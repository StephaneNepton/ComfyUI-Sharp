#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="${1:-.}"
VERSION="2.15.0"
METHOD="${2:-auto}" # auto|npm|cdn|release
CDN_URL="https://cdn.jsdelivr.net/npm/playcanvas@${VERSION}/build/playcanvas.js"
RELEASE_TARBALL_URL="https://github.com/playcanvas/engine/archive/refs/tags/v${VERSION}.tar.gz"

need_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Erreur: commande requise introuvable: $1" >&2
    exit 1
  fi
}

download_to() {
  local url="$1"
  local out="$2"
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$url" -o "$out"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO "$out" "$url"
  else
    echo "Erreur: curl ou wget requis pour télécharger des fichiers." >&2
    return 1
  fi
}

install_via_npm() {
  need_cmd node
  need_cmd npm

  if [ ! -f package.json ]; then
    echo "Aucun package.json détecté -> initialisation npm"
    npm init -y >/dev/null
  fi

  echo "Installation npm de playcanvas@$VERSION dans $(pwd)"
  npm install --save-exact "playcanvas@$VERSION" || return 1

  echo "Vérification npm:"
  npm ls playcanvas || return 1

  local installed
  installed="$(node -p "require('./node_modules/playcanvas/package.json').version" 2>/dev/null || true)"
  [ -n "$installed" ] || return 1

  if [ "$installed" != "$VERSION" ]; then
    echo "Erreur: version npm inattendue: $installed" >&2
    return 1
  fi

  echo "OK npm: PlayCanvas Engine $installed installé."
}

install_via_cdn() {
  mkdir -p vendor
  echo "Téléchargement CDN: $CDN_URL"
  download_to "$CDN_URL" "vendor/playcanvas-${VERSION}.js" || return 1

  if [ ! -s "vendor/playcanvas-${VERSION}.js" ]; then
    echo "Erreur: fichier CDN vide ou absent." >&2
    return 1
  fi

  echo "OK CDN: vendor/playcanvas-${VERSION}.js téléchargé."
}

install_via_release() {
  need_cmd tar
  mkdir -p vendor
  local tarball="vendor/playcanvas-engine-v${VERSION}.tar.gz"

  echo "Téléchargement release GitHub: $RELEASE_TARBALL_URL"
  download_to "$RELEASE_TARBALL_URL" "$tarball" || return 1

  if [ ! -s "$tarball" ]; then
    echo "Erreur: archive release vide ou absente." >&2
    return 1
  fi

  tar -xzf "$tarball" -C vendor
  echo "OK release: source extraite dans vendor/engine-${VERSION} (nom exact selon archive)."
}

mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

case "$METHOD" in
  npm)
    install_via_npm
    ;;
  cdn)
    install_via_cdn
    ;;
  release)
    install_via_release
    ;;
  auto)
    if command -v node >/dev/null 2>&1 && command -v npm >/dev/null 2>&1; then
      install_via_npm && exit 0
      echo "npm a échoué -> tentative CDN"
    fi

    install_via_cdn && exit 0
    echo "CDN a échoué -> tentative release GitHub"

    install_via_release && exit 0

    echo "Erreur: installation impossible via npm, CDN et release GitHub." >&2
    exit 1
    ;;
  *)
    echo "Usage: $0 [target_dir] [auto|npm|cdn|release]" >&2
    exit 1
    ;;
esac

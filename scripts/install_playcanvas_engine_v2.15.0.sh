#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="${1:-.}"
VERSION="2.15.0"

if ! command -v node >/dev/null 2>&1; then
  echo "Erreur: Node.js est requis mais introuvable dans le PATH." >&2
  exit 1
fi

if ! command -v npm >/dev/null 2>&1; then
  echo "Erreur: npm est requis mais introuvable dans le PATH." >&2
  exit 1
fi

mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

if [ ! -f package.json ]; then
  echo "Aucun package.json détecté dans $TARGET_DIR -> initialisation npm"
  npm init -y >/dev/null
fi

echo "Installation de playcanvas@$VERSION dans $(pwd)"
npm install --save-exact "playcanvas@$VERSION"

echo "\nVérification de la version installée:"
npm ls playcanvas

INSTALLED_VERSION="$(node -p "require('./node_modules/playcanvas/package.json').version")"
if [ "$INSTALLED_VERSION" != "$VERSION" ]; then
  echo "Erreur: version installée inattendue ($INSTALLED_VERSION)." >&2
  exit 1
fi

echo "\nOK: PlayCanvas Engine $INSTALLED_VERSION installé avec succès."

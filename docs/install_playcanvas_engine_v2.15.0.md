# Installer PlayCanvas Engine v2.15.0

## Installation directe (recommandée)

Le script supporte 4 modes:

- `auto` (défaut): npm -> CDN -> release GitHub,
- `npm`: package npm,
- `cdn`: téléchargement direct de `playcanvas.js`,
- `release`: téléchargement de l'archive source GitHub.

```bash
bash scripts/install_playcanvas_engine_v2.15.0.sh <chemin-projet> auto
```

Exemples:

```bash
bash scripts/install_playcanvas_engine_v2.15.0.sh /tmp/mon-projet auto
bash scripts/install_playcanvas_engine_v2.15.0.sh /tmp/mon-projet npm
bash scripts/install_playcanvas_engine_v2.15.0.sh /tmp/mon-projet cdn
bash scripts/install_playcanvas_engine_v2.15.0.sh /tmp/mon-projet release
```

## Résultat attendu par mode

- `npm`: dépendance `playcanvas@2.15.0` dans `node_modules`.
- `cdn`: fichier `vendor/playcanvas-2.15.0.js`.
- `release`: archive et sources extraites dans `vendor/`.

## Vérification

- npm: `npm ls playcanvas`
- cdn/release: vérifier les fichiers dans `vendor/`.

## Source officielle

- https://github.com/playcanvas/engine/releases/tag/v2.15.0

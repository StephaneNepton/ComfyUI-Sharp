# Installer PlayCanvas Engine v2.15.0

Si tu veux une installation immédiate, exécute simplement:

```bash
bash scripts/install_playcanvas_engine_v2.15.0.sh <chemin-du-projet-js>
```

Exemple:

```bash
bash scripts/install_playcanvas_engine_v2.15.0.sh /tmp/mon-projet-playcanvas
```

Le script:

- initialise `package.json` si absent,
- installe `playcanvas@2.15.0` avec une version exacte,
- vérifie la version installée.

## Installation manuelle (alternative)

Dans ton projet:

```bash
npm install --save-exact playcanvas@2.15.0
npm ls playcanvas
```

## CDN (sans npm)

```html
<script src="https://cdn.jsdelivr.net/npm/playcanvas@2.15.0/build/playcanvas.js"></script>
```

Source release officielle:

- https://github.com/playcanvas/engine/releases/tag/v2.15.0

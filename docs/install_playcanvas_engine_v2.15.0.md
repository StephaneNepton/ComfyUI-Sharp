# Installation de PlayCanvas Engine v2.15.0

Ce guide explique comment installer la release **v2.15.0** du moteur PlayCanvas depuis:

- https://github.com/playcanvas/engine/releases/tag/v2.15.0

## Prérequis

- **Node.js 18+** recommandé
- **npm** (ou pnpm/yarn)

Vérification rapide:

```bash
node -v
npm -v
```

## Option 1 — Installation via npm (recommandé)

Dans ton projet JavaScript/TypeScript:

```bash
npm install playcanvas@2.15.0
```

Puis dans ton code:

```js
import * as pc from 'playcanvas';
```

## Option 2 — Installation via script CDN

Tu peux aussi utiliser la version buildée depuis un CDN:

```html
<script src="https://cdn.jsdelivr.net/npm/playcanvas@2.15.0/build/playcanvas.js"></script>
```

Puis:

```html
<script>
  const app = new pc.Application(document.getElementById('application-canvas'));
</script>
```

## Option 3 — Téléchargement manuel de la release

1. Ouvre la page de release: https://github.com/playcanvas/engine/releases/tag/v2.15.0
2. Télécharge l'archive adaptée à ton usage (source ou build).
3. Décompresse dans ton projet.
4. Référence le fichier `playcanvas.js` (ou `playcanvas.mjs`) dans ton bundler ou ton HTML.

## Vérification

Après installation npm:

```bash
npm ls playcanvas
```

La sortie doit montrer `playcanvas@2.15.0`.

## Dépannage rapide

- Si la version installée n'est pas la bonne, supprime `node_modules` et `package-lock.json`, puis relance `npm install`.
- Si ton bundler ne résout pas le module, vérifie la configuration ESM/CommonJS.
- Si tu utilises TypeScript, mets à jour la version de TypeScript et les options `moduleResolution` si nécessaire.

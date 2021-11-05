@echo off
npm run build&&cd dist&&git init&&git add -A&&git commit -m 'deploy'&&git push -f https://github.com/IshanPJoshi/command-deck-builder main:gh-pages&&cd ..

@echo off
npm run build&&cd dist&&git init&&git add -A&&git commit -m 'deploy'&&git push -f git@github.com:IshanPJoshi/command-deck-builder.git main:gh-pages&&cd -

---
description: Cria uma nova branch git e troca para ela
---

Crie uma nova branch git com o nome `$ARGUMENTS` e troque para ela.

Passos:
1. Rode `git status` e `git branch --show-current` para ver o estado atual.
2. Se a árvore estiver suja (arquivos modificados não commitados), PARE e informe ao usuário — pergunte se quer `git stash` antes de continuar. Não faça stash sem confirmação.
3. Crie a branch a partir da branch atual com `git checkout -b $ARGUMENTS` (ou `git switch -c $ARGUMENTS`).
4. Confirme com `git branch --show-current`.

Se `$ARGUMENTS` estiver vazio, pergunte o nome da branch. Sugira o padrão conventional: `feat/...`, `fix/...`, `refactor/...`, `test/...`, `docs/...`, tudo em minúsculas.

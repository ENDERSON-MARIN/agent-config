---
description: Cria uma nova branch git e troca para ela
agent: agent
---

Crie uma nova branch git com o nome informado pelo usuário e troque para ela.

Passos:
1. Rode `git status` e `git branch --show-current` para ver o estado atual.
2. Se a árvore estiver suja (arquivos modificados não commitados), PARE e informe ao usuário — pergunte se quer `git stash` antes de continuar. Não faça stash sem confirmação.
3. Crie a branch a partir da branch atual com `git checkout -b <nome>` (ou `git switch -c <nome>`).
4. Confirme com `git branch --show-current`.

Se o nome não foi informado, pergunte. Sugira o padrão conventional: `feat/...`, `fix/...`, `refactor/...`, `test/...`, `docs/...`, tudo em minúsculas.

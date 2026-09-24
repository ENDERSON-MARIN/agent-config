---
description: Atualiza a branch atual com o remoto (git pull)
---

Atualize a branch atual com as mudanças do repositório remoto.

Passos:
1. Rode `git status` e `git branch --show-current` para confirmar a branch.
2. Se a árvore estiver suja (arquivos modificados não commitados), PARE e informe ao usuário — pergunte se quer `git stash` antes de continuar. Não faça stash sem confirmação.
3. Rode `git pull` (ou `git pull origin <branch>` se a branch não tem upstream).
4. Mostre o resultado (`git log --oneline -5` e `git status --short`).

Não use `--force` nem `--rebase` sem pedido explícito do usuário. Se houver conflito de merge, PARE e mostre os arquivos em conflito em vez de resolver sozinho.

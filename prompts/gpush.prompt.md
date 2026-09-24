---
description: Envia a branch atual para o remoto (com upstream se preciso)
agent: agent
---

Envie a branch atual para o repositório remoto.

Passos:
1. Rode `git status` e `git branch --show-current` para confirmar a branch.
2. Verifique se o remoto `origin` existe (`git remote -v`).
3. Se a branch ainda não tem upstream configurado, use `git push -u origin <branch>`. Caso contrário, use `git push`.
4. Mostre o resultado do push.

Não use `--force` nem `--force-with-lease` sem pedido explícito do usuário. Se o push for rejeitado, mostre o erro e sugira os próximos passos em vez de forçar.

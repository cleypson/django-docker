# Django 3.0 + PostgreSQL + Docker.

Objetivo desse projeto é disponibilizar uma estrutura básica(boilerplate) para um novo projeto Django rodando em Docker.

## Debug remoto com VSCode.

Primeiro passo: instalar o ptvsd:

```
pip install ptvsd
```

ou podemos adicionar:

```
...
ptvsd==4.3.2
...
```
no requirements.txt e executar o rebuild no container para instalar automaticamente o ptvsd.

Segundo passo: alterar o manage.py para excutar o ptvsd ao executar o runserver:

```
...
    # Configuração para debugar remotamente o código atráves de VSCode
    from django.conf import settings

    if settings.DEBUG:
        if os.environ.get('RUN_MAIN') or os.environ.get('WERKZEUG_RUN_MAIN'):
            import ptvsd

            ptvsd.enable_attach(address=('0.0.0.0', 3000))
            print('Attached!')  # Vai aparecer Attached! no console do docker.
    # end
...
```
Cole esse trecho de código logo após 'DJANGO_SETTINGS_MODULE' antes do 'try'.

Terceiro passo: expor a porta 3000 aberta pelo ptvsd na sua máquina local, basta adicionar ao ports do serviço web no docker-compose.yml a porta 3000 junto com a porta do runserver:

```
...
    ports:
      - '3000:3000' # expõe no localhost a porta 3000 aberta pelo ptvsd.
      - '8100:8100'
...
```

Quarto passo (e último uffa): Adicionar no launch.json a configuração para executar o debug, basta clicar na engranagem na aba Run do VSCode e colar esse trecho de código dentro do "configurations":

```
...        
    {
        "name": "Python: Django | Docker", // pode ser qualquer nome
        "type": "python",
        "request": "attach",
        "pathMappings": [
            {
            "localRoot": "${workspaceFolder}/src", //caminho do projeto na máquina local
            "remoteRoot": "/app" //caminho de projeto dentro do container
            }
        ],
        "port": 3000, // porta do ptvsd
        "host": "127.0.0.1", // localhost
    }
...
```

Agora vai aparecer "Python: Django | Docker" na lista para ser executado, basta clicar no run e marcar os breakpoints e seja feliz com seu bug.

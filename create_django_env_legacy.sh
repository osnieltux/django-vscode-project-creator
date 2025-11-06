#!/bin/bash

# Initialize new Project
uv init
uv add Django

# prod dependencies
uv add --group prod gunicorn

# dev dependencies
uv add --group dev djlint pylint-django pylint-plugin-utils django-stubs django-stubs-ext

mkdir -p .vscode/

# VS Code extensions
echo '{
  "recommendations": [
    "ms-python.python",
    "ms-python.pylint",
    "ms-python.flake8",
    "ms-python.mypy-type-checker",
    "njpwerner.autodocstring",
    "batisteo.vscode-django",
    "ms-python.black-formatter",
    "mrorz.language-gettext",
    "qwtel.sqlite-viewer",
    "ms-python.isort",
    "monosans.djlint",
    "esbenp.prettier-vscode",
    "gruntfuggly.todo-tree"
  ],
  "unwantedRecommendations": [
    "ms-python.vscode-pylance"
  ]
}' > .vscode/extensions.json

# VS Code config
echo '{
  "python.defaultInterpreterPath": ".venv/bin/python",
  "editor.formatOnSave": true,
  "files.autoSave": "afterDelay",
  "[python]": {
    "editor.defaultFormatter": "ms-python.black-formatter",
    "editor.codeActionsOnSave": {
      "source.organizeImports": "explicit"
    }
  },
  "pylint.args": [
    "--load-plugins=pylint_django",
    "--django-settings-module=django_project.settings", // change this to your project name
    "--disable=C0116", // docstring
    "--disable=C0115", // docstring
    "--disable=C0114", // docstring
  ],
  "flake8.args": [
    "--ignore=E501"   // line too long (+79)
  ],
  "[html][django-html][handlebars][hbs][mustache][jinja][jinja-html][nj][njk][nunjucks][twig]": {
    "editor.defaultFormatter": "monosans.djlint",
    "editor.detectIndentation": true,
    "editor.formatOnSave": true,
    "editor.tabSize": 4
  },
  "terminal.integrated.environmentChangesRelaunch": false,
  "[typescript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "isort.args": [
    "--profile", "black"
  ]
}' > .vscode/settings.json

echo 'Done

To dev, run:
uv run django-admin startproject django_project .
uv run manage.py startapp books
# add your app to django_project/settings.py
uv run manage.py makemigrations
uv run manage.py migrate

uv run manage.py runserver

To prod, run:
uv run gunicorn django_project.wsgi:application

-------------------------------------------------
Visual Studio Code keep disabled ms-python.vscode-pylance, Otherwise, you will not receive import recommendations.
Remeber to change your project name in settings:
    (.vscode/settings.json) "--django-settings-module=django_project.settings",
-------------------------------------------------
'

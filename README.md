# django-vscode-project-creator
Create a Django project with UV and recommendations for VS Code

### 📦 Dependencies
- [uv](https://docs.astral.sh/uv/#installation)
- code
  - [visualstudio](https://code.visualstudio.com/Download)
  - [vscodium](https://vscodium.com/#install)

```bash
create_django_env_legacy.sh
```

It will create the dependencies to start your project using uv and based on pylint. It will also create the basic recommendations. You are free to review the code before running it, as it has some customizations you may not need.

### 🤖 create_django_env_legacy.sh Warning
- Remeber to change your project name in settings (.vscode/settings.json -> "--django-settings-module=django_project.settings",)
- keep disabled ms-python.vscode-pylance. Otherwise, you will not receive import recommendations.

#### To dev, run:
```bash
uv run django-admin startproject django_project .
uv run manage.py startapp books

# add your app to django_project/settings.py

uv run manage.py makemigrations
uv run manage.py migrate

uv run manage.py runserver
```

#### To prod, run:
```bash
uv run gunicorn django_project.wsgi:application
```

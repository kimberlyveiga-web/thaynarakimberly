from flask import Blueprint, render_template

# Cria as rotas do sistema
main_bp = Blueprint('main', __name__)

@main_bp.route('/')
def home():
    # Ele vai procurar o arquivo index.html dentro da pasta templates
    return render_template('index.html')
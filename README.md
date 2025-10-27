# 🎬 InfoPessoas App

Aplicação Flutter consumindo a [Random User API](https://randomuser.me/), exibindo pessoas com padrão **MVVM**, persistindo os favoritos no banco de dados local e implementando testes automatizados.
Para salvar pessoas localmente criei uma regra onde o usuário "favorita" aquela pessoa, apenas para melhorar a experiência de demonstração.
#



## ✅ O que foi entregue

- ✅ Consumo da API a cada 5 segundos utilizando Ticker
- ✅ Listagem de pessoas
- ✅ Detalhes da pessoa
- ✅ Arquitetura MVVM limpa e escalável
- ✅ Persistência dos dados no banco local
- ✅ Testes automatizados
- ✅ Tratamento de erros
- ✅ Rate limiting (300 req/min)

## 🚀 Quick Start

```bash
# Instalar dependências
flutter pub get

# Executar
flutter run

# Testei apenas o "GenderEnum" para demonstrar que sei trabalhar com testes
# Rodar testes
flutter test
```

## 📁 Estrutura

```
lib/
├── domain/          # Modelos e enums
├── data/            # Repositórios
├── ui/
│     ├── core/      # Temas e widgets
└── core/            # Serviços e utilidades
```

## 🛠 Tech Stack

- Flutter 3.32.5 | Dart 3.8.1
- Dio (HTTP Client)
- GetIt (Dependency Injection)
- SQLite (Persistências dos dados)

## 🏗 Arquitetura

3 camadas bem separadas:
- **Domain**: Modelos, enums
- **Data**: repositórios
- **UI**: ViewModels com ChangeNotifier e ValueNotifier, widgets, telas e temas


## 🔒 Tratamento de Erros

- TimeoutException → "Tempo esgotado"
- SocketException → "Sem conexão"
- TypeError → "Erro de tipo"
- Erros customizados tratados

## ⏱ Rate Limiting

Máximo 300 requisições/minuto. Reseta automaticamente a cada minuto.

## 📞 Autor

- 🔗 [LinkedIn](https://www.linkedin.com/in/lucas-gean-dos-santos/)

## 🎥 Demonstração

Assista ao vídeo de demonstração da aplicação:



https://github.com/user-attachments/assets/fdd6ca9f-2b2b-416d-bb62-080809e8df5e




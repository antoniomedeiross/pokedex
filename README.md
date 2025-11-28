# Aplicativo Pokedex

Um aplicativo móvel desenvolvido como projeto preparatório para o minicurso de desenvolvimento mobile da UEFS. Esta Pokedex permite aos usuários navegar por uma lista de Pokémon e visualizar seus detalhes.

## Funcionalidades

*   Exibição de uma lista de Pokémon.
*   Visualização de informações detalhadas para cada Pokémon, incluindo tipos, habilidades e estatísticas.
*   (Adicione mais funcionalidades específicas aqui, se houver, ex: busca, filtro, favoritos)

## Tecnologias Utilizadas

*   **Flutter:** Kit de ferramentas de UI para construir aplicativos compilados nativamente para mobile, web e desktop a partir de uma única base de código.
*   **Dart:** Linguagem de programação utilizada pelo Flutter.
*   **Pacote HTTP:** Para fazer requisições de rede e buscar os dados dos Pokémon de uma API (provavelmente a PokeAPI).

## Como Começar

Estas instruções permitirão que você obtenha uma cópia do projeto e a execute em sua máquina local para fins de desenvolvimento e teste.

### Pré-requisitos

*   [SDK do Flutter](https://flutter.dev/docs/get-started/install) instalado e configurado.
*   [SDK do Dart](https://dart.dev/get-dart) (incluído no SDK do Flutter).
*   Um IDE como o [VS Code](https://code.visualstudio.com/) com a extensão do Flutter ou [Android Studio](https://developer.android.com/studio).

### Instalação

1.  **Clone o repositório:**
    ```bash
    git clone https://github.com/seu-usuario/pokedex.git # Substitua pela URL real do repositório
    cd pokedex
    ```
2.  **Obtenha as dependências:**
    ```bash
    flutter pub get
    ```

### Executando o Aplicativo

Para executar o aplicativo em um dispositivo conectado ou emulador:

```bash
flutter run
```

## Estrutura do Projeto

O projeto segue a estrutura padrão de um projeto Flutter:

*   `lib/main.dart`: Ponto de entrada da aplicação.
*   `lib/models/`: Contém os modelos de dados (ex: `pokemon.dart`).
*   `lib/pages/`: Contém as principais telas da aplicação (ex: `home_page.dart`, `details_page.dart`).
*   `lib/services/`: Contém os serviços para busca de dados e lógica de negócio (ex: `poke_api_service.dart`).
*   `lib/utils/`: Funções utilitárias ou extensões (ex: `color_ext.dart`, `color_type.dart`).
*   `lib/widgets/`: Componentes de UI reutilizáveis (ex: `pokemon_card.dart`).


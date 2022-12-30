Um widget focado no visual para escolha entre diversas opções, através das dicas flutuantes é possível saber o que cada opção faz sem precisar preencher a tela com textos indicativos.

<img src="https://user-images.githubusercontent.com/31104317/186810400-a7ad8927-3e5b-4024-902b-cae7b95ffe53.gif" alt="DotsPicker" height="600"/>

## Usage

Crie uma lista de Dots, insira ao DotsPicker e pronto!

```dart
  DotsPicker(
    dots: [
      Dot('Option 1', Colors.blue), 
      Dot('Option 2', Colors.red), 
      Dot('Option 3', Colors.green)
    ],
    onSelected: (index) {},
    exposureTime: 1000 // Tempo de exposição do PopUp em milissegundos.
  )
```

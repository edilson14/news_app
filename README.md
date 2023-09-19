# news_app

Repositorio para estudo de testes no flutter

[Tutorial](https://www.youtube.com/watch?v=hUAUAkIZmX0&list=PLB6lc7nQ1n4jN2u4rMmb-3tdJ_cQBs-YS)

- Gerenciamento de estado usando [provider](https://pub.dev/packages/provider)

Antes de realizar os testes é importante 'configurar' todas as configurações necessarias, toda a configuração é feita dentro do setUp

```dart
  setUp(
    (){

    }
  );

```

## Testes Unitarios

- Evitar chamadas de API porque podem existir problemas de conexão e falhar nao por causa do código
- Criar Mocks com o [mocktail](https://pub.dev/packages/mocktail) para evitar criar cada detalhes das classes e adicionar complexidades

  - Através do mocktail podemos ter uma implementação para cada caso de teste espcifico

- Para metodos Future , não adicionar o await caso queira verificar alguma condição antes da finalização
  ```dart
   test(
        'indicar o loading dos dados e que eles chegaram e logo depois garantir que nao estao sendo carregados',
        () async {
          arrangeNewsServices();

          final futureMethod = stu.getArticles(); /// se colocar o await aqui, a função já vai ter sido executado e o [isLoading] deixado de ser verdadeiro
          expect(stu.isLoading, true);
          await futureMethod;
          expect(stu.articles, returnedArticles);
        },
      );
  ```

## Testes de Widgets

- Atuam sobre a árvore de widgtes , então precisamos executar algumas ações sobre eles.
- Não são feitos rebuilds de forma automatica , então é preciso fazer de forma manual
- necessario criar o widget a ser testado

  ```dart
    testWidget('test description',
      (WidgetTester tester) async{
        await tester.pumpWidget(widgetToBeTested);
        // escrever testes aqui em baixo
      },
    )

  ```

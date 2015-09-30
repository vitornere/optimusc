# OptimusC
Otimizador / Indentificador de más práticas de códigos C

### 1-Introdução:

O OptimusC se trata de um compilador que abstrai os conceitos de boas técnicas de programação e as aplica na linguagem C, ou seja, um compilador de linguagem C para uma linguagem C com estes conceitos. Basicamente temos a linguagem de entrada sendo a linguagem C e a linguagem de saída, sendo esta a linguagem C com algumas boas práticas comentadas no trecho do código que as mesmas se referem.


### 2-Padrões do Flex:

| Padrão | Descrição|
| ----| ----------- |
|x |O carácter “x”|
|. |Qualquer carácter excepto mudança de linha|
|\n |Mudança de linha|
|[xyz] |Um dos caracteres “x”, “y” ou “z”|
|xyz| A cadeia de caracteres “xyz”|
|[a-zA-Z] |Um dos caracteres no intervalo de “a” a “z” ou de “A” a “Z”|
|[-+*/]| Qualquer um dos operadores “-”, “+”, “*” ou “/”, send que o símbolo “-” tem de aparecer em primeiro lugar dada a possibilidade de ambiguidade com a definição de intervalo
|[abj-oZ]| Um dos caracteres “a”, “b” ou de “j” a “o” ou “Z”
|[ˆA-Z\n] |Qualquer carácter excepto no intervalo de “A” a “Z” ou mudança de linha|
|r* |O carácter “r” zero ou mais vezes|
|r+ |O carácter “r” uma ou mais vezes |
|r? |O carácter “r” zero ou uma vez|
|r{2,5}| O carácter “r” repetido de duas a cinco vezes|
|r{2,} |O carácter “r” repetido pelo menos duas vezes|
|r{4}| O carácter “r” repetido exactamente quatro vezes|
|{macro}| Substituição/Expansão da macro definida anteriormente|
|(r) |O carácter “r”, sendo que os parêntesis permitem estipular precedências|
|xyz* |A sequência “xy” seguida de zero ou mais “z”s|
|(xyz)* |A sequência “xyz” repetida zero ou mais vezes|
|(x\|y)*xyz |Todos caracteres x ou y termidados em xyz|
|r\|s |O carácter “r” ou “s” (alternativa)|
|ˆr |O carácter “r” apenas se no início da linha|
|r$ |O carácter “r” apenas se no final da linha (não consome o \n)|
|ˆxyz$| Uma linha que contém apenas a cadeia de caracteres “xyz”|
|<\<EOF>\>| Fim de ficheiro|

### 3-Declarações do BISON:

Sumário das declarações usadas para definir a gramática no bison:

| Declaração | Descrição|
| ----| ----------- |
|%union|Declara a coleção de tipos de dados que podem ter valores semânticos|
|%token|Declara um símbolo terminal (nome do tipo token) sem precedência ou associatividade especificado|
|%right|Declara um símbolo terminal (nome do tipo token) que é associativa à direita|
|%left|Declara um símbolo terminal (nome do tipo token) que é associativa à esquerda|
|%type|Declara o tipo de valores semânticos para um símbolo não-terminal|
|%start|Especifique símbolo de começo do gramática|
|%define variable \| %define variable value \| %define variable {value} \| %define variable "value"|Definie uma variável para ajustar o comportamento do Bison|
|%defines|Faz um arquivo de cabeçalho parser contendo definições macro para os nomes de tipo de token definidas na gramática, bem como algumas outras declarações. Se o arquivo de implementação analisador é nomeado nome.c o arquivo gerado de cabeçalho é nomeado name.h.|
|%destructor|Especifica como o analisador deve recuperar a memória associada a símbolos descartados|
|%file-prefix "prefix"|Especifica um prefixo para todos os nomes de arquivo de saída Bison. Os nomes são escolhidos são os arquivo de gramática nomeados prefix.y|
|%language "language"|Especifica a linguagem de programação para o analisador gerado. Línguas atualmente suportadas incluem C, C ++ e Java|
|%locations|Gera o código de processamento dos locais. Este modo é ativado assim que a gramática usa o token especial '@n', mas se sua gramática não usá-lo, usando '% localizações' permite mensagens de erro de sintaxe mais precisos.|
|%output "file"|Gera a implementação analisador no arquivo|
|%verbose|Faz um arquivo de saída adicional contendo descrições detalhadas dos estados do analisador e o que é feito para cada tipo de token de verificação à frente nesse estado|
|%yacc|Trabalho como se a opção --yacc tivesse sido dada, ou seja, imitar Yacc, incluindo as suas convenções de nomenclatura|

Para mais informações  a cerca das declarações visite o site do manual do [BISON](http://www.gnu.org/software/bison/manual/html_node/Decl-Summary.html).
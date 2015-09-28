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
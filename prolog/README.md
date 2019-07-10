## Description

Simulation of faculty management using Prolog.

## Run

* Install a Prolog interpreter. [SWI-Prolog](https://www.swi-prolog.org/) is recommended.
* Run the interpreter and load the file:
    ```
    swipl
    consult('faculty').
    ```
* Run a query to confirm that the file was successfully loaded:
    ```
    aposentado(N).
    ```
    The result should be:
    ```
    N = julio ;
    N = viviane
    ```

## Rules (in Portugues)

    Simpósios são organizados anualmente para cada área.
    O simpósio de direito ocorre em março, o de economia em setembro e o de 
    administração em novembro.
    Todos os professores de uma área devem estar envolvidos na organização do
    simpósio de sua área.

    O salário para técnicos é igual, no valor de 2300 reais.
    O coordenador dos técnicos recebe um adicional de 700 reais.

    O salário de professores doutores é de 8000 reais, o de mestres é de 6000 e
    o de graduados é de 3000. O coordenador dos professores recebe um adicional de 
    1000 reais.

    O diretor da faculdade recebe um bônus de 3000 reais. Diretores não podem
    ser coordenadores simultaneamente.

    Professores tiram férias em janeiro, fevereiro e junho. Coordenadores tiram
    férias em janeiro e fevereiro. Diretores tiram férias em janeiro.
    Técnicos administrativos tiram férias em janeiro e junho.

    Homens se aposentam a partir dos 65 anos e mulheres a partir dos 60 anos de
    idade.

## Facts (in Portuguese)

    Jorge é professor de direito e diretor da faculdade. Possui doutorado e tem 60
    anos de idade. Ana é professora de direito, possui mestrado e tem 45 anos.
    Cláudio é professor de administração, possui 23 anos e cursou a graduação.
    Regina é coordenadora e professora de administração, tem 37 anos e também
    possui a graduação. Júlio era professor de economia e possui mestrado, mas se
    aposentou e possui 80 anos. Joana é professora de economia, tem mestrado e 53
    anos. Viviane era professora de economia, possui mestrado e tem 61 anos.

    Geraldo, Vinicius e Maria são funcionários técnicos administrativos. Geraldo
    possui 19 anos, Vinicius possui 41 e Maria possui 32. Maria é a
    coordenadora dos técnicos administrativos.
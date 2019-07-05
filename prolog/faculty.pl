% Jorge é professor e diretor da faculdade. Possui doutorado e tem 60 anos de
% idade. Ana é professora, possui mestrado e tem 45 anos. Cláudio é
% professor, possui 23 anos e cursou a graduação. Regina é coordenadora e
% professora, tem 37 anos e também possui a graduação. Júlio era professor
% e possui mestrado, mas se aposentou e possui 80 anos. Joana é professora,
% tem mestrado e 53 anos.

% O salário de professores doutores é de 8000 reais, o de mestres é de 6000 e
% o de graduados é de 3000. O coordenador dos professores recebe um adicional de 
% 1000 reais.

% Geraldo, Vinicius e Maria são funcioáarios técnico-administrativos. Geraldo
% possui 19 anos, Vinicius possui 41 e Maria possui 32. Maria é a
% coordenadora dos técnicos administrativos. O salário para técnicos é igual,
% no valor de 2300 reais. O coordenador dos técnicos recebe um adicional
% de 700 reais.

% O diretor da faculdade recebe um bônus de 3000 reais. Diretores não podem
% ser coordenadores simultaneamente.

% Professores tiram férias em janeiro, fevereiro e junho. Coordenadores tiram
% férias em janeiro e fevereiro. Diretores tiram férias em janeiro.
% Técnicos administrativos tiram férias em janeiro e junho.

% Homens se aposentam a partir dos 65 anos e mulheres a partir dos 60 anos de
% idade.

%% Funcoes
% Professores
funcao(professor, homem, jorge, 60, doutorado).
funcao(professor, mulher, ana, 45, mestrado).
funcao(professor, homem, claudio, 23, mestrado).
funcao(professor, mulher, regina, 37, graduacao).
funcao(professor, homem, julio, 80, graduacao).
funcao(professor, mulher, joana, 53, mestrado).

% TAs
funcao(tecnico_administrativo, homem, geraldo, 19, _).
funcao(tecnico_administrativo, homem, vinicius, 41, _).
funcao(tecnico_administrativo, mulher, maria, 32, _).

% Diretor e Coordenadores
diretor(N, F) :- funcao(F, _, N, _, _), N = jorge.
coordenador(N, F) :- funcao(F, _, N, _, _), N = regina.
coordenador(N, F) :- funcao(F, _, N, _, _), N = maria.

%% Salarios
% Professor com doutorado
salario(N, 8000) :- funcao(professor, _, N, _, doutorado), coordenador(C, professor), diretor(D, _), C \= N, D \= N.
salario(N, 9000) :- funcao(professor, _, N, _, doutorado), coordenador(N, professor).
salario(N, 11000) :- funcao(professor, _, N, _, doutorado), diretor(N, _).

% Professor com mestrado
salario(N, 6000) :- funcao(professor, _, N, _, mestrado), coordenador(C, professor), diretor(D, _), C \= N, D \= N.
salario(N, 7000) :- funcao(professor, _, N, _, mestrado), coordenador(N, professor).
salario(N, 9000) :- funcao(professor, _, N, _, mestrado), diretor(N, _).

% Professor com graduacao
salario(N, 3000) :- funcao(professor, _, N, _, graduacao), coordenador(C, professor), diretor(D, _), C \= N, D \= N.
salario(N, 4000) :- funcao(professor, _, N, _, graduacao), coordenador(N, professor).
salario(N, 6000) :- funcao(professor, _, N, _, graduacao), diretor(N, _).

% Tecnicos Administrativos
salario(N, 2300) :- funcao(tecnico_administrativo, _, N, _, _), coordenador(C, tecnico_administrativo), diretor(D, _), C \= N, D \= N.
salario(N, 3000) :- funcao(tecnico_administrativo, _, N, _, _), coordenador(N, tecnico_administrativo).
salario(N, 5300) :- funcao(tecnico_administrativo, _, N, _, _), diretor(N, _).

% Condicoes de aposentadoria
aposentado(N) :- funcao(_, homem, N, I, _), I > 65.
aposentado(N) :- funcao(_, mulher, N, I, _), I > 60.

% Ferias
ferias(N, [janeiro]) :- diretor(N, _).
ferias(N, [janeiro, fevereiro]) :- coordenador(N, _).
ferias(N, [janeiro, fevereiro, junho]) :- funcao(professor, _, N, _, _), diretor(D, _), coordenador(C, professor), D \= N, C \= N.
ferias(N, [janeiro, junho]) :- funcao(tecnico_administrativo, _, N, _, _), diretor(D, _), coordenador(C, tecnico_administrativo), D \= N, C \= N.
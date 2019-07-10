%%% Regras
% Há dois tipos de funcionários na instituição: técnicos administrativos e
% professores.
% Há um cargo de direção geral da faculdade e outros dois de coordenadoria: um
% para coordenação dos professores, e outro para coordenação dos técnicos
% administrativos. O cargo de coordenação de professores deve ser ocupado por
% um professor, assim como o de coordenação de técnicos administrativos deve ser
% ocupado por um técnico. O diretor não pode ser coordenador enquanto na direção.
% Professores tiram férias em janeiro, fevereiro e junho. Técnicos
% administrativos tiram férias em janeiro e junho. Coordenadores tiram férias em
% janeiro e fevereiro. O diretor tira férias em janeiro. 
% Simpósios são organizados anualmente para cada área. O simpósio de direito
% ocorre em março, o de economia em setembro e o de administração em novembro.
% Todos os professores de uma área devem estar envolvidos na organização do
% simpósio de sua área.
% O salário de professores doutores é de 8000 reais, o de mestres é de 6000 e os
% professores que possuem apenas ensino superior recebem 3000 reais. O 
% coordenador dos professores recebe um adicional de 1000 reais.
% O salário para técnicos administrativos é igual, no valor de 2300 reais,
% independente do nível de escolaridade. O coordenador dos técnicos recebe um
% adicional de 700 reais.
% O diretor da faculdade recebe um bônus de 3000 reais. 
% Homens se aposentam a partir dos 65 anos e mulheres a partir dos 60 anos de
% idade.

%%%% Fatos
% Jorge é professor de direito e diretor da faculdade. Possui doutorado e tem
% 60 anos de idade.
% Ana é professora de direito, possui mestrado e tem 45 anos.
% Cláudio é professor de administração, possui 23 anos e cursou a graduação.
% Regina é coordenadora e professora de administração, tem 37 anos e também
% possui a graduação.
% Júlio era professor de economia e possui mestrado, mas se aposentou e possui
% 80 anos.
% Joana é professora de economia, tem mestrado e 53 anos.
% Viviane era professora de economia, possui mestrado e tem 61 anos.
% Geraldo, Vinícius e Maria são funcionários técnicos administrativos. Geraldo
% possui 19 anos, Vinícius possui 41 e Maria possui 32.
% Maria é a coordenadora dos técnicos administrativos. 

%% Funcoes
% Professores
profissao(professor, direito, homem, jorge, 60, doutorado).
profissao(professor, direito, mulher, ana, 45, mestrado).
profissao(professor, administracao, homem, claudio, 23, mestrado).
profissao(professor, administracao, mulher, regina, 37, graduacao).
profissao(professor, economia, homem, julio, 80, graduacao).
profissao(professor, economia, mulher, joana, 53, mestrado).
profissao(professor, economia, mulher, viviane, 61, mestrado).

% TAs
profissao(tecnico_administrativo, _, homem, geraldo, 19, _).
profissao(tecnico_administrativo, _, homem, vinicius, 41, _).
profissao(tecnico_administrativo, _, mulher, maria, 32, _).

% Diretor e Coordenadores
diretor(N, F) :- profissao(F, _, _, N, _, _), N = jorge.
coordenador(N, F) :- profissao(F, _, _, N, _, _), N = regina.
coordenador(N, F) :- profissao(F, _, _, N, _, _), N = maria.

%% Salarios
% Professor com doutorado
salario(N, 8000) :- profissao(professor, _, _, N, _, doutorado),
    coordenador(C, professor), diretor(D, _), C \= N, D \= N.
salario(N, 9000) :- profissao(professor, _, _, N, _, doutorado),
    coordenador(N, professor).
salario(N, 11000) :- profissao(professor, _, _, N, _, doutorado),
    diretor(N, _).

% Professor com mestrado
salario(N, 6000) :- profissao(professor, _, _, N, _, mestrado),
    coordenador(C, professor), diretor(D, _), C \= N, D \= N.
salario(N, 7000) :- profissao(professor, _, _, N, _, mestrado),
    coordenador(N, professor).
salario(N, 9000) :- profissao(professor, _, _, N, _, mestrado), diretor(N, _).

% Professor com graduacao
salario(N, 3000) :- profissao(professor, _, _, N, _, graduacao),
    coordenador(C, professor), diretor(D, _), C \= N, D \= N.
salario(N, 4000) :- profissao(professor, _, _, N, _, graduacao),
    coordenador(N, professor).
salario(N, 6000) :- profissao(professor, _, _, N, _, graduacao), diretor(N, _).

% Tecnicos Administrativos
salario(N, 2300) :- profissao(tecnico_administrativo, _, _, N, _, _),
    coordenador(C, tecnico_administrativo), diretor(D, _), C \= N, D \= N.
salario(N, 3000) :- profissao(tecnico_administrativo, _, _, N, _, _),
    coordenador(N, tecnico_administrativo).
salario(N, 5300) :- profissao(tecnico_administrativo, _, _, N, _, _),
    diretor(N, _).

%% Condicoes de aposentadoria
aposentado(N) :- profissao(_, _, G, N, I, _), G = homem, I >= 65.
aposentado(N) :- profissao(_, _, G, N, I, _), G = mulher, I >= 60.

ativo(N) :- profissao(_, _, G, N, I, _), G = homem, I < 65.
ativo(N) :- profissao(_, _, G, N, I, _), G = mulher, I < 60.

%% Ferias
ferias(N, [janeiro]) :- diretor(N, _), ativo(N).
ferias(N, [janeiro, fevereiro]) :- coordenador(N, _), ativo(N).
ferias(N, [janeiro, fevereiro, junho]) :- profissao(professor, _, _, N, _, _),
    diretor(D, _), coordenador(C, professor), ativo(N), D \= N, C \= N.
ferias(N, [janeiro, junho]) :- profissao(tecnico_administrativo, _, _, N, _, _),
    diretor(D, _), coordenador(C, tecnico_administrativo),
    ativo(N), D \= N, C \= N.

%% Todos
todos_professores(P) :- findall(N, profissao(professor, _, _, N, _, _), P).
todos_tecnicos_administrativos(T) :-
    findall(N, profissao(tecnico_administrativo, _, _, N, _, _), T).

%% Simposio
simposio(direito, M, P) :-
    findall(N, (profissao(professor, direito, _, N, _, _), ativo(N)), P),
    M = marco.
simposio(economia, M, P) :-
    findall(N, (profissao(professor, economia, _, N, _, _), ativo(N)), P),
    M = setembro.
simposio(administracao, M, P) :-
    findall(N, (profissao(professor, administracao, _, N, _, _), ativo(N)), P),
    M = novembro.
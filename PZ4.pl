%Произвденеие элементов списка;
pr_list(A,Pr):-pr_list(A,Pr,1).
pr_list([],Pr,Pr):-!.
pr_list([H|T],Pr,P):-P1 is P*H,pr_list(T,Pr,P1).

% NO(отрицание(проверка на лекции),not - более хороший код,
% а ! - быстродействие);
no(P):-P,!,fail.
no(_).

%Append(Лекция);
append1([],X,X).
append1([H|T],X,[H|Z]):-append1(T,X,Z).

%write (Список без квадратных скобок);
write1([H]):-write(H),!.
write1([H|T]):-write(H),write(", "),write1(T).

% nl (Переход на следующую строку).
% tab (Табуляция).
% display (Выдает информацию в постфикнсой записи).

% Строки;
% put(Выдает символ по кодировке).
% read(Работает не всегда).
% get(Даёт номер, работает с буквами, но криво обрабатывает символами).
% get0(Нормальная работа с буквами).

read_word(A):-get0(X),r_w(X,A,[]).
r_w(32,A,A):-!.
r_w(X,A,B):-append(B,[X],B1),get0(X1),r_w(X1,A,B1).

read_str(A,N):-get0(X),r_str(X,A,[],N,0).
r_str(10,A,A,N,N):-!.
r_str(X,A,B,N,K):-K1 is K+1,append(B,[X],B1),get0(X1),r_str(X1,A,B1,N,K1).

pr_lec3_1:-read_str(A,N),write("vsego "),write(N),write1(A).

% Предикат see(""), добирается до файла, который нужно открыть. И после
% работает с ним. seen. - закрывает файл.
% tell("Путь.расширение") открывает что-то для записи. told. - закрывает

write_str([]):-!.
write_str([H|T]):-put(H),write_str(T).

%Практика.
%Вывод строки 3 раза
pr1:-read_str(A,N),write_str(A),write(", "),write_str(A),write(", "),write_str(A),nl,write(N).

%Найти кол-во слов;
pr2:-read_str(A,_),count_word(A,0,K,0),write(K).
count_word([],K1,K,1):-K is K1+1,!.
count_word([],K1,K,0):-K is K1,!.
count_word([32|T],K1,K,0):-count_word(T,K1,K,0),!.
count_word([32|T],K1,K,1):-K2 is K1+1,count_word(T,K2,K,0),!.
count_word([_|T],K1,K,_):-count_word(T,K1,K,1).

%Самое частое слово
pr3:-read_str(A,_),common_word(A,B,[],[],0,Max,A),write_str(B),write(Max).
repeat_word([],[],_,K1,K,1):-K is K1+1,!.
repeat_word([],_,_,K,K,_):-!.
repeat_word([H|T],[],Sub,I,K,1):-H>=32,H=<64,I1 is I+1,repeat_word(T,Sub,Sub,I1,K,1),!.
repeat_word([H|T],_,Sub,I,K,_):-H>=32,H=<64,repeat_word(T,Sub,Sub,I,K,1),!.
repeat_word([H|T],[H1|T1],Sub,I,K,_):-H\=H1,repeat_word(T,[H1|T1],Sub,I,K,0),!.
repeat_word([H|T],[H1|T1],Sub,I,K,1):-H=H1,repeat_word(T,T1,Sub,I,K,1),!.
repeat_word([_|T],B,Sub,I,K,_):-repeat_word(T,B,Sub,I,K,0).

common_word([],B,B,_,Max,Max,_):-!.
common_word([H|T],B,ML,[],Max,LM,A):-H>=32,H=<64,common_word(T,B,ML,[],Max,LM,A),!.
common_word([H|T],B,ML,C,Max,LM,A):-H>=32,H=<64,repeat_word(A,C,C,0,K,1),(K>Max->common_word(T,B,C,[],K,LM,[H|T]);common_word(T,B,ML,[],Max,LM,[H|T])),!.
common_word([H|T],B,ML,C,Max,LM,A):-append(C,[H],C1),common_word(T,B,ML,C1,Max,LM,A).

%Первые три символа и последние три символа, если длина больше 5
%иначе первый символ столько раз, какова длина строк;
pr4:-read_str(A,N),(N>5->N1 is N-3,write_first(A,C,[],0,N1),write_str(C);write_length(A,[],B,0,N),write_str(B)).
write_first([],B,B,_,_):-!.
write_first([H|T],C,B,K,N1):-K<3,K1 is K+1,append(B,[H],B1),write_first(T,C,B1,K1,N1),!.
write_first([H|T],C,B,K,N1):-K>=N1,K1 is K+1,append(B,[H],B1),write_first(T,C,B1,K1,N1),!.
write_first([_|T],C,B,K,N1):-K1 is K+1,write_first(T,C,B,K1,N1).
write_length([_],B,B,N,N):-!.
write_length([H|_],C,B,K,N):-K<N,K1 is K+1,append(C,[H],C1),write_length([H],C1,B,K1,N).

%Показать номера символов, совпадающих с последним номером строки;
pr5:-read_str(A,_),find_last(A,El),numbers(A,[],B,0,El),write(B).
find_last([H],H):-!.
find_last([_|T],El):-find_last(T,El).
numbers([_],B,B,_,_):-!.
numbers([H|T],C,B,K,El):-K1 is K+1,H=El,append(C,[K1],C1),numbers(T,C1,B,K1,El),!.
numbers([_|T],C,B,K,El):-K1 is K+1,numbers(T,C,B,K1,El).

% Пример чтения из файла (Одна строка);
example1:-see('C.txt'),read_str(A,_),write_str(A),seen,see('C.txt'),read_str(A,_),write_str(A),seen.

%Чтение строк из файла;
read_str_file(A,Flag):-get0(X),r_str(X,A,[],Flag).
r_str(10,A,A,10):-!.
r_str(-1,A,A,-1):-!.
r_str(X,A,B,Flag):-append(B,[X],B1),get0(X1),r_str(X1,A,B1,Flag).

% Все строки;
example2:-see('C.txt'),read_str_str(A),write(A),see('C.txt'),read_str_str(A),write(A).
read_str_str(A):-read_str_file(B,Flag),read_str_str(A,[B],Flag).
read_str_str(A,A,-1):-!.
read_str_str(A,Temp_list,10):-read_str_file(B,Flag),append(Temp_list,[B],T_L),read_str_str(A,T_L,Flag).

write_list_str([]):-!.
write_list_str([H|T]):-write_str(H),nl,write_list_str(T).

% Вывести длину наибольшей строки;
pr6:-see('C.txt'),read_str_str_max(A,Max),write_list_str(A),write(Max),seen.
read_str_str_max(A,Max):-read_str_file(B,Flag),length_str(B,0,Current_max),read_str_str_max(A,[B],Flag,Current_max,Max).
read_str_str_max(A,A,-1,Max,Max):-!.
read_str_str_max(A,C,10,Current_max,Max):-read_str_file(B,Flag),length_str(B,0,L),(L>Current_max->New_current_max is L;New_current_max is Current_max),append(C,[B],NL),read_str_str_max(A,NL,Flag,New_current_max,Max).

% Сколько строк, не содержащих пробелы;
pr7:-see('C.txt'),read_str_str_space(A,Count),write_list_str(A),write(Count),seen.
find_elem([H|_],H):-!.
find_elem([_|T],El):-find_elem(T,El).
read_str_str_space(A,Count):-read_str_file(B,Flag),(find_elem(B,32)->K is 0;K is 1),read_str_str_space(A,[B],Flag,K,Count).
read_str_str_space(A,A,-1,Count,Count):-!.
read_str_str_space(A,C,10,K,Count):-read_str_file(B,Flag),append(C,[B],NL),(find_elem(B,32)->K1 is K; K1 is K+1),read_str_str_space(A,NL,Flag,K1,Count).

% Вывести только те строки, в которых букв A
% больше, чем в среднем на строку.
pr8:-return_count_str(Count_str),return_count_A(Count_A),Sr is Count_A div Count_str,return_str(Sr).

return_count_str(Count_str):-see('C.txt'),read_str_str_count(Count_str),seen.

return_count_A(Count_A):-see('C.txt'),read_str_str_countA(Count_A),seen.

return_str(Sr):-see('C.txt'),read_str_str_A(A,Sr),write_list_str(A),seen.

read_str_str_count(Count_str):-read_str_file(_,Flag),read_str_str_count(Flag,1,Count_str).
read_str_str_count(-1,Count_str,Count_str):-!.
read_str_str_count(10,K,Count_str):-read_str_file(_,Flag),K1 is K+1,read_str_str_count(Flag,K1,Count_str).

count_elem([],_,K,K):-!.
count_elem([H|T],H,K,K1):-K2 is K1+1,count_elem(T,H,K,K2),!.
count_elem([_|T],EL,K,K1):-count_elem(T,EL,K,K1).

read_str_str_countA(Count_A):-read_str_file(B,Flag),count_elem(B,65,K,0),read_str_str_countA(Flag,K,Count_A).
read_str_str_countA(-1,Count_A,Count_A):-!.
read_str_str_countA(10,K,Count_A):-read_str_file(B,Flag),count_elem(B,65,K1,0),K2 is K+K1,read_str_str_count(Flag,K2,Count_A).

read_str_str_A(A,Sr):-read_str_file(B,Flag),count_elem(B,65,K,0),(K>Sr->read_str_str_A(A,[B],Flag,Sr);read_str_str_A(A,[],Flag,Sr)).
read_str_str_A(A,A,-1,_):-!.
read_str_str_A(A,C,10,Sr):-read_str_file(B,Flag),count_elem(B,65,K,0),
    (K>Sr->append(C,[B],NL),read_str_str_A(A,NL,Flag,Sr);read_str_str_A(A,C,Flag,Sr)).

%Вывести самое частое слово;
pr9:-see('C.txt'),read_str_str(A),read_str_str_1(A,Word,Max),
    write("Самое частое слово: "),write_str(Word),write("\nКол-во: "),write(Max),seen.

read_str_str_1([H|T],Word,Max):-common_word([H|T],H,Word,[],[],0,Max,H).

repeat_word([],[],[],_,K1,K,1):-K is K1+1,!.
repeat_word([],[],_,_,K,K,_):-!.
repeat_word([_|T],[],[],Sub,K1,K,1):-K2 is K1+1,first_elem(T,EL),repeat_word(T,EL,Sub,Sub,K2,K,1),!.
repeat_word([_|T],[],_,Sub,K1,K,_):-first_elem(T,EL),repeat_word(T,EL,Sub,Sub,K1,K,1),!.
repeat_word(Q,[H|T],[],Sub,I,K,1):-H>=32,H=<64,I1 is I+1,repeat_word(Q,T,Sub,Sub,I1,K,1),!.
repeat_word(Q,[H|T],_,Sub,I,K,_):-H>=32,H=<64,repeat_word(Q,T,Sub,Sub,I,K,1),!.
repeat_word(Q,[H|T],[H1|T1],Sub,I,K,_):-H\=H1,repeat_word(Q,T,[H1|T1],Sub,I,K,0),!.
repeat_word(Q,[H|T],[H1|T1],Sub,I,K,1):-H=H1,repeat_word(Q,T,T1,Sub,I,K,1),!.
repeat_word(Q,[_|T],B,Sub,I,K,_):-repeat_word(Q,T,B,Sub,I,K,0).

first_elem([H|_],H):-!.
first_elem([],[]).

common_word([],[],B,B,[],MAX,MAX,_):-!.
common_word([_|T],[],B,ML,[],Max,LM,_):-first_elem(T,EL),common_word(T,EL,B,ML,[],Max,LM,EL),!.
common_word(Q,[],B,ML,C,Max,LM,A):-repeat_word(Q,A,C,C,0,K,1),(K>Max->common_word(Q,[],B,C,[],K,LM,A);common_word(Q,[],B,ML,[],Max,LM,A)),!.
common_word(Q,[H|T],B,ML,[],Max,LM,A):-H>=32,H=<64,common_word(Q,T,B,ML,[],Max,LM,A),!.
common_word(Q,[H|T],B,ML,C,Max,LM,A):-H>=32,H=<64,repeat_word(Q,A,C,C,0,K,1),(K>Max->common_word(Q,T,B,C,[],K,LM,A);common_word(Q,T,B,ML,[],Max,LM,A)),!.
common_word(Q,[H|T],B,ML,C,Max,LM,A):-append(C,[H],C1),common_word(Q,T,B,ML,C1,Max,LM,A).

% Выводит в файл строки, состоящие из уникальных слов в исходном файле;
pr10:-see('C:/Users/ASUS/Desktop/Мое/2 курс/Prolog/file.txt'),tell('C:/Users/ASUS/Desktop/Мое/2 курс/Prolog/file1.txt'),read_str_str(A),unique_str(A),told,seen.
unique_str([H|T]):-unique_str([H|T],[H|T],H,[],H,0,H).
unique_str(_,[],[],[],_,_,_):-!.
unique_str(Text,[_|T],[],[],A,0,Current_str):-write_str(Current_str),nl,first_elem(T,EL),unique_str(Text,T,EL,[],A,0,EL),!.
unique_str(Text,[_|T],[],[],A,1,_):-first_elem(T,EL),unique_str(Text,T,EL,[],A,0,EL),!.
unique_str(Text,B,[],C,A,_,CS):-repeat_word(Text,A,C,C,0,K,1),(K>1->unique_str(Text,B,[],[],A,1,CS);unique_str(Text,B,[],[],A,0,CS)),!.
unique_str(Text,Current_text,[H|T],[],A,_,CS):-H>=32,H=<64,unique_str(Text,Current_text,T,[],A,_,CS),!.
unique_str(Text,Current_text,[H|T],C,A,_,CS):-H>=32,H=<64,repeat_word(Text,A,C,C,0,K,1),(K>1->unique_str(Text,Current_text,[],[],A,1,CS);unique_str(Text,Current_text,T,[],A,0,CS)),!.
unique_str(Text,Current_text,[H|T],C,A,_,CS):-append(C,[H],C1),unique_str(Text,Current_text,T,C1,A,_,CS).

%Показать третий, шестой и так далее символы;
pr11:-read_str(A,_),show(A,[],B,1),write_str(B).
show([],B,B,_):-!.
show([H|T],C,B,K):-R is K mod 3,R=0,append(C,[H],C1),K1 is K+1,show(T,C1,B,K1),!.
show([_|T],C,B,K):-K1 is K+1,show(T,C,B,K1).

% Общее кол-во + и - в строке, а так же кол-во символов, за которыми
% стоит 0
pr12:-read_str(A,_),count_sign(A,0,K,0),write(K).
count_sign([],K,K,_):-!.
count_sign([H|T],I,K,_):-H=43,I1 is I+1,count_sign(T,I1,K,1),!.
count_sign([H|T],I,K,_):-H=45,I1 is I+1,count_sign(T,I1,K,1),!.
count_sign([48|T],I,K,0):-count_sign(T,I,K,1),!.
count_sign([48|T],I,K,1):-I1 is I+1,count_sign(T,I1,K,1),!.
count_sign([_|T],I,K,_):-count_sign(T,I,K,1).

% w или x встретился раньше
% Если какого-то символа нет, то вывести сообщение об ошибке;
pr13:-read_str(A,_),check(A,0,0).
check([],0,0):-write("Символов x и w нет в строке."),!.
check([],0,1):-write("Символа x нет в строке."),!.
check([],1,0):-write("Символа w нет в строке."),!.
check([],1,1):-!.
check([H|T],0,0):-H=120,write("x встретился раньше w."),check(T,1,0),!.
check([H|T],0,0):-H=119,write("w встретился раньше x."),check(T,0,1),!.
check([H|T],1,0):-H=119,check(T,1,1),!.
check([H|T],0,1):-H=120,check(T,1,1),!.
check([_|T],F1,F2):-check(T,F1,F2).

% Вывести большую по длине строку столько раз, насколько она больше;
pr14:-read_str(A,N1),read_str(B,N2),(N1>N2->N3 is N1-N2-1,out(A,0,N3);N3 is N2-N1-1,out(B,0,N3)).
out(_,N3,N3):-!.
out(A,K,N3):-K1 is K+1,write_str(A),nl,out(A,K1,N3).

% Если начинается на abc, тогда заменить на www,
% иначе добавить в конец строки zzz;
pr15:-read_str(A,_),(first_symb(A,[97,98,99])->replace_str(A,[119,119,119],[],B);append(A,[122,122,122],B)),write_str(B).
first_symb(_,[]):-!.
first_symb([H|T],[H1|T1]):-H=H1,first_symb(T,T1),!.
first_symb(_,_):-!,fail.

replace_str([],_,B,B):-!.
replace_str([_|T],[H1|T1],C,B):-append(C,[H1],C1),replace_str(T,T1,C1,B),!.
replace_str([H|T],[],C,B):-append(C,[H],C1),replace_str(T,[],C1,B).

% Если длина строки больше 10, тогда оставить в строке только первые 6
% символов, иначе дополнить символом о до длины 12
pr16:-read_str(A,N),(N>10->first_six(A,[],B,0);full_str(A,[],B,0)),write_str(B).
first_six(_,B,B,6):-!.
first_six([H|T],C,B,K):-K1 is K+1,append(C,[H],C1),first_six(T,C1,B,K1).

full_str([],B,B,12):-!.
full_str([],C,B,N):-N1 is N+1,append(C,[111],C1),full_str([],C1,B,N1),!.
full_str([H|T],C,B,N):-N1 is N+1,append(C,[H],C1),full_str(T,C1,B,N1).

pr17:-randset(1,120,S),write_str(S).

% Заменить каждый чётный символ или на a, если символ не равен а или b,
% или на с в противном случае;
pr18:-read_str(A,_),replace(A,B,[],0),write_str(B).
replace([],B,B,_):-!.
replace([H|T],B,C,K):-K1 is K+1,R is K1 mod 2,R=0,H=97,append(C,[99],C1),replace(T,B,C1,K1),!.
replace([H|T],B,C,K):-K1 is K+1,R is K1 mod 2,R=0,H=98,append(C,[99],C1),replace(T,B,C1,K1),!.
replace([_|T],B,C,K):-K1 is K+1,R is K1 mod 2,R=0,append(C,[97],C1),replace(T,B,C1,K1),!.
replace([H|T],B,C,K):-K1 is K+1,append(C,[H],C1),replace(T,B,C1,K1).

% Найти кол-во цифр;
pr19:-read_str(A,_),count(A,0,K),write(K).
count([],K,K):-!.
count([H|T],I,K):-H>=48,H=<57,I1 is I+1,count(T,I1,K),!.
count([_|T],I,K):-count(T,I,K).

% Определить содержит ли строка только a,b,c или нет;
pr20:-read_str(A,_),check_symb(A,0,0,0).
check_symb([],F1,F2,F3):-F1=F2,F1=F3,F1=1,!.
check_symb([H|T],_,F2,F3):-H=97,check_symb(T,1,F2,F3),!.
check_symb([H|T],F1,_,F3):-H=98,check_symb(T,F1,1,F3),!.
check_symb([H|T],F1 ,F2,_):-H=99,check_symb(T,F1,F2,1),!.
check_symb(_,_,_,_):-!,fail.

% Заменить вхождения word на letter;
pr21:-read_str(A,_),replace(A,[],B),write_str(B).
delete_first([],B,B,_,_):-!.
delete_first([_|T],B,C,I,K):-I1 is I+1,I1=<K,delete_first(T,B,C,I1,K),!.
delete_first([H|T],B,C,I,K):-append(C,[H],C1),delete_first(T,B,C1,I,K).

append_word(A,[],A):-!.
append_word(A,[H|T],C):-append(A,[H],A1),append_word(A1,T,C),!.

replace([],B,B):-!.
replace([H|T],C,B):-first_symb([H|T],[119,111,114,100]),delete_first([H|T],D,[],0,4),append_word(C,[108,101,116,116,101,114],NL),replace(D,NL,B),!.
replace([H|T],C,B):-append(C,[H],C1),replace(T,C1,B).

% Удалить все буквы x, за которыми стледует abc;
pr22:-read_str(A,_),delete_x(A,[],B),write_str(B).
delete_x([],B,B):-!.
delete_x([120|T],C,B):-first_symb(T,[97,98,99]),delete_x(T,C,B),!.
delete_x([H|T],C,B):-append(C,[H],C1),delete_x(T,C1,B).

% Удалить все abc, за которыми следует цифры;
pr23:-read_str(A,_),delete_abc(A,[],B),write_str(B).
first_digit([H|_]):-H>=48,H=<57.

delete_abc([],B,B):-!.
delete_abc([H|T],C,B):-first_symb([H|T],[97,98,99]),delete_first([H|T],D,[],0,3),first_digit(D),delete_abc(D,C,B),!.
delete_abc([H|T],C,B):-append(C,[H],C1),delete_abc(T,C1,B).

% Найти кол-во вхождений aba в строку;
pr24:-read_str(A,_),count_aba(A,0,K),write(K).
count_aba([],K,K):-!.
count_aba([H|T],I,K):-first_symb([H|T],[97,98,97]),delete_first([H|T],B,[],0,2),I1 is I+1,count_aba(B,I1,K),!.
count_aba([_|T],I,K):-count_aba(T,I,K).

% Удалить в строке все лишние пробелы;
pr25:-read_str(A,_),delete_space(A,[],C,1),delete_space(C,[],B,0),length_str(B,0,K),write_str(B),nl,write("Длина: "),write(K).
length_str([],K,K):-!.
length_str([_|T],I,K):-I1 is I+1,length_str(T,I1,K),!.

delete_space([],B,B,_):-!.
delete_space([32],C,B,_):-delete_space([],C,B,_),!.
delete_space([32|T],C,B,0):-append(C,[32],C1),delete_space(T,C1,B,1),!.
delete_space([32|T],C,B,1):-delete_space(T,C,B,1),!.
delete_space([H|T],C,B,_):-append(C,[H],C1),delete_space(T,C1,B,0),!.

% Показать все слова, без разделителей
% Разделители указаны во второй строке;
pr26:-read_str(A,_),read_str(B,_),print_word(A,B,[],[],E),delete_space(E,[],C,1),write_str(C),count_word(C,0,K,0),nl,write("Кол-во слов: "),write(K).
compare_sign(_,[]):-!,fail.
compare_sign(H,[H|_]):-!.
compare_sign(El,[_|T]):-compare_sign(El,T).

print_word([],_,[],E,E):-!.
print_word([],_,D,C,E):-append_word(C,D,C1),print_word([],_,[],C1,E),!.
print_word([H|T],B,D,C,E):-compare_sign(H,B),(D\=[]->append_word(C,D,C1),append(C1,[32],C2),print_word(T,B,[],C2,E);append_word(C,D,C1),print_word(T,B,[],C1,E)),!.
print_word([H|T],B,D,C,E):-append(D,[H],D1),print_word(T,B,D1,C,E).

% Вывести первый, средний(если есть) и последний;
pr27:-read_str(A,N),R is N mod 2,(R=0->Sr is N/2+1-1;Sr is (N+1)/2-1),print_symb(A,B,[],0,Sr),write_str(B).
print_symb([],B,B,_,_):-!.
print_symb([H],C,B,_,_):-append(B,[H],B1),print_symb([],C,B1,_,_),!.
print_symb([H|T],C,B,0,Sr):-append(B,[H],B1),print_symb(T,C,B1,1,Sr),!.
print_symb([H|T],C,B,Sr,Sr):-append(B,[H],B1),K1 is Sr+1,print_symb(T,C,B1,K1,Sr),!.
print_symb([_|T],C,B,K,Sr):-K1 is K+1,print_symb(T,C,B,K1,Sr).





















read_str(A,N):-get0(X),r_str(X,A,[],N,0).
r_str(10,A,A,N,N):-!.
r_str(X,A,B,N,K):-K1 is K+1,append(B,[X],B1),get0(X1),r_str(X1,A,B1,N,K1).

write_str([]):-!.
write_str([H|T]):-put(H),write_str(T).

read_str_file(A,Flag):-get0(X),r_str(X,A,[],Flag).
r_str(10,A,A,10):-!.
r_str(-1,A,A,-1):-!.
r_str(X,A,B,Flag):-append(B,[X],B1),get0(X1),r_str(X1,A,B1,Flag).

read_str_str(A):-read_str_file(B,Flag),read_str_str(A,[B],Flag).
read_str_str(A,A,-1):-!.
read_str_str(A,Temp_list,10):-read_str_file(B,Flag),append(Temp_list,[B],T_L),
    read_str_str(A,T_L,Flag).

write_list_str([]):-!.
write_list_str([H|T]):-write_str(H),nl,write_list_str(T).

%Прочитать из файла строки и вывести длину наибольшей строки.
pr6:-see('C:/Users/ASUS/Desktop/Мое/2 курс/Prolog/file.txt'),read_str_str(A),
    length_max(A,0,Max),write_list_str(A),write('Длина наибольшей строки: '),
    write(Max),seen.

length_max([],Max,Max):-!.
length_max([H|T],M,Max):-length(H,L),L>M,length_max(T,L,Max),!.
length_max([_|T],M,Max):-length_max(T,M,Max).

%Определить,сколько в файле строк, не содержащих пробела.
pr7:-see('C:/Users/ASUS/Desktop/Мое/2 курс/Prolog/file.txt'),read_str_str(A),
    count_not_contain_space(A,0,K),write_list_str(A),
    write('Количество строк, не содержащих пробелы: '),write(K),seen.

count_not_contain_space([],K,K):-!.
count_not_contain_space([H|T],K1,K):-not(find(H,32)),K2 is K1+1,
    count_not_contain_space(T,K2,K),!.
count_not_contain_space([_|T],K1,K):-count_not_contain_space(T,K1,K).

find([H|_],H).
find([_|T],E):-find(T,E).

% Найти и вывести только те строки, в которых букв А больше, чем в
% среднем на строку.
pr8:-see('C:/Users/ASUS/Desktop/Мое/2 курс/Prolog/file.txt'),read_str_str(A),
    sr_A(A,0,0,K),out_str(A,K),write(K),seen.

sr_A([],CountS,K1,K):-K is K1/CountS.
sr_A([H|T],CountS,K1,K):-count_El(H,0,Count,65),P is CountS+1,K2 is K1+Count,
    sr_A(T,P,K2,K).

count_El([],Count,Count,_):-!.
count_El([H|T],K,Count,El):-H=El,K1 is K+1,count_El(T,K1,Count,El),!.
count_El([_|T],K,Count,El):-count_El(T,K,Count,El).

out_str([],_):-!.
out_str([H|T],K):-count_El(H,0,Count,65),Count>K,write_str(H),nl,out_str(T,K),!.
out_str([_|T],K):-out_str(T,K).

put_str([]):-!.
put_str([H|T]):-put(H),put_str(T).

create_file([]):-!.
create_file([H|T]):-put_str(H),nl,create_file(T).

% Вывести в отдельный файл строки, состоящие из слов, не повторяющихся в
% исходном файле
pr10:-see('C:/Users/ASUS/Desktop/Мое/2 курс/Prolog/file.txt'),read_str_str(A),
    new_list(A,[],B),seen,
    tell('C:/Users/ASUS/Desktop/Мое/2 курс/Prolog/newfile.txt'),create_file(B),
    told.
new_list([H|T]):-new_list([H|T],[H|T],H,[],H,0,H).
new_list(_,[],[],[],_,_,_):-!.
new_list(Text,[_|T],[],[],A,0,Current_str):-new_list(Current_str),nl,first_elem(T,EL),new_list(Text,T,EL,[],A,0,EL),!.
new_list(Text,[_|T],[],[],A,1,_):-first_elem(T,EL),new_list(Text,T,EL,[],A,0,EL),!.
new_list(Text,B,[],C,A,_,CS):-repeat_word(Text,A,C,C,0,K,1),(K>1->new_list(Text,B,[],[],A,1,CS);new_list(Text,B,[],[],A,0,CS)),!.
new_list(Text,Current_text,[H|T],[],A,_,CS):-H>=32,H=<64,new_list(Text,Current_text,T,[],A,_,CS),!.
new_list(Text,Current_text,[H|T],C,A,_,CS):-H>=32,H=<64,repeat_word(Text,A,C,C,0,K,1),(K>1->new_list(Text,Current_text,[],[],A,1,CS);new_list(Text,Current_text,T,[],A,0,CS)),!.
new_list(Text,Current_text,[H|T],C,A,_,CS):-append(C,[H],C1),new_list(Text,Current_text,T,C1,A,_,CS).

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











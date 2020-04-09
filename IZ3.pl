read_str_file(A,Flag):-get0(X),r_str(X,A,[],Flag).
r_str(10,A,A,10):-!.
r_str(-1,A,A,-1):-!.
r_str(X,A,B,Flag):-append(B,[X],B1),get0(X1),r_str(X1,A,B1,Flag).

read_str_str(A):-read_str_file(B,Flag),read_str_str(A,[B],Flag).
read_str_str(A,A,-1):-!.
read_str_str(A,Temp_list,10):-read_str_file(B,Flag),append(Temp_list,[B],T_L),
    read_str_str(A,T_L,Flag).

write_str([]):-!.
write_str([H|T]):-put(H),write_str(T).

write_list_str([]):-!.
write_list_str([H|T]):-write_str(H),nl,write_list_str(T).

pr:-see('C:/Users/ASUS/Desktop/Мое/2 курс/Prolog/file.txt'),
    read_str_str(A),seen,dell_words(A,B),
    write_list_str(B).
new_str_str(A):-dell_words(A,B).

dell_words(A,B):-dell_words(A,A,[],[],[],0,B).

dell_words([],_,Str,B,_,0,C):-append(B,[Str],B1),C = B1,!.
dell_words([],A,Str,B,Word,1,C):-repeat_word(A,Word,K),K<4,
    append(Str,Word,Str1),append(B,[Str1],B1),C = B1,!.
dell_words([],_,Str,B,_,1,C):-append(B,[Str],B1),C = B1,!.

dell_words([[]|T],A,Str,B,_,0,C):-append(B,[Str],B1),dell_words(T,A,[],B1,_,0,C),!.
dell_words([[]|T],A,Str,B,Word,1,C):-repeat_word(A,Word,K),K<4,
    append(Str,Word,Str1),append(B,[Str1],B1),dell_words(T,A,[],B1,[],0,C),!.
dell_words([[]|T],A,Str,B,_,1,C):-append(B,Str,B1),dell_words(T,A,[],B1,[],0,C),!.

dell_words([[H1|T1]|T],A,Str,B,Word,0,C):-H1=32,append(Str,[H1],Str1),
    dell_words([T1|T],A,Str1,B,Word,0,C),!.
dell_words([[H1|T1]|T],A,Str,B,Word,0,C):-append(Word,[H1],Word1),
    dell_words([T1|T],A,Str,B,Word1,1,C),!.
dell_words([[H1|T1]|T],A,Str,B,Word,1,C):-append(Word,[H1],Word1),
    dell_words([T1|T],A,Str,B,Word1,1,C),!.
dell_words([[H1|T1]|T],A,Str,B,Word,1,C):-H1=32,repeat_word(A,Word,K),K<4,
    append(Str,Word,Str1),dell_words([T1|T],A,Str1,B,[],0,C),!.
dell_words([[H1|T1]|T],A,Str,B,_,1,C):-H1=32,dell_words([T1|T],A,Str,B,[],0,C).


repeat_word(A,Word,K):-r_w(A,Word,Word,0,K,0).

r_w([],_,_,K,K,_):-!.
r_w([[H1|T1]|T],[],Word,I,K,1):-(H1=32;H1=10),I1 is I+1,r_w([T1|T],Word,Word,I1,K,0),!.
r_w([[_|T1]|T],[],Word,I,K,1):-r_w([T1|T],[],Word,I,K,0).
r_w([[H1|T1]|T],[],Word,I,K,0):-(H1\=32;H1\=10),r_w([T1|T],[],Word,I,K,0),!.
r_w([T1|T],[],Word,I,K,0):-r_w([T1|T],Word,Word,I,K,0),!.

r_w([[]|T],_,Word,I,K,_):-r_w(T,Word,Word,I,K,0),!.

r_w([[H1|T1]|T],[HW|_],Word,I,K,0):-H1\=HW,r_w([T1|T],Word,Word,I,K,0),!.
r_w([[H1|T1]|T],[HW|TW],Word,I,K,0):-r_w([T1|T],TW,Word,I,K,1),!.
r_w([[H1|T1]|T],[HW|TW],Word,I,K,1):-HW=H1,r_w([T1|T],TW,Word,I,K,1),!.
r_w([[_|T1]|T],_,Word,I,K,1):-r_w([T1|T],Word,Word,I,K,0).


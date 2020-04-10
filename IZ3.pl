read_str_file(A,Flag):-get0(X),r_str(X,A,[],Flag).
r_str(10,A,A,10):-!.
r_str(-1,A,A,-1):-!.
r_str(X,A,B,Flag):-append(B,[X],B1),get0(X1),r_str(X1,A,B1,Flag).

read_str_str(A):-read_str_file(B,Flag),read_str_str(A,[B],Flag).
read_str_str(A,A,-1):-!.
read_str_str(A,Temp_list,10):-read_str_file(B,Flag),
    append(Temp_list,[B],T_L),read_str_str(A,T_L,Flag).

write_str([]):-!.
write_str([H|T]):-put(H),write_str(T).

write_list_str([]):-!.
write_list_str([H|T]):-write_str(H),nl,write_list_str(T).

pr:-see('C:/Users/ASUS/Desktop/Мое/2 курс/Prolog/file.txt'),
    read_str_str(A),seen,new_str_str(A,B),write_list_str(B).

new_str_str(A,C):-dell_words(A,B),add_words(B,C).

dell_words(A,B):-dell_words(A,A,[],[],[],B).

dell_words([],_,Str,B,[],B1):-append(B,[Str],B2),B1=B2.
dell_words([],A,Str,B,Word,B1):-repeat_word(A,Word,K),K>3,
    append(B,[Str],B2),B1=B2,!.
dell_words([],_,Str,B,Word,B1):-append(Str,Word,Str1),
    append(B,[Str1],B2),B1=B2.

dell_words([[]|T],A,Str,B,[],B1):-append(B,[Str],B2),
    dell_words(T,A,[],B2,[],B1).
dell_words([[]|T],A,Str,B,Word,B1):-repeat_word(A,Word,K),K>3,
    append(B,[Str],B2),dell_words(T,A,[],B2,[],B1),!.
dell_words([[]|T],A,Str,B,Word,B1):-append(Str,Word,Str1),
    append(B,[Str1],B2),dell_words(T,A,[],B2,[],B1).

dell_words([[H1|T1]|T],A,Str,B,[],B1):-H1=32,append(Str,[H1],Str1),
    dell_words([T1|T],A,Str1,B,[],B1),!.
dell_words([[H1|T1]|T],A,Str,B,[],B1):-
    dell_words([T1|T],A,Str,B,[H1],B1),!.
dell_words([[H1|T1]|T],A,Str,B,Word,B1):-H1\=32,append(Word,[H1],Word1),
    dell_words([T1|T],A,Str,B,Word1,B1),!.
dell_words([[H1|T1]|T],A,Str,B,Word,B1):-repeat_word(A,Word,K),K>3,
    append(Str,[H1],Str1),dell_words([T1|T],A,Str1,B,[],B1),!.
dell_words([[_|T1]|T],A,Str,B,Word,B1):-append(Str,Word,Str1),
    append(Str1,[32],Str2),dell_words([T1|T],A,Str2,B,[],B1).

add_words([Str|T],B):-add_words([Str|T],[Str|T],Str,[],[],B).

add_words([],_,Str,B1,[],B):-append(B1,[Str],B2),B=B2,!.
add_words([],A,Str,B1,Word,B):-repeat_word(A,Word,K),K\=1,
    append(B1,[Str],B2),B=B2,!.
add_words([],_,Str,B1,Word,B):-append(Str,[32],Str1),
    append(Str1,Word,Str2),append(B1,[Str2],B2),B=B2,!.

add_words([[]|[C|T]],A,Str,B1,[],B):-append(B1,[Str],B2),
    add_words([C|T],A,C,B2,[],B),!.
add_words([[]|[C|T]],A,Str,B1,Word,B):-repeat_word(A,Word,K),K\=1,
    append(B1,[Str],B2),add_words([C|T],A,C,B2,[],B),!.
add_words([[]|[C|T]],A,Str,B1,Word,B):-append(Str,[32],Str1),
    append(Str1,Word,Str2),append(B1,[Str2],B2),
    add_words([C|T],A,C,B2,[],B),!.

add_words([[H1|T1]|T],A,Str,B1,[],B):-H1=32,
    add_words([T1|T],A,Str,B1,[],B),!.
add_words([[H1|T1]|T],A,Str,B1,[],B):-add_words([T1|T],A,Str,B1,[H1],B).
add_words([[H1|T1]|T],A,Str,B1,Word,B):-H1\=32,append(Word,[H1],Word1),
    add_words([T1|T],A,Str,B1,Word1,B),!.
add_words([[H1|T1]|T],A,Str,B1,Word,B):-repeat_word(A,Word,K),K=1,
    append(Str,[H1],Str1),append(Str1,Word,Str2),
    add_words([T1|T],A,Str2,B1,[],B).
add_words([[_|T1]|T],A,Str,B1,_,B):-add_words([T1|T],A,Str,B1,[],B).

skip_word([],[]):-!.
skip_word([32|T],T):-!.
skip_word([_|T],A):-skip_word(T,A).

repeat_word(A,Word,K):-r_w(A,Word,Word,0,K,0).

r_w([],[],_,I,K,1):-I1 is I+1,K=I1,!.
r_w([],_,_,K,K,_):-!.

r_w([[]|T],[],Word,I,K,1):-I1 is I+1,r_w(T,Word,Word,I1,K,0),!.
r_w([[]|T],_,Word,I,K,_):-r_w(T,Word,Word,I,K,0),!.

r_w([[H1|T1]|T],[HW|TW],Word,I,K,0):-H1=HW,r_w([T1|T],TW,Word,I,K,1),!.
r_w([[H1|T1]|T],W,Word,I,K,0):-skip_word([H1|T1],A),
    r_w([A|T],W,Word,I,K,0),!.
r_w([[H1|T1]|T],[HW|TW],Word,I,K,1):-H1=HW,r_w([T1|T],TW,Word,I,K,1),!.
r_w([[H1|T1]|T],_,Word,I,K,1):-H1=32,I1 is I+1,
    r_w([T1|T],Word,Word,I1,K,0),!.
r_w([[H1|T1]|T],_,Word,I,K,1):-skip_word([H1|T1],A),
    r_w([A|T],Word,Word,I,K,0).


read_str_file(A,Flag):-get0(X),r_str(X,A,[],Flag).
r_str(10,A,A,10):-!.
r_str(-1,A,A,-1):-!.
r_str(X,A,B,Flag):-append(B,[X],B1),get0(X1),r_str(X1,A,B1,Flag).

read_str_str(A):-read_str_file(B,Flag),read_str_str(A,[B],Flag).
read_str_str(A,A,-1):-!.
read_str_str(A,Temp_list,10):-read_str_file(B,Flag),append(Temp_list,[B],T_L),
    read_str_str(A,T_L,Flag).

pr:-see('C:/Users/ASUS/Desktop/Мое/2 курс/Prolog/file.txt'),tell('C:/Users/ASUS/Desktop/Мое/2 курс/Prolog/file1.txt'),read_str_str(A),new_str_str(A),told,seen.

new_str_str(A):-dell_words(A).

dell_words(A):-dell_words(A,A,[],[],[],0).

dell_words([],_,Str,B,_,0):-append(B,[Str],B1),dell_words(B1,_,_,B1,0),!.
dell_words([],A,Str,B,Word,1):-repeat_word(A,Word,K),K<4,append(Str,[Word],Str1),
    append(B,[Str1],B1),dell_words(B1,A,_,B1,_).
dell_words([],_,Str,B,_,1):-append(B,[Str],B1),dell_words(B1,_,_,B1,_).

dell_words([[]|T],_,Str,B,_,0):-append(B,[Str],B1),dell_words(T,_,[],B1,_,0).
dell_words([[]|T],A,Str,B,Word,1):-repeat_word(A,Word,K),K<4,append(Str,[Word],Str1),
    append(B,[Str1],B1),dell_words(T,A,[],B1,[],0).
dell_words([[]|T],_,Str,B,_,1):-append(B,[Str],B1),dell_words(T,_,[],B1,0).

dell_words([[H1|T1]|T],_,Str,B,Word,0):-append(Str,H1,Str1),
    dell_word([T1|T],_,Str1,B,Word,0).
dell_words([[H1|T1]|T],_,Str,B,Word,0):-append(Word,[H1],Word1),
    dell_words([T1|T],_,Str,B,Word1,1).
dell_words([[H1|T1]|T],_,Str,B,Word,1):-append(Word,[H1],Word1),
    dell_words([T1|T],_,Str,B,Word1,1).
dell_words([[H1|T1]|T],A,Str,B,Word,1):-H1=32,repeat_word(A,Word,K),K<4,
    append(Str,[Word],Str1),dell_words([T1|T],A,Str1,B,[],0).
dell_words([[H1|T1]|T],_,Str,B,_,1):-H1=32,dell_word([T1|T],_,Str,B,[],0).

repeat_word(A,Word,K):-r_w(A,Word,Word,0,K,0).
r_w([[H1|T1]|T],[HW|TW],Word,I,K,0):-HW=H1,r_w([T1|T],TW,Word,I,K,1).
r_w([[_|T1]|T],[_|TW],Word,I,K,0):-r_w([T1|T],TW,Word,I,K,0).
r_w([[H1|T1]|T],[HW|TW],Word,I,K,1):-HW=H1,r_w([T1|T],TW,Word,I,K,1).


pr1:-read(N),read_list(A,N),sum_list(A,S),write(S).

read_list(A,N):-r_l([],A,0,N).
r_l(A,A,N,N):-!.
r_l(B,A,I,N):-I1 is I+1,read(X),append(B,[X],B1),r_l(B1,A,I1,N).

sum_list([],0):-!.
sum_list([Head|Tail],S):-sum_list(Tail,S1),S is S1+Head.

pr2:-read(N),read_list(A,N),read(Nom),nom(Nom,A,E),write(E).

nom(0,[Head|_],Head):-!.
nom(Nom,[_|Tail],E):-Nom1 is Nom-1,nom(Nom1,Tail,E).

pr3:-read(N),read_list(A,N),min(A,M),write(M).
min_list([H|T],M):-m_l(T,H,M).
m_l([],M,M):-!.
m_l([H|T],Min,M):-(H<Min->m_l(T,H,M);m_l(T,Min,M)).

write_list([]):-!.
write_list([H|T]):-write(H),write_list(T).

pr4:-read(N),read_list(A,N),read(E),find(A,E).
find([H|_],H).
find([_|T],E):-find(T,E).

pr5:-read(N),read_list(A,N),read(X),num_list(A,X,M),write(M).
num_list(A,X,M):-num_list(A,X,0,M).
num_list([X|_],X,I,I):-!.
num_list([],_,_,-1):-!.
num_list([_,T],X,I,M):-I1 is I+1,num_list(T,X,I1,M).

pr9:-read(N),read_list(A,N),read(X),delete(A,B,[],X),write(B).
delete([],B,B,_):-!.
delete([H|T],B,C,X):-H\=X,append(C,[H],C1),delete(T,B,C1,X).
delete([_|T],B,C,X):-delete(T,B,C,X).

pr10:-read(N),read_list(A,N),check(A).
check([]).
check([H|T]):-find(T,H),!,fail.
check([_|T]):-check(T).

pr11:-read(N),read_list(A,N),new_list(A,[],B),write(B).
new_list([],B,B):-!.
new_list([H|T],C,B):-find(T,H),delete([H|T],A1,[],H),new_list(A1,C,B).
new_list([H|T],C,B):-append(C,[H],C1),new_list(T,C1,B).

pod:-read(S),read(SP),read(A),read(P),sub_str(A,P,P,1,0,S,SP).
sub_str(_,_,_,_,K,S,SP):-R is S-K,R<SP,!,fail.
sub_str(_,_,_,SP,_,_,SP):-!.
sub_str([H|T],[H1|T1],[HP|TP],I,K,S,SP):-H=H1,K1 is K+1,I1 is I+1,sub_str(T,T1,[HP|TP],I1,K1,S,SP).
sub_str([_|T],[_|_],[HP|TP],_,K,S,SP):-K1 is K+1,sub_str(T,[HP|TP],[HP|TP],1,K1,S,SP).

















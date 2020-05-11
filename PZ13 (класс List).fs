// Learn more about F# at http://fsharp.org

open System
open System.Collections.Generic

let rec read_list n = 
    if n=0 then []
    else
    let Head = System.Convert.ToInt32(System.Console.ReadLine())
    let Tail = read_list (n-1)
    Head::Tail

let read_data = 
    let n=System.Convert.ToInt32(System.Console.ReadLine())
    read_list n

let rec write_list list = 
    match list with
    |[] -> 0
    |h::t -> System.Console.WriteLine(h.ToString())
             write_list t

let check el = el%2=0

let rec prog1_1 head tail = 
    match List.isEmpty(tail) with
    | true -> head
    | false -> if ((check head)=(check tail.Head)) && (tail.Head>head) then prog1_1 tail.Head tail.Tail
               else prog1_1 head tail.Tail

let prog1 list = 
    match List.isEmpty(list) with
    | true -> 0
    | false -> prog1_1 list.Head list.Tail

let rec count_repeat el list =
    match List.isEmpty(list) with
    | true -> 0
    | false -> if(el = list.Head) then (count_repeat el list.Tail) + 1
               else count_repeat el list.Tail

let rec max_repeat head tail list =
    match List.isEmpty(tail) with
    | true -> head
    | false -> if ((count_repeat head list)<(count_repeat tail.Head list)) then max_repeat tail.Head tail.Tail list
               else max_repeat head tail.Tail list

let prog2 list =
    match List.isEmpty(list) with
    | true -> 0
    | false -> max_repeat list.Head list.Tail list

let prog3 list = 
    let list1 = List.filter (fun x -> (check x) && check(count_repeat x list)) list
    list1

[<EntryPoint>]
let main argv =
    let list = read_data
    write_list (prog3 list)
    0 // return an integer exit code
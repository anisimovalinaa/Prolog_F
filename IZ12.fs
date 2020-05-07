// Learn more about F# at http://fsharp.org

open System

let rec read_list n = 
    if n=0 then []
    else
    let Head = System.Convert.ToInt32(System.Console.ReadLine())
    let Tail = read_list (n-1)
    Head::Tail

//let read_data = 
//    lazy 
//        let n = System.Convert.ToInt32(System.Console.ReadLine())
//        read_list n

let rec write_list list = 
    match list with
    |[] -> 0
    |h::t -> System.Console.WriteLine(h.ToString())
             write_list t

let rec count list h =
    match list with
    | [] -> 0
    | head::tail -> if (h=head) then (count tail h)+1
                    else count tail h

let rec find el list = 
    match list with
    | [] -> false
    | head::tail -> if (head = el) then true
                    else find el tail

let rec new_list1 l1 l2 l3 =
    match l1 with 
    | [] -> []
    | h1::t1 -> let tail = new_list1 t1 l2 l3
                if (count l2 h1 = 1) && not(find h1 l3) then h1::tail
                else tail   

let rec new_list2 l1 l2 l3 list = 
    match l1 with 
    | [] -> list
    | h::t -> if (count l2 h = 1) && not(find h l3) then new_list2 t l2 l3 (h::list)
              else new_list2 t l2 l3 list

let new_list l1 l2 =
    new_list2 l2 l2 l1 (new_list1 l1 l1 l2)

//let rec q l1 l2 =
//    match l1, l2 with
//    | [],[] -> []
//    | h1::t1,[] -> let tail = q t1 l2
//                   if (count l1 h1 = 1) then h1::tail
//                   else tail
//    | [], h2::t2 -> 

[<EntryPoint>]
let main argv =
    System.Console.WriteLine("Введите первый список:")
    System.Console.Write("n = ")
    let n1 = System.Convert.ToInt32(System.Console.ReadLine())
    let list1 = read_list n1
    System.Console.WriteLine("Введите второй список:")
    System.Console.Write("n = ")
    let n2 = System.Convert.ToInt32(System.Console.ReadLine())
    let list2 = read_list n2
    System.Console.WriteLine("Новый список:")
    write_list (new_list list1 list2)
    0 // return an integer exit code
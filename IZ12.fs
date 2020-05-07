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
    | h::t -> if (count l2 h = 1) && not(find h l3) then h::list
              else list

let new_list l1 l2 =
    let list = new_list1 l1 l1 l2
    new_list2 l2 l2 l1 list


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
    printfn ""
    let list3 = new_list list1 list2
    write_list list3
    0 // return an integer exit code

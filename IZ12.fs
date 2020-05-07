// Learn more about F# at http://fsharp.org

open System

let rec read_list n = 
    if n=0 then []
    else
    let Head = System.Convert.ToInt32(System.Console.ReadLine())
    let Tail = read_list (n-1)
    Head::Tail

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

let rec new_list1 secondList subList firstList =
    match secondList with 
    | [] -> []
    | h::t -> let tail = new_list1 t subList firstList
              if (count subList h = 1) && not(find h firstList) then h::tail
              else tail   

let rec new_list firstList subList secondList resultList = 
    match firstList with 
    | [] -> resultList
    | h::t -> if (count subList h = 1) && not(find h secondList) then new_list t subList secondList (h::resultList)
              else new_list t subList secondList resultList

[<EntryPoint>]
let main argv =
    System.Console.WriteLine("Введите первый список:")
    System.Console.Write("n = ")
    let n1 = System.Convert.ToInt32(System.Console.ReadLine())
    let firstList = read_list n1
    System.Console.WriteLine("Введите второй список:")
    System.Console.Write("n = ")
    let n2 = System.Convert.ToInt32(System.Console.ReadLine())
    let secondList = read_list n2
    System.Console.WriteLine("Новый список:")
    //System.Console.WriteLine(new_list list1 list2)
    //let q = new_list2 list2 list2 list1 (new_list1 list1 list1 list2)

    write_list (new_list firstList firstList secondList (new_list1 secondList secondList firstList))
    0 // return an integer exit code
// Learn more about F# at http://fsharp.org

open System
open System.Drawing
open System.Windows.Forms
open System.IO

let form = new Form(Text = "Индивидуальная работа №14.", Height = 500, Width = 500)

let buttonOpen = new Button(Text = "Открыть файл", Width = 100)
buttonOpen.Location <- new Point(165, 20)

let text = new RichTextBox(Height = 100, Width = 400)
text.Location <- new Point(50,50)

let label1 = new Label(Text = "Введите слово: ")
label1.Location <- new Point(50,170)

let textWord = new RichTextBox(Height = 20, Width = 140)
textWord.Location <- new Point(150, 170)

let button = new Button(Text = "Найти количество перестановок", Height = 30, Width = 150)
button.Location <- new Point(150, 220)

let label2 = new Label(Text = "Ответ: ", Width = 50)
label2.Location <- new Point(120, 280)

let answer = new RichTextBox(Height = 20, Width = 60)
answer.Location <- new Point(180, 280)

form.Controls.Add(buttonOpen)
form.Controls.Add(text)
form.Controls.Add(label1)
form.Controls.Add(textWord)
form.Controls.Add(button)
form.Controls.Add(label2)
form.Controls.Add(answer)

type 'T Tree =
    Empty
    | Node of 'T*('T Tree)*('T Tree)

let fold_tree f list tree =
    let rec loop t l =
        match t with
        |Empty -> l
        |Node (z,L,R) -> loop L (f z (loop R l))
    loop tree list

let tree_to_list T = fold_tree (fun x t -> x::t) [] T

let rec insert x = function
    Empty->Node(x,Empty,Empty)
    |Node(z,L,R)-> if x <= z then Node(z, insert x L, R)
                   else Node(z, L, insert x R)

let rec string_to_tree word tree =
    match word with
    | "" -> tree
    | _ -> string_to_tree (word.Remove(0,1)) (insert word.[0] tree)

//let rec tree_to_list = function
//    Empty -> []
//    |Node(v, L, R) -> (tree_to_list L)@[v]@(tree_to_list R)

let check word1 word2 = 
    if (tree_to_list (string_to_tree word1 Empty)) = (tree_to_list (string_to_tree word2 Empty)) then true
    else false

//let rec check1 (word1: string) (word2: string) iter = 
//    match iter = word2.Length with 
//    | true -> true
//    | false -> if word1.Contains(word2.[iter].ToString()) then let i = word1.IndexOf(word2.[iter])
//                                                               check1 (word1.Remove(i,1)) word2 (iter+1)
//               else false

//let check (word1: string) (word2: string) = 
//    match word1.Length = word2.Length with
//    | true -> check1 word1 word2
//    | false -> false

let rec countPemutations text word word1 count =
    match text with
    | "" -> if (word1 <> "") then if (check word word1) then count+1
                                  else count
            else count
    | _ -> if(text.[0] <> '\n' && text.[0] <> ' ') then countPemutations (text.Remove(0,1)) word (word1+text.[0].ToString()) count
           else if (check word word1) then countPemutations (text.Remove(0,1)) word "" (count+1)
                else countPemutations (text.Remove(0,1)) word "" count

[<STAThread>]
buttonOpen.Click.Add (fun evArgs -> let openFile = new OpenFileDialog():OpenFileDialog
                                    if (openFile.ShowDialog() = DialogResult.OK) then let file = new StreamReader(openFile.FileName)
                                                                                      text.AppendText(file.ReadToEnd())
                                    else text.AppendText("")|> ignore)

button.Click.Add(fun evArgs -> let count = countPemutations (text.Text) (textWord.Text) "" 0
                               answer.AppendText(count.ToString())
                               |> ignore)

do Application.Run(form)
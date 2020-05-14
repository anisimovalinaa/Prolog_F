// Learn more about F# at http://fsharp.org

open System
open System.Drawing
open System.Windows.Forms
open System.IO

let form = new Form(Text = "Индивидуальная работа №14.", Height = 500, Width = 500)

let buttonOpen = new Button(Text = "Открыть файл", Width = 100)
buttonOpen.Location <- new Point(165, 20)

let textString = new RichTextBox(Height = 100, Width = 400)
textString.Location <- new Point(50,50)

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
form.Controls.Add(textString)
form.Controls.Add(label1)
form.Controls.Add(textWord)
form.Controls.Add(button)
form.Controls.Add(label2)
form.Controls.Add(answer)

let func (word1: string) (word2: string) = 
    if (word1.Length = word2.Length) then if(word1.[0] = word2.[0]) then true
                                          else false
    else false

let rec countPemutations (text: string) (word: string) iter (word1: string) count =
    match iter = text.Length with
    | true -> count
    | false -> if(text.[iter] <> '\n' && text.[iter] <> ' ') then countPemutations text word (iter+1) (word1+text.[iter].ToString()) count
               else if (func word word1) then countPemutations text word (iter+1) "" (count+1)
                       else countPemutations text word (iter+1) "" count

[<STAThread>]
buttonOpen.Click.Add (fun evArgs -> let openFile = new OpenFileDialog():OpenFileDialog
                                    if (openFile.ShowDialog() = DialogResult.OK) then let file = new StreamReader(openFile.FileName)
                                                                                      textString.AppendText(file.ReadToEnd())
                                    else textString.AppendText("")|> ignore)

button.Click.Add(fun evArgs -> let a = textString.Text
                               let b = textWord.Text
                               let c = countPemutations a b 0 "" 0
                               answer.AppendText(c.ToString())
                               |> ignore)

do Application.Run(form)
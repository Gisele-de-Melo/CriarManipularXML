//------------------------------------------------------------------------------------------------------------
//********* Sobre ************
//Autor: Gisele de Melo
//Esse código foi desenvolvido com o intuito de aprendizado para o blog codedelphi.com, portanto não me
//responsabilizo pelo uso do mesmo.
//
//********* About ************
//Author: Gisele de Melo
//This code was developed for learning purposes for the codedelphi.com blog, therefore I am not responsible for
//its use.
//------------------------------------------------------------------------------------------------------------

unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, XMLDoc, XMLIntf;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  XMLDoc: IXMLDocument;
  RootNode, LivroNode: IXMLNode;

begin

  // Criando o documento XML
  XMLDoc := NewXMLDocument;
  XMLDoc.Options := [doNodeAutoIndent];
  XMLDoc.Version := '1.0';
  XMLDoc.Encoding := 'UTF-8';

  // Adicionando o nó raiz
  RootNode := XMLDoc.AddChild('Livraria');

  // Adicionando um nó filho (Livro) e atributos
  LivroNode := RootNode.AddChild('Livro');
  LivroNode.Attributes['ID'] := '001';
  LivroNode.AddChild('Titulo').Text := 'Programando em Delphi';
  LivroNode.AddChild('Autor').Text := 'Fulano de Tal';
  LivroNode.AddChild('Preco').Text := '49.90';

  // Salvando o documento em um arquivo
  XMLDoc.SaveToFile('livraria.xml');
  ShowMessage('Arquivo criado!');

end;

procedure TForm1.Button2Click(Sender: TObject);
var
  XMLDoc: IXMLDocument;
  LivroNode: IXMLNode;
begin
  // Carregando o documento XML existente
  XMLDoc := LoadXMLDocument('livraria.xml');

  // Localizando o nó do livro com ID 001
  LivroNode := XMLDoc.DocumentElement.ChildNodes.FindNode('Livro');
  if Assigned(LivroNode) and (LivroNode.Attributes['ID'] = '001') then
  begin
    // Modificando o preço do livro
    LivroNode.ChildNodes['Preco'].Text := '39.90';

    // Salvando as alterações no arquivo
    XMLDoc.SaveToFile('livraria_modificado.xml');
    ShowMessage('Arquivo criado!');
  end;
end;

end.

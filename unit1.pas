unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Menus, EditBtn, ComCtrls, Buttons, process, Unit2;

type

  { TForm1 }

  TForm1 = class(TForm)
    makeButton: TBitBtn;
    linkText: TEditButton;
    fileSymRadio: TRadioButton;
    targetPathText: TEditButton;
    Label1: TLabel;
    Label2: TLabel;
    targetText: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    N1: TMenuItem;
    fileDiag: TOpenDialog;
    dirSymLink: TRadioButton;
    hardRadio: TRadioButton;
    juncRadio: TRadioButton;
    svDiag: TSaveDialog;
    dirDiag: TSelectDirectoryDialog;
    procedure makeButtonClick(Sender: TObject);
    procedure dirDiagClose(Sender: TObject);
    procedure dirSymLinkChange(Sender: TObject);
    procedure fileDiagClose(Sender: TObject);
    procedure fileSymRadioChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure hardRadioChange(Sender: TObject);
    procedure checkRadio();
    procedure juncRadioChange(Sender: TObject);
    procedure linkTextButtonClick(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure svDiagClose(Sender: TObject);
    procedure targetPathTextButtonClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  s: string;
  key: string;
  linkName: string;
  targetPath: string;
  targetType: string;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.checkRadio();
begin
  if (fileSymRadio.Checked = True) then
  begin
    targetType := 'FILE';
    key := ' ';
  end;
  if (dirSymLink.Checked = True) then
  begin
    targetType := 'DIR';
    key := ' /D ';
  end;
  if (hardRadio.Checked = True) then
  begin
    targetType := 'FILE';
    key := ' /H ';
  end;
  if (juncRadio.Checked = True) then
  begin
    targetType := 'DIR';
    key := ' /J ';
  end;
  targetText.Caption := 'Target: ' + targetType;
  if (targetType <> 'NONE') then
  begin
    linkText.Enabled := True;
    targetPathText.Enabled := True;
  end;
  if (targetPathText.Caption <> '') and (linkText.Caption <> '') then
    makeButton.Enabled := True
  else
    makeButton.Enabled := False;
end;

procedure TForm1.juncRadioChange(Sender: TObject);
begin
  checkRadio();
  targetPathText.Caption := '';
end;

procedure TForm1.linkTextButtonClick(Sender: TObject);
begin
  svDiag.Execute;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  Form2.ShowModal;
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  linkText.Caption := '';
  targetPathText.Caption := '';
  fileSymRadio.Checked := False;
  dirSymLink.Checked := False;
  hardRadio.Checked := False;
  juncRadio.Checked := False;
  targetText.Caption := 'Target: NONE';
  makeButton.Enabled := False;
  linkText.Enabled := False;
  targetPathText.Enabled := False;
  s := '';
  key := '';
  linkName := '';
  targetPath := '';
  targetType := '';
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  Form1.Close;
end;

procedure TForm1.svDiagClose(Sender: TObject);
begin
  linkText.Caption := svDiag.FileName;
  checkRadio();
end;

procedure TForm1.targetPathTextButtonClick(Sender: TObject);
begin
  if (targetType = 'FILE') then
    fileDiag.Execute
  else
    dirDiag.Execute;
end;

procedure TForm1.makeButtonClick(Sender: TObject);
begin
  makeButton.Enabled := False;
  fileSymRadio.Enabled := False;
  dirSymLink.Enabled := False;
  hardRadio.Enabled := False;
  juncRadio.Enabled := False;
  makeButton.Enabled := False;
  linkText.Enabled := False;
  targetPathText.Enabled := False;
  RunCommand('C:\Windows\System32\cmd.exe', ['/c', '"mklink' + key +
    '"' + linkText.Caption + '" "' + targetPathText.Caption + '""'], s);
  makeButton.Enabled := True;
  fileSymRadio.Enabled := True;
  dirSymLink.Enabled := True;
  hardRadio.Enabled := True;
  juncRadio.Enabled := True;
  makeButton.Enabled := True;
  linkText.Enabled := True;
  targetPathText.Enabled := True;
end;

procedure TForm1.dirDiagClose(Sender: TObject);
begin
  targetPathText.Caption := dirDiag.FileName;
  checkRadio();
end;

procedure TForm1.dirSymLinkChange(Sender: TObject);
begin
  checkRadio();
  targetPathText.Caption := '';
end;

procedure TForm1.fileDiagClose(Sender: TObject);
begin
  targetPathText.Caption := fileDiag.FileName;
  checkRadio();
end;

procedure TForm1.fileSymRadioChange(Sender: TObject);
begin
  checkRadio();
  targetPathText.Caption := '';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  targetType := '';
  targetPath := '';
  s := '';
  key := '';
  linkName := '';
  targetText.Caption := targetText.Caption + 'NONE';
end;

procedure TForm1.hardRadioChange(Sender: TObject);
begin
  checkRadio();
  targetPathText.Caption := '';
end;

end.

unit uCadastro_Usuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uForm_Padrao, Data.DB, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList, System.Actions, Vcl.ActnList, Vcl.Menus,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Mask,
  Vcl.DBCtrls;

type
  TFrm_Cadastro_Usuario = class(TFrm_Padrao)
    dbe_Nome: TDBEdit;
    dbe_sobreNome: TDBEdit;
    dbe_Data_Nascimento: TDBEdit;
    dbe_Login: TDBEdit;
    dbe_Senha: TDBEdit;
    lb_Nome: TLabel;
    lb_SobreNome: TLabel;
    lb_Data_Nascimento: TLabel;
    lb_Login: TLabel;
    lb_Senha: TLabel;
    procedure actSalvarExecute(Sender: TObject);
    procedure actDeletarExecute(Sender: TObject);
    procedure btn_FiltarClick(Sender: TObject);
    procedure sbtn_FiltrarClick(Sender: TObject);
  private
    { Private declarations }
    Procedure ContaRegistro;
  public
    { Public declarations }
  end;

var
  Frm_Cadastro_Usuario: TFrm_Cadastro_Usuario;

implementation

{$R *.dfm}

uses uDM, uFuncoes;



{ TFrm_Cadastro_Usuario }
//----------------------Procedure-----------------------------------------------


procedure TFrm_Cadastro_Usuario.ContaRegistro;
begin
 if DM.FT_tbUsuario.RecordCount = 0 then
     begin
       lb_Nregistro.Visible := True;
       lb_Nregistro.Caption :='';
       lb_Nregistro.Caption := 'Nenhum Registro Encontrado';
       Sbtn_Imprimir.Enabled := False;

     end;

     if DM.FT_tbUsuario.RecordCount = 1 then
     Begin
       lb_Nregistro.Visible := True;
       lb_Nregistro.Caption :='';
       lb_Nregistro.Caption := IntToStr(DM.FT_tbUsuario.RecordCount) +' '+ 'Registro Encontrado ';
       SBtn_Imprimir.Enabled := True;
     End;

     if DM.FT_tbUsuario.RecordCount >1 then
     Begin
       lb_Nregistro.Visible := True;
       lb_Nregistro.Caption :='';
       lb_Nregistro.Caption := IntToStr(DM.FT_tbUsuario.RecordCount) +' '+ 'Registros Encontrados ';
       Sbtn_Imprimir.Enabled := True;
     End;

end;
procedure TFrm_Cadastro_Usuario.sbtn_FiltrarClick(Sender: TObject);
begin
  inherited;
  //Configura��o Bot�o Pesquisar
  With DM.FQ_tbUsuario do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Select * From tb_usuario');

    case rdg_Selecionar.ItemIndex of
      0: //Nome
      begin
        SQL.Add('where Nome Like :Nome');
        ParamByName('Nome').Value := '%'+ edt_Filtrar.Text + '%';
      end;
        1: //SobreNome
        begin
          SQL.Add('where SobreNome =:SobreNome');
          ParamByName('SobreNome').Value := edt_Filtrar.Text;
        end;
          2: //Login
          Begin
            SQL.Add('where Login =:Login');
            ParamByName('Login').Value := edt_Filtrar.Text;
          End;
    end;

     Open;

     ContaRegistro;
  End;
end;

//********************Close Procedure*******************************************

//----------------------Events Button-------------------------------------------
procedure TFrm_Cadastro_Usuario.actDeletarExecute(Sender: TObject);
begin
  inherited;
  ContaRegistro;
end;

procedure TFrm_Cadastro_Usuario.actSalvarExecute(Sender: TObject);
begin
  //Configura��o Bot�o Excute Salvar

 //Configura��o Verifica se o campo Nome est� Vazio.
 if Trim(dbe_Nome.Text) = '' then
  Begin
    Application.MessageBox('Preencha o Campo Nome', 'Aviso', MB_OK+MB_ICONWARNING);
    dbe_Nome.SetFocus;
    Abort;
  End;

  //Configura��o Verifica se o campo SobreNome est� Vazio.
  if Trim(dbe_SobreNome.Text) = '' then
  Begin
    Application.MessageBox('Preencha o Campo SobreNome', 'Aviso', MB_OK+MB_ICONWARNING);
   dbe_SobreNome.SetFocus;
   Abort;
  End;

  //Configura��o Verifica se o campo SobreNome est� Vazio.
  if Trim(dbe_Data_Nascimento.Text) = '' then
  Begin
    Application.MessageBox('Preencha o Campo SobreNome', 'Aviso', MB_OK+MB_ICONWARNING);
   dbe_Data_Nascimento.SetFocus;
   Abort;
  End;

 { //Fun��o para Verificar se J� existe o Login Cadastrado.
  If (DS_TB.State in [dsInsert]) and (GetVerifCadastroDuplicado(Trim(Edt_Login.Text))) then
  begin
     Application.MessageBox('Login j� Cadastrado, por favor escolha Outro!!', 'Aviso', MB_OK+MB_ICONWARNING);
     Edt_Login.Setfocus;
     Abort;
  end; }

  //Configura��o Verifica se o campo Login est� Vazio.
  if Trim(dbe_Login.Text) = '' then
  Begin
    Application.MessageBox('Preencha o Campo Login', 'Aviso', MB_OK+MB_ICONWARNING);
    dbe_Login.SetFocus;
    Abort;
  End;
  //Verifica se campo senha est� vazio.
  if Trim(dbe_Senha.Text) = '' then
  Begin
    Application.MessageBox('Preencha o Campo Senha', 'Aviso', MB_OK+MB_ICONWARNING);
    dbe_Senha.SetFocus;
    Abort;
  End;

  DM.FT_tbUsuarioStatus.AsString :='A';
  DM.FT_tbUsuarioData_Cadastro.AsDateTime := Now;
  DM.FT_tbUsuarioHora_Cadastro.AsDateTime := Now;

  inherited;
end;
procedure TFrm_Cadastro_Usuario.btn_FiltarClick(Sender: TObject);
begin
  inherited;

end;

//********************Close Events Button***************************************






end.
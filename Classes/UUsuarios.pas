unit UUsuarios;

interface

 Type
  TUsuario = Class

  Private

  Flogin : String;
  FSenha : String;

  Public

  property Login: String read FLogin write Flogin;
  property Senha: String read FSenha write FSenha;
  Function Logar: Boolean;

  end;

 implementation

uses
  Data.SqlExpr, ModConexao, UCad_Contas_Banco, UCad_Usuarios, UForm_Padrao,
  UFuncoes, UGetConexao, ULogin, UTela_Inicial;

   Function TUsuario.Logar: Boolean;
   Begin
     with TSqlQuery.Create(nil) do
     Try
       SQLConnection := DM.SQLConnection;
       SQLConnection.Close;
       Sql.Add('SELECT ID FROM TB_USER WHERE LOGIN = :LOGIN AND SENHA = :SENHA');
       Params[0].AsString := FLogin;
       Params[1].AsString := FSenha;
       Open;
       Result := Fields[0].AsInteger > 0;
     Finally
       Close;
       Free;
     End;
   End;



end.

unit USQL;

interface

uses Data.SqlExpr, System.Classes;

  type  TSql = class(TSQlQuery)

  public
  constructor Create(Aowner : TComponent); override;
end;

implementation

 { TSql }

uses UGetConexao, ModConexao, UCad_Contas_Banco, UCad_Usuarios, UForm_Padrao,
  UFuncoes, ULogin, UTela_Inicial, UUsuarios;

constructor TSql.Create(Aowner: TComponent);
begin
  inherited;
  SQLConnection := TGetConexao.Conexao;
end;

end.

unit USQL;

interface

uses Data.SqlExpr, System.Classes;

  type  TSql = class(TSQlQuery)

  public
  constructor Create(Aowner : TComponent); override;
end;

implementation

 { TSql }




constructor TSql.Create(Aowner: TComponent);
begin
  inherited;
  SQLConnection := TGetConexao.Conexao;
end;

end.
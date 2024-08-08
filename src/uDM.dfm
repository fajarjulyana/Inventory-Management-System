object DataModule1: TDataModule1
  Height = 201
  Width = 389
  PixelsPerInch = 96
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=SQLite'
      'Database=inventorydb.db3')
    LoginPrompt = False
    BeforeConnect = FDConnection1BeforeConnect
    Left = 64
    Top = 48
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'Select * From users')
    Left = 64
    Top = 120
  end
end

let
    Source = Csv.Document(File.Contents(pDataFolder & "customers.csv"),
        [Delimiter=",", Columns=11, Encoding=1252, QuoteStyle=QuoteStyle.Csv]),
    Headers = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    Rename = Table.RenameColumns(Headers, {{"fisrt_name", "first_name"}}),
    Dates = Table.TransformColumnTypes(Rename,
        {{"date_of_birth", type date}, {"join_date", type date}}, "en-GB"),
    Income = Table.TransformColumnTypes(Dates,
        {{"annual_income", Currency.Type}}, "en-US"),
    Name = Table.AddColumn(Income, "Customer_name",
        each Text.Trim([first_name] & " " & [second_name]), type text)
in
    Name
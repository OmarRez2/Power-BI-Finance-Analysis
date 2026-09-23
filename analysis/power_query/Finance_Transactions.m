let
    Source = Csv.Document(
        File.Contents(pDataFolder & "finance_transactions.csv"),
        [Delimiter=",", Columns=15, Encoding=1252,
         QuoteStyle=QuoteStyle.Csv]),
    Headers = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    Blanks = Table.ReplaceValue(Headers, "", null,
        Replacer.ReplaceValue, {"fee_amount"}),
    Dates = Table.TransformColumnTypes(Blanks,
        {{"transaction_date", type date}}, "en-GB"),
    Numbers = Table.TransformColumnTypes(Dates,
        {{"amount", Currency.Type}, {"fee_amount", Currency.Type},
         {"tax_amount", Currency.Type}, {"risk_score", Int64.Type}}, "en-US"),
    ExactDistinct = Table.Distinct(Numbers),
    // Course decision for the single inspected conflict only.
    Resolved = Table.SelectRows(ExactDistinct,
        each not ([transaction_id] = "T00000009" and [fee_amount] = null)),
    ChannelTrim = Table.TransformColumns(Resolved,
        {{"channel", each Text.Trim(Text.Clean(_)), type text}}),
    ChannelFix = Table.ReplaceValue(ChannelTrim,
        "M@bile App", "Mobile App", Replacer.ReplaceValue, {"channel"}),
    CurrencyCase = Table.TransformColumns(ChannelFix,
        {{"currency", Text.Upper, type text}}),
    NegativeFlag = Table.AddColumn(CurrencyCase, "IsNegativeAmount",
        each [amount] < 0, type logical),
    FeeFlag = Table.AddColumn(NegativeFlag, "Fee Missing",
        each [fee_amount] = null, type logical)
in
    FeeFlag
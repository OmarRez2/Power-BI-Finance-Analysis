let
    Joined = Table.NestedJoin(finance_transactions, {"customer_id"},
        customers, {"customer_id"}, "Customer", JoinKind.LeftOuter),
    Expanded = Table.ExpandTableColumn(Joined, "Customer",
        {"join_date"}, {"join_date"}),
    Flag = Table.AddColumn(Expanded, "Before Join",
        each [transaction_date] < [join_date], type logical)
in
    Flag
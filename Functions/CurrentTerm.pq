let
    Source = () =>
        let
            Source = Sql.Database("IAAS-INSTANTID\CARDS", "DATA"),
            dbo_IR_STRM_TBL = Source{[Schema = "dbo", Item = "IR_STRM_TBL"]}[Data],
            #"Filtered Rows" = Table.SelectRows(dbo_IR_STRM_TBL, each ([ACAD_CAREER] = "CRED")),
            #"Filtered Rows1" = Table.SelectRows(
                #"Filtered Rows",
                each [TERM_BEGIN_DT] < DateTime.FixedLocalNow() and [TERM_END_DT] > DateTime.FixedLocalNow()
            ),
            #"Removed Other Columns" = Table.SelectColumns(#"Filtered Rows1", {"STRM"}),
            STRM1 = #"Removed Other Columns"{0}[STRM]
        in
            STRM1
in
    Source

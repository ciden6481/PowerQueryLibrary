let
    Source = Sql.Database("IAAS-INSTANTID\CARDS", "DATA"),
    dbo_IR_STUDENT = Source{[Schema="dbo",Item="IR_STUDENT"]}[Data],
    #"Inserted Merged Column" = Table.AddColumn(dbo_IR_STUDENT, "emplid-strm", each Text.Combine({[EMPLID], [STRM]}, "-"), type text),
    #"Added Custom" = #!"Table.AddColumn(#""Inserted Merged Column"", ""Custom"", each Number.FromText(Text.Combine({[EMPLID],[STRM]})), type int64 )",
    #"Removed Columns" = Table.RemoveColumns(#"Added Custom",{"RUNDATE", "NATIONAL_ID", "DRIVERS_LIC_NBR", "VX_IR_DR_LIC_STATE", "VX_IR_VA_COLLG_ID", "VX_IR_VA_ST_TST_ID", "VX_IR_FA_ACAD_PLAN", "VX_IR_INIT_PROG", "ATP_CD", "ADMIT_TYPE", "EXT_GPA", "BIRTHCOUNTRY", "VISA_PERMIT_TYPE", "TUITION_RES", "TUITION_EXCPT", "MILITARY_STATUS", "VX_HIGHEST_EDU", "VX_HIGHEST_EDU_1", "FERPA", "TERM_BEGIN_DT", "TERM_END_DT", "CENSUS_DT", "UNT_TRNSFR", "FA_LOAD", "FA_STATUS_CODE_14", "VX_FA_ACTIVITY", "VX_PROGPLAN_ISSUES", "VX_XDUL_ATTRIBUTE", "VX_IR_GREAT_EXP", "VX_IR_XSSC", "STDNT_CAR_NBR"})
in
    #"Removed Columns"
let
    // Define the getYearList function to generate a list of years
    getYearList = (startYear as number, endYear as number) =>
    let
        yearCount = endYear - startYear + 1,
        yearsList = List.Numbers(startYear, yearCount)
    in
        yearsList,

    // Define the getFTE function that takes startYear and endYear as inputs
    getFTE = (startYear as number, endYear as number) =>
    let
        // Call getYearList to generate the list of years
        yearList = getYearList(startYear, endYear),
        
        // Iterate over the list of years and fetch data for each year, assigning custom names
        queriesList = List.Transform(yearList, (year) =>
            let
                // Fetch the data for the given year
                Source = Json.Document(Web.Contents("https://educationdata.urban.org/api/v1/college-university/ipeds/enrollment-full-time-equivalent/" & Text.From(year) & "/1/?unitid=232575")),
                results = Source[results],
                results1 = results{0},
                
                // Convert to table
                ConvertedToTable = Record.ToTable(results1),
                
                // Pivot columns and assign a meaningful name (for example, using the year)
                PivotedTable = Table.Pivot(ConvertedToTable, List.Distinct(ConvertedToTable[Name]), "Name", "Value", List.Sum),

                // Assign a custom name to the result for each year
                NamedTable = PivotedTable
            in
                NamedTable
        ),

        // Combine all the tables into one
        combinedTable = Table.Combine(queriesList)
    in
        combinedTable
in
    getFTE
# Pegar o diretório atual
$scriptDirectory= Split-Path $MyInvocation.MyCommand.Definition -Parent

# Arquivo de saída com todos os SQL
$outputfile = Join-Path -Path $scriptDirectory -ChildPath "migration.sql"

# verifica se o arquivo já existe, e se existir deleta-o
if (Test-Path $outputFile){
    Remove-Item $outputFile
}

# Pega conteúdo dos arquivos
$sqlFiles = Get=Childitem -Path $scriptDirectory -Filter *.sql -File | Sort-Object Name

# Concatena Arquivos
foreach($file in $sqlFiles){
    Get-Content $file.FullName | Out-File -Append -FilePath $outputFile
    "GO" | Out-File -Append -FilePath $outputFile
}

Write-Host "Todos os arquivos foram combinados em $OutputFile"
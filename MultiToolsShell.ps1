# MultiToolsShell.ps1
# Ferramenta Multi Tools Shell v2.0 - PowerShell
# Criado por: Mandraquinho - By Douglas Furlan
# Data: 29/08/2025

function Show-Credits {
    Clear-Host
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host "             MultiTools Shell v2.0" -ForegroundColor Cyan
    Write-Host "             Criado por: Mandraquinho" -ForegroundColor Cyan
    Write-Host "               By Douglas Furlan" -ForegroundColor Cyan
    Write-Host "        Data: $(Get-Date -Format 'dd/MM/yyyy')" -ForegroundColor Cyan
    Write-Host "================================================`n" -ForegroundColor Cyan
    Start-Sleep -Seconds 2
}

function Get-PublicIPAndGeo {
    try {
        $response = Invoke-RestMethod -Uri "https://ipinfo.io/json" -ErrorAction Stop
        return @{
            PublicIP = $response.ip
            Location = $response.city + ", " + $response.region + ", " + $response.country
        }
    } catch {
        return @{ PublicIP = "Não disponível"; Location = "Não disponível" }
    }
}

function Show-SystemStatus {
    Clear-Host
    Write-Host "==================== STATUS DO SISTEMA ====================" -ForegroundColor Cyan
    Write-Host "Computador : $env:COMPUTERNAME"
    Write-Host "Usuário    : $env:USERNAME"
    
    $ipLocal = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object {
        $_.IPAddress -notlike '169.*' -and $_.IPAddress -ne '127.0.0.1'
    } | Select-Object -First 1 -ExpandProperty IPAddress)
    if (-not $ipLocal) { $ipLocal = "Não disponível" }
    Write-Host "IP Local   : $ipLocal"

    $publicInfo = Get-PublicIPAndGeo
    Write-Host "IP Público : $($publicInfo.PublicIP)"
    Write-Host "Geo Local  : $($publicInfo.Location)"

    Write-Host "Sistema    : $((Get-CimInstance Win32_OperatingSystem).Caption)"
    $ramFreeMB = [math]::Round(((Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory / 1KB),2)
    Write-Host "RAM Livre  : $ramFreeMB MB"

    $disk = Get-PSDrive C
    $freeGB = [math]::Round(($disk.Free/1GB),2)
    $totalGB = [math]::Round(($disk.Used + $disk.Free)/1GB,2)
    Write-Host "Disco C:   $freeGB GB livres / $totalGB GB total"

    Write-Host "Data/Hora  : $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')"
    Write-Host "=============================================================`n"
}

function Show-Menu {
    Write-Host "===================== MENU PRINCIPAL =======================" -ForegroundColor Green
    Write-Host "[R] Rede e Conectividade"
    Write-Host "[S] Sistema e Hardware"
    Write-Host "[U] Usuários e Segurança"
    Write-Host "[M] Monitoramento e Logs"
    Write-Host "[O] Otimização e Performance"
    Write-Host "[A] Assistente de Diagnóstico"
    Write-Host "[H] Ajuda e Documentação"
    Write-Host "[X] Sair"
    Write-Host "=============================================================`n"
    Write-Host "Digite a letra da categoria desejada:" -NoNewline
}

# ================== MÓDULOS ==================

function Rede-Conectividade {
    Clear-Host
    Write-Host "=== Rede e Conectividade ===`n" -ForegroundColor Yellow
    Write-Host "1. Mostrar Configuração IP"
    Write-Host "2. Testar Conectividade (Ping google.com)"
    Write-Host "3. Rastrear rota (Tracert google.com)"
    Write-Host "4. Redefinir TCP/IP"
    Write-Host "5. Redefinir Winsock"
    Write-Host "6. Limpar Cache DNS"
    Write-Host "7. Listar Adaptadores de Rede"
    Write-Host "0. Voltar"
    Write-Host "`nEscolha uma opção:" -NoNewline

    $input = Read-Host
    switch ($input) {
        '1' { ipconfig /all; Pause; Rede-Conectividade }
        '2' { Test-Connection google.com -Count 4; Pause; Rede-Conectividade }
        '3' { tracert google.com; Pause; Rede-Conectividade }
        '4' { netsh int ip reset; Write-Host "`nReinicie o computador."; Pause; Rede-Conectividade }
        '5' { netsh winsock reset; Write-Host "`nReinicie o computador."; Pause; Rede-Conectividade }
        '6' { ipconfig /flushdns; Write-Host "`nCache DNS limpo."; Pause; Rede-Conectividade }
        '7' { Get-NetAdapter | Format-Table Name, Status, MacAddress; Pause; Rede-Conectividade }
        '0' { return }
        default { Write-Host "Opção inválida!" -ForegroundColor Red; Start-Sleep -Seconds 1.5; Rede-Conectividade }
    }
}

function Sistema-Hardware {
    Clear-Host
    Write-Host "=== Sistema e Hardware ===`n" -ForegroundColor Yellow
    Write-Host "SO: $((Get-CimInstance Win32_OperatingSystem).Caption)"
    Write-Host "Versão: $((Get-CimInstance Win32_OperatingSystem).Version)"
    Write-Host "Processador: $((Get-CimInstance Win32_Processor).Name)"
    $memTotalMB = [math]::Round(((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1MB),2)
    Write-Host "Memória Total (MB): $memTotalMB"
    $freeDiskGB = [math]::Round((Get-PSDrive C).Free/1GB,2)
    Write-Host "Espaço livre em C: $freeDiskGB GB"
    Pause
}

function Usuarios-Seguranca {
    Clear-Host
    Write-Host "=== Usuários e Segurança ===`n" -ForegroundColor Yellow
    Get-LocalUser | Format-Table Name, Enabled, LastLogon
    Pause
}

function Monitoramento-Logs {
    Clear-Host
    Write-Host "=== Monitoramento e Logs ===`n" -ForegroundColor Yellow
    Write-Host "Últimos eventos do sistema:`n"
    Get-EventLog -LogName System -Newest 10 | Format-Table TimeGenerated, EntryType, Source, Message -AutoSize
    Pause
}

function Otimizacao-Performance {
    Clear-Host
    Write-Host "=== Otimização e Performance ===`n" -ForegroundColor Yellow
    Write-Host "1. Limpar arquivos temporários"
    Write-Host "2. Limpar cache navegador (Edge/Chrome)"
    Write-Host "3. Listar programas na inicialização"
    Write-Host "0. Voltar"
    $opt = Read-Host
    switch ($opt) {
        '1' {
            $paths = @("$env:TEMP\*", "$env:SystemRoot\Prefetch\*")
            foreach ($p in $paths) { Remove-Item -Path $p -Recurse -Force -ErrorAction SilentlyContinue }
            Write-Host "Arquivos temporários limpos."; Pause; Otimizacao-Performance
        }
        '2' {
            $chromeCache = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache\*"
            $edgeCache = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache\*"
            Remove-Item $chromeCache,$edgeCache -Recurse -Force -ErrorAction SilentlyContinue
            Write-Host "Cache do Chrome/Edge limpo."; Pause; Otimizacao-Performance
        }
        '3' {
            Get-CimInstance Win32_StartupCommand | Select-Object Name, Command, Location | Format-Table -AutoSize
            Pause; Otimizacao-Performance
        }
        '0' { return }
        default { Write-Host "Opção inválida!"; Start-Sleep 1; Otimizacao-Performance }
    }
}

function Assistente-Diagnostico {
    Clear-Host
    Write-Host "=== Assistente de Diagnóstico ===`n" -ForegroundColor Yellow
    Write-Host "1. Verificar Disco (CHKDSK)"
    Write-Host "2. Verificar Arquivos do Sistema (SFC)"
    Write-Host "3. Diagnóstico de Memória"
    Write-Host "4. Verificar Integridade da Imagem (DISM)"
    Write-Host "5. Otimizar Disco (Desfragmentar/Trim)"
    Write-Host "6. Testar Velocidade do Disco (WinSAT)"
    Write-Host "7. Relatório de Energia"
    Write-Host "8. Logs de Aplicativos"
    Write-Host "9. Status Licença do Windows"
    Write-Host "0. Voltar"
    $opt = Read-Host
    switch ($opt) {
        '1' { chkdsk C: /f; Pause; Assistente-Diagnostico }
        '2' { sfc /scannow; Pause; Assistente-Diagnostico }
        '3' { mdsched; Pause; Assistente-Diagnostico }
        '4' { DISM /Online /Cleanup-Image /ScanHealth; Pause; Assistente-Diagnostico }
        '5' {
            $ssd = $false
            try {
                $diskNumber = (Get-Partition -DriveLetter C).DiskNumber
                $mediaType = (Get-PhysicalDisk | Where-Object { $_.DeviceID -eq $diskNumber }).MediaType
                if ($mediaType -eq 'SSD') { $ssd = $true }
            } catch {}
            if ($ssd) {
                Write-Host "`nO disco C: é um SSD. Executando TRIM (Optimize-Volume)..." -ForegroundColor Cyan
                Optimize-Volume -DriveLetter C -ReTrim -Verbose
            } else {
                Write-Host "`nExecutando desfragmentação..." -ForegroundColor Yellow
                defrag C:
            }
            Pause; Assistente-Diagnostico
        }
        '6' { winsat disk; Pause; Assistente-Diagnostico }
        '7' { powercfg /energy; Write-Host "Relatório gerado em C:\Windows\System32\energy-report.html"; Pause; Assistente-Diagnostico }
        '8' { Get-EventLog -LogName Application -Newest 10 | Format-Table TimeGenerated, EntryType, Source, Message -AutoSize; Pause; Assistente-Diagnostico }
        '9' { slmgr /xpr; Pause; Assistente-Diagnostico }
        '0' { return }
        default { Write-Host "Opção inválida!"; Start-Sleep 1; Assistente-Diagnostico }
    }
}

function Show-Help {
    Clear-Host
    Write-Host "=== Ajuda e Documentação ===`n" -ForegroundColor Yellow
    Write-Host "Use as letras indicadas para navegar entre as categorias."
    Write-Host "Exemplo: Digite 'R' para Rede e Conectividade."
    Write-Host "Pressione X para sair."
    Pause
}

function Pause {
    Write-Host "`nPressione Enter para continuar..." -NoNewline
    [void][System.Console]::ReadKey($true)
}

# ================== LOOP PRINCIPAL ==================
Show-Credits

while ($true) {
    Show-SystemStatus
    Show-Menu
    $choice = Read-Host
    $choice = $choice.Trim().ToUpper()
    if ($choice -eq 'X') { break }
    switch ($choice) {
        'R' { Rede-Conectividade }
        'S' { Sistema-Hardware }
        'U' { Usuarios-Seguranca }
        'M' { Monitoramento-Logs }
        'O' { Otimizacao-Performance }
        'A' { Assistente-Diagnostico }
        'H' { Show-Help }
        default { Write-Host "Opção inválida!"; Start-Sleep 2 }
    }
}
Write-Host "`nSaindo do programa. Até mais!" -ForegroundColor Green

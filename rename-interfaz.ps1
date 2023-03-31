# Verificar si el usuario tiene permisos de administrador
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Debes ejecutar este script con permisos de administrador."
    exit
}

# Listar las interfaces de red
Write-Host "Interfaces de red disponibles:"
$interfaces = Get-NetAdapter | Select-Object @{Name='Opción'; Expression={($_.ifIndex)}}, @{Name='Nombre'; Expression={$_.Name}}, @{Name='Descripción'; Expression={$_.InterfaceDescription}}
$interfaces | Format-Table

# Elegir una interfaz para renombrar
$interfaceIndex = Read-Host -Prompt 'Ingresa el índice de la interfaz que deseas renombrar (ejemplo: 1)'
$interface = $interfaces | Where-Object {$_.Opción -eq $interfaceIndex}
$newName = Read-Host -Prompt 'Ingresa el nuevo nombre para la interfaz'

# Renombrar la interfaz
Rename-NetAdapter -Name $interface.Nombre -NewName $newName
Write-Host "La interfaz ha sido renombrada exitosamente."

# Volver a listar las interfaces de red
Write-Host "Interfaces de red disponibles:"
$interfaces = Get-NetAdapter | Select-Object @{Name='Opción'; Expression={($_.ifIndex)}}, @{Name='Nombre'; Expression={$_.Name}}, @{Name='Descripción'; Expression={$_.InterfaceDescription}}
$interfaces | Format-Table
$port = 5986  # Puerto predeterminado para WinRM (puedes cambiarlo al puerto que necesites)

# Comprueba si el puerto está habilitado
$portTest = Test-NetConnection -ComputerName localhost -Port $port

if ($portTest.TcpTestSucceeded) {
    Write-Host "El puerto $port está habilitado..No se realizará la configuración de Ansible."
    

}
else {
    Write-Host "El puerto $port no está habilitado.  Continuando con la configuración de Ansible"
    # Definir la URL del script de configuración y el nombre del archivo de salida
    $url = "https://github.com/rickpss/script_to_ansible_on_windows_connection/raw/master/ConfigureRemotingForAnsible.ps1"
    $outfile = "ConfigureRemotingForAnsible.ps1"

    # Descargar el script de configuración
    Invoke-WebRequest -Uri $url -OutFile $outfile

    # Establecer la política de ejecución para permitir la ejecución del script
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

    # Ejecutar el script de configuración de Ansible
    & .\ConfigureRemotingForAnsible.ps1

    # Enumerar los listeners de WinRM para verificar que están configurados correctamente
    winrm enumerate winrm/config/listener

}

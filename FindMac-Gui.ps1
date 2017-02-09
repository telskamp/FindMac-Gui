#Searches for a mac address in all scopes on the specified dhcp server
 
$dhcpsrv = "your-dhcp-server.yourdomain.com"
Function get-mac {
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
 
$form = New-Object System.Windows.Forms.Form
$form.Text = "Find Mac address"
$form.Size = New-Object System.Drawing.Size(300,200)
$form.StartPosition = "CenterScreen"
 
$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(75,120)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "OK"
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)
 
$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(150,120)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = "Cancel"
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)
 
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = "Enter Mac-Address:"
$form.Controls.Add($label)
 
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,40)
$textBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($textBox)
 
$form.Topmost = $True
 
$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()
 
if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $x = $textBox.Text
 
}
 
$clean = $x -replace '[^a-zA-Z0-9]', ''
 
get-dhcpServerv4Scope -cn $dhcpsrv |Get-dhcpserverv4lease -Cn $dhcpsrv -ClientId $clean -ErrorAction SilentlyContinue |Out-GridView
 
 
$rerun = Read-Host "Want to find more? (y/n)?"
 
    if($rerun -eq "y") {get-mac}
 
 
}
get-mac
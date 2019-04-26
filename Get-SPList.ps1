#
# Get-SPList
#
# returns the contents of the given list from a specified site root in JSON format
#
function Get-SPList {
    param ([string]$site_root, [string]$list_name)
    
    $web_session = new-object Microsoft.PowerShell.Commands.WebRequestSession
    $web_session.Headers.Add("Accept", "application/json;odata=verbose")
    $api_url = "$site_root" + "_api/web/lists/getByTitle('$list_name')/items"
    $web_request = Invoke-WebRequest -uri $api_url -Method Get -WebSession $web_session -UseDefaultCredentials
    $json_data = $web_request.Content.ToString().Replace("ID","_ID") | ConvertFrom-Json
    $json_data.d.results
}


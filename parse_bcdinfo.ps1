$template = @'
{[string]Title:Windows Boot Something}
{[string]identifier:someproperty},{[string]Value:Some-value}
{[string]Property:someproperty},{[string]Value:Some-value}
'@
# device                  
# path                   
# description             
# locale                  
# inherit                 
# recoverysequence        
# displaymessageoverride  
# recoveryenabled         
# isolatedcontext         
# flightsigning
# default           
# allowedinmemorysettings
# osdevice               
# systemroot              
# resumeobject
# displayorder 
# toolsdisplayorder
# timeout     
# nx                      
# bootmenupolicy          
# hypervisorlaunchtype   

$convert_test = (bcdedit.exe /enum) -replace '^\s','~' | ConvertFrom-String -TemplateContent $template
$convert_test


 


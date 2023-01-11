param(
	[Parameter(Position=0)][string]$run,
    [Parameter(Position=1)][string]$1,
    [Parameter(Position=2)][string]$2,
    [Parameter(Position=3,ValueFromRemainingArguments=$true)][string[]]$3
)

$query = "$1 $2 $3"

$Aliases = @{

<# -------------------------------- USER EDITING STARTS HERE --------------------------------------------------------

    Add your own shortcuts!
       
        -  al = a shortened version of your desired shortcut alias (recommend 2 letters)
        -  alias = your desired shortcut alias
        -  args = if your shortcut can be launched with parameters (e.g. query on youtube)
    
    Call your shortcuts in Run, with `s <al/alias> <args>`
    (e.g. `s gl how to tie a tie`)

----------------------------------------------------------------------------------------------------------------------

    ! LINK/PATH                                                    ! ALIASES

    "<link/path>"                                                  = @('<al>'   ,'<alias>') : regular syntax
    "https://www.google.com"                                       = @('gl'     ,'google')  : web address shortcut
    "C:\Program Files\Mozilla Firefox\firefox.exe"                 = @('fi'     ,'firefox') : app shortcut (file only if added to PATH)

#>

    <#  CLASSROOMS  #>       # add your google classrooms below

    "https://classsroom.google.com"                                = @('cl'     ,'classroom')


    <#  GSUITE  #>
 
    "https://docs.google.com/document/u/0/?tgif=d&q=$query"        = @('do'     ,'docs')
    "https://docs.google.com/presentation/u/0/?tgif=d&q=$query"    = @('sl'     ,'slides')
    "https://docs.google.com/spreadsheets/u/0/?tgif=d&q=$query"    = @('sh'     ,'sheets')
    "https://sites.google.com/new?tgif=d&q=$query"                 = @('si'     ,'sites')

    <#  MISC  #>
    
    "https://suzannecoryhs-vic.compass.education/"                 = @('co'     ,'compass')
    "https://www.google.com/search?q=$query"                       = @('g'      ,'google')
    "https://github.com/search?q=$query"                           = @('gh'     ,'github')
    "https://www.amazon.com.au/s?k=$query"                         = @('amz'    ,'amazonAU')

    <#  SOCIAL MEDIA  #>

    "https://www.pinterest.com.au/search/pins/?q=$query"           = @('pin'    ,'pinterest')
    "https://twitter.com/search?q=$query"                          = @('tw'     ,'twitter')
    "https://www.youtube.com/results?search_query=$query"          = @('yt'     ,'youtube')
    
    <#  SYSTEM  #>

    "taskmgr"                                                      = @('tm'     ,'taskManager')
    "control"                                                      = @('ct'     ,'controlPanel')
    "powershell"                                                   = @('wt'     ,'powershell')
    "shutdown.exe /p /f"                                           = @('off'    ,'powerOff')
    "shutdown.exe /r /t 0"                                         = @('rst'    ,'restart')
    "shutdown.exe /o /r /t 0"                                      = @('abo'    ,'advancedBoot')
}
    <#  TOOLS/SCOOP APPS  #>   

    $everything_alias                                              =   'ev'        # search for any file/folder on your desktop (e.g. `s ev <query>`)
    $ytdownloader_alias                                            =   'ytdl'      # simple youtube downloader as mp4 or mp3 (e.g. `s ytdl mp4 <output name> <url>`)
    $translate_alias                                               =   'tr'        # translate with deepL (e.g. `s tr <langfrom> <langto> <query>)

<#--------------------------------- USER EDITING STOPS HERE ----------------------------------------------------------------------------#>

if ($run -eq $translate_alias -or $run -eq "translate"){

    $langfrom = $1
    $langto = $2
    $query = $3
    start-process "https://www.deepl.com/en/translator#$langfrom/$langto/$query"
    exit
}

if ($run -eq "$ytdownloader_alias"){

    $format = $1
    $oname = $2
    $url = "$3"
    $dls = "$env:UserProfile\downloads"

    if ($format -eq "mp3"){
        yt-dlp.exe -f 'ba' -x --audio-format mp3 $url -o "$oname.mp3" -P $dls
        Start-Process $dls
        exit
    }

    if ($format -eq "mp4"){
        yt-dlp.exe -f mp4 $url -o "$oname.mp4" -P $dls
        Start-Process $dls
        exit
    }
}

if ($run -eq "$everything_alias" -or $run -eq "everything"){
    Start-Process everything.exe -ArgumentList @("-s $query")
    exit
}

Foreach($applink in $Aliases.Keys) { # Loops through the hashtable above
	if ($appstart){continue}
	if ($run -in $Aliases.$applink){
		$appstart = $applink
}
}

if ($run -eq "edit"){
    $parentdir = split-path $PSScriptRoot
    $scriptpath = "$parentdir\apps\scutl\current\scutl.ps1"
    start-process notepad.exe $scriptpath
    exit
}


<# -------------------------------------- Help -------------------------------------- #>

if (!$run){
	@"



    ,/////  ///        (((///           ,###(((             /////           
    *(((((  (((       .###(((,          ,&&&%%%,            (((((           
    *(((((  *((       /###((((.         (%&&%%%%,           (((((           
    .(((((   (((     (((((((((((.     ,(((%#%%%%%%*         (((((           
     (((((*   ((( (((((,  ((((((((((#((((   %%%%%%%%%%%     (((((           
     *(((((    (###(*       /((((#####((/     (%%%%%%%%%%%%.((((.           
      ((((((,((((((((.        /((##(((((((((      .%%%%%%%&&&&(*            
       ((((##((     ((((,   /((((   .(((((((((       .(&&&&&&&%%            
        /####((        ((((#(((        .(((((###((((((((((&%%%%%%#          
       *((##(((((        /(##((         /(#######(((/.      %%%%%%%         
      /(((. ((((((/     ((((  (((,    (((((#((((((           %%%%%%%        
     ,(((.    ((((((   /(((     ((( ((((((  ((((((           .%%%%%%        
     ((((      ((((((  (((/      ((#((((    ((((((            %%%%%%        
    .(((       .((((( ,(((        (##((.    ((((((            %%%%%%     



"@ | Write-Output
    Write-Host "   all commands are called with `s <   >`. list of commands below:   " -BackgroundColor Red -ForegroundColor white 
    @"

    - edit/open the script to add your own / remove shortcuts (edit)
    
        Apps and links

    - schs compass (co)
    - youtube downloader (ytdl <mp3/mp4> <output name> <url>)
    - search all desktop files (ev <query>)

        Launchable websites with syntax `s <name> <query>`
    
    - Google (g)
    - Youtube (yt)
    - Amazon AU (amz)
    - Github (gh)
    - G-suite (<first 2 letters of app>) e.g. do = docs, sh = sheets
    - Pinterest (pin)
    - Twitter (tw)

        Google Classrooms

    - edit the script to add your classrooms with custom shortcut names

        System
    
    - control panel (ct)
    - task manager (tm)
    - shut down (off)
    - restart (rst)
    - advanced boot (abo)

"@ | Write-Output
    Start-Sleep 2147483
    exit
}

start-process $appstart

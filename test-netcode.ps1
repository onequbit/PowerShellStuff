cls

Add-Type -AssemblyName System
Add-Type -AssemblyName System.Collections
Add-Type -AssemblyName System.Collections.Generic
Add-Type -AssemblyName System.Diagnostics
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Linq
Add-Type -AssemblyName System.ServiceProcess
Add-Type -AssemblyName System.Text
Add-Type -AssemblyName System.Threading
Add-Type -AssemblyName System.Threading.Tasks
Add-Type -AssemblyName System.Windows.Forms
Add-Type -Language CSharp -TypeDefinition @"
    // using System;
    // using System.Collections;
    // using System.Collections.Generic;
    // using System.Diagnostics;
    // using System.Drawing;
    // using System.Linq;
    // using System.ServiceProcess;
    // using System.Text;
    // using System.Threading;
    // using System.Threading.Tasks;
    // using System.Windows.Forms;

    namespace Program
    {

        public class SysTrayIcon : System.Windows.Forms.Form
        {         
            public NotifyIcon notifyIcon;
            public SysTrayIcon()
            {            
                try
                {               
                    this.notifyIcon = new NotifyIcon();                            
                    this.notifyIcon.Icon = this.GetCurrentIcon();
                    this.notifyIcon.Visible = true;                
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Constructor failed");
                }                                   
            }

            public void ShowInfoBalloon(string title, string message, int timeout = 8192)
            {            
                this.notifyIcon.BalloonTipIcon = ToolTipIcon.Info;
                this.notifyIcon.BalloonTipTitle = title;               
                this.notifyIcon.BalloonTipText = message;
                this.notifyIcon.ShowBalloonTip(timeout);
            }
        }
    }
"@


$icon = New-Object -TypeName SysTrayIcon

$icon


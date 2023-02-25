

$code = @"
using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Runtime.InteropServices;    

public static class Kernel32
{        
    [DllImport("kernel32", SetLastError=true, CharSet = CharSet.Ansi)]
        public static extern IntPtr LoadLibrary(
            [MarshalAs(UnmanagedType.LPStr)]string lpFileName);
            
    [DllImport("kernel32", CharSet=CharSet.Ansi, ExactSpelling=true, SetLastError=true)]
        public static extern IntPtr GetProcAddress(
            IntPtr hModule,
            string procName);
}
    
public static class User32
{
    [DllImport("User32.dll")]
    static extern IntPtr GetDC(IntPtr hwnd);

    [DllImport("User32.dll")]
    static extern int ReleaseDC(IntPtr hwnd, IntPtr dc);        
}

public static class Program
{
    static void Main()
    {            
        IntPtr desktop = User32.GetDC(IntPtr.Zero);
        using (Graphics g = Graphics.FromHdc(desktop)) {
            g.FillRectangle(Brushes.Red, 0, 0, 100, 100);
        }
        User32.ReleaseDC(IntPtr.Zero, desktop);        
    }
}

"@

# $Forms = [reflection.assembly]::LoadWithPartialName( "System.Windows.Forms")
# [reflection.assembly]::Assembly.Load( "System.Drawing")

Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Drawing.Drawing2D
Add-Type -AssemblyName System.Windows.Forms
Add-Type -TypeDefinition $code  #-PassThru # -OutputAssembly $OutputAssembly -OutputType Library;

# Load the .NET Assembly 
#[System.Reflection.Assembly]::LoadFile($OutputAssembly);


#$User32Handle = [Kernel32]::LoadLibrary("C:\Windows\System32\user32.dll")
# $FuncHandle = [Kernel32]::GetProcAddress($LibHandle, "LockWorkStation")
    
#    if ([System.IntPtr]::Size -eq 4) {
#        echo "`nKernel32::LoadLibrary   --> 0x$("{0:X8}" -f $LibHandle.ToInt32())"
#        echo "User32::LockWorkStation --> 0x$("{0:X8}" -f $FuncHandle.ToInt32())"
#    }
#    else {
#        echo "`nKernel32::LoadLibrary   --> 0x$("{0:X16}" -f $LibHandle.ToInt64())"
#        echo "User32::LockWorkStation --> 0x$("{0:X16}" -f $FuncHandle.ToInt64())"
#    }
     
#    echo "Locking user session..`n"
#    [User32]::CallWindowProc($FuncHandle, 0, 0, 0, 0) | Out-Null
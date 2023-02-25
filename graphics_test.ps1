[reflection.assembly]::LoadWithPartialName( "System.Windows.Forms")
[reflection.assembly]::LoadWithPartialName( "System.Drawing")

# $code = @"
# using System;
# using System.Drawing;
# using System.Drawing.Common;
# using System.Drawing.Drawing2D;
# using System.Runtime.InteropServices;

#Load the GDI+ and WinForms Assemblies

[reflection.assembly]::LoadWithPartialName( "System.Runtime.InteropServices" )
[reflection.assembly]::LoadWithPartialName( "System.Windows.Forms" )
[reflection.assembly]::LoadWithPartialName( "System.Drawing" )
[reflection.assembly]::LoadWithPartialName( "System.Drawing.Drawing2D" )

$User32Dll = [reflection.assembly]::LoadFile("User32.dll")


Add-Type -TypeDefinition @"
namespace GraphicsTest {
    class Program 
    {
        [DllImport("User32.dll")]
        static extern IntPtr GetDC(IntPtr hwnd);

        [DllImport("User32.dll")]
        static extern int ReleaseDC(IntPtr hwnd, IntPtr dc);

        static void Main(string[] args) {
            IntPtr desktop = GetDC(IntPtr.Zero);
            using (Graphics g = Graphics.FromHdc(desktop)) {
                g.FillRectangle(Brushes.Red, 0, 0, 100, 100);
            }
            ReleaseDC(IntPtr.Zero, desktop);
        }
    }
}
"@

# Add-Type -TypeDefinition $code  -Language CSharp	
[GraphicsTest.Program]::Main()


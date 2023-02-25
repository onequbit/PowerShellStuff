#Load the GDI+ and WinForms Assemblies
[reflection.assembly]::LoadWithPartialName( "System.Windows.Forms")
[reflection.assembly]::LoadWithPartialName( "System.Drawing")

# Create pen and brush objects
$myBrush = new-object Drawing.SolidBrush green
$mypen = new-object Drawing.Pen black

# Create a Rectangle object for use when drawing rectangle
$rect = new-object Drawing.Rectangle 10, 10, 180, 180

# Create a Form
$form = New-Object Windows.Forms.Form

# Get the form's graphics object
$formGraphics = $form.createGraphics()

# Define the paint handler

$form.add_paint(
    {
        $formGraphics.FillEllipse($myBrush, $rect) # draw an ellipse using rectangle object
        $mypen.color = "red" # Set the pen color
        $mypen.width = 5 # ste the pen line width
        $p1 = new-object Drawing.Point 50, 30
        $p2 = new-object Drawing.Point 0, 100
        $p3 = new-object Drawing.Point 100, 100
        $p4 = new-object Drawing.Point 80, 30
        $formGraphics.DrawBezier($mypen, $p1, $p2, $p3, $p4)
        $p1 = new-object Drawing.Point 80, 90
        $p2 = new-object Drawing.Point 0, 170
        $p3 = new-object Drawing.Point 100, 70
        $p4 = new-object Drawing.Point 70, 170
        $formGraphics.DrawBezier($mypen, $p1, $p2, $p3, $p4)
        $p1 = new-object Drawing.Point 100, 90
        $p2 = new-object Drawing.Point 50, 170
        $p3 = new-object Drawing.Point 150, 170
        $p4 = new-object Drawing.Point 130, 90
        $formGraphics.DrawLine($mypen, 170, 100, 120, 170) # draw a line
        $formGraphics.DrawLine($mypen, 150, 100, 150, 170) # draw a line
        $formGraphics.DrawBezier($mypen, $p1, $p2, $p3, $p4)
    }
)

$form.ShowDialog() # display the dialog
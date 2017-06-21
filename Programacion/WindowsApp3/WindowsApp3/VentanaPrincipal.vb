Public Class VentanaPrincipal
    Private Sub VScrollBar1_Scroll(sender As Object, e As ScrollEventArgs)

    End Sub

    Private Sub DomainUpDown1_SelectedItemChanged(sender As Object, e As EventArgs)

    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

    End Sub

    Private Sub Form1_Load(sender As Object, e As EventArgs) Handles MyBase.Load

    End Sub

    Private Sub DomainUpDown1_SelectedItemChanged_1(sender As Object, e As EventArgs)

    End Sub

    Private Sub TextBox3_TextChanged(sender As Object, e As EventArgs) Handles TextBox3.TextChanged

    End Sub

    Private Sub UsuariosToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles UsuariosToolStripMenuItem.Click
        IngresoCasa.ShowDialog()

    End Sub

    Private Sub ApartamentoToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ApartamentoToolStripMenuItem.Click
        IngresarApartamento.ShowDialog()
    End Sub

    Private Sub VehiculoToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles VehiculoToolStripMenuItem.Click
        IngresarVehiculo.ShowDialog()
    End Sub

    Private Sub CrearNuevoUsuarioToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles CrearNuevoUsuarioToolStripMenuItem.Click
        IngresoUsuario.ShowDialog()
    End Sub

    Private Sub CambiarContraseñaToolStripMenuItem_Click(sender As Object, e As EventArgs) 

    End Sub
End Class

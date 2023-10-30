<%@page import="ma.school.beans.Machine"%>
<%@page import="ma.school.service.MachineService"%>
<%@page import="ma.school.beans.Marque"%>
<%@page import="ma.school.service.MarqueService"%>
<%@page import="java.util.Date"%>
<%@page import="ma.school.beans.Etudiant"%>
<%@page import="ma.school.service.EtudiantService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="script/script.js" type="text/javascript"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="style/css.css" rel="stylesheet" type="text/css"/>
        <link href="style/csslocal.css" rel="stylesheet" type="text/css"/>
        
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <script src="script/jquery-3.3.1.min.js" type="text/javascript"></script>

    </head>
    <body>
        <%@include file="template/header.jsp" %>
        <%@include file="template/menu.jsp" %>
        <div class="modal fade" id="confirmDeleteModal" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title" id="confirmDeleteModalLabel">Confirmation de la suppression</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Êtes-vous sûr de vouloir supprimer ce produit ?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Confirmer la suppression</button>
                        <button type="button" class="btn btn-primary" data-dismiss="modal">Annuler</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="content">
            <form method="GET" action="MachineController">
                <fieldset>
                    <legend>Informations Machine</legend>
                    <table border="0">
                        <tr>
                            <td>Reference</td>
                            <td><input id="ref" type="text" name="ref" value=""  required=""/></td>
                        </tr>
                        <tr>
                            <td>Prix</td>
                            <td><input id="prix" type="text" name="prix" value="" required="" /></td>
                        </tr>
                        <tr>
                            <td>Marque</td>
                            <td>
                                <select id="marque" name="marque">
                                    <%
                                        MarqueService ms = new MarqueService();
                                        for(Marque m : ms.findAll()){
                                    %>
                                    <option value="<%=m.getId()%>"><%=m.getLibelle()%></option>
                                    <%}%>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Date Achat</td>
                            <td><input id="date" type="date" name="dateAchat" value="" required="" /></td>
                        </tr>
                        
                        <tr>
                            <td></td>
                            <td>
                                <input name="op" type="submit" value="Envoyer" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </form>
            <%
                MachineService mms = new MachineService();
            %>
            <fieldset>
                <legend>Liste des Machines</legend>

                <table border="1" class="tab">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>Reference <br>
                            
                            <th>Prix</th>
                            <th>Marque</th>
                            <th>Date d'achat</th>
                       
                            <th>Supprimer</th>
                            <th>Modifier</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Machine mm : mms.findAll()) {
                        %>
                        <tr>
                            <td><%=mm.getId()%></td>
                            <td><%=mm.getReference()%></td>
                            <td><%=mm.getPrix()%></td>
                            <td><%=mm.getMarque().getLibelle()%></td>
                            <td><%=mm.getDateAchat()%></td>
                            <td><button type="button" class="btn btn-danger" data-toggle="modal" data-target="#confirmDeleteModal" data-id="<%=mm.getId()%>">Supprimer</button></td>
                            <td><a class="bnupdate" href="">Modifier</a></td>
                        </tr>
                        <%}%>
                    </tbody>
                </table>

            </fieldset>
        </form>  
        <script>
        // Gestionnaire d'événements lorsque le bouton de suppression est cliqué
        $('button[data-toggle="modal"][data-target="#confirmDeleteModal"]').on('click', function () {
            // Récupérer l'ID du produit à supprimer à partir de l'attribut data-id
            var productId = $(this).data('id');
            // Configurer le bouton "Confirmer la suppression" dans la modal pour rediriger vers la suppression réelle
            $('#confirmDeleteBtn').on('click', function () {
                window.location.href = "MachineController?op=delete&id=" + productId;
            });
        });
    </script>
</body>
</html>

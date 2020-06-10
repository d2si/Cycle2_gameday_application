#Procedure de déploiement de l'application  

1- Cloner le Repository https://github.com/d2si/Cycle2_gameday_application.git

2- Créer un vpc avec terraform pour la création de l'ami à partir du répertoire terraform/vpc4packer

3- Lancer la création de l'ami avec packer à partir du répertoire vpc4packer

4- Lancer le déploiement de l'application avec terraform à partir du répertoire terraform/common

5- Tester l'accès à l'application à partir de l'url fournit à l'étape précédente ainsi que la fonctionnalité d'entregistrement. Dès qu'une personne est enregistrée elle doit apparaitre dans la liste des participants sur le site

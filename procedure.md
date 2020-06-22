#Procedure de déploiement de l'application

* Se connecter sur le server d'admin via SSM (url disponible en output de la stack cloudformation)
  Exécuter la procédure suivante avec le user ec2-user

## Recupération du package applicatif sur github  : https://github.com/d2si/Cycle2_gameday_application.git

## Création d'un VPC temporaire pour la création d'une ami via packer
* il faut executer terraform à partir du répertoire terraform/vpc4packer

## Lancer la création de l'ami avec packer
* il faut executer packer à partir du répertoire packer

## Lancer la création de l'infrastructure et le déploiement de l'application
* il faut executer terraform à partir du répertoire terraform/common

## Tester l'application à partir de l'url fournit en résultat du terraform apply
* il faut également tester l'enregistrement d'un nouveau participant. Si l'enregistrement a bien été effect, le nouveau participant doit s'affficher dans la section attendees après un rechargement complet de le page

su -
mariadb
create database synchro;
create user 'johndoe'@'localhost' identified by 'azerty';
grant all privileges on synchro.* to 'johndoe'@'localhost';
flush privileges;
exit;
maridb -h localhost -u johndoe -p;
use synchro;



CREATE TABLE tache (
  id SERIAL PRIMARY KEY,
  id_utilisateur FOREIGN KEY REFERENCES utilisateur (id_utilisateur),
  libelle VARCHAR(100) NOT NULL,
  description VARCHAR(500),
  date_debut DATETIME NOT NULL
  date_fin DATETIME NOT NULL,
  importance VARCHAR(10) CHECK (importance IN ('faible', 'moyen', 'fort')) NOT NULL,
  statut VARCHAR(10) CHECK (statut IN ('en cours', 'fait', 'en retard')) NOT NULL
);

CREATE TABLE utilisateur (
  id serial primary key,
  nom VARCHAR(40) NOT NULL,
  prenom VARCHAR(40) NOT NULL,
  email VARCHAR(70) NOT NULL,
  fonction VARCHAR(20) CHECK (fonction IN ('operationnel', 'chef de projet', 'ressources humaines')) NOT NULL,
  mdp VARCHAR(40) NOT NULL,
  


create table administrateurGroupe (
    id serial primary key,
);

create table Groupe (

  

--su -
--mariadb
create database synchro;
create user 'johndoe'@'localhost' identified by 'azerty';
grant all privileges on synchro.* to 'johndoe'@'localhost';
flush privileges;
--exit;
--maridb -h localhost -u johndoe -p;
use synchro;

CREATE TABLE utilisateur (
    id_utilisateur INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    fonction VARCHAR(30) CHECK (fonction IN ('operationnel', 'chef de projet', 'ressources humaines')) NOT NULL,
    mdp VARCHAR(255) NOT NULL
);

CREATE TABLE tache (
    id_tache INT AUTO_INCREMENT PRIMARY KEY,
    id_utilisateur INT NOT NULL,
    libelle VARCHAR(100) NOT NULL,
    description TEXT,
    date_debut DATETIME NOT NULL,
    date_fin DATETIME NOT NULL,
    importance VARCHAR(10) CHECK (importance IN ('faible', 'moyen', 'fort')) NOT NULL,
    statut VARCHAR(20) CHECK (statut IN ('en cours', 'fait', 'en retard')) NOT NULL,
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur) ON DELETE CASCADE --suppression simplifié
);

CREATE TABLE groupe (
    id_groupe INT AUTO_INCREMENT PRIMARY KEY,
    nom_groupe VARCHAR(100) NOT NULL,
    description_groupe VARCHAR(500)
);

CREATE TABLE groupe_membre (
    id_groupe INT NOT NULL,
    id_utilisateur INT NOT NULL,
    date_inscription DATE NOT NULL DEFAULT (CURRENT_DATE),
    est_admin BOOLEAN NOT NULL,
    PRIMARY KEY (id_groupe, id_utilisateur), --création de la clé primaire par les deux clé étrangères 
    FOREIGN KEY (id_groupe) REFERENCES groupe(id_groupe) ON DELETE CASCADE,  --suppression simplifié
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur) ON DELETE CASCADE  --suppression simplifié
);




  

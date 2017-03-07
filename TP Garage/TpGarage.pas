//BUT:Generer un formulaire pour garage pour les voitures
//ENTREE:saisi utilisateur
//SORTIE:formulaire rempli

CONST
	MAXGARAGE=2
	MAXVOITURE=15


TYPE
	Tgarage=ENREGISTREMENT
		nom:CHAINE
		adresse:Tformulaire
		voitures:ENTIER
	FINENREGISTREMENT
	
TYPE
	Tformulaire=ENREGISTREMENT
		numero:ENTIER
		voie:CHAINE
		CP:CHAINE
		ville:CHAINE
		pays:CHAINE
		tel:CHAINE
		email:CHAINE
	FINENREGISTREMENT
	
TYPE
	Tvoiture=ENREGISTREMENT
		marques:marques
		modele:CHAINE
		energie:Tenergie
		fiscale:ENTIER
		dyn:ENTIER
		couleur:CHAINE
		options:CHAINE
		anneeVente:ENTIER
		prix:ENTIER
		argus:ENTIER
		dates:Tdate
		age:ENTIER
		plaque:CHAINE
	FINENREGISTREMENT
	
TYPE 
	Tmarque=(bmw,mercedes,audi,ferrari,porsche)
	Tenergie=(essence,diesel,gpl,electrique,hybride)

TYPE
	Tdate=ENREGISTREMENT
		jour:ENTIER
		mois:ENTIER
		annee:ENTIER
	FINENREGISTREMENT
	
TYPE
	GarageTab:TABLEAU [1..MAXGARAGE] DE garage
	VoitureTab:TABLEAU [1..MAXVOITURE] DE voiture


//BUT:Cree le forumualire du garage
//ENTREE:1 tableau de type Garage
//SORTIE:1 tableau de type garage rempli
PROCEDURE CreateGarage(VAR garage:GarageTab; i:ENTIER)
DEBUT
	
	ECRIRE "Garage n'" & i & " : "
	ECRIRE "Entrez le nom de votre garage : "
	LIRE garage[i].nom
	
	ECRIRE "Pour l'adresse de votre garage, "
	
	ECRIRE "Entrez le numero de la rue/voie : "
	LIRE garage[i].adresse.numero
	
	ECRIRE "Entrez le nom de la voie/rue : "
	LIRE garage[i].adresse.voie
	
	REPETER
		ECRIRE "Entrez le code postal : "
		LIRE garage[i].adresse.cp
	JUSQU'A LONGUEUR(garage[i].adresse.cp)=5
	
	ECRIRE "Entrez la ville : "
	LIRE garage[i].adresse.ville
	
	ECRIRE "Entrez le pays : "
	LIRE garage[i].adresse.pays
	
	ECRIRE "Entrez votre telephone [06xxxxxxxx]"
	LIRE garage[i].adresse.tel
	
	ECRIRE "Entrez votre Email"
	LIRE garage[i].adresse.email
	
	ECRIRE "Entrez le nombre de voiture en posseder : "
	LIRE garage[i].voitures		
	
FINPROCEDURE


//BUT:calcul l'argus de la voiture
//ENTREE:1 tableau de type voiture
//SORTIE:valeur de largus
FONCTION CalculArgus(voiture:Tvoiture;i:ENTIER):ENTIER
DEBUT

	CAS voiture[i].age PARMIS
	
		CAS 0:voiture[i].argus<-voiture[i].prix
		
		CAS 1:voiture[i].argus<-(voiture[i].prix*25)/100
		
		CAS 2:voiture[i].argus<-(voiture[i].prix*25)/100
					voiture[i].argus<-(voiture[i].prix*10)/100
		
		CAS 3:voiture[i].argus<-(voiture[i].prix*25)/100
					voiture[i].argus<-(voiture[i].prix*10)/100
					voiture[i].argus<-(voiture[i].prix*10)/100
		
		CASPARDEFAULT:voiture[i].argus<-0
		
	FINCASPARMIS

FINFONCTION


//BUT:calcul le numero de la plaque aleatoirement
//ENTREE:1 tableau de type voiture
//SORTIE:valeur de la plaque
FONCTION CalculPlaque(voiture:Tvoiture;i:ENTIER):ENTIER
VAR
DEBUT

	ALEATOIRE(

FINFONCTION


//BUT:Creer le forumuaire voiture 
//ENTREE:1 tableau de type voiture
//SORTIE:1 tableau de type voiture rempli
PROCEDURE CreateVoiture(garage:Tgarage;VAR voiture:Tvoiture; i:ENTIER)
DEBUT

	POUR i<-1 A garage[i].voitures FAIRE
	
		ECRIRE "Voiture " & i
		ECRIRE "Entrez la marque (bmw,mercedes,audi,ferrari,porsche) : "
		LIRE voiture[i].marque
		
		ECRIRE "Entrez le modele : "
		LIRE voiture[i].modele
		
		ECRIRE "Entrez l'energie utiliser (essence,diesel,gpl,electrique,hybride) : "
		LIRE voiture[i].energie
		
		ECRIRE "Entrez la puissance fiscale : "
		LIRE voiture[i].fiscale
		
		ECRIRE "Entrez la puissance (CV DYN) : "
		LIRE voiture[i].dyn
		
		ECRIRE "Entrez la couleur : "
		LIRE voiture[i].couleur
		
		ECRIRE "Entrez les options (separer par #) : "
		LIRE voiture[i].options

		ECRIRE "Entrez l'annee du modele : "
		LIRE voiture[i].anneeVente
		
		ECRIRE "Entrez le prix du modele : "
		LIRE voiture[i].prix
		
		//fonction pour l'argus
		voiture[i].argus<-CalculArgus(voiture,i)
		
		ECRIRE "Pour la date de mise en circulation "
		
		REPETER 
			ECRIRE "Entrez le jour : "
			LIRE voiture[i].dates.jour
			
			ECRIRE "Entrez le mois : "
			LIRE voiture[i].dates.mois
			
			ECRIRE "Entrez l'annee : "
			LIRE voiture[i].dates.annee
		JUSQU'A TestDate(voiture)	//fonction pour tester si la date est juste
		
		voiture[i].age<-AUJOURDHUI-voiture[i].anneeVente
		
		//fonction pour la plaque
		voiture[i].plaque<-CalculPlaque(voiture,i)
		
	
	FINPOUR

FINPROCEDURE

	
VAR
	garage:GarageTab
	voiture:VoitureTab

DEBUT
	
	POUR i<-1 A MAXGARAGE FAIRE
		
		CreateGarage(garage,i)
		CreateVoiture(garage,voiture,i)
		
	FINPOUR

FIN.
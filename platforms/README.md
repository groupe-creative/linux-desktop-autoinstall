# # Linux Desktop Auto Install - Platforms/CI

Les fichiers présents dans le répertoire "platforms" peuvent être utilisés 
* manuellement 
* pour automatiser la vérification et le déploiement d'éléments (via Jenkins, Gitlab CI, etc)

## Le répertoire "platforms/ci" 

### "platforms/ci/check.sh"

Permet de vérifier le bon format du fichier "pxe/autoinstall/ubuntu/user-data"

Utilisation
```
# On vérifie le bon format du fichier "pxe/autoinstall/ubuntu/user-data"
./platforms/ci/check.sh
```

A noter que ce fichier se base sur une image Docker pour réaliser la vérification.

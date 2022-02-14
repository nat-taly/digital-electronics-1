# digital-electronics-1
`cd` - change directory (posouvám se o adresář)
<br>
`ls` nebo `ls -al` - zobrazi vsechno v adresari
<br>
`pwd` - zobrazi aktualni adresar
<br>
`cd ..` - vracim se nahoru
<br>
`rm` - vymazat soubor
<br>
`mkdir` - vytvori adresar (slozku)

## CLONE

- kdyz mam nove vytvoreny repozitar a chci ho dostat do PC, tak ho musím naklonovat.

1. Otevrit terminal ve slozce, kam ho budu chtit nahrat
2. Otevrit si to v terminalu a prikaz `git clone <ssh_address>` ( na GitHubu SSH a zkopirovat odkaz, ten tam vlozit)
3. Vytvori se mi slozka
4. Otevru si to v IDE a muzu upravovat (Pycharm je ok)

## GIT ADD + GIT COMMIT + PUSH

- kdyz vytvorim novy soubor a chci ho pridat na github (poznamka dela se to uz i s existujicim souborem)

1. `git status` - zkontroluju vsechny soubory co mam
2. `git add <nazev_souboru>` - pridam soubor
3. `git status` - overim, jestli je pridany
4. `git commit -m "Zprava pri nahrani"`
5. `git push origin main` - timto prikazem nahraju na git
6. chce to po me heslo, zadam heslo




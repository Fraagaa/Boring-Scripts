#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define HITS 600

typedef char* weaponName;
typedef int timesGot;
typedef struct tItemL {
    weaponName name;
    timesGot times_we_got_the_gun;
} tItemL;
typedef struct
{
    tItemL weapon[30];
} tList;


void run_hits(tList *L);
void printResoults(tList *L);
tList createWeaponList(tList *L);
int main()
{
    unsigned int semilla = (unsigned)time(NULL);
    srand(semilla);
    int hits = HITS;
    tList L;
    createWeaponList(&L);
    while(hits)
    {
        hits--;
        run_hits(&L);
    }
    printResoults(&L);
    return 0;
}

void run_hits(tList *L)
{
    int i = rand() % 23;
    L->weapon[i].times_we_got_the_gun++;
}

void printResoults(tList *L)
{
    int i;
    int totalHitsRegistered = 0;
    for(i = 0; i != 23; i++)
    {
        printf("%s, %d\n", L->weapon[i].name, L->weapon[i].times_we_got_the_gun);
        totalHitsRegistered += L->weapon[i].times_we_got_the_gun;
    }
    printf("\nTotal Guns Registered: %d", i);
    printf("\nTotal Hits Registered: %d", totalHitsRegistered);
    printf("\nAverage is: %f", (float)totalHitsRegistered / (float)i);
    printf("\nChance of getting a specific weapon asuming you have 2 weapons from the box and a equipment: %f", 1 / (float)(i - 3));
}

tList createWeaponList(tList *L)
{
    tItemL python_zm, cz75_zm, g11_lps_zm, famas_zm, spectre_zm, cz75dw_zm, spas_zm, hs10_zm, aug_acog_zm, galil_zm, commando_zm, fnfal_zm, dragunov_zm, l96a1_zm, rpk_zm, hk21_zm, m72_law_zm, china_lake_zm, ray_gun_zm, thundergun_zm, crossbow_explosive_zm, knife_ballistic_zm, zombie_black_hole_bomb, zombie_nesting_dolls;

    python_zm.name = "Python";
    python_zm.times_we_got_the_gun = 0;
    cz75_zm.name = "CZ";
    cz75_zm.times_we_got_the_gun = 0;
    g11_lps_zm.name = "G11";
    g11_lps_zm.times_we_got_the_gun = 0;
    famas_zm.name = "FAMAS";
    famas_zm.times_we_got_the_gun = 0;
    spectre_zm.name = "Spectre";
    spectre_zm.times_we_got_the_gun = 0;
    cz75dw_zm.name = "CZ DW";
    cz75dw_zm.times_we_got_the_gun = 0;
    spas_zm.name = "SPAS";
    spas_zm.times_we_got_the_gun = 0;
    hs10_zm.name = "HS12";
    hs10_zm.times_we_got_the_gun = 0;
    aug_acog_zm.name = "AUG";
    aug_acog_zm.times_we_got_the_gun = 0;
    galil_zm.name = "GALIL";
    galil_zm.times_we_got_the_gun = 0;
    commando_zm.name = "Commando";
    commando_zm.times_we_got_the_gun = 0;
    fnfal_zm.name = "FAL";
    fnfal_zm.times_we_got_the_gun = 0;
    dragunov_zm.name = "Dragunov";
    dragunov_zm.times_we_got_the_gun = 0;
    l96a1_zm.name = "L96A1";
    l96a1_zm.times_we_got_the_gun = 0;
    rpk_zm.name = "RPK";
    rpk_zm.times_we_got_the_gun = 0;
    hk21_zm.name = "HK21";
    hk21_zm.times_we_got_the_gun = 0;
    m72_law_zm.name = "M72 LAW";
    m72_law_zm.times_we_got_the_gun = 0;
    china_lake_zm.name = "China Lake";
    china_lake_zm.times_we_got_the_gun = 0;
    ray_gun_zm.name = "Ray Gun";
    ray_gun_zm.times_we_got_the_gun = 0;
    thundergun_zm.name = "Thundergun";
    thundergun_zm.times_we_got_the_gun = 0;
    crossbow_explosive_zm.name = "Crossbow";
    crossbow_explosive_zm.times_we_got_the_gun = 0;
    knife_ballistic_zm.name = "Ballistic Knife";
    knife_ballistic_zm.times_we_got_the_gun = 0;
    knife_ballistic_zm.name = "Ballistic Knife";
    knife_ballistic_zm.times_we_got_the_gun = 0;
    knife_ballistic_zm.name = "Ballistic Knife";
    knife_ballistic_zm.times_we_got_the_gun = 0;
    zombie_black_hole_bomb.name = "Gershes";
    zombie_black_hole_bomb.times_we_got_the_gun = 0;
    zombie_nesting_dolls.name = "Dolls";
    zombie_nesting_dolls.times_we_got_the_gun = 0;
    L->weapon[0] = python_zm;
    L->weapon[1] = cz75_zm;
    L->weapon[2] = g11_lps_zm;
    L->weapon[3] = famas_zm;
    L->weapon[4] = spectre_zm;
    L->weapon[5] = cz75dw_zm;
    L->weapon[6] = spas_zm;
    L->weapon[7] = hs10_zm;
    L->weapon[8] = aug_acog_zm;
    L->weapon[9] = galil_zm;
    L->weapon[10] = commando_zm;
    L->weapon[11] = fnfal_zm;
    L->weapon[12] = dragunov_zm;
    L->weapon[13] = rpk_zm;
    L->weapon[14] = hk21_zm;
    L->weapon[15] = m72_law_zm;
    L->weapon[16] = china_lake_zm;
    L->weapon[17] = ray_gun_zm;
    L->weapon[18] = thundergun_zm;
    L->weapon[19] = crossbow_explosive_zm;
    L->weapon[20] = knife_ballistic_zm;
    L->weapon[21] = zombie_black_hole_bomb;
    L->weapon[22] = zombie_nesting_dolls;



    return *L;
}
/*
 * To change box hits go to line 5 and change the number.

 * To add weapons do the following:
 * On line 139 add this:


    tItemL weapon;
    weapon.name = "name";
    weapon.times_we_got_the_gun = 0;
    L->weapon[number] = weapon;

number should be the next number of the list, right now last number is 22, so you should write 23
weapon can be anything, but I decided to use the names the devs gave them
name can be anything you want, just make sure it is within "     "
 * on line 48 chacne the  i != 23 to the next number of the list, if the list ends in 22, write 23
 * on line 40 do the same with the rand % 23, change it to the next number of the list
*/
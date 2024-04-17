#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main()
{
    unsigned int semilla = (unsigned)time(NULL);
    srand(semilla);
    unsigned int round, firstDogs, missed, rounders = 0, fourRounders = 0, fiveRounders = 0;
    firstDogs = rand() %3;
    if(firstDogs == 0)
        round = 5;
    else if(firstDogs == 1)
        round = 6;
    else
        round = 7;

    printf("%d\n", round);
    while(round < 260)
    {
        rounders++;
        unsigned int rounder = rand() %2;
        if(rounder)
        {
            round += 4;
            fourRounders++;
        }
        else
        {
            round += 5;
            fiveRounders++;
        }
        if(round > 162)
        {
            if(round == 163 || round == 165 || round == 167 || round == 169 || round == 171 || round == 173 || round == 175 || round == 177 || round == 179 || round == 181 || round == 183 || round == 185 || round == 188 || round == 189 || round == 191 || round == 194 || round == 196 || round == 197 || round == 199 || round == 202 || round == 204 || round == 205 || round == 207 || round == 210 || round == 211 || round == 214 || round == 216 || round == 217 || round == 219 || round == 222 || round == 224 || round == 225 || round == 228 || round == 229 || round == 231 || round == 234 || round == 236 || round == 237 || round == 239 || round == 242 || round == 243 || round == 246 || round == 248 || round == 249 ||  round == 252 ||  round == 253 ||  round == 255)
            {
                printf("%d MISSED\n", round);
                missed++;
            }
            else
                printf("%d\n", round);
        }
        else
            printf("%d\n", round);
    }
    printf("4 Rounders: %d\n", fourRounders);
    printf("5 Rounders: %d\n", fiveRounders);
    printf("AVG: %f\n", (4 * (float)fourRounders + 5 * (float)fiveRounders) / (float)rounders);
    printf("Missed instas: %d\n", missed);

    return 0;
}
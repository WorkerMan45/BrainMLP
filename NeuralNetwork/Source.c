#include <stdio.h>   
#include <Windows.h>

//arrays to make a brain
int arr[9] = { 0,0,0,0,0,0,0,0,0, };
char arr2[21] = { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 };
int arr3[19] = { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 };
int arr4[17] = { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 };
int arr5[15] = { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 };
int arr6[13] = { 0,0,0,0,0,0,0,0,0,0,0,0,0 };
int arr7[11] = { 0,0,0,0,0,0,0,0,0,0,0 };
int arr8[13] = { 0,0,0,0,0,0,0,0,0,0,0,0,0 };
int arr9[15] = { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 };

int space13 = 13;
int space12 = 12;
int space11 = 11;
int space10 = 10;
int space9 = 9;
int space8 = 8;
void display() {
    //displaying the arrays
   
    {
        for(int i = 0; i < space12; i++ ){
            printf(" ");
            if(i == space12 - 1)
                printf("(");
        }

        for (int i = 0; i < 13; i++) {
            printf("%d", arr6[i]);
            if(i == 12)
                printf(")");
        }
    }
    printf("\n");
    {
        for(int i = 0; i < space11; i++ ){
            printf(" ");
            if(i == space11 - 1)
                printf("(");
        }

        for (int i = 0; i < 15; i++) {
            printf("%d", arr5[i]);
            if(i == 14)
                printf(")");
        }
    }
    printf("\n");
    {
        for(int i = 0; i < space10; i++ ){
            printf(" ");
            if(i == space10 - 1)
                printf("(");
        }

        for (int i = 0; i < 17; i++) {
            printf("%d", arr4[i]);
            if(i == 16)
                printf(")");
        }

    }
    printf("\n");
    {
        for(int i = 0; i < space9; i++ ){
            printf(" ");
            if(i == space9 - 1)
                printf("(");
        }

        for (int i = 0; i < 19; i++) {
            printf("%d", arr3[i]);
            if(i == 18)
                printf(")");
        }
        
    }
    printf("\n");
    {
        for(int i = 0; i < space8; i++ ){
            printf(" ");
            if(i == space8 - 1)
                printf("(");
        }

        for (int i = 0; i < 21; i++) {
            printf("%d", arr2[i]);
            if(i == 20)
                printf(")");
        }

       
    }
    printf("\n");
    {
        for(int i = 0; i < space8; i++ ){
            printf(" ");
            if(i == space8 - 1)
                printf("(");
        }

        for (int i = 0; i < 21; i++) {
            printf("%d", arr2[i]);
            if(i == 20)
                printf(")");
        }
        
    }
    printf("\n");
    {
        for(int i = 0; i < space8; i++ ){
            printf(" ");
            if(i == space8 - 1)
                printf("(");
        }

        for (int i = 0; i < 21; i++) {
            printf("%d", arr2[i]);
            if(i == 20)
                printf(")");
        }
    }
    printf("\n");
    {
        for(int i = 0; i < space9; i++ ){
            printf(" ");
            if(i == space9 - 1)
                printf("(");
        }

        for (int i = 0; i < 19; i++) {
            printf("%d", arr3[i]);
            if(i == 18)
                printf(")");
        }
        
    }
    printf("\n");
    {
        for( i = 0; i < 11; i++ ){
            printf(" ");
        }
        for (int i = 0; i < 15; ++i) {
            printf("%d", arr9[i]);
        }
    }
    printf("\n");
    {
        for( i = 0; i < 12; i++ ){
            printf(" ");
        }
        for (int i = 0; i < 13; ++i) {
            printf("%d", arr8[i]);
        }
    }
    printf("\n");
    {
        for( i = 0; i < 13; i++ ){
            printf(" ");
        }
        for (int i = 0; i < 11; ++i) {
            printf("%d", arr7[i]);
        }
    }
}

void border() {
    {
        COORD l;
        l.X = 11;
        l.Y = 0;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), l);
        printf("(");
    }
    {
        COORD l;
        l.X = 25;
        l.Y = 0;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), l);
        printf(")");
    }
    {
        COORD l;
        l.X = 26;
        l.Y = 1;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), l);
        printf(")");
    }
    {
        COORD l;
        l.X = 27;
        l.Y = 2;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), l);
        printf(")");
    }
    {
        COORD l;
        l.X = 28;
        l.Y = 3;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), l);
        printf(")");
    }
    {
        COORD m;
        m.X = 10;
        m.Y = 1;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), m);
        printf("(");
    }
    {
        COORD n;
        n.X = 9;
        n.Y = 2;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), n);
        printf("(");
    }
    {
        COORD o;
        o.X = 8;
        o.Y = 3;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), o);
        printf("(");
    }
    {
        COORD l;
        l.X = 28;
        l.Y = 7;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), l);
        printf(")");
    }
    {
        COORD l;
        l.X = 26;
        l.Y = 8;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), l);
        printf(")");
    }
    {
        COORD l;
        l.X = 25;
        l.Y = 9;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), l);
        printf(")");
    }
    {
        COORD l;
        l.X = 24;
        l.Y = 10;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), l);
        printf(")");
    }
    {
        COORD l;
        l.X = 8;
        l.Y = 7;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), l);
        printf("(");
    }
    {
        COORD l;
        l.X = 10;
        l.Y = 8;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), l);
        printf("(");
    }
    {
        COORD l;
        l.X = 11;
        l.Y = 9;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), l);
        printf("(");
    }
    {
        COORD l;
        l.X = 12;
        l.Y = 10;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), l);
        printf("(");
    }
    {
        COORD p;
        p.X = 7;
        p.Y = 4;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), p);
        printf("|");
    }
    {
        COORD p;
        p.X = 7;
        p.Y = 5;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), p);
        printf("|");
    }
    {
        COORD p;
        p.X = 7;
        p.Y = 6;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), p);
        printf("|");
    }
    {
        COORD p;
        p.X = 29;
        p.Y = 6;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), p);
        printf("|");
    }
    {
        COORD p;
        p.X = 29;
        p.Y = 5;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), p);
        printf("|");
    }
    {
        COORD p;
        p.X = 29;
        p.Y = 4;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), p);
        printf("|");
    }
    {
        COORD l;
        l.X = 13;
        l.Y = 11;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), l);
        printf("-");
    }
    {
        COORD l;
        l.X = 14;
        l.Y = 11;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), l);
        printf("-");
    }
    {
        COORD l;
        l.X = 15;
        l.Y = 11;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), l);
        printf("-");
    }
    {
        COORD l;
        l.X = 16;
        l.Y = 11;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), l);
        printf("-");
    }
    {
        COORD l;
        l.X = 17;
        l.Y = 11;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), l);
        printf("-");
    }
    {
        COORD l;
        l.X = 18;
        l.Y = 11;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), l);
        printf("-");
    }
    {
        COORD l;
        l.X = 19;
        l.Y = 11;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), l);
        printf("-");
    }
    {
        COORD l;
        l.X = 20;
        l.Y = 11;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), l);
        printf("-");
    }
    {
        COORD l;
        l.X = 21;
        l.Y = 11;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), l);
        printf("-");
    }
    {
        COORD l;
        l.X = 22;
        l.Y = 11;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), l);
        printf("-");
    }
    {
        COORD l;
        l.X = 23;
        l.Y = 11;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), l);
        printf("-");
    }
}
int main() {
    int x;
    x = 5;

    
    border(); 
    display();

    if (x == 5) {
        arr2[0] = 1;
        arr2[1] = 1;
        arr2[2] = 1;
        arr3[2] = 1;
        arr3[3] = 1;
        display();
    }
    else {
       display();
    }
    getch();
    return 0;
}
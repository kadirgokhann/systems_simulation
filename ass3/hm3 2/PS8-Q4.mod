
1$            CREATE,        1:NORMAL(5,1):MARK(ArrTime):NEXT(3$);
 
3$            ASSIGN:        Type=1: #  Eng
                             FServiceTime=UNIFORM(2,7):
                             Priority=2: 
                             PaymentType=DISCRETE(0.6,1,1.0,2); # 1 credit, 2 cash
5$            QUEUE,         FoodQ;
6$            SEIZE,         1,Other:
                             FoodS,1:NEXT(14$);

14$           TALLY:         TimeFoodQ,INT(ArrTime),1;
7$            DELAY:         FServiceTime,Type,Other:NEXT(8$);

8$            RELEASE:       FoodS,1;
CashierPlace  QUEUE,         CashQ;
9$            SEIZE,         1,Other:
                             Cashier,1:NEXT(13$);

13$           BRANCH,        1:
                             If,PaymentType==1,CreditDelay,Yes:
                             Else,CashDelay,Yes;
CreditDelay   DELAY:         UNIFORM(1,2),Type+2,Other:NEXT(10$);

10$           RELEASE:       Cashier,1;
11$           BRANCH,        1:
                             If,Priority==1,Exit,Yes:
                             With,0.25,Drink,Yes:
                             With,0.75,Exit,Yes;
Exit          COUNT:         Exited,1;
0$            DISPOSE:       No;

Drink         ASSIGN:        Priority=1;
15$           COUNT:         NumberOfForgottenStudents,1;
12$           DELAY:         0.5,Type + 4,Other:NEXT(CashierPlace);

CashDelay     DELAY:         UNIFORM(2,6),Type+2,Other:NEXT(10$); 


2$            CREATE,        1:EXPONENTIAL(4):MARK(ArrTime):NEXT(4$);

4$            ASSIGN:        Type=2: # Social 
                             FServiceTime=EXPONENTIAL(5):
                             Priority=2:
                             PaymentType=DISCRETE(0.6,1,1.0,2):NEXT(5$); # 1 card 2 cash






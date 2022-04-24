# Exercise 2 results. Dzhemilya Gizutdinova

## Test with Read committed

link onto my conspectum: https://docs.google.com/document/d/1hK0tPNXfMBKSe7fh0LwFmiGi2lJscVaEMjrfABvhxYg/edit#

#### STEP 1 TERMINAL 1: Start a transaction and display the accounts information

![image-20220426230742794](/home/dzhemilya/.config/Typora/typora-user-images/image-20220426230742794.png)

#### STEP 2 TERMINAL 2: Start a transaction and update the username for “Alice Jones” as “ajones” 

![image-20220426230906043](/home/dzhemilya/.config/Typora/typora-user-images/image-20220426230906043.png)

#### STEP 3 TERMINAL 1: Display again the accounts table

#### ![image-20220426231201490](/home/dzhemilya/.config/Typora/typora-user-images/image-20220426231201490.png)

#### STEP 4 TERMINAL 2: Display again the accounts table

![image-20220426231126312](/home/dzhemilya/.config/Typora/typora-user-images/image-20220426231126312.png)

### Do both terminals show the same information? Explain the reason

#### ANSWER: 

***No changes in terminal 1, since we didn't commit anything in the terminal 2. Because READ COMMITTED guarantees that any data is read is committed at the moment it is read.***

#### STEP 5 TERMINAL 2: Commit the changes and compare again both sessions.

**terminal 2:**

![image-20220426231734434](/home/dzhemilya/.config/Typora/typora-user-images/image-20220426231734434.png)

**terminal 1:**

### Answer: 

***After commit, T1 and T2 shows the same data. As was said above, READ COMMITTED guarantees that any data is read is committed at the moment it is read.  Thus, first terminal display the data which was committed in second terminal.***

#### STEP 6 TERMINAL 2: Start a new transaction

![image-20220426232242496](/home/dzhemilya/.config/Typora/typora-user-images/image-20220426232242496.png)

#### STEP 7 TERMINAL 1: Update the balance for the Alice’s account by +10.

![image-20220426232426766](/home/dzhemilya/.config/Typora/typora-user-images/image-20220426232426766.png)

#### STEP 8 TERMINAL 2: Update the balance for the Alice’s account by +20 

![image-20220426233543047](/home/dzhemilya/.config/Typora/typora-user-images/image-20220426233543047.png)

### Explain the output form the second terminal 

***After update statement T2 starts blocking state and waits for commit of T2 transaction since they both holds the same record changed. Situation is similar to a deadlock.***

#### STEP 9 TERMINAL 1: Commit the changes. 

![image-20220426233918794](/home/dzhemilya/.config/Typora/typora-user-images/image-20220426233918794.png)

#### STEP 10 TERMINAL 2: Rollback

![image-20220426233951656](/home/dzhemilya/.config/Typora/typora-user-images/image-20220426233951656.png)



## Test with Read committed

#### STEP 1 TERMINAL 1: Start a transaction and display the accounts information

![image-20220427003051896](/home/dzhemilya/.config/Typora/typora-user-images/image-20220427003051896.png)

#### STEP 2 TERMINAL 2: Start a transaction and update the username for “Alice Jones” as “ajones” 

![image-20220427003226986](/home/dzhemilya/.config/Typora/typora-user-images/image-20220427003226986.png)

#### STEP 3 TERMINAL 1: Display again the accounts table

![image-20220427003253001](/home/dzhemilya/.config/Typora/typora-user-images/image-20220427003253001.png)

#### STEP 4 TERMINAL 2: Display again the accounts table

![image-20220427003938712](/home/dzhemilya/.config/Typora/typora-user-images/image-20220427003938712.png)

### Do both terminals show the same information? Explain the reason

#### ANSWER: 

***No, T1 terminal shows still shows ```'jones'```, while T2 shows updated value ```'ajones'```. It's because repeatable read as read committed guarantees that any data is read is committed at the moment it is read, but transaction in T2 is not committed yet.*** ***After commit, T1 still shows old data because it keeps all records that were read in current transaction. T2 shows new data.***

#### STEP 5 TERMINAL 2: Commit the changes and compare again both sessions.

![image-20220427004011375](/home/dzhemilya/.config/Typora/typora-user-images/image-20220427004011375.png)terminal 2

![image-20220427004031082](/home/dzhemilya/.config/Typora/typora-user-images/image-20220427004031082.png)terminal 1

#### STEP 6 TERMINAL 2: Start a new transaction

![image-20220427004112410](/home/dzhemilya/.config/Typora/typora-user-images/image-20220427004112410.png)



#### STEP 7 TERMINAL 1: Update the balance for the Alice’s account by +10

***T1 update will not work with such error: ERROR:  could not serialize access due to concurrent update because transaction of T2 has updated the same record (Alice) and due to the guarantees of the repeatable read isolation level, the statement in this session was cancelled.*** ***So after commit; we will see ROLLBACK in T1 transaction.***

![image-20220427004325921](/home/dzhemilya/.config/Typora/typora-user-images/image-20220427004325921.png)

#### STEP 8 TERMINAL 2: Update the balance for the Alice’s account by +20 

![image-20220427004426104](/home/dzhemilya/.config/Typora/typora-user-images/image-20220427004426104.png)

#### STEP 9 TERMINAL 1: Commit the changes. 

![image-20220427004454425](/home/dzhemilya/.config/Typora/typora-user-images/image-20220427004454425.png)

#### STEP 10 TERMINAL 2: Rollback

![image-20220427004514965](/home/dzhemilya/.config/Typora/typora-user-images/image-20220427004514965.png)

## EXERCISE 2 TASK 2.

### FOR READ COMMITTED

***The main idea is that is this isolation level only the committed data could be read. E.g. you can start transaction and change data during the another transaction and if you committed it another transaction will see it.***

#### STEP 1:  Start a transaction (T1 & T2) 

![image-20220427010618254](/home/dzhemilya/.config/Typora/typora-user-images/image-20220427010618254.png)

#### STEP 2: Read accounts with group_id=2 (T1).

![image-20220427010638297](/home/dzhemilya/.config/Typora/typora-user-images/image-20220427010638297.png)

#### STEP 3: Move Bob to group 2(T2). 

![image-20220427010733971](/home/dzhemilya/.config/Typora/typora-user-images/image-20220427010733971.png)

#### STEP 4: Read accounts with group_id=2 (T1).

![image-20220427010757248](/home/dzhemilya/.config/Typora/typora-user-images/image-20220427010757248.png)

#### STEP 5: Update selected accounts balances by +15 (T1). 

![image-20220427010824631](/home/dzhemilya/.config/Typora/typora-user-images/image-20220427010824631.png)

#### STEP 6: Commit transaction (T1 & T2)

![image-20220427010842117](/home/dzhemilya/.config/Typora/typora-user-images/image-20220427010842117.png)

### Answer:

***We can see that at first ```mike``` has got +15 to balance but ```bbrow```has not. It's because T1 transaction was processing while T2 transaction has not been committed yet, so ```bbrow``` has not been in group 2 yet.***



### FOR REPEATABLE READ

***In case of repeatable read even when we commit changes in transaction, the another transaction won't see it before the end of transaction.***

#### STEP 1:  Start a transaction (T1 & T2) 

![image-20220427012328476](/home/dzhemilya/.config/Typora/typora-user-images/image-20220427012328476.png)

#### STEP 2: Read accounts with group_id=2 (T1).

![image-20220427012400993](/home/dzhemilya/.config/Typora/typora-user-images/image-20220427012400993.png)

#### STEP 3: Move Bob to group 2(T2). 

![image-20220427012546646](/home/dzhemilya/.config/Typora/typora-user-images/image-20220427012546646.png)

#### STEP 4: Read accounts with group_id=2 (T1).

![image-20220427012646404](/home/dzhemilya/.config/Typora/typora-user-images/image-20220427012646404.png)

#### STEP 5: Update selected accounts balances by +15 (T1). 

![image-20220427012724509](/home/dzhemilya/.config/Typora/typora-user-images/image-20220427012724509.png)

#### STEP 6: Commit transaction (T1 & T2)

![image-20220427012806667](/home/dzhemilya/.config/Typora/typora-user-images/image-20220427012806667.png)

![image-20220427012840091](/home/dzhemilya/.config/Typora/typora-user-images/image-20220427012840091.png)



### Answer:

***We can see that the result is the same as in read committed. There are no errors because T2 updated record which had not been read by T1. Therefore, T1 & T2 updated different records and obtain the same result.***
import timeit
##################################################################
#others
def hamdist(u,v): # return the hamming distance between 2 vector u and v
    nu=len(u)
    nv=len(v)
    if nu != nv:
        print("error. length must equal")
        return("error")
    hd=0
    for i in range(nv):
        if u[i] !=v[i]:
            hd +=1
    return(hd)

def binario_chooser(database_binario,m,blanks):
    # chose randomly from database. choose random transformation preserving the constraint. then choose random cells to be blank
    k = 0
    while (m,k) in database_binario:
        k +=1
    A0 = database_binario[m,randint(0,k-1)]
    trans = ['A0', 'A0[::-1]', 'A0.transpose()', 'A0.antitranspose()', 'A0[::-1].transpose()', 'A0[::-1].antitranspose()', 'A0.transpose().antitranspose()']
    A = copy(eval(trans[randint(0,6)])) # 7 is the len of trans
    location_index = cartesian_product([Set(xrange((2*m))), Set(xrange((2*m)))])
    set_of_blank_cell = Subsets(location_index,blanks)
    index_of_blank_cell = set_of_blank_cell.random_element()
    for i in index_of_blank_cell:
        A[i[0],i[1]] = 9
    return A

##################################################################
#checking for contradiction
def cekcons1(v): #cek apakah suatu vektor memeiliki t consecutive 1. return true jika ya
    t=3
    for i in range(len(v)-(t-1)):
        tt=[]
        for j in range(t):
            tt.append(v[i+j]==1)
        #print(tt)
        if(sum(tt)==t):
            return(True)
    return(False)
"""
Check wether a vector has 3 consecutive 1 or not:
Input: vector vwith length n,
Output: T/F. True if there is a 3 consecutive 1. False otherwise
for i = 0 .. n-2, <- tt =[v_i, v_{i+1}, v_{i+2}]. If sum(tt) = 3, return(True)
"""

def cekcons0(v):
    t=3
    for i in range(len(v)-(t-1)):
        tt=[]
        for j in range(t):
            tt.append(v[i+j]==0)
        #print(tt)
        if(sum(tt)==t):
            return(True)
    return(False)
"""
Check wether a vector has 3 consecutive 0 or not:
Input: vector vwith length n,
Output: T/F. True if there is a 3 consecutive 1. False otherwise
for i = 0 .. n-2, set tt =[v_i, v_{i+1}, v_{i+2}]. If sum(tt) = 0, return(True)
"""
    
def isbalance(v): # check a vector v whether it is balance or not return true if balance
    v=list(v)
    n1=v.count(1)
    n0=v.count(0)
    if n0==n1:
        return(True)
    return(False)
"""
Check wether a vector has the same number of 0 and 1 (balance)
Input: vector v
Output: T/F. True if it is balance. False otherwise
n1 <- number of 1s in v. set n0 <- number of 0s in v. if n1==n0, return(True)
"""

def isidentic(u,v): #check whether v is equal to u or not. return true if equal
    if u==v:
        return(True)
    return(False)
"""
trivial
"""

def checkforconsrow(A): #given array A, we want to check all the condition for the row. return True if it is ok (no contradiction).
    A=matrix(A)
    nc=A.ncols()
    nr=A.nrows()
    # if nc !=nr or mod(nc,2) !=0 :
    #     print('error . matrx should be square and even')
    #the rows
    for a in A:
        cons1a=cekcons1(a)
        if cons1a:
            return(False)
        cons1b=cekcons0(a)
        if cons1b:
            return(False)
        nblank=list(a).count(9)
        #print(cons1a,cons1b,nblank)
        if nblank==0:
            cons2=isbalance(a)
            if not cons2:
                return(False)
            A1=list(copy(A))
            A1.remove(a)
            #print(matrix(A1));print(cons2)
            for b in A1: 
                cons3=isidentic(a,b)
                if cons3:
                    return(False)
               # print(cons3)
    return(True)
"""
Check wether the rows of a square matrix satisfies binary puzzle properties (only the rows)
Input: matrix A
Output: T/F. True if it satisfies all the constraints, False otherwise
nc <- number of column, nr <- number of row
for each row in A, check for 3 consecutive 1s and 0s. also check for its balancedness. return(False) if there is 3 consecutive 1s or 0s of not balance.
for each row in A, say a, A1 <- A/a (copy of A excluding a), for each row in A1,say b, check wether  a and b are identic. Return(False) if they are identic.
"""
            
# checkforcons(A)                 
def checkforcons(A):
    A=matrix(A)
    itisok=checkforconsrow(A)
    if not itisok:
        return(False)
    A=transpose(A)
    itisok=checkforconsrow(A)
    if not itisok:
        return(False)
    return(True)
"""
Check wether  a square matrix satisfies binary puzzle properties 
Input: matrix A
Output: T/F. True if it satisfies all the constraints, False otherwise
check the rows of matrix A.
check the tranpose of A
"""
            
##################################################################
# forced move
def partdistinctrow(A1): #algorithm for solving w.r.t. the distinct rules (forced conditions->only for rows)
    dochange=0
    A=matrix(copy(A1))
    nr=A.nrows()
    nc=A.ncols()
    if nc !=nr or mod(nc,2) !=0 :
        print('error . matrx should be square and even')
    for i in range(nr): # for each row
        a=list(A[i])
        n1=a.count(1)
        n0=a.count(0)
        nblank=a.count(9); # print('.')
        if nblank==2: # only check for nblank=2 because for blank=1, will be forced by other condition
            if n1==n0: # the other non blank are balance
                for j in range(nr): # each other row,
                    b=list(A[j])
                    hd=hamdist(a,b)# ;print(hd)
                    if hd == 2: # compare the distance ( if the only different is the blank, then..
                        for index,item in enumerate(a):
                            if item == 9:
                                if b[index] == 0:
                                    A[i,index]=1
                                    dochange=1
                                if b[index]==1:
                                    A[i,index]=0
                                    dochange=1
                        if dochange==1:
                            return(A)
    return(A)                   
"""
Filling the puzzle with forced move with respect to the non-identical rows (row checking).
Input: matrix A filled with 1, 0, and 9 (blank)
Output: Matrix B after forced move.
nc <- number of columns of A. nr <- number of rows of A.
for each row in A, say a, n1 <- number of 1 in a, n0 <- number of  0 in a. nblank <- number of blank in a. If nblank==2 and n1==n2, compute the hamming distance, hd,  with all other row, say b. If the hamming distance between a and b == 2, fill the blank in a with the inverse of b.  
"""

def partdistinct(A):
    dochange=0
    A=matrix(A)
    A1=partdistinctrow(A)
    A1=transpose(A1)
    A1=partdistinctrow(A1)
    A1=transpose(A1)
    if A==A1:
        return(A1)
    else:
        return(partdistinct(A1))
"""
Filling the puzzle with forced move with respect to the non-identical.
Input: matrix A filled with 1, 0, and 9 (blank)
Output: Matrix B after forced move.
Fill with respect to the non-identical row.
Fill with respect to the non-identical column.
"""
    
def partnocons(v1):#algorithm for flling the puzzle w.r.t. no consecutive ones or zero . v is a vector with length 3
    v=copy(v1)
    dochange=0
    n1=v.count(1)
    n0=v.count(0)
    nblank=v.count(9)
    if nblank==1 and n0==2:
        #replace 9 with 1
        loc = v.index(9)
        v[loc] = 1
        dochange=1
    elif nblank==1 and n1==2:
        #replace 9 with 0
        loc = v.index(9)
        v[loc] = 0
        dochange=1
    return(v)
"""
Filling a vector with respect to no consecutive 1s or zeros
Input:a vector v with length 3
Output: a vector with length 3
If the number of blank is equal to 1 and the number of 0s is equal to 2, fill the blank with 1. If the number of blank is equal to 1 and the number of 1s is equal to 2, fill the blank with 0. 
"""
    
def partbal(v1): # algorithm for filling the puzzle wrt balance properties
    v=list(copy(v1))
    n=len(v)
    dochange=0
    n0=v.count(0)
    nblank=v.count(9)
    if nblank==1:
        dochange=1;
        if abs(n0-n/2)<10^-9:
            loc = v.index(9)
            v[loc] = 1
        else:
            loc = v.index(9)
            v[loc] = 0
    return(v)         
"""
Filling a vector with forced move with respect to the balance properties
Input: a vector v with even length.
Output: a vector
If number of blank == 1, then: fill the blank with 0 if the number of 1s is even, otherwise fill with 0 
"""

def fill2cons(A1): #algorithm for filling wrt 2nd constrain
    dochange=0
    A=copy(matrix(A1))
    nr=A.nrows()
    nc=A.ncols()
    A=list(A)
    if nc !=nr or mod(nc,2) !=0 :
        print('error . matrx should be square and even')
    for a in A: #force move for each row in A
        v=vector(partbal(list(a)))
        if v != a:
            loc = A.index(a)
            A[loc] = v
            dochange=1
    A=list(transpose(matrix(A))) #transpose for checking columns
    for a in A:
        v=vector(partbal(list(a)))
        if v != a:
            #print(a);print(v)
            loc = A.index(a)
            A[loc] = v
            dochange=1
    return(transpose(matrix(A)),dochange)
"""
Filling a matrix puzzle with force move with respect to the balance properties
Input: a square even matrix A
Output: a matrix
for each row in A, say v, force move v with respect to balance properties
for each column in A, say v, force move v with respect to balance properties
"""

def fill2consB(A1): # calling funcrion until no change can be done
    result=fill2cons(A1)
    if(result[1]==0):
        A=matrix(result[0])
        return(A)
    else:
        return(fill2consB(result[0]))
"""
Recursively fill a matrix puzzle with force move with respect to the balance properties
Input: a square matrix A
Output: a matrix
fill A with forcemove with respect to the balance properties until no change can be made
"""
    
def fill1cons(A1):#algorithm for fililing wrt 1st constrain
    dochange=0
    A=copy(matrix(A1))
    nr=A.nrows()
    nc=A.ncols()
    A=list(A)
    if nc !=nr or mod(nc,2) !=0 :
        print('error . matrx should be square and even')
    for a in A:
        for i in [0..nc-3]:
            v=partnocons([a[i],a[i+1],a[i+2]])
            if v != [a[i],a[i+1],a[i+2]]:
                a[i]=v[0];a[i+1]=v[1];a[i+2]=v[2]
                dochange=1
    A=list(transpose(matrix(A)))#transpose for checking columns
    for a in A:
        for i in [0..nc-3]:
            v=partnocons([a[i],a[i+1],a[i+2]])     
            if v != [a[i],a[i+1],a[i+2]]:
                a[i]=v[0];a[i+1]=v[1];a[i+2]=v[2]
                dochange=1
    return(transpose(matrix(A)),dochange)
"""
Filling a matrix puzzle with force move with respect to the no 3 consecutive 1s and 0s properties
Input: a square even matrix A
Output: a matrix
for each row in A, say v, fill every blank in 3 consecutive cell in v with respect to no consecutive 1s and 0s
for each column in A, say v,  fill every blank in 3 consecutive cell in v with respect to no consecutive 1s and 0s
"""

def fill1consB(A1): # caaling function until no change can be done
    result=fill1cons(A1)
    if result[1]==0 :
        A=matrix(result[0])
        return(A)
    else:
        return(fill1consB(result[0]))
"""
Recursively fill matrix A with forecemove with  respect to no 3 consecutive 1s and 0s until no change can be made.
"""

def solvepart1(AA): #solve binario puzzle
  dochange=0
  A=matrix(copy(AA))
  A1=fill1consB(A)
  A1=fill2consB(A1)
  A1=partdistinct(A1)
  if A==A1:
    return(A1)
  else:
    return(solvepart1(A1))
"""
Solve binario puzzle with force move  recursively.
"""

##################################################################
#backtraking
def changelogs(Anew,Aold,logs,iterat): #keep change for what cell is changed. logs is a dict
    if Anew==Aold:
        return(logs)
    else:
        A1=matrix(copy(Anew))
        A2=matrix(copy(Aold))
        nr=A1.nrows()
        nc=A1.ncols()
        if nc !=nc:
            print('error, matrix should be square')
            return()
        for i in range(nc):
            for j in range(nr):
                if A1[i,j]!=A2[i,j]:
                    logs[iterat,(i,j)]=[A2[i,j],A1[i,j]]
    return(logs)
"""
Keep track the modified cell
Input: matrix puzzles (before and after filled), database of changed cell before it filled, iteration
Output:database of changedd cell: logs
if nothing changed, return logs, else, append to logs which cell was changed including the changes 
"""

def fill1stblank(AA,o,logs_guess,iterat):
     A=matrix(copy(AA))
     nr=A.nrows()
     nc=A.ncols()
     for i in range(nr):
         for j in range(nc):
             if A[i,j]==9:
                 A[i,j]=o
                 logs_guess[iterat]=[[i,j],o]
                 return(A,logs_guess)
"""
Guess the first blank with 0/1.
Input: matrix puzzle A, guess, iteration
Output: new matrix A, log of guesses
"""

def solvepart2(AA,o,logs_guess,iterat): #part 2 of binario puzzle. it should have some blank filled with force by 1st algorithm
    A=matrix(copy(AA))
    resultfillfirstblank=fill1stblank(A,o,logs_guess,iterat) ;# 
    A=resultfillfirstblank[0]
    logs_guess=resultfillfirstblank[1]
    A=solvepart1(A)
    return(A,logs_guess)
"""
Wrapper for the guessing (part 2 solver) binario puzzle with logs
"""
    
def solvepuzzle(AA):
    A1=solvepart1(copy(AA))
    logs={}; iterat=1; logs_guess={}; listAA={iterat:A1}; changeiterat=[];  o = 0; number_of_guess = 0; number_of_backtrack = 0
    nr=A1.nrows()
    nc=A1.ncols()
    numblank=sum(list(list(a).count(9) for a in A1))
    if not checkforcons(A1):
        print('puzzle does not have solution')
        return(A1,number_of_guess,number_of_backtrack)
    if numblank == 0:
        return(A1,number_of_guess,number_of_backtrack)
    else:
        numberofloop=0
        while numblank != 0:
            numberofloop   +=1
            resultsolvepart2   = solvepart2(A1,o,logs_guess,iterat)
            A2                 = resultsolvepart2[0] 
            logs_guess         = resultsolvepart2[1]
            resultcheckandlogs = checkandlogs(A1,A2,logs,iterat)
            logs               = resultcheckandlogs[0]
            status             = resultcheckandlogs[1]
            iterat            += 1
            number_of_guess   += 1
 
            if  status:
                A1=A2
                listAA[iterat]=A1
            else:
                iterat -= 1;
                while iterat in changeiterat:
                    changeiterat.remove(iterat) ;
                    iterat -=1 ;
                    if iterat == 0:
                        print 'invalid puzzle'
                        return(A2,number_of_guess,number_of_backtrack)
                o                 = mod(logs_guess[iterat][1]+1,2);
                dellogiter_result = dellogsiter(A2,logs,logs_guess,iterat);
                A2                = dellogiter_result[0]; 
                logs              = dellogiter_result[1] ; 
                A1                = listAA[iterat];
                changeiterat.append(iterat)
                number_of_backtrack += 1 
            numblank              = sum(list(list(a).count(9) for a in A1))
            if numberofloop == 2^(nr*nc)+1:
                print('Failed')
                return(A2,number_of_guess,number_of_backtrack)
        return(A2,number_of_guess,number_of_backtrack)
"""
Wrapper for binario solver.
Input: matrix A puzzle,
Output: solved puzzle
1. Try to solve using force move.
2. Check whether the puzzle has a solution or not
3. Recursively do the part 2 of the solver (guessing)
3. a. If  number of loop >= 2^number_of_cell+1, then "Abort"
"""

def solvepuzzle_rand(AA):
    A1=solvepart1(copy(AA))
    #start tracking
    #print A1
    logs={}; iterat=1; logs_guess={}; listAA={iterat:A1}; changeiterat=[];  o=randint(0,1)
    nr=A1.nrows()
    nc=A1.ncols()
    numblank=sum(list(list(a).count(9) for a in A1))
    if not checkforcons(A1):
        print('puzzle does not have solution')
        return(A1)
    if numblank == 0:
        return(A1)
    else:
        numberofloop=0
        while numblank != 0:
            numberofloop   +=1
            resultsolvepart2   = solvepart2(A1,o,logs_guess,iterat)
            A2                 = resultsolvepart2[0] 
            logs_guess         = resultsolvepart2[1]
            resultcheckandlogs = checkandlogs(A1,A2,logs,iterat)
            logs               = resultcheckandlogs[0]
            status             = resultcheckandlogs[1]
            iterat            += 1
 
            if  status:
                A1=A2
                listAA[iterat]=A1
                o=randint(0,1)
            else:
                iterat -= 1;
                while iterat in changeiterat:
                    changeiterat.remove(iterat) ;
                    iterat -=1 ;
                    if iterat == 0:
                        print 'invalid puzzle'
                        return(A2)
                o                 = mod(logs_guess[iterat][1]+1,2);
                dellogiter_result = dellogsiter(A2,logs,logs_guess,iterat);
                A2                = dellogiter_result[0]; 
                logs              = dellogiter_result[1] ; 
                A1                = listAA[iterat];
                changeiterat.append(iterat)
            numblank              = sum(list(list(a).count(9) for a in A1))
            if numberofloop == 2^(nr*nc)+1:
                print('Failed')
                return(A2)
        return(A2)
"""
Wrapper for binario solver with random guess.
Input: matrix A puzzle,
Output: solved puzzle
1. Try to solve using force move.
2. Check whether the puzzle has a solution or not
3. Recursively do the part 2 of the solver (guessing)
3. a. If  number of loop >= 2^number_of_cell+1, then "Abort"
"""

def checkandlogs(A1,A2,logs,iterat):
    #iterat will add if there are no contraddiction. A2 is the new one
    logs=changelogs(A2,A1,logs,iterat)
    #chenking
    if checkforcons(A2):
        status=True
    else:
        status=False
    return(logs,status)
"""
Check wether the result is consistent or not
"""
            
def dellogsiter(AA,logs,logs_guess,iterat):
    nl=len(logs)
    nll=range(nl-1,-1,-1)
    lkeys=list(logs.keys())
    A=matrix(copy(AA))
    for i in nll:
        if lkeys[i][0] == iterat:
            A[lkeys[i][1]]=9
            logs.pop(lkeys[i],None)
    logs_guess.pop(iterat,None)
    iteratsofar=logs_guess.keys();iteratsofar.append(0)
    if iterat <= max(iteratsofar):
        return(dellogsiter(A,logs,logs_guess,iterat+1))
    return(A,logs,logs_guess)
"""
Revert changes if the result of guessing lead to inconsitency
"""

# 1. solve part 1
# start tracking
#solve part 2 ( guess+part1)
#chexk
#
# backtrack : delete k level iteration from A
##
##################################################################
#toc=timeit.default_timer()-tic;print '\n','time/duration: ', toc

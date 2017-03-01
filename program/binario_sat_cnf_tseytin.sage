#import sage.logic.propcalc as propcalc

###    CNF, for SAT solver. transform bolean formula into cnf, DIMACS (sage version  ##
#do reindex from matrix to vector. we do in row: 1st row, 2nd row, etc.. 1st row start at 1 until 2m. 2nd row from 2m+1 until 2m+2m, etc... . tecnically, aij become i*(2*m)+(j+1)
##balance
#output from balancearraylogic is almost in CNF. we just need to renumber the index and write as dimacs format
# the idea is simple: (1) convert aij to i*(2*m)+(j+1), (2) replace "|" with ", " (3) "&" with newline (4)  delete unused "(" and ")" (5) keep ")"

##  $2 \times  2m \times (2  \times \binom{2m}{m+1})$  clause and each clause have $m+1$ literal
def balance_list_sat(m):
    listbal=Combinations(xrange(2*m),m+1) #listbal[k][l] = j
    clause_list=[]
    for i in xrange(2*m):
        for j_list in listbal:
            clause_col=[i*(2*m)+(j+1) for j in j_list]
            clause_row=[j*(2*m)+(i+1) for j in j_list]
            clause_list.append(clause_col)
            clause_list.append(clause_row)
            # a=[[i,j] for j in j_list]; b=[[j,i] for j in j_list] #crosschek with bolean formula defined before
    clause_list_temp=copy(clause_list)
    for clause in clause_list_temp:
        clause_list.append([-el for el in clause]) 
    return clause_list

##identical columns and rows  $\binom{2m}{2} \times 2^{2m} \times 2 $   clause and each clause have $2 \times 2m$ literal
# generate cnf based on original expression and tseytin transformation
def no_identical(m):
    def X(i,j):
        return i*(2*m) + (j+1)     
    def Ac(i,j,k):
        return ((2*m)^2 + (i+1) + 2*m * ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)  )
    def Bc(i,j,k):
        return ((2*m)^2 +  binomial(2*m,2)*2*m + (i+1) + 2*m * ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)  )
    def Cc(i,j,k):
        return ((2*m)^2 + 2*binomial(2*m,2)*2*m + (i+1) + 2*m * ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)  )
    def Dc(j,k):
        return ((2*m)^2 + 3*binomial(2*m,2)*2*m +1+ ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)                )
    def Ar(i,j,k):
        return ((2*m)^2 + binomial(2*m,2) + 3*binomial(2*m,2)*2*m   + (i+1) + 2*m * ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)  )
    def Br(i,j,k):
        return ((2*m)^2 + binomial(2*m,2) + 4*binomial(2*m,2)*2*m + (i+1) + 2*m * ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)  )
    def Cr(i,j,k):
        return ((2*m)^2 + binomial(2*m,2) + 5*binomial(2*m,2)*2*m + (i+1) + 2*m * ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)  )
    def Dr(j,k):
        return ((2*m)^2 + binomial(2*m,2) + 6*binomial(2*m,2)*2*m +1+ ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)                )
    list_comb2 = Combinations(2*m,2);
    clause_list=[]
    for jj in list_comb2:
        for i in xrange(2*m):
            clause_list.append( [-X(i,jj[0]), - X(i,jj[1]), Ac(i,jj[0],jj[1])  ])
            clause_list.append( [X(i,jj[0]), -Ac(i,jj[0],jj[1])  ])
            clause_list.append( [X(i,jj[1]), -Ac(i,jj[0],jj[1])  ])
            clause_list.append( [X(i,jj[0]), X(i,jj[1]), Bc(i,jj[0],jj[1])  ])
            clause_list.append( [-X(i,jj[0]),- Bc(i,jj[0],jj[1])  ])
            clause_list.append( [-X(i,jj[1]),- Bc(i,jj[0],jj[1])  ])
            clause_list.append( [Ac(i,jj[0],jj[1]),Bc(i,jj[0],jj[1]),-Cc(i,jj[0],jj[1]) ])
            clause_list.append( [-Ac(i,jj[0],jj[1]),Cc(i,jj[0],jj[1]) ])
            clause_list.append( [-Bc(i,jj[0],jj[1]),Cc(i,jj[0],jj[1]) ])
            clause_list.append( [Dc(jj[0],jj[1]),Cc(i,jj[0],jj[1]) ])
            clause_list.append( [-X(jj[0],i), - X(jj[1],i), Ar(i,jj[0],jj[1])  ])
            clause_list.append( [X(jj[0],i), -Ar(i,jj[0],jj[1])  ])
            clause_list.append( [X(jj[1],i), -Ar(i,jj[0],jj[1])  ])
            clause_list.append( [X(jj[0],i), X(jj[1],i), Br(i,jj[0],jj[1])  ])
            clause_list.append( [-X(jj[0],i),- Br(i,jj[0],jj[1])  ])
            clause_list.append( [-X(jj[1],i),- Br(i,jj[0],jj[1])  ])
            clause_list.append( [Ar(i,jj[0],jj[1]),Br(i,jj[0],jj[1]),-Cr(i,jj[0],jj[1]) ])
            clause_list.append( [-Ar(i,jj[0],jj[1]),Cr(i,jj[0],jj[1]) ])
            clause_list.append( [-Br(i,jj[0],jj[1]),Cr(i,jj[0],jj[1]) ])
            clause_list.append( [Dr(jj[0],jj[1]),Cr(i,jj[0],jj[1]) ])
        clause_list.append( [Dc(jj[0],jj[1]) ]+ [-Cc(i,jj[0],jj[1]) for i in xrange(2*m)])
        clause_list.append( [Dr(jj[0],jj[1]) ]+ [-Cr(i,jj[0],jj[1]) for i in xrange(2*m)] )
    return(clause_list)


##no 3 consecutive 0 or 1 :  $2 \times  2m \times (2 \times (2m-2))$   clause and each clause have $3$ literal
def no_consecutive(m):
    clause_list=[]
    for i in xrange(2*m):
        for k in xrange(2*m-2):
            clause_col=[i*(2*m)+(j+1) for j in [k..k+2]]
            clause_row=[j*(2*m)+(i+1) for j in [k..k+2]]
            clause_list.append(clause_col)
            clause_list.append(clause_row)
    clause_list_temp=copy(clause_list)
    for clause in clause_list_temp:
        clause_list.append([-el for el in clause]) 
    return clause_list

def filled_cells(m,A):
    fixed_cell =[]
    for i in xrange(2*m):
        for j in xrange(2*m):
            if A[i,j] == 1:
                fixed_cell.append([i*(2*m)+(j+1)])
            if A[i,j] == 0:
                fixed_cell.append([-(i*(2*m)+(j+1))])
    return fixed_cell

def binario_generate_cnf(m,A):
    fixed_cells = filled_cells(m,A);
    vcon1_sat = no_consecutive(m);
    vcon2_sat = balance_list_sat(m);
    vcon3_sat = no_identical(m);
    cnf_binario = [fixed_cells, vcon1_sat, vcon2_sat, vcon3_sat]
    return flatten(cnf_binario,max_level=1)
    

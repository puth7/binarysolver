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
def no_identical(m):
    list_comb=Combinations(xrange(2*m))
    list_2comb=Combinations(xrange(2*m),2)
    clause_list=[]
    for i in  list_2comb:
        for k in list_comb:
            clause_row=[]
            clause_col=[]
            for j in xrange(2*m):
                if j in k:
                    clause_row.append([-(i[0]*2*m+(j+1)), -((i[1]*2*m)+(j+1))])
                    clause_col.append([-((j*2*m)+(i[0]+1)), -((j*2*m)+(i[1]+1))])
                else:
                    clause_row.append([(i[0]*2*m)+(j+1), (i[1]*2*m)+(j+1)])
                    clause_col.append([(j*2*m)+(i[0]+1), (j*2*m)+(i[1]+1)])
            clause_list.append(flatten(clause_col))
            clause_list.append(flatten(clause_row))
    return clause_list

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
    

### this model are supposed to be executed by yices, the purposes is to write a file consisting the model of binary puzzle
#to solve, run yices from shell:
# for ((i=51;i<=500;i++)) do yices binario_smt_bv${i}.ys > binario_solved_smt_bv_${i}.txt;done

#1. print  variable: define...
#2. print model: - kendala1, kendala2, kendala3

#suppose we have 2m * 2m puzzle, then there will be (2m)^2 variables for x,
#and 2*(2m)*sum{i}_{i=1}^{2m} variables for z: z_c (collumn), and z_r (row)

##generate variables
def variable(m,f):
    for i in xrange(2*m):
        f.write('(define col_'+str(i)+'::(bitvector '+str(2*m)+'))')
        f.write('\n')
        f.write('(define row_'+str(i)+'::(bitvector '+str(2*m)+'))')
        f.write('\n')
    f.write('\n')

##generate constraint

def cell_constraint(m,f):# cell assigned by column must be the same with cell assigned by row
    for i in xrange(2*m):
        for j in xrange(2*m):
            f.write('(assert(= (bit col_'+str(i)+' '+str(j)+') (bit row_'+str(j)+' '+str(i)+')))')
            f.write('\n')
    f.write('\n')

def first_constraint(m,f): #no three consecutive one and zero ,use xor?
    for i in xrange(2*m):
        for j in xrange(2*m-2):
            f.write('(assert(bv-gt (bv-extract '+str(j+2)+' '+str(j)+' col_'+str(i)+') 0b000))')
            f.write('\n')
            f.write('(assert(bv-lt (bv-extract '+str(j+2)+' '+str(j)+' col_'+str(i)+') 0b111))')
            f.write('\n')
            f.write('(assert(bv-gt (bv-extract '+str(j+2)+' '+str(j)+' row_'+str(i)+') 0b000))')
            f.write('\n')
            f.write('(assert(bv-lt (bv-extract '+str(j+2)+' '+str(j)+' row_'+str(i)+') 0b111))')
            f.write('\n')
    f.write('\n')

def second_constraint(m,f): # balanced condition
    k = ceil(log(2*m+2))-1
    for i in xrange(2*m):
        f.write('(assert(= (mk-bv '+str(k+1)+' '+str(m)+') (bv-add')
        for j in xrange(2*m):
            f.write(' (bv-concat 0b'+'0'*k+' '+' (bv-extract '+str(j)+' '+str(j) +' col_'+str(i)+'))')
        f.write(')))\n')
    for i in xrange(2*m):
        f.write('(assert(= (mk-bv '+str(k+1)+' '+str(m)+') (bv-add')
        for j in xrange(2*m):
            f.write(' (bv-concat 0b'+'0'*k+' '+' (bv-extract '+str(j)+' '+str(j) +' row_'+str(i)+'))')
        f.write(')))\n')
    f.write('\n')   
    
def third_constraint(m,f): # identical constraint
    f.write('(assert(distinct')
    for i in xrange(2*m):
        f.write(' row_'+str(i))
    f.write('))\n')
    f.write('(assert(distinct')
    for i in xrange(2*m):
        f.write(' col_'+str(i))
    f.write('))\n\n')
    
def filled_cells(A,f): #input partial filled puzzle
    for i in xrange(2*m):
        for j in xrange(2*m):
            if A[i][j] == 1:
                f.write('(assert (= true (bit col_'+str(i)+' '+str(j)+')))\n')
            if A[i][j] == 0:
                f.write('(assert (= false (bit col_'+str(i)+' '+str(j)+')))\n')
    f.write('\n')



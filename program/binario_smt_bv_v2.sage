### this model are supposed to be executed by yices, the purposes is to write a file consisting the model of binary puzzle

#1. print  variable: define...
#2. print model: - kendala1, kendala2, kendala3

#suppose we have 2m * 2m puzzle, then there will be (2m)^2 variables for x,
#and 2*(2m)*sum{i}_{i=1}^{2m} variables for z: z_c (collumn), and z_r (row)

#cheking uniquness of solution: using yices: creates 2 set of bv: x,y ::
#  try to solve both with same constraint
#  add constraint: x != y

# learn how to programming in shell. ie. output to file

# + statistics

# m = size puzzle is 2m * 2m; f = file variabel; z = bit vector variable (string)

##generate variables
def variable(m,f,z):
    for i in xrange(2*m):
        f.write('(define '+z+'_col_'+str(i)+'::(bitvector '+str(2*m)+'))')
        f.write('\n')
        f.write('(define '+z+'_row_'+str(i)+'::(bitvector '+str(2*m)+'))')
        f.write('\n')
    f.write('\n')

##generate constraint

def cell_constraint(m,f,z):# cell assigned by column must be the same with cell assigned by row
    for i in xrange(2*m):
        for j in xrange(2*m):
            f.write('(assert(= (bit '+z+'_col_'+str(i)+' '+str(j)+') (bit '+z+'_row_'+str(j)+' '+str(i)+')))')
            f.write('\n')
    f.write('\n')

def first_constraint(m,f,z): #no three consecutive one and zero ,use xor?
    for i in xrange(2*m):
        for j in xrange(2*m-2):
            f.write('(assert(bv-gt (bv-extract '+str(j+2)+' '+str(j)+' '+z+'_col_'+str(i)+') 0b000))')
            f.write('\n')
            f.write('(assert(bv-lt (bv-extract '+str(j+2)+' '+str(j)+' '+z+'_col_'+str(i)+') 0b111))')
            f.write('\n')
            f.write('(assert(bv-gt (bv-extract '+str(j+2)+' '+str(j)+' '+z+'_row_'+str(i)+') 0b000))')
            f.write('\n')
            f.write('(assert(bv-lt (bv-extract '+str(j+2)+' '+str(j)+' '+z+'_row_'+str(i)+') 0b111))')
            f.write('\n')
    f.write('\n')

def second_constraint(m,f,z): # balanced condition
    k = ceil(log(2*m+2))-1
    for i in xrange(2*m):
        f.write('(assert(= (mk-bv '+str(k+1)+' '+str(m)+') (bv-add')
        for j in xrange(2*m):
            f.write(' (bv-concat 0b'+'0'*k+' '+' (bv-extract '+str(j)+' '+str(j) +' '+z+'_col_'+str(i)+'))')
        f.write(')))\n')
    for i in xrange(2*m):
        f.write('(assert(= (mk-bv '+str(k+1)+' '+str(m)+') (bv-add')
        for j in xrange(2*m):
            f.write(' (bv-concat 0b'+'0'*k+' '+' (bv-extract '+str(j)+' '+str(j) +' '+z+'_row_'+str(i)+'))')
        f.write(')))\n')
    f.write('\n')   
    
def third_constraint(m,f,z): # identical constraint
    f.write('(assert(distinct')
    for i in xrange(2*m):
        f.write(' '+z+'_row_'+str(i))
    f.write('))\n')
    f.write('(assert(distinct')
    for i in xrange(2*m):
        f.write(' '+z+'_col_'+str(i))
    f.write('))\n\n')

def distinct_result(m,f,z0,z1):#x != y
    f.write('(assert(or ')
    for i in xrange(2*m):
        f.write(' (distinct ' + z0 + '_row_' + str(i) + ' ' + z1 + '_row_' + str(i)+')' )
    f.write('))\n')
    f.write('(assert(or ')
    for i in xrange(2*m):
        f.write(' (distinct ' + z0 + '_col_' + str(i) + ' ' + z1 + '_col_' + str(i)+')' )
    f.write('))\n\n')

def distinct_result_v2(m,f,var_list):#x != y
    f.write('(assert(or ')
    for i in xrange(2*m):
        f.write(' (distinct ')
        for z in var_list:
            f.write( z + '_row_' + str(i)+ ' ')
        f.write(')' )
    f.write('))\n')
    f.write('(assert(or ')
    for i in xrange(2*m):
        f.write(' (distinct ')
        for z in var_list:
            f.write( z + '_row_' + str(i)+' ')
        f.write(')' )
    f.write('))\n\n')


def filled_cells(A,f,z): #input partial filled puzzle
    for i in xrange(2*m):
        for j in xrange(2*m):
            if A[i][j] == 1:
                f.write('(assert (= true (bit ' + z + '_col_' + str(i) + ' ' + str(j) + ')))\n')
            if A[i][j] == 0:
                f.write('(assert (= false (bit ' + z + '_col_' + str(i) + ' ' + str(j) + ')))\n')
    f.write('\n')
    

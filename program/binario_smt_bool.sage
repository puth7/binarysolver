### this model are supposed to be executed by yices, the purposes is to write a file consisting the model of binary puzzle

#1. print  variable: define...
#2. print model: - kendala1, kendala2, kendala3

#suppose we have 2m * 2m puzzle, then there will be (2m)^2 variables for x,
#and 2*(2m)*sum{i}_{i=1}^{2m} variables for z: z_c (collumn), and z_r (row)


##generate variables
def variable_x(m,f):
    for i in xrange(2*m):
        for j in xrange(2*m):
            f.write('(define x_'+str(i)+'_'+str(j)+'::bool)')
            f.write('\n')
    f.write('\n')
    
def variable_z(m,f):
    for k in xrange(2*m):
        for i in xrange(2*m):
            for j in xrange(i+1):
                f.write('(define zr_'+str(k)+'_'+str(i)+'_'+str(j)+'::bool)')
                f.write('\n')
                f.write('(define zc_'+str(k)+'_'+str(i)+'_'+str(j)+'::bool)')
                f.write('\n')
    f.write('\n')

##generate constraint

def first_constraint(m,f): #no three consecutive one and zero ,use xor?
    for i in xrange(2*m):
        for j in xrange(2m-2):
            f.write('(assert (or 
            
                

def second_constraint(m,f): # balanced condition

def third_constraint(m,f): # identical constraint



f = file('binario_smt.ys','w')
variable_x(2,f)
variable_z(2,f)    
f.close()

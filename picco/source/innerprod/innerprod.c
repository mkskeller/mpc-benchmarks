/*
 * takes the inner product of two inputs
 */

public int LEN = 100000;

public int main() {

    int A[LEN], B[LEN];

    smcinput(A,1,LEN);
    smcinput(B,1,LEN);

    int p = A @ B;

    smcoutput(p,1);
    return 0;

}

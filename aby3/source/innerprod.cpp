#include<iostream>
#include <cryptoTools/Network/IOService.h>

#include "aby3/sh3/Sh3Runtime.h"
#include "aby3/sh3/Sh3Encryptor.h"
#include "aby3/sh3/Sh3Evaluator.h"

#include "innerprod.h"

using namespace oc;
using namespace aby3;

void innerprod_test(oc::u64 partyIdx, std::vector<int>values) {
	if (partyIdx == 0)
    	std::cout << "testing innerprod..." << std::endl;
	
	IOService ios;
	Sh3Encryptor enc;
	Sh3Evaluator eval;
	Sh3Runtime runtime;
	setup_samples(partyIdx, ios, enc, eval, runtime);

	// encrypt (only parties 0,1 provide input)
	u64 rows = values.size();
	si64Matrix A(1, rows);
	si64Matrix B(rows, 1);

	if (partyIdx == 0) {
	    i64Matrix input(1, rows);
	    for (unsigned i = 0; i < rows; i++)
	      input(0, i) = values[i];
	    enc.localIntMatrix(runtime, input, A).get();
	} else {
	    enc.remoteIntMatrix(runtime, A).get();
	}

	if (partyIdx == 1) {
        i64Matrix input(rows, 1);
        for (unsigned i = 0; i < rows; i++)
            input(i, 0) = values[i];
        enc.localIntMatrix(runtime, input, B).get();
	} else {
	    enc.remoteIntMatrix(runtime, B).get();
	}
	
	// parallel multiplications
	si64Matrix sum(1, 1);
	Sh3Task task = runtime.noDependencies();
	task = eval.asyncMul(task, A, B, sum);
	task.get();

	// reveal result
	i64Matrix result;
	enc.revealAll(runtime, sum, result).get();
	std::cout << "result: " << result(0, 0) << std::endl;
}

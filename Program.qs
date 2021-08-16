namespace Project_QRandom {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    
    operation GenerateQubit() : Result {
        use q = Qubit() {
            H(q);
            return MResetZ(q);
        }
    }

    operation SRandomNumber(max : Int) : Int {
        mutable output = 0;
        repeat {
            mutable bits = new Result[0];
            for idxBit in 1..BitSizeI(max) {
                set bits += [GenerateQubit()];
            }
            set output = ResultArrayAsInt(bits);
        } until (output <= max);
        return output;
    }

@EntryPoint()
    operation Number() : Int {
        let max = 35;
        Message($"Generate Random Number Lower Than {max}: ");
        return SRandomNumber(max);
    }
}
.pragma library

function mapTo(value, inputMin, inputMax, outputMin, outputMax, clamp)
{
    var fltEpsilon = 1.19209290e-7;
    if (Math.abs(inputMin - inputMax) < fltEpsilon) {
        return outputMin;
    }
    else {
        var outVal = ((value - inputMin) / (inputMax - inputMin) * (outputMax - outputMin) + outputMin);
        if (clamp) {
            if (outputMax < outputMin) {
                if (outVal < outputMax) {
                    outVal = outputMax;
                }
                else if (outVal > outputMin) {
                    outVal = outputMin;
                }
            }
            else {
                if (outVal > outputMax) {
                    outVal = outputMax;
                }
                else if (outVal < outputMin) {
                    outVal = outputMin;
                }
            }
        }
        return outVal;
    }
}

function clamp(val, outputMax, outputMin) {
    if (outputMax < outputMin) {
        if (val < outputMax) {
            val = outputMax;
        }
        else if (val > outputMin) {
            val = outputMin;
        }
    }
    else {
        if (val > outputMax) {
            val = outputMax;
        }
        else if (val < outputMin) {
            val = outputMin;
        }
    }

    return val;
}

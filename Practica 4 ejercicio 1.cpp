#include <bits/stdc++.h>
using namespace std;

using u32 = uint32_t;
using u64 = uint64_t;

u32 float_to_bits(float f) {
    u32 u; memcpy(&u, &f, sizeof(u)); return u;
}
float bits_to_float(u32 u) {
    float f; memcpy(&f, &u, sizeof(f)); return f;
}
string bits32(u32 x) {
    string s; for (int i = 31; i >= 0; --i) s.push_back(((x >> i) & 1) ? '1' : '0'); return s;
}

int main() {
    float xf, yf;
    cin >> xf >> yf;
    u32 xb = float_to_bits(xf), yb = float_to_bits(yf);
    u32 sx = (xb >> 31) & 1, sy = (yb >> 31) & 1;
    u32 ex = (xb >> 23) & 0xFF, ey = (yb >> 23) & 0xFF;
    u32 mx = xb & 0x7FFFFF, my = yb & 0x7FFFFF;
    const int BIAS = 127;

    bool x0 = (ex == 0 && mx == 0), y0 = (ey == 0 && my == 0);
    if (x0 || y0) {
        u32 rb = ((sx ^ sy) << 31);
        cout << bits32(rb) << " -> " << bits_to_float(rb) << "\n";
        return 0;
    }
    bool xinf = (ex == 0xFF && mx == 0), yinf = (ey == 0xFF && my == 0);
    bool xnan = (ex == 0xFF && mx != 0), ynan = (ey == 0xFF && my != 0);
    if (xnan || ynan || (xinf && y0) || (yinf && x0)) {
        u32 rb = 0x7FC00000u;
        cout << bits32(rb) << " -> NaN\n"; return 0;
    }
    if (xinf || yinf) {
        u32 rb = ((sx ^ sy) << 31) | (0xFFu << 23);
        cout << bits32(rb) << " -> Inf\n"; return 0;
    }

    u32 ma = (ex == 0) ? mx : (mx | (1u << 23));
    u32 mb = (ey == 0) ? my : (my | (1u << 23));
    int exp = int(ex) + int(ey) - BIAS;

    u64 prod = (u64)ma * (u64)mb;
    bool lead47 = (prod & (1ULL << 47));
    if (lead47) exp++;
    int shift = lead47 ? 24 : 23;
    u64 shifted = prod >> shift;
    u64 rem = prod & ((1ULL << shift) - 1);
    bool guard = (rem >> (shift - 1)) & 1ULL;
    bool sticky = (rem & ((1ULL << (shift - 1)) - 1));
    u32 mant = (u32)(shifted & 0xFFFFFFu);
    if (guard && (sticky || (mant & 1))) mant++;
    if (mant & (1u << 24)) { mant >>= 1; exp++; }

    u32 sign = sx ^ sy;
    if (exp >= 255) {
        u32 rb = (sign << 31) | (0xFFu << 23);
        cout << bits32(rb) << " -> Inf\n"; return 0;
    }
    if (exp <= 0) {
        u32 rb = (sign << 31);
        cout << bits32(rb) << " -> 0\n"; return 0;
    }
    u32 expf = (u32)(exp & 0xFF);
    u32 frac = mant & 0x7FFFFF;
    u32 rb = (sign << 31) | (expf << 23) | frac;
    float rf = bits_to_float(rb), native = xf * yf;

    cout << "Emulado: " << bits32(rb) << " -> " << rf << "\n";
    cout << "Nativo : " << bits32(float_to_bits(native)) << " -> " << native << "\n";
    return 0;
}

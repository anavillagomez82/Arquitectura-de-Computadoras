#include <iostream>
#include <vector>
using namespace std;

vector<int> aBin(int x,int n){
    vector<int>b(n,0); if(x<0) x=(1<<n)+x;
    for(int i=0;i<n;i++) b[i]=(x>>i)&1; return b;
}
int aDec(vector<int>b){
    int n=b.size(),v=0; for(int i=0;i<n;i++) v|=(b[i]<<i);
    if(b[n-1]) v-=(1<<n); return v;
}
vector<int> suma(vector<int>a,vector<int>b){
    int n=a.size(),c=0; for(int i=0;i<n;i++){int s=a[i]+b[i]+c;a[i]=s&1;c=s>>1;}return a;
}
vector<int> neg(vector<int>a){
    for(int&i:a)i=1-i; int c=1; for(int i=0;i<a.size();i++){int s=a[i]+c;a[i]=s&1;c=s>>1;}return a;
}
void shift(vector<int>&A,vector<int>&Q,int&Qm1){
    int n=A.size(),msb=A[n-1],nQm1=Q[0];
    for(int i=0;i<n-1;i++) Q[i]=Q[i+1]; Q[n-1]=A[0];
    for(int i=0;i<n-1;i++) A[i]=A[i+1]; A[n-1]=msb; Qm1=nQm1;
}

int main(){
    int n,M,Qd; cin>>n>>M>>Qd;
    auto Mbin=aBin(M,n),Q=aBin(Qd,n),A=vector<int>(n,0); int Qm1=0;
    for(int i=0;i<n;i++){int Q0=Q[0];
        if(Q0==1&&Qm1==0)A=suma(A,neg(Mbin));
        else if(Q0==0&&Qm1==1)A=suma(A,Mbin);
        shift(A,Q,Qm1);}
    vector<int>R(2*n); for(int i=0;i<n;i++){R[i]=Q[i];R[n+i]=A[i];}
    for(int i=2*n-1;i>=0;i--) cout<<R[i]; cout<<"\n"<<aDec(R)<<"\n";
}


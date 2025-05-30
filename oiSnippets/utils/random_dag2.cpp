#include <bits/stdc++.h>
using namespace std;

const int maxn = 1e6+5;
const int maxe = 1e6+5;

std::random_device rd;
std::default_random_engine __rnd(rd());
std::mt19937 mtrnd(rd());
int rnd(int l,int r) {
    return __rnd() % (r-l+1) + l;
}


struct linkList {
    typedef struct {int u,v,w,next;} edge;
    edge e[maxe];
    int h[maxn],edge_cnt=0;
    linkList(){
        edge_cnt=0;
        memset(h,-1,sizeof(h));
    }

    //遍历点u 周围点
    template<typename U>
    void for_each(int u,U func){
        for(int i = h[u] ; i !=-1;i = e[i].next)
            func(e[i].u,e[i].v,e[i].w); //u v w
    }

    void add(int u,int v,int w=0){
        e[edge_cnt] = {u,v,w,h[u]};
        h[u] = edge_cnt++;
    }
    void add2(int u,int v,int w=0){
        add(u,v,w);
        add(v,u,w);
    }
    //下标访问
    edge& operator[](int i){ return e[i]; }
    //返回head[u]
    int operator()(int u){ return h[u]; }
} e;


//maxEdges=0 表示不设置最大的边的数量
void generateRandomDAG(int numberNodes,int maxEdges=0)
{
    int e_cnt = 0;
    for(int i =1;i<=numberNodes;i++) {
        for(int j = i+1; j<=numberNodes;j++)
        {
            if( rnd(0,1) ) {
                e.add(i,j);
                if( maxEdges && ++e_cnt == maxEdges)
                    return;
            }
        }
    }
}

int main () {
    int nodes = 6;
    generateRandomDAG(nodes);
    return 0;
}



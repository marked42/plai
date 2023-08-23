public class norminal {
    public static void main(String[] args) {
        BT t = new node(5, new node(3, new mt(), new mt()), new mt());
        System.out.println(t.size());
    }
}

abstract class BT {
    abstract public int size();
}

class mt extends BT {
    public int size() {
        return 0;
    }
}

class node extends BT {
    int v;
    BT l, r;
    node(int v, BT l, BT r) {
        this.v = v;
        this.l = l;
        this.r = r;
    }

    public int size() {
        return 1 + this.l.size() + this.r.size();
    }
}

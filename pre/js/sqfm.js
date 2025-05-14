const dur = 1 * 1000;

window.addEventListener('load', () => {
    Array.from(document.getElementsByClassName('sqfm')).forEach(go);
});

function go(btn) {
    const dancers = [1,2,3,4,5,6,7,8].map(i => new Dancer(btn.dataset.gid, i));

    const cb = sequence(btn.dataset.anim.split('|').map(specs =>
        combine(fillin(specs.split('/')).map((spec, i) =>
            mkfunc(spec, dancers[i])))));

    let going = false;
    const evfunc = () => {
        if (going) return;
        going = true;
        let start;
        const f = ts => {
            if (start === undefined) start = ts;
            if (ts - start < dur) cb((ts - start) / dur), requestAnimationFrame(f);
            else cb(1), going = false;
        };
        requestAnimationFrame(f);
    };
    btn.addEventListener('click', evfunc);
}

function fillin(specs) {
    if (specs.length === 8) return specs;
    if (specs.length === 4) return specs.concat(specs);
    throw 'oops';
}

function mkfunc(spec, dancer) {
    const f = parse(spec);
    const dx = dancer.x, dy = dancer.y, dr = ((dancer.r % 4) + 4) % 4;

    dancer.x += f.tx(1);
    dancer.y -= f.ty(1);
    dancer.r += f.r(1);

    return ts => {
        const m = [
            [1, 0],
            [0, 1],
            [-1, 0],
            [0, -1]
        ][dr];
        const x = f.tx(ts), y = -f.ty(ts), r = f.r(ts);
        dancer.trans.setAttribute('transform',
            `translate(${dx + x*m[0] + y*m[1]} ${dy + y*m[0] - x*m[1]})`);
        dancer.rot.setAttribute('transform', `rotate(${(dr + r) * 90})`);
    };
}

function Dancer(gid, i) {
    this.trans = document.getElementById(gid+i+'t');
    this.rot = document.getElementById(gid+i+'r');
    this.x = 0;
    this.y = 0;
    this.r = 0;
}

const hump = a => t => a*(1-4*(0.5-t)*(0.5-t));

function parse(spec) {
    let prev = 0;
    const funcs = spec
        // stand there
        .replace(/^0$/, '000')
        // run
        .replace(/^r(\d+)([+-]?)$/, (m, a, b) => `${a}${b||'+'}a2${b||'+'}`)
        // forward
        .replace(/^f(\d+)([+-]?)$/, (m, a, b) => `0${a}${b||'+'}0`)
        // curve
        .replace(/^c(\d+)([+-])(\d+)$/, (m, a, b, c) => `${a}${b||'+'}${c}+1${b||'+'}`)
        .match(/[0a]|\d+[+-]/g).map(m => {
            if (m === '0') return t => 0;
            if (m === 'a') return hump(Math.abs(prev/4));
            const n = parseInt(m.slice(-1) + m.slice(0, m.length-1), 10);
            prev = n;
            return t => t*n;
        });
    return { tx: funcs[0], ty: funcs[1], r: funcs[2] };
}

function combine(funcs) {
    return ts => {
        for (let i = 0; i < 8; ++i) funcs[i](ts);
    };
}

function sequence(anims) {
    const durs = anims.map(() => 1/anims.length);
    return ts => {
        if (ts == 1) return anims[anims.length-1](1);
        for (var i = 0; i < anims.length; ++i) {
            if (ts < durs[i]) return anims[i](ts / durs[i]);
            else ts -= durs[i];
        }
    };
}

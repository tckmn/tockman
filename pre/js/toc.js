window.addEventListener('load', () => {
    const headers = [...document.querySelectorAll('h2,h3')];

    const elt = document.createElement('div');
    elt.classList.add('toc');
    document.body.append(elt);

    for (const h of headers) {
        const row = document.createElement('div');
        row.textContent = h.textContent;
        if (h.tagName === 'H3') row.classList.add('tocsub');
        elt.append(row);
    }
});

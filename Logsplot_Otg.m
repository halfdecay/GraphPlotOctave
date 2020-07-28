[a, b] = textread ('log.txt')
b = (10*log10(b/0.000001) - 10*log10(0.000000978/0.000001))*(-1) / 120 * 1000
a = (a - 34)
a = a(34:end)
b = b(34:end)

plot(a, b, 'r')
grid


xlabel ("t, c");
ylabel ("–Õ«, ‰¡/ÍÏ");

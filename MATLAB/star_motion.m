close all
clear

lambdaPr           = 656.28;         % нм
speedOfLight       = 299792.458;     % км/с

angstremChar       = char(197);      % ASCII код ангстрема
textX              = 635;            % нм, позиция подписи к графику по оси Ox
textY              = 3.3 * 10^(-13); % эрг/cм^2/c/ангстрем, позиция подписи к графику по оси Oy

spectra     = importdata("spectra.csv");
starNames   = importdata("star_names.csv");
lambdaStart = importdata("lambda_start.csv");
lambdaDelta = importdata("lambda_delta.csv");

nWavelengths = size(spectra, 1);
nStars       = size(starNames, 1);

lambdaEnd = lambdaStart + (nWavelengths - 1) * lambdaDelta;
lambda    = (lambdaStart:lambdaDelta:lambdaEnd)';

[spectrumsHa, idx] = min(spectra);
lambdasHa          = lambda(idx);

z = lambdasHa / lambdaPr - 1;
speed = z * speedOfLight;

movaway = starNames(speed > 0);

set(gcf, 'Visible', 'on')
grid on
hold on

title('Спектры звезд')
xlabel('Длина волны, нм')
ylabel(strcat('Интенсивность, эрг/cм^2/c/', angstremChar))
text(textX, textY, 'Георгий Лебедев, Б01-008')

for i = 1:nStars
    if z(i) > 0
        plot(lambda, spectra(:, i), 'LineWidth', 3)
    else
        plot(lambda, spectra(:, i), '--', 'LineWidth', 1)
    end
end

legend(starNames, 'Location', 'northeast')

saveas(gcf, 'спектры.png')
hold off
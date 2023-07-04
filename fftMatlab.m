% Importando os dados de uma planilha excel
data = readtable('fftMatLab.xlsx');

% Extraindo o tempo dos dados
t = table2array(data(:,'t'));

% Extraindo a sustentação dos dados
L = table2array(data(:,'L'));

% Extraindo o arrasto dos dados
D = table2array(data(:,'D'));

% Extraindo o momento dos dados
M = table2array(data(:,'M'));

% Criando o vetor de frequencia
Fs = 1/(t(2)-t(1)); % Frequencia da coleta de amostras
N = length(t); % Numero de amostras
f = ((1:N)*(Fs/N)).'; % Vetor da frequencia

% Performando a fft
FFT_L = abs(fft(L)); % Sustentação
FFT_D = abs(fft(D)); % Arrasto
FFT_M = abs(fft(M)); % Momento

% Calculando o espectro da amplitude dos sinais
PSD_L = abs(FFT_L).^2 / N;
PSD_D = abs(FFT_D).^2 / N;
PSD_M = abs(FFT_M).^2 / N;

% Removendo ruido
FFT_L = FFT_L(2:485);
FFT_D = FFT_D(2:485);
FFT_M = FFT_M(2:485);
PSD_L = PSD_L(2:485);
PSD_D = PSD_D(2:485);
PSD_M = PSD_M(2:485);
f = f(2:485);

% Criando uma tabela com os resultados
results = table(f, FFT_L, FFT_D, FFT_M, PSD_L, PSD_D, PSD_M);

% Renomeando as variaveis
results.Properties.VariableNames = {'Frequency', 'FFT_L', 'FFT_D', 'FFT_M', 'PSD_L', 'PSD_D', 'PSD_M'};

% Exportando os resultados para um arquivo excel
writetable(results, 'results.xlsx');

% Plotando os resultados

% FFT da Sustentação
figure(1);
plot(f, FFT_L);
title('FFT da Sustentação (L)');
xlabel('Frequência (Hz)');
ylabel('Magnitude');

% FFT do Arrasto
figure(2);
plot(f, FFT_D);
title('FFT do Arrasto (D)');
xlabel('Frequência (Hz)');
ylabel('Magnitude');

% FFT do Momento
figure(3);
plot(f, FFT_M);
title('FFT do Momento (M)');
xlabel('Frequência (Hz)');
ylabel('Magnitude');

% PSD da Sustentação
figure(4);
plot(f, PSD_L);
title('PSD da Sustentação (L)');
xlabel('Frequência (Hz)');
ylabel('PSD');

% PSD do Arrasto
figure(5);
plot(f, PSD_D);
title('PSD do Arrasto (D)');
xlabel('Frequência (Hz)');
ylabel('PSD');

% PSD do Momento
figure(6);
plot(f, PSD_M);
title('PSD do Momento (M)');
xlabel('Frequência (Hz)');
ylabel('PSD');

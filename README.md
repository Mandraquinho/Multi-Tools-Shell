# Multi Tools Shell

🇧🇷 **Descrição (PT-BR)**  
O **Multi Tools Shell** é uma ferramenta em **PowerShell** para diagnóstico, manutenção e suporte em sistemas **Windows**. Com interface de linha de comando centralizada, reúne funções essenciais para técnicos e usuários avançados, tornando o gerenciamento do sistema mais ágil e objetivo.

A versão **2.0** traz melhorias de estabilidade, novas funções e um menu ainda mais organizado.

---

## ⚙️ Funcionalidades por Módulo

### 🟢 Menu Principal

- **R** → Rede e Conectividade
- **S** → Sistema e Hardware
- **U** → Usuários e Segurança
- **M** → Monitoramento e Logs
- **O** → Otimização e Performance
- **A** → Assistente de Diagnóstico
- **H** → Ajuda e Documentação
- **X** → Sair

---

### 🔗 Rede e Conectividade

- Mostrar configuração IP (ipconfig /all)
- Testar conectividade (ping google.com)
- Rastrear rota (tracert google.com)
- Redefinir TCP/IP (netsh int ip reset)
- Redefinir Winsock (netsh winsock reset)
- Limpar cache DNS (ipconfig /flushdns)
- Listar adaptadores de rede

### 💻 Sistema e Hardware

- Exibe SO, versão, processador
- Mostra memória total e espaço livre em disco

### 🔐 Usuários e Segurança

- Lista usuários locais, status e último logon

### 📊 Monitoramento e Logs

- Exibe os 10 eventos mais recentes do log do sistema

### 🚀 Otimização e Performance

- Limpa arquivos temporários (TEMP, Prefetch)
- Limpa cache do navegador (Chrome/Edge)
- Lista programas na inicialização

### 🛠️ Assistente de Diagnóstico

- Verificar disco (CHKDSK)
- Verificar arquivos do sistema (SFC)
- Diagnóstico de memória (mdsched)
- Verificar integridade da imagem (DISM)
- Otimizar disco:
  - **Se SSD:** executa TRIM (Optimize-Volume)
  - **Se HDD:** executa desfragmentação (defrag)
  - ⚠️ **Atenção:** Desfragmentação não é realizada em SSDs, protegendo a vida útil do dispositivo.
- Testar velocidade do disco (WinSAT)
- Gerar relatório de energia (powercfg /energy)
- Exibir logs de aplicativos
- Verificar status da licença do Windows

### 🆘 Ajuda e Documentação

- Orientações de uso do menu e atalhos

---

## 📦 Recursos Adicionais

- Exibe IP local e público, com geolocalização
- Mostra status do sistema (RAM livre, disco, data/hora)
- Interface amigável e feedbacks claros
- Mensagens e alertas em português

---

## 🖥️ Requisitos

- **PowerShell 5.1+**
- **Windows 10/11 ou Windows Server 2016+**

---

## 🚀 Instalação e Execução

1. Clone este repositório:

   ```powershell
   git clone https://github.com/Mandraquinho/Multi-Tools-Shell
   cd Multi-Tools-Shell
   ```

2. Baixe o arquivo `MultiToolsShell.ps1`.

3. Abra o **PowerShell como Administrador**.

4. Navegue até a pasta do script:

   ```powershell
   cd "C:\caminho\da\pasta"
   ```

5. Execute o script:

   ```powershell
   PowerShell -ExecutionPolicy Bypass -File "MultiToolsShell.ps1"
   ```

---

## ▶️ Uso Básico

- Navegue pelo menu digitando a letra correspondente à categoria desejada.
- Siga as instruções exibidas em cada módulo.
- Pressione **Enter** para continuar após cada operação.

---

## 📌 Contribuição

Contribuições são bem-vindas!  
Abra **issues** ou envie **pull requests** com melhorias ou correções.

---

**Desenvolvido por Douglas Furlan**  
🔗 [LinkedIn](https://www.linkedin.com/in/douglasfurlans)

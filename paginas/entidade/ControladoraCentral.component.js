/**
 * Construtor da controladora da pagina inicial
 * 
 * Aqui, foi definido como uma classe, mas pode ser instanciada como uma funcao.
 * Nesse caso da classe, necessario ser usado os elementos inerentes a instancia atual (this)
 */
class ControladoraCentral {

    /**
     * Importacao dos elementos nativos injetados pelo SNK.JS ou por modulos devidamente definidos
     */
    constructor (ObjectUtils, Criteria, DateUtils, SanPopup, StringUtils,ServiceProxy,i18n, MessageUtils, $scope) {

        /** **/
        /** REMOCAO DO FRAME (frame de entorno padrao dos componentes de BI)                             **/
        /** **/
        /** Ele recarregara o _iframe_ do componente de BI, por isso, informe o                          **/
        /** local onde ele encontrara novamente a pagina inicial JSP na propriedade                      **/
        /** `paginaInicial`. E faremos a busca do componente a ser recarregado baseado                   **/
        /** no nome exato do componente que devemos informar a propriedade `instancia`                   **/
        /** **/
            JX.removerFrame ({
                paginaInicial: 'paginas/entidade/index.jsp', /** Local da pagina inicial(nao use BASE_FOLDER) **/
                instancia: 'TELA_HTML5'                      /** Nome EXATO (case sensitive) do Componente BI **/
            });
        /** **/

        /* Interceptadores da entidade de tela */
            ObjectUtils.implements (this, IDynaformInterceptor);
            ObjectUtils.implements (this, IDatagridInterceptor);
        /* */

        /* Modulos de componentes necessarios ao sistema */
            this.Criteria       = Criteria;
            this.DateUtils      = DateUtils;
            this.SanPopup       = SanPopup;
            this.StringUtils =  StringUtils;
            this.i18n = i18n;
            this.ServiceProxy = ServiceProxy;
            this.MessageUtils   = MessageUtils;
            this.opcSelEnvio = 'ATUALIZACAO';
            this.notificacaoTitulo = '';
            this.notificacaoDescricao = '';
            this.notificacaoDica = '';
            this.opcEnviarParaSel = 'T';
            this.usuarioList = [];
            this.grupoList = [];
            this.opcEnviarPara = [
            {data: "T", value: "Todos", $$hashKey: "object:215"},
            {data: "G", value: "Grupo", $$hashKey: "object:216"},
            {data: "U", value: "Usuário", $$hashKey: "object:217"}
            ];
        /* */

        /* Variaveis com os dados da entidade principal da tela */
            this.dataset        = undefined;
            this.formulario     = undefined;
            this.nomeEntidade   = `MarcaProduto`;
        /* */

    }


    /**
     * Evento disparado ao se finalizar a criacao e montagem do componente de formulario dinamico
     * 
     * @param { any } dynaform Instancia e informacoes sobre o formulario dinamico
     * @param  { any } dataset Instancia do conjunto de informacoes dos registros para preencher a grade de registros
     */
    aoCarregarDynaform (dynaform, dataset) {

        /* Checa se a tabela carregada eh a entidade */
        if (dataset.getEntityName () === this.nomeEntidade) {

            /* Salva as informacoes da tabela */
            this.dataset    = dataset;
            this.formulario = dynaform;

            /* Inicializa o dataset com os valores iniciais */
            this.dataset.initAndRefresh ();

            /* Alterna o modo de visualizacao do formulario para o modo grade */
            this.formulario.goToGridView ();

        }

    }

    comboEnvParaChange() {
    }

    limparCamposNotificacao() {
        this.notificacaoTitulo = undefined;
        this.notificacaoDescricao = undefined;
        this.notificacaoDica = undefined;
    }

    enviarNotificacao(alerta) {
        let tipoNotificacao = this.opcSelEnvio;
        let enviarPara = this.opcEnviarParaSel;

        if (this.StringUtils.isEmpty(this.notificacaoTitulo)) {
            this.MessageUtils.showAlert(
                this.i18n('Core.AdministracaoServidor.atencao'),
                this.i18n('Core.AdministracaoServidor.msgAlertaTituloNotificacao')
            );
            return;
        }

        if (this.StringUtils.isEmpty(this.notificacaoDescricao)) {
            this.MessageUtils.showAlert(
                this.i18n('Core.AdministracaoServidor.atencao'),
                this.i18n('Core.AdministracaoServidor.msgAlertaDescricaoNotificacao')
            );
            return;
        }

        if (enviarPara === 'U' && this.StringUtils.isEmpty(this.usuarioList)) {
            this.MessageUtils.showAlert(
                this.i18n('Core.AdministracaoServidor.atencao'),
                this.i18n('Core.AdministracaoServidor.selecaoUsuarios')
            );
            return;
        }

        if (enviarPara === 'G' && this.StringUtils.isEmpty(this.grupoList)) {
            this.MessageUtils.showAlert(
                this.i18n('Core.AdministracaoServidor.atencao'),
                this.i18n('Core.AdministracaoServidor.selecaoGrupos')
            );
            return;
        }

        if (tipoNotificacao !== 'ATUALIZACAO' && enviarPara === 'T' && alerta) {
            this.MessageUtils.simpleConfirm(
                this.i18n('Core.AdministracaoServidor.enviarNotificacaoTodos')
            ).then(() => {
                this.enviarNotificacao(false);
            });
            return;
        }

        let importancia = 3;
        if (tipoNotificacao === 'ATUALIZACAO' || tipoNotificacao === 'URGENTE') importancia = 0;
        else if (tipoNotificacao === 'ERRO') importancia = 1;
        else if (tipoNotificacao === 'ATENCAO') importancia = 2;

        let req = {
            aviso: {
                importancia,
                destinatario: [],
                titulo: { $: this.notificacaoTitulo },
                descricao: { $: this.notificacaoDescricao },
                dica: { $: this.StringUtils.isEmpty(this.notificacaoDica) ? '' : this.notificacaoDica }
            }
        };

        if (enviarPara === 'U') {
            for (let id of this.usuarioList) {
                req.aviso.destinatario.push({ id, tipo: 'usuario' });
            }
        } else if (enviarPara === 'G') {
            for (let id of this.grupoList) {
                req.aviso.destinatario.push({ id, tipo: 'grupo' });
            }
        }

        this.ServiceProxy.callService('mge@AvisoSistemaSP.enviarAviso', req)
            .then(() => {
                this.MessageUtils.showInfo(
                    this.MessageUtils.TITLE_INFORMATION,
                    this.i18n('Core.AdministracaoServidor.notificacaoEnviada')
                );
            });
    }


}
<!-- Injecao de variaveis e dependencias para a compilacao do JSP -->
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
    <%@ page import="br.com.sankhya.modelcore.auth.AuthenticationInfo" %>
    <%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
<!--  -->

<!DOCTYPE html>
<html lang= "pt-BR">

<head>
    <title></title><meta charset= "UTF-8" />

    <!-- ESTILOS -->
        <!-- Estilos Externos -->
            <link rel= "stylesheet" href= "https://ajax.googleapis.com/ajax/libs/angular_material/1.2.1/angular-material.min.css" />
            <link rel= "stylesheet" href= "https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" />
        <!-- -->

        <!-- Estilos Internos -->
            <link rel= "stylesheet" href= "/mge/assets/vendors/ui-grid/ui-grid.min.css?v=" />
            <link rel= "stylesheet" href= "/mge/assets/vendors/bootstrap.min.css?v=" />
            <link rel= "stylesheet" href= "/mge/assets/vendors/loading-bar.min.css?v=" />
            <link rel= "stylesheet" href= "/mge/js/jqwidgets/styles/jqx.base.css" />
            <link rel= "stylesheet" href= "/mge/js/jqwidgets/styles/jqx.metro.css" />
            <link rel= "stylesheet" href= "/mge/assets/css/snk.min.css?v=" />
            <link rel= "stylesheet" href= "/mge/assets/vendors/bpmn/css/diagram-js.css" />
            <link rel= "stylesheet" href= "/mge/assets/vendors/bpmn/css/bpmn.css" />
            <link rel= "stylesheet" href= "/mge/assets/vendors/bpmn/css/bpmnsnk.css" />
            <link rel= "stylesheet" href= "/mge/scripts/vendors/fullcalendar/main.min.css?v=" />
            <link rel= "stylesheet" href= "/mge/html5/DynaformLauncher/DynaformLauncher.css" />
        <!-- -->

        <!-- Estilos Customizados -->
            <!-- IMPORTE AQUI SEUS ARQUIVOS CSS -->
        <!--  -->

        <!-- Estilização para remoção forcada da div de componente customizaddo -->
            <style>
                /* Remove o footer de pagina customizada */
                    body > div:nth-child(16) > div:nth-child(3) {
                        height: 0 !important;
                    }
                /* * */

                /* Maximiza o tamanho do modal de criacao de ordem de servico */
                    body > div.modal-type-default.modal.gray-background.no-padding-modal-body.sk-popup.fade.ng-isolate-scope.in > div,
                    body > div.modal-type-default.modal.no-padding-modal-body.sk-popup.ng-isolate-scope.in > div {
                        top: 5px !important;
                        left: 5px !important;
                        width: calc(100% - 10px) !important;
                        height: calc(100% - 10px) !important;
                    }
                        body > div.modal-type-default.modal.gray-background.no-padding-modal-body.sk-popup.fade.ng-isolate-scope.in > div > div,
                        body > div.modal-type-default.modal.no-padding-modal-body.sk-popup.ng-isolate-scope.in > div > div {
                            height: 100% !important;
                        }

                        body > div.modal-type-default.modal.gray-background.no-padding-modal-body.sk-popup.fade.ng-isolate-scope.in > div > div > div.modal-body,
                        body > div.modal-type-default.modal.no-padding-modal-body.sk-popup.ng-isolate-scope.in > div > div > div.modal-body {
                            height: calc(100% - 32px) !important;
                        }
                /* * */
            </style>
        <!-- -->
    <!-- -->


    <!-- SCRIPTS GENERICOS (_NAO MODIFICAR_) -->

        <!-- Configuracao de parametros em tela do Sankhya -->
            <script type= "text/javascript">

                /* Variaveis da internacionalizacao das strings */
                    var locale        = 'pt_BR';
                    var i18nlocal     = null; // .i18n        : buildLocalI18nVar-method : bundle do dic. de dados
                    var i18nAll       = {};   // .i18nBundles : i18nVars-method          : bundle dos defaults
                    var i18nFramework = {};   // .i18nBundles : i18nVars-method          : bundle do framework
                /* */

                /* Validacao da configuracao do workspace para escopo da tela */
                    var localHostname    = window.location.hostname;
                    var ngAppName        = "DynaformLauncherApp";
                    var isSecurityDomain = false;
                    var VSS              = null;
                    var workspace;

                    try {
                        var parentHostname = window.top.window.location.hostname;
                        
                        if (parentHostname == localHostname) {
                            isSecurityDomain = true;
                        }
                        
                        if (isSecurityDomain) {
                            workspace = parent.workspace;

                            if (!workspace) {
                                if (parent.parent.workspace) {
                                    workspace = parent.parent.workspace;
                                }
                            }
                        }
                    } catch (e) {
                        console.error (e);
                    }
                /* */


                /* Processamento das portas de comunicacao com a impressora */
                    var printerAppPort    = 9096;
                    var printerAppSSLPort = 9196;

                    try {
                        if (navigator.userAgent.indexOf ("Electron") !== -1) {
                            if (sessionStorage.getItem ("printerAppPort")) {
                                printerAppPort = parseInt (sessionStorage.getItem ("printerAppPort")); 
                                printerAppSSLPort = printerAppPort + 100;
                            }
                        }
                    } catch (err) {
                        console.log ("Erro ao consultar porta do WC: " + err);
                    }
                /* */

                /* Variaveis uteis da pagina */
                    APPLICATION_NAME= 'DynaformLauncher';
                    MODULE_ID       = 'DynaformLauncher';
                    PCSF            = "I08joRPTKIBHLGw=";
                    PROFILEID       = 'S4W8LB';
                    RAS             = "aXNTdXA=";
                    MGE_PARAMS      = "YnIuY29tLnNhbmtoeWEubWdlLm1vc3RyYS5hdmlzby5wYWdpbmEuaW5pY2lhbF9fPV9fTl9fO19fY29t"
                    + "LmFjY2Vzcy5jb25maWcuaW4uZ3JpZF9fPV9fTl9fO19fY29tLmNvbmZpZ3VyYWNhby5ncmFkZS5yZXNwZWl0YS5jb25maWcu"
                    + "dGVsYV9fPV9fTl9fO19fZ2xvYmFsLmF0YWxoby5hY29lcy5wZXJzb25hbGl6YWRhc19fPV9fTl9fO19fZ2xvYmFsLmNhcnJl"
                    + "Z2FyLnJlZ2lzdHJvcy5pbmljaWFyLnRlbGFfXz1fX05fXztfX2dsb2JhbC5ub3RpZmljYS5hbHRlcmFjYW8uZGF0YXNldF9f"
                    + "PV9fTl9fO19fZ2xvYmFsLm9yZGVuYXIuYWJhcy50b2Rhc2FiYXNfXz1fX05fXztfX2dsb2JhbC5vcmRlbmFyLmFjb2VzLnBl"
                    + "cnNvbmFsaXphZGFzX189X19OX187X19nbG9iYWwub3JkZW5hci5maWx0cm9zLnBlcnNvbmFsaXphZG9zX189X19OX187X19n"
                    + "bG9iYWwucG9ydGEuYXBwLmltcHJlc3Nhb19fPV9fOTA5Nl9fO19fZ2xvYmFsLnVzYS5hcHAuY3Vib19fPV9fTl9fO19fZ2xv"
                    + "YmFsLnVzYS5hcHAuaW1wcmVzc2FvX189X19TX187X19tZ2UuYXRpdmEubXVsdGkuYWJhc19fPV9fMV9fO19fbWdlLmNvcmUu"
                    + "Y29uZmlnLmZvcm0uaHRtbDVfXz1fXzBfXztfX21nZS5jb3JlLmZsZXgudGhlbWVfXz1fX1NfXztfX21nZS5jb3JlLmhhYmls"
                    + "aXRhLnRlbGEuaHRtbDVfXz1fXzBfXztfX21nZS5jb3JlLm1vZG8uZ3JhZGUuY29uZmlndXJhdmVsLnBlc3F1aXNhX189X19T"
                    + "X187X19tZ2UuY29yZS5xdGRlLm1heGltYS5yZWdpc3Ryb3MucGFyYS5leHBvcnRhY2FvX189X181MDAwX187X19tZ2UuY29y"
                    + "ZS50aXBvLmNvbnN1bHRhLmF1dG9tYXRpY2EuY2VwX189X18yX187X19tZ2UuaHRtbDUubm92YS5wZXNxdWlzYS50ZWxhLmlu"
                    + "aWNpYWxfXz1fX1NfXztfX21nZS5xdGQucmVnaXN0cm9zLm1haXMudXRpbGl6YWRvcy5hcHJlc2VudGFjYW9fXz1fX05fXztf"
                    + "X21nZS5xdGQucmVnaXN0cm9zLm1haXMudXRpbGl6YWRvcy5wZXNxdWlzYV9fPV9fMTBfXztfX21nZS5xdGQucmVnaXN0cm9z"
                    + "Lm1haXMudXRpbGl6YWRvcy5yZXNldF9fPV9fMzA=";
                /* */

            </script>
        <!-- -->

        <!-- Modulo de importacao do JQuery -->
        <script src= "/mge/js/util/jquery-1.9.1.min.js?v=">                                                     </script>
        <!-- Gerenciador do token de autenticacao -->
        <script src= "/mge/js/sf/sf.js?v=">                                                                     </script>
        <!-- Modulo responsavel pelo processamento do Base64 -->
        <script src= "/mge/js/util/Base64.js?v=">                                                               </script>
        <!-- Modulo responsavel pela chamada de outros apps do sistema -->
        <script src= "/mge/js/AppletCaller.js?v=">                                                              </script>
        <!-- Modulo responsavel pela impressao -->
        <script src= "/mge/js/impressao.js?v=">                                                                 </script>
        <!-- Modulo para correcao de layout para dispositivos IOS -->
        <script src= "/mge/scripts/custom-native-functions.js?v=">                                              </script>

        <!-- Dependencias e modulos do Angular -->
            <script src= "/mge/scripts/vendors/angular/angular.js?v=">                                          </script>
            <script src= "/mge/scripts/vendors/angular/angular-touch.js?v=">                                    </script>
            <script src= "/mge/scripts/vendors/angular/angular-animate.min.js?v=">                              </script>
            <script src= "/mge/scripts/vendors/angular/angular-aria.min.js?v=">                                 </script>
            <script src= "/mge/scripts/vendors/angular/angular-sanitize.min.js?v=">                             </script>
            <script src= "/mge/scripts/vendors/translate/angular-translate.js?v=">                              </script>
        <!-- -->

        <!-- Modulo da biblioteca de componentes do Angular Material -->
        <script src= "https://ajax.googleapis.com/ajax/libs/angular_material/1.2.1/angular-material.min.js">    </script>
        <!-- Modulo de importacao para transacoes avancadas com o Sankhya -->
        <script src= "https://cdn.jsdelivr.net/gh/wansleynery/SankhyaJX/jx.min.js">                             </script>
        <!-- Modulo responsavel pelo processamento da tela de carregamento -->
        <script src= "https://cdn.jsdelivr.net/npm/sweetalert2@11.4.13/dist/sweetalert2.all.min.js">            </script>
        <!-- Modulo que controla os avisos em tela -->
        <script src= "https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js">                   </script>

        <!-- IMPORTE AQUI SUAS BIBLIOTECAS JS ADICIONAIS -->

        <!-- Dependencias padroes das telas do Sankhya -->
            <script src="/mge/scripts/vendors/ui-bootstrap/ui-bootstrap-tpls.min.js?v=">                        </script>
            <script src="/mge/scripts/vendors/ui-grid/ui-grid.modified.js?v=">                                  </script>
            <script src="/mge/scripts/vendors/numeral/numeral.min.js?v=">                                       </script>
            <script src="/mge/scripts/vendors/moment/moment.min.js">                                            </script>
            <script src="/mge/scripts/vendors/loading-bar/loading-bar.min.js?v=">                               </script>
            <script src="/mge/scripts/vendors/sortable/sortable.min.js?v=">                                     </script>
            <script src="/mge/scripts/vendors/ui-mask/mask.min.js?v=">                                          </script>
            <script src="/mge/scripts/vendors/tinymce/tinymce.min.js?v=">                                       </script>
            <script src="/mge/scripts/vendors/tinymce/uitinymce.js?v=">                                         </script>
            <script src="/mge/scripts/vendors/tinymce/langs/pt_BR.js?v=">                                       </script>
            <script src="/mge/scripts/vendors/tinymce/langs/en_CA.js?v=">                                       </script>
            <script src="/mge/scripts/vendors/ace/ace.min.js?v=">                                               </script>
            <script src="/mge/scripts/vendors/clipboard/clipboard.min.js?v=">                                   </script>
            <script src="/mge/scripts/vendors/ag-grid/ag-grid-enterprise.js?v=">                                </script>
            <script src="/mge/scripts/vendors/bpmn/bpmn-custom-modeler.development.js?v=">                      </script>
            <script src="/mge/scripts/vendors/snapsvg/snap.svg-min.js?v=">                                      </script>
            <script src="/mge/scripts/vendors/crypto-js/crypto-js.js?v=">                                       </script>
            <script src="/mge/scripts/vendors/fullcalendar/main.min.js?v=">                                     </script>
            <script src="/mge/scripts/vendors/fullcalendar/locales/es.js?v=">                                   </script>
            <script src="/mge/scripts/vendors/fullcalendar/locales/pt-br.js?v=">                                </script>
        <!-- -->

        <!-- Dependencias e modulos customizados do Sankhya -->
            <script src= "/mge/js/jqwidgets/jqxcore.js?v=">                                                     </script>
            <script src= "/mge/js/jqwidgets/jqxdata.js?v=">                                                     </script>
            <script src= "/mge/js/jqwidgets/jqxlistbox.js?v=">                                                  </script>
            <script src= "/mge/js/jqwidgets/jqxbuttons.js?v=">                                                  </script>
            <script src= "/mge/js/jqwidgets/jqxscrollbar.js?v=">                                                </script>
            <script src= "/mge/js/jqwidgets/jqxmenu.js?v=">                                                     </script>
            <script src= "/mge/js/jqwidgets/jqxgrid.js?v=">                                                     </script>
            <script src= "/mge/js/jqwidgets/jqxgrid.selection.js?v=">                                           </script>
            <script src= "/mge/js/jqwidgets/jqxgrid.columnsresize.js?v=">                                       </script>
            <script src= "/mge/js/jqwidgets/jqxgrid.columnsreorder.js?v=">                                      </script>
            <script src= "/mge/js/jqwidgets/jqxgrid.sort.js?v=">                                                </script>
            <script src= "/mge/js/jqwidgets/jqxgrid.filter.js?v=">                                              </script>
            <script src= "/mge/js/jqwidgets/jqxgrid.aggregates.js?v=">                                          </script>
            <script src= "/mge/js/jqwidgets/jqxdropdownlist.js?v=">                                             </script>
            <script src= "/mge/scripts/snk.js?v=">                                                              </script>
            <script src= "/mge/scripts/launcher.js?v=">                                                         </script>
        <!-- -->
    <!-- -->


    <!-- CONFIGURACOES -->
        <!-- Importacao das Controladoras -->
            <script src="${BASE_FOLDER}/paginas/entidade/ControladoraCentral.component.js">                     </script>
            <!-- IMPORTE AQUI SUAS CONTROLADORAS -->
        <!-- -->

        <!-- Importacao das Services -->
            <script src="${BASE_FOLDER}/servicos/Impressao.js">                                                 </script>
            <!-- IMPORTE AQUI SUAS SERVICES -->
        <!-- -->

        <!-- Configuracoes editaveis customizadas -->
            <script>
                /* Inicializacao do modulo de tabela do Sankhya */
                    agGrid.LicenseManager.setLicenseKey (""
                        + "Sankhya_Gestao_de_Negocios_Sankhya-W_2Devs6_November_2020__"
                        + "MTYwNDYyMDgwMDAwMA==1f914bb75813904547879033c6de21d2"
                    );
                    agGrid.initialiseAgGridWithAngular1 (angular);
                /* */

                /* Defina aqui o valor que as telas originais setam para essas variaveis */
                    globalThis.APPLICATION_NAME = 'DynaformLauncher';
                    globalThis.MODULE_ID        = 'DynaformLauncher';
                    globalThis.app              = 'App';
                    globalThis.url              = '${BASE_FOLDER}';
                    globalThis.usuario          = '<%= ((AuthenticationInfo) session.getAttribute ("usuarioLogado")).getUserID ().toString () %>';
                /* */

                /* Classe com as configuracoes de processamento de strings de internacionalizacao */
                    class Runner {
                        constructor (SkI18nService, SkWorkspace) {

                            SkWorkspace.unlockSwitchApp ();

                            SkI18nService.setLang (locale);

                            angular.forEach (i18nAll, function (translations, bundleName) {
                                SkI18nService.addBundle (locale, bundleName, translations);
                            });

                            angular.forEach (i18nFramework, function (translations, bundleName) {
                                SkI18nService.addBundle (locale, bundleName, translations);
                            });

                        }
                    }
                /* */

                var DragEventDirective = {};

                angular.forEach (
                    'drag dragend dragenter dragexit dragleave dragover dragstart drop'.split (' '),
                    function (eventName) {
                        var directiveName = 'ng' + eventName.charAt (0).toUpperCase () + eventName.slice (1);

                        DragEventDirective [directiveName] = ['$parse', '$rootScope', function ($parse, $rootScope) {
                            return {
                                restrict: 'A',
                                compile: function ($element, attr) {
                                    var fn = $parse (attr [directiveName], null, true);

                                    return function ngDragEventHandler (scope, element) {
                                        element.on (eventName, function (event) {
                                            var callback = function () {
                                                fn (scope, {$event: event});
                                            };

                                            try {
                                                $timeout (() => scope.$apply (callback), 0);
                                            } catch (e) { /**/ }
                                        });
                                    };
                                }
                            };
                        }];
                    }
                );

                /* Função inicializada pelo Launcher nativo das telas Sankhya que cuida das internacionalizacoes */
                    function startApplication () {

                        /* Instancia o modulo global do AngularJS, bem como todas as suas dependencias e controladoras */
                            angular
                                .module     (globalThis.app, ['snk', 'ngSanitize'])
                                .run        (Runner)
                                .directive  (DragEventDirective)
                                .controller ('ControladoraCentral', ControladoraCentral);
                        /* */

                        /* Inicializa o modulo do AngularJS via manual */
                            angular.bootstrap (document, [ globalThis.app ]);
                        /* */

                    }
                /* */
            </script>
        <!-- -->
    <!-- -->
</head>

<body>

    <!-- Componente necessario para a preparacao fundamental inicial das telas em AngularJS -->


        <!-- Componente responsavel pela montagem automatica da grade e formulario vinculado a entidade -->
        <sk-application
               layout="column"
                    class="dynaform-launcher"
                    ng-controller="ControladoraCentral as ctrl"
        >
                <div ng-include="'html5/AdministracaoServidor/abas/abaNotificacoes.html'" class="ng-scope" style="padding: 50px"><sk-hbox flex="" layout="row" class="ng-scope" >

                            <sk-vbox class="painel-left" id="pnLeft" layout="column">
                                <sk-vbox layout="column">
                                    <span sk-i18n="">Tipo de notificação:</span>
                                    <br>
                                    <sk-radio-input sk-value="ctrl.opcSelEnvio" sk-option="INFO" sk-change="onChange()" sk-enabled="enabled" class="ng-isolate-scope"><label class="radio"><input type="radio" ng-model="value" value="INFO" ng-disabled="!enabled" ng-change="changeHandler()" name="" class="ng-pristine ng-untouched ng-valid checked ng-not-empty"> <span class="outer"><span class="inner"></span> </span><span class="radio-label" >
                                        <b class="ng-scope"><span sk-i18n="">Informação</span></b>
                                    </span></label></sk-radio-input>
                                    <span class="font-italic" sk-i18n="">Notifica o usuário com uma mensagem informativa no botão de notificações do sistema.</span>
                                    <br>

                                    <sk-radio-input sk-value="ctrl.opcSelEnvio" sk-option="ATENCAO" sk-change="onChange()" sk-enabled="enabled" class="ng-isolate-scope"><label class="radio"><input type="radio" ng-model="value" value="ATENCAO" ng-disabled="!enabled" ng-change="changeHandler()" name="" class="ng-pristine ng-untouched ng-valid ng-not-empty"> <span class="outer"><span class="inner"></span> </span><span class="radio-label">
                                        <b class="ng-scope"><span sk-i18n="">Atenção</span></b>
                                    </span></label></sk-radio-input>
                                    <span class="font-italic" sk-i18n="">Notifica o usuário com uma mensagem de alerta no botão de notificações do sistema.</span>
                                    <br>

                                    <sk-radio-input sk-value="ctrl.opcSelEnvio" sk-option="ERRO" sk-change="onChange()" sk-enabled="enabled" class="ng-isolate-scope"><label class="radio"><input type="radio" ng-model="value" value="ERRO" ng-disabled="!enabled" ng-change="changeHandler()" name="" class="ng-pristine ng-untouched ng-valid ng-not-empty"> <span class="outer"><span class="inner"></span> </span><span class="radio-label">
                                        <b class="ng-scope"><span sk-i18n="">Erro</span></b>
                                    </span></label></sk-radio-input>
                                    <span class="font-italic" sk-i18n="">Notifica o usuário com uma mensagem de erro no botão de notificações do sistema.</span>
                                    <br>

                                    <sk-radio-input sk-value="ctrl.opcSelEnvio" sk-option="URGENTE" sk-change="onChange()" sk-enabled="enabled" class="ng-isolate-scope"><label class="radio"><input type="radio" ng-model="value" value="URGENTE" ng-disabled="!enabled" ng-change="changeHandler()" name="" class="ng-pristine ng-untouched ng-valid ng-not-empty"> <span class="outer"><span class="inner"></span> </span><span class="radio-label" >
                                        <b class="ng-scope"><span sk-i18n="">Urgente</span></b>
                                    </span></label></sk-radio-input>
                                    <span class="font-italic" sk-i18n="">Notifica o usuário instantaneamente com uma janela no centro da tela, independente do que ele esteja fazendo.</span>
                                    <br>

                                    <sk-radio-input sk-value="ctrl.opcSelEnvio" sk-option="ATUALIZACAO" sk-change="onChange()" sk-enabled="enabled" class="ng-isolate-scope"><label class="radio"><input type="radio" ng-model="value" value="ATUALIZACAO" ng-disabled="!enabled" ng-change="changeHandler()" name="" class="ng-pristine ng-untouched ng-valid ng-not-empty"> <span class="outer"><span class="inner"></span> </span><span class="radio-label" >
                                        <b class="ng-scope"><span sk-i18n="" sk-popover="" popover-template-url="html5/AdministracaoServidor/abas/popupNotificacaoHorario.html" width="350" height="auto" create-on-load="false" show-btn-apply="false" show-btn-close="false" controller-name="AdministracaoServidorController" controller-as="ctrl" class="ng-isolate-scope">Atualização do sistema</span></b>
                                    </span></label></sk-radio-input>
                                    <span class="font-italic" sk-i18n="">Notifica o usuário instantaneamente com uma mensagem de atualização do sistema.</span>
                                    <br>

                                    <span sk-i18n="">Enviar para:</span>
                                    <sk-combobox sk-value="ctrl.opcEnviarParaSel" sk-allow-null="false" sk-required="false" sk-options="ctrl.opcEnviarPara" sk-change="ctrl.comboEnvParaChange()" class="mbot-10 ng-isolate-scope"><div class="ui-select-container selectize-control single ng-not-empty ng-valid ng-touched" sk-focus-out="onFocusOut" sk-focus="onFocus" outfocus-on="UiSelectFocusEvent" ng-model="modelValue.selected" theme="selectize" ng-disabled="!enabled" on-select="onSelect()" append-to-body="true"><div class="selectize-input" ng-class="{'focus': $select.open, 'disabled': $select.disabled, 'selectize-focus' : $select.focus}" ng-click="$select.activate()"><div ng-hide="($select.open || $select.isEmpty())" class="ui-select-match ng-scope"  title="Todos" allow-clear="true" placeholder="Todos"><span class="ng-binding ng-scope">Todos</span></div><input autocomplete="off" tabindex="-1" class="ui-select-search ui-select-toggle ng-pristine ng-valid ng-empty ng-touched ng-hide" ng-click="$select.toggle($event)" placeholder="Todos" ng-model="$select.search" ng-hide="!$select.searchEnabled || ($select.selected &amp;&amp; !$select.open)" ng-disabled="$select.disabled || $select.isMobile" aria-label="Select box"></div><sk-select-single></sk-select-single><input ng-disabled="$select.disabled || $select.isMobile" class="ui-select-focusser ui-select-offscreen ng-scope" type="text" id="focusser-0" aria-label="Select box focus" aria-haspopup="true" role="button"></div></sk-combobox>

                                    <sk-vbox ng-show="ctrl.opcEnviarParaSel == 'U'" layout="column" class="ng-hide">
                                        <sk-entity-list sk-entity-name="Usuario" sk-value="ctrl.usuarioList" sk-show-checkbox="false" class="ng-isolate-scope"><div flex="" class="entity-list-container"><div layout="row" layout-align="start center" class="checkbox-list-header-container"><sk-checkbox ng-show="!onlyOneSelection &amp;&amp; showCheckBox" accept-indeterminate="true" indeterminate-value="I" ng-model="checkBoxAll" ng-change="atualizaCheckBoxLista()" class="checkbox-list-cbx-header ng-pristine ng-untouched ng-valid ng-isolate-scope ng-not-empty" tooltip="Marcar/desmarcar todos" tooltip-placement="right" tooltip-append-to-body="true" ng-disabled="disableActions" tabindex="0" role="checkbox"><div class="sk-container"><div class="sk-icon"></div></div><div class="sk-label"></div></sk-checkbox><span ng-show="showLabel" class="ng-binding ng-hide"></span><div class="checkbox-list-header" flex="" layout="row" layout-align="start center"><button type="button" ng-class="{'entity-list-margin-left-5' : onlyOneSelection || !showCheckBox}" class="btn btn-default btn-teste-cond ng-binding" ng-click="addItem()" ng-disabled="disableActions"><sk-icon font-icon="plus" class="ng-isolate-scope margin-icon"><span ng-disabled="!enabled" ng-show="visible !== false" ng-class="[prefixIcon, prefixIcon + '-' + fontIcon, skClass]" class="glyphicons glyphicons-plus"></span></sk-icon>Adicionar</button> <button type="button" class="btn btn-default ng-binding" ng-click="removeSelectedItems()" ng-disabled="getSelectedItems().length <= 0" disabled="disabled"><sk-icon font-icon="remove-2" class="ng-isolate-scope margin-icon"><span ng-disabled="!enabled" ng-show="visible !== false" ng-class="[prefixIcon, prefixIcon + '-' + fontIcon, skClass]" class="glyphicons glyphicons-remove-2"></span></sk-icon>Remover</button> <button type="button" class="btn btn-default ng-binding" ng-click="clearAll()" ng-disabled="!hasData()" disabled="disabled"><sk-icon font-icon="delete" class="ng-isolate-scope margin-icon"><span ng-disabled="!enabled" ng-show="visible !== false" ng-class="[prefixIcon, prefixIcon + '-' + fontIcon, skClass]" class="glyphicons glyphicons-delete"></span></sk-icon>Limpar</button></div></div><!-- ngIf: !onlyOneSelection --><div class="checkbox-list-body-container ng-scope" ng-if="!onlyOneSelection"><!-- ngRepeat: item in dataProvider --></div><!-- end ngIf: !onlyOneSelection --><!-- ngIf: onlyOneSelection --></div></sk-entity-list>
                                    </sk-vbox>

                                    <sk-vbox ng-show="ctrl.opcEnviarParaSel == 'G'" layout="column" class="ng-hide">
                                        <sk-entity-list sk-entity-name="GrupoUsuario" sk-value="ctrl.grupoList" sk-show-checkbox="false" sk-only-selection="false" class="ng-isolate-scope"><div flex="" class="entity-list-container"><div layout="row" layout-align="start center" class="checkbox-list-header-container"><sk-checkbox ng-show="!onlyOneSelection &amp;&amp; showCheckBox" accept-indeterminate="true" indeterminate-value="I" ng-model="checkBoxAll" ng-change="atualizaCheckBoxLista()" class="checkbox-list-cbx-header ng-pristine ng-untouched ng-valid ng-isolate-scope ng-not-empty" tooltip="Marcar/desmarcar todos" tooltip-placement="right" tooltip-append-to-body="true" ng-disabled="disableActions" tabindex="0" role="checkbox"><div class="sk-container"><div class="sk-icon"></div></div><div class="sk-label"></div></sk-checkbox><span ng-show="showLabel" class="ng-binding ng-hide"></span><div class="checkbox-list-header" flex="" layout="row" layout-align="start center"><button type="button" ng-class="{'entity-list-margin-left-5' : onlyOneSelection || !showCheckBox}" class="btn btn-default btn-teste-cond ng-binding" ng-click="addItem()" ng-disabled="disableActions"><sk-icon font-icon="plus" class="ng-isolate-scope margin-icon"><span ng-disabled="!enabled" ng-show="visible !== false" ng-class="[prefixIcon, prefixIcon + '-' + fontIcon, skClass]" class="glyphicons glyphicons-plus"></span></sk-icon>Adicionar</button> <button type="button" class="btn btn-default ng-binding" ng-click="removeSelectedItems()" ng-disabled="getSelectedItems().length <= 0" disabled="disabled"><sk-icon font-icon="remove-2" class="ng-isolate-scope margin-icon"><span ng-disabled="!enabled" ng-show="visible !== false" ng-class="[prefixIcon, prefixIcon + '-' + fontIcon, skClass]" class="glyphicons glyphicons-remove-2"></span></sk-icon>Remover</button> <button type="button" class="btn btn-default ng-binding" ng-click="clearAll()" ng-disabled="!hasData()" disabled="disabled"><sk-icon font-icon="delete" class="ng-isolate-scope margin-icon"><span ng-disabled="!enabled" ng-show="visible !== false" ng-class="[prefixIcon, prefixIcon + '-' + fontIcon, skClass]" class="glyphicons glyphicons-delete"></span></sk-icon>Limpar</button></div></div><!-- ngIf: !onlyOneSelection --><div class="checkbox-list-body-container ng-scope" ng-if="!onlyOneSelection"><!-- ngRepeat: item in dataProvider --></div><!-- end ngIf: !onlyOneSelection --><!-- ngIf: onlyOneSelection --></div></sk-entity-list>
                                    </sk-vbox>
                                </sk-vbox>
                            </sk-vbox>

                            <sk-vbox class="mtop-10 mlef-10" layout="column">
                                <sk-simple-form sk-columns="1" class="ng-isolate-scope"><div class="sk-form" flex=""><div class="form-fields-container clearfix" >
                                    <sk-simple-item sk-label="Core.AdministracaoServidor.titulo" sk-required="true" class="ng-scope ng-isolate-scope col-xs-12 col-sm-12"><div class="form-group"><!-- ngIf: !$ctrl.inLine --><div ng-if="!$ctrl.inLine" sk-width="100%" class="ng-scope" style="width: 100%;"><!-- ngIf: $ctrl.labelText || $ctrl.emptyLabel --><label ng-if="$ctrl.labelText || $ctrl.emptyLabel" class="form-input-label simple-label ng-scope required" ng-class="{'required': $ctrl.required, 'has-help-tip': $ctrl.helptip}"><div layout="row"><!-- ngIf: !$ctrl.emptyLabel --><span ng-bind="$ctrl.labelText" ng-if="!$ctrl.emptyLabel" class="ng-binding ng-scope">Título:</span><!-- end ngIf: !$ctrl.emptyLabel --> <span class="required">*</span><!-- ngIf: $ctrl.helptip --></div></label><!-- end ngIf: $ctrl.labelText || $ctrl.emptyLabel --><div class="clearfix"></div><div  id="simple-item-content">
                                        <sk-text-input sk-value="ctrl.notificacaoTitulo" class="ng-scope ng-isolate-scope"><input type="text" id="" class="form-control ng-pristine ng-valid ng-empty ng-valid-maxlength ng-valid-required ng-touched" ng-model="value" ng-model-options="valueOptions" ng-attr-placeholder="{{placeholder}}" ng-disabled="!enabled" ng-required="required" ng-change="changeHandler()" ng-keydown="$event.keyCode !== 13 &amp;&amp; onInputKeydown($event)" ng-keyup="$event.keyCode === 13 &amp;&amp; onInputKeydown($event)" maxlength="" ng-blur="onControleInputFocusOut()"></sk-text-input>
                                    </div></div><!-- end ngIf: !$ctrl.inLine --><!-- ngIf: $ctrl.inLine --></div></sk-simple-item>
                                    <sk-simple-item sk-label="Core.AdministracaoServidor.descricao" sk-required="true" class="ng-scope ng-isolate-scope col-xs-12 col-sm-12"><div class="form-group"><!-- ngIf: !$ctrl.inLine --><div ng-if="!$ctrl.inLine" sk-width="100%" class="ng-scope" style="width: 100%;"><!-- ngIf: $ctrl.labelText || $ctrl.emptyLabel --><label ng-if="$ctrl.labelText || $ctrl.emptyLabel" class="form-input-label simple-label ng-scope required" ng-class="{'required': $ctrl.required, 'has-help-tip': $ctrl.helptip}"><div layout="row"><!-- ngIf: !$ctrl.emptyLabel --><span ng-bind="$ctrl.labelText" ng-if="!$ctrl.emptyLabel" class="ng-binding ng-scope">Descrição:</span><!-- end ngIf: !$ctrl.emptyLabel --> <span class="required">*</span><!-- ngIf: $ctrl.helptip --></div></label><!-- end ngIf: $ctrl.labelText || $ctrl.emptyLabel --><div class="clearfix"></div><div  id="simple-item-content">
                                        <sk-text-area sk-value="ctrl.notificacaoDescricao" class="ng-scope ng-isolate-scope"><textarea id="snk-textarea" ng-style="style" class="form-control text-area-height ng-pristine ng-valid ng-empty ng-valid-maxlength ng-touched" rows="4" ng-model="value" ng-disabled="!enabled" ng-change="changeHandler()" ng-attr-placeholder="{{placeholder | i18n}}" maxlength="" style="resize: vertical"></textarea><sk-icon font-icon="copy" class="copy-clipboard ng-isolate-scope ng-hide" ng-show="!enabled" tooltip="Copiar" tooltip-placement="left" sk-i18n=""><span ng-disabled="!enabled" ng-show="visible !== false" ng-class="[prefixIcon, prefixIcon + '-' + fontIcon, skClass]" class="glyphicons glyphicons-copy"></span></sk-icon></sk-text-area>
                                    </div></div><!-- end ngIf: !$ctrl.inLine --><!-- ngIf: $ctrl.inLine --></div></sk-simple-item>
                                    <sk-simple-item sk-label="Core.AdministracaoServidor.dica" class="ng-scope ng-isolate-scope col-xs-12 col-sm-12"><div class="form-group"><!-- ngIf: !$ctrl.inLine --><div ng-if="!$ctrl.inLine" sk-width="100%" class="ng-scope" style="width: 100%;"><!-- ngIf: $ctrl.labelText || $ctrl.emptyLabel --><label ng-if="$ctrl.labelText || $ctrl.emptyLabel" class="form-input-label simple-label ng-scope" ng-class="{'required': $ctrl.required, 'has-help-tip': $ctrl.helptip}"><div layout="row"><!-- ngIf: !$ctrl.emptyLabel --><span ng-bind="$ctrl.labelText" ng-if="!$ctrl.emptyLabel" class="ng-binding ng-scope">Dica:</span><!-- end ngIf: !$ctrl.emptyLabel --> <span class="required">*</span><!-- ngIf: $ctrl.helptip --></div></label><!-- end ngIf: $ctrl.labelText || $ctrl.emptyLabel --><div class="clearfix"></div><div id="simple-item-content">
                                        <span class="font-italic ng-scope" sk-i18n="">Ex. Em uma notificação podemos relatar um problema no campo descrição. Já no campo dica, podemos descrever uma possível solução.</span>
                                        <sk-text-area sk-value="ctrl.notificacaoDica" class="ng-scope ng-isolate-scope"><textarea id="snk-textarea" ng-style="style" class="form-control text-area-height ng-pristine ng-valid ng-empty ng-valid-maxlength ng-touched" rows="4" ng-model="value" ng-disabled="!enabled" ng-change="changeHandler()" ng-attr-placeholder="{{placeholder | i18n}}" maxlength="" style="resize: vertical"></textarea><sk-icon font-icon="copy" class="copy-clipboard ng-isolate-scope ng-hide" ng-show="!enabled" tooltip="Copiar" tooltip-placement="left" sk-i18n=""><span ng-disabled="!enabled" ng-show="visible !== false" ng-class="[prefixIcon, prefixIcon + '-' + fontIcon, skClass]" class="glyphicons glyphicons-copy"></span></sk-icon></sk-text-area>
                                    </div></div><!-- end ngIf: !$ctrl.inLine --><!-- ngIf: $ctrl.inLine --></div></sk-simple-item>
                                    <button class="mlef-15 btn btn-default ng-scope" default="" ng-click="ctrl.enviarNotificacao(true)" sk-i18n="" style="margin:20px">Enviar</button>
                                    <button default="" ng-click="ctrl.limparCamposNotificacao()" sk-i18n="" class="btn btn-default ng-scope">Limpar</button>
                                    <span class="font-italic mlef-5 ng-scope" sk-i18n="">*Cada usuário logado poderá levar até 1 minuto para receber a notificação</span>
                                </div></div></sk-simple-form>
                            </sk-vbox>

                        </sk-hbox></div>
        </sk-application>

    <!-- -->
</body>
</html>
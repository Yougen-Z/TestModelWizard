/*
 * Copyright (c) 2016 by Zafin, All rights reserved.
 * This source code, and resulting software, is the confidential and proprietary information
 * ("Proprietary Information") and is the intellectual property ("Intellectual Property")
 * of Zafin ("The Company"). You shall not disclose such Proprietary Information and
 * shall use it only in accordance with the terms and conditions of any and all license
 * agreements you have entered into with The Company.
 */
package com.zafin.zplatform.workbench.navigator.wizards

import com.google.inject.Inject
import com.google.inject.Injector
import com.zafin.zplatform.models.Artifact
import com.zafin.zplatform.models.Module
import com.zafin.zplatform.workbench.navigator.util.LanguageServiceProvider
import com.zafin.zplatform.workbench.service.ServiceProvider
import com.zafin.zplatform.workbench.ui.tree.VirtualRepositoryFolder
import com.zafin.zplatform.workbench.workspace.WorkspaceManager
import org.eclipse.core.resources.IFile
import org.eclipse.core.resources.IProject
import org.eclipse.emf.common.util.URI
import org.eclipse.jface.viewers.IStructuredSelection
import org.eclipse.ui.IWorkbench
import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtext.ui.editor.IURIEditorOpener

@Accessors(PROTECTED_GETTER) class NewModelCreationWizard extends NewArtifactCreationWizard {
    private String artifactName
    private String artifactDescription
    private Module module
    private NewModelCreationWizardPage modelWizardPage
    private NewArtifactDescriptionPage descriptionPage
    private IWorkbench workbench
    private IStructuredSelection selection

    @Inject
    IURIEditorOpener editorOpener

    new() {
        LanguageServiceProvider.findService(URI.createURI("dummy.zmodel"), Injector).injectMembers(this)
    }

    override protected getWizardPages() {
        modelWizardPage = new NewModelCreationWizardPage()
        modelWizardPage.module = module
        descriptionPage = new NewArtifactDescriptionPage()
        return #[modelWizardPage, descriptionPage]
    }

    override protected doFinish() {
        val artifact = createArtifact()
        if (modelWizardPage.isOpenInEditor) {
            editorOpener.open(WorkspaceManager.instance.getFileURI(artifact), true)
        }
        return true
    }

    override protected doCancel() {
        true
    }

    override protected doDispose() {
    }

    override protected doCanFinish() {
        true
    }

    override init(IWorkbench workbench, IStructuredSelection selection) {
        this.workbench = workbench
        this.selection = selection
        val selectedObject = selection.getFirstElement()
        if (selectedObject instanceof IProject) {
            module = WorkspaceManager.getInstance().getModule(selectedObject as IProject)
        } else if (selectedObject instanceof IFile) {
            val artifact = WorkspaceManager.getInstance().getArtifact(selectedObject as IFile)
            module = artifact.module
        } else if (selectedObject instanceof VirtualRepositoryFolder) { // have to be removed. We can use folder function already.
            val folder = selectedObject as VirtualRepositoryFolder
            if (folder.getParent() instanceof IProject) {
                module = WorkspaceManager.getInstance().getModule(folder.getParent() as IProject)
            } else {
                module = folder.getParent() as Module
            }
        }

    }

    def Artifact createArtifact() {
        return ServiceProvider.getInstance().createArtifact(module,
                                                            modelWizardPage.getArtifactName(),
                                                            modelWizardPage.getArtifactType(), 
                                                            modelWizardPage.getArtifactNamespace(),
                                                            descriptionPage.findWizardDesciption(), 
                                                            getDslDescriptor());
    }

    private def String getDslDescriptor() {
        var String result = '''/**
*
*/
namespace «modelWizardPage.artifactNamespace»

/**
* «modelWizardPage.artifactName» ''';

        switch (modelWizardPage) {
            case modelWizardPage.isZEnumSelected:
                result += '''ZEnum
*/
enum «modelWizardPage.artifactName» {

    instances {
    }
}'''
            case modelWizardPage.isModelSelected:
                result += '''ZModel
*/
«modelWizardPage.modifier» model «modelWizardPage.artifactName» extends «modelWizardPage.parentModelName» {

    attributes {
    }
}'''
            case modelWizardPage.isComponentSelected:
                result += '''ZComponent
*/
component «modelWizardPage.artifactName» {
  
}'''
            default:
                result += '''*/'''
        }
        return result
    }
}

/*
 * Copyright (c) 2016 by Zafin, All rights reserved.
 * This source code, and resulting software, is the confidential and proprietary information
 * ("Proprietary Information") and is the intellectual property ("Intellectual Property")
 * of Zafin ("The Company"). You shall not disclose such Proprietary Information and
 * shall use it only in accordance with the terms and conditions of any and all license
 * agreements you have entered into with The Company.
 */
package com.zafin.zplatform.workbench.navigator.wizards

import org.eclipse.swt.widgets.Composite
import org.eclipse.swt.widgets.Text
import org.eclipse.swt.layout.GridData
import org.eclipse.swt.SWT
import org.eclipse.swt.widgets.Button
import org.eclipse.jface.wizard.WizardPage
import org.eclipse.xtend.lib.annotations.Accessors
import static extension com.zafin.zplatform.workbench.navigator.lib.SWTExtensions.SWTWidgetExtensions.*
import static extension com.zafin.zplatform.workbench.navigator.lib.SWTExtensions.SWTLayoutExtensions.*
import org.eclipse.swt.events.ModifyEvent
import org.eclipse.swt.events.ModifyListener
import com.zafin.zplatform.models.ArtifactType
import com.zafin.zplatform.workbench.navigator.wizards.widget.NamespaceDropDown
import com.zafin.zplatform.nls.LocalizationUtil
import com.zafin.zplatform.nls.Messages
import com.zafin.zplatform.models.Module
import org.eclipse.xtext.util.Strings

abstract class NewArtifactCreationWizardPage extends WizardPage {
	private int parentNumColumns = 2 // Number of column in parent Composite
	private Text artifactName
	private NamespaceDropDown namespace
	private Button openInEditorChkBox
	@Accessors(PUBLIC_GETTER, PUBLIC_SETTER) Module module
	
	protected new(String title, String description) {
		super(title)
		setTitle(title)
		setDescription(description)
	}
	
	override createControl(Composite parent) {
		val childComposite = parent.addChildComposite()
		childComposite.layout = newGridLayout() => [
			numColumns = parentNumColumns
            makeColumnsEqualWidth = false
            verticalSpacing = 2
		]
        childComposite.addArtifactNamespaceDropDown()
		childComposite.addArtifactNameControl()
		childComposite.addCustomControl()
		childComposite.addLine()
		childComposite.addOpenInEditorCheckbox()
		control = childComposite
		pageComplete = false
        updateNamespace()
	}
	
	def private void addArtifactNameControl(Composite parent) {
        parent.addLabel("Name:", SWT.NULL)
        val childComposite = addInputComposite(parent, 1)
        artifactName = childComposite.addText()
        artifactName.layoutData = newGridData(GridData::FILL_HORIZONTAL)
        
        artifactName.addModifyListener(
        	new ModifyListener() {
        		override modifyText(ModifyEvent e) {
					validate()
				}
        	})
    }

    def private void addArtifactNamespaceDropDown(Composite parent) {
        parent.addLabel(Messages.Navigator_wizard_new_artifact_field_namespace, SWT.NULL)
        
        val childComposite = addInputComposite(parent, 1)
		namespace = new NamespaceDropDown(childComposite, null);
        namespace.setLayoutData(new GridData(GridData.FILL_HORIZONTAL));
    }
	
    def private void addOpenInEditorCheckbox(Composite parent) {
    	val childComposite = addInputComposite(parent, 1)
		childComposite.layoutData = newGridData() => [
    		horizontalAlignment = GridData::FILL_HORIZONTAL
    		verticalAlignment = GridData::BEGINNING
    		horizontalSpan = 2
    	]
		
	   	openInEditorChkBox = childComposite.addButton("Open the artifact in editor", SWT::CHECK)
	    openInEditorChkBox.selection = true
    }
	
	def protected void addLine(Composite parent) 
	{
		parent.addLabel(SWT::SEPARATOR
			.bitwiseOr(SWT::HORIZONTAL)
			.bitwiseOr(SWT::BOLD)) => [
				
			layoutData = newGridData(GridData.FILL_HORIZONTAL) => [
				horizontalSpan = parentNumColumns
			]
		]
	}
	
	def protected void addCustomControl(Composite parent)
	
	def protected Composite addInputComposite(Composite parent, int numCols) {
		val childComposite = parent.addChildComposite()
        childComposite.layout = newGridLayout() => [
            numColumns = numCols
            makeColumnsEqualWidth = false
            marginWidth = 0
        ]
        childComposite.layoutData = newGridData(GridData::FILL_HORIZONTAL)
        return childComposite
	}
	
	def protected void validate() {
	    if (artifactName.text.length >= 3) {
	        pageComplete = true
	    }
	}

    def protected void updateNamespace() {

        if (module != null && namespace != null) {
            val ns = module.getNs()
            namespace.setReadOnlyPrefix(ns.getName())
            val type = getArtifactType().getName()
            val defaultPackage = LocalizationUtil.getDefaultPackageName(type)
            namespace.appendSuggestion(defaultPackage)
        }
    }
    
    def ArtifactType getArtifactType() {
        return null
    }
    
    def getArtifactName() {
        return Strings.toFirstUpper(artifactName.text)
    }
    
    def getArtifactNamespace() {
        return namespace.text
    }
    
    def isOpenInEditor() {
        return openInEditorChkBox.selection
    }

}
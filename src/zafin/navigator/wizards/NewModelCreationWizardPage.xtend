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
import org.eclipse.swt.widgets.Button
import org.eclipse.swt.widgets.Text
import org.eclipse.swt.SWT
import org.eclipse.swt.layout.GridData
import static extension com.zafin.zplatform.workbench.navigator.lib.SWTExtensions.SWTWidgetExtensions.*
import static extension com.zafin.zplatform.workbench.navigator.lib.SWTExtensions.SWTLayoutExtensions.*
import org.eclipse.swt.events.SelectionAdapter
import com.zafin.zplatform.nls.Messages
import org.eclipse.swt.events.SelectionEvent
import com.zafin.zplatform.dsl.zmodel.zModelDsl.EntityType
import com.zafin.zplatform.dsl.zmodel.services.ZModelDslGrammarAccess
import com.google.inject.Inject
import org.eclipse.emf.common.util.URI
import com.google.inject.Injector
import com.zafin.zplatform.workbench.navigator.util.LanguageServiceProvider
import com.zafin.zplatform.models.ArtifactType
import com.zafin.zplatform.workbench.navigator.dialog.ParentZEntitySelectionDialog2
import org.eclipse.jface.window.Window
import org.eclipse.xtext.resource.IEObjectDescription

class NewModelCreationWizardPage extends NewArtifactCreationWizardPage {
	private Button abstractSelButton
    private Button transientSelButton
    private Button nonCacheableSelButton
    private Button domainModelSelButton
    private Button componentModelSelButton
    private Button enumModelSelButton
    private Button browseButton
    private Text parentText
    
    @Inject ZModelDslGrammarAccess grammarAccess
    
    private String abstractText
    private String transientText
    private String nonCacheableText
    

	protected new() {
		super(Messages.Navigator_wizard_new_artifact_title,
              Messages.Navigator_wizard_new_artifact_description)

        LanguageServiceProvider.findService(URI.createURI("dummy.zmodel"), Injector).injectMembers(this)
        abstractText = grammarAccess.getZEntityAccess().getAbstractAbstractKeyword_1_0().getValue()
        transientText = grammarAccess.getZEntityAccess().getTransientTransientKeyword_4_0().getValue()
        nonCacheableText = grammarAccess.getZEntityAccess().getNonCacheableNonCacheableKeyword_5_0().getValue()
	}
	
	override protected addCustomControl(Composite parent) {
		parent.addParentSelectionControl()
		parent.addLine()
		parent.addEntityTypeSelectionControl()
		parent.addModifierControls()
	}

    def void addParentSelectionControl(Composite parent) {
        parent.addLabel("Parent Model:", SWT::NULL)
        
        val childComposite = parent.addChildComposite()
        childComposite.layout = newGridLayout() => [
            numColumns = 2
            makeColumnsEqualWidth = false
            marginWidth = 0
        ]
        childComposite.layoutData = newGridData(GridData::FILL_HORIZONTAL)
		parentText = childComposite.addText(SWT::BORDER.bitwiseOr(SWT::SINGLE))
		parentText.layoutData = newGridData(GridData::FILL_HORIZONTAL)        
        browseButton = childComposite.addButton("Browse...", SWT::PUSH)
        browseButton.addSelectionListener(new SelectionAdapter() {
            override widgetSelected(SelectionEvent e) {
                val parentZEntitySelectionDialog = new ParentZEntitySelectionDialog2(getShell(), module) {
                    override getTitle() {
                        return Messages.ArtifactTypeSelectionDialog_Title_Select_Parent_Type
                    }
                };
                if (parentZEntitySelectionDialog.open() == Window.OK) {
                    val parentModelEod = parentZEntitySelectionDialog.getFirstResult() as IEObjectDescription
                    if (parentModelEod != null) {
                        val modelName = parentModelEod.getName().getLastSegment()
                        parentText.setText(modelName)
                    }
                }
            }
        })
    }
	
	def void addEntityTypeSelectionControl(Composite parent) {
        parent.addLabel("Model Type:", SWT::WRAP)        
        val childComposite = addChildComposite(parent)
        childComposite.layout = newGridLayout() => [
            numColumns = 3
            makeColumnsEqualWidth = true
        ]
        domainModelSelButton = addEntityTypeSelectionButton(childComposite, EntityType.MODEL)
        enumModelSelButton = addEntityTypeSelectionButton(childComposite, EntityType.ENUM)
        componentModelSelButton = addEntityTypeSelectionButton(childComposite, EntityType.COMPONENT)
        domainModelSelButton.selection = true
    }

    def void addModifierControls(Composite parent) {

    	val layout = newGridLayout() => [
            numColumns = 3
            makeColumnsEqualWidth = true
        ]
        
        parent.addLabel("Modefiers:", SWT::NONE)
        val childComposite = parent.addChildComposite(SWT::NULL)
        childComposite.layout = layout
        abstractSelButton = childComposite.addButton(abstractText.toFirstUpper, SWT::CHECK)
        transientSelButton = childComposite.addButton(transientText.toFirstUpper, SWT::CHECK)
        nonCacheableSelButton = childComposite.addButton(nonCacheableText.toFirstUpper, SWT::CHECK)
    }
    
    def private Button addEntityTypeSelectionButton(Composite parent, EntityType entityType) {
        val button = parent.addButton(entityType.getName().toLowerCase().toFirstUpper, SWT::RADIO)
        button.addSelectionListener(new SelectionAdapter() {
            override void widgetSelected(SelectionEvent e) {
                var enableSelection = entityType.equals(EntityType.MODEL)
                updateParentModelSelection(enableSelection)
                updateModifierControlState(enableSelection)
                updateNamespace()
            }
        })
        
        return button
    }
    
    def getModifier() {
        var result = ''''''
        if(isAbstract) result += '''«abstractText» '''
        if(isTransient) result += '''«transientText» '''
        if(isNonCacheable) result += '''«nonCacheableText» '''
        return result
    }
    
    override ArtifactType getArtifactType() {
        if (isZEnumSelected)
            return ArtifactType.ZENUM
        else
            return ArtifactType.DOMAIN_MODEL
    }
    
    def private void updateParentModelSelection(boolean state) {
        parentText.text = ""
        browseButton.enabled = state
    }
    
    def private void updateModifierControlState(boolean state) {
        abstractSelButton.setSelection(false);
        abstractSelButton.setEnabled(state);
        transientSelButton.setSelection(false);
        transientSelButton.setEnabled(state);
        nonCacheableSelButton.setSelection(false);
        nonCacheableSelButton.setEnabled(state);
    }
    
    def getParentModelName() {
        return parentText.text
    }
    
    def isModelSelected() {
        return domainModelSelButton.selection
    }
    
    def isZEnumSelected() {
        return enumModelSelButton.selection
    }
    
    def isComponentSelected() {
        return componentModelSelButton.selection
    }
    
    def isAbstract() {
        return abstractSelButton.selection
    }
    
    def isTransient() {
        return transientSelButton.selection
    }
    
    def isNonCacheable() {
        return nonCacheableSelButton.selection
    }
}

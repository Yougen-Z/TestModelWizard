/*
 * Copyright (c) 2016 by Zafin, All rights reserved.
 * This source code, and resulting software, is the confidential and proprietary information
 * ("Proprietary Information") and is the intellectual property ("Intellectual Property")
 * of Zafin ("The Company"). You shall not disclose such Proprietary Information and
 * shall use it only in accordance with the terms and conditions of any and all license
 * agreements you have entered into with The Company.
 */
package com.zafin.zplatform.workbench.navigator.wizards

import org.eclipse.jface.wizard.WizardPage
import org.eclipse.swt.widgets.Composite
import org.eclipse.swt.SWT
import org.eclipse.swt.layout.GridData
import org.eclipse.swt.widgets.Text
import static extension com.zafin.zplatform.workbench.navigator.lib.SWTExtensions.SWTWidgetExtensions.*
import static extension com.zafin.zplatform.workbench.navigator.lib.SWTExtensions.SWTLayoutExtensions.*

class NewArtifactDescriptionPage extends WizardPage {
	private Text wizardDesciption
	
	protected new() {
		super("Description Page")
		title = "Description Page"
	}
	
	override getNextPage() {
		null
	}
	
	override isPageComplete() {
		true
	}
	
	override createControl(Composite parent) {
				
		val childComposite = parent.addChildComposite()
		childComposite.layout = newGridLayout(2, false)
		childComposite.addArtifactDescriptionControl()
		control = childComposite
		pageComplete = true
	}
	
	def protected void addArtifactDescriptionControl(Composite parent) {
		
        val label = parent.addLabel("Description:", SWT.NULL)
        label.layoutData = newGridData() => [
            horizontalAlignment = GridData.BEGINNING
            verticalAlignment = GridData.BEGINNING
        ]
        
        wizardDesciption = parent.addText(SWT::BORDER.bitwiseOr(SWT::MULTI))
        wizardDesciption.layoutData = newDefaultGridData() => [
            horizontalSpan = 1
            verticalSpan = 1
            minimumHeight = 50
        ]
    }
    
    def findWizardDesciption() {
        return wizardDesciption.text
    }
	
}
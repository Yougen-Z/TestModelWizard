/*
 * Copyright (c) 2016 by Zafin, All rights reserved.
 * This source code, and resulting software, is the confidential and proprietary information
 * ("Proprietary Information") and is the intellectual property ("Intellectual Property")
 * of Zafin ("The Company"). You shall not disclose such Proprietary Information and
 * shall use it only in accordance with the terms and conditions of any and all license
 * agreements you have entered into with The Company.
 */
package com.zafin.zplatform.workbench.navigator.wizards

import java.util.List
import org.eclipse.jface.wizard.Wizard
import org.eclipse.jface.wizard.WizardPage
import org.eclipse.ui.INewWizard

abstract class NewArtifactCreationWizard extends Wizard implements INewWizard {

	override addPages() {
		wizardPages.forEach[wizardPage | addPage(wizardPage)]
	}

	override performFinish() {
		doFinish()
	}

	override performCancel() {
		doCancel()
	}

	override dispose() {
		super.dispose()
		doDispose()
	}

	override canFinish() {
		super.canFinish()
		doCanFinish()
	}

	protected def boolean doCanFinish()

	protected def boolean doFinish()

	protected def boolean doCancel()

	protected def void doDispose()

	protected def List<WizardPage> getWizardPages()
}

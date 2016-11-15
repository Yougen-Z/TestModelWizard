package handlers

import org.eclipse.core.commands.AbstractHandler
import org.eclipse.core.commands.ExecutionEvent
import org.eclipse.core.commands.ExecutionException
import org.eclipse.jface.wizard.IWizard
import org.eclipse.jface.wizard.WizardDialog
import org.eclipse.ui.handlers.HandlerUtil

abstract package class AbstractArtifactWizardHandler extends AbstractHandler {
	override Object execute(ExecutionEvent event) throws ExecutionException {
		new WizardDialog(HandlerUtil.getActiveShell(event), getArtifactCreationWizard()).open()
		return null
	}

	def abstract package IWizard getArtifactCreationWizard()
}

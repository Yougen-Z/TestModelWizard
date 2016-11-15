package testwizard

import java.util.List
import org.eclipse.jface.wizard.Wizard
import org.eclipse.jface.wizard.WizardPage

abstract class NewArtifactCreationWizard extends Wizard {

	override addPages() {
		wizardPages.forEach[addPage(newInstance)]
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

	protected def List<Class<? extends WizardPage>> getWizardPages()
}

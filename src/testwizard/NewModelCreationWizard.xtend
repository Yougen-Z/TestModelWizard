package testwizard

import org.eclipse.ui.IWorkbench
import org.eclipse.jface.viewers.IStructuredSelection

class NewModelCreationWizard extends NewArtifactCreationWizard {

	override protected getWizardPages() {
		return #[NewModelCreationWizardPage, ModelDescriptionPage]
	}

	override protected doFinish() {
		// Your code comes here
		true
	}

	override protected doCancel() {
		// Your code comes here
		true
	}

	override protected doDispose() {
		
	}

	override protected doCanFinish() {
		// Your code comes here
		true
	}
	
	override init(IWorkbench workbench, IStructuredSelection selection) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}

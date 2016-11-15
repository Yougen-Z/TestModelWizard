package testwizard

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

}

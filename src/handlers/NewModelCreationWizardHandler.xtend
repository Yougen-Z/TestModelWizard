package handlers

import testwizard.NewModelCreationWizard

class NewModelCreationWizardHandler extends AbstractArtifactWizardHandler {
	
	override getArtifactCreationWizard() {
		new NewModelCreationWizard
	}
	
}
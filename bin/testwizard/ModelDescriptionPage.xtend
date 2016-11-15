package testwizard

import org.eclipse.jface.wizard.WizardPage
import org.eclipse.swt.widgets.Composite

class ModelDescriptionPage extends WizardPage {
	
	protected new() {
		super("Description Page", "Description Page", null)
	}
	
	override getNextPage() {
		null
	}
	
	override isPageComplete() {
		true
	}
	
	override createControl(Composite parent) {
		// Your code comes here
		control = parent // You could also assign another composite (created inside this method) to the control. 
	}
	
}
package testwizard

import org.eclipse.jface.wizard.WizardPage
import org.eclipse.swt.widgets.Composite

class NewModelCreationWizardPage extends WizardPage {

	protected new() {
		super("New Model Creation", "New Model Creation", null)
	}

	override createControl(Composite parent) {
		// Your code comes here
		control = parent // You could also assign another composite (created inside this method) to the control. 
	}

}

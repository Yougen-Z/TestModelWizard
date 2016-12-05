package testwizard

import org.eclipse.jface.wizard.WizardPage
import org.eclipse.swt.widgets.Composite
import org.eclipse.swt.SWT
import org.eclipse.swt.layout.GridData
import org.eclipse.swt.widgets.Text
import static extension com.lib.SWTExtensions.SWTWidgetExtensions.*
import static extension com.lib.SWTExtensions.SWTLayoutExtensions.*

class ModelDescriptionPage extends WizardPage {
	private Text wizardDesciption
	
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
	
}
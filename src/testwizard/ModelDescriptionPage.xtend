package testwizard

import org.eclipse.jface.wizard.WizardPage
import org.eclipse.swt.widgets.Composite
import org.eclipse.swt.SWT
import org.eclipse.swt.layout.GridData
import org.eclipse.swt.widgets.Text
import static extension com.lib.SWTExtensions.SWTWidgetExtensions.*
import static extension com.lib.SWTExtensions.SWTLayoutExtensions.*

class ModelDescriptionPage extends WizardPage {
	Text wizardDesciption
	
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
		
		control = parent.addChildComposite => [
			layout = newGridLayout => [
                numColumns = 2
                makeColumnsEqualWidth = false
            ]
			addArtifactDescriptionControl
		]
		pageComplete = true
	}
	
	def protected void addArtifactDescriptionControl(Composite parent) {
        parent.addLabel("Description:", SWT.NULL) => [ 
            layoutData = newGridData => [
                horizontalAlignment = GridData.BEGINNING
                verticalAlignment = GridData.BEGINNING
            ]
        ]
        
        wizardDesciption = parent.addText(SWT::BORDER.bitwiseOr(SWT::MULTI)) => [
            layoutData = newGridData => [
                horizontalAlignment = GridData.FILL
                verticalAlignment = GridData.FILL
                grabExcessHorizontalSpace = true
                grabExcessVerticalSpace = true
                horizontalSpan = 1
                verticalSpan = 1
                minimumHeight = 50
            ]
        ]
    }
	
}
package testwizard

import org.eclipse.swt.widgets.Composite
import org.eclipse.swt.widgets.Text
import org.eclipse.swt.layout.GridData
import org.eclipse.swt.SWT
import org.eclipse.swt.widgets.Button
import static extension com.lib.SWTExtensions.SWTWidgetExtensions.*
import static extension com.lib.SWTExtensions.SWTLayoutExtensions.*
import org.eclipse.jface.wizard.WizardPage
import org.eclipse.jface.resource.ImageDescriptor
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors(PROTECTED_GETTER) abstract class NewArtifactCreationWizardPage extends WizardPage {
	private int parentNumColumns = 2 // Number of column in parent Composite
	private Text artifactName
	private Text namespace
	private Button openInEditorChkBox
	
	protected new(String pageName, String title, ImageDescriptor titleImage) {
		super(pageName, title, titleImage)
	}
	
	override createControl(Composite parent) {
		val childComposite = parent.addChildComposite()
		childComposite.layout = newGridLayout() => [
			numColumns = parentNumColumns
            makeColumnsEqualWidth = false
            verticalSpacing = 1
		]
		childComposite.addArtifactNameControl()
		childComposite.addArtifactNamespaceDropDown()
		
		childComposite.addCustomControl()
		
		childComposite.addLine()
		childComposite.addOpenInEditorCheckbox()
		control = childComposite
		pageComplete = true
	}
	
	def private void addArtifactNameControl(Composite parent) {
        parent.addLabel("Name:", SWT.NULL)        
        artifactName = parent.addText(SWT::BORDER.bitwiseOr(SWT::SINGLE))
        artifactName.layoutData = newGridData(GridData::FILL_HORIZONTAL)
    }

    def private void addArtifactNamespaceDropDown(Composite container) {
        container.addLabel("Namespace:", SWT.NULL)
        namespace = container.addText(SWT::BORDER.bitwiseOr(SWT::SINGLE))
        namespace.layoutData = newGridData(GridData::FILL_HORIZONTAL)
    }
	
    def private void addOpenInEditorCheckbox(Composite parent) {
    	val childComposite = parent.addChildComposite(SWT::NULL)    	
		childComposite.layout = newGridLayout()
		childComposite.layoutData = newGridData() => [
    		horizontalAlignment = GridData::FILL_HORIZONTAL
    		verticalAlignment = GridData::BEGINNING
    		horizontalSpan = 2
    	]
		
	   	openInEditorChkBox = childComposite.addButton("Open the artifact in editor", SWT::CHECK)
	    openInEditorChkBox.selection = true
    }
	
	def protected void addLine(Composite parent) 
	{
		parent.addLabel(SWT::SEPARATOR
			.bitwiseOr(SWT::HORIZONTAL)
			.bitwiseOr(SWT::BOLD)) => [
				
			layoutData = newGridData(GridData.FILL_HORIZONTAL) => [
				horizontalSpan = parentNumColumns
			]
		]
	}
	
	protected def void addCustomControl(Composite parent)
	
	override isPageComplete() {
		validate()
	}
	
	protected def boolean validate()
	
}
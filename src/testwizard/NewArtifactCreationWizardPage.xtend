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
import org.eclipse.swt.events.ModifyEvent
import org.eclipse.swt.events.ModifyListener

@Accessors(PUBLIC_GETTER) abstract class NewArtifactCreationWizardPage extends WizardPage {
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
            verticalSpacing = 0
            marginTop = 0
		]
		childComposite.addArtifactNameControl()
		childComposite.addArtifactNamespaceDropDown()		
		childComposite.addCustomControl()		
		childComposite.addLine()
		childComposite.addOpenInEditorCheckbox()
		control = childComposite
		pageComplete = false
	}
	
	def private void addArtifactNameControl(Composite parent) {
        parent.addLabel("Name:", SWT.NULL)
        val childComposite = addInputChildComposite(parent, 1)
        artifactName = childComposite.addText(SWT::BORDER.bitwiseOr(SWT::SINGLE))
        artifactName.layoutData = newGridData(GridData::FILL_HORIZONTAL)
        
        artifactName.addModifyListener(
        	new ModifyListener() {
        		override modifyText(ModifyEvent e) {
					validate()
				}
        	
        })
    }

    def private void addArtifactNamespaceDropDown(Composite parent) {
        parent.addLabel("Namespace:", SWT.NULL)
        
        val childComposite = addInputChildComposite(parent, 1)
		namespace = childComposite.addText(SWT::BORDER.bitwiseOr(SWT::SINGLE))
		namespace.layoutData = newGridData(GridData::FILL_HORIZONTAL)  
    }
	
    def private void addOpenInEditorCheckbox(Composite parent) {
    	val childComposite = addInputChildComposite(parent, 1)
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
	
	protected def void validate()
	
	protected def Composite addInputChildComposite(Composite parent, int numCols) {
		val childComposite = parent.addChildComposite()
        childComposite.layout = newGridLayout() => [
            numColumns = numCols
            makeColumnsEqualWidth = false
            marginWidth = 0
            marginHeight = 3
        ]
        childComposite.layoutData = newGridData(GridData::FILL_HORIZONTAL)
        return childComposite
	}

}
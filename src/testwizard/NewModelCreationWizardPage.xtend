package testwizard

import org.eclipse.jface.wizard.WizardPage
import org.eclipse.swt.widgets.Composite
import org.eclipse.swt.widgets.Button
import org.eclipse.swt.widgets.Text
import org.eclipse.swt.SWT
import static extension com.lib.SWTExtensions.SWTWidgetExtensions.*
import static extension com.lib.SWTExtensions.SWTLayoutExtensions.*
import org.eclipse.swt.layout.GridData

class NewModelCreationWizardPage extends WizardPage {
	Text artifactName
	Text namespace
	Button openInEditorChkBox
	Button abstractSelButton
    Button transientSelButton
    Button nonCacheableSelButton
    Button domainModelSelButton
    Button componentModelSelButton
    Button enumModelSelButton
    Button browseButton
    Text parentText

	protected new() {
		super("New Model Creation", "New Model Creation", null)
	}

	override createControl(Composite parent) {
		val ncol = 2 // Number of column in parent Composite
		
		control = parent.addChildComposite => [
            layout = newGridLayout => [
                numColumns = ncol
                makeColumnsEqualWidth = false
                verticalSpacing = 1
            ]
			addArtifactNameControl
			addArtifactNamespaceDropDown
			addParentSelectionControl
			createLine(ncol)
			addEntityTypeSelectionControl
			addModifierControls
			createLine(ncol)
			addOpenInEditorCheckbox
		]
		pageComplete = true
	}
	
	def protected void addArtifactNameControl(Composite parent) {
        parent.addLabel("Name:", SWT.NULL)        
        artifactName = parent.addText(SWT::BORDER.bitwiseOr(SWT::SINGLE)) => [
            layoutData = newGridData(GridData::FILL_HORIZONTAL)
        ]
    }

    def protected void addArtifactNamespaceDropDown(Composite container) {
        container.addLabel("Namespace:", SWT.NULL)
        namespace = container.addText(SWT::BORDER.bitwiseOr(SWT::SINGLE)) => [
            layoutData = newGridData(GridData::FILL_HORIZONTAL)
        ]
    }

    def void addParentSelectionControl(Composite parent) {        
        parent.addLabel("Parent Model:", SWT::NULL)
        parent.addChildComposite => [
            layout = newGridLayout => [
	            numColumns = 2
	            makeColumnsEqualWidth = false
	            marginWidth = 0
	        ]
            layoutData = newGridData(GridData::FILL_HORIZONTAL)
			parentText = addText(SWT::BORDER.bitwiseOr(SWT::SINGLE)) => [
				layoutData = newGridData(GridData::FILL_HORIZONTAL)
			]
            
            browseButton = addButton(SWT::PUSH) => [
                text = "Browse..."                
            ]
        ]
    }
	
	def void addEntityTypeSelectionControl(Composite parent) {
        parent.addLabel("Model Type:", SWT::WRAP)        
        parent.addChildComposite => [
            layout = newGridLayout => [
                numColumns = 3
                makeColumnsEqualWidth = true
            ]
            domainModelSelButton = addButton(SWT::RADIO) => [
                text = "Model"
                selection = true
            ]
            enumModelSelButton = addButton(SWT::RADIO) => [
                data = "ENUM"
                text = "Enum"
            ]
            componentModelSelButton = addButton(SWT::RADIO) => [
                data = "COMPONENT"
                text = "Component"
            ]
        ]
    }

    def void addModifierControls(Composite parent) {
        parent.addLabel("Modefiers:", SWT::NONE)
        parent.addChildComposite(SWT::NULL) => [
            layout = newGridLayout => [
                numColumns = 3
                makeColumnsEqualWidth = true
            ]
            abstractSelButton = addButton(SWT::CHECK) => [
                text = "Abstract"
            ]
            transientSelButton = addButton(SWT::CHECK) => [
                text = "Abstract"
            ]
            nonCacheableSelButton = addButton(SWT::CHECK) => [
                text = "NonCacheable"
            ]
        ] 
    }
	
    def protected void addOpenInEditorCheckbox(Composite parent) {
    	parent.addChildComposite(SWT::NULL) => [
			layout = newGridLayout
	        openInEditorChkBox = parent.addButton(SWT::CHECK) => [
	        	layoutData = newGridData => [
	        		horizontalAlignment = GridData::FILL_HORIZONTAL
	        		verticalAlignment = GridData::BEGINNING
	        		horizontalSpan = 2
	        	]
	        	text = "Open the artifact in editor"
	        	selection = true
	        ]
        ]
    }
	
	def void createLine(Composite parent, int ncol) 
	{
		parent.addLabel(SWT::SEPARATOR
			.bitwiseOr(SWT::HORIZONTAL)
			.bitwiseOr(SWT::BOLD)) => [
				
			layoutData = newGridData(GridData.FILL_HORIZONTAL) => [
				horizontalSpan = ncol
			]
		]
	}

}

package testwizard

import org.eclipse.swt.widgets.Composite
import org.eclipse.swt.widgets.Button
import org.eclipse.swt.widgets.Text
import org.eclipse.swt.SWT
import static extension com.lib.SWTExtensions.SWTWidgetExtensions.*
import static extension com.lib.SWTExtensions.SWTLayoutExtensions.*
import org.eclipse.swt.layout.GridData

class NewModelCreationWizardPage extends NewArtifactCreationWizardPage {
	private Button abstractSelButton
    private Button transientSelButton
    private Button nonCacheableSelButton
    private Button domainModelSelButton
    private Button componentModelSelButton
    private Button enumModelSelButton
    private Button browseButton
    private Text parentText

	protected new() {
		super("New Model Creation", "New Model Creation", null)
	}
	
	override protected addCustomControl(Composite parent) {
		parent.addParentSelectionControl()
		parent.addLine()
		parent.addEntityTypeSelectionControl()
		parent.addModifierControls()
	}

    def void addParentSelectionControl(Composite parent) {        
        parent.addLabel("Parent Model:", SWT::NULL)
        
        val childComposite = parent.addChildComposite()
        childComposite.layout = newGridLayout() => [
            numColumns = 2
            makeColumnsEqualWidth = false
            marginWidth = 0
        ]
        childComposite.layoutData = newGridData(GridData::FILL_HORIZONTAL)
		parentText = childComposite.addText(SWT::BORDER.bitwiseOr(SWT::SINGLE))
		parentText.layoutData = newGridData(GridData::FILL_HORIZONTAL)        
        browseButton = childComposite.addButton("Browse...", SWT::PUSH)
    }
	
	def void addEntityTypeSelectionControl(Composite parent) {
        parent.addLabel("Model Type:", SWT::WRAP)        
        val childComposite = addChildComposite(parent)
        childComposite.layout = newGridLayout() => [
            numColumns = 3
            makeColumnsEqualWidth = true
        ]
        domainModelSelButton = childComposite.addButton("Model", SWT::RADIO)
        enumModelSelButton = childComposite.addButton("Enum", SWT::RADIO)
        componentModelSelButton = childComposite.addButton("Component", SWT::RADIO)
    }

    def void addModifierControls(Composite parent) {
    	val layout = newGridLayout() => [
            numColumns = 3
            makeColumnsEqualWidth = true
        ]
        parent.addLabel("Modefiers:", SWT::NONE)
        parent.addChildComposite(SWT::NULL) => [
            it.layout = layout
            abstractSelButton = addButton("Abstract", SWT::CHECK)
            transientSelButton = addButton("Abstract", SWT::CHECK)
            nonCacheableSelButton = addButton("NonCacheable", SWT::CHECK)
        ]
    }
				
	override protected validate() {
		pageComplete = artifactName.text.length >= 3
	}

}

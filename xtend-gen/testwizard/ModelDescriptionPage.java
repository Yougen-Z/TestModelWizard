package testwizard;

import org.eclipse.jface.wizard.IWizardPage;
import org.eclipse.jface.wizard.WizardPage;
import org.eclipse.swt.widgets.Composite;

@SuppressWarnings("all")
public class ModelDescriptionPage extends WizardPage {
  protected ModelDescriptionPage() {
    super("Description Page", "Description Page", null);
  }
  
  @Override
  public IWizardPage getNextPage() {
    return null;
  }
  
  @Override
  public boolean isPageComplete() {
    return true;
  }
  
  @Override
  public void createControl(final Composite parent) {
    this.setControl(parent);
  }
}

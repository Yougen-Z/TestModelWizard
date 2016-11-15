package testwizard;

import org.eclipse.jface.wizard.WizardPage;
import org.eclipse.swt.widgets.Composite;

@SuppressWarnings("all")
public class NewModelCreationWizardPage extends WizardPage {
  protected NewModelCreationWizardPage() {
    super("New Model Creation", "New Model Creation", null);
  }
  
  @Override
  public void createControl(final Composite parent) {
    this.setControl(parent);
  }
}

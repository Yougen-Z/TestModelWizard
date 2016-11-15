package testwizard;

import java.util.Collections;
import java.util.List;
import org.eclipse.jface.wizard.WizardPage;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import testwizard.ModelDescriptionPage;
import testwizard.NewArtifactCreationWizard;
import testwizard.NewModelCreationWizardPage;

@SuppressWarnings("all")
public class NewModelCreationWizard extends NewArtifactCreationWizard {
  @Override
  protected List<Class<? extends WizardPage>> getWizardPages() {
    return Collections.<Class<? extends WizardPage>>unmodifiableList(CollectionLiterals.<Class<? extends WizardPage>>newArrayList(NewModelCreationWizardPage.class, ModelDescriptionPage.class));
  }
  
  @Override
  protected boolean doFinish() {
    return true;
  }
  
  @Override
  protected boolean doCancel() {
    return true;
  }
  
  @Override
  protected void doDispose() {
  }
  
  @Override
  protected boolean doCanFinish() {
    return true;
  }
}

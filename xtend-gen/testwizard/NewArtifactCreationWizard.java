package testwizard;

import java.util.List;
import java.util.function.Consumer;
import org.eclipse.jface.wizard.Wizard;
import org.eclipse.jface.wizard.WizardPage;
import org.eclipse.xtext.xbase.lib.Exceptions;

@SuppressWarnings("all")
public abstract class NewArtifactCreationWizard extends Wizard {
  @Override
  public void addPages() {
    List<Class<? extends WizardPage>> _wizardPages = this.getWizardPages();
    final Consumer<Class<? extends WizardPage>> _function = (Class<? extends WizardPage> it) -> {
      try {
        WizardPage _newInstance = it.newInstance();
        this.addPage(_newInstance);
      } catch (Throwable _e) {
        throw Exceptions.sneakyThrow(_e);
      }
    };
    _wizardPages.forEach(_function);
  }
  
  @Override
  public boolean performFinish() {
    return this.doFinish();
  }
  
  @Override
  public boolean performCancel() {
    return this.doCancel();
  }
  
  @Override
  public void dispose() {
    super.dispose();
    this.doDispose();
  }
  
  @Override
  public boolean canFinish() {
    boolean _xblockexpression = false;
    {
      super.canFinish();
      _xblockexpression = this.doCanFinish();
    }
    return _xblockexpression;
  }
  
  protected abstract boolean doCanFinish();
  
  protected abstract boolean doFinish();
  
  protected abstract boolean doCancel();
  
  protected abstract void doDispose();
  
  protected abstract List<Class<? extends WizardPage>> getWizardPages();
}

/*
 * Copyright (c) 2016 by Zafin, All rights reserved.
 * This source code, and resulting software, is the confidential and proprietary information
 * ("Proprietary Information") and is the intellectual property ("Intellectual Property")
 * of Zafin ("The Company"). You shall not disclose such Proprietary Information and
 * shall use it only in accordance with the terms and conditions of any and all license
 * agreements you have entered into with The Company.
 */
package com.zafin.zplatform.workbench.navigator.dialog;

import java.util.Comparator;
import java.util.Set;

import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.core.runtime.IStatus;
import org.eclipse.core.runtime.Status;
import org.eclipse.emf.common.util.URI;
import org.eclipse.jface.dialogs.IDialogSettings;
import org.eclipse.jface.viewers.LabelProvider;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Control;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.ui.dialogs.FilteredItemsSelectionDialog;
import org.eclipse.ui.internal.ide.IDEWorkbenchPlugin;
import org.eclipse.xtext.resource.IEObjectDescription;
import org.eclipse.xtext.resource.IResourceDescriptions;

import com.google.common.collect.Iterables;
import com.google.common.collect.Sets;
import com.google.inject.Inject;
import com.google.inject.Injector;
import com.zafin.zplatform.dsl.zfunction.ZFunctionDslPackage;
import com.zafin.zplatform.dsl.zmodel.zModelDsl.ZModelDslPackage;
import com.zafin.zplatform.dsl.zresource.zResourceDsl.ZResourceDslPackage;
import com.zafin.zplatform.dsl.zview.zViewDsl.ZViewDslPackage;
import com.zafin.zplatform.models.Module;
import com.zafin.zplatform.workbench.navigator.util.LanguageServiceProvider;

public class ArtifactSelectionDialog extends FilteredItemsSelectionDialog {
    private final com.zafin.zplatform.models.Module module;

    private static final String DIALOG_SETTINGS = "com.zafin.zplatform.workbench.navigator.dialog.ArtifactTypeSelectionDialog";
    private static final String INITIAL_FILTER_PATTERN = "?";

    @Inject
    private IResourceDescriptions index;

    private class ArtifactLabelProvider extends LabelProvider {
        @Override
        public String getText(Object element) {
            if (element instanceof IEObjectDescription) {
                return getElementName(element);
            } else if (element instanceof String) {
                return element.toString();
            }
            return "";
        }
    }

    public ArtifactSelectionDialog(Shell shell, com.zafin.zplatform.models.Module module, boolean multi) {
        super(shell, multi);
        super.setDetailsLabelProvider(new ArtifactLabelProvider());
        super.setListLabelProvider(new ArtifactLabelProvider());
        super.setInitialPattern(ArtifactSelectionDialog.INITIAL_FILTER_PATTERN,
                                FilteredItemsSelectionDialog.FULL_SELECTION);
        setTitle(getTitle());
        initDependencyInjector();
        this.module = module;
    }

    private void initDependencyInjector() {
        LanguageServiceProvider.findService(URI.createURI("dummy.zmodel"), Injector.class).injectMembers(this);
    }

    @Override
    protected Control createExtendedContentArea(Composite parent) {
        return null;
    }

    @Override
    protected IDialogSettings getDialogSettings() {
        IDialogSettings settings = IDEWorkbenchPlugin.getDefault()
                                                     .getDialogSettings()
                                                     .getSection(ArtifactSelectionDialog.DIALOG_SETTINGS);
        if (settings == null) {
            settings = IDEWorkbenchPlugin.getDefault()
                                         .getDialogSettings()
                                         .addNewSection(ArtifactSelectionDialog.DIALOG_SETTINGS);
        }
        return settings;
    }

    @Override
    protected IStatus validateItem(Object item) {
        return Status.OK_STATUS;
    }

    @Override
    protected ItemsFilter createFilter() {
        return new ItemsFilter() {
            @Override
            public boolean isConsistentItem(final Object item) {
                return true;
            }

            @Override
            public boolean matchItem(final Object item) {
                return matches(getElementName(item));
            }
        };
    }

    @Override
    protected Comparator<?> getItemsComparator() {
        return new Comparator<IEObjectDescription>() {
            @Override
            public int compare(IEObjectDescription a, IEObjectDescription b) {
                return getElementName(a).compareTo(getElementName(b));
            }
        };
    }

    @Override
    protected void fillContentProvider(AbstractContentProvider contentProvider,
                                       ItemsFilter itemsFilter,
                                       IProgressMonitor progressMonitor) throws CoreException {
        final Set<IEObjectDescription> elements = Sets.newHashSet();
        Iterables.addAll(elements, index.getExportedObjectsByType(ZModelDslPackage.Literals.ZENTITY));
        Iterables.addAll(elements, index.getExportedObjectsByType(ZFunctionDslPackage.Literals.ZFUNCTION));
        Iterables.addAll(elements, index.getExportedObjectsByType(ZViewDslPackage.Literals.ZVIEW));
        Iterables.addAll(elements, index.getExportedObjectsByType(ZResourceDslPackage.Literals.ZRESOURCE));

        for (final IEObjectDescription eod : elements) {
            contentProvider.add(eod, itemsFilter);
            progressMonitor.worked(1);
        }
        progressMonitor.done();
    }

    @Override
    public String getElementName(Object item) {
        final IEObjectDescription element = (IEObjectDescription) item;
        return element.getName().getLastSegment();
    }

    protected String getTitle() {
        return "Select Parent Model";
    }

    public Module getModule() {
        return module;
    }

}

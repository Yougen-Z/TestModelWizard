/*
 * Copyright (c) 2016 by Zafin, All rights reserved.
 * This source code, and resulting software, is the confidential and proprietary information
 * ("Proprietary Information") and is the intellectual property ("Intellectual Property")
 * of Zafin ("The Company"). You shall not disclose such Proprietary Information and
 * shall use it only in accordance with the terms and conditions of any and all license
 * agreements you have entered into with The Company.
 */
package com.zafin.zplatform.workbench.navigator.dialog;

import java.util.List;
import java.util.Set;

import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.xtext.resource.IEObjectDescription;

import com.google.common.collect.Iterables;
import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import com.google.inject.Inject;
import com.zafin.zplatform.dsl.zmodel.index.ZModelIndex;
import com.zafin.zplatform.dsl.zmodel.utils.ZModelDslUtil;
import com.zafin.zplatform.model.common.utils.Constant;
import com.zafin.zplatform.models.ModelsPackage;

public class ParentZEntitySelectionDialog2 extends ArtifactSelectionDialog {
    private static final String MODEL_NAMESPACE_LAST_SEGMENT = ".models";

    @Inject
    ZModelIndex zModelIndex;

    public ParentZEntitySelectionDialog2(Shell shell, com.zafin.zplatform.models.Module module, boolean multi) {
        super(shell, module, multi);
    }

    public ParentZEntitySelectionDialog2(Shell shell, com.zafin.zplatform.models.Module module) {
        super(shell, module, false);
    }

    @Override
    protected void fillContentProvider(AbstractContentProvider contentProvider,
                                       ItemsFilter itemsFilter,
                                       IProgressMonitor progressMonitor) throws CoreException {
        final List<IEObjectDescription> elements = Lists.newArrayList();
        String s = ZModelDslUtil.getNamespace(getModule()) + ParentZEntitySelectionDialog2.MODEL_NAMESPACE_LAST_SEGMENT;
        elements.add(zModelIndex.getModelWithName(Constant.CORE_MODEL_NAMESPACE,
                                                  ModelsPackage.Literals.MODEL.getName()));
        Iterables.addAll(elements, zModelIndex.getZModels(s));
        final Set<String> artifacts = Sets.newHashSet();
        for (final IEObjectDescription eod : elements) {
            if (artifacts.add(getElementName(eod))) {
                contentProvider.add(eod, itemsFilter);
                progressMonitor.worked(1);
            }
        }
        progressMonitor.done();
    }

}

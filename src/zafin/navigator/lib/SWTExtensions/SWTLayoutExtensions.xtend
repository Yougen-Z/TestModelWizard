/*
 * Copyright (c) 2016 by Zafin, All rights reserved.
 * This source code, and resulting software, is the confidential and proprietary information
 * ("Proprietary Information") and is the intellectual property ("Intellectual Property")
 * of Zafin ("The Company"). You shall not disclose such Proprietary Information and
 * shall use it only in accordance with the terms and conditions of any and all license
 * agreements you have entered into with The Company.
 */
package com.zafin.zplatform.workbench.navigator.lib.SWTExtensions

import org.eclipse.swt.layout.GridLayout
import org.eclipse.swt.layout.GridData
import org.eclipse.swt.layout.FillLayout

class SWTLayoutExtensions {
	
	def static GridLayout newGridLayout() {
		new GridLayout
	}
	
	def static GridLayout newGridLayout(int numColumns, boolean makeColumnsEqualWidth) {
		new GridLayout(numColumns, makeColumnsEqualWidth)
	}
	
	def static FillLayout newFillLayout() {
		new FillLayout
	}
	
	def static GridData newGridData() {
		new GridData
	}
	
	def static GridData newGridData(int style) {
		new GridData(style)
	}
	
	def static GridData newDefaultGridData() {
		new GridData => [
			horizontalAlignment = GridData.FILL
			verticalAlignment = GridData.FILL
			grabExcessHorizontalSpace = true
			grabExcessVerticalSpace = true
		]
	}
	
	def static GridData newDefaultGridData(int style) {
		new GridData(style) => [
			horizontalAlignment = GridData.FILL
			verticalAlignment = GridData.FILL
			grabExcessHorizontalSpace = true
			grabExcessVerticalSpace = true
		]
	}
}

package com.lib.SWTExtensions

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

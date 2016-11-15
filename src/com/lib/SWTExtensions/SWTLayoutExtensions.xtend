package com.lib.SWTExtensions

import org.eclipse.swt.layout.GridLayout
import org.eclipse.swt.layout.GridData
import org.eclipse.swt.layout.FillLayout

class SWTLayoutExtensions {
	
	def static newGridLayout() {
		new GridLayout
	}
	
	def static newFillLayout() {
		new FillLayout
	}
	
	def static newGridData() {
		new GridData
	}
	
	def static newGridData(int style) {
		new GridData(style)
	}
}
package com.lib.SWTExtensions

import org.eclipse.swt.widgets.Composite
import org.eclipse.swt.SWT
import org.eclipse.swt.widgets.Text
import org.eclipse.swt.widgets.Label
import org.eclipse.swt.widgets.Button
import org.eclipse.swt.custom.StyledText
import org.eclipse.swt.widgets.Combo

class SWTWidgetExtensions {
	
	def static addChildComposite(Composite parent) {
		new Composite(parent, SWT.NONE)
	}
	
	def static addChildComposite(Composite parent, int style) {
		new Composite(parent, style)
	}
	
	def static addLabel(Composite parent, int style) {
		new Label(parent, style)
	}
	
	def static addLabel(Composite parent, String text, int style) {
		new Label(parent, style) => [
			it.text = text
		]
	}
	
	def static addText(Composite parent, int style) {
		new Text(parent, style)
	}
	
	def static addDefaultText(Composite parent) {
		new Text(parent, SWT::BORDER.bitwiseOr(SWT::SINGLE))
	}
	
	def static addButton(Composite parent, int style) {
		new Button(parent, style)
	}
	
	def static addButton(Composite parent, String text, int style) {
		new Button(parent, style) => [
			it.text = text
		]
	}
	
	def static addStyledText(Composite parent, int style) {
		new StyledText(parent, style)
	}
	
	def static addCombo(Composite parent, int style) {
		new Combo(parent, style)
	}
}

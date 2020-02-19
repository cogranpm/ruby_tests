require 'java'

java_import java.lang.System
java_import org.eclipse.swt.SWT
java_import org.eclipse.swt.widgets.Display
java_import org.eclipse.swt.widgets.Shell
java_import org.eclipse.swt.widgets.Text
java_import org.eclipse.swt.widgets.Composite
java_import java.lang.Runnable
java_import org.eclipse.core.databinding.observable.Realm
java_import org.eclipse.jface.action.IAction
java_import org.eclipse.jface.action.Action
java_import org.eclipse.jface.action.MenuManager
java_import org.eclipse.jface.action.Separator
java_import org.eclipse.jface.action.StatusLineManager

java_import  org.eclipse.jface.databinding.swt.DisplayRealm
java_import org.eclipse.jface.window.ApplicationWindow
java_import org.eclipse.swt.graphics.Image
java_import org.eclipse.swt.graphics.Point
java_import org.eclipse.swt.graphics.Rectangle
java_import org.eclipse.swt.layout.FillLayout


puts System.currentTimeMillis

#swt = Java::org.eclipse.swt
#widgets = Java::org.eclipse.swt.widgets


class MainWindow < ApplicationWindow

  def initialize()
    super(nil)
    addMenuBar
    addToolBar(SWT::FLAT | SWT::WRAP)
    addStatusLine

  end

  def createContents(parent)
    container = Composite.new(parent, SWT::NONE)
    container.setLayout(FillLayout.new)
    txtHello = Text.new(container, SWT::NONE)
    txtHello.text = "Hello World"

    getShell.text = "Kernai"
    container
  end



  def createMenuManager
    menu_manager = MenuManager.new("menu")
    file_menu = MenuManager.new("&File")
    file_menu.add(Separator.new)
    file_menu.add(Quitter.new("&Quit", self))
    menu_manager.add(file_menu)

    test_menu = MenuManager.new("&Test")
    test_action = Class.new(Action){
      def run
        puts "I ran"
      end
    }.new("&test")

    test_menu.add(test_action)
    menu_manager.add(test_menu)

    menu_manager
  end

  def getInitialSize
    Point.new(600, 800)
  end

  # don't use this method or menus etc don't appear
  #def configureShell(shell)

end


class Quitter < Action
# doing a class for each of the actions, had trouble pass self instance to an anonymous inner class or a block
  def initialize(name, window)
    super(name)
    @win = window
    #self.accelerator = ?\C-x 
  end

  def run
    @win.close
  end
end

class Runner
  import Runnable

  def run
    mainWin = MainWindow.new
    mainWin.setBlockOnOpen(true)
    mainWin.open()
    
    #shell = Shell.new(display)
    #txtHello = Text.new(shell, SWT::NONE)
    #txtHello.text = "Hello world"
    #txtHello.pack

    #shell.pack
    #shell.open

   # while not shell.isDisposed
   #   if not display.readAndDispatch
   #     display.sleep
   #   end
   # end

   #display.dispose

  end
end

display = Display::getDefault()
Realm::runWithDefault(DisplayRealm::getRealm(display), Runner.new)
display.dispose()






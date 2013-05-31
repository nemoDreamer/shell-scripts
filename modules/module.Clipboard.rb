module Clipboard
  def copy this
    IO.popen 'pbcopy', 'w' do |io|
      io.print this
    end
  end

  def paste
    `pbpaste`
  end
end

require "test/unit"
require "boot"

class PageTest < Test::Unit::TestCase

  def setup
    @page_name = "test.html"
    @page_title = "Page Title"
    @page_content = "h1. Test h1.\n\nContent"
    @page_keywords = "keywords, are , here"
    @page_description = "Page description"      
  end


  def teardown

  end

  def test_1_save

    assert_raise QuirkyRequirdFieldsException, LoadError do 
      p = Page.save(
      :name => nil,
      :title =>  @page_title,
      :content =>  nil,
      :keywords => @page_keywords,
      :description => nil
      )
    end
  
    assert_raise QuirkyRequirdFieldsException, LoadError do 
      p = Page.save(
      :name => "",
      :title =>  "",
      :content =>  "",
      :keywords => @page_keywords,
      :description => @page_description
      )
    end
    
    p = Page.save(
    :name => @page_name,
    :title =>  @page_title,
    :content =>  @page_content,
    :description => @page_description
    )
    assert File.exist?(QREPOSITORY_PATH + "/#{@page_name}.yaml"), "File #{@page_name}.yaml doesn't exist"
    
    p.keywords = @page_keywords
    p.save

    assert File.exist?(QREPOSITORY_PATH + "/#{@page_name}.yaml"), "File #{@page_name}.yaml doesn't exist"
    Page.destroy(@page_name)
  end

  def test_1_save_instance
    p = Page.new
    assert_raise QuirkyRequirdFieldsException, LoadError do 
      p.save
    end
    assert_raise QuirkyRequirdFieldsException, LoadError do 
      p.description = @page_description
      p.title =  @page_title
      p.content =  @page_content
      p.save
    end
    p.keywords = @page_keywords
    assert !p.is_valid?, "Page valid when it's not supposed to be"
    p.name = @page_name
    assert p.is_valid?, "Page not valid when it's supposed to be"
    p.save

    assert File.exist?(QREPOSITORY_PATH + "/#{@page_name}.yaml"), "File #{@page_name}.yaml doesn't exist"
  end

  def test_2_find
    p = Page.find(@page_name)
    assert_equal @page_name, p.name
    assert_equal @page_title, p.title
    assert_equal @page_content, p.content
    assert_equal @page_keywords, p.keywords
    assert_equal @page_description, p.description                                  
  end

  def test_2_find_error
    assert_raise QuirkyException, LoadError do 
      Page.find(@page_name + " ")
    end
  end

  def test_3_update
    p = Page.find(@page_name)
    p.title =  @page_title + " Updated"
    p.content =  @page_content + " Updated"
    p.keywords = @page_keywords + ", Updated"
    p.description = @page_description + " Updated"
    p.save

    p = Page.find(@page_name)

    assert_equal @page_title + " Updated", p.title
    assert_equal @page_content + " Updated", p.content
    assert_equal @page_keywords + ", Updated", p.keywords
    assert_equal @page_description + " Updated", p.description

    p = Page.save(
    :name => @page_name,
    :title =>  @page_title + " Updated Again",
    :content =>  @page_content + " Updated Again",
    :keywords => @page_keywords + ", Updated Again",
    :description => @page_description + " Updated Again"
    )

    p = Page.find(@page_name)

    assert_equal @page_title + " Updated Again", p.title
    assert_equal @page_content + " Updated Again", p.content
    assert_equal @page_keywords + ", Updated Again", p.keywords
    assert_equal @page_description + " Updated Again", p.description

  end

  def test_4_destroy
    Page.destroy(@page_name)
    assert !File.exist?(QREPOSITORY_PATH + "/#{@page_name}.yaml"), "File #{@page_name}.yaml still exist"
  end

end
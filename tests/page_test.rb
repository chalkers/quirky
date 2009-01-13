require "test/unit"
require "boot"

class PageTest < Test::Unit::TestCase

    def setup
        @page_url = "test.html"
        @page_title = "Page Title"
        @page_content = "h1. Test h1\n\nContent"
        @page_keywords = "keywords, are , here"
        @page_description = "Page description"      
    end


    def teardown

    end


    def test_1_save
        p = Page.new
        p.url = @page_url
        p.title =  @page_title
        p.content =  @page_content
        p.keywords = @page_keywords
        p.description = @page_description
        p.save

        assert File.exist?(QREPOSITORY_PATH + "/#{@page_url}.yaml"), "File #{@page_url}.yaml doesn't exist"
    end

    def test_2_find
        p = Page.find(@page_url)
        assert_equal @page_url, p.url
        assert_equal @page_title, p.title
        assert_equal @page_content, p.content
        assert_equal @page_keywords, p.keywords
        assert_equal @page_description, p.description                                  
    end

    def test_2_find_error
      assert_raise QuirkyException, LoadError do 
        Page.find(@page_url + " ")
      end
    end

    def test_3_update
        p = Page.find(@page_url)
        p.title =  @page_title + " Updated"
        p.content =  @page_content + " Updated"
        p.keywords = @page_keywords + ", Updated"
        p.description = @page_description + " Updated"
        p.save

        p = Page.find(@page_url)

        assert_equal @page_title + " Updated", p.title
        assert_equal @page_content + " Updated", p.content
        assert_equal @page_keywords + ", Updated", p.keywords
        assert_equal @page_description + " Updated", p.description
    end
    
    def test_4_destroy
        Page.destroy(@page_url)
        assert !File.exist?(QREPOSITORY_PATH + "/#{@page_url}.yaml"), "File #{@page_url}.yaml still exist"
    end

    def test_4_destroy_error
        assert_raises QuirkyException, LoadError do
          Page.destroy(@page_url +" ")
        end
    end

end
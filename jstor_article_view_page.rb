class JstorArticleViewPage < JstorBasePage

  attr_reader :page_url

  def initialize(browser_object, doi='1361256', direct_override = false)
    super(browser_object)
    url = (ALIAS_LOCATIONS.has_key?('article-view-ui') && direct_override) ? ITHAKA::Service::Location.new.get_host('article-view-ui') : BASE_JSTOR_URL
    @page_url = URI.join(url,"/stable/#{doi}").to_s
    # @page_url = "http://article-view-ui-test.apps.test.cirrostratus.org/stable/#{doi}".to_s

    #HTML head section
    @title_tag = @browser.title

    #Content Tools
    @download_pdf_link = @browser.link(:text => /PDF/)
    @download_pdf_link_text_newpage = @browser.link(:text => "Download PDF")
    @download_pdf_link_text_oldpage = @browser.link(:text => "View PDF")
    @download_chapter_link = @browser.link(:id => 'chapPdf')
    @view_pdf_link = @browser.link(:id => "pdf") #this is legacy until our page is on firefly
    @view_citation_link = @browser.link(:text => 'View Citation')
    @citation_tools_link = @browser.link(:text => 'Citation Tools')
    @email_citation_link = @browser.link(:text => 'Email Citation')
    @export_citation_link = @browser.link(:text => 'Export Citation')
    @save_citation_link = @browser.link(:text => 'Save Citation')
    @track_citation_link = @browser.link(:text => 'Track Citation')
    @citation_saved = @browser.div(:id => 'citation_saved')
    @citation_tracked = @browser.div(:id => 'citation_tracked')

    #Terms and Conditions Overlay Article View Page
    @jstor_tac_overlay_avp = @browser.link(:id => "acceptTC")

    #Terms and Conditions Overlay Search Results Page
    @jstor_tac_overlay_srp = @browser.link(:id => "acceptTC")

    #Terms and Conditions Overlay Issue TOC
    @jstor_tac_overlay_issue_toc = @browser.link(:id => "acptTC")

    #Errors
    @we_are_sorry_error = @browser.h2(:text => /Sorry/)

    #Links
    @most_accessed_link = @browser.link(:text => 'Most Accessed')
    @most_cited_link = @browser.link(:text => 'Most Cited')
    @welcome_user_block = @browser.div(:class => 'welcome')
    @saved_citations_link = @browser.li(:xpath => "//*[@id='content']/div[3]/div[1]/ul/li[1]/a")
    @shelf_link = @browser.li(:class => 'menu menu-welcome inline-list',:href => '/action/showShelf')
    @provider_statement = @browser.div(:class => 'subcontent-body')
    @shopping_cart_link = @browser.div(:id => 'shopping-cart')
    @back_to_search = @browser.a(:text => /Back to Search Results/)
    @cover_image_link = @browser.a(:xpath => "//*[@id='cover_image']/a")
    @published_by_link = @browser.a(:xpath => "//*[@id='published_by']/a")
    @jstor_t_and_c_link = @browser.a(:text => 'JSTOR Terms And Conditions')
    @more_rights_link = @browser.a(:text => /More Rights Options/)

    #Global Navigation
    @breadcrumbs_journal_link = @browser.a(:xpath => "//*[@id='breadcrumbs_journal']/a")
    @breadcrumbs_issue_link = @browser.li(:id => 'breadcrumbs_issue')
    @pub_logo_image = @browser.img(:src => /userimages/)

    #Publication Info
    @journal_title = @browser.div(:id => 'publication_info')
    @pub_info_link = @browser.link(:text => 'Publication Info')
    @pub_info_header = @browser.div(:id => 'publication_info_header')
    @pub_info_journal = @browser.div(:id => 'publication_info_journal')
    @pub_info_coverage = @browser.div(:id => 'publication_info_coverage')
    @pub_info_links_to_ext_content = @browser.div(:id => 'publication_info_links_to_external_content')
    @pub_info_moving_wall = @browser.div(:id => 'publication_info_moving_wall')
    @pub_moving_wall_def = @browser.div(:id => 'panel1')
    @pub_info_subjects = @browser.div(:id => 'publication_info_subjects')
    @pub_info_collections = @browser.div(:id => 'publication_info_collections')
    @pub_info_published_by = @browser.a(:xpath => "//*[@id='publication_info_published_by']/a")
    @pub_info_issn = @browser.div(:id => 'publication_info_issn')
    @published_by = @browser.div(:id => 'published_by')


    #Publication Info Overlay
    @pub_info_journal_description = @browser.div(:id => 'publication_info_journal_description')

    #Previous Item/Next Item
    @previous_item_link = @browser.link(:text =>/Previous Item/)
    @next_item_link = @browser.link(:text =>/Next Item/)

    #Tabs
    @summary_tab_link = @browser.link(:href => '#summary_tab_contents')
    @page_thumbs_tab_link = @browser.link(:text => 'Page Thumbnails')
    @page_scan_tab_link = @browser.link(:href => '#page_scan_tab_contents')
    @summary_abstract_header = @browser.div(:id => 'summary_abstract_header')
    @article_author = @browser.div(:class => 'author langMatch')

    #Summary Tab
    @sp_article_author = @browser.div(:id =>'summary_bibliographic_information_authors')
    @sp_abstract_contents = @browser.div(:id =>'summary_abstract_contents')
    @sp_formats = @browser.div(:id =>'summary_formats')
    @sp_source_info = @browser.div(:id =>'summary_bibliographic_information_source_info')
    @sp_toc = @browser.div(:id =>'summary_table_of_contents')
    @sp_abstract_link = @browser.link(:text =>'Abstract')
    @sp_bibliographic_information_link = @browser.link(:text =>'Bibliographic Information')
    @sp_author_information_link = @browser.link(:text =>'Author Information')
    @sp_items_citing_this_item_link = @browser.link(:text =>'Items Citing This Item')
    @sp_back_to_top_link = @browser.link(:text =>'(back to top)')
    @sp_summary_notes_ref_contents = @browser.div(:id =>'summary_notes_and_references_contents')
    @sp_article_title = @browser.div(:id => 'summary_article')
    @sp_article_title_bib = @browser.div(:id => 'summary_bibliographic_information_article')

    #Page Scan Tab
    @ps_next_page_link = @browser.span(:class => 'next')
    @ps_prev_page_link = @browser.span(:class => 'previous')
    @ps_article_title = @browser.div(:id => 'page_scan_article')
    @ps_reviewed_work_subtitle = @browser.div(:id => 'page_scan_subtitle')
    @ps_author_info = @browser.div(:id => 'page_scan_author')
    @ps_copyright_statement = @browser.div(:id => 'page_scan_copyright_statement')
    @ps_page_scan_image = @browser.img(:id => 'page_scan_container')
    @ps_current_page = @browser.span(:class => 'page_scan_current_page')
    @ps_journal_title = @browser.h1(:class => 'mbxl')
    @ps_page_range = @browser.div(:id => 'page_scan_page_range')

    #Page Thumbnails Tab
    @pt_page_thumbnails_header = @browser.div(:id => 'page_thumbnails')
    @pt_article_title = @browser.div(:id => 'page_thumbnails_article')
    @pt_author_info = @browser.div(:id => 'page_thumbnails_author')
    @pt_thumbs_number = @browser.div(:id => 'thumbs')
    @pt_copyright_statement = @browser.div(:id => 'page_thumbnail_copyright_statement')
    @pt_summary_author = @browser.div(:id => 'summary_author_information_contents')

    #View Citation
    @view_citation_article_title = @browser.div(:id => 'item_citation_article')
    @view_citation_authors = @browser.div(:id => 'item_citation_authors')
    @view_citation_source_info = @browser.div(:id => 'item_citation_source_info')
    @view_citation_published_by = @browser.div(:id => 'item_citation_published_by')
    @view_citation_stable_doi = @browser.div(:id => 'item_citation_stable_url')

    #CIL Content
    @cilIcon = @browser.link(:class => 'cilIcon newWindow')

    @sc_data = @browser.div(:id => 'SCData')

    @site_catalyst_data = {:page_level => {:pageName => 'Article View',
                                           :ch => 'Journal:Issues:Issue:Article:Scan',
                                           :server => BASE_JSTOR_URL.gsub("http://",""),
                                           :events => 'event13',
                                           :v1 => 'Institutional',
                                           :c2 => 'The Condor',
                                           :v2 => 'Standard',
                                           :c3 => 'The Woodpeckers of the Upper Salinas Valley',
                                           :c4 => 'Cooper Ornithological Society',
                                           :c5 => 'No. 3',
                                           :c6 => 'journal',
                                           :v8 => 'The Condor',
                                           :c9 => 'seq',
                                           :v9 => 'The Woodpeckers of the Upper Salinas Valley',
                                           :v10 => 'Cooper Ornithological Society',
                                           :v11 => 'No. 3',
                                           # :v17 => 'journal',
                                           :c21 => 'Content View',
                                           :v29 => 'JSTOR',
                                           :v34 => 'Logged In',
                                           :c50 => 'H.26.1'
                                            },
                           :link_level => {}}

    yield(self) if block_given?
  end

  def article_view_get_required_data(content_type)
    if content_type == 'journal'
      {content_type => ['article_title','article_author','journal_title','volume','issue','publication_date','pagination','abstract','pamphlet_title','pamphlet_author','review_title','review_author','reviewed_works','reviewed_author','references']}
    end
  end

  def article_view_validate_data_matrix(data_matrix_hash, content_type)
    @successful_variations = 0
    if content_type == 'journal'
      error_messages = data_matrix_hash[content_type].keys.reduce([]) { |errors, metadata|
        puts "Content metadata under test : #{metadata}"
        errors << self.journal_data_validation(@browser, data_matrix_hash[content_type][metadata], metadata)
      }
    end
    [error_messages.flatten, @successful_variations]
  end

  def journal_data_validation(browser, metadata_data_matrix, metadata)
    metadata_data_matrix.keys.reduce([]) do |errors, variation_type|
      status = false
      variation_iid = metadata_data_matrix[variation_type]['iid']
      variation_doi = metadata_data_matrix[variation_type]['doi']
      variation_value = metadata_data_matrix[variation_type]['value']
      unless variation_doi == nil
      content_item_url = "/stable/#{variation_doi}"

      browser.goto (URI.join(@page_url, content_item_url)).to_s
        status = self.verify_title_ps(variation_value)                         if (metadata == 'article_title' || metadata == 'pamphlet_title' || metadata == 'review_title')
        status = self.verify_author_ps(variation_type,variation_value)         if (metadata == 'article_author' || metadata == 'pamphlet_author' || metadata == 'review_author')
        status = self.verify_journal_title(variation_value)                    if metadata == 'journal_title'
        # status = self.verify_title_ps(variation_value)                         if (metadata == 'article_title' || metadata == 'pamphlet_title' || metadata == 'review_title')
        # status = self.verify_author_ps(variation_type,variation_value)         if (metadata == 'article_author' || metadata == 'pamphlet_author' || metadata == 'review_author')
        # status = self.verify_title_pt(variation_value)                         if (metadata == 'article_title' || metadata == 'pamphlet_title' || metadata == 'review_title')
        # status = self.verify_author_pt(variation_type,variation_value)         if (metadata == 'article_author' || metadata == 'pamphlet_author' || metadata == 'review_author')
        # status = self.verify_source_info(variation_value)                   if (metadata == 'volume' || metadata == 'issue' || metadata == 'publication_date' || metadata == 'pagination')
        # status = self.verify_page_count(variation_value)                    if metadata == 'page_count'
        # status = self.verify_abstract(variation_type,variation_value)       if metadata == 'abstract'
        # status = self.verify_semantic_terms(variation_type,variation_value) if metadata == 'semantic_terms'
        # status = self.verify_references(variation_type,variation_value)     if metadata == 'references'
        if status
          @successful_variations+=1
        else
          errors << "#{metadata}-#{variation_type} #{variation_doi} Expected: #{variation_value} Actual  : #{@actual}  #{variation_iid}"
        end
     end
      errors
    end
  end

  def verify_title_ps(variation_value)
    @actual = self.ps_article_title.text
    self.ps_article_title.text == variation_value
  end

  def verify_title_sp(variation_value)
    @actual = self.sp_article_title.text
    self.sp_article_title.text == variation_value
  end

  def verify_title_sp_bib(variation_value)
    @actual = self.sp_article_title_bib.text
    self.sp_article_title_bib.text == variation_value
  end

  def verify_title_pt(variation_value)
    @actual = self.pt_article_title.text
    self.pt_article_title.text == variation_value
  end

  def verify_author_ps(variation_type,variation_value)
    if variation_type != 'none'
      @actual = self.ps_author_info.text
      self.ps_author_info == variation_value
    elsif variation_type == 'none'
      # !(self.article_author?)
    end
  end

  def verify_author_sp_bib(variation_type,variation_value)
    if variation_type != 'none'
      @actual = self.sp_article_author.text
      self.sp_article_author == variation_value
    elsif variation_type == 'none'
    end
  end

  def verify_author_sp_auth(variation_type,variation_value)
    if variation_type != 'none'
      @actual = self.sp_article_author.text
      self.sp_article_author == variation_value
    elsif variation_type == 'none'
    end
  end

  def verify_author_pt(variation_type,variation_value)
    if variation_type != 'none'
      @actual = self.pt_author_info.text
      self.pt_author_info == variation_value
    elsif variation_type == 'none'
    end
  end

  def verify_journal_title(variation_value)
    @actual = self.ps_journal_title.text
    self.ps_journal_title.text == variation_value
  end

  def verify_source_info(variation_value)
    self.source_info.include?(variation_value)
  end

  def verify_page_count(variation_value)
    page_count_container = self.page_count
    page_count = page_count_container.gsub('Page Count: ','')
    page_count == variation_value
  end

  def verify_abstract(variation_type,variation_value)
    if variation_type != 'none'
      self.abstract_element.wait_until_present
      if self.abstract_more_link_element.exists?
        self.abstract_more_link
        self.abstract_less_link_element.wait_until_present
      end
      status = (self.abstract.include?(variation_value))
    elsif variation_type == 'none'
      status = !(self.abstract?)
    end
    status
  end

  def verify_semantic_terms(variation_type,variation_value)
    if variation_type != 'none'
      self.semantic_terms.gsub("\n",' ') == variation_value
    elsif variation_type == 'none'
      !(self.semantic_terms?)
    end
  end

  def verify_references(variation_type,variation_value)
    if variation_type != 'none'
      self.references.gsub("\n",'') == variation_value
    elsif variation_type == 'none'
      !(self.references?)
    end
  end

  def click_tabs(tabs=['summary_tab_link','page_thumbs_tab_link','page_scan_tab_link'])
    tabs.each{|tab|
      tab_element = instance_variable_get(:"@#{tab}")
      tab_element.wait_until_present(5)
      tab_element.click
    }
  end

  def local_ip
    orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true

    UDPSocket.open do |s|
      s.connect '192.168.1.1', 1
      s.addr.last
    end
  ensure
    Socket.do_not_reverse_lookup = orig
  end

  def validate_page_scan_src(url)
    agent = ITHAKA::Session::Factory.ip_auth_session_agent
    begin
      agent.get(url.to_s)
    rescue Mechanize::ResponseCodeError => e
      e.page
    end
  end

  def dynamic_url_form(expected_page_names)
    pagefor_unnum = expected_page_names.find_index("nil")+1
    @page_url = @browser.url.gsub('=1',"=#{pagefor_unnum}")
    visit
  end

  def validate_page_scan_image
    @browser.execute_script("return (typeof arguments[0].naturalWidth!=\"undefined\" && arguments[0].naturalWidth>0)", JstorArticleViewPage.new(@browser).ps_page_scan_image)
  end

  def self.attr_list
    [:breadcrumbs_issue_link,
     :pub_info_link,
     :pub_info_header,
     :pub_info_journal,
     :pub_info_coverage,
     :pub_info_links_to_ext_content,
     :pub_info_moving_wall,
     :pub_moving_wall_def,
     :pub_info_subjects,
     :pub_info_collections,
     :pub_info_published_by,
     :pub_info_issn,
     :published_by,
     :pub_info_journal_description,
     :pub_logo_image,
     :most_accessed_link,
     :most_cited_link,
     :download_pdf_link,
     :download_pdf_link_text_newpage,
     :download_pdf_link_text_oldpage,
     :view_citation_link,
     :citation_tools_link,
     :email_citation_link,
     :export_citation_link,
     :save_citation_link,
     :track_citation_link,
     :we_are_sorry_error,
     :summary_tab_link,
     :summary_abstract_header,
     :page_thumbs_tab_link,
     :page_scan_tab_link,
     :article_author,
     :sp_article_author,
     :sp_abstract_contents,
     :sp_formats,
     :sp_source_info,
     :sp_toc,
     :sp_abstract_link,
     :sp_bibliographic_information_link,
     :sp_author_info,
     :sp_author_information_link,
     :sp_back_to_top_link,
     :sp_items_citing_this_item_link,
     :sp_summary_notes_ref_contents,
     :ps_next_page_link,
     :ps_prev_page_link,
     :ps_article_title,
     :ps_reviewed_work_subtitle,
     :ps_author_info,
     :ps_copyright_statement,
     :pt_page_thumbnails_header,
     :pt_article_title,
     :pt_author_info,
     :pt_thumbs_number,
     :pt_copyright_statement,
     :ps_copyright_statement,
     :view_citation_article_title,
     :view_citation_authors,
     :view_citation_source_info,
     :view_citation_published_by,
     :view_citation_stable_doi,
     :journal_title,
     :ps_page_scan_image,
     :view_pdf_link,
     :jstor_tac_overlay,
     :jstor_tac_overlay_srp,
     :jstor_tac_overlay_avp,
     :previous_item_link,
     :next_item_link,
     :ps_journal_title,
     :sp_article_title,
     :pt_summary_author,
     :sp_article_title_bib,
     :next_item_link,
     :download_chapter_link,
     :title_tag,
     :ps_current_page,
     :ps_page_range,
     :site_catalyst_data,
     :cilIcon,
     :citation_saved,
     :citation_tracked,
     :welcome_user_block,
     :saved_citations_link,
     :shelf_link,
     :provider_statement,
     :shopping_cart_link,
     :back_to_search,
     :cover_image_link,
     :breadcrumbs_journal_link,
     :published_by_link,
     :jstor_t_and_c_link,
     :more_rights_link
    ]
  end

  attr_accessor *attr_list
end

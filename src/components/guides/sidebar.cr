class GuideCategory
  getter title, guides

  def initialize(@title : String, @guides : Array(GuideAction.class))
  end

  def active?(guide_action : GuideAction.class)
    guides.includes?(guide_action)
  end
end

class Guides::Sidebar < BaseComponent
  needs current_guide : GuideAction.class

  @categories : Array(GuideCategory)

  private getter categories = [
    GuideCategory.new("Getting Started", [
      Guides::GettingStarted::WhyLucky,
      Guides::GettingStarted::Installing,
      Guides::GettingStarted::Concepts,
      Guides::GettingStarted::Configuration,
    ] of GuideAction.class),
    GuideCategory.new("HTTP and Routing", [
      Guides::HttpAndRouting::RoutingAndParams,
      Guides::HttpAndRouting::LinkGeneration,
      Guides::HttpAndRouting::RequestAndResponse,
      Guides::HttpAndRouting::SessionsAndCookies,
      Guides::HttpAndRouting::Flash,
      Guides::HttpAndRouting::ErrorHandling,
    ] of GuideAction.class),
    GuideCategory.new("Frontend", [
      Guides::Frontend::RenderingHtml,
      Guides::Frontend::AssetHandling,
      Guides::Frontend::Testing,
    ] of GuideAction.class),
    GuideCategory.new("Database", [
      Guides::Database::ManagingAndMigrating,
      Guides::Database::Models,
      Guides::Database::Querying,
      Guides::Database::ValidatingSavingDeleting,
      Guides::Database::RawSql,
      Guides::Database::Testing,
    ] of GuideAction.class),
    GuideCategory.new("JSON and APIs", [
      Guides::JsonAndApis::RenderingJson,
      Guides::JsonAndApis::ParsingJsonRequests,
      Guides::JsonAndApis::SavingToTheDatabase,
      Guides::JsonAndApis::HandlingErrors,
      Guides::JsonAndApis::Cors,
    ] of GuideAction.class),
    GuideCategory.new("Authentication", [
      Guides::Authentication::Show,
    ] of GuideAction.class),
    GuideCategory.new("Command Line Tasks", [
      Guides::CommandLineTasks::BuiltIn,
      Guides::CommandLineTasks::CustomTasks,
    ] of GuideAction.class),
    GuideCategory.new("Emails", [
      Guides::Emails::SendingEmailsWithCarbon,
    ] of GuideAction.class),
    GuideCategory.new("Deploying", [
      Guides::Deploying::Heroku,
    ] of GuideAction.class),
  ]

  def render
    div class: "text-black absolute pin-t pin-l bg-white rounded-lg shadow-lg w-sidebar mt-5 ml-2 pb-3 mb-10" do
      ul class: "list-reset" do
        li "All Guides", class: "uppercase text-sm text-grey-dark tracking-wide border-b border-grey-light py-3 mt-3 ml-8 mb-4"
        categories.each do |category|
          li do
            if category.active?(@current_guide)
              div class: "block pb-3 bg-grey-lighter border-t border-b border-grey-light shadow-inner" do
                span category.title, class: "pl-8 py-3 mb-2 block bold text-sm tracking-wide"
                category.guides.each do |guide|
                  if guide == @current_guide
                    link guide.title, guide, class: "block text-sm text-grey-darker no-underline pl-12 py-3 hover:bg-grey-lighter hover:underline #{active_class}"
                  else
                    link guide.title, guide, class: "block text-sm text-grey-darker no-underline pl-12 py-3 hover:underline hover:text-blue-dark"
                  end
                end
              end
            else
              link category.title, category.guides.first, class: "block text-sm tracking-wide text-grey-darker no-underline pl-8 py-3 hover:underline hover:text-blue-dark"
            end
          end
        end
      end
    end
  end

  def wut
  end

  def active_class
    "text-white bg-teal text-shadow hover:bg-lucky-teal-blue hover:no-underline hover:text-white"
  end
end

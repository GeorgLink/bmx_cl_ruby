class Issue < ThorBase
  desc "list", "list all issues"
  option :limit , desc: "limit number of issues" , type: :numeric
  def list
    opts = options[:limit] ? {limit: options[:limit]} : {}
    list = BmxApiRuby::IssuesApi.new(client)
    output(run {list.get_issues(opts).map {|issue| issue.to_hash}})
  end

  desc "show ISSUE_UUID", "show issue details"
  def show(issue_uuid)
    issue  = BmxApiRuby::IssuesApi.new(client)
    runput { issue.get_issues_issue_uuid(issue_uuid, {}) }
  end

  desc "sync ISSUE_EXID", "create or update an issue"
  option :uuid       , desc: "only required for updating existing issue" , type: :string
  option :repo_uuid  , desc: "UUID of issue repository" , type: :string , required: true
  option :title      , desc: "Text describing issue, typically from issue tracker" , type: :string
  option :status     , desc: "'fixed' or 'unfixed' (default: '???')" , type: :string
  option :labels     , desc: "TBD" , type: :string
  def sync(exid)
    repo_uuid = options["repo_uuid"]
    opts = {}
    %i(uuid title status labels).each do |lbl|
      opts[lbl] = options[lbl] if options[lbl]
    end
    issue  = BmxApiRuby::IssuesApi.new(client)
    runput { issue.post_issues_exid(exid, repo_uuid, opts) }
  end
end



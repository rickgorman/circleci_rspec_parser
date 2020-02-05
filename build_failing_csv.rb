require 'active_support/core_ext'  # Hash.from_xml
require 'csv'

class FailingCsvBuilder
  CIRCLE_TOKEN = ENV["CIRCLE_TOKEN"]
  VCS_NAME = ENV["VCS_NAME"] || "github"
  USERNAME = ENV["USERNAME"]
  PROJECT_NAME = ENV["PROJECT_NAME"]
  BUILD_NUMBER = ENV["BUILD_NUMBER"] || "latest"
  BRANCH = ENV["BRANCH"]

  def run
    clear_tmp_files
    get_xml_files

    build_csv(rspec_xml_to_error_count_by_filename_array)
  end

  private

  def clear_tmp_files
    Dir.glob("tmp/rspec.xml*").each do |filename|
      File.delete(filename)
    end
  end

  def get_xml_files
    # this ensures that the string of commands in the script are properly pipelined
    cmd = "CIRCLE_TOKEN=#{CIRCLE_TOKEN} " \
          "VCS_NAME=#{VCS_NAME} " \
          "USERNAME=#{USERNAME} " \
          "PROJECT_NAME=#{PROJECT_NAME} " \
          "BRANCH=#{BRANCH} " \
          "BUILD_NUMBER=#{BUILD_NUMBER} " \
          "fetch_rspec_xml.sh"
    `cmd`
  end

  def xml_filenames
    Dir.glob("tmp/rspec.xml*")
  end

  def rspec_xml_to_error_count_by_filename_array
    error_count_by_filename_hash = Hash.new(0)

    xml_filenames.map do |filename|
      xml_data = File.open(filename).read
      testcases = error_hash_from_xml(xml_data)

      testcases.each do |testcase|
        next if testcase["failure"].nil?

        error_count_by_filename_hash[testcase["file"]] += 1
      end
    end

    error_count_by_filename_hash.sort_by { |file, counter| file }
  end

  def error_hash_from_xml(rspec_xml)
    Hash.from_xml(rspec_xml)["testsuite"]["testcase"]
  end

  def build_csv(filename_with_errors_list)
    CSV.open("rspec_errors_by_filename.csv", "wb") do |csv|
      filename_with_errors_list.each do |row|
        csv << row
      end
    end
  end
end

FailingCsvBuilder.new.run

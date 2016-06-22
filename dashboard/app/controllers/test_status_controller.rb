require 'aws-sdk'
require 'date'

class TestStatusController < ApplicationController
  def test_run_status
    bucket = Aws::S3::Bucket.new('cucumber-logs')
    objects = bucket.objects({prefix: "#{params[:branch]}/"})
    render json: objects.map {|summary| {
        key: summary.key,
        last_modified: summary.last_modified
    }}
  end

  def test_run_status_since
    boundary_time = Time.at(params[:time].to_i)
    bucket = Aws::S3::Bucket.new('cucumber-logs')
    objects = bucket.objects({prefix: "#{params[:branch]}/"})
    render json: objects.select {|summary|
      boundary_time <= summary.last_modified
    }.map {|summary| {
      key: summary.key,
      last_modified: summary.last_modified
    }}
  end

  def test_status
    bucket = Aws::S3::Bucket.new('cucumber-logs')
    object = bucket.object("#{params[:branch]}/#{params[:name]}.#{params[:format]}")
    render json: {
        version_id: object.version_id,
        commit: object.metadata['commit'],
        attempt: object.metadata['attempt'],
        success: object.metadata['success'],
        duration: object.metadata['duration']
    }
  end
end
# encoding: utf-8

require 'pp'

Adhearsion::Events.draw do
  punchblock do |event|
    begin

      # get event name or nil
      event_name = event.name rescue nil

      if event_name
        if event.headers.has_key?('Channel') || (event.headers.has_key?('Channel1') && event.headers.has_key?('Channel2'))
          channel = event.headers['Channel'] || event.headers['Channel1']
          channel2 = event.headers['Channel2']

          # print event dump
          logger.info "Channel: #{channel}, event name: #{event_name}, event map:\n#{event.pretty_inspect}\n"

          # Do something with DTMF event
          # if event_name == "DTMF"
          #   # [2015-05-02 14:38:22.261] INFO  Adhearsion::Events: >>> event DTMF: #<Punchblock::Event::Asterisk::AMI::Event target_call_id="ca6df387-3e1b-44b2-84dc-760a5e70d4e5", target_mixer_name=nil, component_id=nil, source_uri=nil, domain=nil, transport=nil, timestamp=Sat, 02 May 2015 14:38:22 +0200, name="DTMF", headers={"Privilege"=>"dtmf,all", "Timestamp"=>"1430570302.205988", "SequenceNumber"=>"497", "File"=>"channel.c", "Line"=>"3728", "Func"=>"send_dtmf_event", "Channel"=>"SIP/adhearsion-0000000c", "Uniqueid"=>"1430570298.12", "Digit"=>"1", "Direction"=>"Received", "Begin"=>"No", "End"=>"Yes"}>
          #
          #   call_id = event.target_call_id
          #
          #   unless WebCall.user_input?(call_id)
          #     # here application announces API service about first DTMF digit input
          #     WebCall.start_user_input(call_id)
          #   end
          # end

        end
      end

    # process error exception
    rescue => e
      logger.error "\n\n-------------------------------------\n\nAdhearsion::Events.draw error: #{e}\n#{e.backtrace}\n\n-------------------------------------\n"
    end

  end
end

################################################################################
#  THIS FILE IS 100% GENERATED BY ZPROJECT; DO NOT EDIT EXCEPT EXPERIMENTALLY  #
#  Please refer to the README for information about making permanent changes.  #
################################################################################

module Zyre
  module FFI
    
    # Parsing Zyre messages
    class Event
      class DestroyedError < RuntimeError; end
      
      # Boilerplate for self pointer, initializer, and finalizer
      class << self
        alias :__new :new
      end
      def initialize ptr, finalize=true
        @ptr = ptr
        if @ptr.null?
          @ptr = nil # Remove null pointers so we don't have to test for them.
        elsif finalize
          @finalizer = self.class.send :create_finalizer_for, @ptr
          ObjectSpace.define_finalizer self, @finalizer
        end
      end
      def self.create_finalizer_for ptr
        Proc.new do
          ptr_ptr = ::FFI::MemoryPointer.new :pointer
          ptr_ptr.write_pointer ptr
          ::Zyre::FFI.zyre_event_destroy ptr_ptr
        end
      end
      def null?
        !@ptr or ptr.null?
      end
      # Return internal pointer
      def __ptr
        raise DestroyedError unless @ptr
        @ptr
      end
      # Nullify internal pointer and return pointer pointer
      def __ptr_give_ref
        raise DestroyedError unless @ptr
        ptr_ptr = ::FFI::MemoryPointer.new :pointer
        ptr_ptr.write_pointer @ptr
        ObjectSpace.undefine_finalizer self if @finalizer
        @finalizer = nil
        @ptr = nil
        ptr_ptr
      end
      
      # Constructor: receive an event from the zyre node, wraps zyre_recv.
      # The event may be a control message (ENTER, EXIT, JOIN, LEAVE) or  
      # data (WHISPER, SHOUT).                                            
      def self.new self
        self = self.__ptr if self
        ptr = ::Zyre::FFI.zyre_event_new self
        
        __new ptr
      end
      
      # Destructor; destroys an event instance
      def destroy
        return unless @ptr
        self_p = __ptr_give_ref
        result = ::Zyre::FFI.zyre_event_destroy self_p
        result
      end
      
      # Print properties of the zyre event object.
      def print
        raise DestroyedError unless @ptr
        result = ::Zyre::FFI.zyre_event_print @ptr
        result
      end
      
      # Returns event type, which is a zyre_event_type_t
      def type
        raise DestroyedError unless @ptr
        result = ::Zyre::FFI.zyre_event_type @ptr
        result
      end
      
      # Return the sending peer's id as a string
      def sender
        raise DestroyedError unless @ptr
        result = ::Zyre::FFI.zyre_event_sender @ptr
        result
      end
      
      # Return the sending peer's public name as a string
      def name
        raise DestroyedError unless @ptr
        result = ::Zyre::FFI.zyre_event_name @ptr
        result
      end
      
      # Return the sending peer's ipaddress as a string
      def address
        raise DestroyedError unless @ptr
        result = ::Zyre::FFI.zyre_event_address @ptr
        result
      end
      
      # Returns the event headers, or NULL if there are none
      def headers
        raise DestroyedError unless @ptr
        result = ::Zyre::FFI.zyre_event_headers @ptr
        result
      end
      
      # Returns value of a header from the message headers   
      # obtained by ENTER. Return NULL if no value was found.
      def header name
        raise DestroyedError unless @ptr
        name = String(name)
        result = ::Zyre::FFI.zyre_event_header @ptr, name
        result
      end
      
      # Returns the group name that a SHOUT event was sent to
      def group
        raise DestroyedError unless @ptr
        result = ::Zyre::FFI.zyre_event_group @ptr
        result
      end
      
      # Returns the incoming message payload (currently one frame)
      def msg
        raise DestroyedError unless @ptr
        result = ::Zyre::FFI.zyre_event_msg @ptr
        result
      end
      
      # Self test of this class
      def self.test verbose
        verbose = !(0==verbose||!verbose) # boolean
        result = ::Zyre::FFI.zyre_event_test verbose
        result
      end
    end
    
  end
end

################################################################################
#  THIS FILE IS 100% GENERATED BY ZPROJECT; DO NOT EDIT EXCEPT EXPERIMENTALLY  #
#  Please refer to the README for information about making permanent changes.  #
################################################################################
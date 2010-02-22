require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe Rubis::Namespace do
  describe "namespace" do
    it "should be klass when extending Klass" do
      with_rubis_namespace_class(:Klass) do
        Klass.class_eval { @rubis_namespace }.should == "klass"
      end
    end

    it "should be foo when extending Foo" do
      with_rubis_namespace_class(:Foo) do
        Foo.class_eval { @rubis_namespace }.should == "foo"
      end
    end

    it "should be parent:child when extending Parent::Child" do
      with_rubis_namespace_class(:Parent, :Child) do
        Parent::Child.class_eval { @rubis_namespace }.should == "parent:child"
      end
    end

    it "should pass valid redis commands" do
      with_rubis_namespace_class(:Klass) do
        redis = mock('redis')
        Klass.stub(:redis => redis)

        redis.should_receive(:rpush).with("klass:key", "value")
        Klass.rpush("key", "value")
      end
    end
    
    it "should pass valid redis-rb aliases" do
      with_rubis_namespace_class(:Klass) do
        redis = mock('redis')
        Klass.stub(:redis => redis)

        redis_alias = Redis::ALIASES.keys[rand(Redis::ALIASES.keys.size)].to_sym
        redis.should_receive(redis_alias)
        Klass.send(redis_alias, "key", "value")
      end
    end
    
    it "should not pass invalid redis/redis-rb commands" do
      with_rubis_namespace_class(:Klass) do
        redis = mock('redis')
        Klass.stub(:redis => redis)

        redis.should_not_receive(:foobarbaz)
        lambda { Klass.foobarbaz("key", "value") }
      end
    end
  end

  def with_rubis_namespace_class(*args)
    klass = 
      if args.size == 1
        klass_obj = Class.new
        Object.const_set(args[0], klass_obj)
      else
        klass_sym = args.pop
        parents = args.inject([]) do |namespaces, name|
          (namespaces.last || Object).module_eval do
            namespaces << const_set(name, Module.new)
          end
        end

        parents.last.module_eval do
          klass_obj = Class.new
          const_set(klass_sym, klass_obj)
        end
      end

    klass.class_eval { extend Rubis::Namespace }
    yield(klass)
    Object.send(:remove_const, args[0])
  end
end

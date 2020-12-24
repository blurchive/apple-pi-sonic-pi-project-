batter = "/Users/santhosh/Documents/Sonic Pi/apple pi"

set :bpm , 155

# Defining functions (patterns) for track playback

# Fading in and out a sample
use_bpm 155
define :fade_inout_amen do
  with_fx :level, amp: 10.5 do
    vol = (line 0, 1, inclusive: true, steps: 24).mirror
    
    s = sample batter, "intro", beat_stretch: 16, amp: vol.tick
    puts "---------- Vol 1: #{vol.look} ----------"
    control s, amp_slide: 4, amp: vol.tick
    
  end
end

# Main sample function, 64 bars
define :main_sample_fxd do
  1.times do
    
    with_fx :level, amp: 0.8 do
      use_bpm get(:bpm)
      
      fade_inout_amen
      sleep 16
      
      sample batter, "loop"
      sleep sample_duration batter, "loop"
      
      sample batter, "full"
      sleep sample_duration batter, "full"
      
    end
  end
end


##| Kick + snare function, 8 bars
define :kick_snare do
  1.times do
    use_bpm get(:bpm)
    
    sample batter, "kick", amp: 2
    sleep 2
    sample batter, "snare", amp: 1.2
    sleep 1.5
    sample batter, "kick", amp: 1
    sleep 0.5
    
    sample batter, "kick", amp: 2
    sleep 1
    sample batter, "kick", amp: 1.5
    sleep 1
    sample batter, "snare", amp: 1.2
    sleep 2
  end
end

##| Hi-hat functions, 16 bars
define :shorthatpattern do
  use_bpm get(:bpm)
  sleep 0.09
  sample batter, "hat", amp: 0.2, sustain: 0.03, release: 0.01
  sleep 0.455
  sample batter, "hat", amp: 0.32, sustain: 0.03, release: 0.01
  sleep 0.455
  
  sleep 0.1
  sample batter, "hat", amp: 0.13, sustain: 0.03, release: 0.01
  sleep 0.45
  sample batter, "hat", amp: 0.11, sustain: 0.03, release: 0.01
  sleep 0.45
end

##| 16 bars
define :hats do
  1.times do
    with_fx :flanger, amp:2, wave:3, phase:2, depth:4.5 do
      6.times do
        shorthatpattern
      end
      
      1.times do
        use_bpm get(:bpm)
        sleep 0.045
        sample batter, "hat", amp: 0.3, sustain: 0.03, release: 0.01
        sleep 0.455
        
        sleep 0.045
        sample batter, "hat", amp: 0.1, sustain: 0.5, release: 0.5
        sleep 0.455
        
        sleep 0.045
        sample batter, "open", amp: 0.2, sustain: 1, release: 1
        sleep 0.455
        
        sleep 0.5
        
        shorthatpattern
      end
    end
  end
end

##| 16 bars
define :hats2 do
  1.times do
    with_fx :flanger, amp:2, wave:3, phase:2, depth:4.5 do
      
      1.times do
        use_bpm get(:bpm)
        sleep 2.5
        
        sleep 0.09
        sample batter, "hat", amp: 0.1, sustain: 0.03, release: 0.01
        sleep 0.45
        sample batter, "hat", amp: 0.15, sustain: 0.03, release: 0.01
        sleep 0.45
        
        sleep 0.1
        sample batter, "hat", amp: 0.1, sustain: 0.03, release: 0.01
        sleep 0.41
        sample batter, "hat", amp: 0.15, sustain: 0.03, release: 0.01
      end
      
      4.times do
        shorthatpattern
      end
      
      1.times do
        use_bpm get(:bpm)
        sleep 0.045
        sample batter, "hat", amp: 0.3, sustain: 0.03, release: 0.01
        sleep 0.455
        
        sleep 0.045
        sample batter, "hat", amp: 0.1, sustain: 0.5, release: 0.5
        sleep 0.455
        
        sleep 0.045
        sample batter, "open", amp: 0.075, sustain: 1, release: 1
        sleep 0.455
        
        sleep 0.5
        
        shorthatpattern
      end
    end
  end
end

##| FX function, 32 bars
define :pewpew do
  sleep 16
  sleep 12
  sample batter, "pew", amp: 0.1
  sleep 4
end

##| Vocal function, 32 bars
define :vocal do
  sleep 4
  sample batter, "vocal", amp: 0.25
  sleep 12
  sleep 16
end


##| Sequencing loops, with compressor and distortion on master
with_fx :compressor, amp:2, threshold:0.1 do
  with_fx :distortion, mix:0.15 do
    
    
    ##| Kick snare arrangment
    in_thread do
      use_bpm get(:bpm)
      sleep 16
      
      kick_snare
      kick_snare
      kick_snare
      kick_snare
      kick_snare
      kick_snare
      kick_snare
      kick_snare
      
      
      kick_snare
      kick_snare
      kick_snare
      kick_snare
      sleep 8
      kick_snare
      kick_snare
      kick_snare
    end
    
    ##| Hi-Hat arrangment
    in_thread do
      use_bpm get(:bpm)
      sleep 16
      
      hats
      hats2
      hats
      hats
      
      hats
      hats2
      hats
      hats2
    end
    
    ##| Main sample arrangment
    in_thread do
      use_bpm get(:bpm)
      main_sample_fxd
    end
    
    ##| Pew Pew arrangment
    in_thread do
      with_fx :ping_pong, phase: 0.5 do
        sleep 16
        
        pewpew
        
        pewpew
        
        pewpew
        
        pewpew
      end
    end
    
    in_thread do
      sleep 16
      
      vocal
      
      vocal
      
      vocal
      
      vocal
    end
  end
end
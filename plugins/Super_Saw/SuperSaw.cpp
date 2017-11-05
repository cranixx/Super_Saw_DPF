#include "DistrhoPlugin.hpp"
#include <math.h>
extern "C" void adainit(void);
extern "C" void adafinal(void);
extern "C" float Super_Saw(float,float,float,float,float);

START_NAMESPACE_DISTRHO
class SuperSaw : public Plugin
{
public:
  SuperSaw() : Plugin(2,0,0){
        adainit();
  }

  ~SuperSaw() {
    adafinal();
  }

protected:
  const char* getLabel() const override
  {
    return "Super Saw";
  }

  const char* getDescription() const override
  {
    return "Roland JP-8000 Super Saw emulator";
    }
  const char* getMaker() const override
  {
    return "Cranix";
  }

  /**
     Get the plugin homepage.
  */
  const char* getHomePage() const override
  {
    return "http://example.org/Super_Saw";
  }

  /**
     Get the plugin license name (a single line of text).
     For commercial plugins this should return some short copyright information.
  */
  const char* getLicense() const override
  {
    return "GPL";
  }

  /**
     Get the plugin version, in hexadecimal.
  */
  uint32_t getVersion() const override
  {
    return d_version(1, 0, 0);
  }

  /**
     Get the plugin unique Id.
     This value is used by LADSPA, DSSI and VST plugin formats.
  */
  int64_t getUniqueId() const override
  {
    return d_cconst('d', 'N', 'f', 'o');
  }
  void setParameterValue(uint32_t index, float value) override
  {
    if (index == 0) {
      detune = value;
    } else if (index == 1) {
      mix = value;
    }
  }

  float getParameterValue(uint32_t index) const override
  {
    if (index == 0) {
      return detune;
    } else if (index == 1) {
      return mix;
    }

  }

  void initParameter(uint32_t index, Parameter& parameter) override {
    if (index == 0) { /*Detune*/
      parameter.hints      = kParameterIsAutomable;
      parameter.name       = "Detune";
      parameter.symbol     = "detune";
      parameter.ranges.min = 0.0f;
      parameter.ranges.max = 1.0f;
      parameter.ranges.def = 0.5f;
    } else if (index == 1) { /*Mix*/
      parameter.hints      = kParameterIsAutomable;
      parameter.name       = "Mix";
      parameter.symbol     = "mix";
      parameter.ranges.min = 0.0f;
      parameter.ranges.max = 1.0f;
      parameter.ranges.def = 0.5f;
    }
  }


  void run(const float** inputs, float** outputs, uint32_t frames) override {
    uint32_t i;
    for(i=0;i<frames;i++){
      outputs[0][i] = Super_Saw(phase,1000.0,detune,mix,getSampleRate())/50.0;
      phase++;
    }
  }
private:
  float phase=0;
  float detune;
  float mix;
};

Plugin* createPlugin()
{
   return new SuperSaw();
}


END_NAMESPACE_DISTRHO


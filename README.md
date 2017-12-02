An attempt to recreate Super Saw basing on Adam Szabo's work.

DSP code is written in Ada, You need gnat to build it
(one from Your distro's package system should be fine).

DSP code is plugged in into DPF framework for easier generation
of lv2 plugin.

Current status: It souds different from JP-8000 but IMO good.
There is issue around polyphony handling, and compensation
of volume change in function of pitch does not work as good as i would like it to.

I have wrote this plugin mainly for easier testing of DSP, which i would like to
run on microcontroller.


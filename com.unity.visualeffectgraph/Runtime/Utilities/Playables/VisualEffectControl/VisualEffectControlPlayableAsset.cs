#if VFX_HAS_TIMELINE
using System;
using System.Linq;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;
using System.Runtime.CompilerServices;
using UnityEngine.VFX.Utility;

[assembly: InternalsVisibleTo("VisualEffect.Playable.Editor")]
namespace UnityEngine.VFX
{
    [Serializable]
    class VisualEffectControlPlayableAsset : PlayableAsset, ITimelineClipAsset
    {
        public ClipCaps clipCaps
        {
            //TODOPAUL: If speed available, enable here
            get { return ClipCaps.None; }
        }

        public double clipStart { get; set; }
        public double clipEnd { get; set; }

        [NotKeyable]
        public bool scrubbing = true;
        [NotKeyable]
        public uint startSeed;

        [Serializable]
        public struct PrewarmClipSettings
        {
            public bool enable;
            public uint stepCount;
            public float deltaTime;
            public ExposedProperty eventName;
        }

        [NotKeyable]
        public PrewarmClipSettings prewarm = new PrewarmClipSettings()
        {
            enable = false,
            stepCount = 20u,
            deltaTime = 0.05f,
            eventName = VisualEffectAsset.PlayEventName
        };


        [Serializable]
        public struct ClipEvent
        {
            public VisualEffectPlayableSerializedEvent enter;
            public VisualEffectPlayableSerializedEvent exit;
        }

        [NotKeyable]
        public List<ClipEvent> clipEvents = new List<ClipEvent>()
        {
            new ClipEvent()
            {
                enter = new VisualEffectPlayableSerializedEvent()
                {
                    name = VisualEffectAsset.PlayEventName,
                    time = 0.0,
                    timeSpace = VisualEffectPlayableSerializedEvent.TimeSpace.AfterClipStart,
                },

                exit = new VisualEffectPlayableSerializedEvent()
                {
                    name = VisualEffectAsset.StopEventName,
                    time = 0.0,
                    timeSpace = VisualEffectPlayableSerializedEvent.TimeSpace.BeforeClipEnd,
                }
            }
        };

        [NotKeyable]
        public List<VisualEffectPlayableSerializedEvent> singleEvents = new List<VisualEffectPlayableSerializedEvent>();

        public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
        {
            var playable = ScriptPlayable<VisualEffectControlPlayableBehaviour>.Create(graph);
            var behaviour = playable.GetBehaviour();
            behaviour.clipStart = clipStart;
            behaviour.clipEnd = clipEnd;
            behaviour.scrubbing = scrubbing;
            behaviour.startSeed = startSeed;

            if (clipEvents == null)
                clipEvents = new List<ClipEvent>();
            if (singleEvents == null)
                singleEvents = new List<VisualEffectPlayableSerializedEvent>();

            behaviour.clipEventsCount = (uint)clipEvents.Count;
            behaviour.events = new VisualEffectPlayableSerializedEvent[clipEvents.Count * 2 + singleEvents.Count];
            int cursor = 0;
            foreach (var itEvent in clipEvents)
            {
                behaviour.events[cursor++] = itEvent.enter;
                behaviour.events[cursor++] = itEvent.exit;
            }

            foreach (var itEvent in singleEvents)
            {
                behaviour.events[cursor++] = itEvent;
            }

            if (!prewarm.enable || !scrubbing || prewarm.eventName == null || string.IsNullOrEmpty((string)prewarm.eventName))
            {
                behaviour.prewarmStepCount = 0u;
                behaviour.prewarmDeltaTime = 0.0f;
                behaviour.prewarmEvent = null;
            }
            else
            {
                behaviour.prewarmStepCount = prewarm.stepCount;
                behaviour.prewarmDeltaTime = prewarm.deltaTime;
                behaviour.prewarmEvent = prewarm.eventName;
            }

            return playable;
        }
    }
}
#endif

using System;
using UnityEngine.Serialization;
using UnityEngine.SceneManagement;
using System.Collections.Generic;

namespace UnityEngine.Rendering.HighDefinition
{
    public class ProbeVolumeAsset : ScriptableObject
    {
        [Serializable]
        internal enum AssetVersion
        {
            First,
            AddProbeVolumesAtlasEncodingModes,
            PV2,
            Max,
            Current = Max - 1
        }

        [SerializeField] protected internal int m_Version = (int)AssetVersion.Current;
        [SerializeField] public int Version { get => m_Version; }

        [SerializeField] public List<ProbeReferenceVolume.Cell> cells = new List<ProbeReferenceVolume.Cell>();

#if UNITY_EDITOR
        internal static string GetFileName(int id = -1)
        {
            string assetName = "ProbeVolumeData";

            String assetFileName;
            String assetPath;

            if (id == -1)
            {
                assetPath = "Assets";
                assetFileName = UnityEditor.AssetDatabase.GenerateUniqueAssetPath(assetName + ".asset");
            }
            else
            {
                String scenePath = SceneManagement.SceneManager.GetActiveScene().path;
                String sceneDir = System.IO.Path.GetDirectoryName(scenePath);
                String sceneName = System.IO.Path.GetFileNameWithoutExtension(scenePath);

                assetPath = System.IO.Path.Combine(sceneDir, sceneName);

                if (!UnityEditor.AssetDatabase.IsValidFolder(assetPath))
                    UnityEditor.AssetDatabase.CreateFolder(sceneDir, sceneName);

                assetFileName = UnityEditor.AssetDatabase.GenerateUniqueAssetPath(assetName + id + ".asset");
            }

            assetFileName = System.IO.Path.Combine(assetPath, assetFileName);

            return assetFileName;
        }

        public static ProbeVolumeAsset CreateAsset(int id = -1)
        {
            ProbeVolumeAsset asset = ScriptableObject.CreateInstance<ProbeVolumeAsset>();
            string assetFileName = GetFileName(id);

            UnityEditor.AssetDatabase.CreateAsset(asset, assetFileName);
            UnityEditor.AssetDatabase.SaveAssets();
            UnityEditor.AssetDatabase.Refresh();

            return asset;
        }
#endif
    }
}

using System;
using UnityEditor.ProjectWindowCallback;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Rendering.Universal;
using UnityEngine.Rendering;


namespace UnityEditor.Rendering.Universal
{
    static class Renderer2DMenus
    {
        internal static void PlaceGameObjectInFrontOfSceneView(GameObject go)
        {
            var sceneViews = SceneView.sceneViews;
            if (sceneViews.Count >= 1)
            {
                SceneView view = SceneView.lastActiveSceneView;
                if (!view)
                    view = sceneViews[0] as SceneView;

                if (view)
                    view.MoveToView(go.transform);
            }
        }

        // This is from GOCreationCommands
        internal static void Place(GameObject go, GameObject parent)
        {
            if (parent != null)
            {
                var transform = go.transform;
                Undo.SetTransformParent(transform, parent.transform, "Reparenting");
                transform.localPosition = Vector3.zero;
                transform.localRotation = Quaternion.identity;
                transform.localScale = Vector3.one;
                go.layer = parent.layer;

                if (parent.GetComponent<RectTransform>())
                    ObjectFactory.AddComponent<RectTransform>(go);
            }
            else
            {
                PlaceGameObjectInFrontOfSceneView(go);
                StageUtility.PlaceGameObjectInCurrentStage(go); // may change parent
                go.transform.position = new Vector3(go.transform.position.x, go.transform.position.y, 0);
            }

            // Only at this point do we know the actual parent of the object and can modify its name accordingly.
            GameObjectUtility.EnsureUniqueNameForSibling(go);
            Undo.SetCurrentGroupName("Create " + go.name);

            //EditorWindow.FocusWindowIfItsOpen<SceneHierarchyWindow>();
            Selection.activeGameObject = go;
        }

        static Light2D CreateLight(MenuCommand menuCommand, Light2D.LightType type, Vector3[] shapePath = null)
        {
            GameObject go = ObjectFactory.CreateGameObject("Light 2D", typeof(Light2D));
            Light2D light2D = go.GetComponent<Light2D>();
            light2D.lightType = type;

            if (shapePath != null && shapePath.Length > 0)
                light2D.shapePath = shapePath;

            var parent = menuCommand.context as GameObject;
            Place(go, parent);

            Analytics.Light2DData lightData = new Analytics.Light2DData();
            lightData.was_create_event = true;
            lightData.instance_id = light2D.GetInstanceID();
            lightData.light_type = light2D.lightType;
            Analytics.Renderer2DAnalytics.instance.SendData(Analytics.AnalyticsDataTypes.k_LightDataString, lightData);

            return light2D;
        }

        static bool CreateLightValidation()
        {
            return Light2DEditorUtility.IsUsing2DRenderer();
        }

        [MenuItem("GameObject/Light/Freeform Light 2D/Square", priority = CoreUtils.Sections.section3 + CoreUtils.Priorities.gameObjectMenuPriority + 4)]
        static void CreateSquareFreeformLight2D(MenuCommand menuCommand)
        {
            CreateLight(menuCommand, Light2D.LightType.Freeform, FreeformPathPresets.CreateSquare());
        }

        [MenuItem("GameObject/Light/Freeform Light 2D/Circle", priority = CoreUtils.Sections.section3 + CoreUtils.Priorities.gameObjectMenuPriority + 5)]
        static void CreateCircleFreeformLight2D(MenuCommand menuCommand)
        {
            CreateLight(menuCommand, Light2D.LightType.Freeform, FreeformPathPresets.CreateCircle());
        }

        [MenuItem("GameObject/Light/Freeform Light 2D/Isometric Diamond", priority = CoreUtils.Sections.section3 + CoreUtils.Priorities.gameObjectMenuPriority + 6)]
        static void CreateIsometricDiamondFreeformLight2D(MenuCommand menuCommand)
        {
            CreateLight(menuCommand, Light2D.LightType.Freeform, FreeformPathPresets.CreateIsometricDiamond());
        }

        [MenuItem("GameObject/Light/Freeform Light 2D/Hexagon Flat Top", priority = CoreUtils.Sections.section3 + CoreUtils.Priorities.gameObjectMenuPriority + 7)]
        static void CreateHexagonFlatTopFreeformLight2D(MenuCommand menuCommand)
        {
            CreateLight(menuCommand, Light2D.LightType.Freeform, FreeformPathPresets.CreateHexagonFlatTop());
        }

        [MenuItem("GameObject/Light/Freeform Light 2D/Hexagon Pointed Top", priority = CoreUtils.Sections.section3 + CoreUtils.Priorities.gameObjectMenuPriority + 8)]
        static void CreateHexagonPointedTopFreeformLight2D(MenuCommand menuCommand)
        {
            CreateLight(menuCommand, Light2D.LightType.Freeform, FreeformPathPresets.CreateHexagonPointedTop());
        }

        [MenuItem("GameObject/Light/Sprite Light 2D", priority = CoreUtils.Sections.section3 + CoreUtils.Priorities.gameObjectMenuPriority + 1)]
        static void CreateSpriteLight2D(MenuCommand menuCommand)
        {
            Light2D light = CreateLight(menuCommand, Light2D.LightType.Sprite);
            ResourceReloader.ReloadAllNullIn(light, UniversalRenderPipelineAsset.packagePath);
        }

        [MenuItem("GameObject/Light/Spot Light 2D", priority = CoreUtils.Sections.section3 + CoreUtils.Priorities.gameObjectMenuPriority + 2)]
        static void CreatePointLight2D(MenuCommand menuCommand)
        {
            CreateLight(menuCommand, Light2D.LightType.Point);
        }

        [MenuItem("GameObject/Light/Global Light 2D", priority = CoreUtils.Sections.section3 + CoreUtils.Priorities.gameObjectMenuPriority + 3)]
        static void CreateGlobalLight2D(MenuCommand menuCommand)
        {
            CreateLight(menuCommand, Light2D.LightType.Global);
        }

        [MenuItem("GameObject/Light/Freeform Light 2D/Isometric Diamond", true)]
        [MenuItem("GameObject/Light/Freeform Light 2D/Square", true)]
        [MenuItem("GameObject/Light/Freeform Light 2D/Circle", true)]
        [MenuItem("GameObject/Light/Freeform Light 2D/Hexagon Flat Top", true)]
        [MenuItem("GameObject/Light/Freeform Light 2D/Hexagon Pointed Top", true)]
        [MenuItem("GameObject/Light/Sprite Light 2D", true)]
        [MenuItem("GameObject/Light/Spot Light 2D", true)]
        [MenuItem("GameObject/Light/Global Light 2D", true)]
        static bool CreateLight2DValidation()
        {
            return CreateLightValidation();
        }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1812")]
        internal class CreateUniversalPipelineAsset : EndNameEditAction
        {
            public override void Action(int instanceId, string pathName, string resourceFile)
            {
                //Create asset
                AssetDatabase.CreateAsset(UniversalRenderPipelineAsset.Create(UniversalRenderPipelineAsset.CreateRendererData(RendererType._2DRenderer)), pathName);
            }
        }

        [MenuItem("Assets/Create/Rendering/URP Asset (with 2D Renderer)", priority = CoreUtils.Sections.section2 + CoreUtils.Priorities.assetsCreateRenderingMenuPriority)]
        static void CreateUniversalPipeline()
        {
            ProjectWindowUtil.StartNameEditingIfProjectWindowExists(0, UniversalRenderPipelineAsset.CreateInstance<CreateUniversalPipelineAsset>(),
                "New Universal Render Pipeline Asset.asset", null, null);
        }
    }
}

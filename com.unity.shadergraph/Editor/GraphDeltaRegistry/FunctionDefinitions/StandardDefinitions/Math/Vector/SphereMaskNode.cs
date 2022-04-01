using System.Collections.Generic;
using Usage = UnityEditor.ShaderGraph.GraphDelta.GraphType.Usage;

namespace UnityEditor.ShaderGraph.Defs
{
    internal class SphereMaskNode : IStandardNode
    {
        public static string Name = "SphereMask";
        public static int Version = 1;

        public static FunctionDescriptor FunctionDescriptor => new(
            1,
            "SphereMask",
            "Out = 1 - saturate((distance(Coords, Center) - Radius) / (1 - Hardness));",
            new ParameterDescriptor("Coords", TYPE.Vector, Usage.In),
            new ParameterDescriptor("Center", TYPE.Vector, Usage.In, new float[] { 0.5f, 0.5f, 0.5f, 0.5f }),
            new ParameterDescriptor("Radius", TYPE.Float, Usage.In, new float[] { 0.1f }),
            new ParameterDescriptor("Hardness", TYPE.Float, Usage.In, new float[] { 0.8f }),
            new ParameterDescriptor("Out", TYPE.Vector, Usage.Out)
        );

        public static NodeUIDescriptor NodeUIDescriptor => new(
            Version,
            Name,
            displayName: "Sphere Mask",
            tooltip: "creates a spherical volume mask originating at the given position",
            categories: new string[2] { "Math", "Vector" },
            synonyms: new string[0],
            parameters: new ParameterUIDescriptor[5] {
                new ParameterUIDescriptor(
                    name: "Coords",
                    tooltip: "coordinate space input"
                ),
                new ParameterUIDescriptor(
                    name: "Center",
                    tooltip: "coordinates of the sphere origin"
                ),
                new ParameterUIDescriptor(
                    name: "Radius",
                    tooltip: "radius of the sphere"
                ),
                new ParameterUIDescriptor(
                    name: "Hardness",
                    tooltip: "soften falloff of the sphere"
                ),
                new ParameterUIDescriptor(
                    name: "Out",
                    tooltip: "a spherical volume mask originating at the given position"
                )
            }
        );

        public static Dictionary<string, string> UIStrings => new()
        {
            { "Category", "Math, Vector" },
            { "DisplayName", "Sphere Mask" },
            { "Tooltip", "creates a spherical volume mask originating at the given position" },
            { "Parameters.Coords.Tooltip", "coordinate space input" },
            { "Parameters.Center.Tooltip", "coordinates of the sphere origin" },
            { "Parameters.Radius.Tooltip", "radius of the sphere" },
            { "Parameters.Hardness.Tooltip", "soften falloff of the sphere" },
            { "Parameters.Out.Tooltip", "a spherical volume mask originating at the given position" }
        };
    }
}

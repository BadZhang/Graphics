using System.Collections.Generic;
using Usage = UnityEditor.ShaderGraph.GraphDelta.GraphType.Usage;

namespace UnityEditor.ShaderGraph.Defs
{

    internal class FloorNode : IStandardNode
    {
        public static FunctionDescriptor FunctionDescriptor => new(
            1,
            "Floor",
            "Out = floor(In);",
            new ParameterDescriptor("In", TYPE.Vector, Usage.In),
            new ParameterDescriptor("Out", TYPE.Vector, Usage.Out)
        );

        public static Dictionary<string, string> UIStrings => new()
        {
            { "Name.Synonyms", "down" },
            { "Tooltip", "rounds the input down to the nearest whole number" },
            { "Parameters.In.Tooltip", "input value" },
            { "Parameters.Out.Tooltip", "the input rounded down to the nearest whole number" },
            { "Category", "Math, Round" }
        };
    }
}

using System.Collections.Generic;
using Usage = UnityEditor.ShaderGraph.GraphDelta.GraphType.Usage;

namespace UnityEditor.ShaderGraph.Defs
{

    internal class AllNode : IStandardNode
    {
        public static FunctionDescriptor FunctionDescriptor => new(
            1,
            "All",
            "Out = all(In);",
            new ParameterDescriptor("In", TYPE.Vector, Usage.In),
            new ParameterDescriptor("Out", TYPE.Bool, Usage.Out)
        );

        public static Dictionary<string, string> UIStrings => new()
        {
            { "Tooltip", "returns true if all components of the input In are non-zero" },
            { "Parameters.In.Tooltip", "input value" },
            { "Parameters.Out.Tooltip", "true if all input components are non-zero" },
            { "Category", "Utility, Logic" }
        };

        public static Dictionary<string, float> UIHints => new()
        {
            { "Preview.Exists", 0 }
        };
    }
}

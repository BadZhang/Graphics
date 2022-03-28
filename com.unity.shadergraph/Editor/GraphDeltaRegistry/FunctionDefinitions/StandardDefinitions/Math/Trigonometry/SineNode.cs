using System.Collections.Generic;
using Usage = UnityEditor.ShaderGraph.GraphDelta.GraphType.Usage;

namespace UnityEditor.ShaderGraph.Defs
{

    internal class SineNode : IStandardNode
    {
        public static FunctionDescriptor FunctionDescriptor => new(
            1,
            "Sine",
            "Out = sin(In);",
            new ParameterDescriptor("In", TYPE.Vector, Usage.In),
            new ParameterDescriptor("Out", TYPE.Vector, Usage.Out)
        );

        public static Dictionary<string, string> UIStrings => new()
        {
            { "Tooltip", "returns the sine of the input" },
            { "Parameters.In.Tooltip", "input value" },
            { "Parameters.Out.Tooltip", "the sine of the input" },
            { "Category", "Math, Trigonometry" }
        };
    }
}

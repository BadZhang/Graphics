﻿using UnityEditor.GraphToolsFoundation.Overdrive.BasicModel;

namespace UnityEditor.ShaderGraph.GraphUI
{
    public class GraphDataPortModel : PortModel
    {
        public string graphDataName => UniqueName;
        public IGraphDataPortModelOwner portModelOwner => (IGraphDataPortModelOwner)NodeModel;
    }
}

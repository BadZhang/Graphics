namespace UnityEngine.Rendering.Universal
{
    public struct OutRec
    {
        Reference<OutRecStruct> m_Data;

        public void Initialize()
        {
            OutRecStruct initialValue = new OutRecStruct();
            m_Data = Reference<OutRecStruct>.Create(initialValue);
        }

        public bool IsCreated { get { return m_Data.IsCreated; } }
        public bool IsNull { get { return m_Data.IsNull; } }
        public bool NotNull { get { return !m_Data.IsNull; } }
        public void SetNull() { m_Data.SetNull(); }
        public bool IsEqual(OutRec node) { return m_Data.IsEqual(node.m_Data); }
        public static bool operator ==(OutRec a, OutRec b) { return a.IsEqual(b); }
        public static bool operator !=(OutRec a, OutRec b) { return !a.IsEqual(b); }

        //-----------------------------------------------------------------
        //                      Properties
        //-----------------------------------------------------------------

        internal ref int Idx { get{ return ref m_Data.DeRef().Idx; }}
        internal ref bool IsHole { get { return ref m_Data.DeRef().IsHole; }}
        internal ref bool IsOpen { get { return ref m_Data.DeRef().IsOpen; }}
        //see comments in clipper.pas
        internal ref OutRec FirstLeft { get { return ref m_Data.DeRef().FirstLeft; }} 
        internal ref OutPt Pts { get { return ref m_Data.DeRef().Pts; }} 
        internal ref OutPt BottomPt { get { return ref m_Data.DeRef().BottomPt; }} 
        internal ref PolyNode PolyNode { get { return ref m_Data.DeRef().PolyNode; }} 
    }
}

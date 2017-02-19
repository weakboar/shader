using UnityEngine;
using System.Collections;

[RequireComponent (typeof(MeshRenderer))]
[RequireComponent (typeof(MeshFilter))]
public class DynamicCreateMesh : MonoBehaviour
{
    private void Start ()
    {
        var mesh = new Mesh ();
        mesh.vertices = new Vector3[] {
            new Vector3 (1, 1f),
            new Vector3 (1f, -1f),
            new Vector3 (-1f, -1f),
        };
        mesh.triangles = new int[] {
            0, 1, 2 
        };

        var filter = GetComponent<MeshFilter> ();
        filter.sharedMesh = mesh;
    }
}
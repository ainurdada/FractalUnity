using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FractalMeneger : MonoBehaviour
{
    public Material material;
    private void Start()
    {
        material.SetFloat("_Zoom", 1f);
        material.SetFloat("_OffsetX", 0);
        material.SetFloat("_OffsetY", 0);
    }
    private void Move()
    {
        float moveSpeed = 0.005f / material.GetFloat("_Zoom");

        if(Input.GetAxis("Mouse ScrollWheel") > 0)
        {
            float zoom = material.GetFloat("_Zoom");
            material.SetFloat("_Zoom", zoom + 0.1f * zoom);
        }
        if (Input.GetAxis("Mouse ScrollWheel") < 0)
        {
            float zoom = material.GetFloat("_Zoom");
            material.SetFloat("_Zoom", zoom - 0.1f * zoom);
        }

        //Debug.Log(material.GetFloat("_Zoom"));

        if(Input.GetKey(KeyCode.D))
        {
            float move = material.GetFloat("_OffsetX");
            material.SetFloat("_OffsetX", move + moveSpeed);
        }
        if (Input.GetKey(KeyCode.A))
        {
            float move = material.GetFloat("_OffsetX");
            material.SetFloat("_OffsetX", move - moveSpeed);
        }
        if (Input.GetKey(KeyCode.W))
        {
            float move = material.GetFloat("_OffsetY");
            material.SetFloat("_OffsetY", move + moveSpeed);
        }
        if (Input.GetKey(KeyCode.S))
        {
            float move = material.GetFloat("_OffsetY");
            material.SetFloat("_OffsetY", move - moveSpeed);
        }

    }
    private void Update()
    {
        Move();
    }
}

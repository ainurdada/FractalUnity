Shader "Unlit/FractalShader"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "black" {}
        _Zoom ("Zoom", float) = 1
        _OffsetX ("OffsetX", float) = 0
        _OffsetY ("OffsetY", float) = 0
        
        _Test ("test", float) = 1
        
    }
    SubShader
    {
        Tags {"RenderType"="Opaque"}
        LOD 200

        CGPROGRAM

        #pragma surface surf Standard 
        #pragma target 3.0
        
        sampler2D _MainTex;
        float _Zoom, _OffsetX, _OffsetY, _Test;
        
        struct Input{
        half2 uv_MainTex;
        };
        
        void surf(Input IN, inout SurfaceOutputStandard o){
            
            float zx = 0, zy = 0, cx = 0, cy = 0;

            float result = 0;
            fixed iterations = 0, maxIteratoins = 1000;

            fixed mini = -2, maxi = 2, minr = -2, maxr = 2;
            float xMultiply = (maxr - minr); 
            float yMultiply = (maxi - mini); 

            float zoomedSize = 1/(_Zoom);
            float minZoomPoint = ((1-zoomedSize) / 2);

            cx = (IN.uv_MainTex.x * zoomedSize + minZoomPoint + _OffsetX) * xMultiply + minr;
            cy = (IN.uv_MainTex.y * zoomedSize + minZoomPoint + _OffsetY) * yMultiply + mini;

            while(result < 4 * _Zoom * _Zoom && iterations < maxIteratoins){
                iterations++;
                float tempX = zx;
                float tempY = zy;

                zx =  ((tempX * tempX) - (tempY * tempY) + cx);
                zy = (2 * tempX * tempY + cy);
                result = (zx * zx) + (zy * zy);


            }
            

            fixed3 clr = tex2D(_MainTex,IN.uv_MainTex);

            clr = fixed3((iterations * 0.002) %255, (iterations * 0.02) %255, (iterations * 0.016) %255);

            o.Albedo = clr.rgb;
        }


        ENDCG
    }
    Fallback "Legacy Shaders/Transparent/VertexLit"
}

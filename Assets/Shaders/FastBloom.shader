Shader "Custom/FastBloom" {
	Properties {
		_MainTex ("MainTex(RGB)", 2D) = "white" {}
		_Threshold ("Threshold", Range(0.0,1.0)) = 0.5
		_Strength ("Strength", Range(1.0,5.0)) = 2.0
		_Alpha ("Alpha", Range(0.0,1.0)) = 0.1
	}
	SubShader {
		Tags { 
			"RenderType"="Opaque"
		}

		LOD 100
		Fog { Mode Off }

		// 1
		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha
			
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest

			#include "UnityCG.cginc"

			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;

			struct v2f
			{
				float4 position : SV_POSITION;
				half2  uv		: TEXCOORD0;
			};

			v2f vert( appdata_full v )
			{
				v2f o;
				o.position = mul( UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX( v.texcoord, _MainTex);
				return o;
			}

			fixed4 frag( v2f IN ) : COLOR
			{
				fixed4 tex = tex2D(_MainTex, IN.uv);
				return tex; 
			}


			ENDCG
		}

		// 2
		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha
			
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest

			#include "UnityCG.cginc"

			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;
			uniform fixed _Threshold;
			uniform fixed _Strength;
			uniform fixed _Alpha;

			struct v2f
			{
				float4 position : SV_POSITION;
				half2  uv		: TEXCOORD0;
			};

			v2f vert( appdata_full v )
			{
				v2f o;
				o.position = mul( UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX( v.texcoord, _MainTex);
				return o;
			}

			fixed4 frag( v2f IN ) : COLOR
			{
				fixed4 tex = (tex2D(_MainTex, IN.uv) - _Threshold) * _Strength;
				tex.a *= _Alpha;
				return tex; 
			}

			ENDCG
		}

	}
	FallBack "Diffuse"
}

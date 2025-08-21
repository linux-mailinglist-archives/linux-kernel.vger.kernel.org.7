Return-Path: <linux-kernel+bounces-780482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC2EB30288
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F6E3B1A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B24734DCD0;
	Thu, 21 Aug 2025 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YGjBJFln"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8183451CC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755802594; cv=none; b=u/7BS3ayeQZyriUcYmwn+2ApKgLxwGDRvBJzbwDYG6Vn9SyW4iu3AVrlDlwZ1AS55bIIH8A31pTYtm/DSXgnoAMUcHg7xrsbbrvyXSzkK+Nm8L5Py8XDHvfmgp1JUuTAGiMAcnAISWsJQG1rgVW/nqFtdvuchGUVdIt4w00B+E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755802594; c=relaxed/simple;
	bh=6AFrVVcg/N51X91M5bv9em1Itbidcds+ZgEHoW2k3Ec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=auPtQl4nWl7awcQUpp9aR3b5E+ROjQIBaBk4XkZgq8Xkhuvu8VfngeewnUOMuZr9rt4lhhv8OkgRU+MJnJLK/0elD5Le36jAlaNkvrv2ZPvxfW8P5WcKeeq6jifVCNM56SnCjK/erKtyGzbSn6I974yCl1Wd9IZGEE6cu3exhZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YGjBJFln; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LI9aPj031029
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tPLB0lOSl90qjv87azKGiAHlMSsu88zpljXIRtVwbjQ=; b=YGjBJFlnVQhEEWkZ
	S+x2kx4nwHhRT8q5cP88FHWG8ygji6d7he5zz8QGXxnbsIBzskIKIvEy62VEHS7T
	Px4PFnxxix9YYQ70WgDGB0xn7TNVyVybToDo1JtXe1L0alellQ5VRy8PZ2hJnE5N
	SbtVbDEIiSGgI0uCTj3iEuZkun7EjR+FNo8vKzaz5SiB1DzyGAWp4VtlVfGBKJs3
	npIofUQKQB2CzcjAUHkcJWEN4S64O9iWkbaZ8nVv/bMT+xsyQiBN+vqL9UyK8b7G
	jTKaypFeriZJawT4FLmXLVrqXztM3vWq9CLyPd9qyqmoZB3MLyLViHKSUWUzKvjF
	ElskNw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a6mkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:56:31 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2e8b4ab7so1250434b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755802591; x=1756407391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPLB0lOSl90qjv87azKGiAHlMSsu88zpljXIRtVwbjQ=;
        b=p2+G4mjcYSJIBiLrkWYE09FbDbrncl4Agjdn5VKkJJf+Aaa7eW3+r00AjANlOGaTVX
         2mS2fwATehKU36lUL2C0BpwgWhtCay3po1115yx4ML1OqSfOoZYg8uhx/d2Sy14Eckzs
         aJAIjsuR2fUpBZ0G4NlqcWN3Z1zye4rxnAugtaqaFbAyeDxUaxQ6W6DCgOjtcTi897Y2
         il3mLZoypDDUMH1i3EHGv2VCAT7MiFg1IO87Wpr0gx2iWIL9a5pttxyGxcmTr+q7Wrp7
         TSQMkmC2liq7ZdW0tJPUsfB5wzcB3g3NfVPS4J3MNPcHnya9UIRnq+j9v1mUt13Q3dZ9
         OCGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg2HTVk6cGr0TysfIkrLuZ9S28MEFFLWP3JfAFqKMqy1hm/7GG6CBWsVQWVN5enmofIO3T5XuWvCKD9nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJim4SDar0YeWlijculb3bVclo0vzpaVwrYJD6l3tltS3a8u7m
	JNIOgpItB6w7VR0/5PyyJ0XWkVkH1omAbiQFnbAVVR7e9UEPfBn067hBaMlrTt/xnd4fRYJwz1n
	iojA2iU8h/F/DBGNkfZd15bQVbbpKv74Y0cTqHveUnL2PUMYyXtj1l3CqmBShAu0fb24=
X-Gm-Gg: ASbGncud/Rb5U8CAGrMcD4mDFHw23tvmke/Hs+FNnd8IxA1Qvact+8Lz9cVw2OE/nET
	vH76JjLgk53txdXoAqHqFxnQZ+Yi/wiWYHyfMXbtwl8K1SgoZySdELtu6PL9zcoWGW02Vqz8NKb
	yl+v+MP1hYmxNhG6xGzboRatD3bnFdFga4KwhQhKhERDJerdO1u3IFy8nltpPPwZrdttlzqTAuL
	769+WDWNx1EcYllQP0Wtl/g0GLdSQv7jrDhIhkc92KdBDqOWSa9LtbqEMEqyLsze01xs6xM2CPL
	dTVcUfoKzvvM42YJmfRgorBwxoUXSak/nzDa119Pud+wuS7Af9t/a5pDX5aXjvDA
X-Received: by 2002:a05:6a20:2585:b0:243:78a:82a3 with SMTP id adf61e73a8af0-24340e4a4edmr269985637.60.1755802591155;
        Thu, 21 Aug 2025 11:56:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgXXMidYmQXFpqBRDLcsODNjXVwWerFYBzO2zoS70dDoedtPxh2rZs542+/5DAWroEPgZTFQ==
X-Received: by 2002:a05:6a20:2585:b0:243:78a:82a3 with SMTP id adf61e73a8af0-24340e4a4edmr269952637.60.1755802590729;
        Thu, 21 Aug 2025 11:56:30 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4764090b0esm2106977a12.37.2025.08.21.11.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 11:56:30 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 00:25:28 +0530
Subject: [PATCH v4 3/6] arm64: dts: qcom: sa8775p: Add gpu and gmu nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-a663-gpu-support-v4-3-97d26bb2144e@oss.qualcomm.com>
References: <20250822-a663-gpu-support-v4-0-97d26bb2144e@oss.qualcomm.com>
In-Reply-To: <20250822-a663-gpu-support-v4-0-97d26bb2144e@oss.qualcomm.com>
To: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: Gaurav Kohli <quic_gkohli@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755802565; l=4497;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=nI41liweZfTMu604YixzPD6RJqaIWEkGUI9JOPsmvDw=;
 b=Dc8lSBNBKRNBYdzfgozV0uhBRvQ64bZE53SgZopfgFk3sLXSxqDcg92mzm4x+EOOQij2IrdA5
 4/s0j2HHGsEAVbEtHg9bAJD3doK7ClVrT0Z3RgIm94q2mgxETjjI0PE
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=feD0C0QF c=1 sm=1 tr=0 ts=68a76be0 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=D_IGQ_qLm8RrHFHUsBgA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: FmYVKoIk4fTVSNSq6NEg40x7XuEAAj50
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX+IniO4MHy0jh
 kxq+Pz+DMRY1acuFbKO6gpmWX2pSqxFhzuLYkiU4pyW+zPJzS009rTtZ0bDknq0zvC12aZh9REB
 BqyhgQeM2QivLTwypPzFg/HHzftTbNSQKQgtd19buKaC3JmWMlqrbghILaf6hOxL1s4xr3QGedN
 izUjTZFi/tKDsjGUCPT/rKF5ukKeqchYFzvI9F6LmkGE/hocpTc5oRFaYhBe59+QvRqYEbJ0dVt
 AxHrOiXgNIlfeYRU6MHlEAFGyXrOnwwI3vEe7h5daAJKx2cm0AzXODHzEE5pbzX6kE1fu8WHF7C
 V++MBYS516QPSdnsYMAykHoBVoP812axqW+82itx1uF0vQgB8LiOi+pqeglA2qs0MMyemmVMm74
 sKNVcC5ysOcqs5gHPQhvcHaZoCE7Aw==
X-Proofpoint-GUID: FmYVKoIk4fTVSNSq6NEg40x7XuEAAj50
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

From: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>

Add gpu and gmu nodes for sa8775p chipset. As of now all
SKUs have the same GPU fmax, so there is no requirement of
speed bin support.

Signed-off-by: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 116 +++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 8ceb59742a9fc6562b2c38731ddabe3a549f7f35..8eac8d4719db9230105ad93ac22287850b6b007c 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -1097,6 +1097,18 @@ ipcc: mailbox@408000 {
 			#mbox-cells = <2>;
 		};
 
+		qfprom: efuse@784000 {
+			compatible = "qcom,sa8775p-qfprom", "qcom,qfprom";
+			reg = <0x0 0x00784000 0x0 0x2410>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			gpu_speed_bin: gpu_speed_bin@240c {
+				reg = <0x240c 0x1>;
+				bits = <0 8>;
+			};
+		};
+
 		gpi_dma2: dma-controller@800000  {
 			compatible = "qcom,sa8775p-gpi-dma", "qcom,sm6350-gpi-dma";
 			reg = <0x0 0x00800000 0x0 0x60000>;
@@ -4093,6 +4105,110 @@ tcsr: syscon@1fc0000 {
 			reg = <0x0 0x1fc0000 0x0 0x30000>;
 		};
 
+		gpu: gpu@3d00000 {
+			compatible = "qcom,adreno-663.0", "qcom,adreno";
+			reg = <0x0 0x03d00000 0x0 0x40000>,
+			      <0x0 0x03d9e000 0x0 0x1000>,
+			      <0x0 0x03d61000 0x0 0x800>;
+			reg-names = "kgsl_3d0_reg_memory",
+				    "cx_mem",
+				    "cx_dbgc";
+			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+			iommus = <&adreno_smmu 0 0xc00>,
+				 <&adreno_smmu 1 0xc00>;
+			operating-points-v2 = <&gpu_opp_table>;
+			qcom,gmu = <&gmu>;
+			interconnects = <&gem_noc MASTER_GFX3D QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "gfx-mem";
+			#cooling-cells = <2>;
+
+			status = "disabled";
+
+			gpu_zap_shader: zap-shader {
+				memory-region = <&pil_gpu_mem>;
+			};
+
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-405000000 {
+					opp-hz = /bits/ 64 <405000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					opp-peak-kBps = <5285156>;
+					opp-supported-hw = <0x3>;
+				};
+
+				opp-530000000 {
+					opp-hz = /bits/ 64 <530000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					opp-peak-kBps = <12484375>;
+					opp-supported-hw = <0x2>;
+				};
+
+				opp-676000000 {
+					opp-hz = /bits/ 64 <676000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					opp-peak-kBps = <8171875>;
+					opp-supported-hw = <0x1>;
+				};
+
+				opp-778000000 {
+					opp-hz = /bits/ 64 <778000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+					opp-peak-kBps = <10687500>;
+					opp-supported-hw = <0x1>;
+				};
+
+				opp-800000000 {
+					opp-hz = /bits/ 64 <800000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+					opp-peak-kBps = <12484375>;
+					opp-supported-hw = <0x1>;
+				};
+			};
+		};
+
+		gmu: gmu@3d6a000 {
+			compatible = "qcom,adreno-gmu-663.0", "qcom,adreno-gmu";
+			reg = <0x0 0x03d6a000 0x0 0x34000>,
+			      <0x0 0x03de0000 0x0 0x10000>,
+			      <0x0 0x0b290000 0x0 0x10000>;
+			reg-names = "gmu", "rscc", "gmu_pdc";
+			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hfi", "gmu";
+			clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
+				 <&gpucc GPU_CC_CXO_CLK>,
+				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
+				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&gpucc GPU_CC_AHB_CLK>,
+				 <&gpucc GPU_CC_HUB_CX_INT_CLK>,
+				 <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>;
+			clock-names = "gmu",
+				      "cxo",
+				      "axi",
+				      "memnoc",
+				      "ahb",
+				      "hub",
+				      "smmu_vote";
+			power-domains = <&gpucc GPU_CC_CX_GDSC>,
+					<&gpucc GPU_CC_GX_GDSC>;
+			power-domain-names = "cx",
+					     "gx";
+			iommus = <&adreno_smmu 5 0xc00>;
+			operating-points-v2 = <&gmu_opp_table>;
+
+			gmu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-200000000 {
+					opp-hz = /bits/ 64 <200000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
+				};
+			};
+		};
+
 		gpucc: clock-controller@3d90000 {
 			compatible = "qcom,sa8775p-gpucc";
 			reg = <0x0 0x03d90000 0x0 0xa000>;

-- 
2.50.1



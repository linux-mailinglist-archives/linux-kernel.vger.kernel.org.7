Return-Path: <linux-kernel+bounces-858510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DCDBEB02D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A34C35F953
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A75E302CC7;
	Fri, 17 Oct 2025 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HlVAKuzH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EC3302CA2
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720972; cv=none; b=aFyJ90biFBrIxmk1KJI3jTcRdTdc24ZXlnJr7q82mUayGRqQ0KJtRzNJlJ+NFp1HtWYNedlfQ5cQL3Q6OrvPnlVkG0K4DTbwZvpcpn3dLSy3auFdCDGog4RrupPq5Y230X30+Sr4HWz0y+/JZXlxLo6P+XLnjgUVf5OOtyQF+k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720972; c=relaxed/simple;
	bh=eubN1SNcEiFBUmnvIMKscUak3a9TkLmcxn/pNLpftMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VSm3Vw869Urd1lBL6kFUzCpx9TSuqQEeHC5j0LUIm4HD8Okfw27DHG9/cpzG10yL2MRv6mQEP/1iH84vXPAo5Jv+YBl4+KdKA+csIuMdbywtK4NuNBYWDVSl4l3+Cs5e4ZorZf0r9SdZ3A2sXTVVfxhCaZuHdT3L5p+BS9udR6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HlVAKuzH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H8Y3QE009737
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dHkPqzKL5cOW6aLL+kPJl4pl/S+1jflMOk+MByC2fno=; b=HlVAKuzHh6zu+Egu
	DSqD6lycJX5+oBGVKBDWD9ysgND+vCI1g+jjSUtG0Trybpsyawxps/OhKXviOyVm
	9tO75ZywroCnvPQu3u/Kebe2WZtHw6LkS/nhgdbsiiPz9NVENM1EXuT8+sO/i3Ku
	cyYY+isDWLcSVtSJqhhuPFZvhtdpWp9MNBDZOyAPesAAx1/Yb+fzEkNhH75iKCZY
	JMld9i6FVGzectTOD7OxDU0XUoI3BaisR0/TvFs2xV1bre0fTRIsOksiHYzTBu0/
	uZcrWEns+QY/cjP3q6QgdYCeP128qg1bKd5l0VDaSKzRzZvrHKh2+SXUPul67zrU
	Oanv/A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1asa77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:09:29 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2909e6471a9so16988575ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760720969; x=1761325769;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHkPqzKL5cOW6aLL+kPJl4pl/S+1jflMOk+MByC2fno=;
        b=u9Yg4ai03Z7fGx0MD6lPq/Cco5+afla+78gSYBL5jyGmSMIRTZyLFLYSVHlpnrXBTP
         078/czZoyRcFDJdePYer6Txy18tG0/Um7anB94FfUROHWaZqw75q/3suzR+PKesCklmz
         8Nug5taf0rAYb1aud3hNGd3j/3iPzIIFh/2KAkb7AaIckl2N3OHebaC2hQ8+T9s9JOtt
         hd4c5vwlLeIgCSfnWrAy8GbbmVfMduTkmU7yOiOr0VFKMn9pmp3x9Wxvyku3mrq40GhS
         7+8ndxqjYvbCX3VsSJDl39ChKBUOWCCf9WVvaqG7sr1gHmTZG58NcFOxU0pAP4Vue4IR
         Gkng==
X-Forwarded-Encrypted: i=1; AJvYcCX5YbLItDbr2Zny1ZhYSwxsdnXgRL5tYAea242798/Iwiv/RO3MojJpcBRFfyjKnTZ9k0Mx9xM/ZRr+cyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO4fAHDzoPzJCOUnFTo1hIorTEe7E76YUv+qJCyKu+3eSdDnJh
	kCbG9TAOkAe12gHwR6PNjtdiKiVaYKpVTeK/JtKiUYbxgkS2MlTu1MNEQVAFmIf+QMQJNUlMMPX
	zjjj+NkoqoDnCss2Rtw+4uXflmM6+ZuqM4sw7FzjKAsJ+7MDQlLAYe2YqcwQjFy3gfB4=
X-Gm-Gg: ASbGncteacRQbbITEAtzVSVnSXDJ5WoRgWsbPaLPLT1L9n7rl+UsCJkAZw4c+idhMOY
	/Lz7egQJjPMX81DdN7LoxKZ+OGQ7ydFwX6E+to5kJva2/Nq7eH/oB5SQbs16NqDQeV6BCrmO5ci
	mbeYxM1h+1VlzkJq+NWsIX+Y44Xxa643ebPKETMaQuvQGNrXZi0QpDj0EsdP+Ujw4WGJX9zIgC7
	vG6FK0f3AgdxjVLdBuhKbLL35oLHBSrdOQll3COamvN+vA9ruDbO8zITxIaHhbdnKJConuEkL0U
	01XX64+0ns02YD0+/vGAmTt9g/XdowI+Yf0P4opxaYMNwI2r9LbgOZbqDTrSajz2ZcDVL8QZA7D
	LwMSejOZ4GGmDnrRHAqE4olI=
X-Received: by 2002:a17:903:b48:b0:290:29ba:340f with SMTP id d9443c01a7336-290cb17c05fmr56313295ad.42.1760720968761;
        Fri, 17 Oct 2025 10:09:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUHA1cKYoK5EhzqViS61RGZd6u0Dhx9U4B3Qz8Ha/inD8zekpvuLlC6BeCF7KMumjqYTzq3w==
X-Received: by 2002:a17:903:b48:b0:290:29ba:340f with SMTP id d9443c01a7336-290cb17c05fmr56312755ad.42.1760720968090;
        Fri, 17 Oct 2025 10:09:28 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471febc6sm173625ad.86.2025.10.17.10.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 10:09:27 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 22:38:33 +0530
Subject: [PATCH 5/6] arm64: dts: qcom: qcs615: Add gpu and rgmu nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-qcs615-spin-2-v1-5-0baa44f80905@oss.qualcomm.com>
References: <20251017-qcs615-spin-2-v1-0-0baa44f80905@oss.qualcomm.com>
In-Reply-To: <20251017-qcs615-spin-2-v1-0-0baa44f80905@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Jie Zhang <quic_jiezh@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760720932; l=3741;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=pYXZ8JyrCel0n/Z58j1178sF3I/9eN/SDHbJiB8QyuU=;
 b=cd5A5lv+d5mtTnZWr7466DoX8m11khu+CGe/Vzv5l+k/D49mAQ3av+THiJdckItV2Rx4iIEWL
 6AMy/VgCXXHAq9LXNnYVs3uZaOSZo+oOIZe7P42si7eYNgLZg0DYVTs
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68f27849 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=WQ4zR0kUUHxS2nCRhxYA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: iXFcDQ1ZavTH3_emgnL-UejkFpWreMh7
X-Proofpoint-ORIG-GUID: iXFcDQ1ZavTH3_emgnL-UejkFpWreMh7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfX8oyc0gfR520h
 nqwymSGAnMS3vWSFANRzd5UQS9BA59TzzGq9mzdxXVYSPREMQEMjqg5JzikjFZFusmyPUcZXs8E
 80RX/2UrOkDuwqy37guIXNf/D8KHCCWXNI7Bt8p8o3twaOTBQ9Z3jAFlFM3NeVkjiWiyUksAp25
 96ia13h4bYU3GTw/89wC8eWLAO8YaD2dZo7lFFz2eIew/scpSg1ZBGNOqXfUOJAo/17VBh0ofrZ
 ReiNbFaYLhrVl8QFOKHknB68v4f+bwm6m/EhLoSJse2a4943FAGqBSM4LZZrVK4Uu6BuBODHERM
 X/CkJ8bqHM1Su/vwktB+HLWZyB3eAQDznwlHiIVlyMf7zgx/fFkZAKFwZVcNu22VU3+gdQbhSbJ
 60MOpbhzhgNlXYzRhJl/9KCfhWWeqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035

From: Jie Zhang <quic_jiezh@quicinc.com>

Add gpu and rgmu nodes for qcs615 chipset.

Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm6150.dtsi | 112 +++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6150.dtsi b/arch/arm64/boot/dts/qcom/sm6150.dtsi
index e62b062c543657b6fd8f9aba7ad595855d8134d6..8181f63e4d6838b1d198972199756271707e6e49 100644
--- a/arch/arm64/boot/dts/qcom/sm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6150.dtsi
@@ -508,6 +508,11 @@ rproc_adsp_mem: rproc-adsp@95900000 {
 			reg = <0x0 0x95900000 0x0 0x1e00000>;
 			no-map;
 		};
+
+		pil_gpu_mem: pil-gpu@97715000 {
+			reg = <0x0 0x97715000 0x0 0x2000>;
+			no-map;
+		};
 	};
 
 	soc: soc@0 {
@@ -1687,6 +1692,113 @@ data-pins {
 			};
 		};
 
+		gpu: gpu@5000000 {
+			compatible = "qcom,adreno-612.0", "qcom,adreno";
+			reg = <0x0 0x05000000 0x0 0x90000>;
+			reg-names = "kgsl_3d0_reg_memory";
+
+			clocks = <&gpucc GPU_CC_GX_GFX3D_CLK>;
+			clock-names = "core";
+
+			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+
+			interconnects = <&gem_noc MASTER_GFX3D QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "gfx-mem";
+
+			iommus = <&adreno_smmu 0x0 0x401>;
+
+			operating-points-v2 = <&gpu_opp_table>;
+			power-domains = <&rpmhpd RPMHPD_CX>;
+
+			qcom,gmu = <&rgmu>;
+
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
+				opp-845000000 {
+					opp-hz = /bits/ 64 <845000000>;
+					required-opps = <&rpmhpd_opp_turbo>;
+					opp-peak-kBps = <7050000>;
+				};
+
+				opp-745000000 {
+					opp-hz = /bits/ 64 <745000000>;
+					required-opps = <&rpmhpd_opp_nom_l1>;
+					opp-peak-kBps = <6075000>;
+				};
+
+				opp-650000000 {
+					opp-hz = /bits/ 64 <650000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <5287500>;
+				};
+
+				opp-500000000 {
+					opp-hz = /bits/ 64 <500000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>;
+					opp-peak-kBps = <3975000>;
+				};
+
+				opp-435000000 {
+					opp-hz = /bits/ 64 <435000000>;
+					required-opps = <&rpmhpd_opp_svs>;
+					opp-peak-kBps = <3000000>;
+				};
+
+				opp-290000000 {
+					opp-hz = /bits/ 64 <290000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <1762500>;
+				};
+			};
+		};
+
+		rgmu: rgmu@506a000 {
+			compatible = "qcom,adreno-rgmu-612.0", "qcom,adreno-rgmu";
+			reg = <0x0 0x0506a000 0x0 0x34000>;
+			reg-names = "gmu";
+
+			clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
+				 <&gpucc GPU_CC_CXO_CLK>,
+				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
+				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>;
+			clock-names = "gmu",
+				      "cxo",
+				      "axi",
+				      "memnoc",
+				      "smmu_vote";
+
+			power-domains = <&gpucc CX_GDSC>,
+					<&gpucc GX_GDSC>,
+					<&rpmhpd RPMHPD_CX>;
+			power-domain-names = "cx", "gx", "vdd_cx";
+
+			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "oob", "gmu";
+
+			operating-points-v2 = <&rgmu_opp_table>;
+
+			rgmu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-200000000 {
+					opp-hz = /bits/ 64 <200000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+			};
+		};
+
 		gpucc: clock-controller@5090000 {
 			compatible = "qcom,qcs615-gpucc";
 			reg = <0 0x05090000 0 0x9000>;

-- 
2.51.0



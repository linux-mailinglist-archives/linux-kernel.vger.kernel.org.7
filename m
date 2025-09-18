Return-Path: <linux-kernel+bounces-797853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C2BB41648
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87B91BA1B7D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C092D97BD;
	Wed,  3 Sep 2025 07:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jmKYjV8y"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A712D9EEF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756884033; cv=none; b=jz28g0CiMp4rfaS0XRwrFZ49ubScrSqGBFHmchql1wz3JZc41AZkkgK1LPKfPUeLRaukxvPcMWQ2tGKmiLjLiqthcUYSgg2+VzQI8ofgF/iWHyld+wXTtCz7/uyhTmlzE2nlzxopGSd5ULyDp896bw0Cp8cxyrAUOFlyIendJ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756884033; c=relaxed/simple;
	bh=Rt+uJIP9yhMYsZGl3Ni5LGLHO0NjDFQ9aBLE6yz0egI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nkYPfBYebVS8k13YTLPLlmniT8+uXysvRarNW7bdXLkFS6dhq7GHfDOHf91xT61SDzwLMLbwuU7JWBvB9iWLvW9pJ5HZZ7AwO8jnDfeikAeJdh4ol90aopJ/wj7TUXvfQ6VxACFMhSU2eJhQr6g8AmrTAW6mNXPzGyMryGN8flA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jmKYjV8y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5832mHIO012509
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 07:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6gD8qutWEStZDNubpi2rWDL7kuXRdLU/Z53l7eIhvmU=; b=jmKYjV8ycL51+iTZ
	8ZrqDWNmkWqlAeEPRlIo6mXvkUEIXXndvFerD6H1b7eBJNJmln7rUbMS5R6EPHUS
	giUjCHEqXEkCiGEJ5Ihu2rKYCFD4T4/aQfZKpO/m5W9wSQoU7u/hFkxHQh4Ep+IF
	eKyHI5YfeiX9zJps7BxtVyQ0zvbeEAe4RGatJVndYA1hAw0xqdekCD6xsH1U4wd/
	BlI1Py8JgCQ1Mn9phx4+rPnu41udKjK2qtUO78tZ5wQD3sEK12tmN1Rvk3jT6aTD
	AWf3/6PoWPHDFsx6KjpFQU6wYwZUNOsAWVhqh1f8p1p/jB/BGUqr4ZyG6nmW2iF4
	wEUXvw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fjfyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:20:31 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7724ff1200eso2745445b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 00:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756884031; x=1757488831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gD8qutWEStZDNubpi2rWDL7kuXRdLU/Z53l7eIhvmU=;
        b=IruL2wM89jr5Nk7NLcZRk0q22LcEWJGLZelm9Lu3U/fxuBmfsqJKZfS9dNzBwxtil2
         hHml2xIlK5Sckwif3j5bGE64DkfWl+tCRnDQ7BDXkCdyjhw6mErvfiN8R5yAjr9C5m0g
         /XpwmXyB7AJk/nKaWkYf0nY2kTChRdMbfGi22/na4gEey5VHRhqHBtQX01X4LKeykrZo
         a2gLXLgSKdlEgp8SCekge3JtySwLJMcV6FUynFLLd/X+k97ymIyGUVdAyqwWJEPmbmWm
         fHZjXGJjYR5bsqCJRDH3+1a/1e/iOLTp/1vkEBTyyUxaXw1aBVJfIqb5wGiNQVnC1zsV
         KrJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLlJFRctDuvwt2SGTjYTyRxbfEEJ3t+oVKC0usHFvQ3F+0hceTak9RVUk8Ec81WxskoeuyjfcVqTlgcS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVSXwWCYYroDiNQ4/exSFKon6cTmmG7mcSwvpw9d7vSMoIlEuc
	XOLRkIKGQkgD91IygS6HBKM+H6MPOMqml4bTSQ3zcvzLYcBV3UvQHNAahs36KKKNei38g2CtbjY
	LmZEWmiRRFK45N/j+P3sHhT1yyvtDj1lyrVzq5tG/Vnld55UKQ3kiDYwV3ubJomMva/Y=
X-Gm-Gg: ASbGncsBqqdSqmzw0l6SVpJVmQ7iW8CAA90Z8yr3rV/IeTLp9+jROwnZhO57b0crYek
	hN85KvcGHEU8RNiIWL6+9ppaxQmISU5Mo21wfRXcoZ6kyIzrtEvIOCVheo13C/41exDQ+eCUkhT
	zhgXRcWxE8UxCdlQ69H97cLzp6sWI/WtRdXvw7+vR7Ez9+wTTNHFNRN0yx7W//EQFnNi0ytjz4d
	Yn6ZuH1P37RYmeFo/IK61gehV/VH231EZDwIpHWoXktlEfVDR/dMb5iJs4nMKfFKgHc9AIij1zR
	ad91TaRCshG75jjr12JMRP82BIXbb9Maf8Y9rt4m7980FNuBIIsOe1QnZoQJI2Jl
X-Received: by 2002:a05:6a00:7450:b0:772:f60:75b0 with SMTP id d2e1a72fcca58-7723e3b1c5fmr16627567b3a.24.1756884030796;
        Wed, 03 Sep 2025 00:20:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/VZ+eezWf10NsdDC2ah8ohwPyf3u6U2AGy+CxYZi3Y89RHsi9zo/N0N7Fd74Q52ZM1qd6cg==
X-Received: by 2002:a05:6a00:7450:b0:772:f60:75b0 with SMTP id d2e1a72fcca58-7723e3b1c5fmr16627514b3a.24.1756884030249;
        Wed, 03 Sep 2025 00:20:30 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b78d7sm15816191b3a.30.2025.09.03.00.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 00:20:29 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 12:49:54 +0530
Subject: [PATCH v5 3/5] arm64: dts: qcom: qcs8300: Add gpu and gmu nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-a623-gpu-support-v5-3-5398585e2981@oss.qualcomm.com>
References: <20250903-a623-gpu-support-v5-0-5398585e2981@oss.qualcomm.com>
In-Reply-To: <20250903-a623-gpu-support-v5-0-5398585e2981@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Gaurav Kohli <quic_gkohli@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Zhang <quic_jiezh@quicinc.com>,
        Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756884002; l=4180;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=3SVCOq1sUsaaG/McjBG1Nl1zTTKQqCIctO2ttcMNFK8=;
 b=BbTief53o9N8JFHS3Yt30CjJDyW3NZXLWVKqf967YbaIbxFFCHlyi5x0qtJHelPM25s09xqrI
 GGfGqLavwrDC7mDTKDKJeSeZ3WliyA65moxk1FSIgvchPuI4QVRsp1J
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX9csaG5f7VD0h
 XL2yHxpUIrOvaPbVPYvF499RBayXVrkhJFk2rYMyvHSLlJVN21EtvPd4A2o4ZWhbbM/fyraR+w8
 z0ghqCcPVD+RKKe/PgyBoxRSlGw0JcnPuHL9jqLHAn7At3PI7EjTWqsRF481ThgVNgwHkoa9rH/
 wdWt61qsphdMK2TwTP+j2EYu/r6C7wApnV3wb84mWaSy1ClUnmPdymG76ZueEDIjE1c84eMhANx
 mbElD4iVwLL2bkRKKGeKr2ILTvqxPEPoZx5+2l42aDCwxtZSLdS5ExLM+K5O6Vh1iNRSm7lPrmU
 67LZz5/+8L/FWzNxvevsuJJgIKFeJUITxVMI4s2Y5JwvNr3oA/T8NTa+zp+ezzjbQvOY/ltL5Zp
 jIztp5Lm
X-Proofpoint-ORIG-GUID: iuMOUUz04NQR7cjHWrubJrc7BlqnIeuW
X-Proofpoint-GUID: iuMOUUz04NQR7cjHWrubJrc7BlqnIeuW
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b7ec3f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=D_IGQ_qLm8RrHFHUsBgA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038

From: Jie Zhang <quic_jiezh@quicinc.com>

Add gpu and gmu nodes for qcs8300 chipset.

Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs8300.dtsi | 105 +++++++++++++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
index 0024a75916d0dc3d2f48912549d9544c124e27ff..00e6131e6b24def4ff9566c14398aaa86efe557c 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
@@ -640,9 +640,14 @@ ipcc: mailbox@408000 {
 
 		qfprom: efuse@784000 {
 			compatible = "qcom,qcs8300-qfprom", "qcom,qfprom";
-			reg = <0x0 0x00784000 0x0 0x1200>;
+			reg = <0x0 0x00784000 0x0 0x2410>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			gpu_speed_bin: gpu_speed_bin@240c {
+				reg = <0x240c 0x1>;
+				bits = <0 8>;
+			};
 		};
 
 		gpi_dma0: dma-controller@900000 {
@@ -3903,6 +3908,104 @@ serdes0: phy@8909000 {
 			status = "disabled";
 		};
 
+		gpu: gpu@3d00000 {
+			compatible = "qcom,adreno-623.0", "qcom,adreno";
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
+			nvmem-cells = <&gpu_speed_bin>;
+			nvmem-cell-names = "speed_bin";
+
+			status = "disabled";
+
+			gpu_zap_shader: zap-shader {
+				memory-region = <&gpu_microcode_mem>;
+			};
+
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-877000000 {
+					opp-hz = /bits/ 64 <877000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+					opp-peak-kBps = <12484375>;
+					opp-supported-hw = <0x1>;
+				};
+
+				opp-780000000 {
+					opp-hz = /bits/ 64 <780000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+					opp-peak-kBps = <10687500>;
+					opp-supported-hw = <0x1>;
+				};
+
+				opp-599000000 {
+					opp-hz = /bits/ 64 <599000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					opp-peak-kBps = <8171875>;
+					opp-supported-hw = <0x3>;
+				};
+
+				opp-479000000 {
+					opp-hz = /bits/ 64 <479000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					opp-peak-kBps = <5285156>;
+					opp-supported-hw = <0x3>;
+				};
+			};
+		};
+
+		gmu: gmu@3d6a000 {
+			compatible = "qcom,adreno-gmu-623.0", "qcom,adreno-gmu";
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
+				 <&gpucc GPU_CC_HUB_CX_INT_CLK>;
+			clock-names = "gmu",
+				      "cxo",
+				      "axi",
+				      "memnoc",
+				      "ahb",
+				      "hub";
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
+				opp-500000000 {
+					opp-hz = /bits/ 64 <500000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+				};
+			};
+		};
+
 		gpucc: clock-controller@3d90000 {
 			compatible = "qcom,qcs8300-gpucc";
 			reg = <0x0 0x03d90000 0x0 0xa000>;

-- 
2.50.1



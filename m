Return-Path: <linux-kernel+bounces-886952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D34A5C36D07
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACBDE4F3018
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1556337B96;
	Wed,  5 Nov 2025 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U75+wgNF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QsnvX6af"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548573385BC
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361185; cv=none; b=CUdn3/+MqiziE7HdKJWT1HjoOR8y7MLkHQvKjmhw1QqM0OWVQALE/znimvkq3EsAkfpjdt8Nl/ZLq2GnWOxl57B669IrtYVsHQm0Fjl5VW/R8iXHdm4geI4JLSRhoVuBCDaC2ZH5hBmM7jV+oZ7kSjFaWTzZf7zCrAygnLNNW90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361185; c=relaxed/simple;
	bh=UrygXLv9tiTTV7SBe3kyVlz2seAU0VkTfOThP5BSXcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NCMc/ueWVGVhNNN8a2rga9+fBwAiK1zXTWl5F9C9paP+qn8tQGPgMMlKC1hhzfh4i70izT+h/vJtiAxfM8F9Zoa1SfxNdVHRmdGN+FlZ7ANG5thA/UcHkLKl9ApsMx4HHFGNs6a3WhHxdLIX5DRj7l1cjavRzDgTOvmpy1rGaas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U75+wgNF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QsnvX6af; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5DRFdZ3913967
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 16:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gNiaCnl/ZAJk2DgY15on5+Ci9unMo7cZ3k6PfcpQW8I=; b=U75+wgNFFDcfexLn
	i5pQaYJMM6iud5xMsaPr3VzLbADQfLKFHCx+pnTUvBjSwdAFz5NjJhXrY8stcQ71
	hlKeCxPSN0X/cI0OQc0PglA1zb9iBXkjD7iV67mQaiggM5kiipvqHudhh7nxGfU/
	E9P4jBbZS9MZbcbB6WCIa9+mSCcA60G0hgzGS0LhqI4H5OoZLCd8JNnFK2T/TG+q
	m26HQaUWRSIqZaQ+tfDcUEmqDwOrn+/ClGHKqxKbV7M//zygEKoVmjbc+P4bjHA/
	YBM3g3dnQz9+r79b6dAOfiQm8dTxW7VYgc4hyN/WiYQWsCtSD7XPv6LVV2Bcupp3
	F1Yaqg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7y37a0hg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 16:46:22 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32ee62ed6beso100468a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762361181; x=1762965981; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gNiaCnl/ZAJk2DgY15on5+Ci9unMo7cZ3k6PfcpQW8I=;
        b=QsnvX6afEDOL2ziGKQfYGFlKM1zhtjcwjhoDZLVGjdOvWZBCRiT61J74phqitqOMKu
         w6gWY6BoaXcO409A2q8YpaU1iJyMTYvATuCgqgnM8qPhIogNqjUeErIf0erZkVH8B2UR
         iEtq04teW5162tpTBZa2HbnXFQZ3uUWetCD5viBpVjmet8kN24ixgs1REymcHEV3sOlR
         z1u1en1rcZJH7RPbYn3gFE3mi/r1KP9E5DoY8gSGfcJWSa7IC8ed4DNkbpU3UjZqH/Dj
         BWCHGx8Br6+coZCAbD5XCqJcFsOBWlUZtf59cp/HiRCF9OVcN1bQQVk2eJyNOh5fOtuY
         rMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762361181; x=1762965981;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gNiaCnl/ZAJk2DgY15on5+Ci9unMo7cZ3k6PfcpQW8I=;
        b=oCtXVQ++lNjpwoikE+tMSKoB+IqebOe9lHw/L6wsIqcN+lVvMH9Fzi+FJFTexs2yg5
         VEMvx4AIP0fGaAsKD8a9giZIdl1W3yl0g8CxSwGAYdUww+7KO/zLaiKU+wKSZ9xr/rJv
         eDzXUvkxxNmoI/AxFiTLcSeJoR5T9Iuuk16NyvbEsL+kE0iDWYhijTTExxVYsnjCJleZ
         0sBD03cipmedhF3DZmpalU7tNAyvkg8dvqEb5TBEUQA4Wh6vHqFhY61wDhnAabpCGut1
         xM8j/eGgtLphwL4usXrpkxpNNUJA1W397aswV4VeGxokKfYV8hQOKimYUP1jUiPOVQOf
         OnVg==
X-Forwarded-Encrypted: i=1; AJvYcCXsHsseLlqHOmq8u7n25n5rswAWGT7bghRNPfFLZ2WiWTCkfidnMiAduDYDrZ9wfo1d/ZhxKhTJNTots9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCDSPy0JAsPBPLKy27uLF3qggf59QPSJNItoaCcpOr7OJJJu9W
	envSVxAHhrjPTvqn8uSXKV4TtlYNHNLmFdGu9BotnFHxM8jx/I2+hiepRutIlNsXbA4JOa9SJdB
	Dv4DG/NsMoI7YVf3gHMKIMFDYtxC9VZ32rslZoUqZFJJMFzTu+VdfyGQ2rUU39XqzGnE=
X-Gm-Gg: ASbGncumqLcHsLWaiBVN1ffxoikdyWT/ghJZNVxW35AFesweFukfXux+jfp/pP0JsSI
	U5wQ/uvYa7EnacjYDBf9J+2HgkchrTdS5I5EzJgMOKv+M4QjZPhqEB7dA1H1/kVkMegNVlLS1GO
	TzrFPS+JvoMNguDTUEaah+mSdQTdw7JHHri0XOVyZfo9gCxJa6tbRHGnoraHd4m2yH92i+KjN7D
	/BzYMkNYixZiU5R4D/ywLEcHUdpvUwwXMRNGlEYHasfqOOMVkRK+lJE822HH80oBvOAMq8BeyuV
	7j8gFSNTRfmHuHsNXR5b8WPe6nVIp8XMB4QOQjjmY85oypzVwiAV+x3ICG+hCzaVPjVluTsxnIX
	IC53poa+E/DQ3rmAwyW/WrSo=
X-Received: by 2002:a17:90b:17d0:b0:341:1ac:84e0 with SMTP id 98e67ed59e1d1-341a6c43bc6mr5313311a91.11.1762361181271;
        Wed, 05 Nov 2025 08:46:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpGdqaiaTEAa2LzG3a/pfsz08lzVJ8gnN8pk8dvCpVHcI2W34tyKgoSHwurHyUA8G0KlAHrQ==
X-Received: by 2002:a17:90b:17d0:b0:341:1ac:84e0 with SMTP id 98e67ed59e1d1-341a6c43bc6mr5313285a91.11.1762361180732;
        Wed, 05 Nov 2025 08:46:20 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68c822dsm3426249a91.8.2025.11.05.08.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:46:20 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 05 Nov 2025 22:15:46 +0530
Subject: [PATCH v7 2/5] arm64: dts: qcom: sa8775p: Add gpu and gmu nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-a663-gpu-support-v7-2-1bcf7f151125@oss.qualcomm.com>
References: <20251105-a663-gpu-support-v7-0-1bcf7f151125@oss.qualcomm.com>
In-Reply-To: <20251105-a663-gpu-support-v7-0-1bcf7f151125@oss.qualcomm.com>
To: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762361159; l=4606;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=luvOKrArTfNaPhVmBH/wS1foS7oE6cguSnjd/GdyRZE=;
 b=9/5ReRt6JvTHQu9A1ntMHBE9rjdzezS2IH6zgxk2zJlKqCx4SEhErJFAeq6nA9FH2cfjYSE2b
 QGTo+GPUp0yC7yBiY1J/3ndcFAaOiowRlxY0/Md2jLlmd9/YV/AEyVZ
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: LtrEIABF_xXO7W2tW3YHx2uzht1Hgmda
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEyOSBTYWx0ZWRfXzP0l4syIYQqZ
 D0N3JqTb6D3aNWT88NnVo3F9p9eq7+eIji63soRvbOnZc9cE3j336x/+Spv2xQPx9ASDwHmlsbB
 AfdnLZd4J089AE3DFm/49Xt/Lmzukned9pEiwGvnu28Wli/O7nfHdAj90mt2LYxmnEEa9dKVDOp
 Z9N8TrcDL3VpjuA30P4VD2cOTVFF2YfnSb1Fq+KB+SrSw60V4c1qzwkfKiMoEih7f1komDeoc7f
 hJW6nl2RdVRgObU85AoDUgn7zZyst5eqMbMNKt4B7bMaZd+tKe1BlSqNIVQLnB/7PZ+bAAypSQa
 +YDgXFB7rWST8Qu2BR+wUWcSuBQLBElglWfW46KP4ZTRgtN+OHxhzGEnNm741hiTay0ZnS/pImM
 H4WQZjDn7y4nWJg0oCXvctfn/TXlsQ==
X-Proofpoint-ORIG-GUID: LtrEIABF_xXO7W2tW3YHx2uzht1Hgmda
X-Authority-Analysis: v=2.4 cv=Ev3fbCcA c=1 sm=1 tr=0 ts=690b7f5e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=D_IGQ_qLm8RrHFHUsBgA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050129

From: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>

Add gpu and gmu nodes for sa8775p chipset. Also, add the speedbin
qfprom node and wire it up with GPU node.

Signed-off-by: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 119 +++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 0b154d57ba24e69a9d900f06bbb22baa2781cc3f..883f9e0ab45c98b9e128f3fa141d625431d89831 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -1098,6 +1098,18 @@ ipcc: mailbox@408000 {
 			#mbox-cells = <2>;
 		};
 
+		qfprom: efuse@784000 {
+			compatible = "qcom,sa8775p-qfprom", "qcom,qfprom";
+			reg = <0x0 0x00784000 0x0 0x3000>;
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
@@ -4135,6 +4147,113 @@ tcsr: syscon@1fc0000 {
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
+			nvmem-cells = <&gpu_speed_bin>;
+			nvmem-cell-names = "speed_bin";
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
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
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
+				opp-500000000 {
+					opp-hz = /bits/ 64 <500000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+				};
+			};
+		};
+
 		gpucc: clock-controller@3d90000 {
 			compatible = "qcom,sa8775p-gpucc";
 			reg = <0x0 0x03d90000 0x0 0xa000>;

-- 
2.51.0



Return-Path: <linux-kernel+bounces-889374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5DBC3D6C1
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 21:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E043BCFBD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 20:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87683009F1;
	Thu,  6 Nov 2025 20:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ACQIiwax";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F3DBOjV6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423A32FD689
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 20:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762462261; cv=none; b=idjwoSr1AHy4Ef5vU9lm9UzqDEoHfKDnKhmF0/KSBpc35QhWACEaqtacwSySGY7eFhBVp2YsvAUnjzI9EJ51rPvaAv7cjOesJ4iQw1OkkRHLQqNSb5ZfstE376/YyZhKj6RTeygvffbzqiA7SodoGAcK9jdYeccneJOnvHIctek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762462261; c=relaxed/simple;
	bh=8dI9XOba2jAlCHcw6erGfoomUhKbEisdoyPpP8p3+1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=itJfnc3/scEWEqbQ/mwdx5vb7AeE/123l1llbClaXwz08/kTJoNB9HqSzgH6+GCiqnfqiAA+3nMKoE9t8oWdVw2EqskPC1O5/PYEZtPxs7KCuFHFD1CyU57bfDZ8dTpVD68v9y0fNrE0UbB56NedzkLfF52sg5r/YkdQQEIhd1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ACQIiwax; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F3DBOjV6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6HWLbU567424
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 20:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4alXn5Z9NyPSEeuSzUYUetC2BlPUE3MPJ93LRIGuum0=; b=ACQIiwaxE+4/mWMn
	oh63h64/SFdH2jMTWK9X6RjEblpxpSntEtqf+gwGXZz92zoQ9WWMaY/FehapgWhd
	jPm/xcDZE4pFGy3yjGG/r8udkf1us3nLl+koHsRI07JSiywaAwdiYrPXTY5IhGlc
	HdBIPnNDH7iIHO5p/UKqs0rck7J1piaC/wAVXWguQFY7V19LR33/dmTTg2aHszK2
	iIfmt5y+hzaL00G7FxrVrM5+l8YjridQChQr/ADJoI7hWJC42SeI5pWndWbFEDL6
	ErWy95R960aU2TjMVUX7sV7lFn5uCzyf9l9EyTWGKHRF7VpBVO2zDZf3oB4t+xuu
	tD0nEg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a905qgjqs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 20:50:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-295592eb5dbso740415ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 12:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762462259; x=1763067059; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4alXn5Z9NyPSEeuSzUYUetC2BlPUE3MPJ93LRIGuum0=;
        b=F3DBOjV64Spp/RSqXOvt5qQkrnt9EXuzkaRIJKeeyjqpr2mN7q1IFi05hBjUACxEXt
         EWOrWpjUMT0V3Ru5LA59HX9vmU40PtfKdSLOcjMAh8W1kY9zQrS1mKvR903YvQNWiWZ+
         JuKz9+tKahwbbFb0zU/oh9W2cbHz9Or9jKwtMhOJyYx7mWslv8ETsQOaskE7JTXz35FJ
         tYSxBZYM0Wv81azLeGAoTMuPqzsbXcQKDdCDYQXlbJvVSjpAV0QCYJYQHHk53xTd5nP6
         ZTAzdRofhBUJhMVTOSZNqyTaWt3I2ec7EfmgE6z2KrasaI5Mzxb7XcaLR99UIPKjATHn
         g2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762462259; x=1763067059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4alXn5Z9NyPSEeuSzUYUetC2BlPUE3MPJ93LRIGuum0=;
        b=q990QkbdzTllTfTv8LZDneNdAVUlRqSobYyMZavYl279+GSokoq3ba6HS0zrz5xrcI
         k0c/89LBLLFcGgihsAfmezKNNWNFPXTgpkuCK63q80rf/c6vt4iNFQV3c2C5WnzfJmDM
         QuCysJgjO2MpU0cD8aUas1WPSHZcdxenxDrkg26vvjKoVJgmZQMrGJ3mqaaa0tR0PqKa
         gt7K2pxPEpjNhwwZPuIo5SvCMkss0v09V0GzYZMLaKkV4xMWQTxQW8UJE/zMMk+Cy/em
         n7eUVmk6Iey5Oasoqhx0mVMbqv+rmMQ4O29b04eVmm/v3ywFAc0s42nIb+pmFJj0fbwd
         FzmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsQYko2XG7VSMul20fm+1BzItBSrjm7Q6Kh5x0+yZFzxs+4zbUG97VaLbGsb4b4y6oRbrl3I5UgE5ie1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI2PS2yN7+H+dxm81zPVZ8zLq21xnFdiWYn+PgKqrUcpT2/kNo
	6MDDeswDia9YZZqpWJ6ur9tFk1MqjgYoiONylrWkgNYKECAQLr8jsTYiNqDpc8YlbrrsaxOxX+Q
	8u+YO1YK1zWOsbi4rZy34zSzuSWsZApDXuuRfMuEaUVNAu2fl6iYyglBF5evrsVJyS2Q=
X-Gm-Gg: ASbGncu79HcArjccwA/yTGwVm+TxfC/yFeUqX2GiMgCNI3FWZ7kAEt0aBbzDTp/HAu3
	faFHKtj7CrrrXNtgc0/lfWkzs7xDMVPYWta4Yub7x4JlKzz42DwEpYSs/+Yc/PMLE+zpbBtRkez
	yvOB4uF6ntdM6rt2unZWBl70IfmsAiT+HAad+1sDVysTmyY7E0gTdLBkobBiKn+GFixGImlc89d
	k7Q0s4LQj8CpUAiS+W6Q7PhGcUxWA5jM9j3DO2YNBHXNpCDoZn2GEtkOLotne4St46n8eMtmbs9
	e2WdOCAmyg5vGYOs651QagIX5pElnOJH4hesxBXn3uAVTqYfpcgBqB3r41vpHP/MI+SLkOwKRWs
	HejWCqbnPbjCUSsZQepxqZ08=
X-Received: by 2002:a17:903:1110:b0:269:8d1b:40c3 with SMTP id d9443c01a7336-297c03ab66fmr8998805ad.12.1762462258825;
        Thu, 06 Nov 2025 12:50:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvzjLUzykk5qQIPuXJFJNx8GRGolqHLiDIkvgFyorR08sPq55A5GPVLpAmt2J6lNFfm5dTPg==
X-Received: by 2002:a17:903:1110:b0:269:8d1b:40c3 with SMTP id d9443c01a7336-297c03ab66fmr8998525ad.12.1762462258295;
        Thu, 06 Nov 2025 12:50:58 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651042c24sm37408815ad.50.2025.11.06.12.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 12:50:57 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 07 Nov 2025 02:20:10 +0530
Subject: [PATCH v2 5/6] arm64: dts: qcom: sm6150: Add gpu and rgmu nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-qcs615-spin-2-v2-5-a2d7c4fbf6e6@oss.qualcomm.com>
References: <20251107-qcs615-spin-2-v2-0-a2d7c4fbf6e6@oss.qualcomm.com>
In-Reply-To: <20251107-qcs615-spin-2-v2-0-a2d7c4fbf6e6@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jessica Zhang <jesszhan0024@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Jie Zhang <quic_jiezh@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762462219; l=3661;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=Ct57iacDgaVMt56kXqWeRFWhEb4Wd5ogLzmDMijMvgs=;
 b=e/BqN8mgOUhXSRNrqolpteNBwbBYXhn8yVoEJAQU24ywpExTCCdo4JQAZUDl39nnqVHMjSSmi
 nEk4WIRahHqCtdIsmGZFSZMBLI7z2vBtWPVJCebVLHYsPrMPQg5VWaN
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: 4JheFAOxo4C3xzxjeKCbOqjkBr_YwqxD
X-Proofpoint-GUID: 4JheFAOxo4C3xzxjeKCbOqjkBr_YwqxD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDE2OSBTYWx0ZWRfXzEzSLbgDYobd
 OoXLsYaNEoZYUfzzkEUvMeL6/reysk5bFoEcMqitH+BapGozNraoN0ZUXHdvU3RghjSKVP/Keg2
 Zyzli1lwBCBIAPiW2cHhEtUGC9eNbg5qRik8ZT79Bp4tyqFqwJ6A9G2tjrPWYMqKtr+GjbniJ/J
 Gxdvi9DBV6nQaUfP/vDY5V8/brpwH78YOeH+3Bk72vdeL28d1ap2RaOf/chs3+qfwPPlBAgP91R
 0N648yAD2kipWSieKjMDuNfmGfCm51sqNCg3sNfO4Y9brexBRyUYvHXsJWa5qmD9ARSxH5tHhw0
 SKYrHU9sPCYB63IIduf4mcFHESh3eJbSUfQ5gBPaJ01ABESm5GOA8++nQiSRt2uYMVJ5WoX3/4l
 O7aVgY8hIYVQ8Sg/HJrel9Lxw/0DnA==
X-Authority-Analysis: v=2.4 cv=D6lK6/Rj c=1 sm=1 tr=0 ts=690d0a33 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=WQ4zR0kUUHxS2nCRhxYA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060169

From: Jie Zhang <quic_jiezh@quicinc.com>

Add gpu and rgmu nodes for qcs615 chipset.

Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/talos.dtsi | 113 ++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index efb753ba1747..500587ea9ae4 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -647,6 +647,11 @@ rproc_adsp_mem: rproc-adsp@95900000 {
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
@@ -1826,6 +1831,114 @@ data-pins {
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
+			power-domains = <&gpucc GX_GDSC>;
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
+					<&gpucc GX_GDSC>;
+			power-domain-names = "cx",
+					     "gx";
+
+			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "oob",
+					  "gmu";
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



Return-Path: <linux-kernel+bounces-850309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 423D2BD277E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 393F74F1A57
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5274F2FF654;
	Mon, 13 Oct 2025 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gxnGv5Bo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180DB3002CE
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349880; cv=none; b=p07xY5Yf9xJaI3i62pzpfLTbxjmMqBlAUis6ljZG8Rp/4QiTgh3kptuNjuo/LTYv5Bpz+hRTLsZfRxJLQQkhv4pe8kfyiTik1ZgL4RxA2LfZ9D0kf+jYiTKzDzoc9moYWICuJuWfyGhkmxYzRwK5j3SCfCYVD1bNQXChrhuIEhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349880; c=relaxed/simple;
	bh=X8H9fFaRsPhpz9P3HuFYkIi/c1/WMaKEL12Al2lLqn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dk5UY+K1ib81jHgoTj2qP61hdFb2OUttCJtJ25gj9WYziElECM5NlcRPHRzUk95jrty644bTVzOo8U70U/HVfWwdJQSo0sRx4iHNKAI2sZx+ttZRr+u6LNiZ0BVPpqhcszlScWyTB/hmmfbsDZfkSOCOxaYl3YGLVo/QySECg0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gxnGv5Bo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2nMm5011098
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GXyFql7Vsf8w6NStbJ4fPVmykU+7LPFNxNyrVzYIRqU=; b=gxnGv5BoU4nyZamk
	hHjL3XJxuX6rXEobBVD74aDBixIIX9IEyjiip5Iq5JWx0k/UZake+/BStgExdVNO
	9+ccpt+L8m1V/6doE02aoEjaFhAYn/HMiU8u1+hxdFmVNQcT9RH1ieYWfLPBmVo8
	6YQXi7iSYiQ7WXbbaI/dTLOPqDVw8PzNeqrcEb2VeSUa89q9pNN1y6rkivmoEDls
	uXASL4vMjzkWQ/5Tj5eA3STPhOPrQP6UnANpVcCt2e0YFbmR4AJLLMsO5stFMPAA
	hDUWqqVzbyDq/YaSi5aN2DH50+Ya1mNXDqsCTWyB2fv85w8+wSE6aAv4n+XM0e2l
	gm3Qkg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0bv49v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:04:38 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2ea9366aso6396906b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760349874; x=1760954674;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXyFql7Vsf8w6NStbJ4fPVmykU+7LPFNxNyrVzYIRqU=;
        b=qilyTUB6WjAfu+uLoUhbWQyeMJSUhyFVmwhoi24YrajtcQZaZZIPvnlCUVYLYD/a38
         kJhs6bhOXP79lziDNIJq078e/ZLX/+RaZIq28auQXVSRuaCDftHGcpJl5tIKbe6ti+Ya
         nVlgHfV/7drt4xooCQDmTlAJpMWNw5eqjClJVeWrrcMg4cJpT/dF2gBOEffpdGofHn/X
         XXnI7/z/YtQ/DYZL4UGWGai5fmrcdK7CvORbIC9Hj2WPS1TpSkNFjjytFhpqZBqr8loQ
         W8njyn+aqtFvmFiOgI1JppIUvpzAKYbKXhO/ee6m2s0yy5TZZ19Lk8M48StqhRkUMfFT
         5Alw==
X-Forwarded-Encrypted: i=1; AJvYcCWY1zdcOhodp61xxO2I+1tOLgZCArEGjMl+xOP09BYmzxpofybMGeMbMmIOkLdz/0Ciq1jUejMVnI9MLs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtGgie7xNpcEsKswiFe2m7szqq6r++zmMygKLABNKkbjpnm7xD
	QfnOSvgVXaCIuGSkShDf9Ixd23cTqSGKsJ9fu3Ozxb6o1NbQbXIZb0L5lRzKgisc7d6bw0C6C3p
	MJpwG6OvWp5QiL9Wj3eZEvXlmtAbQYA+qG2VUObPdUoA4j9fOS4vDJSg3lE5PnmVU/uo=
X-Gm-Gg: ASbGncuZ5xCU4jspEvkNAkSJRDMYnz7OoaRKzl1zpiq+/q6JlPW4ess366SLbYKdY19
	+7/g0xbH5jGtaLLfxMcG/pHXgyfXXVwxH926BO/1y63Z4WYwKIJqMQ68W4Wk7MOMahSySlx9RZf
	DQewm1Sg6evseYSc9nbXCEAftUtvujHH6508wtfiODROtB9lCZmWKgLKRuwYjR7y6TbThRHr7bV
	DrWOv/pCJoYFMfX/yN9IX8azvehmqTHWJe+ZL9DytlANMjZYG3Vb0WBNBWrf11Yv+bEvr+3OI7V
	+z1wEgw9Zl7lEz7X6jBCPAf7ZBCm2mqFolSjHE5cLnoujjNxEJbP9u02c2nd0ldWIUw=
X-Received: by 2002:a05:6a00:9a6:b0:777:797b:7318 with SMTP id d2e1a72fcca58-79385709525mr23185189b3a.7.1760349873714;
        Mon, 13 Oct 2025 03:04:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk14qu64ftjSRMW+hpD91y5/GM/5pJJ4AVMwHSK60e/YUg3Ls1E/Mz/JkNwC+/KshyXuyWzg==
X-Received: by 2002:a05:6a00:9a6:b0:777:797b:7318 with SMTP id d2e1a72fcca58-79385709525mr23185146b3a.7.1760349873112;
        Mon, 13 Oct 2025 03:04:33 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d5b8672sm10981657b3a.69.2025.10.13.03.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 03:04:32 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 15:33:17 +0530
Subject: [PATCH v5 13/13] arm64: dts: qcom: Add EL2 overlay for Lemans
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-kvm_rprocv5-v5-13-d609ed766061@oss.qualcomm.com>
References: <20251013-kvm_rprocv5-v5-0-d609ed766061@oss.qualcomm.com>
In-Reply-To: <20251013-kvm_rprocv5-v5-0-d609ed766061@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14-dev-f7c49
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760349819; l=3372;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=X8H9fFaRsPhpz9P3HuFYkIi/c1/WMaKEL12Al2lLqn0=;
 b=gqjKdu3xbu3Gwv9MRIlItaFj4syW7otVyVQw46zSjsI7ZKvZQWxvTq3xDQ+kp7vyMpg35pQ6f
 Pu6W1eaoS4QBjoRd3rQQhGE1nB14ZwmvyVKxhWXN6SRk23d0jsoPv2q
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-GUID: LHOxFAuQebTL_5l2M_VGgmjXywpqq2fS
X-Proofpoint-ORIG-GUID: LHOxFAuQebTL_5l2M_VGgmjXywpqq2fS
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68ecceb6 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=OUqdy03oI2q1KQI58CwA:9
 a=QEXdDO2ut3YA:10 a=eSe6kog-UzkA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfX/5ETABrGJZ2G
 IRyNIrDl2NIgnSoUgRqaGnPEkHBZerBiPA02sWyBUYGfXrTJUcD29wMJDSmjHTSTwK9l+wzvevZ
 W1XT4YCUVfD58TDJbrSYPK9Mnfig2UX94V1egnNWLzD7itV3Ja7C+EGboGuZBCDKIhWKWrE7Jx/
 8spppzqmHQRyLIXXuWoWZM29uqwawLhonzbq23cdPRmAaBu4TfGXIRu824Wsv4SrakMVU8t3hNO
 fpbLGq44Wm4XlAJIp8KjI/TFZLmGLo3FkrBR1YtJyTG9v+1QW0Wvma7UD0uQdCovEHgt2uttEVX
 +RKxyyg4L67+ZSeWdPyxXKJvhTm6g90GVdPN5IffNSUEwWqaCZlcf3ArCinL5QaCPv2FtHlTYqQ
 O824BqqI2W5yk/DBa6px+icDY7WGAg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022

All the Lemans IOT variants boards are using Gunyah hypervisor which
means that, so far, Linux-based OS could only boot in EL1 on those
devices.  However, it is possible for us to boot Linux at EL2 on these
devices [1].

When running under Gunyah, remote processor firmware IOMMU streams is
controlled by the Gunyah however when Linux take ownership of it in EL2,
It need to configure it properly to use remote processor.

Add a EL2-specific DT overlay and apply it to Lemans IOT variant
devices to create -el2.dtb for each of them alongside "normal" dtb.

[1]
https://docs.qualcomm.com/bundle/publicresource/topics/80-70020-4/boot-developer-touchpoints.html#uefi

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/Makefile        |  8 +++++++
 arch/arm64/boot/dts/qcom/lemans-el2.dtso | 41 ++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 296688f7cb26..e0791f987ff9 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -33,8 +33,10 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp454.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk.dtb
 
 lemans-evk-camera-csi1-imx577-dtbs	:= lemans-evk.dtb lemans-evk-camera-csi1-imx577.dtbo
+lemans-evk-el2-dtbs := lemans-evk.dtb lemans-el2.dtbo
 
 dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk-camera-csi1-imx577.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk-el2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= monaco-evk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8216-samsung-fortuna3g.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-acer-a1-724.dtb
@@ -137,6 +139,12 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs8300-ride.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs8550-aim300-aiot.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride-r3.dtb
+
+qcs9100-ride-el2-dtbs := qcs9100-ride.dtb lemans-el2.dtbo
+qcs9100-ride-r3-el2-dtbs := qcs9100-ride-r3.dtb lemans-el2.dtbo
+
+dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride-el2.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride-r3-el2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb2210-rb1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb4210-rb2.dtb
diff --git a/arch/arm64/boot/dts/qcom/lemans-el2.dtso b/arch/arm64/boot/dts/qcom/lemans-el2.dtso
new file mode 100644
index 000000000000..af35039946e3
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/lemans-el2.dtso
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/*
+ * Lemans specific modifications required to boot in EL2.
+ */
+
+/dts-v1/;
+/plugin/;
+
+&iris {
+	/* More driver work is needed */
+	status = "disabled";
+};
+
+/*
+ * When running under Gunyah, remote processor firmware IOMMU streams is
+ * controlled by the Gunyah however when we take ownership of it in EL2,
+ * we need to configure it properly to use remote processor.
+ */
+&remoteproc_adsp {
+	iommus = <&apps_smmu 0x3000 0x0>;
+};
+
+&remoteproc_cdsp0 {
+	iommus = <&apps_smmu 0x21c0 0x0400>;
+};
+
+&remoteproc_cdsp1 {
+	iommus = <&apps_smmu 0x29c0 0x0400>;
+};
+
+&remoteproc_gpdsp0 {
+       iommus = <&apps_smmu 0x38a0 0x0>;
+};
+
+&remoteproc_gpdsp1 {
+       iommus = <&apps_smmu 0x38c0 0x0>;
+};

-- 
2.50.1



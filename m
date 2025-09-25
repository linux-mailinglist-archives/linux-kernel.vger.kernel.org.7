Return-Path: <linux-kernel+bounces-831509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC81B9CDBE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94851894CBF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3A41D63C2;
	Thu, 25 Sep 2025 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WVSj2J6L"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5588B1FBEA2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758759469; cv=none; b=jFpwDeiC3uDsS8Mhsy3vlynRVy1xbCexm8goZNlP2hnSf4ZrHQVGE9S3F0vOYnta8BimI6CuEDtri9Mso4jPHm9K+iYFtTPwAuVgMERypid9sYK8AIxUA7PVleQAmXk54DNZO7prl6fl3vkU8NHb5+thzfOxCNea2wtxmhSKc20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758759469; c=relaxed/simple;
	bh=RD4L+S1NMvsr2LfxdUqTQYG0kxas+l7a1F4onzI6p3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L2dv3Nxx0pBqZ8tDkIGFTajeULoyAtxOfm/3at4AtTa/1WZCls9vx/uLnwHVyquyLNk5PbIIid+9d9OshcUOVvh8pke16/A7Z2+8JMiNsVgzW2Fm0cl4zK0/PZKHPyQPq1kdaYW8b2Z+ZLOp8t9F1wQSndElqu+xFhbzs5Cl45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WVSj2J6L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODBc2k025108
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YJqY/YOSHWryJJD2gbToR7Hr7pe3t+h/VgArJwBLTWc=; b=WVSj2J6Lw/P9DrdD
	gITlxZq59GspSpnDm3DJ6lP0O4rbcrWcr2HqCXgm096+pgON9llB2x7edSXcIfl1
	BM78TRfkELkpm2i9KPM/ni37S5EeforLD+SUlT7JnDZSRrpK2aOky3j/cbjdp3J+
	6gQqo+HzIgcfWd8hRrRhTa/eM2GfWEWPZQp1bIwV3/qw96zZIU/g4LNjpSU3eFX0
	zcB7uNFOY92NysL1kS3vCWB7kKCRMN9PwGbAZUBnjS8/WQck1gUI7GsxxCK2IdSW
	koyHlcIAnwwVUMOLa2VyEOPHp78fnziTYPQoc+s/S62yBu6cv61jtU6FIS1pL3Ed
	Oqmjrg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv165tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:17:46 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77f2d29dc2aso307649b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758759465; x=1759364265;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJqY/YOSHWryJJD2gbToR7Hr7pe3t+h/VgArJwBLTWc=;
        b=JBrMmChIu9AVWhuJi6Et9CC7azCnW3Dt4vQ6lirmByVgN0Z71G4HVuin4nq8j9T/Ie
         d2H6jVPzsJCdyEKEJxUO4ePuAadFfU6aEoIigNmGPX51h7FjOGrqEWSkdrWUF/9QzD+I
         GekHfyT2BdiDR7MiJgiw30KiSn3Vq1mVxgiOOZAIWzmM3XbkpFsKUzsaqwd0dqakw2QS
         3rfltxO4W64eIRUqdW4PA3wZROjfLUA2AGUECYlbsBDHnlHrx0nAVq6Aq6mMzmfjRcgc
         v76vgm6xgHKKA1JXkL1gL+TvO7gkWdckdv0a1fNrbi2J6cCPuN/ahwmuZzQ6qGh6xn8d
         Ifhg==
X-Forwarded-Encrypted: i=1; AJvYcCUNSaBN7LbsyCuvJyJAbPemLq7qJHtNkcdzAjNKeqTcS52iQ2TBa8VG3Ml+vVPWgq3OpvNG+hLYEDeQxo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2VTwl6vvfZV7arxXg2VR1SLJC9EpnLf/tBBi+WpvxGoOG0qVB
	pJN+/mnwiMevIqId7GJE41Hlkwq2RUU0O1TjdfIJhU8dN43Q/l6+kjSIhuAm8ymRrcnCvpFKF7E
	EeZ2Qb7M6Iu8NoBnBSjr543EryJJm5K+X9hxa0X6yBItq6UDYbzJQpJJt64pWRT7N2eY=
X-Gm-Gg: ASbGncsb0Xot5xuWeQa6009KKfBGZuHyOv1/dvDlZ9prIpP4DJlv5AM4QK6BnFgjw63
	K7hMJsifx7u11SLt8A50ZBc25VDULTa2GpwQbFgiaQEvr/gWI7sfAfbIsWjqF/vZOYdKmURjjdL
	gaga6o6H+sLvY+cTwwZCgedjADdVCgQGB/0oWXh1kbl+svOz+IhW8nP4gxzJ2BRDDkDCkFSX+xZ
	L9aGTPsVuwMKOqHdpHjPgm/ZRV7bNvLtjs7Ew0sbP9ABIXLMpJZXE/AxwoRL/BsHv1AHsTu01qc
	D32O07vDDLgn4cyw16QGT7bzYDwDKdL6y1TcVR2JDn9gstpwusPVVLdEYMVjJlbrnQuf5keEHZs
	G7VRl1PiW36Qribc=
X-Received: by 2002:aa7:8894:0:b0:77f:2f8b:7667 with SMTP id d2e1a72fcca58-780fcc89c45mr1802888b3a.0.1758759464900;
        Wed, 24 Sep 2025 17:17:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI3PF6T/qNq84bR1+KT7qTVMeyZ1J2YnrN2+HR/zdjK4JgcTpfa4wdjxgdq+nyFUxBS2phhg==
X-Received: by 2002:aa7:8894:0:b0:77f:2f8b:7667 with SMTP id d2e1a72fcca58-780fcc89c45mr1802860b3a.0.1758759464458;
        Wed, 24 Sep 2025 17:17:44 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238e6fasm262748b3a.1.2025.09.24.17.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 17:17:44 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 17:17:28 -0700
Subject: [PATCH 11/20] arm64: dts: qcom: Add PMH0110 pmic dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-dts-v1-11-3fdbc4b9e1b1@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
In-Reply-To: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758759448; l=3693;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=uGWrfrbW9Ltax/z9kxUgKt2wfGnwFiMi5enZLEbDphg=;
 b=LlDlOyQkaI+mAZoKdtEKS2e2+qylqopKLfM0yo/+QffhD0gRYwRLlr7elLktQfBWH4rMix+a7
 ABr66Rr6vaoBh2SB45rirHoJEexmFAZJUpOpmO5ds/ro7PkAKGmpBhc
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: FAr8m4EyzPF6vBpGlJXnJSLR8KMFcK-Q
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d48a2a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=4ECTE-F74UkuUx1KzIYA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX20bdQlDadEsP
 OAOR4/gBSctN+GQZeabz9nh/RS54zx/9aDRPUuTYBL8LiBluDCKJSvkyRoj+7E+VH3aj0i7LyQE
 Fjm58lpemlp0wHQVT/NU6xrCPmi65vTyBQNvRY9ErNlWhspIg6VHYJqwnBeQmiQeJS1UdIhVaFa
 ZT0HXt/v6kjMwyM/KFCLOJTgH6EFWPeiIV1o2haWzUsOG/ps3hqd99035T49liXNP3mm3633LYR
 yNyO+tqNdvRDqfjt0xymdcxfVeN71cp4S7/SKV0u4nFEzaXHAFVcTPFI82AB4KrGBk+83t/3cFs
 FvZAc6DlOC3qXBGNT68nBPvdybUzYP/lwtHBRML2qfYyZ1c6PT/Y3V0H+l0cidctCZbVqDOGNk0
 hkDehE9y
X-Proofpoint-ORIG-GUID: FAr8m4EyzPF6vBpGlJXnJSLR8KMFcK-Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>

Add base DTS file for PMH0110 including temp-alarm and GPIO nodes.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/pmh0110.dtsi | 109 ++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmh0110.dtsi b/arch/arm64/boot/dts/qcom/pmh0110.dtsi
new file mode 100644
index 000000000000..b99c33cba886
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pmh0110.dtsi
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus0 {
+	pmh0110_d_e0: pmic@PMH0110_D_E0_SID {
+		compatible = "qcom,pmh0110", "qcom,spmi-pmic";
+		reg = <PMH0110_D_E0_SID SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		pmh0110_d_e0_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <PMH0110_D_E0_SID 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmh0110_d_e0_gpios: gpio@8800 {
+			compatible = "qcom,pmh0110-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pmh0110_d_e0_gpios 0 0 14>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pmh0110_f_e0: pmic@PMH0110_F_E0_SID {
+		compatible = "qcom,pmh0110", "qcom,spmi-pmic";
+		reg = <PMH0110_F_E0_SID SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		pmh0110_f_e0_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <PMH0110_F_E0_SID 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmh0110_f_e0_gpios: gpio@8800 {
+			compatible = "qcom,pmh0110-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pmh0110_f_e0_gpios 0 0 14>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pmh0110_g_e0: pmic@PMH0110_G_E0_SID {
+		compatible = "qcom,pmh0110", "qcom,spmi-pmic";
+		reg = <PMH0110_G_E0_SID SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		pmh0110_g_e0_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <PMH0110_G_E0_SID 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmh0110_g_e0_gpios: gpio@8800 {
+			compatible = "qcom,pmh0110-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pmh0110_g_e0_gpios 0 0 14>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pmh0110_i_e0: pmic@PMH0110_I_E0_SID {
+		compatible = "qcom,pmh0110", "qcom,spmi-pmic";
+		reg = <PMH0110_I_E0_SID SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+
+		pmh0110_i_e0_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <PMH0110_I_E0_SID 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pmh0110_i_e0_gpios: gpio@8800 {
+			compatible = "qcom,pmh0110-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pmh0110_i_e0_gpios 0 0 14>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+};

-- 
2.25.1



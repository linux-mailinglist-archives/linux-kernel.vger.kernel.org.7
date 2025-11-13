Return-Path: <linux-kernel+bounces-899377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFFFC57B33
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411E5423C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BB0353888;
	Thu, 13 Nov 2025 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iit7z+pD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hMHSmJsm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE30C353885
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039130; cv=none; b=axQVKzmIf2eTgdo80p6XknDJ+I0Zke/5m34MuBPfIfe0WquGM+w/rBL2iC9zGCDDjxnt7xPNs9DHqbonCfuyP+EXpJ1w6saS0W9wFWKBfyZcVReGDn2t3Vt8l5xLO6OQaHl2nQobId2Srdu5CgMftpgnFo7OdS9A3LaWDTxsRJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039130; c=relaxed/simple;
	bh=/pmTjiQIV7lNkIY5RLjdvFSxXZR+OHwMnF2CG0g2LS4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EuSqnl0N9TC1zicrXxVz7df0HP8n6synicuCDkiHBdVP7bNbrO3YoFm9/enXeoBCY7OhiC7FPf+uJxkHpHN6jWBvfsdy8Wnl4bDya3B/P3GBIisol8yNe3ykzt+VBfxy+Tj59EOUHUZ+DzEF6vCZeFGxEBIn9kmI6V0XqJMAzUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iit7z+pD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hMHSmJsm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD9VxRp3120579
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:05:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Ami9/GRxxdVsR0BkYUb2Vn
	6mb39Uxml9YmPVyIIGtZo=; b=iit7z+pDgnjPt/631+fG4dc04U04y9RJRkFDM0
	9BCTy7sdkgFUoNHHTspwWseaxbwbvd2gaUMXJSzDc+uxDtMAQsTEXWTy1rZjEvZU
	IeycYngKJY3Ct2NgFZiLoFyA80tlZg2Eglpbku4Y4ywTuxrXzSrY8Vo9A+7d9itm
	PAwKY4IFK4Ima/xg5rAkbuhZY2QJ+80QosCG3LK0yXSvXCa4c9eKm42sLjjjeYuw
	unavYIGVHIgUnIvSBUWg/CCozzujnB4c73SBuM0+TaVZ0K//MntzwOpuzfI6W4qh
	Few+ZBg6m+mmM1J5uJS+WQRyKIlOQV2aYS773rZtSsyBM6/A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ad5pusws1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:05:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3435dd4103aso273579a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 05:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763039127; x=1763643927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ami9/GRxxdVsR0BkYUb2Vn6mb39Uxml9YmPVyIIGtZo=;
        b=hMHSmJsmNm4LpveMixVg/T55C0MnDk+xw5FEGJMHRf43NNzhLOd8D1q67JEv7jNYgb
         FIp9LOdSe5/iF/vAG0WgsX49tRg4SSrDnIX3MFOsNuxX1P+ACadOlmFlFTvo1NzkZbnC
         TjkJkYdND+ds1M5/I+gh+jhb+zKLN6oVs0DN9PVEkQSA2koz13k2VkCTyRkMof/mmm/l
         GXmncoQXsYGf7SZ4v2GxLOHw6gGaPW/ajEej3Vg9/6E1Utj7o09I2hgxaVSUgFUuC16J
         3jtxeAMhIxaKehudOqfExlgW0hw8K89zNAl8lQiWBPnt3hkYX06TRY9B3iAaeCZT8aKP
         MXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763039127; x=1763643927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ami9/GRxxdVsR0BkYUb2Vn6mb39Uxml9YmPVyIIGtZo=;
        b=nSw3wNWgtpSs35AvXRudjgn1K1kTCoz0WwHMpPRUw2Gqo0+xmtq7Rha4hte+1LtFzh
         8fU5iwhAlcxAPaDAGqAAbn7JecHsC2d1K046U8R8oGowFCHO6B2SkV46NGNeHNmGJLaB
         DiH8SW8sj53ba9W6E/l5vzeP9b/h6zca87yxXKgf96q+GfFjDL/rlJEhJExE/XG9TSeh
         pMA8TgbZneEKl/6HY34YBUOyZAQ8YVG8tG5CXtOuec5LVPKlD2I9gxkPZ1yuXA8WthyB
         1Xltrv3JOoNOs2AgEV241YqJUmcG6hCBWqsEcxYST7HYQDq14TckaUq07jSx6DQgLrB2
         5oQw==
X-Forwarded-Encrypted: i=1; AJvYcCVsErO5yQkpzi9EidcUBNYGNt8fkyft5bThmsyJfsMYqS+GiRNOaUvuVJLFCxVixVhmgQNtVj565Ld6+6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNEFZ+c8KzWSu7hkhBiThrJ5YaiQ8gvMRQV0Qw2tqw56Sb0y5+
	b03/U/Z14X6H4zbXJYIH6MJAvaFpAK5rpchWy8e5V0IZ/gGp3hZQ1RvrNudpvJnVROlWkZ1XVAF
	G69iUZLEu7orPqtWmWkqXfhGrABOIKrkLPgfCiulPY0tVCEfrW5k7WY45K03tBFxK3/o=
X-Gm-Gg: ASbGncumOLSh3h6B4Qb0mYwi2iuuuKeCwgd3bNSEpE0T9WZJVbCrdmPF5yfsMK9e4lb
	HqYLXWRt2Wzw2LjIQ9j7j7Q6jGqO4bDTGK5FEEwEqRGpKAFnlXMBWUezXfuxceC5eDx9SRP4Go4
	NxBm2LBEK0zbZqg9v3/wlgicOkn/HYFwHpfYbJxvcZhjDo3wADON+hUzI2hWoDrEXlmg20pgT6p
	Ppa8R3+jU62UhW3u5TojgRKzT0vfAo5ZSOPOMcyyhwotSdZ8J26h/JQgNKQvH/OnXzeXrpNdBCu
	1xuZyDSM0V/JosRFZG1qn9HB8HWJq+rRBYWY4oob20kkHSP05UdES1vnAR5ph/o3Sc3ddVhTgLX
	dg+97gbOZu9GYVJiL6z5vzw==
X-Received: by 2002:a17:90b:384c:b0:340:e8e4:1166 with SMTP id 98e67ed59e1d1-343ddef4dd8mr4473960a91.5.1763039127178;
        Thu, 13 Nov 2025 05:05:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENEs8usVLQVclfCfoQ11ktHzHwnn3YtQfKRKLH1gqmzn5G8Re1Uz7UaIJvtTSzWnAEDf7Ulw==
X-Received: by 2002:a17:90b:384c:b0:340:e8e4:1166 with SMTP id 98e67ed59e1d1-343ddef4dd8mr4473871a91.5.1763039125335;
        Thu, 13 Nov 2025 05:05:25 -0800 (PST)
Received: from hu-weiden-sha.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343ed4adf45sm2564093a91.4.2025.11.13.05.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 05:05:24 -0800 (PST)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_jiaymao@quicinc.com,
        quic_chezhou@quicinc.com, quic_shuaz@quicinc.com
Subject: [PATCH] arm64: dts: qcom: monaco-evk: Enable Bluetooth support
Date: Thu, 13 Nov 2025 18:35:19 +0530
Message-Id: <20251113130519.2647081-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=6915d797 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=jAN5yIkcfwfeL4kR2mIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA5OSBTYWx0ZWRfX4J6gaAAQk+xp
 2QX3xyUGAn6G50O4ny961+q8B7RPh1yGUV8+X4am8b9LUPny6TgdDidAn6tuhmzVP9zPIBvQWHE
 CPYzzKLIXB0N0knZonbIBmqBJyfIoXslxaijwmVYeWEVnxP1bAw4tI5jmvhXG6Up59pkf9nLk9B
 ka11YpLISoCXLybAPl7mEpJ3n61MdCwMhTWpCbJS4kw9sjCwnj6bTVCKd7VdDMQ0dJmhpGC2aqN
 Ht4fXEgLO3/JxjV7D4AB6U57fEWZQuiKOMO/1tlNrPCPnFj9m3I7UQswfL76BNbrstpBi52jT5b
 4mzufhFsA10/KQuWTy1pWUI+j14YVO1poj0ob6ficOj69RgX07p8o1rYP++CDVn3cs7v80s2NWW
 uCsHO80DQxAOGuzfd3fTPOKluPe86g==
X-Proofpoint-GUID: 3BIC_lmqSyomDwbcn6eUKNaPI4E5QDvH
X-Proofpoint-ORIG-GUID: 3BIC_lmqSyomDwbcn6eUKNaPI4E5QDvH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130099

There's a WCN6855 WiFi/Bluetooth module on an M.2 card. To make
Bluetooth work, we need to define the necessary device tree nodes,
including UART configuration and power supplies.

Since there is no standard M.2 binding in the device tree at present,
the PMU is described using dedicated PMU nodes to represent the
internal regulators required by the module.

The module provides a 3.3V supply, which originates from the
main board’s 12V rail. To represent this power hierarchy in the device
tree, add a fixed 12V regulator node as the DC-IN source and link it
to the 3.3V regulator node.

Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco-evk.dts | 99 +++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco-evk.dts b/arch/arm64/boot/dts/qcom/monaco-evk.dts
index bb35893da73d..a8d1dd04fcd3 100644
--- a/arch/arm64/boot/dts/qcom/monaco-evk.dts
+++ b/arch/arm64/boot/dts/qcom/monaco-evk.dts
@@ -20,6 +20,7 @@ aliases {
 		ethernet0 = &ethernet0;
 		i2c1 = &i2c1;
 		serial0 = &uart7;
+		serial1 = &uart2;
 	};
 
 	chosen {
@@ -76,6 +77,86 @@ platform {
 			};
 		};
 	};
+
+	vreg_dcin_12v: regulator-dcin-12v {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_DCIN_12V";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vreg_wcn_3p3: regulator-wcn-3p3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_WCN_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		vin-supply = <&vreg_dcin_12v>;
+
+		regulator-boot-on;
+	};
+
+	wcn6855-pmu {
+		compatible = "qcom,wcn6855-pmu";
+
+		vddio-supply = <&vreg_wcn_3p3>;
+		vddaon-supply = <&vreg_wcn_3p3>;
+		vddpmu-supply = <&vreg_wcn_3p3>;
+		vddpmumx-supply = <&vreg_wcn_3p3>;
+		vddpmucx-supply = <&vreg_wcn_3p3>;
+		vddrfa0p95-supply = <&vreg_wcn_3p3>;
+		vddrfa1p3-supply = <&vreg_wcn_3p3>;
+		vddrfa1p9-supply = <&vreg_wcn_3p3>;
+		vddpcielp3-supply = <&vreg_wcn_3p3>;
+		vddpcielp9-supply = <&vreg_wcn_3p3>;
+
+		regulators {
+			vreg_pmu_rfa_cmn: ldo0 {
+				regulator-name = "vreg_pmu_rfa_cmn";
+			};
+
+			vreg_pmu_aon_0p59: ldo1 {
+				regulator-name = "vreg_pmu_aon_0p59";
+			};
+
+			vreg_pmu_wlcx_0p8: ldo2 {
+				regulator-name = "vreg_pmu_wlcx_0p8";
+			};
+
+			vreg_pmu_wlmx_0p85: ldo3 {
+				regulator-name = "vreg_pmu_wlmx_0p85";
+			};
+
+			vreg_pmu_btcmx_0p85: ldo4 {
+				regulator-name = "vreg_pmu_btcmx_0p85";
+			};
+
+			vreg_pmu_rfa_0p8: ldo5 {
+				regulator-name = "vreg_pmu_rfa_0p8";
+			};
+
+			vreg_pmu_rfa_1p2: ldo6 {
+				regulator-name = "vreg_pmu_rfa_1p2";
+			};
+
+			vreg_pmu_rfa_1p8: ldo7 {
+				regulator-name = "vreg_pmu_rfa_1p8";
+			};
+
+			vreg_pmu_pcie_0p9: ldo8 {
+				regulator-name = "vreg_pmu_pcie_0p9";
+			};
+
+			vreg_pmu_pcie_1p8: ldo9 {
+				regulator-name = "vreg_pmu_pcie_1p8";
+			};
+		};
+	};
 };
 
 &apps_rsc {
@@ -466,6 +547,24 @@ qup_i2c15_default: qup-i2c15-state {
 	};
 };
 
+&uart2 {
+	status = "okay";
+
+	bluetooth: bluetooth {
+		compatible = "qcom,wcn6855-bt";
+		max-speed = <3200000>;
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
+		vddbtcmx-supply = <&vreg_pmu_btcmx_0p85>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p8>;
+	};
+};
+
 &uart7 {
 	status = "okay";
 };
-- 
2.25.1



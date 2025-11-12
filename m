Return-Path: <linux-kernel+bounces-896649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303E4C50E3F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C73A3A83C4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848AF29B793;
	Wed, 12 Nov 2025 07:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eH5LvamG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ejRvq+r+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF3D26AC3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762931524; cv=none; b=BljzCFFfVyb+nptYei5GE1EZilzcJnPWx0kOaC8TpCinNIeK19KjVub0Gm6Ks3iRivZ8AgH3xmlp0FwZoh8PwVOhhS0i3J8fR7SGxYR7BYTNWgRpmVJWPkRN/+g8FncHyvSMEqfm48WhxP1nsQghGf78vTkv+NoQFsBv8RScD1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762931524; c=relaxed/simple;
	bh=t6/dnpKeijBWspn2y7sLCQ1hIJte3iDvGgv7cHKKY14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+4Zf4YlY0eIEU/8LLPJGxy3pw6X2AajtlkRojNxrIbQMfPAN4pnkcaFp/vGpwiaJpwOSWrnGfn5AV6Twe9TrjZNOpWusedGv2+TC/wAdq70Mu+4W9TWtKKaOhihn000ENl2wikUhlBBHMQPP6OtAvyyO/K8G3MWxArLJCXBZBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eH5LvamG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ejRvq+r+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC1HZJF3683715
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9fxPxZxcQt6S8UXjieAvc43H1MpqDUf2xI5qng2G0vQ=; b=eH5LvamG8iATuNvP
	UmwPQL7u3r8sg3PdA+oZjS2ZLtLsqavOzSjF4phxI6hT2up+ydX+GUzWT8ienj0Y
	siQ2CCkPNEub0PqONjoEkQxrgKsCZrRdZYdISlmauDx4e39fZuF/CbgZF55JD/sF
	W2HJrXdZF+Kvj8oD3wvOjeQViKYVBIBWvpHRX9wo9fezbE/uNwksNz2zGREO4jdX
	anQNMaUlWpj+zk21K+iumnp1S2c29lyMa154XRHx77IcC7/bYLf1Mmu3aSDKV+ek
	6+howMQh4TXY06gn/sNQ0uyr0SJVCaxOxCjltGPWhZfDKl1HGVuFe2pM/ekrwrvN
	TdiwPw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acgeu0w4p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:12:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3435dd4103aso163863a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762931522; x=1763536322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fxPxZxcQt6S8UXjieAvc43H1MpqDUf2xI5qng2G0vQ=;
        b=ejRvq+r+1q4/CrQANP7X3CwYlvEnOIykGI3YuaZiHTUwQJY3HojqSx5DV8vbX2vAER
         n4ZWxp7+8FU0qDcO3xPf1m0Nj/43ONZbFQsA1KbXY4neUz1pycZmkwUM7YbXqh7TOS/X
         FR0qzoOjLogY3cWtUTjX2LT9yPzTh/UneSN+qUkJPLjzDZEN95TXYsehEL+laMSXOBCZ
         y9h1RWPPniFDIfDtLBU57mcphPBr8lM1DcUVJTirOKkUDY8Yw9uIOS5aIEhZXMqb76ti
         SMRPf6WBcWIqAoj6mTX7st0YZua5uM4OM1be6mtizmBEoFIdDM3pBpS5BEfnZtJZIHQu
         lgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762931522; x=1763536322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9fxPxZxcQt6S8UXjieAvc43H1MpqDUf2xI5qng2G0vQ=;
        b=u9e2mnnq7NCILzvLWM7f4jLVj+h/hAH6VFLM2/rzkXvWjMVJ/JxdpGvlEU4KsOoKaT
         ml7dg1borlje9ez3YiYP74GiAWroiy1y7MK/QQs2MEoCX2I9hpMI/fKlL6w6v+ErPnY3
         K712iq5FDQakVPRhlBmqVvGTaWdvkc3JBbfCCOMYx/JM6YTL5aNbLiau/GZrppS/QoL1
         KclBDK86UM2azjnAAVwVvSprbrm89NlDElJMS5WIFKul36cHK7M+fMe2vR+MLoKkvh+4
         ZigBJw0wCZisIqyThYb0St/xSY6eGPJQzld4IEemLdILGtRKfI5+q/p5y/RVvwo2Cx3G
         NyPw==
X-Forwarded-Encrypted: i=1; AJvYcCX/B1/q6ABaREUrc2GLuf8Bb431UDqGlI0ikYE42HL/8oGIXXRyFj8KXh7Ot/iBEMlvW44cDI3srrnMoZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZQ8PCFW1PAcj4gpeXlKnBJC0uS23lNTH8kFXKoggZXnMskzo1
	zs64YQWlHg88DzgHDrMlglu3eKGgffuNTpr5p4Ba4TCaMjuc+MsbcPv9tD8brT64eTA22JYiTP6
	fbYiEVqaN9N0JX6Z7zC/JRKA+ZUMe6c0skbmVsSR/2IAQWmPpOXzoqTrJ/riAs5l4AQI=
X-Gm-Gg: ASbGnctZVkwljsY9+LR5pU9eebwvT6IIQLWsaoGLKUZET79yw8qhnUhRLqfUo5XKmEt
	Lrk2JSHvvuIdf7mhBpljYHapxUSkgjxlXG8m1QUJRqKYAfI5kTBV2NUAZb4YeTGDw6xCWJF24Ll
	qnUKpw977VS19KCsC6vagaXWWIyyNpKAsIP++QG0ufNWw2G4vYHrzXVJvs/8A3QOksLbyHiVqoE
	V29SkIoY3+zTSQW0DA5QUOMNy3VZvUCjim3YVUj3wKPecqF+q06xUr2WJ7BkwHKU32UAgAYnNVY
	UNfP1hRQdC+2pjiU6UcVnV8qK9KTA4Xap4YsAJ2OkkTfGgguev/Eo2KFrNmTXzu8xGO6Xr2o9H9
	3kvltMFFnTuBbTQTWiYBDzg==
X-Received: by 2002:a17:90b:3ec8:b0:343:6a63:85d1 with SMTP id 98e67ed59e1d1-343ddef65a5mr1336600a91.6.1762931521733;
        Tue, 11 Nov 2025 23:12:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjYDY1JLEsZVVzJaPhfcfNidP7Rb9JXHS6DfFNv0Q2YteiyP7RZu1nSeRRUCw8ztCuRHYQjg==
X-Received: by 2002:a17:90b:3ec8:b0:343:6a63:85d1 with SMTP id 98e67ed59e1d1-343ddef65a5mr1336582a91.6.1762931521246;
        Tue, 11 Nov 2025 23:12:01 -0800 (PST)
Received: from hu-weiden-sha.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf18968e1dsm1748045a12.33.2025.11.11.23.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 23:12:00 -0800 (PST)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_jiaymao@quicinc.com,
        quic_chezhou@quicinc.com, quic_shuaz@quicinc.com
Subject: [PATCH v2 1/1] arm64: dts: qcom: lemans-evk: Enable Bluetooth support
Date: Wed, 12 Nov 2025 12:41:47 +0530
Message-Id: <20251112071147.1450258-2-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251112071147.1450258-1-wei.deng@oss.qualcomm.com>
References: <20251112071147.1450258-1-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA1NiBTYWx0ZWRfX5E12dXT3aUHm
 D1t+Sj3Z0NDbP0oTpsd4ZEZv9H/Fq3A3VQntsZu2AouvBR1HyDfE8CX19vcl6+VAUBgkNbK3w5Q
 G4jgRAnoHb7UmCt2DqvIvk1AH3Fvu7OdbBvooNE2nYFTFVejoFOppcc8oaDo7JbyEUsIucstA5j
 9e7AePxtM5cjo7niwKysF/FVB/3g0aZVh6UtV2JnTfNL26/M9ti3GA0WfMo510kBKrjWytUi5lK
 2PewbWm1ZuU4l3Rrsp3/vp4RSUKZEv8EZk9sfkpVbcC61eaTK+dFrryWPJhjXu6buR4qAkGVac5
 DF6KrPDEVyr+2qm+8e7hCug2/6KsuLCNh6T3Ei7yxPdtqeac3Os9RPOf9eooPSxhZ3NQD9vkuvk
 KjwDvA/ZyoLkzWYSmcBWmO8K3hkGFA==
X-Proofpoint-ORIG-GUID: I_2VeBGw-PHxIbH2bHZMIvAGu_EpJIuM
X-Proofpoint-GUID: I_2VeBGw-PHxIbH2bHZMIvAGu_EpJIuM
X-Authority-Analysis: v=2.4 cv=SvudKfO0 c=1 sm=1 tr=0 ts=69143342 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=jAN5yIkcfwfeL4kR2mIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_02,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120056

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
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 99 +++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index b40fa203e4a2..89f3f001fdcf 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -21,6 +21,7 @@ aliases {
 		ethernet0 = &ethernet0;
 		mmc1 = &sdhc;
 		serial0 = &uart10;
+		serial1 = &uart17;
 	};
 
 	dmic: audio-codec-0 {
@@ -110,6 +111,17 @@ vmmc_sdc: regulator-vmmc-sdc {
 		regulator-max-microvolt = <2950000>;
 	};
 
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
 	vreg_sdc: regulator-vreg-sdc {
 		compatible = "regulator-gpio";
 
@@ -123,6 +135,75 @@ vreg_sdc: regulator-vreg-sdc {
 
 		startup-delay-us = <100>;
 	};
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
@@ -761,6 +842,24 @@ &uart10 {
 	status = "okay";
 };
 
+&uart17 {
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
 &ufs_mem_hc {
 	reset-gpios = <&tlmm 149 GPIO_ACTIVE_LOW>;
 	vcc-supply = <&vreg_l8a>;
-- 
2.25.1



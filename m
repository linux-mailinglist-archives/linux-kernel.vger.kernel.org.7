Return-Path: <linux-kernel+bounces-788372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25424B38379
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115EB4635E0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148F43568EC;
	Wed, 27 Aug 2025 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JhY4Qw17"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F960352FF5
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756300366; cv=none; b=o6QHTExw/cc3qclyd4p9o/PzmS1WM0zr4U+E5nK+ILnsNQOHY56oX7bHALT44RuyQOV6fsEcfkzJpjWL5l5tvuVahx+ASknrvAg6tDlYpfll7UJbiIFpqPPKK9y2mCi+paZ6SdJDXrioFdv8qJ33XbTWBtcKwVTKKz7v39YO12s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756300366; c=relaxed/simple;
	bh=lkEkNI6U5UMNHhspuDTyPj/+zirteVHnTk56Di9FfME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jhpe24fSV8p8r8OLDz1/laA711yc6dfecNg3rxGqyGG5nwtTWiCsHiRoAONK/PiDUGWoJE5TRb8m3qlmia9XnDsgozyt0kjc3HAIAFZZaT92C+Pi6xu3DFZJ4ETnsTUOd0sBEjVGO4h2Hqzy3/efcHj1vWpltwTu72ElvQz3GTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JhY4Qw17; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R6kgxj031439
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bl2TJs4T4ux1GQlk8A5Nbj4tfsZuZ244zRVaui58pQM=; b=JhY4Qw17s+bMt+L7
	sZhWvqrCeNWST8IP2HDJa9j9I70zvQC4aQxCYgmFv5pNw4AHTKON/mBR1m8QVHUc
	YhjVVvnfsk1LtKyuvIKHep/wbk/DJxOqRaFk8kElGIPbZN3ZBb4n67IIV7CYokDt
	//i0k2Jq+IE5XFXRkRcl+sTvVqA6+abEqpm/1vtrF6yLXsIj61rp6n5M2T+Dforh
	gMAj2PHf28NZsWwI1zQ+atxUmoBJNr2tyObsdIFnScmLzkwiYD0S/lLYWem6hdtA
	LzTCPLXxx99Q0xqCYqj2oivLTkErj9JUAf715yfdE3WkSZqlgYTHOE+TMqenzsNk
	5kjFew==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615mmc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:12:43 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7704769dbb0so4053825b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756300362; x=1756905162;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bl2TJs4T4ux1GQlk8A5Nbj4tfsZuZ244zRVaui58pQM=;
        b=CtNLJj3rXXYPZbpcP3l2bCXJ2PTB3CsN6OZTPIOmWsT3Om/dkuHhq2FlF54hcFLVo8
         2l34neUXmL0gZmRydi/OVMjoMdajTyYvq9k/D1TEvnIG3ZGvKwkm2t7UYozD+eZw3ZB8
         HeQczw0JBqUUtR7cfPU86Gc1y1U57RdUapbp23KjY9v6NlfvVgBUpVfFd8uHZL5Gfjwx
         W7p4pbB2L62mDgtPPgvy4Ob0pUVMoTO1C5i0jGAfo5u/iCBOHonAmMFTMZw7kaNrrtVj
         MyeNWyugLXXFAjvJvg9w8pz1zfHoHsMHnjejTGbHi9AcpQqHmlOovkqEOs3z8fsTrDBf
         Xq3w==
X-Forwarded-Encrypted: i=1; AJvYcCVHikJue1qsgcMxUoaQi6AErrpTSCI+u1D/OJ2UJDcBCHLa13WM/PN+7ICLe86EMooRrF2XleL4P7vAzJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi1G8O8x0eVRFo0NxEWfGyvJnDF1NDygrcMR8Sj2afdANuewkl
	7fd0UL7RciKNNryTgRSj06BJFi8+dnfaFNmJX2BolitCwXoC1Vtba8aGLsEmYW6iBPaI030EDz2
	hk6+FiVofNk8U9aKy5sB6yZO+iWMawN84aso/xGi7DaxaZ5o15gdmnjZcVREKeTXzVTY=
X-Gm-Gg: ASbGncueuFI8TFGVmH17vnt4ww0RIC+5yykr3lHfwQFLe4KNwbrVULkLftvF8UJlkIu
	xdL7EiZRFfgvRZow2zQUXazDyIGOtq3z+zWb55n0eCoHALnkZ06P95al7Mq5SisU+C5NLuZuBMf
	lsRp2WOTXeGOdK2UHTwnsAFCj+fHvy3j/9zhuioTGaak/yUy4o+oJd0Jb0xLV8i0OjtnpUGSBiI
	NkXNDwY62J/LqciJuz2MSKwbB9qzcJ6gT4O0Ci4lSXbly1I1dOkW9RHMUMdlfz+HVeeShYI3T/G
	URN6InbYyr85uSTG6EjPdYdFkhxyppryAoCsd6WS2wn+CzI7FTVSlaICemzt/imQ/d/V0fNkHQY
	sa0hnq97UXUVbRBJ3k81Nr8mRz6Q+jE/HABiJP/fioucQ0Uj4VStuh1S6
X-Received: by 2002:a05:6a20:939e:b0:21a:e751:e048 with SMTP id adf61e73a8af0-24340d7bb9emr27246344637.35.1756300361753;
        Wed, 27 Aug 2025 06:12:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKv0SxiOk8HOhjqipABcYHZo/NM6n3Rzp99dkCa0YkacESHFFYUFbAP41DOIrGC4Tn3dm1tw==
X-Received: by 2002:a05:6a20:939e:b0:21a:e751:e048 with SMTP id adf61e73a8af0-24340d7bb9emr27246287637.35.1756300361246;
        Wed, 27 Aug 2025 06:12:41 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbba615csm11432972a12.44.2025.08.27.06.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 06:12:40 -0700 (PDT)
From: Fange Zhang <fange.zhang@oss.qualcomm.com>
Date: Wed, 27 Aug 2025 21:08:39 +0800
Subject: [PATCH v7 2/2] arm64: dts: qcom: Add display support for QCS615
 RIDE board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-add-display-support-for-qcs615-platform-v7-2-917c3de8f9ca@oss.qualcomm.com>
References: <20250827-add-display-support-for-qcs615-platform-v7-0-917c3de8f9ca@oss.qualcomm.com>
In-Reply-To: <20250827-add-display-support-for-qcs615-platform-v7-0-917c3de8f9ca@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiangxu.yin@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, Li Liu <li.liu@oss.qualcomm.com>,
        Fange Zhang <fange.zhang@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756300349; l=4229;
 i=fange.zhang@oss.qualcomm.com; s=20250714; h=from:subject:message-id;
 bh=0A09/X7LZ/FPKuEalGbQvn6eLOGaYhze9r/cZSPB9CE=;
 b=UjWhjMIjhsB4/ZoMtsO6oPaI14B3iw7RmRmQ1GfzI23d4kAQbu3yu9diD0pxQZGJmrtjf7ZhJ
 JL25beEd5OZB3p6trsGHDfi+YU1F5j0tIppIwymtjWfA3Zh3bPYEywP
X-Developer-Key: i=fange.zhang@oss.qualcomm.com; a=ed25519;
 pk=tn190A7bjF3/EyH7AYy/eNzPoS9lwXGznYamlMv6TE0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfXzjXy8iaOm6CO
 zbCnfZ3NQf+tHNpfxJRIwTaKIoGyVqi82TDEyOmXsiqWvWXjnGm0gKDM1PKMVKHaJr4jwE4RdET
 RuCV7up4TfsQbYlGO9aqxOT/s+t+p9oQi6RJTwJfw0Prwj/Gi2ShBJADSIeb4QRK027BDQLu31W
 zLaz+L9RLuUAQJdAXPZdpsmaZsU7FARVkeOOj+Yv/lZ+Z+AC43NwjS/qifwshtFUEQfG7Jevu7c
 3f9dWzVUnl/TCX6Ng6SND/hP4jThanMfVclLSD50KHMk7jZfj8t82tl8dsJX1Z4rbkN+3D7tenm
 DZhRfGiKvXa4EJSeFQ7XnHixoQIyf9iS2KNr8E17QpI/LQAfi3LJhgiXflSrry+82Y9bmjDubS/
 b0gEHTso
X-Proofpoint-GUID: qMzPv91J-l_bjKgyw4V1upINsk3870Br
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68af044b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=M5YQ4GC9HTMohWAA_GoA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: qMzPv91J-l_bjKgyw4V1upINsk3870Br
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_03,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

From: Li Liu <li.liu@oss.qualcomm.com>

Add display MDSS and DSI configuration for QCS615 RIDE board.
QCS615 has a DP port, and DP support will be added in a later patch.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Li Liu <li.liu@oss.qualcomm.com>
Signed-off-by: Fange Zhang <fange.zhang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs615-ride.dts | 150 +++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
index e663343df75d59481786192cde647017a83c4191..f6e0c82cf85459d8989332497ded8b6ea3670c76 100644
--- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
@@ -39,6 +39,76 @@ xo_board_clk: xo-board-clk {
 		};
 	};
 
+	dp-dsi0-connector {
+		compatible = "dp-connector";
+		label = "DSI0";
+		type = "mini";
+
+		port {
+			dp_dsi0_connector_in: endpoint {
+				remote-endpoint = <&dsi2dp_bridge_out>;
+			};
+		};
+	};
+
+	vreg_12p0: vreg-12p0-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VREG_12P0";
+
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	vreg_5p0: vreg-5p0-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VREG_5P0";
+
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+
+		vin-supply = <&vreg_12p0>;
+	};
+
+	vreg_1p8: vreg-1p8-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VREG_1P8";
+
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		vin-supply = <&vreg_5p0>;
+	};
+
+	vreg_1p0: vreg-1p0-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VREG_1P0";
+
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1000000>;
+
+		vin-supply = <&vreg_1p8>;
+	};
+
+	vreg_3p0: vreg-3p0-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VREG_3P0";
+
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+
+		vin-supply = <&vreg_12p0>;
+	};
+
 	vreg_conn_1p8: regulator-conn-1p8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vreg_conn_1p8";
@@ -288,6 +358,86 @@ vreg_l17a: ldo17 {
 	};
 };
 
+&i2c2 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	io_expander: pinctrl@3e {
+		compatible = "semtech,sx1509q";
+		reg = <0x3e>;
+		interrupts-extended = <&tlmm 58 IRQ_TYPE_EDGE_FALLING>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		semtech,probe-reset;
+	};
+
+	i2c-mux@77 {
+		compatible = "nxp,pca9542";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			bridge@58 {
+				compatible = "analogix,anx7625";
+				reg = <0x58>;
+				interrupts-extended = <&io_expander 0 IRQ_TYPE_EDGE_FALLING>;
+				enable-gpios = <&tlmm 4 GPIO_ACTIVE_HIGH>;
+				reset-gpios = <&tlmm 5 GPIO_ACTIVE_HIGH>;
+				vdd10-supply = <&vreg_1p0>;
+				vdd18-supply = <&vreg_1p8>;
+				vdd33-supply = <&vreg_3p0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						dsi2dp_bridge_in: endpoint {
+							remote-endpoint = <&mdss_dsi0_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						dsi2dp_bridge_out: endpoint {
+							remote-endpoint = <&dp_dsi0_connector_in>;
+						};
+					};
+				};
+			};
+		};
+	};
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&vreg_l11a>;
+	status = "okay";
+};
+
+&mdss_dsi0_out {
+	remote-endpoint = <&dsi2dp_bridge_in>;
+	data-lanes = <0 1 2 3>;
+};
+
+&mdss_dsi0_phy {
+	vcca-supply = <&vreg_l5a>;
+	status = "okay";
+};
+
 &pcie {
 	perst-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 100 GPIO_ACTIVE_HIGH>;

-- 
2.34.1



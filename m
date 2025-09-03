Return-Path: <linux-kernel+bounces-798922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60880B424B7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F84A1A8243C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DF0322552;
	Wed,  3 Sep 2025 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aUJvs2LV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C449F321F46
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912452; cv=none; b=L/AJOXZlZAE+kxheFB7nypf0Ax7g5+YqkpeoeOsPb/nWsBWiG9mPCUxJIM6Y/WNnH9wvMssZN1i/AFZiVQSrMpCBUS6wztnfYQDbamk3lp/Uhsh8DjbPALUCzkLbJxSzIVFMSY94k2qVdmQdNMWkwbBnPS2cbMpKd7elDZDakWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912452; c=relaxed/simple;
	bh=iBKYOpGPyv+9zI93qQknVrs+/6gKwzWVCvy1W+3qLW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a0sf9EXDj+AzuJYmSJLKyRzu9ZDaTXH/eYXx5v1ZhAygufa6GZWJfG0YCrDCrT0Hz0fNHP38AI6ABHvOt/tWP55rGfr/uKePwNKJHAXvc1ZNLTGE8keYWmLGGIhWhgBHSbPdblIBTedDsAt7H6eUVde5aGCLcH51pNyOb2o6F70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aUJvs2LV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dwob5029551
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 15:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=RsvsUgYey4U
	BhpLmgTWdFwV40CxonIezuuQ/VfUSJX8=; b=aUJvs2LVsW8uQ84kIHe3/1cDbws
	9A7sdTsAoQ4Ed8Ax5BUtNkoW9vPHEgYEpXZvswh6MCi2VGD+gEzfUyBUmmjZJ0Ys
	JJ7EmqopLx/QxPQrOSsu4okv16zHReznLbQc1xq7jTsNeSlxjnetwY9nCdY/FYja
	YdBMYUXWvpyeqP7mvl4eP9tgjFeYgmfHgbQHijTYmnfuqSpIuemLv0UqASljeqDD
	QYy0IcBW5+x63ugKmfHSI4D3J285ljF16nU98kmOw8NLCOgqixjHv6Vb+iCfJAEk
	jhGpUkx5GlhXCPEz8eKlIqbF1gHUxhoP0qra/PUW7Prlq51lgf272BQ648g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpca5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 15:14:08 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24457ef983fso854095ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912448; x=1757517248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RsvsUgYey4UBhpLmgTWdFwV40CxonIezuuQ/VfUSJX8=;
        b=K7OI09YRF+KxNzSZD1JBcNptJJHqgwERH1VAH5Kt+loEirNuxs+HLq9PCU1x2ApCMy
         UZ3mzjvPsLF7zdr/Zc3UVD9gF2S1Np8yVktE8BXyVJe9aGK4ABIbdKr+lnXtOPiSw2Vk
         qq2Z54+NdnU1L1M8J/wEGZy+ZZgRVUPo91CqTACXwb9xXm69A2GmysfQtC+IbUTH8NSJ
         rfh1y76N/1L/7yiaZt6ABsDCaSev7aLashY2aY7s0ySD7FyX+HIBg2aaH05vxJbP9gQL
         KpHNVZrTscbX+Xbf/jCrXe1a5uhEmFXKZ1uhfs2QKGld3XEfDJckdlXArvqeTD5tdY1j
         bK4w==
X-Forwarded-Encrypted: i=1; AJvYcCXOaUvmGSmNHS6XCs9LeG9g3L2SfnyfuUzIfQVFx1aidtbalk1EgFtODKo1962f7u9zEZ/CJzU4sJSVbNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8LHYIIJL1hjLBgItiXV1J7TtlN77bd3V94ziD9yC18Vrr4VTM
	ReWHLrrcDUxcguw9pKD+GxiAJqU3fG6BxajysIz/dNNLrUcAqqAABbzvyx4r5HZ/MyZNJUCJX6n
	9Cro3EN1e7k/1a5+k3OTW9uSRqIn7cQ1lcfGxHFsnwDvIddvUVVXG7WC+AQAm7FiYFjE=
X-Gm-Gg: ASbGncuYKikkjIZ/+V6OftrCrMFXC5n0GgqtziCfwOM1yXSyFnuXgTQldEW1+2fKAqx
	k85CMarIe5Nw2c3xvy2mOnCJzU6DSSdr+N35i2rj99efC5uEOsqPnV3cKrM+C7hkBL3pD7UoQIK
	psYkQJ88kzj3P4oPg1RDcxe27aCCzsXF5RupASxiGWFSVdbIsaE/zoUDLZqMpFqit2IHym3DADK
	KwtKSibjEY3tu5cgiu7Ul/zVBY6kQ27SBsm8toaIIony+oSXybcvRoNSN8HYBDKBacILJpvreGE
	mu1tAZXQgh3PWO5aBkWJmcdMz7xlfF60e+PyjH7goI10YE437zgebrFTPZaRGGQWPNF+l40+GIO
	p
X-Received: by 2002:a17:903:2c03:b0:240:92f9:7b85 with SMTP id d9443c01a7336-249446d2982mr177996755ad.0.1756912447415;
        Wed, 03 Sep 2025 08:14:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0MgnlTxIAVarLgp0e9JQQUNXagDbI4OQFXCoge5p1C6fk5EN8sgATia2tBH5VV5Q9tApHRw==
X-Received: by 2002:a17:903:2c03:b0:240:92f9:7b85 with SMTP id d9443c01a7336-249446d2982mr177996335ad.0.1756912446898;
        Wed, 03 Sep 2025 08:14:06 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903758b89sm164818945ad.59.2025.09.03.08.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:14:06 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com,
        Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v9 3/8] arm64: dts: qcom: sc7280: Add WSA SoundWire and LPASS support
Date: Wed,  3 Sep 2025 20:43:32 +0530
Message-Id: <20250903151337.1037246-4-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903151337.1037246-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250903151337.1037246-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UE5iMxS72oCEAeUgPmNuHlmboobiTpPG
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b85b40 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=cYIjkc3OaKe1eJlVBt8A:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: UE5iMxS72oCEAeUgPmNuHlmboobiTpPG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX3+Ijh4PCZ9J5
 8g1C9nKmbqFmDiYxAfFT0dj3n/hZ6aCQLxxnhzySIdbY/c+52VudY4h71Tk5wCaLnGOrBamAbE0
 UWa8pzUpgyiuoAmDAMXlFQoVKJ5BFzXT0lL0VL7M6AMMBu4YMXzaOB4ozZTDUWhA6N7HW//5NKK
 O8o6nKdw5oIkQd8T8CPzOk8GrlFVvxGlJdLcD6Q7LXTQy1hpzxexXZ+4QkDvICeTQaFLTam3ytb
 oPRiwEgu/gh3AQWH+/vmtE/TLNwB2knjsCQEbQUSDJeg8ZyI62+qE0acdEMgD0I+S6aIU5sc59Y
 BAjUxlquWhCAxzEPtYXMEayl8b8Sx4SV3RI5bc6Vpb+g2YWlXzVMDYW73chTGmpeeyuK0eAoYeG
 bUeADf7L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

Add WSA LPASS macro Codec along with SoundWire controller.

Co-developed-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 77 ++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 9fa294cc9a3e..4f7aca76f364 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -28,6 +28,7 @@
 #include <dt-bindings/soc/qcom,apr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/sound/qcom,lpass.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
 #include <dt-bindings/thermal/thermal.h>
 
@@ -2773,6 +2774,66 @@ swr1: soundwire@3230000 {
 			status = "disabled";
 		};
 
+		lpass_wsa_macro: codec@3240000 {
+			compatible = "qcom,sc7280-lpass-wsa-macro";
+			reg = <0x0 0x03240000 0x0 0x1000>;
+
+			clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
+				 <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
+				 <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&lpass_va_macro>;
+			clock-names = "mclk",
+				      "npl",
+				      "macro",
+				      "dcodec",
+				      "fsgen";
+
+			pinctrl-0 = <&lpass_wsa_swr_clk>, <&lpass_wsa_swr_data>;
+			pinctrl-names = "default";
+
+			#clock-cells = <0>;
+			clock-output-names = "mclk";
+			#sound-dai-cells = <1>;
+
+			status = "disabled";
+		};
+
+		swr2: soundwire@3250000 {
+			compatible = "qcom,soundwire-v1.6.0";
+			reg = <0x0 0x03250000 0x0 0x2000>;
+
+			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&lpass_wsa_macro>;
+			clock-names = "iface";
+
+			resets = <&lpass_audiocc LPASS_AUDIO_SWR_WSA_CGCR>;
+			reset-names = "swr_audio_cgcr";
+
+			qcom,din-ports = <2>;
+			qcom,dout-ports = <6>;
+
+			qcom,ports-sinterval-low = /bits/ 8 <0x07 0x1f 0x3f 0x07
+								0x1f 0x3f 0x0f 0x0f>;
+			qcom,ports-offset1 = /bits/ 8 <0x01 0x02 0x0c 0x06 0x12 0x0d 0x07 0x0a>;
+			qcom,ports-offset2 = /bits/ 8 <0xff 0x00 0x1f 0xff 0x00 0x1f 0x00 0x00>;
+			qcom,ports-hstart = /bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-hstop = /bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-word-length = /bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-block-pack-mode = /bits/ 8 <0xff 0xff 0x01 0xff 0xff 0x01
+							       0xff 0xff>;
+			qcom,ports-block-group-count = /bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff
+								0xff 0xff>;
+			qcom,ports-lane-control = /bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff
+							    0xff 0xff>;
+
+			#address-cells = <2>;
+			#size-cells = <0>;
+			#sound-dai-cells = <1>;
+
+			status = "disabled";
+		};
+
 		lpass_audiocc: clock-controller@3300000 {
 			compatible = "qcom,sc7280-lpassaudiocc";
 			reg = <0 0x03300000 0 0x30000>,
@@ -2976,6 +3037,22 @@ lpass_tx_swr_data: tx-swr-data-state {
 				pins = "gpio1", "gpio2", "gpio14";
 				function = "swr_tx_data";
 			};
+
+			lpass_wsa_swr_clk: wsa-swr-clk-state {
+				pins = "gpio10";
+				function = "wsa_swr_clk";
+				drive-strength = <2>;
+				slew-rate = <1>;
+				bias-disable;
+			};
+
+			lpass_wsa_swr_data: wsa-swr-data-state {
+				pins = "gpio11";
+				function = "wsa_swr_data";
+				drive-strength = <2>;
+				slew-rate = <1>;
+				bias-bus-hold;
+			};
 		};
 
 		gpu: gpu@3d00000 {
-- 
2.34.1



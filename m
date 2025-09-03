Return-Path: <linux-kernel+bounces-798414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66971B41D92
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D85547014
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3362FCC19;
	Wed,  3 Sep 2025 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ce4un2Nb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5494302CBE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900117; cv=none; b=iCG/DahMwP1zQibWoXOGDIbtf4Dcv/trltGcvqkOtxtYmqv0sbvTMr22wdDP43eghNAB4zDjy8wh2LkD1v+ie/+s7GcB1YLxv1Vj4rkdG3fKGPB+rZU4csuLaYqwQBtx2k5kNNIy+teNML+ZObYKlP8IdRYkpWFLLtYpLK4ySM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900117; c=relaxed/simple;
	bh=JsB/vM+vDg1pqrgFnPVYbAfiodJ6g4Ketnyr07QLJjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u2a8kLLWEqUkZYCeIAhc1+K+YV0gR5USCyNE0cJUd34M4Zv3iilvuqlFEHROTCUP+3bO1Mwt5jQCnSj7MxFx9V6iRRnUHK7ak0uOOK0YNiZ/kB4JbNOvunktite/Qmm/3lnM+98+mUVP9WjRCQR1fCgrq9EqicGQSEhA+VI0BH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ce4un2Nb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BF57R022948
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 11:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QI9++NezeeQHxyb4K/k5RMtpPMwIn4t3wPgvkRjOclg=; b=Ce4un2Nbz2f7tBH8
	A+oBYYn+QMFrrQv3kWkzxsoAJF0d2GatqTa+QXX4OLtjw8Kq8exbf+1vYgknz54R
	ZmriU7M1cRin5gY5Sko7jAWkQACCiY1BrekIHa0kUNIA0y+gi3UpXgFxnIRzZFqY
	9uCyjqLcDiQr3heu9v1+Jy1JucpRm5aPG5GT6YZOlSpWIVUxGB8DoBmtf1v63Hn8
	J/oIoD+lCzG5L/jRkJgt4BMNaPxEr/CTUtGQjDqP3OjqdNB3R4VJrrbDgou26dkl
	objG50RllRq/06DWS4hoRPFe0Jm2Qz8AlFX6sxc+BOd6aUQCtp2xp2qVR8jh2Jai
	Zp1eIg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fkcwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 11:48:35 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7725a76dcb4so696254b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900114; x=1757504914;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QI9++NezeeQHxyb4K/k5RMtpPMwIn4t3wPgvkRjOclg=;
        b=qD/H75BzeKc6DuDlS32LuwfRg7CR2i0gI7l9ZoRVDq6/PJW8dmARNef+AzJdvGyBaF
         iIqpDHyyAXxIksecqAXKRKo68ZTHtpS5VywV7L2XseRfUKbN7vddCNlM+6EeqQvr0B5k
         Bt5yZFtk/CSgWi/+E/iMWFHoTBwmgkSyn3h/lX5mXD5kOOJVTaNelo3GythZmQEOCnQ+
         tsPOV1yqRZII4GqdV2VfI4DGR8c1dtE1TLaQQ6xN2oBiKEFxh9bZsIb1wZI+ruFMSbEc
         fxpfPo4UGV9ibB7v+1OXgQIuf7/2fvRMZU5bzJ2+heZbNN+gRpH5S+chp4IbJPoRXdhD
         q+Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWIz1A6qF67LLnZxQHysGmjKfw6XOQQbz9SgwkdIE1rUvrPocZh1IolrsF+Nh6uYjl6SLDfCl29BiUusUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc8GFGfkrGtdCKCTZRt8Wz32wadMJlbavbn0Q/wgKHBCGCBFc1
	tVgFfWdRvusE0Pi50ydL0OGyLUoF+UCAJJF78DPEzh33nRj8KgPTVfpT2SAS8GKpfmyRM/zOMt8
	icgHZrg5ohgKN/w7+cCPJQfn6TCuVszN3V7g/Fk9mT940n2LLVt+fogck6x9kqvOp/Js=
X-Gm-Gg: ASbGnct/MsJ+rSx+Dm2wYgV19zGvJgxl2CIlqxIONVjnnbjXSKSB9/ScButA6BtGCtL
	WgKqdb2hccpX5JbrrSwHGo0h91gxciFHMZVQLb6QHJSi5zkBWqlfDsKPFlJ4gN8lIGJZqSY12l5
	rFo3v+1PKXIGF/l75riZZI5EiD7XyBeYG+16aZ/fzK8OL+TkAeqtEzcEUxg34pKTtF57+8Jch5V
	a9VGQ0yo47Hp4DiQLCYF326WuExfjjSJlutGzAU3QqilXn0Q3rA+so9AMa+kTlfeMEyrv3c5Sce
	zQshbVNQ6aeRzFBkcGoVax0Rx2S4utTv47yjegL7Qzj7KzwXjcyUs9imHKMcK47eIxVl
X-Received: by 2002:a05:6a21:32a6:b0:247:55a7:695a with SMTP id adf61e73a8af0-24755a77066mr3480270637.15.1756900114154;
        Wed, 03 Sep 2025 04:48:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3NjxqXFYsOho+XHvlskDWQdVStPAKzQQGePA4tis9XWfYdQEn5D+B3PKJy3PtGYOByW+HNA==
X-Received: by 2002:a05:6a21:32a6:b0:247:55a7:695a with SMTP id adf61e73a8af0-24755a77066mr3480224637.15.1756900113649;
        Wed, 03 Sep 2025 04:48:33 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a2851sm6584074a12.37.2025.09.03.04.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:48:33 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 17:17:14 +0530
Subject: [PATCH v2 13/13] arm64: dts: qcom: lemans-evk: Add sound card
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-lemans-evk-bu-v2-13-bfa381bf8ba2@oss.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
In-Reply-To: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756900050; l=3115;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=rsQ70XuuzikTEL//lunyv8DprTTtt6yK/Y2Nh5U3LqY=;
 b=Bi1icvmEuhZPp4acn7G3T11pofXg0hfMgKG2V8vfOCqLQ3al20o4FihRTpNycjFQw0mE2l+mq
 v0HawdkxcZBAzqiiRqxbue21LsgiJbQRXaPmfeZK6370Qm18IuGpWJq
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX6tY9A07O6U3h
 xUBM2Z0ES5qcxpgFKIZa6EBlWH4ySeH+Hvd8fugUuaW2zE8PcM18jL0icx6PH7b4g6RAA0jieDt
 MqK3gS0ZKAzn6mRT6Ivq1i+025u2Q0Tk99vUEd8Ou6G0Np+RH/A9Fe9uclS1kgFMGd6PdVzJxV3
 YrJNtlaecZqqXcSnsiF+cl0TpUbVjpF9Y/ObiJGdqLSl5uv0VAYzUOPZRr11zbl2lTj/Kf7W0lm
 06wBj4QTibVkHiUqebFk85S6Vbw3h5VJr1zNwUrqQJz6g7Oi1f3PnJc9m4FQ5sR//y6tZ3BICrA
 NTqV276C7T1gJ1e9PwNqQqyn+y8sAzhaNGuanhwWIET/BjTE81rkNHOJSXwDziRsZNB2DBW+uGR
 r2+fp0Xu
X-Proofpoint-ORIG-GUID: tPnsVKgceaCzg5x0uR4Fpt4hzjNOgFAH
X-Proofpoint-GUID: tPnsVKgceaCzg5x0uR4Fpt4hzjNOgFAH
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b82b13 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=WTMWP25ZRELiBA-utRQA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038

From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>

Add the sound card for Lemans-Evk board and verified playback
functionality using the max98357a I2S speaker amplifier and I2S
microphones. The max98357a speaker amplifier is connected via
High-Speed MI2S HS0 interface, while the microphones utilize the
HS2 interface. This patch also introduces pin control support
for the High-Speed I2S interfaces.

Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 52 +++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/lemans.dtsi    | 14 +++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 69ce6a60361a..7802fd830aa0 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
 
 #include "lemans.dtsi"
 #include "lemans-pmics.dtsi"
@@ -25,6 +26,17 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	dmic: audio-codec-0 {
+		compatible = "dmic-codec";
+		#sound-dai-cells = <0>;
+		num-channels = <1>;
+	};
+
+	max98357a: audio-codec-1 {
+		compatible = "maxim,max98357a";
+		#sound-dai-cells = <0>;
+	};
+
 	edp0-connector {
 		compatible = "dp-connector";
 		label = "EDP0";
@@ -70,6 +82,46 @@ vreg_sdc: regulator-vreg-sdc {
 
 		startup-delay-us = <100>;
 	};
+
+	sound {
+		compatible = "qcom,qcs9100-sndcard";
+		model = "LEMANS-EVK";
+
+		pinctrl-0 = <&hs0_mi2s_active>, <&hs2_mi2s_active>;
+		pinctrl-names = "default";
+
+		hs0-mi2s-playback-dai-link {
+			link-name = "HS0 MI2S Playback";
+
+			codec {
+				sound-dai = <&max98357a>;
+			};
+
+			cpu {
+				sound-dai = <&q6apmbedai PRIMARY_MI2S_RX>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		hs2-mi2s-capture-dai-link {
+			link-name = "HS2 MI2S Capture";
+
+			codec {
+				sound-dai = <&dmic>;
+			};
+
+			cpu {
+				sound-dai = <&q6apmbedai TERTIARY_MI2S_TX>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+	};
 };
 
 &apps_rsc {
diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 41003d8878f0..de8f5d78d0d2 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -5068,6 +5068,20 @@ dp1_hot_plug_det: dp1-hot-plug-det-state {
 				bias-disable;
 			};
 
+			hs0_mi2s_active: hs0-mi2s-active-state {
+				pins = "gpio114", "gpio115", "gpio116", "gpio117";
+				function = "hs0_mi2s";
+				drive-strength = <8>;
+				bias-disable;
+			};
+
+			hs2_mi2s_active: hs2-mi2s-active-state {
+				pins = "gpio122", "gpio123", "gpio124", "gpio125";
+				function = "hs2_mi2s";
+				drive-strength = <8>;
+				bias-disable;
+			};
+
 			qup_i2c0_default: qup-i2c0-state {
 				pins = "gpio20", "gpio21";
 				function = "qup0_se0";

-- 
2.51.0



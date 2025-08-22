Return-Path: <linux-kernel+bounces-781962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB872B3195D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA4EA21C4F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72BD2FFDDD;
	Fri, 22 Aug 2025 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DaKYv8m1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD492FE574
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868775; cv=none; b=RjsuZIdBC6g0Ec4c+C3bzolTRfxfAL9zKFbPhiG3Uf8CdRyn3/FnRM5VzPXhMrTVihQewSE6zZbj7t/p/zOilJ7+1C8I83anD71SKqtm3Uy4bTow6KJEkTQKF+xNh+ed6VBOzRU0h47u6F+e0etN9x9unrRvKqvxds4hvKWIAdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868775; c=relaxed/simple;
	bh=p1lojM5nyeVH0L3ungCLAGrmlI+pOzLl59WmtGTtIF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OQd841I4IdSHVhIAFs8JO9EX62fXrk0BxnIJMzDsVAbdlDeVhzOwFumIPPaGF1V+FmTh4cLNBYawlhVyn9aZCe65LO6uajSBL0Z2vtdXEwzxBZvhQvhnGnc7Lu2QcNYXx0INCz6d2qTBqXNOIBzh5UvFjZJiBkqt3rcJwerETsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DaKYv8m1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UVCn001232
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=vNUipRbE5fx
	ce8vnIsbMIrjSIDj5rZHRbC1GeB9L/KY=; b=DaKYv8m11fBqbvyOGHLxvD4QQ3a
	wXdzjKyD+MH9W6GwVr9PGwHhw0oZojJGPMHnJBPzj85IQaaKWqClAAjd6wcnKt59
	JZyIk5hQwcmH9HW8Qa3PNuygOj961/ByBzojNYUgOMLvIwF9EKCC39+REWTci/Fq
	7OA/8aqMxb82YqE+NNNmwnloQZvsPVV2hZEGm+fo86exczZet3AAzBZp5vDyv+/x
	Jx3vizvwFI9rsEoucys2ZYkDtqf7aPU8p3X8L4OZ45cuMAv8T+cKVHXZ9nTk5yJC
	lhhVHeYVNzEjvlQBZvolkqqByWT6Ik9hloq+A61GHODFYIaa8rFEXB78Q+A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5299bbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:19:31 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2eab5baaso1878410b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755868771; x=1756473571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNUipRbE5fxce8vnIsbMIrjSIDj5rZHRbC1GeB9L/KY=;
        b=uY+lOcHWxvVRMKcIpe1E94d6aQTm0BmTa55Vj8MGLz9BME+JkffIyZEK7ByvsT6kNI
         Bcjv4NIcuw90/GlgnJ6ihGLmyKQBE+1y6H867mu15n0CuOQHXVXOUZCfrthwOZN4ShW5
         ts3QvSL1FdJkDRVn5fd5nE/1gr+yPzsQjFLUsFvL+EcjDqoCem9mBBISrfyQIZCsVPpf
         8KHZOEo1o9/3eYcHgWG+BrAGhPS+4LsrmXM8A9MT5MkGQkSPQTLCeIi81HKOEkaJVDYp
         TC8ydqnqxPqQiK38Fet91+FSwSIS/dRXQcZ+7DPy6EuaeBUcxBWxMytTiPJX/opsxXg7
         nvaA==
X-Forwarded-Encrypted: i=1; AJvYcCXtctg91vt+ycTMc98g9tIArdzhuoUnk5F7ezCISE8eUUIUj7DFl+PR0ZzMhSm/ov59W3J+OU/RD3amwRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY9VYWFdQXB9xIYjaqNLYlnivTGX9RDKSgI5egjW9P4q1DgC8G
	PE+UgDx8oL0B6MKhGNqIE8plp3v2Sln157H1vi5QTH/taR3z4UcfRCV0yLQRK5PsTW4Emrn38oh
	Cy/unQg9SVIrWTv6FkkL/7OaWqt8auCul2VO+/JCaHOc9Ug1kYxeNkrSeFOO3FspzKY0=
X-Gm-Gg: ASbGnctvcns9n+N6OTAP76E7qLp4J65vuODp8HMEeNuRLheEnXPHLVGgj7YXQl4s3ZU
	igRELWQyvr80i9kJmlK1h9wJtSeoykTFZnFjF6mqQmGT6j3hZ/nL/w/ixKRhHPOfRtasxY7MkPR
	7uzylAa2p6npcJHInWqzzmwtBV4Fyt9JaFCTEZJDBLrRgO4xiqMY0Gl/U2BqxYXPyQe8RaMKS1r
	uRhgOj0IaUyynk9DgHihg1xbOjOvOgabsQy6NaHV/VkFH0+gerYdXNnWpWZeNy3MMQhCHULc3qx
	+FYcpdMCCF3zw+VWLbwHRgJm8q5IyMYcs2+JoasmarVNUg7bu8jwjDhviYN8P8jQpS9cElzsU2Q
	g
X-Received: by 2002:a05:6a20:7fa7:b0:220:631c:e090 with SMTP id adf61e73a8af0-24340884ecfmr4535902637.0.1755868770960;
        Fri, 22 Aug 2025 06:19:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs0KFkP5BTa+R2QlhzOkxpGvgMcS67+Ki+Y7hGXCge7fxFOeBX3xAEM0bX/4I7Gp2cRnOFIQ==
X-Received: by 2002:a05:6a20:7fa7:b0:220:631c:e090 with SMTP id adf61e73a8af0-24340884ecfmr4535857637.0.1755868770475;
        Fri, 22 Aug 2025 06:19:30 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7703d2b7301sm405621b3a.93.2025.08.22.06.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:19:30 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com
Subject: [PATCH v4 2/2] arm64: dts: qcom: lemans-evk: Add sound card
Date: Fri, 22 Aug 2025 18:49:02 +0530
Message-Id: <20250822131902.1848802-3-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822131902.1848802-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250822131902.1848802-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _GeAqqCXTN5o9euKJTg3XeAluKcYbHSv
X-Proofpoint-ORIG-GUID: _GeAqqCXTN5o9euKJTg3XeAluKcYbHSv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX7LEwcd2KZAJO
 T83pLAVK6FywZs+BXF3ozEh2UPdSyQjg2ts0UHuRWL9VJzNVdyYuqnt3V8Iqb/jJdLWO4qdOIpY
 PyqBR25RJZM7MdPIe3MlPgQuv/FT3C5bbp7xuEldbzlgIzKfc2Ecm9tqQdc+s3t4Ov27lbii9wG
 MZgrHM3H45PcsKqG1wYfl4zEePKI7OOMruNXdcdkbAEiKKZayEeDNDioXQ1iAlpkE9/UyXpzfed
 SXYkS+mylxCHfL+FjPwQ2hTCGdi3Fr2eNDB9RKQYUOa1coK7EYjbam1KDyIzD6BgZXdPK6/Rbiq
 o5rQdtReP2POQ0+EX6rvIk42MVxjG4mAVS96GMbrgqd/do9Otig/MWG3Bc5aLUdZY3tIYGJlstJ
 uta8lrcndxLIKDmj+Tuc9F7PMrzXGw==
X-Authority-Analysis: v=2.4 cv=SPkblOvH c=1 sm=1 tr=0 ts=68a86e64 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=_dDu9j5-v2Tbu4HaPncA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Add the sound card node with tested playback over max98357a
I2S speakers amplifier and I2S mic.

Introduce HS (High-Speed) MI2S pin control support.
The I2S max98357a speaker amplifier is connected via HS0 and I2S
microphones utilize the HS2 interface.

Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 52 +++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/lemans.dtsi    | 14 +++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 669ac52f4cf6..d67a9307cc75 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
 #include "lemans.dtsi"
@@ -22,6 +23,57 @@ aliases {
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
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
index 7026f25877c8..d73037d6d97a 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -5005,6 +5005,20 @@ tlmm: pinctrl@f000000 {
 			gpio-ranges = <&tlmm 0 0 149>;
 			wakeup-parent = <&pdc>;
 
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
2.34.1



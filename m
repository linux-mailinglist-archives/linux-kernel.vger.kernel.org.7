Return-Path: <linux-kernel+bounces-743266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EEAB0FCC3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A528A3B43C0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F989272E48;
	Wed, 23 Jul 2025 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C8OXm6jX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CA1273D71
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309680; cv=none; b=DvHvq1wsxwaGcWaDTxN8DczVfF4n2CX6k7mv9iIRrgh0ALT5QP/Y+nu8YIP91VoHKtwDksiVUckmu1srZgd5U4mOhTDZwDweYZ1+5+un9L1Ptnc/dc7vVk5Y/JAEFsaRM53zvYhD04TLoCuJ3UgxePOiA0EB6VAmswQq0yn59yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309680; c=relaxed/simple;
	bh=pvf9JF7jjZfMEX1LsRfCZnTjM3hSxhl1Eal1wQ6AyDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4NAxWfNab13g4R7Het0CyswbZ+1EkS8QlWiQI6Pzt4vtDKeTfCTjx/AhJh66ANxp5LwcgDPiHGFCGk0ZCAJQQ8F/PXcEhpnLODl90X9gyJWkPNWnu0BfQBc8k8s+xjNxoWDHAIRqtfSEs4rhEAufxl4xgX9FzFgK+no6SJvWk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C8OXm6jX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NHrdHC032272
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rGjVOGGinto
	CGY8gtHt3SxU3lDJJ/TxmoFuDubqT8pw=; b=C8OXm6jXBVJheqfFrBZJHRY7Cn2
	xVsEejRTwvcKgKO4Avic8ITYUQl6X4pNnpEQVo3RePrFi4YFHTZQPI9alj6eGXSA
	vE4p3R5OXcGFxfcOt11u82W9GHOFM8pP/7NNpK/x9qF8269Nu4pGIpHi3oI0lnW6
	AaxTri5yJKwinxDDyFWHd6pYx93tcokielYuci/d4wyzszdsVugxdVX5NYimc1Pr
	PeZq1huDOdz+ykWEs7+SNi1O8dX3+tX8rdbW6ak06wCFuuaNlipat5EbQ9Un26JL
	OJvGCYh/5BR6RgJ2ID8dNKQS/wpLJFVc6FItgkO1v9Ga3I1idI45Tz/d+3w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t1e12n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:27:57 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e3452c060eso31093985a.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753309676; x=1753914476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGjVOGGintoCGY8gtHt3SxU3lDJJ/TxmoFuDubqT8pw=;
        b=kKeMj7cD82vWDLHOV2Jq1OVrTmPmuBe/YI3CBXwjtUAxJ8x5G/DipT4u1CtLoj1gOk
         S4vx+Tyj9dQdS7tR2sB6q4+KDd2eo06z+EkQkx2I98RhzQa3PATv2aQ8NFOaUDxUjN7L
         mzrHi3/7pn5luHlWVxKJ7+2BnqNRpDrVOaZAq/BiMLak2/ESaHmokGhGGFKRsxIzKRqn
         yf8JDlNjuUVvfxM14K+LNf3qptWTHhAkUA+f0qQGNmn4WB4c/hT+mObjbeXMnP8gMH2E
         hnQwNSe30lxggK5O0Ky1j+9wTHh2E0nGe4prLvaIwhNC1XztzQaASQik6/kuN6NuRwqI
         yA4g==
X-Forwarded-Encrypted: i=1; AJvYcCX43cpOiBlXQvAg4cf/utrvq+PL5WY5hl6kGwayjUn3aiTCP1H/PBvXO95XJM0R7ZjQD2hB2XQJduQbKvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3kwYz/IVtYN95OOfOrdm6eUxfVK37iMBAqsjNApphxcO1JFGZ
	I/JAzGrDTK6D/rhPkgLeDdDzS25Rm8ENrKbTr/noQl7x8Pa+dOY85KyFs7UJ3W5B9jk/aR9a1Nl
	9SiWspKmen1CBiXPMyXZDeCrbFU5tTNa/1LEPT8dRhDpGz0sJ2KWyry8A6OCicVmRmzM=
X-Gm-Gg: ASbGncvTSz8oOKSVv/pwFF09+MqYeMHw79CScbvfGCuNGwsNMz8YaR0SFAOSvCJTPdq
	u2x04rYvAciqF0nl+4lBHos/GmGenv5sZnO5giYI2hA55Vwxp0hfbSKB7jYZQGvVtf2RbaahA94
	ykY+y3sRVSpPLlHpUtNT7QVv/jupM9CWTtPs3N3R9Brdf0SCBNACfYh0u7KA4/HOsBZoYxEsQnW
	n0tKIPEK3PdyL/H81ktuYvYQjLN3EKvOk2Yvj7H+Q6P/zWJyVRnyDUm7m4VYqL2u3fS8LntVkPq
	K54V+MJOH0Uk2aH0OxoKfNB8fIYfW2ImCzTwczpRg1inb7lghjfdKA==
X-Received: by 2002:a05:620a:a214:b0:7e3:4014:f322 with SMTP id af79cd13be357-7e62a15a1dcmr550437185a.31.1753309676348;
        Wed, 23 Jul 2025 15:27:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9/popm4R1FR3yrQuWg7/603rsZW/SNKsaARZFwMy/ev531tGkN4vqxS1mQt3rOFlyoBAujg==
X-Received: by 2002:a05:620a:a214:b0:7e3:4014:f322 with SMTP id af79cd13be357-7e62a15a1dcmr550434785a.31.1753309675933;
        Wed, 23 Jul 2025 15:27:55 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad23bsm248520f8f.44.2025.07.23.15.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:27:54 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: andersson@kernel.org, konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 04/23] arm64: dts: qcom: sm8550: use dedicated audioreach dtsi
Date: Wed, 23 Jul 2025 23:27:18 +0100
Message-ID: <20250723222737.35561-5-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250723222737.35561-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250723222737.35561-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sgMnkhXHt6eQvqYdB356lSfQswb2MOQt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE5MiBTYWx0ZWRfX4RQFMFAT/WvD
 da0M8hdEPDTWAunxnEumvmQ4ZH8smO5BtQUgJoYiEtSpj3OcEYuNbD5TUiNMFYO3hz35Vfm6F0P
 QzwqkvT9BNq7uzse8pXwSZQcArxEAnqD72sV0Q8yRiacLwuvS1RncPtaAn7hCiS8yn3Ry2l5iLh
 ACveP5tJFzsAsuUMMGPkBf6cFnjbxVjp4Y0z8Pgbvwrmep4jskLwFfzgQQ54qGLVxaGDtx5wk7W
 XklShfeKNDY8s9Vv+Axzh+4jC0mieCGsb/LtMP63W9+ZPOgn1XeWjmoJNj/Iui5WRaFtWOHwEOX
 8qMeo4bMW9JwnNWkwQ2Mk1uumrNyVwovJm6XLTtte++W67gKDIWyUeXKroHeYdvGQVQARyQLVLR
 8IOU8z4vcnW6+3ry3dRNPiIFRsqJqURw5YNnqZfD9lA5LuR4+fFB4LYrh9DDYDHepdvs0/iT
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=688161ed cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=-ddZ981MevGtOgwbEi0A:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: sgMnkhXHt6eQvqYdB356lSfQswb2MOQt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=540 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230192

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Make use of audioreach-audio.dtsi and remove the gpr nodes from SoC dtsi.
This move removes duplication.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs8550.dtsi         |  1 +
 arch/arm64/boot/dts/qcom/sm8550-audio.dtsi    | 10 +++++
 arch/arm64/boot/dts/qcom/sm8550-hdk.dts       |  1 +
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts       |  1 +
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts       |  1 +
 .../boot/dts/qcom/sm8550-samsung-q5q.dts      |  1 +
 .../qcom/sm8550-sony-xperia-yodo-pdx234.dts   |  1 +
 arch/arm64/boot/dts/qcom/sm8550.dtsi          | 44 ++-----------------
 8 files changed, 19 insertions(+), 41 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8550-audio.dtsi

diff --git a/arch/arm64/boot/dts/qcom/qcs8550.dtsi b/arch/arm64/boot/dts/qcom/qcs8550.dtsi
index f0acdd0b1e93..8cdb14ed8b53 100644
--- a/arch/arm64/boot/dts/qcom/qcs8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs8550.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include "sm8550.dtsi"
+#include "sm8550-audio.dtsi"
 
 /delete-node/ &reserved_memory;
 
diff --git a/arch/arm64/boot/dts/qcom/sm8550-audio.dtsi b/arch/arm64/boot/dts/qcom/sm8550-audio.dtsi
new file mode 100644
index 000000000000..14ae50e72e4b
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8550-audio.dtsi
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#include "audioreach-audio.dtsi"
+
+&q6apmdai{
+	iommus = <&apps_smmu 0x1001 0x80>,
+		 <&apps_smmu 0x1061 0x0>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
index 9dfb248f9ab5..c17851945b6e 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
@@ -8,6 +8,7 @@
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm8550.dtsi"
+#include "sm8550-audio.dtsi"
 #include "pm8010.dtsi"
 #include "pm8550.dtsi"
 #include "pm8550b.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index fdcecd41297d..9decdc32622b 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm8550.dtsi"
+#include "sm8550-audio.dtsi"
 #include "pm8010.dtsi"
 #include "pm8550.dtsi"
 #include "pm8550b.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index 49438a7e77ce..6b80888c030d 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -8,6 +8,7 @@
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm8550.dtsi"
+#include "sm8550-audio.dtsi"
 #include "pm8010.dtsi"
 #include "pm8550.dtsi"
 #include "pm8550b.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts b/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts
index 7d29a57a2b54..2c36e9ca78c2 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts
@@ -10,6 +10,7 @@
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm8550.dtsi"
+#include "sm8550-audio.dtsi"
 #include "pm8550.dtsi"
 #include "pm8550vs.dtsi"
 #include "pmk8550.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts b/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
index d90dc7b37c4a..98c722915d4e 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
@@ -11,6 +11,7 @@
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <dt-bindings/sound/cs35l45.h>
 #include "sm8550.dtsi"
+#include "sm8550-audio.dtsi"
 #include "pm8010.dtsi"
 #include "pm8550.dtsi"
 #include "pm8550b.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 45713d46f3c5..d35d2b9b438d 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -20,7 +20,6 @@
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/power/qcom,rpmhpd.h>
-#include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
 #include <dt-bindings/phy/phy-qcom-qmp.h>
@@ -2746,6 +2745,9 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 				label = "lpass";
 				qcom,remote-pid = <2>;
 
+				gpr: gpr {
+				};
+
 				fastrpc {
 					compatible = "qcom,fastrpc";
 					qcom,glink-channels = "fastrpcglink-apps-dsp";
@@ -2794,46 +2796,6 @@ compute-cb@7 {
 						dma-coherent;
 					};
 				};
-
-				gpr {
-					compatible = "qcom,gpr";
-					qcom,glink-channels = "adsp_apps";
-					qcom,domain = <GPR_DOMAIN_ID_ADSP>;
-					qcom,intents = <512 20>;
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					q6apm: service@1 {
-						compatible = "qcom,q6apm";
-						reg = <GPR_APM_MODULE_IID>;
-						#sound-dai-cells = <0>;
-						qcom,protection-domain = "avs/audio",
-									 "msm/adsp/audio_pd";
-
-						q6apmdai: dais {
-							compatible = "qcom,q6apm-dais";
-							iommus = <&apps_smmu 0x1001 0x80>,
-								 <&apps_smmu 0x1061 0x0>;
-						};
-
-						q6apmbedai: bedais {
-							compatible = "qcom,q6apm-lpass-dais";
-							#sound-dai-cells = <1>;
-						};
-					};
-
-					q6prm: service@2 {
-						compatible = "qcom,q6prm";
-						reg = <GPR_PRM_MODULE_IID>;
-						qcom,protection-domain = "avs/audio",
-									 "msm/adsp/audio_pd";
-
-						q6prmcc: clock-controller {
-							compatible = "qcom,q6prm-lpass-clocks";
-							#clock-cells = <2>;
-						};
-					};
-				};
 			};
 		};
 
-- 
2.50.0



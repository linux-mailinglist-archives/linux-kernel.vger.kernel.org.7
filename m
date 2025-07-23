Return-Path: <linux-kernel+bounces-743274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC46AB0FCD2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E03587022
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11BB276052;
	Wed, 23 Jul 2025 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UAmR7TyI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749CC2750FD
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309689; cv=none; b=n9X3sf22FyL/pGWWeHkGsV8HCnswd8vJxEkkPfOE9aghi4U2F3cYqRXQfuBuKZ/EzBPvC2aQkipc4cyYTD36hJaiFtkbGrjaNOp5C3oRCqveQ9A/u1glcQilgMu1VvhNWlQQyLVAENlb4oObZGrVoMogOlKcGeUxW2r7+YD3XHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309689; c=relaxed/simple;
	bh=XKUT827Diya9gsdp4NNt9fGXSOQCjAATOLC9Fo6qTZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0t0EnNO8VGX3BpPuXKesQDNcr8N+h7h7VgBwAQysEw1Ry0sp2KXfTHNkR8PbXrzTglJueR7f3peTueqCOqRBHtauOyVUv6MkeSrD+GCqKPPergNybyEUxDF7vCLq34yq8eQvcaBHoZv2B4Qm0zcIR0O8MPgM3X+BsmNyOUY4gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UAmR7TyI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NHvhtG021374
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CXn962hWIOP
	OoeJqFuEfdqIL0LSAbPGmMjDTrF+m+FI=; b=UAmR7TyI0vIwh+trJlgInwO5DhX
	8ix+eY+usqjaC737KLEPgiSbBYBXdrBe6VnEYZlhv2V84jcYDuS5SOHQvme+frUK
	Cxa3lBbuAEHsCskSyEt9kCXInei4nHJ8yEdV0EMTf5mhXu1C0is7FjZrutBpdDGq
	Kgx1Ca5fchkkLjbCQuH4QtBg/3Z6+uxjLm0upBRErQYQ62GqKmxzOI6AC8ObZAqd
	xoTwEHiMogqo0oaj/V/OmC3vrDaJXfjv3urRhCV0oJHcVlgWaED+tOzNKFzFXy08
	E+UbifJsQfcc6TtBUA8xo51pXn2Eplyks7QiijjgI/UdhMfOElg2MXUd4iw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6ruyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:06 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e03ac1bf79so28340685a.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753309685; x=1753914485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXn962hWIOPOoeJqFuEfdqIL0LSAbPGmMjDTrF+m+FI=;
        b=pKJkmG0RSspZdU19ruwsNwhpJKDjgyAHr3rQ7GGsN6cmi/vBBV2CHTPVGpuM83gFfP
         dullFzUK1MhT2XEnD9cHRyF7dLG67X/+Omyj/XeGBmtGUdXcQ3O7yl1UVUkZzRksnuqB
         N98fliuwjI16YIwwt2nxtzv+Y51uUGe5E8boEgsQNk0alrj3vGA0QUrRfCz9R7kKtQo/
         gqFlcIIGwUxR4l4+PHHyCeXAGSL5jJp9hmS8CnbeTHeZqEaxUxrJ/xJvXp4NlQ6IufEI
         EdkTP8r/0d2RS9LXxK90futMHITPkBtkVAIkHR3Dvf5cfezBnxQ135vSx6rHeKi8e2AG
         eGxw==
X-Forwarded-Encrypted: i=1; AJvYcCUyViynTOObhqEwKMrvJ0B/vjOqJiFVlCpnFCq+881V83PbiL1eOhDrl1D8a9toezvf9pYbucgiFdzicVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjNqYTniYkoUHGfruDfWt16jv91UGkv2htdv3TGD6cn10fP/UV
	LJyz9cWQvBwMsQFaeaoMo4wfpoXX8+2FQyv9iUaz5CUiSsnI9/vaUZMa5h1I8nNy7lg9Q05vQlY
	EtHmaV4UKlK/b7wlHGeHT0TeCGTLpppiXcaTqkFU0cOwkbrrs280MQK1RXyvv9WSQYuk=
X-Gm-Gg: ASbGncupza6FRjJ520evffw8yh65EsEOdVlM1ebzt7gyMSLJIawxtXgX8wpeXNOoqv/
	nE1+ZF2Uzq895PfeeM0JKQq3vEhoPR6711sdSHCDSCnaSqXSeQTDPaFUofof8z31loIncv7apCf
	NfykOLq2IpfkJ8R9rRqO8NFsjzfDIPiU6FP6UBDKPS41tILnOwAnHkN51RaHaTXOTAxc9XJ+2Ac
	tRe/IZvLMyugY/x1GU3Tdewbb0XrKWN8JZ92yAsyNZ993e/aUfTV4dwUEiJTs0fKfGg547wn0aV
	rCI9nP1I00bylov5quD8lKDOa2mw55rHlISDrSEtzSYlliSvFVbNng==
X-Received: by 2002:a05:620a:a801:b0:7c5:a463:397b with SMTP id af79cd13be357-7e62a0bae6fmr556282885a.20.1753309685267;
        Wed, 23 Jul 2025 15:28:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBaYYgjplFfHrigZf+gmGdcu9OSOBsDXBghP3CWb5gaq5AFlONgypaFZYC7TwPZRdruuNSEA==
X-Received: by 2002:a05:620a:a801:b0:7c5:a463:397b with SMTP id af79cd13be357-7e62a0bae6fmr556280285a.20.1753309684769;
        Wed, 23 Jul 2025 15:28:04 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad23bsm248520f8f.44.2025.07.23.15.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:28:04 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: andersson@kernel.org, konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 12/23] arm64: dts: qcom: sc7280: use dedicated elite-audio dtsi
Date: Wed, 23 Jul 2025 23:27:26 +0100
Message-ID: <20250723222737.35561-13-srinivas.kandagatla@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=688161f6 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=ZVUBih3ntuRNDiIcMoMA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: aoMiHJFj3QsVonyoYaUaTJRt1vjL2wak
X-Proofpoint-GUID: aoMiHJFj3QsVonyoYaUaTJRt1vjL2wak
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE5MyBTYWx0ZWRfX9K7iw04ZqBgv
 AQXLn9Dcj6CKwddv2CTbj9O4yawAEdl+RH9LdlL4cHHtE+Pw5uh1hsshIHVqkOrHgWD6xZpOStt
 coDp+te+fjRHRxne2jrCX5ds3un0TPOwbuLOrGg9GE0Unxh3FzCO5cs3NP/WydC7lQq2l03kv54
 9atJocli07TpLStyGaGnn23VqcM9cF0ijrPQjBhvWoo06iOPU9ZKePDMSZ8vA/o6toyfGmEbIxP
 GOTr+u+Fyk5GDfivpn264u2zgnA5T3X7Tbw2zMgH44YpnKWxUphwOxbsA2vflyHCG1biVsPiIpE
 24xvtgOgUclfdVVpug1GZggiS/AL0L9N4JhFIslpAta6zajWg8teAOWKru1pv3V6dr/FG3Ora6p
 66pSylkfXUm8chCdqVJnLo37Vqjp1BILtkcBSZabET3h/itqkz8d13tMKG0xilv0RGKWPOvY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230193

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Make use of elite-audio.dtsi and remove the gpr nodes from SoC dtsi.
This move removes duplication.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 .../boot/dts/qcom/qcm6490-fairphone-fp5.dts   |  1 +
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts      |  1 +
 .../boot/dts/qcom/qcm6490-shift-otter.dts     |  1 +
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  |  1 +
 arch/arm64/boot/dts/qcom/sc7280-audio.dtsi    |  8 +++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  1 +
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  1 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi          | 68 +------------------
 arch/arm64/boot/dts/qcom/sm7325.dtsi          |  1 +
 9 files changed, 16 insertions(+), 67 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-audio.dtsi

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index e115b6a52b29..ce578c1fe3d7 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -17,6 +17,7 @@
 #include <dt-bindings/sound/qcom,q6asm.h>
 #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
 #include "sc7280.dtsi"
+#include "sc7280-audio.dtsi"
 #include "pm7250b.dtsi"
 #include "pm7325.dtsi"
 #include "pm8350c.dtsi" /* PM7350C */
diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index 7a155ef6492e..6932ca1c831d 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -14,6 +14,7 @@
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sc7280.dtsi"
+#include "sc7280-audio.dtsi"
 #include "pm7250b.dtsi"
 #include "pm7325.dtsi"
 #include "pm8350c.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
index b9a0f7ac4d9c..92a0bf46cc5f 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
@@ -15,6 +15,7 @@
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sc7280.dtsi"
+#include "sc7280-audio.dtsi"
 #include "pm7250b.dtsi"
 #include "pm7325.dtsi"
 #include "pm8350c.dtsi" /* PM7350C */
diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 5fbcd48f2e2d..8b4717ba0be5 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -15,6 +15,7 @@
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sc7280.dtsi"
+#include "sc7280-audio.dtsi"
 #include "pm7250b.dtsi"
 #include "pm7325.dtsi"
 #include "pm8350c.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sc7280-audio.dtsi b/arch/arm64/boot/dts/qcom/sc7280-audio.dtsi
new file mode 100644
index 000000000000..4ff49550460a
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-audio.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#include "elite-audio.dtsi"
+&q6asmdai{
+	iommus = <&apps_smmu 0x1801 0x0>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 90e5b9ab5b84..ac39fd8fec87 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include "sc7280.dtsi"
+#include "sc7280-audio.dtsi"
 #include "pm7325.dtsi"
 #include "pm8350c.dtsi"
 #include "pmk8350.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index 7d1d5bbbbbd9..c9618ae5b219 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -17,6 +17,7 @@
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
 #include "sc7280.dtsi"
+#include "sc7280-audio.dtsi"
 
 /* PMICs depend on spmi_bus label and so must come after SoC */
 #include "pm7325.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 64a2abd30100..428832e918e6 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -25,7 +25,6 @@
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
 #include <dt-bindings/reset/qcom,sdm845-pdc.h>
-#include <dt-bindings/soc/qcom,apr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/sound/qcom,lpass.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
@@ -3833,73 +3832,8 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 				label = "lpass";
 				qcom,remote-pid = <2>;
 
-				apr {
-					compatible = "qcom,apr-v2";
+				apr: apr {
 					qcom,glink-channels = "apr_audio_svc";
-					qcom,domain = <APR_DOMAIN_ADSP>;
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					service@3 {
-						reg = <APR_SVC_ADSP_CORE>;
-						compatible = "qcom,q6core";
-						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
-					};
-
-					q6afe: service@4 {
-						compatible = "qcom,q6afe";
-						reg = <APR_SVC_AFE>;
-						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
-
-						q6afedai: dais {
-							compatible = "qcom,q6afe-dais";
-							#address-cells = <1>;
-							#size-cells = <0>;
-							#sound-dai-cells = <1>;
-						};
-
-						q6afecc: clock-controller {
-							compatible = "qcom,q6afe-clocks";
-							#clock-cells = <2>;
-						};
-					};
-
-					q6asm: service@7 {
-						compatible = "qcom,q6asm";
-						reg = <APR_SVC_ASM>;
-						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
-
-						q6asmdai: dais {
-							compatible = "qcom,q6asm-dais";
-							#address-cells = <1>;
-							#size-cells = <0>;
-							#sound-dai-cells = <1>;
-							iommus = <&apps_smmu 0x1801 0x0>;
-
-							dai@0 {
-								reg = <MSM_FRONTEND_DAI_MULTIMEDIA1>;
-							};
-
-							dai@1 {
-								reg = <MSM_FRONTEND_DAI_MULTIMEDIA2>;
-							};
-
-							dai@2 {
-								reg = <MSM_FRONTEND_DAI_MULTIMEDIA3>;
-							};
-						};
-					};
-
-					q6adm: service@8 {
-						compatible = "qcom,q6adm";
-						reg = <APR_SVC_ADM>;
-						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
-
-						q6routing: routing {
-							compatible = "qcom,q6adm-routing";
-							#sound-dai-cells = <0>;
-						};
-					};
 				};
 
 				fastrpc {
diff --git a/arch/arm64/boot/dts/qcom/sm7325.dtsi b/arch/arm64/boot/dts/qcom/sm7325.dtsi
index 85d34b53e5e9..b4226183cb44 100644
--- a/arch/arm64/boot/dts/qcom/sm7325.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm7325.dtsi
@@ -5,6 +5,7 @@
  */
 
 #include "sc7280.dtsi"
+#include "sc7280-audio.dtsi"
 
 /* SM7325 uses Kryo 670 */
 &cpu0 { compatible = "qcom,kryo670"; };
-- 
2.50.0



Return-Path: <linux-kernel+bounces-743264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4878DB0FCBD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FFB5163A98
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F16273D76;
	Wed, 23 Jul 2025 22:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oPPQAae8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5442737EF
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309677; cv=none; b=crKraixuFEMp2W0mwj1gLwbSW1pGSdiclxMHDZPbFhYwAiOKp3PgHdgdnyMKOLePWiuBudKFHPYQvvO6dIGE4d0kzKqpyBh9T5ZMkpvQsbQwLRmCobYXTcQop49pFClk+c8ZHshaUcYZ55oO9M/gG79iUZXmqthhP486yNfpPow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309677; c=relaxed/simple;
	bh=YekXTtpbtuPJQY9K+KBFkkK1WamERekkK3YWA2mwRYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cky+R16vxOYwkMa2JfkiLAJQ6Dn+ZiW5pU0VMBwLGtHpJwEbtc4Ctz8WHCo1N4LdtwWEsIg3bc6QpZ4X4weMVuSC4TH5wCN2y4OKMlentcRHmcFPdrlGZzUvnE3ve6qV6QKO9zyGcaW/pAZXU9zXu8IDovSzWPPbv+y0kmT3/zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oPPQAae8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NHXD8w024777
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=FxhSae4TrGK
	2oc0rm+K4hgmPsozVGBAQ65/QJBrDpcQ=; b=oPPQAae84/SClWg3K9sRM2gl54X
	+3UFZaCI7lpt2gO26LyGofaRMpaAGGXRJoeW4e1DH8n3kXbKDkGsHhvUS46FVMuC
	yyQm91oO0qe3z7nuGxtRzwFuSkfa63Iu0keqk9d8jiUk75pgEEK6AKg6CgOMhQOb
	SnvSjUAgPPPMk96cUPQx95qi1AwvcHUomf3sIadgVXI1IRhhT7nLUCp6XRG6D5ox
	cpcfxQT+ZRgoESR4Q/m/zgZAAMrZ1AkT5Y5+DcTyaS0LLAH5/GFc4bdM5BShhOeA
	QyK4/+mqNyb/1Efk3nEZVy8jejg3HCkG/eF8IKqqSlkEnhUhxUWL2SPR9Ww==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044dpgac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:27:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e1fb57a7adso28288885a.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753309673; x=1753914473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxhSae4TrGK2oc0rm+K4hgmPsozVGBAQ65/QJBrDpcQ=;
        b=qKJDKBGRUA/l2cQFwIhUzbfWd6kvtcqOzambZmOP5X84pQLZBVEPc2bU+CF3BIBG7g
         f0aAHpGZazu3trGvy7poifdc4K97THqwkNnyd6yxlF2jPopjviMIuMANXQDKwEc1MIDg
         bmI0iZcvE5O3SKDGzIoWmDB9suPp53rjv4+RkvzLs7A54C5wjulSZV0SNmb5YTGl7HfD
         9gHABoffesk7667uNCOmPlBr4gVE6bGCDA3u1t6vUFVIPRYBgYtIv4pt91PyxWfXswJi
         VwWoK16Vdo0eMbHPEdeXLzy4a578lAd9oxzvN1OKsZ0brfOJ6/WNdIY3b+8VGT+mj0K5
         mMQw==
X-Forwarded-Encrypted: i=1; AJvYcCWZiIwAOiSbQ5YzcP4UECj8vDa0xtMFndaBatkGybytoPW807PuJe8xlCpkts5FxGQzzklCemuBm5fue3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIR0bDZeYZHt9M2K05lYGov6eAa6ZVS62bCuUMR4bB2B6cLmm1
	P2B6mZiJ2ZFGB98BBEygsddUtYUR3QYVBc2RUif29n515jO7IqRDi/HUDRGPqMcgO09ejMdpUvV
	V8NCPtL36gmY6vkfGfcvnTO/EYhye1A7kUtQyYEeDBC2Zd1Ptl8PcZY1hHlB471C7etI=
X-Gm-Gg: ASbGnctV2BOs9Q5PJ5oKBGoh4J8txJiiWtaM213PEx8a7z2zURzv0nGCkj3uRnG/a1I
	w5I6zoNPdgOD/BuY9ieT4tWW+WBb1uDxIjuEOSJtZs+Tw4SJkTAo0d0Pn6QY/DAPDaXkFNyP+hV
	6nu05GwBl4s2SY0TpLkQvqSZ5Sz2CsUGMttGztKDN2KBm5ITvQPz+ROAm8B5WxqSZ3lJxS6XlGK
	mbV9uaD1fAqed23U756oiRs/9TFnVMpno7KWfEqKbDoyVw8T4LU9Y9q3r0zw+e7oxH1ryfIXJHJ
	ILsS0xpNRevun3854dumaEFtyuCSXX2sdP1yigyDjnFR01PT7fksEg==
X-Received: by 2002:a05:620a:a904:b0:7e1:3b7d:d12b with SMTP id af79cd13be357-7e62a098a20mr559031385a.6.1753309672764;
        Wed, 23 Jul 2025 15:27:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFKfc+CwTTko7PUDzzAEjFO/NLsQQpngUiYCJzqO3J/i7v0N/CccseGLon4AiUWc+ryJm0oA==
X-Received: by 2002:a05:620a:a904:b0:7e1:3b7d:d12b with SMTP id af79cd13be357-7e62a098a20mr559028885a.6.1753309672300;
        Wed, 23 Jul 2025 15:27:52 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad23bsm248520f8f.44.2025.07.23.15.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:27:51 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: andersson@kernel.org, konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 02/23] arm64: dts: qcom: sc8280xp: use dedicated audioreach dtsi
Date: Wed, 23 Jul 2025 23:27:16 +0100
Message-ID: <20250723222737.35561-3-srinivas.kandagatla@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=688161e9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=-ddZ981MevGtOgwbEi0A:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: TYBKyDuZeSvQ2HpoqwCIVrr4oQPyKtZY
X-Proofpoint-ORIG-GUID: TYBKyDuZeSvQ2HpoqwCIVrr4oQPyKtZY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE5MyBTYWx0ZWRfX8wlI0RjVcPW8
 Ud+SeFstDXbq9651s7bvirXYTwu18i2S0yc/iyP5v4TVxKQPX3NtzFzmARtSk2thT5H8BBgLiKI
 sPFg7obnPA7GGo/SzI2eCsbDlgNGmZM0X8wDQ2K+6KKzV90z3roxgMPGb/Wp/b/K8xqRlDvpk2K
 d45UOfvutS43AXwDtIuJiDDrXjLdGIfaTLfJsL37LQ5tjoAbL7VlT3T/dm2ef3M/rPq1IHowzAK
 6UpLudayNTO8n/9Fi+JfUYGdETUKS29jT8fhdIBX4mxN19OdptS61RmJj+M/ZA6pPdyvn1gfkY8
 SuELy/azBo4g/GixcXKmhP0L/e8KDvNfz0R1f/R/bt8qVb7QBUETdgMMG3lK4QWyGPjE+vj/mwC
 1c1cr8I/r+ACUdXHVBRhxqLf+b3qiW4UU6m5ksdO13ttRuS6kaYY969l5G37IB/9qj0HOxh6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=754 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230193

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Make use of audioreach-audio.dtsi and remove the gpr nodes from SoC dtsi.
This move removes duplication.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sa8540p.dtsi         |  1 +
 arch/arm64/boot/dts/qcom/sc8280xp-audio.dtsi  |  9 +++++
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  1 +
 .../boot/dts/qcom/sc8280xp-huawei-gaokun3.dts |  1 +
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |  1 +
 .../dts/qcom/sc8280xp-microsoft-arcata.dts    |  1 +
 .../dts/qcom/sc8280xp-microsoft-blackrock.dts |  1 +
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 38 +------------------
 8 files changed, 17 insertions(+), 36 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp-audio.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sa8540p.dtsi b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
index 23888029cc11..56cb8d4e19ec 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
@@ -5,6 +5,7 @@
  */
 
 #include "sc8280xp.dtsi"
+#include "sc8280xp-audio.dtsi"
 
 /delete-node/ &cpu0_opp_table;
 /delete-node/ &cpu4_opp_table;
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-audio.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-audio.dtsi
new file mode 100644
index 000000000000..5472f59d4301
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-audio.dtsi
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#include "audioreach-audio.dtsi"
+
+&q6apmdai{
+	iommus = <&apps_smmu 0x0c01 0x0>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 8e2c02497c05..249f359580da 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -10,6 +10,7 @@
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
 #include "sc8280xp.dtsi"
+#include "sc8280xp-audio.dtsi"
 #include "sc8280xp-pmics.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts b/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
index 1667c7157057..0f3d82547a3c 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
@@ -19,6 +19,7 @@
 #include <dt-bindings/phy/phy.h>
 
 #include "sc8280xp.dtsi"
+#include "sc8280xp-audio.dtsi"
 #include "sc8280xp-pmics.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index cefecb7a23cf..c0842d5120fc 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -14,6 +14,7 @@
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
 #include "sc8280xp.dtsi"
+#include "sc8280xp-audio.dtsi"
 #include "sc8280xp-pmics.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
index d00889fa6f0b..2c0c1b54f916 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
@@ -9,6 +9,7 @@
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
 #include "sc8280xp.dtsi"
+#include "sc8280xp-audio.dtsi"
 #include "sc8280xp-pmics.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
index 812251324002..0f03b0ef97ad 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
@@ -15,6 +15,7 @@
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
 #include "sc8280xp.dtsi"
+#include "sc8280xp-audio.dtsi"
 #include "sc8280xp-pmics.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 87555a119d94..73d243c21958 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -16,7 +16,6 @@
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/phy/phy-qcom-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
-#include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/thermal/thermal.h>
@@ -2592,42 +2591,9 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 				label = "lpass";
 				qcom,remote-pid = <2>;
 
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
-						q6apmdai: dais {
-							compatible = "qcom,q6apm-dais";
-							iommus = <&apps_smmu 0x0c01 0x0>;
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
-						q6prmcc: clock-controller {
-							compatible = "qcom,q6prm-lpass-clocks";
-							#clock-cells = <2>;
-						};
-					};
+				gpr: gpr {
 				};
+
 			};
 		};
 
-- 
2.50.0



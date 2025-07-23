Return-Path: <linux-kernel+bounces-743272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAA0B0FCCE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956ED1888219
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6338327586C;
	Wed, 23 Jul 2025 22:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jNtdTFwv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8D3274FD5
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309687; cv=none; b=s9LE1vkOyhg82CtEYikfcxdLGJcIvLHSn7oBA0C6Pt4Q1YsrpLU7Jz8Un8WKfgZfYSAPTJPE0g9X0o7vmbvy2ZcNi7oDCxLf5Af0O34E0Z+QTz87KUSjGPpbv5TnLRA+CXWfDcd6YPtWmmDmPdVYYeOITyGiggJKCLkUGvSGsqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309687; c=relaxed/simple;
	bh=5IfQLskS0Jn3UK0ZpUTxI4rJLSCAb3mbM5urHpKXMO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXK1qlL/8wa4voFJ12gXsAzlzhKZwi7PpW+hJnlXsYTsTy5BGTuMzYcXyBTMmAOzmS5VndQRQCiLMJxjndToCG+m3Kt6YSQuqKReoKqa9XNEMovKEDdLJHz6kJfzm4YbVgbBtkqsDjPXEUgz66SCWtW8GbWshw+qkm7AQDoSLqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jNtdTFwv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NH67J1025883
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CAwCyznw1ti
	fR2eCEf/ZZcHhw4uQ6oQLdlE71ilLV/s=; b=jNtdTFwvSCuFuLsavNub4yYP4Eg
	vlfXZwzqkH7owc/Wbf1QxibhWvoB5vYM8/UNkw4qef1DtED7Bz67CQ9krmX2vRMS
	xE7KLy0qdIwkzZG/De/8xVHuylIeElptkIZzFeujpyiohVrrGj3eZI6xVl7HHhCp
	5AwYuqbLvmWHmWHQkA8OYlVW+pq9Tnw8J51+TNuQU/UKpXypjkqx+XwZU/2m9l+a
	mEHwIHpn/xnJj7hR7r4rm/7t1TBMwXuw0j0oNXwLSGvHS2AOSygaB/dQtQOj8jeR
	y70ZHjdSg//o4+hmUdBppxU6QivAGO6b1qd24JC/O2OuGgavKzeRE2SQy2w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482b1ud924-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c7c30d8986so104969885a.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753309683; x=1753914483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAwCyznw1tifR2eCEf/ZZcHhw4uQ6oQLdlE71ilLV/s=;
        b=ZY5vmJ0iZT5U95wwuj8MYt/E6JvzDKFIZO3eV9V1JvbmX/6nNZNb7flSKRWDwEyTku
         xEt7bxTr5G/xD5l9f1J2V6ESAON5iwa0FeVC/DauP0EbCrdNkp1bFQeF8dYMQJfBye3X
         sTX7fPCxWmO+WLzm5UdKCceVc/nm0DG9PgR8ZO2Kn5PVQ9+dg0I7kqKduP8qAAr11VuA
         pNMgcO+u+7ApRzPkVA7B3fi8sca2YWRp9QVqgO1RUStw4gOhrvfuKz5sXvJyL8SToBo/
         YXuJcNqC4q3jlO6fjwUWYzorHr+qw/VL4imcshfEYtcb6PpT+AASKO793PQBOEF2O6t9
         hx0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4UqiNhaW39LRxRbUTCTeiqNh85ALS1wbp2mmcy85PhkQtD28VvwBzweAXiN0VrqKk1oF8Lg3ASvvXtL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaPclI9q/N7+E5IcCxeJRSXDhnY2YTjqae0kax0PXBlp1uxPG2
	gPLG7bJ/cW4bJ6ymet7lQ1iJaUcLChLaiM/TK1tsL64aXWo9OlEiXu1xj/xwNmZOG67D0ZttzlY
	MJXPQUPvBWLZ2DJQ1pIPQyoE+WUNoNQB/QNd1nBCkxkvLub+P6IjCMreCn6QJwCOApHY=
X-Gm-Gg: ASbGncvPORtz9semtOF1E9xy6t+N8fXBmleZndGqTaVttwBMhbI93OrzRaca91+LIBy
	1/XZQauW79ZeKRvJez3MclubmU3upq/zOARvEElbt6MOvoYQxm53nVzGirco9O0jFhND8C2krxL
	J3ORcEzcqdhFGCzqY/2SVuBwEalVuygreHxehcHBNX63j193xmj9st1P2VjvsLnVIHgRjPxPnmY
	xxsDy6mOmfv2nE0KFqC9MKhEFMZuEYVnPWoWnUtL13sPJoBDYbTqdoD0K4VuIBBG6DxsRat6NZa
	LZgYetS/9e4MqtHsTLDMyzBBQh4X51G8NzwTWIbWyk11VozOc7LTAQ==
X-Received: by 2002:a05:620a:890:b0:7e2:fbf7:f2c8 with SMTP id af79cd13be357-7e62a1944cfmr440002285a.52.1753309683201;
        Wed, 23 Jul 2025 15:28:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9cFbe0eoXQC1HtpgCNLwKH7Z8oI9GtOC99caV95IrxYZN7SWj5L1yj2jt7U2yiVdCHkFJOw==
X-Received: by 2002:a05:620a:890:b0:7e2:fbf7:f2c8 with SMTP id af79cd13be357-7e62a1944cfmr439999785a.52.1753309682774;
        Wed, 23 Jul 2025 15:28:02 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad23bsm248520f8f.44.2025.07.23.15.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:28:02 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: andersson@kernel.org, konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 10/23] arm64: dts: qcom: sdm845: use dedicated elite-audio dtsi
Date: Wed, 23 Jul 2025 23:27:24 +0100
Message-ID: <20250723222737.35561-11-srinivas.kandagatla@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=LdY86ifi c=1 sm=1 tr=0 ts=688161f4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=ZxF_z8GhOwlPRV4PUNAA:9
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE5MyBTYWx0ZWRfX8sjGZSI8M+eH
 Uzy9h5FsYiXAwYYO+uGDEpASeaTihAc+dC1CIDUNs3hFQVUnyo/uis9TlmsLDpaS/6TkRnszV7f
 AQaWw6J8/2C+qtGkC1mbd6yFaaN3JSJMCMqkDU5STsPZTySo6Hkuzm686XqVb9UTDZDt9K6YyS9
 yxsdq2AWm74p/ST4djSqfyyrwMPihgJA77SVh/7DXSZa0199F6Xag45hEKT446vdpuGBIfygvKz
 mMzhnSY9uDLL7CkNtxKjd+phhmdPClefy8HcPoPrKiHwcVWr42DV450elQkMm7B5+HGAxSCJXD0
 Bbq4CsGY6JVHlO7s7x6+ensQVWb1kuyjbNg19oUf428eDi6IDQvVJ+aaKI+1g4IbH+UntrOEEKh
 qRF8GNMDQNIO8C2HQPVrM4P6Csaguvpm8Llo0szSn2RVqX5sW1MGAGM5WAH0WHYxRTDYqQox
X-Proofpoint-ORIG-GUID: bolj4J5g0wo8fR6vb15XGd-Fq8Asd6iH
X-Proofpoint-GUID: bolj4J5g0wo8fR6vb15XGd-Fq8Asd6iH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=985 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230193

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Make use of elite-audio.dtsi and remove the gpr nodes from SoC dtsi.
This move removes duplication.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sdm845-audio.dtsi    |  8 +++
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    |  1 +
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |  1 +
 .../arm64/boot/dts/qcom/sdm845-lg-common.dtsi |  1 +
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts       |  1 +
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |  1 +
 .../dts/qcom/sdm845-samsung-starqltechn.dts   |  1 +
 .../boot/dts/qcom/sdm845-shift-axolotl.dts    |  1 +
 .../dts/qcom/sdm845-sony-xperia-tama.dtsi     |  1 +
 .../qcom/sdm845-xiaomi-beryllium-common.dtsi  |  1 +
 .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   |  1 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 49 +------------------
 arch/arm64/boot/dts/qcom/sdm850.dtsi          |  1 +
 13 files changed, 20 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-audio.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sdm845-audio.dtsi b/arch/arm64/boot/dts/qcom/sdm845-audio.dtsi
new file mode 100644
index 000000000000..112da7e4e04a
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm845-audio.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#include "elite-audio.dtsi"
+&q6asmdai{
+	iommus = <&apps_smmu 0x1821 0x0>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index b7e514f81f92..4214210d38d6 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sdm845.dtsi"
+#include "sdm845-audio.dtsi"
 
 /* PMICs depend on spmi_bus label and so must come after SoC */
 #include "pm8005.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index b5c63fa0365d..20dae8a0d0ce 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -11,6 +11,7 @@
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
 #include "sdm845.dtsi"
+#include "sdm845-audio.dtsi"
 #include "sdm845-wcd9340.dtsi"
 #include "pm8998.dtsi"
 #include "pmi8998.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
index 99dafc6716e7..36bcaaa0f5b0 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
 #include "sdm845.dtsi"
+#include "sdm845-audio.dtsi"
 #include "pm8998.dtsi"
 #include "pmi8998.dtsi"
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index a98756e8b965..0a06f1a45978 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -9,6 +9,7 @@
 
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sdm845.dtsi"
+#include "sdm845-audio.dtsi"
 #include "pm8998.dtsi"
 #include "pmi8998.dtsi"
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index b118d666e535..88729fa88f8a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/sound/qcom,q6asm.h>
 
 #include "sdm845.dtsi"
+#include "sdm845-audio.dtsi"
 #include "sdm845-wcd9340.dtsi"
 #include "pm8998.dtsi"
 #include "pmi8998.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index d686531bf4ea..160066c89fce 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -16,6 +16,7 @@
 #include <dt-bindings/sound/qcom,wcd934x.h>
 
 #include "sdm845.dtsi"
+#include "sdm845-audio.dtsi"
 #include "pm8998.dtsi"
 #include "sdm845-wcd9340.dtsi"
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index 2cf7b5e1243c..824947d8f2e4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -11,6 +11,7 @@
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sdm845.dtsi"
+#include "sdm845-audio.dtsi"
 #include "pm8998.dtsi"
 #include "pmi8998.dtsi"
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
index a3a304e1ac87..20ef0f1e18b5 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sdm845.dtsi"
+#include "sdm845-audio.dtsi"
 #include "pm8005.dtsi"
 #include "pm8998.dtsi"
 #include "pmi8998.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index 7810b0ce7591..b27d6ded9d35 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
 #include "sdm845.dtsi"
+#include "sdm845-audio.dtsi"
 #include "sdm845-wcd9340.dtsi"
 #include "pm8998.dtsi"
 #include "pmi8998.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
index 63cf879a7a29..c7d3e68cae39 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
@@ -13,6 +13,7 @@
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
 #include "sdm845.dtsi"
+#include "sdm845-audio.dtsi"
 #include "sdm845-wcd9340.dtsi"
 #include "pm8998.dtsi"
 #include "pmi8998.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 828b55cb6baf..42638f47e9a1 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -25,7 +25,6 @@
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
 #include <dt-bindings/reset/qcom,sdm845-pdc.h>
-#include <dt-bindings/soc/qcom,apr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
 #include <dt-bindings/thermal/thermal.h>
@@ -928,54 +927,8 @@ glink-edge {
 			qcom,remote-pid = <2>;
 			mboxes = <&apss_shared 8>;
 
-			apr {
-				compatible = "qcom,apr-v2";
+			apr: apr {
 				qcom,glink-channels = "apr_audio_svc";
-				qcom,domain = <APR_DOMAIN_ADSP>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				qcom,intents = <512 20>;
-
-				service@3 {
-					reg = <APR_SVC_ADSP_CORE>;
-					compatible = "qcom,q6core";
-					qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
-				};
-
-				q6afe: service@4 {
-					compatible = "qcom,q6afe";
-					reg = <APR_SVC_AFE>;
-					qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
-					q6afedai: dais {
-						compatible = "qcom,q6afe-dais";
-						#address-cells = <1>;
-						#size-cells = <0>;
-						#sound-dai-cells = <1>;
-					};
-				};
-
-				q6asm: service@7 {
-					compatible = "qcom,q6asm";
-					reg = <APR_SVC_ASM>;
-					qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
-					q6asmdai: dais {
-						compatible = "qcom,q6asm-dais";
-						#address-cells = <1>;
-						#size-cells = <0>;
-						#sound-dai-cells = <1>;
-						iommus = <&apps_smmu 0x1821 0x0>;
-					};
-				};
-
-				q6adm: service@8 {
-					compatible = "qcom,q6adm";
-					reg = <APR_SVC_ADM>;
-					qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
-					q6routing: routing {
-						compatible = "qcom,q6adm-routing";
-						#sound-dai-cells = <0>;
-					};
-				};
 			};
 
 			fastrpc {
diff --git a/arch/arm64/boot/dts/qcom/sdm850.dtsi b/arch/arm64/boot/dts/qcom/sdm850.dtsi
index da9f6fbe32f6..65fbcc644de6 100644
--- a/arch/arm64/boot/dts/qcom/sdm850.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm850.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include "sdm845.dtsi"
+#include "sdm845-audio.dtsi"
 
 &cpu4_opp_table {
 	cpu4_opp33: opp-2841600000 {
-- 
2.50.0



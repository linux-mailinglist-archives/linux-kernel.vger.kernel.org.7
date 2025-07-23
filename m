Return-Path: <linux-kernel+bounces-743278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55848B0FCDB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D811CC2E30
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000EB273803;
	Wed, 23 Jul 2025 22:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z6NPux/N"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762D62737FC
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309694; cv=none; b=KZI533521Bk7grZ/kNAmZBx6v9fSrbzdS1wQTTbTfu2XaM35COmYG/y4C1gVHFupVyNQMz3284g4uGdaRrqhOZWenfpzrYlLOEgvK42Tuw9bchc2UIxv0tWv0QOzw6p79+hoCwSDuioTaatVvl5y5AfIhWGKThWgObHa/ZfR0cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309694; c=relaxed/simple;
	bh=89IdTGEl1KJByV3edAjJliFKNNYIw95TE3HPTPmOzts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ad4JcIobMuVZDNxRQxFTjLhyipHpwseUVMU/RC/Y64un7iH8GYysZNuAnY6z+69aUbraoWUo3RsNcm7O6hB1ffsfWMZTO2lCM4ig9pH86TISraNfKMcPtjHmByVstEPYPmIKU/BUkvVTm5YCQZO7Xb70lgFXb6hQR7e7eGu0BGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z6NPux/N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NH2N5G008047
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=k1140a+9O+2
	Qu50wuXuNC/h7aX5fpByKtVu2W2jNbBs=; b=Z6NPux/NB+95gIx9upFI8HQ+15V
	L1koxhr7S85+R6KjDre+FrWOGcYuicsKmPIUGQ52uz0k5xn4HbFTeT8BtBKvTL27
	S9pW9oYM0k7stSV+4fdEwbn3zXMqUYVsz4Vscb/tSwp39KZos4/yVmaqxFKGiaNj
	rBU0BZSVUHGGwrqWXM29nG4oXKY9iWAdLYLZ6pmoNX8KB8vSpa8V0iMaJGLpXy2c
	uCbSQwxQoAii6O8k05zNiIn73o2wzx08Vn8Iv7VW28fiJzLA0v9wvPk9gPrBEStB
	1RaN9Rq7uBU+UgT0bDprhADBTs+dxbGexa+uSgDAQLFtigWx9qTub52unrg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047qephx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:10 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e03ac1bf79so28345085a.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753309689; x=1753914489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1140a+9O+2Qu50wuXuNC/h7aX5fpByKtVu2W2jNbBs=;
        b=uxfU+IVW3t8tKu+eAz6tGPEmGg1WH5ICdU+ycRrqP3RVYID43sY+RVMuVfsj3Zeobd
         oqjgqxFnZHPA2lSpt5/vgoVvh7GIask0Ci59LGafXPxhwufi3pc4STFTJSCnmF641p6k
         Ez+SQbxc/j4+LHkb99EJHSM/7Ey9yHFZsuDoNzhG3mnmbS9TZ+h0sSbrX3pr3BBK+vnW
         AQlZcXkXg052hNszKkZIHXNfjK3z5f2F94fmNkGQV0z6YTxVqgml5h2y4XVZfTl1KGB1
         anbixMBhcGk0qwpUCtvFAsitnEU7oK5qyXFLMrn9A8aaLN/pZdU2EzKde3VwZHoSgNpr
         b9fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa3SkFrVSDsiLch4cf8fWIaK5YkFTyp26FcMTVWqXV02oGXlZCtheFWW/zCQ82AJ+lbMEtVGwcRAb6t44=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqCbo+LUoJsdzmvE6EqcKMxvMhCTr64s58eIfIrnxbrqsLqJjB
	M/j+M3RDHH7wvmt7NticoHXWM7W4LRk/Do5HgVr/6wUdW3TtGFGUt3kB/3SPc0PmQdN9KLGFA2s
	tUSMzj94TiaqVQQK94s6NEO4hKcMdhBf535uMULDOfdHEqwi+NwRNr471QNkXjlZ4//A=
X-Gm-Gg: ASbGncvN2y7qYOSSJWhN6gbcE7ab1gG25SRDr2C4Vy4BA/KeI0lkpWjjCxNOv4+6/aN
	OTv44b7k8vcQRp9RU0FwvUOK/eGh42MkSW/QMC788i+OcoYomDpO5Vm6kMh8LtbqYejxFEPx1lU
	vSDb5pTA3Jxkm6mLGZzBm2U5q7ADYKGtDc1ovL57xw+Dh7EJeCHgPTlrHVvWNyo1m4kwpQHh9NZ
	J4E/6zMbEKdCBKx5nmKWJ7OSJO63IywO5PKGVxHEWhfbFaayiDWhUEReLXRMN8t4a1WvBfBrBWN
	XW/w2Vcrl60t0RodIlkLrX1S06B6iVfSF6hKZZKKw7XbUQbuUN7fjQ==
X-Received: by 2002:a05:620a:e82:b0:7e3:3894:112f with SMTP id af79cd13be357-7e62a17607cmr484604485a.42.1753309689295;
        Wed, 23 Jul 2025 15:28:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyfHbo3ZkEJOh6+0ceiCSgzdkkDR2pY17H1wQulirVUvpTPanhXji2zAV+s1xUIjYIzSC07Q==
X-Received: by 2002:a05:620a:e82:b0:7e3:3894:112f with SMTP id af79cd13be357-7e62a17607cmr484601285a.42.1753309688692;
        Wed, 23 Jul 2025 15:28:08 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad23bsm248520f8f.44.2025.07.23.15.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:28:08 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: andersson@kernel.org, konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 16/23] arm64: dts: qcom: msm8939: use dedicated elite-audio dtsi
Date: Wed, 23 Jul 2025 23:27:30 +0100
Message-ID: <20250723222737.35561-17-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE5MyBTYWx0ZWRfX63h1hotepmAF
 5v3SGTX1s44LhSMoDXC2AZ9VnsJYk6KZyrZnXDeYI9iMIYvdh2sLEKd+LFA/uECMrK+mDgIjE7Z
 XDah3206YXWuKIY4k1NdBcZLxqor2JiCeUlkrUMdBMOkzjUr9/SE78/2ovSNlS4lY3myLcuoGXz
 yiIWZLZTmi4cEpmT0NaFZyH/ywkWwMAizVfHOLCvKrGGi4IUkmHpuLGPSNKELKU6st87qUMzmp6
 fPW7bdH9n7LNZdckTCF21MJaEBXUtTZIc2F7lAHvk1DlqCPb2wRq6LPWmF/1XyrizU2TPD3+tgH
 9aBKcg5xhPCSKAhu/KSP4MKB1HxPV4YjLMuYNHW+lrldy47shXerdMN5ONGrftf4WSQdi2JQBYp
 57JdCzGjxlF6FgGeFTm163upCe+JCw1qFLSuGljU5ZB1+rWQQp59sj2zD/wGPfC0oCPKizxn
X-Proofpoint-ORIG-GUID: OJCVuNmiGKHo4c9pA-wKD4vDvgx7DejK
X-Proofpoint-GUID: OJCVuNmiGKHo4c9pA-wKD4vDvgx7DejK
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=688161fa cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=RbKoELg_0CB1znD9PlQA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=660 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230193

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Make use of elite-audio.dtsi and remove the gpr nodes from SoC dtsi.
This move removes duplication.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/apq8039-t2.dts       |  1 +
 arch/arm64/boot/dts/qcom/msm8939-audio.dtsi   |  5 +++
 arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi  |  1 +
 .../qcom/msm8939-sony-xperia-kanuti-tulip.dts |  1 +
 arch/arm64/boot/dts/qcom/msm8939.dtsi         | 44 -------------------
 5 files changed, 8 insertions(+), 44 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8939-audio.dtsi

diff --git a/arch/arm64/boot/dts/qcom/apq8039-t2.dts b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
index 38c281f0fe65..1d1bd9273325 100644
--- a/arch/arm64/boot/dts/qcom/apq8039-t2.dts
+++ b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "msm8939.dtsi"
+#include "msm8939-audio.dtsi"
 #include "msm8939-pm8916.dtsi"
 #include <dt-bindings/arm/qcom,ids.h>
 #include <dt-bindings/gpio/gpio.h>
diff --git a/arch/arm64/boot/dts/qcom/msm8939-audio.dtsi b/arch/arm64/boot/dts/qcom/msm8939-audio.dtsi
new file mode 100644
index 000000000000..fe17bc28e825
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8939-audio.dtsi
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#include "elite-audio.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
index adb96cd8d643..1ba802037989 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
@@ -9,6 +9,7 @@
  */
 
 #include "msm8939.dtsi"
+#include "msm8939-audio.dtsi"
 #include "pm8916.dtsi"
 
 &mdss_dsi0 {
diff --git a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
index eeb4d578c6fa..cf55b854b7a9 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "msm8939.dtsi"
+#include "msm8939-audio.dtsi"
 #include "msm8939-pm8916.dtsi"
 #include <dt-bindings/arm/qcom,ids.h>
 #include <dt-bindings/gpio/gpio.h>
diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index 68b92fdb996c..bee5fff2a80e 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -1638,51 +1638,7 @@ smd-edge {
 				label = "hexagon";
 
 				apr: apr {
-					compatible = "qcom,apr-v2";
 					qcom,smd-channels = "apr_audio_svc";
-					qcom,domain = <APR_DOMAIN_ADSP>;
-					#address-cells = <1>;
-					#size-cells = <0>;
-					status = "disabled";
-
-					q6core: service@3 {
-						compatible = "qcom,q6core";
-						reg = <APR_SVC_ADSP_CORE>;
-					};
-
-					q6afe: service@4 {
-						compatible = "qcom,q6afe";
-						reg = <APR_SVC_AFE>;
-
-						q6afedai: dais {
-							compatible = "qcom,q6afe-dais";
-							#address-cells = <1>;
-							#size-cells = <0>;
-							#sound-dai-cells = <1>;
-						};
-					};
-
-					q6asm: service@7 {
-						compatible = "qcom,q6asm";
-						reg = <APR_SVC_ASM>;
-
-						q6asmdai: dais {
-							compatible = "qcom,q6asm-dais";
-							#address-cells = <1>;
-							#size-cells = <0>;
-							#sound-dai-cells = <1>;
-						};
-					};
-
-					q6adm: service@8 {
-						compatible = "qcom,q6adm";
-						reg = <APR_SVC_ADM>;
-
-						q6routing: routing {
-							compatible = "qcom,q6adm-routing";
-							#sound-dai-cells = <0>;
-						};
-					};
 				};
 			};
 		};
-- 
2.50.0



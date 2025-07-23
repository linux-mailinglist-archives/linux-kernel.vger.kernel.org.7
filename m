Return-Path: <linux-kernel+bounces-743279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33642B0FCDC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED5F47AE81D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB5D27C158;
	Wed, 23 Jul 2025 22:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pa1z+XlF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62634277808
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309694; cv=none; b=tpZush2mZAQfuiv5CreKvpKYnGJxM1xWL4mjVkCIAHe/7r7TnTCMfxrkusSrh5rENh2o7Z/bbb87H+1zaVTjsdQO7b0xjDmGQGPQ5SICDBYeJIxCP0cxZMiumyFk6FoMZB4Q7ff554HRVJQhi717bXHvU1/chVofv+xPbIF5IXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309694; c=relaxed/simple;
	bh=GTx0R34kmYLckUM6hD7bROQSiA83rmJbxJ+uDK2+VeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSCAddtFQIVUXgVZTDzcDXZSVkEvoOBTi5LcYH7FQFRwiDDPDgRHRzYB/JaQ56v5ROcJ/gDaMvlEk7YXRf405t2hcVLtLxnXllFLnJsB9AHdhL/W4xFv/31hHKxAE0iDtr0drlTXFsyoARskPrvzsANIS0So+BvUO5C9Tu5+0/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pa1z+XlF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NGnw9r005629
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jNSvi1s7GSx
	u/l+ptgOXt6oOk6eqxwdm7dV/maAE0Og=; b=pa1z+XlFD2bj3L4iACotsyBGch/
	tRCOkevYYRSXyiJRmxFJHOewcOoUCB4iDZ027QqIwpSEWsAh3I6m+C70b+unzlg8
	kdDtFq/SOnBs85b1vSSb4iqwlc6QXGVoFaX8zcermMEIKYcLyULCmoRQf2Ttgc8C
	iO0z43VtWwffI5jjiHppj6iUZHFeaHtI/vXnNm0hJw4xYX/YU6k6zEiIQZoQdvoU
	QAW2LhkFy97aotDzN8xKWGGqUmUnM0MMhYKyX4uCWove90TxbSo5Cj+lCTVYxY9p
	Xq3B0xfBOuBQ6IIcdlZCUqP44E/h+Dslc6BAaWeLr0jUmPOayqJmg2C+2rw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482b1ud92u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:11 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-704b4b61d10so8397946d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753309690; x=1753914490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNSvi1s7GSxu/l+ptgOXt6oOk6eqxwdm7dV/maAE0Og=;
        b=POQna+9pNMGMO70fLPuSipe5xCbrdrSkrKiazYhOUZdZGJzS4TYKqfHZMnFNyzXT5U
         x4fISYRKJvnGUsAvV9tXIwkBSO0/6ijIHxVqfPOhXmGyenLO+IR3jEH8452HsY7LJj4T
         7AHhN3Fl185U2+stklsBGfedWyM1urQRI39M1UqPv6lAijsWzFRopVQlXL6bzYYSWO+y
         i9ZIw1KHBxl0TUsnP0kdWCI2PY+2z6+4+mZnUrB0ZjV4iIov8YNgaLoQbw/eGMo5PuQ8
         g2ZgimuCR9ZwUq6dCh3EdQSb+/fz86YIJUCPlsCkKBJ4+O4rhI6euCVBa7e4dJtPUmKo
         w8tg==
X-Forwarded-Encrypted: i=1; AJvYcCXCiTbqBLsD+HlrpVageGfLLk1G5L4CrLnA0Xmy6+iqxLb9b1ntEkwgxRhTfCt8RqsrxYvV1eFxfbkZmA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnGQEuYl5SLQUo3lTZw29FbDz4jYtqwVRV12BZMU/XrlTZ9NLn
	PDD/rkKDQct4Lyt1aHLvsQeKIzKgqzzWqg9F0ZTQVk8ep9eGQY6059qtOBb5/iKbx/+TR2Oj9rC
	GKNcuK5E5E/iekM8nrq/DBQE1640Uv6rs3VBRUbbTnS8AbmT+t2pAgrOHdLQLMspUkng=
X-Gm-Gg: ASbGncvHTKi64cDimKIPMW63hDeYJR1SMxxee+wn4hw0wnHEh+KoYJG65/MkpChGVyW
	th9ISNgsMI8+6YTa9+LDZr8FKMp3zGvenlcz5fhgodekLhSc6+QUD/+mP2TTtP2yG8/F++6ZQa5
	k20bKq/f2gaSXfHkKsL6xif+KRbZ4vzQd+EaDZATnUCgNl65MEzCK1I108Nhz1hEl5AKF9tIS//
	Rz8vxyibHcpM1sDjQRFVu1y9gyPpRthzkZBvtCLROKFBouB29DC0Hz2HpIYC9NHS8xbHJFyHPum
	oU/zofx2W83922JNri1R/WjxTLSnw1JhnCWf7ClgSP5kPNL5WqaA/w==
X-Received: by 2002:a05:6214:5004:b0:702:d6e2:5bbe with SMTP id 6a1803df08f44-70700489ffamr54695776d6.4.1753309690174;
        Wed, 23 Jul 2025 15:28:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGD/oWYvaahRgnoZPtDPg9sEqmV5hPKh9WjSqYXdbo/TqVqlXqA44uS//aAEl183mm78gj3g==
X-Received: by 2002:a05:6214:5004:b0:702:d6e2:5bbe with SMTP id 6a1803df08f44-70700489ffamr54695476d6.4.1753309689684;
        Wed, 23 Jul 2025 15:28:09 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad23bsm248520f8f.44.2025.07.23.15.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:28:09 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: andersson@kernel.org, konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 17/23] arm64: dts: qcom: msm8996: use dedicated elite-audio dtsi
Date: Wed, 23 Jul 2025 23:27:31 +0100
Message-ID: <20250723222737.35561-18-srinivas.kandagatla@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=LdY86ifi c=1 sm=1 tr=0 ts=688161fb cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=He3Dqnl9yZ_pUDwKbX0A:9
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE5MyBTYWx0ZWRfX5KfbwbOpcx0v
 v+Huo8TiG+wJf0M1MMZOHutpX4ks3evsqSYXNT7yVsexhzI3ov3pSFdmfWLhuBTgvtaKwpxSIeG
 ArHd2Hs36IajhiUs3litXaC7xu1t00rety+ENjvhv95kPnLZOkIqDXmi4RKVs7EtJi7mXsVdE2w
 eDdEhgLFPj8p0JRZclCgYrZzHDKtaiiCc2/W+7X4WKzC6k8uvrxVJNKRsqI7RRLzYicEm4O94sP
 K1WuXeRI+617+5zJA8SvwWHKHHEdHk+p9eo26TGq7hamRszpb7A7ZDMLmVhQWwLlWmWhkptG+1D
 1FcKZIUO/kW1R9jVgPQ8o/TESdaYgmWNkVQfINR5CupX+qkxd3iurK9GO8L538lmzU5gM0S/5kZ
 sEqCvI8sH73dYx1HrBNa/6ZSffuNf7+fY1cdGNKRTZOMRYpcvXOeCs1QVcWfOkP90cl9Xhpn
X-Proofpoint-ORIG-GUID: gM7haK4EuQkr0E8PYdViNUAU4dr9VUK2
X-Proofpoint-GUID: gM7haK4EuQkr0E8PYdViNUAU4dr9VUK2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230193

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Make use of elite-audio.dtsi and remove the gpr nodes from SoC dtsi.
This move removes duplication.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts   |  1 +
 arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts  |  1 +
 arch/arm64/boot/dts/qcom/msm8929.dtsi         |  1 +
 arch/arm64/boot/dts/qcom/msm8996-audio.dtsi   | 14 ++++++
 .../boot/dts/qcom/msm8996-oneplus-common.dtsi |  1 +
 .../dts/qcom/msm8996-sony-xperia-tone.dtsi    |  1 +
 arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi    |  1 +
 .../boot/dts/qcom/msm8996-xiaomi-gemini.dts   |  1 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi         | 48 +------------------
 arch/arm64/boot/dts/qcom/msm8996pro.dtsi      |  1 +
 10 files changed, 23 insertions(+), 47 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-audio.dtsi

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index 5b2e88915c2f..5693778dca32 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "msm8996.dtsi"
+#include "msm8996-audio.dtsi"
 #include "pm8994.dtsi"
 #include "pmi8994.dtsi"
 #include <dt-bindings/input/input.h>
diff --git a/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts b/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
index ac6471d1db1f..098ecd4561e7 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
@@ -3,6 +3,7 @@
 /dts-v1/;
 
 #include "msm8996.dtsi"
+#include "msm8996-audio.dtsi"
 #include "pm8994.dtsi"
 #include "pmi8994.dtsi"
 #include <dt-bindings/gpio/gpio.h>
diff --git a/arch/arm64/boot/dts/qcom/msm8929.dtsi b/arch/arm64/boot/dts/qcom/msm8929.dtsi
index ef7bb1ced954..14293ced4513 100644
--- a/arch/arm64/boot/dts/qcom/msm8929.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8929.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include "msm8939.dtsi"
+#include "msm8939-audio.dtsi"
 
 &opp_table {
 	/delete-node/ opp-550000000;
diff --git a/arch/arm64/boot/dts/qcom/msm8996-audio.dtsi b/arch/arm64/boot/dts/qcom/msm8996-audio.dtsi
new file mode 100644
index 000000000000..6322af1e40a7
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8996-audio.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#include <dt-bindings/clock/qcom,gcc-msm8996.h>
+#include "elite-audio.dtsi"
+
+&apr {
+	power-domains = <&gcc HLOS1_VOTE_LPASS_ADSP_GDSC>;
+};
+
+&q6asmdai{
+	iommus = <&lpass_q6_smmu 1>;
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
index 63ab564655bc..440a129bc899 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include "msm8996.dtsi"
+#include "msm8996-audio.dtsi"
 #include "pm8994.dtsi"
 #include "pmi8994.dtsi"
 #include "pmi8996.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
index d55e4075040f..1c0efae7db2d 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include "msm8996.dtsi"
+#include "msm8996-audio.dtsi"
 #include "pm8994.dtsi"
 #include "pmi8994.dtsi"
 #include "pmi8996.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi b/arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi
index 929bdcd45d02..eb092337f3a9 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include "msm8996.dtsi"
+#include "msm8996-audio.dtsi"
 
 / {
 	qcom,msm-id = <246 0x30000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
index bd3f39e1b98f..806bf0031d81 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "msm8996.dtsi"
+#include "msm8996-audio.dtsi"
 #include "msm8996-xiaomi-common.dtsi"
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index f91605de4909..bf99f1ce5768 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -13,7 +13,6 @@
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
-#include <dt-bindings/soc/qcom,apr.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -3576,53 +3575,8 @@ smd-edge {
 				qcom,smd-edge = <1>;
 				qcom,remote-pid = <2>;
 
-				apr {
-					power-domains = <&gcc HLOS1_VOTE_LPASS_ADSP_GDSC>;
-					compatible = "qcom,apr-v2";
+				apr: apr {
 					qcom,smd-channels = "apr_audio_svc";
-					qcom,domain = <APR_DOMAIN_ADSP>;
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					service@3 {
-						reg = <APR_SVC_ADSP_CORE>;
-						compatible = "qcom,q6core";
-					};
-
-					q6afe: service@4 {
-						compatible = "qcom,q6afe";
-						reg = <APR_SVC_AFE>;
-						q6afedai: dais {
-							compatible = "qcom,q6afe-dais";
-							#address-cells = <1>;
-							#size-cells = <0>;
-							#sound-dai-cells = <1>;
-							dai@1 {
-								reg = <1>;
-							};
-						};
-					};
-
-					q6asm: service@7 {
-						compatible = "qcom,q6asm";
-						reg = <APR_SVC_ASM>;
-						q6asmdai: dais {
-							compatible = "qcom,q6asm-dais";
-							#address-cells = <1>;
-							#size-cells = <0>;
-							#sound-dai-cells = <1>;
-							iommus = <&lpass_q6_smmu 1>;
-						};
-					};
-
-					q6adm: service@8 {
-						compatible = "qcom,q6adm";
-						reg = <APR_SVC_ADM>;
-						q6routing: routing {
-							compatible = "qcom,q6adm-routing";
-							#sound-dai-cells = <0>;
-						};
-					};
 				};
 
 				fastrpc {
diff --git a/arch/arm64/boot/dts/qcom/msm8996pro.dtsi b/arch/arm64/boot/dts/qcom/msm8996pro.dtsi
index b74cff06f300..1119b2e18df5 100644
--- a/arch/arm64/boot/dts/qcom/msm8996pro.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996pro.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include "msm8996.dtsi"
+#include "msm8996-audio.dtsi"
 
 / {
 	/delete-node/ opp-table-cluster0;
-- 
2.50.0



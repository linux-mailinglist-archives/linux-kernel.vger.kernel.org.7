Return-Path: <linux-kernel+bounces-743280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40962B0FCE1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12CA3AA4673
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AC1273D6A;
	Wed, 23 Jul 2025 22:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PWbQYUu9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064CD274FEE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309696; cv=none; b=GP7dnJwQ3ybdSEEcpFE7tVYmuGe6HzL8ODTZBPPKgkzuPmQayzejr+0m5WZo06XAYqMcqBY2LvirdLlU9iGLX7Zg5tws2Ke7eQrksnCT8DMKpikJ2eS6XjaSGBI/OTX2drohboVyX6qd4QjyqVzWvGJ8hUt1qcdgGQlJu1z/uSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309696; c=relaxed/simple;
	bh=uf2SvxSFUgilzw3JCPr59lPmRFUsX2OQLD1FLo+rWHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJRIlU2bI4qcDROHeoP5VknImd40rRbmhB4/tEt3ps+klV18q0iHaB36KxZHlK3DAQG4P4svO1Kie1E2izPFtw+8L3+pw51gJUDaKYcMsXpBAIN/tdsOO3rytMWKC88aqd6JbVO56yXytNoddZfCR/nz4XmCfrU+qlkVPWnHrR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PWbQYUu9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NH6lOr013723
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fb/YneAeDUu
	jai2oooeBHtgRqfio7LaYKhqkQgq7Gsc=; b=PWbQYUu9HYdmT2GTg+nK8n25EhP
	ZhNRT3I80kbQaXA+M4jNkdXB6cZW47Fd7MBpx5j8sCm67M5aY5m7cz4C64bjbCTz
	n3fXdbRsVBt3Cc++04Ta3FvBoF29+iuBqUbMGXpkvdYWP1nwf09tngnsEmbinMZC
	ZU4GkbSY7B3Yi3KGkvdvFq7L/AQoKooQ60aeLVeFrLlTRRfD/qzFgDTCw+l3AiBJ
	jRE3Nu9lFjFCKoVnesElomrXnPHE0mhGE1cqPtqXCzg4cWpSYoBiLnew+6P+RmEc
	oN6gYbVA+xR8jNkIpG4eQX86OH6YAKFvDu/t4O9Do9NDHNVumh/+dzdsVtQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048vd230-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:13 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fac216872cso7463376d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753309691; x=1753914491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fb/YneAeDUujai2oooeBHtgRqfio7LaYKhqkQgq7Gsc=;
        b=rrC29+k61VtyiB8/tJ1KplQdJ0iY4fIQnjUmVZw5U2gPGG3mHegcqFxTxqbSjxMU9Q
         Va6PQSCf63Pc8aAONXxfgT/famyv8ZOrAxwS7PDkMPs/ltsbB02XmQYcA0lM3HNgJAe0
         Gp9x/PI7jmSQQN7yW1Dip5hXrIQTMrJtv+ubVzSyjcgFrkumuV+m1NqEoRueJZiCHMyo
         YjfBoTrnYtxRQ4HfQoI6ddk+UFl3tqKzHACpVbKbcI0y8LzqV5rgdFMtRS1ZiQEjw6yK
         DR0CU1SpP+E3nTf0SiBNQBuAjk8ruUrQvqyelllDegGdXqQWYD8nNaHzAOZNtgir+Yvq
         tvoA==
X-Forwarded-Encrypted: i=1; AJvYcCVryd0JXNHEnTH4JY0sWIn1N2iSZUVU9967mQTUQUE+WrHYdLsZx/QH8x5Tity8PZYsqqxA+qKP+QD33Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW2uvyy6zjBrHQorm85VIculzzZ0BfYcEy6jxqiPijBkE/Pj74
	a1gG0nIQxoskB/iJL5kJLvU7ffhIRui+FE7IxDFBe3RXaGnawXHxEFUEs9VBI+5NdHUrCoJFMJE
	AUv0XWosvpbWc55wRa7YDvl9JdrlXRWq+afSYwST6TQzOnZbNX4iI01RDpKtyCVzqIgA=
X-Gm-Gg: ASbGncuuqIGzjhfm3JZDI3pCgnpGuPrchxKSYPCYEKAprovaYDurHSOEEU0LyUHOqcV
	i6HTmjJpTmXu7vSkYYnyC1XDqnsxdFO7XyHUceJtF9fiU3OV4WqaZ3PmfI8g9s7kBSjkVmjQ8m0
	mfG85a4UCgXpm3boi35LviAkL7cbsCOcWnJg/mVAvoTr0oCpnMVzRRgcHx7s1DUkJm/g0G0Bc3s
	nPTDZlcxanruR8U7zh9kwh9OWUsIFnfK53u6VIf9Fcbst+mFJCcuQZK/jjjIlfUWER6bKz5nn+8
	LcW5gLzMOMEJ6aDuKtuvRiLmPSYZGfaWU/SqNh3DYNF6s6r2+HAizw==
X-Received: by 2002:a05:6214:2022:b0:705:227d:a511 with SMTP id 6a1803df08f44-707006663edmr60475316d6.32.1753309691270;
        Wed, 23 Jul 2025 15:28:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLdeYPeiv/7I5VkqxxCHuku7Mvhd3JyalBaOqeJ6jwBLivMIUNE9FcPwVnIQcM+ygGsLnWtw==
X-Received: by 2002:a05:6214:2022:b0:705:227d:a511 with SMTP id 6a1803df08f44-707006663edmr60474966d6.32.1753309690706;
        Wed, 23 Jul 2025 15:28:10 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad23bsm248520f8f.44.2025.07.23.15.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:28:10 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: andersson@kernel.org, konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 18/23] arm64: dts: qcom: sm6350: use dedicated elite-audio dtsi
Date: Wed, 23 Jul 2025 23:27:32 +0100
Message-ID: <20250723222737.35561-19-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-GUID: 9Vyb0W65iDzRsDcT0_juqMGXfPzYOii6
X-Authority-Analysis: v=2.4 cv=SYL3duRu c=1 sm=1 tr=0 ts=688161fd cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=R7b-5tlmrD_1Gdgo1VcA:9
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE5MyBTYWx0ZWRfX/DuC9Kz+EhXq
 8dhCtTQNcKB55gMTDE3wox/Bxe9/Dy9MDkkIb1Jis39DkN0Md/lciiH6y6iO94zrRzdV3jJe5YW
 UAVjtnvfHe4+4Uy5pLlZgvPOIL0xt8TqV7ftYbzCCqO3onAShRlDTeQBdAbEHvf+PP4NVcr26Mm
 bNoY0nU/asQFlVZrUXP3DbkV3E9zXQN9nTMH98lqRGY9gD4vdbBWoD6EH4rLDQlvuOy1S6fwCII
 8VT3K9GFg8IAevZtVFPz9cqtbBs5kNgAJMqcUP3AVch8TihXjFlmrM431nNOTUjn6TjLGM98Ytc
 6hNYo+6U5wHfWTPxjIMG/3wycRlX/2TgHy9fdypKh2aFAS6TpYL0eKqjMCBMUPHQhEI1OAiCZZd
 DBHEYR7Um/vH9iR4B5vdq1aa0DHGK4DQ8WTb9CwbBCra/dYoBgXEhPpXIL7FZ1R4WRrTveqm
X-Proofpoint-ORIG-GUID: 9Vyb0W65iDzRsDcT0_juqMGXfPzYOii6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=765
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230193

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Make use of elite-audio.dtsi and remove the gpr nodes from SoC dtsi.
This move removes duplication.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm6350-audio.dtsi    | 17 +++++
 .../qcom/sm6350-sony-xperia-lena-pdx213.dts   |  1 +
 arch/arm64/boot/dts/qcom/sm6350.dtsi          | 62 +------------------
 arch/arm64/boot/dts/qcom/sm7225.dtsi          |  1 +
 4 files changed, 20 insertions(+), 61 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sm6350-audio.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sm6350-audio.dtsi b/arch/arm64/boot/dts/qcom/sm6350-audio.dtsi
new file mode 100644
index 000000000000..2ca406763e80
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm6350-audio.dtsi
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#include "elite-audio.dtsi"
+&q6asmdai{
+	iommus = <&apps_smmu 0x1001 0x0>;
+};
+
+&q6afe{
+	q6usbdai: usbd {
+		compatible = "qcom,q6usb";
+		#sound-dai-cells = <1>;
+		iommus = <&apps_smmu 0x100f 0x0>;
+		qcom,usb-audio-intr-idx = /bits/ 16 <2>;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index 8848043f95f2..224f769ee5c2 100644
--- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
+++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
@@ -7,6 +7,7 @@
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm6350.dtsi"
+#include "sm6350-audio.dtsi"
 #include "pm6350.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 2d891a5640de..94db1dbceace 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1322,68 +1322,8 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 				label = "lpass";
 				qcom,remote-pid = <2>;
 
-				apr {
-					compatible = "qcom,apr-v2";
+				apr: apr{
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
-
-						q6usbdai: usbd {
-							compatible = "qcom,q6usb";
-							iommus = <&apps_smmu 0x100f 0x0>;
-							#sound-dai-cells = <1>;
-							qcom,usb-audio-intr-idx = /bits/ 16 <2>;
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
-							iommus = <&apps_smmu 0x1001 0x0>;
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
diff --git a/arch/arm64/boot/dts/qcom/sm7225.dtsi b/arch/arm64/boot/dts/qcom/sm7225.dtsi
index a8ffdfb254fe..860b19440c54 100644
--- a/arch/arm64/boot/dts/qcom/sm7225.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm7225.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include "sm6350.dtsi"
+#include "sm6350-audio.dtsi"
 
 /* SM7225 uses Kryo 570 instead of Kryo 560 */
 &cpu0 { compatible = "qcom,kryo570"; };
-- 
2.50.0



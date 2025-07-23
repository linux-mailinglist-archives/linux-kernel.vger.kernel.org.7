Return-Path: <linux-kernel+bounces-743268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEC2B0FCC6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50883B8EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9F82749E1;
	Wed, 23 Jul 2025 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QPMt0xAA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D634D2741DC
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309682; cv=none; b=HctEa3qOODs1vywWufe3hi1z44RjIzv/BchwhMDNGqEstPAjLrtNuSCkH5cd/XTRYbwE0GBYWmNebqA11wznsxkIGpyOWuNXLsDHd0LbrQFlqScQDCtk7dh2BLOcXigksf4oW7o/rNgfwuk6gAXjww3s/SfIKRzKtovqc6LpxN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309682; c=relaxed/simple;
	bh=DSNhzTi7DTHZSvCHu4rHl48K3anpGJND+T6PsNo7mgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UB4iiDMXWuilgVAB4pJgLhjGTIZ984BSgHS/qm0lfm93Zb9pZg+IGziYu277t9rj7J0EBWuf2b5j2bHgcZ+KiDb7c9rq0ForwwRysQfunML/sgGDpDRNAZlTwzb2z1notpuHZ1MHBd9p9xCP7RkObtMHpC8EsW5s/vhcqdJEgWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QPMt0xAA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NH69PJ023489
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ijdsQb+qWQR
	gBj7piRCjrWJt5D+1ItgSZV9B4FY1NUQ=; b=QPMt0xAAKJMO1lS3QfuYZWmsFK9
	dwkJny0BZWLjlakcFzNYACLFhKzvLzree2V+vh4F1GimCxGHuqF+0z+rL2uP300R
	7IxRfeh/uJm0m2g0EidfR6RQDNnObAPJ+ublV/hPG8nzDewFlWa7mEk1Ah3BSFq+
	tq5lm3DCw3tvVPCD8M1t9S9FeUHBh0hINw0QtFrW2XKFkgpu2BVw/zWho3wvrbSp
	DCfVgpdXPnIyUSGXpKkQeJRu9cV/a9XZtJCyHrrWMf5eveD6Lc3QE5Jn9aj0Rprc
	4p+ou+JOVCppnO1xydGeDa0u+xDxnqkxpzydH1Qm2At8zM4y0Fb6FN8tehw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482b1ud91e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:27:59 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-706edda34f6so5658356d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753309678; x=1753914478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijdsQb+qWQRgBj7piRCjrWJt5D+1ItgSZV9B4FY1NUQ=;
        b=rdjyfLSqjtIWQAHPJrmz+7TDlfocFgpVrjTJAOCslyeUBtKSySwvNaBYHpKq614yOM
         CIbTLgGDd0kwYc2+gp7cGclqylX3y9VMmO/QOsu0iVHWsSM7MlscVYPSYlKNWKBjK2Z4
         uPW+6w8Uw/4+jU0atxkrMYt6DXgSQCu4GOC3XcuMeyraxiQuJLkaq9LO+aClSQOODkSV
         vlgWZCvxnlbz28iVQD6u5O+WD7UjPIzL6LWrQf6TgAhh63eHpe5bcW733Zi0pgSPmPBX
         xhtB+sruS/SNNsL11GMnd5uee3axMLaQd9EjEtdxkCBIIyx0osHVpXdnFsHbmDedwOXj
         kx/A==
X-Forwarded-Encrypted: i=1; AJvYcCWd06f2Z880gC85QgED2H15y7mXkzCvnvgE4JilUIdGVDbV4bBuFqH6Zo5dZsKRf4J0PYzNs75n/KLGDTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBYHh+adUpv31f5gNQeuWUnkpNb+AOLwwOs9B2jhoRRwEp6rZh
	a+9Ap3fhqudmvd2gtoixJZr5oVozhmon6gldkRH0x9ZY7d8kAiqwM/99S6dcF8CRn7I42zMnwR4
	MUzEXK84GAGqICg7axnFSCWTkuBCN284l2FuNIEDSzG8zmM4M+ITrEkaFh0eORTr3SNA=
X-Gm-Gg: ASbGncv4FDSm1ge+/ndIyfr7ptNLErwP9asscuytUAX3C0RoX/Ha8ndttBwgAztUDVy
	KuJVnLZHcuTV1IYbQpeaMV5Xjx4Zvw2qk5s34NEySRXZjr3TvGkTHU5yodQo90vip+PTJxxvbIN
	wWuHpIOyXlnsy9PD5xamc9M6F7bsc0BdVAZZGX3QEsupuFWd/gBL0+iRq+HkMbIzKP/sSri8kIF
	6VdBt8lfnbatoN3Jy4k40QPoT6ADdAoHVFlqEl9f4GyKzuwpzuvD8s1GhPwqXyfDl+0Lp0C47xJ
	mgX3LHztL1hFsnPlceEWc+DDEkVrZ6edbUcW2XTFKGbV9kMpU8rrLA==
X-Received: by 2002:a05:6214:767:b0:6fd:cfe:ebab with SMTP id 6a1803df08f44-7070058cc6dmr70151416d6.7.1753309678379;
        Wed, 23 Jul 2025 15:27:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNob90yLrs2IMzxzG+kHiykrssTZW2bRzfVsXcr8N5We559q29qr8BZTKTVG30hf82+ZzDiQ==
X-Received: by 2002:a05:6214:767:b0:6fd:cfe:ebab with SMTP id 6a1803df08f44-7070058cc6dmr70151106d6.7.1753309677899;
        Wed, 23 Jul 2025 15:27:57 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad23bsm248520f8f.44.2025.07.23.15.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:27:57 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: andersson@kernel.org, konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 06/23] arm64: dts: qcom: sar2130p: use dedicated audioreach dtsi
Date: Wed, 23 Jul 2025 23:27:20 +0100
Message-ID: <20250723222737.35561-7-srinivas.kandagatla@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=LdY86ifi c=1 sm=1 tr=0 ts=688161ef cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=kZFr1r1NR6a6C5-aafMA:9
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE5MyBTYWx0ZWRfXyTBPOEg82QGw
 tu4NILWPheCzQ77YC+poYMEifEWPcF2sr0wESZsY+K1oeXcVUx+opmheC6wWrqFVROBezkpC0ij
 hN6vsRIQ1lynOKcqWDxpw73HmycZO4Vlb1fK70EOGN5BjKGzcaA7B74WBHTLWJEVG8s8jTS74+k
 86CLm6CbHFOCl/Bse1pGBhFDaYh19HEJGz+HFMk8MtOi1kxP99SR4sdTUqmGZ6vCm5UNFRfUhOE
 lHQgjLVI0cKuc75E8h1g2OaF4rcwZF6dBj6MUaUHCUbUtyUs5KRkxz4sYqLUBgLW97o6rxIJ/0G
 mYabkQ3rTnVYhMwZIdnOaG1u//uD3F+BZEcJNimlnXv7RMkJsQWsHEg4AtDnMvdORySEJJGklVh
 uykyJXNvy8d5GlNPHYyefi5gsQxd/lBqsyAJJEDhDyriDhcdfTOgMhbfjxdqlmWKkKuiHe3r
X-Proofpoint-ORIG-GUID: oX8M8-c8QEzjGTQJfXbA6KViPJ13x1Bn
X-Proofpoint-GUID: oX8M8-c8QEzjGTQJfXbA6KViPJ13x1Bn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=625 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230193

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Make use of audioreach-audio.dtsi and remove the gpr nodes from SoC dtsi.
This move removes duplication.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sar2130p-audio.dtsi  |  5 +++
 .../arm64/boot/dts/qcom/sar2130p-qar2130p.dts |  1 +
 arch/arm64/boot/dts/qcom/sar2130p.dtsi        | 40 +------------------
 3 files changed, 7 insertions(+), 39 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sar2130p-audio.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sar2130p-audio.dtsi b/arch/arm64/boot/dts/qcom/sar2130p-audio.dtsi
new file mode 100644
index 000000000000..1478326594ca
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sar2130p-audio.dtsi
@@ -0,0 +1,5 @@
+#include "audioreach-audio.dtsi"
+
+&q6apmdai{
+	iommus = <&apps_smmu 0x1801 0x0>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sar2130p-qar2130p.dts b/arch/arm64/boot/dts/qcom/sar2130p-qar2130p.dts
index 74778a5b19ba..b0db8e48a13e 100644
--- a/arch/arm64/boot/dts/qcom/sar2130p-qar2130p.dts
+++ b/arch/arm64/boot/dts/qcom/sar2130p-qar2130p.dts
@@ -8,6 +8,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sar2130p.dtsi"
+#include "sar2130p-audio.dtsi"
 #include "pm8150.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sar2130p.dtsi b/arch/arm64/boot/dts/qcom/sar2130p.dtsi
index 38f7869616ff..b0f0408ec901 100644
--- a/arch/arm64/boot/dts/qcom/sar2130p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sar2130p.dtsi
@@ -1,4 +1,3 @@
-// SPDX-License-Identifier: BSD-3-Clause
 /*
  * Copyright (c) 2024, Linaro Limited
  */
@@ -17,7 +16,6 @@
 #include <dt-bindings/phy/phy-qcom-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/power/qcom,rpmhpd.h>
-#include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/thermal/thermal.h>
 
@@ -1622,43 +1620,7 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
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
-
-						q6apmdai: dais {
-							compatible = "qcom,q6apm-dais";
-							iommus = <&apps_smmu 0x1801 0x0>;
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
+				gpr: gpr {
 				};
 
 				fastrpc {
-- 
2.50.0



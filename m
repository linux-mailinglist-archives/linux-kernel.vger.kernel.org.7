Return-Path: <linux-kernel+bounces-743271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BC5B0FCCC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF285873F2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151E92750F8;
	Wed, 23 Jul 2025 22:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PiObdMZw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86946274B4F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309686; cv=none; b=tj/XU8adjljjw7L4DF/3x+Gm1xWPu45UJnAmYs63LQqeQHN02LdJz+D/xR+YbZOcy/lQZv5bKH3b+DpKfP/Ss/ZOaUlkUJWfYn0tkHjOjVTsmiasrp3UzwRDiL/Lp8QkD7+CYABKebIfFQ95EKsezZ4xHR1WHQDqQ3kyM6PAWAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309686; c=relaxed/simple;
	bh=u5YnQTCt8dVSb/Fugq9BHu8/dHungUrT8rTY9TBDuw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dl89L9xJ88r6pckXCoi4EeH9PLk6fMQ5+kdXIA4KFle1Yq6EdjBhN0baoJ9/CiDfdP633iUb9eUhDCfh5o27zXg0uO3C4xqlzH6/CoRdfwlVXOdGWfDnAQPNlBww0mqRB1Z73nh2ffwkW4gTKxZvISOdiOQn3HLnIGVjPBARmew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PiObdMZw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NH8Cmg008986
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=5ftBTXL9LYh
	4w82ALN9D5Q1Okarhm8+FZmAriFPFydI=; b=PiObdMZw8FadvApD7FHOOI1j2G2
	zhqs4ifQv3MGDoymwI1OHMCw/zU9KHjnq/yGY3uRVEuMNa2MjASmMqQYjC+fjZFo
	shYIqZG6J8p+VfHNDC+97vd7tqQz9/mhSqMcgH5PE/Mvg9JZiP89pu3JidhCe09E
	ejXiN0XZ1x4KD7z091hBvEXg5MbAK3XP+0NdOUqHd1DMW7FRAxlqa4l5DsWMDM62
	0Pe0Ym4xtnxDPNZVg183pedT0//7k4ZyXWtfaoczTj/mnfxMuCTTYdghgZp7Uxei
	KAGkpW+fNSMeTcDDNBrT5QUcJrMVzSridCceDsVwuoCK7h2fK7Sm2iPZemQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048vd21x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:03 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7070970cb2aso6387076d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753309682; x=1753914482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ftBTXL9LYh4w82ALN9D5Q1Okarhm8+FZmAriFPFydI=;
        b=PQlBahdLNfAS3uKZpMXH185sPQogQnxmqfyPeltSiEZZ6DuLyfbpzCZQHmrPcw+vZ6
         MUVJ2aAg8fniSEXbgpI31AaACR2shxcw6C2MlatMJ1QoX9qm7TyvjE/UXyuoT5U/zTqI
         3NkH7jCZ0EsqV4hY1zCT78ikNzCu/sWkaTOgR7yo1e+obdkjKIN2UnouYPbvNZcZhpbD
         ikC1mdxTT7dI/GdQHW+uUWHBjAmF9lK6qGJMjN88YwbdmeTldzqux4CP1MPeIpRcgRWr
         THkks4bAbTFohgVKE5bdOTeN94vI9h6mEOxr6Vc4tud2/ctGzKUsZM4dvAUqMkDS8xie
         +NpA==
X-Forwarded-Encrypted: i=1; AJvYcCX27IX1IPHfCuD5PUI34/bF5JC5949V6D6THtWoWdco9cgHgCZPmkInJhPGOovBRMjE9IjK848QQWYlBx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYRGyrt3zKZK/MvO+Y04TSkGUd7lDmYrV8ab+VeBiJFNfAbWbo
	/BVNZkKImMX30ER7Svx8XuNsbE2xOPAd1JSqcCkq8JhY3eXrfi/M8O0cv5GDuO3jJu0FBX2ilYZ
	pbqfR42ex64d4cid1r/Q13WDSc79HRhoo3ZVZcPMPPISZsassYd4Q9b8TjGDHc8Q6wyA=
X-Gm-Gg: ASbGncswoGmiqV9wyd8meSlBokBS3TZNziyMTZRYWZkq5JpJ0Czha+GekZKxZH6GaJN
	B2y7QDO7d8ocBjT0zdWPzSzJBJN17BRP9jQMq1LX2GYrxLsldwg2Wf42qknjONm5cDQEmSrhYkb
	SdLhym/z0rkcnhNn3Uvq7lnhD62baO6bswBiZKQ1NzbsUHUGP4pArXqXPG8h4zVwMyviL8VEvZa
	Z2GxKnKrMu3ufeGkffkNulCGI8df2zdr9hlkLTNTHFMChYejULcfXyhZs8N3KGw+aorG/f0W3NS
	Uhc92CPAdwlx2SAAyH6A7RvlHtOvpfNPOoEP/ZW12CwjbF06rBWv9w==
X-Received: by 2002:a05:6214:4115:b0:704:b906:eaa4 with SMTP id 6a1803df08f44-70700736c73mr71555126d6.37.1753309682218;
        Wed, 23 Jul 2025 15:28:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNLAHZ8fpDxJ7lJK4dFDOw2FUpqvS5WNssMuZLaUDjr+J/WR6798RpyyA4BQnkgiXAuhAs8w==
X-Received: by 2002:a05:6214:4115:b0:704:b906:eaa4 with SMTP id 6a1803df08f44-70700736c73mr71554856d6.37.1753309681719;
        Wed, 23 Jul 2025 15:28:01 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad23bsm248520f8f.44.2025.07.23.15.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:28:01 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: andersson@kernel.org, konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 09/23] arm64: dts: qcom: sm6115: use dedicated elite dtsi
Date: Wed, 23 Jul 2025 23:27:23 +0100
Message-ID: <20250723222737.35561-10-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-GUID: pQEOYimuMjzWb0q4a4f71MCO5lH7S9XJ
X-Authority-Analysis: v=2.4 cv=SYL3duRu c=1 sm=1 tr=0 ts=688161f3 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=h0svG2ZG1csubjrOInMA:9
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE5MyBTYWx0ZWRfX05jOm1p9Klq3
 zjEW19fR0/ifmnCpLwk4+K/7uHM7gkbHLDX1kRu/4ECGLKHNip9aFKZ4H4vsiJC6fgEARsTXRbv
 yliQeGS6JFt8auTfZitpkifZU1VWr8vxzF/4YOZIg6bUvf57EduTPljI8seB1iVFYt9v0N8zozk
 axOywfCey5wR12ezjpuEKBROuoRdAUxyN6hyQz8o1AcLJU2NtKlr5IGM45M8fEQPIAAbT+g4Y4m
 Go2FHyJfK620d7DJpd3A4nMS9CFLfmII5XceJNPuYRnwTJWJ0TRx9C6te0sLbTFEdMaEZixXBVj
 ijbSHMcqOLOHE+4HTIzCHczRhbg3lnG87wdqsfLAkn2459LpNnxLYcpQZVGGBJ67rG0qxLfQ393
 TDHoSty956KwwjFZF4R0bxr+W0qErrdoAG46/PicqSAHAqor/2AZ37hyZq0re4HNgPZOL8Yj
X-Proofpoint-ORIG-GUID: pQEOYimuMjzWb0q4a4f71MCO5lH7S9XJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=746
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230193

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Make use of elite-audio.dtsi and remove the gpr nodes from SoC dtsi.
This move removes duplication.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm4250.dtsi          |  1 +
 arch/arm64/boot/dts/qcom/sm6115-audio.dtsi    |  8 +++
 .../boot/dts/qcom/sm6115-fxtec-pro1x.dts      |  1 +
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 69 +------------------
 .../boot/dts/qcom/sm6115p-lenovo-j606f.dts    |  1 +
 5 files changed, 12 insertions(+), 68 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sm6115-audio.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sm4250.dtsi b/arch/arm64/boot/dts/qcom/sm4250.dtsi
index cd8c8e59976e..64ff6f2f1c23 100644
--- a/arch/arm64/boot/dts/qcom/sm4250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm4250.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include "sm6115.dtsi"
+#include "sm6115-audio.dtsi"
 
 &cpu0 {
 	compatible = "qcom,kryo240";
diff --git a/arch/arm64/boot/dts/qcom/sm6115-audio.dtsi b/arch/arm64/boot/dts/qcom/sm6115-audio.dtsi
new file mode 100644
index 000000000000..d8f32f533609
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm6115-audio.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#include "elite-audio.dtsi"
+&q6asmdai{
+	iommus = <&apps_smmu 0x1c1 0x0>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts b/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
index ad347ccd1975..e74423bd8913 100644
--- a/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
+++ b/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "sm6115.dtsi"
+#include "sm6115-audio.dtsi"
 #include "pm6125.dtsi"
 #include "pmi632.dtsi"
 #include <dt-bindings/arm/qcom,ids.h>
diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 91fc36b59abf..b0ff09aca6d5 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -15,7 +15,6 @@
 #include <dt-bindings/interconnect/qcom,sm6115.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
-#include <dt-bindings/soc/qcom,apr.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
 #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
 #include <dt-bindings/thermal/thermal.h>
@@ -2729,74 +2728,8 @@ glink-edge {
 				qcom,remote-pid = <2>;
 				mboxes = <&apcs_glb 8>;
 
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
-						qcom,protection-domain = "avs/audio",
-									 "msm/adsp/audio_pd";
-					};
-
-					q6afe: service@4 {
-						compatible = "qcom,q6afe";
-						reg = <APR_SVC_AFE>;
-						qcom,protection-domain = "avs/audio",
-									 "msm/adsp/audio_pd";
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
-						qcom,protection-domain = "avs/audio",
-									 "msm/adsp/audio_pd";
-						q6asmdai: dais {
-							compatible = "qcom,q6asm-dais";
-							#address-cells = <1>;
-							#size-cells = <0>;
-							#sound-dai-cells = <1>;
-							iommus = <&apps_smmu 0x1c1 0x0>;
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
-						qcom,protection-domain = "avs/audio",
-									 "msm/adsp/audio_pd";
-						q6routing: routing {
-							compatible = "qcom,q6adm-routing";
-							#sound-dai-cells = <0>;
-						};
-					};
 				};
 
 				fastrpc {
diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
index c17545111f49..b461a09781d5 100644
--- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
+++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "sm6115.dtsi"
+#include "sm6115-audio.dtsi"
 #include "pm6125.dtsi"
 
 / {
-- 
2.50.0



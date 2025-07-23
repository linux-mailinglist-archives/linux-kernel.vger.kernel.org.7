Return-Path: <linux-kernel+bounces-743275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBFCB0FCD5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B783ADAEB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D879027701E;
	Wed, 23 Jul 2025 22:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jwKYWZo7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B73A2586C9
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309690; cv=none; b=u2lqFTOSinG8vMlIjf/IVaT+Zv7Jic5dHcm+ZLfNQopj0ukO/1QCBtzCqW2DV/CzqJdpUc8pCDUfx8dNDMzZMefYYXhyaM8pEU4tH1ZRV0/TgXUkVG3WYLrvXdCW18cUKiAS3X8xX3tK+BRfFLggJ1s6RxiRlsAB28lWG8f7fLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309690; c=relaxed/simple;
	bh=pfs8ocV5oFyu+lsbLXH3Ei8VFhET21gpR3lNBPiEabI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kc4PGpxzmvq1M246jtqzwUGTjRUnEOVFvLiz3gNtGd8MRxMHGr8HS594H280YqFUQ7qqWUY3gKs8fdLx69afJJ44efhmwjhPPKSJWk+fyGHht73mIyVSYNzDm1St9da0kosWSc8nuE4o4zhstcnb/IuVk6C1uearhl98KQlGejY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jwKYWZo7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NGn7Ma013815
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=P0uXS7Zq6oD
	QocEsaGxMO8iSgriP2+3nxyR1injnx+0=; b=jwKYWZo73o3zTlAWN16XzqV82Lb
	u6j0x8g8vawdJ5kWP6E2flBkPauwZzp3PMxXahb081dX08RtPgH7pmE+jHs2B/7O
	F+ry373p0sw4rWAH8tDxzGjCMhebJ3MXUwlQXaEyLsjy2UlRefhJnqrgJWXxSgAA
	b7SEYfokD8Okmih3WoQTpUDqy3vvrZbwfEfElevzRSDgl30VovCOMVSc4jCmro2f
	/E3lygXFAU0gwdh5xiLJ8TVp4gXD6HIadsXNzz3gSqBa0gItvjaBxofY2GMcVS0c
	IoQ9lPXcjWePSx/C58p5WwyoIMmMmDy8REK71V80eiegAWLDJfSjpSf8bCw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048vd229-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:07 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fb01bb5d9aso5742146d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753309686; x=1753914486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0uXS7Zq6oDQocEsaGxMO8iSgriP2+3nxyR1injnx+0=;
        b=QjzB+VblmMHO/hNyjNXpQesZlnJ9CvC2Ed9DpFHC9ss84x2Jbm3ALM+PZUt47D01Md
         ctH3nJ40pAeeyFhBbn8lrBjJNaRpiWT7IMXACjhWOYC2Lnip7tIc0GyZszNFG4gDGsVf
         uPRWCy2PnlT1k4Ztp/FDWDxbMMXTGyoizdYs108cdwOj/te6g7PIeLtBzHNypgXMPiF2
         S/iOBxnU2h8/kPD7XdRrRo8NI0XGZJfOaymnfiJuVNMXvzllmwr0FCj96Y+6dZ5SSoXm
         gVA31X2RnUU+2Qh0C/nVmQdn/lY7VCVW/neITEzpnLfaCZcSsmv+g980F+LytY8JJASL
         PeYg==
X-Forwarded-Encrypted: i=1; AJvYcCUUInoK243mlLrvOXxplrEOQJNG9aHnUPadC7P/ze+pMK2f5ICupdVPolbJ8tzffMkYfcM1ciKIzZpPnEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUjOHZlz/0h6iVQsvinqHBImRRAoWs1P1XeUwzmXB4rOdoQSjZ
	G+bXmLipIyL7LGwesH37rexrJp9sOtI6vBi6mIfmWEWTblCMVI3uxM73xvDKqJk03DrJorcSFXm
	Cbbmsd+pH85zFHHD/2BA06pbDkjF+geAkmKKWUYoRPBdrAKSf10859djWQT6NN28JBjU=
X-Gm-Gg: ASbGncvdmflXPRiT9z18aF8vm35CZ7eZuSVEwxHn4EamzN852G5Wdcl7SfkPakAgIBT
	nYcXOTiYEaOYqjSl3Pm9VkoVh90tiFNiWxukWCXn+mMGl7t2xq/8NERHkKIrWZucreZe//2Uc6d
	xg5Qs/K0TpyTpILyKQ29OFxkhrDay/hLYjymA8T9rPosyecEdPXsF+z8LQLnydmaYDwdzznk9w1
	K7LW/EtfqwM/YO6pctHbbPEzlhXLqZsGJyqyik/BvN7b7vHOKWh9pQNV2u9bBEnWKDgnFUhy4Lz
	HAGlItL8g1q2cYloHU/LKDReEjY8aQpfZw8e1l6XXKNLwoKOL6D6ow==
X-Received: by 2002:ad4:5aad:0:b0:705:2db:b28f with SMTP id 6a1803df08f44-70700711d14mr64262186d6.47.1753309686372;
        Wed, 23 Jul 2025 15:28:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRYaGb7My2NTW7nvntpnILXMpKTLb1wZbqZngoqPvadM9aitX/bxEhJQckEoagg5bos3CBKg==
X-Received: by 2002:ad4:5aad:0:b0:705:2db:b28f with SMTP id 6a1803df08f44-70700711d14mr64261906d6.47.1753309685778;
        Wed, 23 Jul 2025 15:28:05 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad23bsm248520f8f.44.2025.07.23.15.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:28:05 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: andersson@kernel.org, konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 13/23] arm64: dts: qcom: sc7180: use dedicated elite-audio dtsi
Date: Wed, 23 Jul 2025 23:27:27 +0100
Message-ID: <20250723222737.35561-14-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-GUID: i-t6Kb-u18pUoxVH2vUSL8vGofZN56Dx
X-Authority-Analysis: v=2.4 cv=SYL3duRu c=1 sm=1 tr=0 ts=688161f7 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=jH0tB8uThlOIpdONzZoA:9
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE5MyBTYWx0ZWRfX4BNJE5inG9rM
 tI1xothJzmVt2Ks+lsrBzVPPMCHWb12G0ixKifYHRiRpluKAaCTSTrc37flRuFtWfUdKRsTn4KW
 MkyzgvgIsa4yF10OsiZ0YuNoYnQVWaCeZJ9HFDxfLP0BsXqQA16JrSINNofxokX8yseiKpjZ32Q
 hIK4BQfDoTVMoOJPW42riuAs2RL5y2/AFCWfZ3TkxgDhI9m73F9THpm9pd5iYgIlm0Nm3cEaJrN
 wmkplvDAYeWtzdEZJYdVlux0r3GlDHqdiMOBv0SXppqvVIvihMLWL5M4tw5epCNR6rZun3RKrFk
 pdvArPeDNYb40d+1HDeMhxQlngNK2VwPS19yrLzEsl/QGUcsqhdpAKTqAse5LoiHx5f48FBexBo
 lfn6AoWQFnALOTGSN+H4lvl03vDAfBBXYwvZbWPmN4v8N02Dyf8TlOI2gwkI/ObmhtUobJqi
X-Proofpoint-ORIG-GUID: i-t6Kb-u18pUoxVH2vUSL8vGofZN56Dx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=870
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230193

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Make use of elite-audio.dtsi and remove the gpr nodes from SoC dtsi.
This move removes duplication.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 .../boot/dts/qcom/sc7180-acer-aspire1.dts     |  1 +
 arch/arm64/boot/dts/qcom/sc7180-audio.dtsi    |  8 +++
 arch/arm64/boot/dts/qcom/sc7180-idp.dts       |  1 +
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |  1 +
 arch/arm64/boot/dts/qcom/sc7180.dtsi          | 56 +------------------
 arch/arm64/boot/dts/qcom/sm7125.dtsi          |  1 +
 6 files changed, 13 insertions(+), 55 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-audio.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
index 672ac4c3afa3..70b8633e5dd9 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
@@ -7,6 +7,7 @@
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
 #include "sc7180.dtsi"
+#include "sc7180-audio.dtsi"
 
 #include "pm6150.dtsi"
 #include "pm6150l.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sc7180-audio.dtsi b/arch/arm64/boot/dts/qcom/sc7180-audio.dtsi
new file mode 100644
index 000000000000..d6d41ba93195
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7180-audio.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#include "elite-audio.dtsi"
+&q6asmdai{
+	iommus = <&apps_smmu 0x1001 0x0>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
index 0146fb0036d4..cbc3a3096cb2 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
@@ -11,6 +11,7 @@
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include "sc7180.dtsi"
+#include "sc7180-audio.dtsi"
 #include "sc7180-firmware-tfa.dtsi"
 #include "pm6150.dtsi"
 #include "pm6150l.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 74ab321d3333..0e267b9fdefc 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/sound/sc7180-lpass.h>
 
 #include "sc7180.dtsi"
+#include "sc7180-audio.dtsi"
 #include "sc7180-firmware-tfa.dtsi"
 /* PMICs depend on spmi_bus label and so must come after sc7180.dtsi */
 #include "pm6150.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 8f827f1d8515..b56173838fdd 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -23,7 +23,6 @@
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
 #include <dt-bindings/reset/qcom,sdm845-pdc.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
-#include <dt-bindings/soc/qcom,apr.h>
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/thermal/thermal.h>
 
@@ -3876,61 +3875,8 @@ glink-edge {
 				qcom,remote-pid = <2>;
 				mboxes = <&apss_shared 8>;
 
-				apr {
-					compatible = "qcom,apr-v2";
+				apr: apr {
 					qcom,glink-channels = "apr_audio_svc";
-					qcom,domain = <APR_DOMAIN_ADSP>;
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					service@3 {
-						compatible = "qcom,q6core";
-						reg = <APR_SVC_ADSP_CORE>;
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
diff --git a/arch/arm64/boot/dts/qcom/sm7125.dtsi b/arch/arm64/boot/dts/qcom/sm7125.dtsi
index a53145a610a3..567c2cdde916 100644
--- a/arch/arm64/boot/dts/qcom/sm7125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm7125.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include "sc7180.dtsi"
+#include "sc7180-audio.dtsi"
 
 /* SM7125 uses Kryo 465 instead of Kryo 468 */
 &cpu0 { compatible = "qcom,kryo465"; };
-- 
2.50.0



Return-Path: <linux-kernel+bounces-743265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6625B0FCBF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A864F7B633D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59887273D9B;
	Wed, 23 Jul 2025 22:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oLwJUEwe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ABB27380A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309678; cv=none; b=rUE+DKwT1At8BQ6G5dRANR4APJ9uimNdbRb9ksTl/X1sj+GPAguo43lkjp5ZKeL/4iJAySDwx7qQBh856tvQupg7Hqn2EXJKLtQAfv8LVbQF/KuC0ZkVFxfHUTSW7CEc6f01Gfav17Mt0OPYstrOtOBqMzIj8cLdIMRIL9sGDwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309678; c=relaxed/simple;
	bh=8gdDskS87FeNg6keyQeGdaNSZnQdQZayup5VAf9Jiwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcVp4H5dRuMirMsat0gdz4q68xTYMwSB4ip6J99DhhLQLSWdMYm8OD8w+ZtE/svUPRtUNnFCn91JRDFNVNePN4T3rcpHqIuwN+U4Uhae1fwgkBk6w86wnG3Sa4nwlUTsi+BCNI2QQbDz3gEHeiw1mqjRIhJeHKZ0FtsA4jAw5hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oLwJUEwe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NGxBbv004853
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7RK0fhLMbvn
	Gy9dQv4qEXj2wBB+KjlP+zFlUnmCUSRg=; b=oLwJUEweVWKKGKcr2drqVXbxA9L
	4kCuBpkIHnleEAXvWm/SS2lLIpxl6z03D6f8lOqsWwatroonMoOjsE/Gxfnuih1+
	DeSZ5XH1RUR4LyYdDa2I+yTJ01F110pZsfZKvJFLXTNatKeGUQNUy1QTglOaO0GW
	llBxAU1wK8/GRpusHTaEUA7E/jv8JVPoVH67tMbBIl9wEYbt5Wm6/va5KUJjMWp5
	tw5DTqseneh/y0uk2kWgjYK+ElSrWzWbQ05TXyW7ySP3fb/sBgoTCe7TRRTuGxpB
	Pw0iezKzyTcrPgxMKfmEC6jkF7b9Lnw6xjfqL9p3FBwGAGw5hHUeu48Qj4Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481t6w7uts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:27:56 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fb3bb94b5cso5261356d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753309675; x=1753914475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RK0fhLMbvnGy9dQv4qEXj2wBB+KjlP+zFlUnmCUSRg=;
        b=OLKKxRv2ec/MTfAp067BREpw+r2lDssOEV5g1eVohczIi8pJZ5GmROvdUDgOn4FgWR
         24FDgJ5nb2jppJC6gx9KsTYFl7iC+nNUCMNhmjLLfjRBthaEN7tCb5QV1T/Vhc/rD+uN
         TsBkPGzwwNpggrpgseS0bDj8v6HmR6v8hSwUUEOXpIPAZ33r6UHIDxu3xV3CH3nopz7B
         r6E/z+74jVLvVsfSrPRdzIXHxpu52i+ao8tq+I8XHpt1tqoPeRWNZ9BxsMp9MNKi6nMP
         byvyCUOV9HNkuQQvRViw27OPba4hI7dlAUYwqTBOvwhr+X8PG9Wi8LhELxJQLGsklNwU
         tIbg==
X-Forwarded-Encrypted: i=1; AJvYcCXdy8rf9lQogaJcNJPtymRQNwAmftAWX9xF51LDGONzRLQhVJkIq4UkrjL5bUP6C1XbcHMb950I5h32g50=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL09mKc/t8quZo/J/on8DnR3nJOVV9TxYC3w84zfc1wpZGKAaf
	bH7H8TitsRiCAJAmysPXQ7HToN0S5fcLe2c7FtYpRjSqR7CiukvsNrWTGieYiti/ENSMCZ/vUqz
	VDN9xGB2RhN/qzhcQQ1gHjyb1dfsygkknTaXjjEz16WazYeXviRTWcWrx2H+5eNwBu04=
X-Gm-Gg: ASbGncv2XpRjPxRRgyfLGfCEmUzSOvnHYSBQ/ukScvLir6Ut8f+nBY8hzqOzM4cDCLa
	3ThpOfXsA893O4lYI0l1kDqY3PWI1uLVIdza926zPvMTn4dRWVEeWzRKn0kkuSk0u9jYnCivsTg
	gtMB6SUVFWcWGQwB+8CbA/d/X7HMd+qlIeEYGUcT6mEjsoxT7GkiYUYnf5hCKqMb/9xnL3yKGoO
	VQR7gkBWzHp9/tHnOT9zmJpdSng3ww9ue0LprhL/tIneztrVMmJfh3FwktS+myLr4X+v45Cc24y
	Wmm/tnrN3Hw9AneQWv67ZdJbYXcQ/vpxxTlJbcFS7E+Wa866pHLScg==
X-Received: by 2002:ad4:5aae:0:b0:704:f3ef:cbc2 with SMTP id 6a1803df08f44-707006800c0mr56091686d6.33.1753309674686;
        Wed, 23 Jul 2025 15:27:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHi+F19FWgptWCgQfI9EqZuj1NHc7/nYLG8611pLkfjbTVjEsycI1TSpNLO1Dn9kYVM+a78uw==
X-Received: by 2002:ad4:5aae:0:b0:704:f3ef:cbc2 with SMTP id 6a1803df08f44-707006800c0mr56091346d6.33.1753309674109;
        Wed, 23 Jul 2025 15:27:54 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad23bsm248520f8f.44.2025.07.23.15.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:27:52 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: andersson@kernel.org, konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 03/23] arm64: dts: qcom: sm8650: use dedicated audioreach dtsi
Date: Wed, 23 Jul 2025 23:27:17 +0100
Message-ID: <20250723222737.35561-4-srinivas.kandagatla@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=SPpCVPvH c=1 sm=1 tr=0 ts=688161ec cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=aONcyR_MLncd44ar4gMA:9
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE5MyBTYWx0ZWRfX7LKkNvxapjjy
 Iz1QSixKFJynItAzTChNkBH+1fo5Dlz5RqXcKoXO+RnryvRZh7abRcTghH1hH8FShUhWahMw/cA
 bbbf/YPhDFAqorMaqWyJHX06lHEh4Zj5Y9ge051TP0abKnCyOLAWRr+jmmMuuNBfXdwDAvX8EOV
 XAeqroEwzGKfO9wkwc0iMHX3m09J57RY6VRGIuUmiJACF4aC90vCcVGrwVVVcFYjHN9a6T+l9ED
 141J3i5SuFn9K8sAZLXPyUpGqkYGbZFsRwWBrXj+Ia05xfFtSe7s7WTy74i0RcxO9MFRH52aWr1
 jZuDhpAdhZQe/QkNhyzemJtCcQZLPlNvQcDl2zmjReeIeH/boL0BYWUlElv1ZC8/YJ6GUWZK9Nz
 FBsrKxMchxpJVXU9Nx/SqLSq2BMBJzcN8TKaTfLKfV6TiO4ALA0ohnzz2gpzlwIM4nLe3A7L
X-Proofpoint-ORIG-GUID: h5791Camn4E_FtarHr6xaYMqkIo4LGGd
X-Proofpoint-GUID: h5791Camn4E_FtarHr6xaYMqkIo4LGGd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=739 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230193

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Make use of audioreach-audio.dtsi and remove the gpr nodes from SoC dtsi.
This move removes duplication.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8650-audio.dtsi | 10 +++++
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts    |  1 +
 arch/arm64/boot/dts/qcom/sm8650-mtp.dts    |  1 +
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts    |  1 +
 arch/arm64/boot/dts/qcom/sm8650.dtsi       | 43 ++--------------------
 5 files changed, 16 insertions(+), 40 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8650-audio.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sm8650-audio.dtsi b/arch/arm64/boot/dts/qcom/sm8650-audio.dtsi
new file mode 100644
index 000000000000..14ae50e72e4b
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8650-audio.dtsi
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
diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
index 259649d7dcd7..94fa52437d79 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
@@ -8,6 +8,7 @@
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm8650.dtsi"
+#include "sm8650-audio.dtsi"
 #include "pm8010.dtsi"
 #include "pm8550.dtsi"
 #include "pm8550b.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
index 8a957adbfb38..07e62918422e 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm8650.dtsi"
+#include "sm8650-audio.dtsi"
 #include "pm8010.dtsi"
 #include "pm8550.dtsi"
 #include "pm8550b.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
index 7552d5d3fb40..7f26095e6f07 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
@@ -8,6 +8,7 @@
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm8650.dtsi"
+#include "sm8650-audio.dtsi"
 #include "pm8010.dtsi"
 #include "pm8550.dtsi"
 #include "pm8550b.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index e14d3d778b71..5212000bf34c 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -23,7 +23,6 @@
 #include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/reset/qcom,sm8650-gpucc.h>
-#include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
 #include <dt-bindings/thermal/thermal.h>
@@ -4447,6 +4446,9 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 
 				label = "lpass";
 
+				gpr: gpr {
+				};
+
 				fastrpc {
 					compatible = "qcom,fastrpc";
 
@@ -4506,45 +4508,6 @@ compute-cb@7 {
 					};
 				};
 
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
-						q6apmbedai: bedais {
-							compatible = "qcom,q6apm-lpass-dais";
-							#sound-dai-cells = <1>;
-						};
-
-						q6apmdai: dais {
-							compatible = "qcom,q6apm-dais";
-							iommus = <&apps_smmu 0x1001 0x80>,
-								 <&apps_smmu 0x1061 0x0>;
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



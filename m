Return-Path: <linux-kernel+bounces-743273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A7DB0FCCF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22EB7586F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BD5275AEB;
	Wed, 23 Jul 2025 22:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U0cYg7H2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAD0274FEE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309688; cv=none; b=IBJHUvW2yNLTW39QqQKyRu+VYX9wAf924fm75r1KBCXwuEx4vAJ/cWSr6b2gCdFopHlJNxOhXfQnmduvLoqDq0XJ5hqciJoaZ9gAPHdtqlcnky32eS/Y9sQ3fVE9p5SCUZvfjMg1sN5tS1HfL+ZedXWfqZ/1pwb5wAvHKhacQbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309688; c=relaxed/simple;
	bh=GZovDhI3KIvNWEQqtfPo90i9y/ccJUL2n910bxESqZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2lU1bxQ4Nygiwai+Xzd7xxJIg5FLLHolDem4ydY0n+VTk+DpDlRFSa6mQJ3H5rEMRBjWahW97GpPIFbUrQUQa7t4iRQGBVvUhSYHOiI2enfIm3vnDEJZ0Fzr9fLFY3Rtc+f0+V5dVsSu1dcmzbRQU9o67YPRPbplhkOsAYDjR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U0cYg7H2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NHrdHE032272
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=i963kRzz7mS
	JAvFLKAqickSsiw6bz65u5/y25yzIkek=; b=U0cYg7H2QMp0KpnBvQqKFSkSzs7
	gyZ8au/f07vgXd15OsL1qzNZImKTHSwkjU3HM92O0nprjuBYmT68g/IOJlwKSXaN
	XlMy5T+KCe1nzcKixeoUgjViplDb8GYm2EP0XKlPJPbzpFJMIbOU3CUq2f8lA32b
	RU4Aw7WNJBtpbkLvudiden74ENUC+71vSCIvKU/8TV9FTMdKwMtiJd89R8J5fVrg
	cFUshQ6tSHOE/amCJC8KIaxhmy/7KMVCW8G+y+9jRAvmlKqBgASQHlOY/Wg3aK11
	L1vSdZ1s049RbqHo563NGWw/InUvd5rEbajhV/ScC8k41+8Dgy0Vf7k9wxQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t1e139-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:05 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e32df3ace0so32010485a.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753309684; x=1753914484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i963kRzz7mSJAvFLKAqickSsiw6bz65u5/y25yzIkek=;
        b=fqM7vXWCnoW2FrhWLM391gPB6rscxzfz3UD3Go9xnyfbkztpQRxYrzBE46MqikG+BB
         IyM4IS1a0hdr+04j1VdskS44XdrwCxub/U5sP9p65jNqZ1YTFtxVHYqrlJgWA0RPX7m/
         lISgOE1kk2P7rewoZB6Ozx4/g6rGWEqSmHCAV7OxioGF9XDO677+UvMqHIqT0kwcwZXB
         dwW4ai3KMTAJryTkVqu8qspvyElKHn5iNhmjycCUYSPZW1n/6ii4WuSlhDyVBtYUDEgP
         D7HGzwkQlEGfOHnaCWRiPzZGTV2Rw819CHBUSZCKLW1OO0CWxv/DY2p4B13EUTkl+TWO
         D3pA==
X-Forwarded-Encrypted: i=1; AJvYcCW00LThe7kh7kU+6QYG3UUqShDOc4vzieeeQjfM/xkIYXaObCWV7K+iwha6K3R+DEjQ6a0VQC3FcRzgSww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXsMfP08aqlQyUxdvnPfPNHY68nPYGvdZPoc4FM4eh+nETsHkM
	kFqWHFGOvXtulK/BJ5Yal31pprUKRvBooT9iQkDnVtj2tJxiSEJdYOm00eQ+g0lrCndisCIe6Nd
	naNGs7fn1DfDKYLLT0KkXh4r2xUvqKSnZz/vqIn9KDjBZT0iJFOWTI5lixamHBlHK1FA=
X-Gm-Gg: ASbGnctrrQ9RO1gzxXMv3ZNBRrPOzvYgLCjnZY7Qego2nv6+f22d92AUonS4HmSTICr
	TIm6bmBd5gUsfnJVRaQIHBWfo3Tp7IZuFbcX+QIPUPBfXinYlq/YqGGoKoYNRt3be2yCl2Bwttr
	NI1ZZjrgzAOAHRtcVYqeIOrgYf6c0wa6TeNpVmuBNQv4sFLxvBlPFGUJ0yZo4Qw1xw9XrpXi/4J
	+MTVsjxeaHyk1/kpcXJ3Nm1kb+TjX4J6pE+20Cnn0HmBVqGHGwRxJcnnCi6qOYBvDAQL+mQb4ha
	RfADzaBYFLYVi1vShCbl1H3QbgivemflZs4EDXMfDPTbcFETJj9/hw==
X-Received: by 2002:a05:620a:430c:b0:7e6:301e:d03e with SMTP id af79cd13be357-7e6301ed169mr207200885a.12.1753309684182;
        Wed, 23 Jul 2025 15:28:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx/aZlDfmJskiYExoJos0IgrbNdsw8hv+iwP1Zu+9SoGCMnhK5VUPuQGwsMnxXkiJ9tKnVRQ==
X-Received: by 2002:a05:620a:430c:b0:7e6:301e:d03e with SMTP id af79cd13be357-7e6301ed169mr207198485a.12.1753309683722;
        Wed, 23 Jul 2025 15:28:03 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad23bsm248520f8f.44.2025.07.23.15.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:28:03 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: andersson@kernel.org, konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 11/23] arm64: dts: qcom: sdm630: use dedicated elite-audio dtsi
Date: Wed, 23 Jul 2025 23:27:25 +0100
Message-ID: <20250723222737.35561-12-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-GUID: w_u7iZV9sUY04oZBfMrHw_9x0DxbK4Wt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE5MiBTYWx0ZWRfX5w7DphL+2n31
 Lxjt/YEWGmA63jvHcg8q2jzfL45GeHRloR1tj37S9f5Ki5Z4FYe4gtp/7e5t67BrYRfeL4zpiTT
 yK84V0o/fem3zMJaFAKB/23Pr3AuvLrI0bWeAtThV5ZA6neGW5zuKs6wFgUM2UC8oUXTZFSVU1J
 PHYzTU8hkY7K8eSUAiY9isQoyPyV2z1HbIIu18q72Bsi5w7+v6A0QQ3FxG7qNEIJ0EYyA8/ifOA
 kqxskqOGpUNa+WVp6Q3Chk3VDjiT2wQruytZyQVbkz3+6PB0MvbJ+fJx1g91MpOhbjrm6rvbERE
 PNvzZQmBJd0vf80IuLyy3ZTHjo3FN4QMVrU3W9uubvJ7BDTQ6Jpe3NOPEkM28CIjUa1Hry/QSMS
 4Pii6gm5t0R/u5wPbELx4tVgW2Fns8XQHzMA5GdfWY3va6hkCdHGggBhfBWzR+/scVA2qdpu
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=688161f5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=NCDuKiUfWsd8YKX2kAAA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: w_u7iZV9sUY04oZBfMrHw_9x0DxbK4Wt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=551 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230192

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Make use of elite-audio.dtsi and remove the gpr nodes from SoC dtsi.
This move removes duplication.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sdm630-audio.dtsi    |  8 ++++
 .../qcom/sdm630-sony-xperia-ganges-kirin.dts  |  1 +
 .../sdm630-sony-xperia-nile-discovery.dts     |  1 +
 .../qcom/sdm630-sony-xperia-nile-pioneer.dts  |  1 +
 .../qcom/sdm630-sony-xperia-nile-voyager.dts  |  1 +
 arch/arm64/boot/dts/qcom/sdm630.dtsi          | 45 +------------------
 6 files changed, 14 insertions(+), 43 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm630-audio.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sdm630-audio.dtsi b/arch/arm64/boot/dts/qcom/sdm630-audio.dtsi
new file mode 100644
index 000000000000..ca7af09a2380
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm630-audio.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#include "elite-audio.dtsi"
+&q6asmdai{
+	iommus = <&lpass_smmu 1>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dts b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dts
index 9425b2d9536e..91663a502291 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dts
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "sdm630.dtsi"
+#include "sdm630-audio.dtsi"
 #include "sdm630-sony-xperia-nile.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dts b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dts
index dd484a9bc7cd..cc0d16ea16f5 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dts
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "sdm630.dtsi"
+#include "sdm630-audio.dtsi"
 #include "sdm630-sony-xperia-nile.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dts b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dts
index 2da83cd41187..9cc953b89816 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dts
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "sdm630.dtsi"
+#include "sdm630-audio.dtsi"
 #include "sdm630-sony-xperia-nile.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dts b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dts
index a679d4acee29..f6d31ef8b49f 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dts
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "sdm630.dtsi"
+#include "sdm630-audio.dtsi"
 #include "sdm630-sony-xperia-nile.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 8b1a45a4e56e..300e69b86cfa 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -15,7 +15,6 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
-#include <dt-bindings/soc/qcom,apr.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -2293,50 +2292,10 @@ glink-edge {
 				mboxes = <&apcs_glb 9>;
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
-							iommus = <&lpass_smmu 1>;
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
+
 			};
 		};
 
-- 
2.50.0



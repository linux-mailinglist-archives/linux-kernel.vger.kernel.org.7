Return-Path: <linux-kernel+bounces-743276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FB1B0FCD6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A008587473
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898B327780E;
	Wed, 23 Jul 2025 22:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eYJeT1Mh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B446275AFA
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309691; cv=none; b=aikU8PxB7JOi3rCilZMCQKty0cRfZmcdQDs+KbU4RP3IvnLFyeL8gFwYljTjf4cT2joIyQLPK3CzLxtoqb4jIrXIlbseBcnv6S8D+5+N7uH+ZrcVhzBTQTLVGcdP/0Tt4COW7qnTN849EYd5FrJqbcWZiVmJTqsRVDMt2zbpJTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309691; c=relaxed/simple;
	bh=5R0DWRB8pAdMg7zzt0GXuEvR8mZZI1Vjp14kikh/KIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmItfTB2g1TOGajaQ6Q/EsCCzRh/YvR7yX91D/oxHlsytEVkE65DLe6nh4mznp2Se5xjb1+52Vs5Rjs/MKc6qxFfhGWPrg9zL84mCIj1EHw+g62v6qdm29oEr8wOxrWh5YJrJ38vZ+QGlN6BeyRYS5vX6/vqn7KQ3KkFjE5Edzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eYJeT1Mh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NGNF2D018863
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=0jpyAxpI48R
	1msvWfQPpUU9wgV/nArJybOguxXU5++4=; b=eYJeT1MhJJjZJUGjzDWMG5ZR0Nt
	sXoSfu+62XVRID/Cg4fCO2s6nKZp/mEwOcB7GV3eVUFVkpSA7zapIcuB6raOpj7I
	BT6cvksK63rOl2rZi1VQTtLNpoor2D483KewU2QbQS8CZgQqTc3EPEDR7v7lp5CL
	kn49uWuVyrAK068GcFnrX/g9y/tdLXlCQkUrDIbGW5ZwUOZn8+mg7xxzyJx4KTM3
	5nhEy79jMt9Jqz8L3cfg2g20E6UMtsuzqErHkTtArek91I4SFTxd27B0xeQj182N
	6awuQLz6DeM9/u6ml1SrarAj8/Vkj7PZRQtuL0+vG41dULT1JzLLsdj35/w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483379ru5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:08 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fad9167e4cso8114476d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753309687; x=1753914487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jpyAxpI48R1msvWfQPpUU9wgV/nArJybOguxXU5++4=;
        b=nhFPm/MIsPKVlhtrH5l5zosOmKmu/0BgCL5QzwYLLDqQ7bFWBKYIVNdb6aSl2S878H
         /Q+4ipin5lWD7WXs/5bz+sh9Oe+5m3mKbyeG1bksJIGV3G8gYLOsXPv8CLtFwFWA9DWC
         VFFbF0RtD4Av+NsdD3fEayFGHdBHfrTUsBRPwPrcTnjSJI8IsNFC8kJkUV5wJsBB3BKf
         ntw/snnHlQB2udIGgPeb9GWrGYiUjyZLqOHPlSpgb5QBcU1RkP4paySdkJRG3dbbE4VF
         2YHXupCbAbvWI/eo0JthfDXW2xQs5Yyy+oiSHSCOKNXyOJITosVxWP0re5EFjIqN6L5P
         9xMw==
X-Forwarded-Encrypted: i=1; AJvYcCU58HjtLUHKXTj+HwJSh++Nmgaqt4U/Hj57hhwY42d/tI43sg5QvPXoiWetTKaYUHjzLH9G7mf5gYcEbR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC2TLC5KVtE+sT9BDtLg5l+nBfuHc8ZQjvcCM5fp0gPlhH29aK
	rG65sPG4EJ3QsDb3YVDQSdO2x2SuMBPNrh4d5zQQqXQn2Aw8J5PgU0XHuHySwxzX1gCstIgnPMe
	q0IPt/2PGEW6KldKo13itrx+iw3dj3YtlYvFU9fM0cLysUxF99s8t0jZHOLeS9aIo+7U=
X-Gm-Gg: ASbGncvxTrfQfENF6QvqBMvuJdAvDxylks5Nj8wrXk/Z8AQNNyZdmVQmLGPoNI3BM2g
	IBBN7yA79fcE9oGS9csPpnx9bXYZYPteAg9dcnu/N7zna9N6cuuqKNw58Cif/vAwyvYY3D1Uqwg
	PZqnpDxtVoEitoAUBtweiBuOSG3d73MDWgPvfOikopkDPcXGtsb/bjGCwZZxbdUz0HlSgCvPpHk
	rvp9J3qn8n53/XKuAxj48ITcKwpGQ3XUs+fDX3JVYH7pffKlim/uXxDs9v7NMgdv0LKzE0+cq2R
	MUEzrop2zpk1b4JAAMBAltlpgfY+WAKbxgS6LivpvAf3YuYuM4A4Vg==
X-Received: by 2002:ad4:596c:0:b0:6fa:ce27:5975 with SMTP id 6a1803df08f44-707005abd62mr63187056d6.22.1753309687180;
        Wed, 23 Jul 2025 15:28:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKZFM4C8iOyGySk3dCMx6hMc5W3tZ8t8wQVtWNw+VZbHduFJCRuN0EyrjNNEO3yDfmvZ1pUA==
X-Received: by 2002:ad4:596c:0:b0:6fa:ce27:5975 with SMTP id 6a1803df08f44-707005abd62mr63186816d6.22.1753309686732;
        Wed, 23 Jul 2025 15:28:06 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad23bsm248520f8f.44.2025.07.23.15.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:28:06 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: andersson@kernel.org, konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 14/23] arm64: dts: qcom: sm8750: use dedicated audioreach dtsi
Date: Wed, 23 Jul 2025 23:27:28 +0100
Message-ID: <20250723222737.35561-15-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-GUID: 7eFdg5PeNbFk5V5cwWKALQP6LDcOJD0-
X-Authority-Analysis: v=2.4 cv=btxMBFai c=1 sm=1 tr=0 ts=688161f8 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=kZFr1r1NR6a6C5-aafMA:9
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE5MiBTYWx0ZWRfX5DSnzwnga/yp
 2I+5ejdunzTVm22kctyaZIHicS6Pgs3vEpbcK1SQq82nWYhquefj0gPGebKkYWvMzyHlBlnKESt
 lxlNMmnNpJLOvmn5jdi/TLLJrMF26zJiXZ5MrO04vnUdXC22Bd086YO9ccbc7qOB30F/xzdW+cV
 uCbzCBE0zpGJp4SXW0owB0yUnm+SXE+paDIs/aV/Gq2o+MnvwbQgnV0okuVPwSLsTh4FC0u7Tkl
 QgNw3Fxf/3aIer9h3II2r5GflZ0HagsA2KxFTYjw8orTXnaapBgibUlcfd8hZTtl+fIxbIgmz9I
 SvhJox92NQZsX/hN0HL24cKqBQXZJIbl7rp9OguMoxCGfLvj2twH2gkxMgJym7y+UpVYjsd9nAX
 U89lfiUEe1/VKZliY6dhpE+sOXfxXpZ9i4tyn1FU/PwhDzu2zZQ+1b1DqzZL237N2w6B/hof
X-Proofpoint-ORIG-GUID: 7eFdg5PeNbFk5V5cwWKALQP6LDcOJD0-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=588 impostorscore=0 mlxscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230192

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Make use of audioreach-audio.dtsi and remove the gpr nodes from SoC dtsi.
This move removes duplication.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750-audio.dtsi | 10 ++++++
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts    |  1 +
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts    |  1 +
 arch/arm64/boot/dts/qcom/sm8750.dtsi       | 41 +---------------------
 4 files changed, 13 insertions(+), 40 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8750-audio.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sm8750-audio.dtsi b/arch/arm64/boot/dts/qcom/sm8750-audio.dtsi
new file mode 100644
index 000000000000..54eab4f5e029
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8750-audio.dtsi
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#include "audioreach-audio.dtsi"
+
+&q6apmdai{
+	iommus = <&apps_smmu 0x1001 0x80>,
+		 <&apps_smmu 0x1041 0x20>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
index 75cfbb510be5..eeca98dc6204 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
@@ -9,6 +9,7 @@
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm8750.dtsi"
+#include "sm8750-audio.dtsi"
 #include "pm8010.dtsi"
 #include "pm8550.dtsi"
 #define PMK8550VE_SID 8
diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
index 13c7b9664c89..83cb53b64f0c 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
@@ -9,6 +9,7 @@
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm8750.dtsi"
+#include "sm8750-audio.dtsi"
 #include "pm8010.dtsi"
 #include "pm8550.dtsi"
 #define PMK8550VE_SID 8
diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index 79ca262f5811..952f6cfcdccf 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -14,7 +14,6 @@
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
-#include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
 
@@ -2194,45 +2193,7 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 						IPCC_MPROC_SIGNAL_GLINK_QMP>;
 				qcom,remote-pid = <2>;
 				label = "lpass";
-
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
-								 <&apps_smmu 0x1041 0x20>;
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
 			};
 		};
-- 
2.50.0



Return-Path: <linux-kernel+bounces-862097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53915BF46DB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 04:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F6718C5AE3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC1E287243;
	Tue, 21 Oct 2025 02:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IO/rxQkV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4982127A91F
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761015574; cv=none; b=noMo9MoU67pk0B+lWrhtcprYBv+ljY0tP91k6zaRTV6mfaaFLmsuuEf3LiUxDZaDLo23MIJoUBGmX9HoyC03W0BaQt48KobCSm5/x4JOKb9spT3V6YqfeM3fYDT1Qdsq9pS+uvYJp3lyyK4HD+TwtqviIB7u47Mv0+PjxYoLGQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761015574; c=relaxed/simple;
	bh=QqJm6H+axsb7Sp+Fv3c7hv2LdUqbjAz0fIGMTf+ZcmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dk5wMV/KwQNrHGxYEpL6j7K4k2T5H0bqjqpEYe+hqFgobx27zX4VRtT2Y/DTFSYXTmp3vsNo3ckK6GJHGSxce7cDw6l7YwdAhNxISe+Bi/etoI4QX7Px80EqNtfNQy84HjJGpShpdDQw/dqYFaZQIg8P5kXge0xG7gS8Z1cwNNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IO/rxQkV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KL0xmq024237
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7DXoW44CUEx
	XzSENB3F34QRGOi0zzg2uAwhUx9G16EY=; b=IO/rxQkVfjmf7LYwYAdSb7rPlEQ
	HxL4OEZPTN/l3dtgC9ixP5LEh2JCLtNrEAiAmtRMqEiJc1fXCmRigsQSXxyXCytx
	mXl2b5OAY64VmpVRaveuJEZJSJ13/2oEI26YBCAX2wELqoUDWR8RT+l3KaKhKDax
	XqWglr9Yy5X6+jAKqrg0DM99hi5ThviwvYl6WtVhTwJUr0CEf1S/6vFxx7q0xnir
	9+sXoms8kMx4gN8XKK38goiT0DjoSQgPdTU6Mh3+JsdkBSe3DqceAGPlDZmt8n+8
	XbyBU4Bhped+A2P0knS6ikECIO0/raaLitfzK7Wz30Lqs+KOYkhqm3Nu6Ig==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w7xy9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:59:30 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32eb864fe90so9229318a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761015569; x=1761620369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DXoW44CUExXzSENB3F34QRGOi0zzg2uAwhUx9G16EY=;
        b=AwigLv8YprgEyLiE/jb4rY2dPlFwOBwu5F/MqfmgNPFX4q9DsCLAWQoM3yBt/3nVQ1
         5pzRcn+6SWzxhFRAACQeV7vUcvAghYb4A6ZYIEfkY3ksCFGyTUejIGoFTd8aRXK2eV6R
         MSQacU1dQ2q8FBTRiFkWRK0Fv4+bE/GOmQvX53G0yy5EiYyOfQ3baFYoy2x8bttwN9Df
         eiWyU+9wCO0lABAdSD5bA4C6Y+i88ga7wabm8ZNbO+CVNpF8oMsFajkW9WyiPPrvDavP
         SBr9OFMSl2DELLEbmZeEXYozTrY9YHkiiYX6S6Fg57aHE6Bk43puOLKQMbAs8VPrTdAL
         ZJIw==
X-Forwarded-Encrypted: i=1; AJvYcCW71mM5rGGiFDgOfQcqvx1QtN0+zMvQyggqt9k4OoIuVXoMvZHodnT2ab8omG9eKkkW9IdTJ2FMW1qI9jk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7gBvLqlpaOqfdsqLfck9TVBGHnn/PJ3fl45pTRX3THYZ6ZEm7
	NVxem8goRObZTXrkvJ1Qvtvg8ZoPslLEM/hPJkPQVkzp0bXpcORfz8dLjlWFs2/Hk9tyYfWp0+j
	wg4ebBeUSEvaDYZaaLqTyDn1n+JYGuZXyTP3to7VbFZIW83ewIufS9D7JFlRUGlLUiMM=
X-Gm-Gg: ASbGnctJWbPF4/zd0fNwAA1sYJ/7Ejhdv2IAwlTV0EJmAqB71YaK2Y3wzrVNP8oebTR
	bjzoQgujOp/9DHxjvvy8IYdA5EHRSJ2ziGK3nLy8dMiGO1i2qCDJXFngFL7cX3IieG91KDYV6Ri
	H3f30JDYNF7H+9jQG1kfTglA+cWR3b0mbuQBsXfuT62Armz0Vfs65OxfAHRDovI+Dx33myTZ/sn
	UQ7RyOEpHzyKCCuUaNWf4HqtrD0UMmkNghimpSJESyOJN0YtREMIoSMBxdqnUNmaejMMUNrwPee
	r9y43PYUlMfN4pz5L8Y7DMKLvJL+XM+1eLgR8aiTOGSZO0qmAj6aCYjdEytb8VVtjv8RuzqM8xU
	ZZ2dTPeTELaon4kQ2ZpJqOtg94y2MpfBMR+aVrGwxi3VwN0gxvlgSeg==
X-Received: by 2002:a17:90b:38c7:b0:332:793e:c2d1 with SMTP id 98e67ed59e1d1-33bcf91c603mr16981880a91.36.1761015568748;
        Mon, 20 Oct 2025 19:59:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfONH+YEJVS/DAl2NGHJErEJq0DNR3DpCG2ZRbsj1KhbAnDKeowuWFqEs7F895so9PNNgFGw==
X-Received: by 2002:a17:90b:38c7:b0:332:793e:c2d1 with SMTP id 98e67ed59e1d1-33bcf91c603mr16981865a91.36.1761015568234;
        Mon, 20 Oct 2025 19:59:28 -0700 (PDT)
Received: from hu-songchai-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76673a86sm8855787a12.10.2025.10.20.19.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 19:59:27 -0700 (PDT)
From: Songwei Chai <songwei.chai@oss.qualcomm.com>
To: andersson@kernel.org, alexander.shishkin@linux.intel.com,
        kernel@oss.qualcomm.com, mike.leach@linaro.org, suzuki.poulose@arm.com
Cc: Songwei Chai <songwei.chai@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        coresight@lists.linaro.org, devicetree@vger.kernel.org
Subject: [RESEND RFC PATCH 1/7] dt-bindings: arm: Add support for Qualcomm TGU trace
Date: Mon, 20 Oct 2025 19:59:03 -0700
Message-Id: <20251021025909.3627254-2-songwei.chai@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251021025909.3627254-1-songwei.chai@oss.qualcomm.com>
References: <20251021025909.3627254-1-songwei.chai@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfX0UIcbRTaXIgo
 rYjeRBaTCMXY7AMlpSjEGh6fMO1xWXYr6AmhwmwrMYhN6MwcM3LDWWmqe4SEPoCRMwTrk0JWihz
 1Ir2w85b4GJG9wDEfbcfqRhTX3jx7BkWY16kHrJC7Gu2SPhquMlSnbt6QjiJgtbXKgEE+09BBze
 lfpd17y18yA113KBmys40QZvZn9keLYdNJTRpJ8w2wVJuh3slfIxiJM8QeI8mtd7xzGOWfJCczS
 tFMj31Ze7fAnW89XvO8ZYpDG7lerbSLar3DoAwxnDgCdwj4IPKgyNW97iHnody9yQ2URnhBNjnm
 9tzsy88mDpWl0+pTmpl+Hsn5ZBRjLlatcYoZM9eOu7Rk1Z27jBY+v26+OaPaK6QVb/qL+s2VWid
 mjlMO0GBX5efHg04QcewQdYcJFAI7Q==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68f6f712 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=N3VNWiZ0WD7Ir0aJMQYA:9 a=iS9zxrgQBfv6-_F4QbHw:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: 5-Nku_YQk-fM2CelYu2m59VMtFHySNK-
X-Proofpoint-ORIG-GUID: 5-Nku_YQk-fM2CelYu2m59VMtFHySNK-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015

The Trigger Generation Unit (TGU) is designed to detect patterns or
sequences within a specific region of the System on Chip (SoC). Once
configured and activated, it monitors sense inputs and can detect a
pre-programmed state or sequence across clock cycles, subsequently
producing a trigger.

   TGU configuration space
        offset table
 x-------------------------x
 |                         |
 |                         |
 |                         |                           Step configuration
 |                         |                             space layout
 |   coresight management  |                           x-------------x
 |        registers        |                     |---> |             |
 |                         |                     |     |  reserve    |
 |                         |                     |     |             |
 |-------------------------|                     |     |-------------|
 |                         |                     |     | priority[3] |
 |         step[7]         |<--                  |     |-------------|
 |-------------------------|   |                 |     | priority[2] |
 |                         |   |                 |     |-------------|
 |           ...           |   |Steps region     |     | priority[1] |
 |                         |   |                 |     |-------------|
 |-------------------------|   |                 |     | priority[0] |
 |                         |<--                  |     |-------------|
 |         step[0]         |-------------------->      |             |
 |-------------------------|                           |  condition  |
 |                         |                           |             |
 |     control and status  |                           x-------------x
 |           space         |                           |             |
 x-------------------------x                           |Timer/Counter|
                                                       |             |
						       x-------------x
TGU Configuration in Hardware

The TGU provides a step region for user configuration, similar
to a flow chart. Each step region consists of three register clusters:

1.Priority Region: Sets the required signals with priority.
2.Condition Region: Defines specific requirements (e.g., signal A
reaches three times) and the subsequent action once the requirement is
met.
3.Timer/Counter (Optional): Provides timing or counting functionality.

Add a new tgu.yaml file to describe the bindings required to
define the TGU in the device trees.

Signed-off-by: Songwei Chai <songwei.chai@oss.qualcomm.com>
---
 .../devicetree/bindings/arm/qcom,tgu.yaml     | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,tgu.yaml

diff --git a/Documentation/devicetree/bindings/arm/qcom,tgu.yaml b/Documentation/devicetree/bindings/arm/qcom,tgu.yaml
new file mode 100644
index 000000000000..557bc16b422b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/qcom,tgu.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+# Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/qcom,tgu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Trigger Generation Unit - TGU
+
+description: |
+  The Trigger Generation Unit (TGU) is a Data Engine which can be utilized
+  to sense a plurality of signals and create a trigger into the CTI or
+  generate interrupts to processors. The TGU is like the trigger circuit
+  of a Logic Analyzer. The corresponding trigger logic can be realized by
+  configuring the conditions for each step after sensing the signal.
+  Once setup and enabled, it will observe sense inputs and based upon
+  the activity of those inputs, even over clock cycles, may detect a
+  preprogrammed state/sequence and then produce a trigger or interrupt.
+
+  The primary use case of the TGU is to detect patterns or sequences on a
+  given set of signals within some region to identify the issue in time
+  once there is abnormal behavior in the subsystem.
+
+maintainers:
+  - Mao Jinlong <jinlong.mao@oss.qualcomm.com>
+  - Songwei Chai <songwei.chai@oss.qualcomm.com>
+
+properties:
+  compatible:
+    items:
+      - const: qcom,tgu
+      - const: arm,primecell
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: apb_pclk
+
+  in-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    additionalProperties: false
+
+    properties:
+      port:
+        description:
+          The port mechanism here ensures the relationship between TGU and
+          TPDM, as TPDM is one of the inputs for TGU. It will allow TGU to
+          function as TPDM's helper and enable TGU when the connected
+          TPDM is enabled.
+        $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    tgu@10b0e000 {
+        compatible = "qcom,tgu", "arm,primecell";
+        reg = <0x10b0e000 0x1000>;
+
+        clocks = <&aoss_qmp>;
+        clock-names = "apb_pclk";
+
+        in-ports {
+            port {
+                tgu_in_tpdm_swao: endpoint{
+                    remote-endpoint = <&tpdm_swao_out_tgu>;
+                };
+            };
+        };
+    };
+...



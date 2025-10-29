Return-Path: <linux-kernel+bounces-875395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C86C18E26
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C88B426C5A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B063E314D24;
	Wed, 29 Oct 2025 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VQLajDd6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GXHaIGqn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751DC313552
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725153; cv=none; b=NjwLjOKlPh1tOYcrcx3/gEsX/w62tDwQNIND5paQL9TKD1dJzmwE5tZYUnRIbjoc8y6hMx7W6QJQiiJG+QffXh926/Do62MA2A/+DJ2c8dp9c7b5IuqjOmaEei0F5fnbyBuG+dnY8MUhJavD7mp8o0HZxD3yzx4XfOMrCChBfEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725153; c=relaxed/simple;
	bh=qG8Px462pi8D1xm7m847bRTx1J9HM3N/XH7QFhMPMJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ETtEa9V1jdSJqiGtuk0UzxpKtjIYCVYl8/TFRNXPFsaZ6EbENqdOL4/ZjkQHn7wIPYl9amSMXyIakGYIbIyKf+5BowRPTg5To+XdUxHHNER8jSRfJqeJa3jrkmP+e0NjnSZ4TmBefF9LMSQJQiWzlNErhCzUZ3bHpK5PhSgzRC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VQLajDd6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GXHaIGqn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4v3sq3663722
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MEzud6d+24miB+oycic8odzPE+LUagpIZeXTQc4w4LY=; b=VQLajDd6YDP7ttaI
	3eiIGqKEGT5OPCv+mJuoD4BD0FbUeWY0TOSsOmKO5YmCuAu9nOYido7G263+K98t
	eeu8903wWh02ID4629ZGfj9WE7WavikPEGfABzAt23sXhT0L6S0CdNsUG6q9C8to
	aNkMo41n7mZxWM1ehJ7vYu65xpMoNKA7P4hsxmOFwYoAG20PItPNaghdx1NxTXzW
	vy2wSNW8WRMTQKe29CbOTTqHvUV4ieozRet9kPGSgOulN/vfhMC6Lpcl/dn+93YV
	YRv9UntRYR0buybKWQyhPeQ+1b3nNZIcsEA+w4WcJqj2TToOFr6NYgBQiQXubEUM
	xF0M3A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a1spv9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:05:50 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b8c19e93a47so176180a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761725150; x=1762329950; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MEzud6d+24miB+oycic8odzPE+LUagpIZeXTQc4w4LY=;
        b=GXHaIGqnLvafSlpIs4iUbVn7NjM529gJYJcJXWpHscq1r52HufJz8Ryo97ep9Xnrp1
         86R5MImOk78E2n2cl4WpaLzqxTIdQDawpSrR6Fi5EhB+GuDwcVubetrA0+miHhrc3q+p
         E6ketDPVnapDGSqaGWos1YYlfknjvqUFRcFSUPjKxaNuhRq9jYeyOsnC0YokncjQLAXZ
         RpqVDsakHMPkvaWi13ICzGn6rDxyGELYPjq9UJTKmamQ5KHQRWnfoE9ValOMMQCilC6N
         u++nUc1ZPt54p/PH8MPQIm/e5reBIJCWeqwP37d2POwKkcZiEYWih5w/vDNh+A7KNU4d
         NnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761725150; x=1762329950;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEzud6d+24miB+oycic8odzPE+LUagpIZeXTQc4w4LY=;
        b=R77c8z3GWReRMl1GbuwPtjLgIEAadjEnGZ/i/IW+8fGCWYJcBGhXCELOVrhnb1X/hT
         iVIVSfg2sDPMmltqdA0FoJILXXi3+3uXp2LLFYM4Ml4GJlC0+XHBD9MYSa0Krw6KLI09
         vWmmZy9SACGwjgKbR0gFHJxJZrgrmAqqY80DK9gSKWVDLy2TCAv4bTef+fQPLMuQpOPf
         J9dLpyhrrYBy+aercGf4lYkOAxRCqhbBTNrch9zkfPRM06M2X1aNgPqsq/s0JRBpS6lD
         D9a8zt09nGnBwx/SNKsNCj+YpoiuYygpfrU1BcwnMoYK2nGdsLnMMtWM4KzMtor8Aj0D
         An1w==
X-Forwarded-Encrypted: i=1; AJvYcCXVWl5sRUY+XOXPTf9y2rf35+6AoppURG7CTxPQViTs/uESfFaNd4NMIHyAtSlE9lTtfUgtczEG4z+gOhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsvpZgmY1MsPbuYd1CFsVqxFplIsKb0QNg7X5t8l+RW8/NMvhH
	IZ3NNDUNbvb+vld8lEk70jgf5M9wnLZizyoJTaSsYQI51et4W49JalmR5zzNI2/lh4GrgPgQtAk
	1n/qr/ZmPVdI182ma4knES+fiREUpSFEfLoypJdREl4nf2YAVId6bnOWiDdwXLyAujYc=
X-Gm-Gg: ASbGncuWRYQmZQGoSr9Jw9cJeUNMSIrYA9g+9oXfRqjG96i7zhBUm0FX6rOW/ISgMBm
	iISxQ/dAU/oSCosiYopT9i3N5blpQzRe06r8EdYZch4t9QYJehFTV+RcOmHzwcklYa9jkP/J7Ki
	NdXWRfxm7y74c9olVcd0sXm+3Y24/FWe61Rgb+NVILjWCW3+WrpTbVZZV9G89nud9ekFybHdot6
	7kt9KuP0Ylr1gw0p0QqXNwElB9JWT97c1/1UhJDmX6jh7sgML/RzM1g+euSQasueMmGXr3hKyio
	qWT3OEIFqKhbTU6YacVdB0y4vgyTq3WD6BE4B+G7DApSc+8YxZ18FZ3I2brQLtOGakgxE6hHcdv
	z4tkPz4H28u5SPQR591t9/Du6hL/TZGnfSwC7Uona7m53oTs9fg==
X-Received: by 2002:a17:903:38c7:b0:25d:510:622c with SMTP id d9443c01a7336-294dec55dedmr25087095ad.28.1761725149638;
        Wed, 29 Oct 2025 01:05:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1h9VyNYFKsW3SdER0jTE51bvlWsilQKQ7k2ZMC1Fu2p3IoJPMrmarrPnim2LRDDTu8v79fw==
X-Received: by 2002:a17:903:38c7:b0:25d:510:622c with SMTP id d9443c01a7336-294dec55dedmr25086725ad.28.1761725149019;
        Wed, 29 Oct 2025 01:05:49 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498f0be0esm141754705ad.96.2025.10.29.01.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:05:48 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 01:05:41 -0700
Subject: [PATCH v2 3/7] dt-bindings: remoteproc: qcom,pas: Document pas for
 SoCCP on Kaanapali and Glymur platforms
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-knp-remoteproc-v2-3-6c81993b52ea@oss.qualcomm.com>
References: <20251029-knp-remoteproc-v2-0-6c81993b52ea@oss.qualcomm.com>
In-Reply-To: <20251029-knp-remoteproc-v2-0-6c81993b52ea@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761725143; l=8744;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=qG8Px462pi8D1xm7m847bRTx1J9HM3N/XH7QFhMPMJ8=;
 b=Pzm3RdAFAhrmpkuKTIL8LFd81hMBua1H2VkVyFflrZgXSQH3KE1b2YN7Z/1+FPaCvx/o5EfQC
 Payvy+FpWYwAsQKn/v8YgCfPa1Osib9aHSqd1/3mxB9gjUR80f0j3qr
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: U9oILsHAeivbCbA1bZJjQKb1KUYRx_Zx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA1OCBTYWx0ZWRfXwYEgwfEi7h71
 XmQxMM/2ou82SXN2TcHU91K5VqKThADtL8R4kwTQKRVj6STkK216fw/DAKoW3Q4JkQ4lQs/j17P
 DCSbKTothxSdHMfWMAcdppChP408V0UbroEml0EovUBe/sYdpTGQ5oo2bXz0OB4c8ouL67OzLe2
 GMelS40q3ybhfiB7hdUCfsPGcW5t36F+Vx+W/l+KT+lysVr0osJPm/oGDy3qKCGzQ77WjCnZwRj
 RigVBveJ9cPQlDlIqxyi+FTBj2vSzmU2sF9KQzHfGJu6Z3SqUWl3Avlc9Mnd7WHxL410bM3h8lR
 IztiJYaAMuGgouNM1IiWJk7wkkZndCqfJwjIsWt5DNXmHNmybTrKOY6HK/uiEG4F1w5LDIZ/yjZ
 AgUtVuYHv06x0VvE2no7VLYvm9nNKw==
X-Proofpoint-ORIG-GUID: U9oILsHAeivbCbA1bZJjQKb1KUYRx_Zx
X-Authority-Analysis: v=2.4 cv=UObQ3Sfy c=1 sm=1 tr=0 ts=6901cade cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=nqtFTnZwU29f_90lC4EA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290058

Document the component used to boot SoCCP on Kaanapali SoC and add
compatible for Glymur SoCCP which could fallback to Kaanapali. Extend
the "qcom,smem-states" and "qcom,smem-state-names" properties and
add conditions for the "interrupts" and "interrupt-names" properties
in the pas-common.

Co-developed-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 .../remoteproc/qcom,kaanapali-soccp-pas.yaml       | 134 +++++++++++++++++++++
 .../bindings/remoteproc/qcom,pas-common.yaml       |  83 +++++++++----
 2 files changed, 194 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,kaanapali-soccp-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,kaanapali-soccp-pas.yaml
new file mode 100644
index 000000000000..6b53121eede1
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,kaanapali-soccp-pas.yaml
@@ -0,0 +1,134 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,kaanapali-soccp-pas.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Kaanapali SoCCP Peripheral Authentication Service
+
+maintainers:
+  - Jingyi Wang <jingyi.wang@oss.qualcomm.com>
+
+description:
+  The SoC Control Processor (SoCCP) is small RISC-V MCU that controls USB
+  Type-C, battery charging and various other functions on Qualcomm SoCs, somewhat
+  analogous to traditional PC Embedded Controllers. This document describes
+  the Peripheral Authentication Service loads and boots firmware for SoCCP.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - qcom,glymur-soccp-pas
+          - const: qcom,kaanapali-soccp-pas
+      - enum:
+          - qcom,kaanapali-soccp-pas
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: XO clock
+
+  clock-names:
+    items:
+      - const: xo
+
+  power-domains:
+    items:
+      - description: CX power domain
+      - description: MX power domain
+
+  power-domain-names:
+    items:
+      - const: cx
+      - const: mx
+
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    items:
+      - description: Firmware name of the Hexagon core
+      - description: Firmware name of the Hexagon Devicetree
+
+  memory-region:
+    items:
+      - description: Memory region for main Firmware authentication
+      - description: Memory region for Devicetree Firmware authentication
+
+required:
+  - compatible
+  - reg
+  - memory-region
+  - power-domains
+  - power-domain-names
+
+allOf:
+  - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/mailbox/qcom-ipcc.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    remoteproc@d00000 {
+        compatible = "qcom,kaanapali-soccp-pas";
+        reg = <0x00d00000 0x200000>;
+
+        clocks = <&rpmhcc RPMH_CXO_CLK>;
+        clock-names = "xo";
+
+        interrupts-extended = <&intc GIC_SPI 167 IRQ_TYPE_EDGE_RISING>,
+                              <&soccp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+                              <&soccp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+                              <&soccp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+                              <&soccp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+                              <&soccp_smp2p_in 9 IRQ_TYPE_EDGE_RISING>,
+                              <&soccp_smp2p_in 10 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "wdog",
+                          "fatal",
+                          "ready",
+                          "handover",
+                          "stop-ack",
+                          "pong",
+                          "wake-ack";
+
+        memory-region = <&soccp_mem>,
+                        <&soccp_dtb_mem_mem>;
+
+        firmware-name = "qcom/kaanapali/soccp.mbn",
+                        "qcom/kaanapali/soccp_dtb.mbn";
+
+        power-domains = <&rpmhpd RPMHPD_CX>,
+                        <&rpmhpd RPMHPD_MX>;
+        power-domain-names = "cx",
+                             "mx";
+
+        qcom,smem-states = <&soccp_smp2p_out 0>,
+                           <&soccp_smp2p_out 10>,
+                           <&soccp_smp2p_out 9>,
+                           <&soccp_smp2p_out 8>;
+        qcom,smem-state-names = "stop",
+                                "wakeup",
+                                "sleep",
+                                "ping";
+
+        glink-edge {
+            interrupts-extended = <&ipcc IPCC_MPROC_SOCCP
+                                         IPCC_MPROC_SIGNAL_GLINK_QMP
+                                         IRQ_TYPE_EDGE_RISING>;
+            mboxes = <&ipcc IPCC_MPROC_SOCCP
+                            IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+            label = "soccp";
+            qcom,remote-pid = <19>;
+
+            /* ... */
+        };
+    };
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
index 63a82e7a8bf8..f81d088c2bad 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
@@ -24,26 +24,6 @@ properties:
   interconnects:
     maxItems: 1
 
-  interrupts:
-    minItems: 5
-    items:
-      - description: Watchdog interrupt
-      - description: Fatal interrupt
-      - description: Ready interrupt
-      - description: Handover interrupt
-      - description: Stop acknowledge interrupt
-      - description: Shutdown acknowledge interrupt
-
-  interrupt-names:
-    minItems: 5
-    items:
-      - const: wdog
-      - const: fatal
-      - const: ready
-      - const: handover
-      - const: stop-ack
-      - const: shutdown-ack
-
   power-domains:
     minItems: 1
     maxItems: 3
@@ -55,13 +35,21 @@ properties:
   qcom,smem-states:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     description: States used by the AP to signal the Hexagon core
+    minItems: 1
     items:
-      - description: Stop the modem
+      - description: Stop the remoteproc
+      - description: Wake up the remoteproc
+      - description: Make the remoteproc sleep
+      - description: Ping the remoteproc
 
   qcom,smem-state-names:
     description: The names of the state bits used for SMP2P output
+    minItems: 1
     items:
       - const: stop
+      - const: wakeup
+      - const: sleep
+      - const: ping
 
   smd-edge:
     $ref: /schemas/remoteproc/qcom,smd-edge.yaml#
@@ -80,9 +68,58 @@ properties:
 required:
   - clocks
   - clock-names
-  - interrupts
-  - interrupt-names
   - qcom,smem-states
   - qcom,smem-state-names
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,kaanapali-soccp-pas
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: Watchdog interrupt
+            - description: Fatal interrupt
+            - description: Ready interrupt
+            - description: Handover interrupt
+            - description: Stop acknowledge interrupt
+            - description: Pong interrupt
+            - description: Wake acknowledge interrupt
+
+        interrupt-names:
+          items:
+            - const: wdog
+            - const: fatal
+            - const: ready
+            - const: handover
+            - const: stop-ack
+            - const: pong
+            - const: wake-ack
+
+    else:
+      properties:
+        interrupts:
+          minItems: 5
+          items:
+            - description: Watchdog interrupt
+            - description: Fatal interrupt
+            - description: Ready interrupt
+            - description: Handover interrupt
+            - description: Stop acknowledge interrupt
+            - description: Shutdown acknowledge interrupt
+
+        interrupt-names:
+          minItems: 5
+          items:
+            - const: wdog
+            - const: fatal
+            - const: ready
+            - const: handover
+            - const: stop-ack
+            - const: shutdown-ack
+
 additionalProperties: true

-- 
2.25.1



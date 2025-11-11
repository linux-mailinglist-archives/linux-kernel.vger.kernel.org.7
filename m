Return-Path: <linux-kernel+bounces-895004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91255C4CAF0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0323E421B36
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D0C2F5A28;
	Tue, 11 Nov 2025 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="K6pAVydt"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EA62F3C2C;
	Tue, 11 Nov 2025 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853430; cv=none; b=NXfFGrcoVPMQN72GWt9EbI84IwdDf6qHes3MTxeZsnP8BVROWClQMiYQ5Wtyf2Xf6bIaw5hXUj9Si4BHwaxGQvGVk4TNK6eBHs3BNL12hMbVqurlvKAWuB8/MXG+SGp90cpmS2b61bq8+6dBTasGXN59aOOhpQTVIQ96n8NHRCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853430; c=relaxed/simple;
	bh=q/+UGrfEYnd7OS1mNZHwDDrVEYkRSR1wjd4fofnbsxU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p821/fbMOLW9h8/Lmnm8drQkb/KqAtUXogWwwWOtvWbxKeyHw3BCMTOgkRlU43BUIR3gFCLz7tdxngWraEoTqz+6gk7YDVSjcN/nTPCmz+IEQCjoXQGGgeaZPDzd8/F/gbv8K9nydMFGU3n7XvCg888kdw3BkuPlxXbdBdFwlI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=K6pAVydt; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AB9U03H03459977, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762853400; bh=T26tsWFQAHQcHBEFzzxd44dLBhgLcJCE21QiVXnNjNQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=K6pAVydtCDPifWvldfN44U6R18krME3PQsHIAE4c70kfe9eh1nVyIFTdRG5VLClNa
	 3Te+iTSq01WyMCb3QZf6iW0h7iAGMGNYREQnQ4jkQ6xIdH+3k9TOyo3rnvVvpRxU4J
	 Zh/Z4NGtcVQPt9POULd+yxIYI/u4LN4y2WGy455ZQ/tOyYAgVu4ERtRIjFSq2lDvxh
	 0WTFxIzM4mmTp5jpC8FwMMlHQuFTxaO4hQ3+vzXg1CVbTvs6b8/6P5AmMcMGsMeTg1
	 5O87lCVW/COWs3SRfWgyyXXeyw1kH679KxEUx2vlA7zvpodKGeupwFGBES6u6KCgGX
	 u4NYYpBImT7YA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AB9U03H03459977
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 17:30:00 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 11 Nov 2025 17:30:00 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 11 Nov 2025 17:30:00 +0800
Received: from ww-haowen.ting (172.21.177.97) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server id 15.2.1544.27 via Frontend
 Transport; Tue, 11 Nov 2025 17:30:00 +0800
From: Hao-Wen Ting <haowen.ting@realtek.com>
To: <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC: <jinn.cheng@realtek.com>, <edwardwu@realtek.com>, <phelic@realtek.com>,
        <shawn.huang724@realtek.com>, <haowen.ting@realtek.com>,
        <cy.huang@realtek.com>, <james.tai@realtek.com>, <cylee12@realtek.com>,
        <phinex@realtek.com>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
        <robh@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: timer: Add Realtek SYSTIMER binding
Date: Tue, 11 Nov 2025 17:29:58 +0800
Message-ID: <20251111092959.616089-2-haowen.ting@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111092959.616089-1-haowen.ting@realtek.com>
References: <20251111092959.616089-1-haowen.ting@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add device tree binding documentation for the Realtek SYSTIMER, a 64-bit
timer that can be used as a tick broadcast timer on multi-core Realtek
SoCs.

The SYSTIMER remains active during deep CPU idle states where local
timers are powered off, allowing all CPUs to enter power-cut idle states
simultaneously for improved power efficiency. The timer operates at a
fixed 1MHz frequency and supports oneshot mode for tick broadcast
functionality.

This binding defines the required properties for memory-mapped register
access and interrupt configuration needed by the timer driver.

Signed-off-by: Hao-Wen Ting <haowen.ting@realtek.com>
---
 .../bindings/timer/realtek,systimer.yaml      | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/realtek,systimer.yaml

diff --git a/Documentation/devicetree/bindings/timer/realtek,systimer.yaml b/Documentation/devicetree/bindings/timer/realtek,systimer.yaml
new file mode 100644
index 000000000000..28ab9b91f45d
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/realtek,systimer.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/realtek,systimer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek SYSTIMER
+
+maintainers:
+  - Hao-Wen Ting <hao-wen.ting@realtek.com>
+
+description: |
+  The Realtek SYSTIMER is a 64-bit timer that can be used as a tick
+  broadcast timer on multi-core Realtek SoCs. It remains active during
+  deep CPU idle states where local timers are powered off, allowing all
+  CPUs to enter power-cut idle states simultaneously for better power
+  efficiency.
+
+  The timer operates at a fixed 1MHz frequency and supports oneshot mode
+  for tick broadcast functionality.
+
+properties:
+  compatible:
+    const: realtek,systimer
+
+  reg:
+    description: |
+      Physical base address and length of the timer's memory mapped
+      registers. The register range contains the 64-bit timestamp counter,
+      compare value registers, control and status registers.
+    maxItems: 1
+
+  interrupts:
+    description: |
+      Timer interrupt specifier. This interrupt is triggered when the
+      timer compare value matches the current timestamp counter.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    systimer: systimer@89420 {
+        compatible = "realtek,systimer";
+        reg = <0x89420 0x18>;
+        interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.34.1



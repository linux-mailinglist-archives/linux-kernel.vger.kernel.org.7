Return-Path: <linux-kernel+bounces-635083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DF3AAB8A7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 08:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946953B7E2A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 06:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A8229242C;
	Tue,  6 May 2025 04:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B64oE3A7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FEB30037D;
	Tue,  6 May 2025 02:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746498214; cv=none; b=CrwGSLwWiT7c1TlTNCIBoJLCqb4FXlAV7xd7l4f6/2EP9XmJ9Cu3ivP8vdnmpbAyyHQrAwc3dXZ34XMp2FiDDDW97a9PJbSRedP4lDe0K2gZVj6pgPdDvjkCyJQeffnH8gXieOKJFeaG7BPMNUfMPjfSTfYldGYZ6uFuXaeqnnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746498214; c=relaxed/simple;
	bh=PlcCyqGeJ+hlmKFOd1cg9NQSi+thrfDLcnZzzn+MdkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C0OAJ9Z0HEmAhVMkuMfaGN1gskgaIXh7HYrmo/cbOivnuL4c+7tD4hekdIgrBJ16Hmkco1R4xGOwOrTuv7zDZSrYWi11tTDaRUw30f+2sA+dg1wuK22lEU59jhbZieiRxE6ISR+70YKUWMXW4iF38eZCwDuYh45cx3l7uTapLGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B64oE3A7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA62C4CEE4;
	Tue,  6 May 2025 02:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746498213;
	bh=PlcCyqGeJ+hlmKFOd1cg9NQSi+thrfDLcnZzzn+MdkM=;
	h=From:To:Cc:Subject:Date:From;
	b=B64oE3A7knBQekF6ZWd6GcHN0s+6V4PBU49Nze4TKr5qnB0t7rgBPreeNdqH8XMTk
	 ODpzmx9UdCOSrRHxVi/F8YIgoeLayCeMjMA5kki57V4yFvsaAmHBlFnZAOgQX/faH/
	 f5JyT8sRq4kzhq1403/CIKI3CDLbMoXhBezqlZst3dkOV6NX3AmNpf40jZUL/dZv/R
	 fPCR6mZzYtY4dcTDxa6A16wzp3tpEqBhsAqhWIH5sZV4VA174SPdomZ7CJgXr0sT8N
	 0lpFny+rG+06hFyqUJUo9xTBHWcjY3JuFz/EH/NsN+L20M72Bu9tvtHoCVk+dgM8py
	 Mbt/kiIc6EajA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Alexander A. Klimov" <grandmaster@al2klimov.de>,
	Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: timer: Convert ti,keystone-timer to DT schema
Date: Mon,  5 May 2025 21:23:29 -0500
Message-ID: <20250506022330.2589598-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the TI Keystone Timer binding to DT schema format. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/timer/ti,keystone-timer.txt      | 29 ---------
 .../bindings/timer/ti,keystone-timer.yaml     | 63 +++++++++++++++++++
 2 files changed, 63 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/ti,keystone-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/ti,keystone-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/ti,keystone-timer.txt b/Documentation/devicetree/bindings/timer/ti,keystone-timer.txt
deleted file mode 100644
index d3905a5412b8..000000000000
--- a/Documentation/devicetree/bindings/timer/ti,keystone-timer.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-* Device tree bindings for Texas instruments Keystone timer
-
-This document provides bindings for the 64-bit timer in the KeyStone
-architecture devices. The timer can be configured as a general-purpose 64-bit
-timer, dual general-purpose 32-bit timers. When configured as dual 32-bit
-timers, each half can operate in conjunction (chain mode) or independently
-(unchained mode) of each other.
-
-It is global timer is a free running up-counter and can generate interrupt
-when the counter reaches preset counter values.
-
-Documentation:
-https://www.ti.com/lit/ug/sprugv5a/sprugv5a.pdf
-
-Required properties:
-
-- compatible : should be "ti,keystone-timer".
-- reg : specifies base physical address and count of the registers.
-- interrupts : interrupt generated by the timer.
-- clocks : the clock feeding the timer clock.
-
-Example:
-
-timer@22f0000 {
-	compatible = "ti,keystone-timer";
-	reg = <0x022f0000 0x80>;
-	interrupts = <GIC_SPI 110 IRQ_TYPE_EDGE_RISING>;
-	clocks = <&clktimer15>;
-};
diff --git a/Documentation/devicetree/bindings/timer/ti,keystone-timer.yaml b/Documentation/devicetree/bindings/timer/ti,keystone-timer.yaml
new file mode 100644
index 000000000000..1caf5ce64f01
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/ti,keystone-timer.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ti,keystone-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI Keystone timer
+
+maintainers:
+  - Alexander A. Klimov <grandmaster@al2klimov.de>
+  - Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
+
+description: >
+  A 64-bit timer in the KeyStone architecture devices. The timer can be
+  configured as a general-purpose 64-bit timer, dual general-purpose 32-bit
+  timers. When configured as dual 32-bit timers, each half can operate in
+  conjunction (chain mode) or independently (unchained mode) of each other.
+
+  It is global timer is a free running up-counter and can generate interrupt
+  when the counter reaches preset counter values.
+
+  Documentation:
+  https://www.ti.com/lit/ug/sprugv5a/sprugv5a.pdf
+
+properties:
+  compatible:
+    const: ti,keystone-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: irq
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: timer
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    timer@22f0000 {
+        compatible = "ti,keystone-timer";
+        reg = <0x022f0000 0x80>;
+        interrupts = <110 IRQ_TYPE_EDGE_RISING>;
+        clocks = <&clktimer15>;
+    };
-- 
2.47.2



Return-Path: <linux-kernel+bounces-780236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 391B3B2FF17
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F10454E6337
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6E72FB618;
	Thu, 21 Aug 2025 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaMyIwxv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677132FB607;
	Thu, 21 Aug 2025 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790908; cv=none; b=ZR9YidmplBtIdHDYA2xP9ZobT3Mh+MdamMLKu4CNoje1b165KA4t8nV0/qPNAZz9uUXu1YI+M9dCruYr1ps4T6cWok+lyRQsgRvt6cX2lA1Gi3OMHVfJPsDMMd/iIU9D+/V6Oz0theZ8uGtzoc7+NjzBkZ5/EpavIBNI4fc/8RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790908; c=relaxed/simple;
	bh=KUPgivL1UrYkdtmomghdO7TapWVL017myryfAdIBAUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdWstEcHVZ4F/LxTlRaPJcsYetelzArHGmPL6+eIyzPGLi/aMawzBzQ71aft3b3xH7kFVWDVKNJJYsa/RK8SQf/8iB5yEzDe+p/6TUuB24M9GAfpmmsAFqVc7I7xaEjwuqZBZWIrTldrLEsUlY2Op1PPhhrjm1JaX1YSHt36UXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaMyIwxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E33C4CEEB;
	Thu, 21 Aug 2025 15:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755790907;
	bh=KUPgivL1UrYkdtmomghdO7TapWVL017myryfAdIBAUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RaMyIwxvK/qPv005WCquizlxmTujZRhlbS/r9Y3mAwcfX5Mt5eyqkKdtDmAHiynNC
	 2QS630ul8+m5+IIACEShZimkNoe9U0A+bT0LHxWD3yva1ZYRle4amhTMqjNU5faHeV
	 575boSRyi3qVWVgmLJIDCBO9HBLByDqlnVIW3Uw3puJbC5aEeaEKmJM2EcdikfOIF+
	 vhJCLRvrzhNt46ID3VwPs4jlSfDmSGfHy1eA2swVYgeqYS5dW1ZiuMHfSnILDzBnF2
	 n/IHs3k2vKBFezXleyp0LSL3fRMLyK+yC7dSMiPotmnPR8Guar7fhKUFn/exfwpVLf
	 yN7+9s7yHXDkw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: timer: Add ARM SSE(Subsystems for Embedded) timer
Date: Thu, 21 Aug 2025 23:24:28 +0800
Message-ID: <20250821152429.26995-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250821152429.26995-1-jszhang@kernel.org>
References: <20250821152429.26995-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding doc for the ARM SSE(Subsystems for Embedded) timer. Here
is the document URL:
https://developer.arm.com/documentation/107610/0000/System-timer-components?lang=en

Although the IP is mostly seen on MCU SoC platforms, but nothing
prevent it from being integrated into linux capable SoC platforms.

The IP core may have a system counter to generate timestamp value,
a system timer to raise an interrupt when a period has elapsed, and
a System Watchdog to detect errant system behaviour then reset the
system if a period elapses without ping.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../bindings/timer/arm,sse_timer.yaml         | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/arm,sse_timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/arm,sse_timer.yaml b/Documentation/devicetree/bindings/timer/arm,sse_timer.yaml
new file mode 100644
index 000000000000..37a79f9052d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/arm,sse_timer.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/arm,sse_timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM SSE(Subsystems for Embedded) system timer
+
+maintainers:
+  - Jisheng Zhang <jszhang@kernel.org>
+
+description: |+
+  ARM SSE(Subsystems for Embedded) system timer core may have a system counter
+  to generate timestamp value, a system timer to raise an interrupt when a
+  period has elapsed, and a System Watchdog to detect errant system behaviour
+  then reset the system if a period elapses without ping.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - arm,sse-timer
+
+  reg:
+    maxItems: 1
+    description: The system counter control frame base
+
+  clocks:
+    maxItems: 1
+
+  '#address-cells':
+    enum: [1, 2]
+
+  '#size-cells':
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  '^frame@[0-9a-f]+$':
+    type: object
+    additionalProperties: false
+    description: A timer node has some frame sub-nodes, each frame can be timer frame or watchdog frame. Each frame has the following properties.
+    properties:
+      interrupts:
+        minItems: 1
+        items:
+          - description: timer irq
+
+      reg:
+        minItems: 1
+        items:
+          - description: 1st view base address
+          - description: 2nd optional view base address if this is a watchdog frame
+
+    required:
+      - interrupts
+      - reg
+
+required:
+  - compatible
+  - reg
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    timer@f7f3e000 {
+      compatible = "arm,sse-timer";
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges;
+      reg = <0xf7f3e000 0x2000>;
+      clocks = <&core_clk>;
+
+      frame@f7f20000 {
+        reg = <0xf7f20000 0x1000>;
+        interrupts = <0 26 0x8>;
+      };
+
+      frame@f7f30000 {
+        interrupts = <0 15 0x8>;
+        reg = <0xf7f32000 0x1000>,
+              <0xf7f33000 0x1000>;
+      };
+    };
+
+...
-- 
2.50.1



Return-Path: <linux-kernel+bounces-765400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71762B2328A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8743B0060
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CA42F4A02;
	Tue, 12 Aug 2025 18:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQju3OOP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC1920409A;
	Tue, 12 Aug 2025 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022430; cv=none; b=Y3fdP2pfmcYByjH4QjDRwSQXNRgYrneqKHUfJAUAJGWjnWvhD5lR1afKXYzgPss5mIWVwKPSsmCK5ejqax1llBuQwrRV8QywVAeTl5uLlbJMbBKOXp65UNH2e3AS3KRDKMpBrErGMqqmbfYLvxGiiTbyrEfEvW/04F5QvfDhOiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022430; c=relaxed/simple;
	bh=2G9iWlo23GHxJ65AxMwzRiYfucjYHe/ztpYSv1VBrOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W3s175tesgJfM3yCNQSGtRwz26ICpDN+jbfEb2kRbyR0NR7lSHHnmeyySeXPmT90XeRVYiQALnJNMHCH8Gb1xglLKXeTj6BtVmAceT0WLqqU8p9s2mHVFsBXSLaCX7AlMtYknQVpngKZEgZoDPSuDdqeAqhcIRJbExtzs9HkZhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQju3OOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B12C4CEF0;
	Tue, 12 Aug 2025 18:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755022430;
	bh=2G9iWlo23GHxJ65AxMwzRiYfucjYHe/ztpYSv1VBrOs=;
	h=From:To:Cc:Subject:Date:From;
	b=eQju3OOPGRBU8gqJkHFznbsclSPjdm3XbsGXpJ0hyscmGPlsNhrAxAlHYxbSL+egM
	 0YhqKNCSY8Y6sS+ZtcxQl8cR0o7DIyUuBMzbUFmKd5oeVXy+SXJNRDjpzAdNAS1xhB
	 N+Ic2Ta4ecBcWE1gW4hAZwSSr38+KlJYJeueN96A8/m2zQ2+814xGgjtowSULTPKMv
	 hG2O8Xu7tZ/fQXL8KzVPN0ERHutxYLPX/mj2Qu/FGL06quL/LCRCO1jMJX8RFfjhB0
	 9d8SCM6CaHizp1EwVrjGW3DXwFEJOaY+zNsK+6cu4HiCc2QQUOn/S1Uhbf5aKlUsw7
	 rB52QZFgKWNyw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH] dt-bindings: mailbox: Convert rockchip,rk3368-mailbox to DT schema
Date: Tue, 12 Aug 2025 13:13:46 -0500
Message-ID: <20250812181348.62137-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the rockchip,rk3368-mailbox binding to DT schema format. Add
the missing 'clocks' and 'clock-names' properties. Document that it's
one interrupt per mailbox channel (and there are 4 channels).

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../mailbox/rockchip,rk3368-mailbox.yaml      | 56 +++++++++++++++++++
 .../bindings/mailbox/rockchip-mailbox.txt     | 32 -----------
 2 files changed, 56 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/rockchip,rk3368-mailbox.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/rockchip-mailbox.txt

diff --git a/Documentation/devicetree/bindings/mailbox/rockchip,rk3368-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/rockchip,rk3368-mailbox.yaml
new file mode 100644
index 000000000000..107bc96a8f3d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/rockchip,rk3368-mailbox.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/rockchip,rk3368-mailbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip RK3368 Mailbox Controller
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+description:
+  The Rockchip mailbox is used by the Rockchip CPU cores to communicate
+  requests to MCU processor.
+
+properties:
+  compatible:
+    const: rockchip,rk3368-mailbox
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: pclk_mailbox
+
+  interrupts:
+    description: One interrupt for each channel
+    maxItems: 4
+
+  '#mbox-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#mbox-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    mailbox@ff6b0000 {
+        compatible = "rockchip,rk3368-mailbox";
+        reg = <0xff6b0000 0x1000>;
+        interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+        #mbox-cells = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/mailbox/rockchip-mailbox.txt b/Documentation/devicetree/bindings/mailbox/rockchip-mailbox.txt
deleted file mode 100644
index b6bb84acf5be..000000000000
--- a/Documentation/devicetree/bindings/mailbox/rockchip-mailbox.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-Rockchip mailbox
-
-The Rockchip mailbox is used by the Rockchip CPU cores to communicate
-requests to MCU processor.
-
-Refer to ./mailbox.txt for generic information about mailbox device-tree
-bindings.
-
-Required properties:
-
- - compatible: should be one of the following.
-   - "rockchip,rk3368-mbox" for rk3368
- - reg: physical base address of the controller and length of memory mapped
-	region.
- - interrupts: The interrupt number to the cpu. The interrupt specifier format
-	depends on the interrupt controller.
- - #mbox-cells: Common mailbox binding property to identify the number
-	of cells required for the mailbox specifier. Should be 1
-
-Example:
---------
-
-/* RK3368 */
-mbox: mbox@ff6b0000 {
-	compatible = "rockchip,rk3368-mailbox";
-	reg = <0x0 0xff6b0000 0x0 0x1000>,
-	interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
-	#mbox-cells = <1>;
-};
-- 
2.47.2



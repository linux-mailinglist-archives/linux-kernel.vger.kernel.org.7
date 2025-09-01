Return-Path: <linux-kernel+bounces-794379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB5EB3E0E0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CACF2010C4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EC0311C24;
	Mon,  1 Sep 2025 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bq6Y8EX7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51C1217F55;
	Mon,  1 Sep 2025 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724704; cv=none; b=A9zS9kLkGT4ItGJbMhx1WYDv/i8HhdxUYNDfNuqvJv0M8+NJ0hyJ/RNDCxMjt4gH+H7OQT/r6ZCB4bu9cMx1nHGbY0t54qLJ2O7yqSItWyF9q+eCFKkYLEc5ByKXqmCWb+sTp7dS4+4TOuGIrN77F85Y394DKJyfoIqsZlYfHRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724704; c=relaxed/simple;
	bh=m5ocoAhQ9i2Yxyd23Uis14ToLuXf0jZLSM0DHyjyLJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPT47HyorcJ0hShw8ZjDp/Rc+xtY+Y8JGe0mDjVYuCbwf4olkfvtH35mMWMAM7XZbBP4yElwVAdCWthlhzic+jhEGns3QZNBlHKR/aeeRivHcc+qqT91FR9ff27jVBgD0yJvLy+n8t18jnk0Tu0XN/uKF4f9TYME3pSewUZZDJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bq6Y8EX7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8390C4CEF0;
	Mon,  1 Sep 2025 11:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756724703;
	bh=m5ocoAhQ9i2Yxyd23Uis14ToLuXf0jZLSM0DHyjyLJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bq6Y8EX7ppY3fE5wNtkCzbJNicM5PKEp91aTlMiYjbAboyoWAEzuxiY9IJLz0KRlb
	 A9wL4kRm0TKg40uteBK4RO7HJXqRw5zaiQNNHzWU93qcypItGmQr+X6E7fNRv6yUrP
	 ApbWsR4AyVBjjGdOb9soTx+0d6vWxshEGG+RIJjqV7mw/t4rcu5StTREgBQb268lhY
	 i9mFVs7zDJuaeBr4CG9xDrMYdxh4YBALwZXlmV9YAA8dSeRbupxonBixMTz84KlCzw
	 K9sEuy5Dnc04kp9dpUeQurzsNSwYejCclUJpdz6bdgErQp6ae1UjtPPqkj+jCBNrxE
	 uItuv34qUBjNw==
From: Conor Dooley <conor@kernel.org>
To: sboyd@kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 2/9] dt-bindings: soc: microchip: document the simple-mfd syscon on PolarFire SoC
Date: Mon,  1 Sep 2025 12:04:14 +0100
Message-ID: <20250901-garbage-hardship-027861fb3380@spud>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901-rigid-sacrifice-0039c6e6234e@spud>
References: <20250901-rigid-sacrifice-0039c6e6234e@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2943; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=b+aGSGhQUJdmsPs1oLuFh7qLo75fMDz/w1qPMM5tYX0=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBlba9eGXrq6UORSxIapJ96K6FccM8zh8rKbsqHPteSd8 Emb/PnrO0pZGMS4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCR2RqMDPcn6Z0+Ofdaqq6k 6/9Ixpz1y1Tf2TK8O6gc/d9TY+Pdb+YMPxnNP1Q5RN/+LZM06eaRdbGbHrFEex9rmeBlfv7n/XM b8lgB
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

"mss-top-sysreg" contains clocks, pinctrl, resets, an interrupt controller
and more. At this point, only the reset controller child is described as
that's all that is described by the existing bindings.
The clock controller already has a dedicated node, and will retain it as
there are other clock regions, so like the mailbox, a compatible-based
lookup of the syscon is sufficient to keep the clock driver working as
before, so no child is needed. There's also an interrupt multiplexing
service provided by this syscon, for which there is work in progress at
[1].

Link: https://lore.kernel.org/linux-gpio/20240723-uncouple-enforcer-7c48e4a4fefe@wendy/ [1]
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
v3:
- drop simple-mfd at Krzysztof's request since the child nodes do not
  yet exist.

v2:
- clean up various minor comments from Rob on mpfs-mss-top-sysreg
- remove mpfs-control-scb from this patch
---
 .../microchip,mpfs-mss-top-sysreg.yaml        | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml

diff --git a/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml
new file mode 100644
index 0000000000000..1ab691db87950
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PolarFire SoC Microprocessor Subsystem (MSS) sysreg register region
+
+maintainers:
+  - Conor Dooley <conor.dooley@microchip.com>
+
+description:
+  An wide assortment of registers that control elements of the MSS on PolarFire
+  SoC, including pinmuxing, resets and clocks among others.
+
+properties:
+  compatible:
+    items:
+      - const: microchip,mpfs-mss-top-sysreg
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  '#reset-cells':
+    description:
+      The AHB/AXI peripherals on the PolarFire SoC have reset support, so
+      from CLK_ENVM to CLK_CFM. The reset consumer should specify the
+      desired peripheral via the clock ID in its "resets" phandle cell.
+      See include/dt-bindings/clock/microchip,mpfs-clock.h for the full list
+      of PolarFire clock/reset IDs.
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@20002000 {
+      compatible = "microchip,mpfs-mss-top-sysreg", "syscon";
+      reg = <0x20002000 0x1000>;
+      #reset-cells = <1>;
+    };
+
-- 
2.47.2



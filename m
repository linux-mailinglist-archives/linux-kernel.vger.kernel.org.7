Return-Path: <linux-kernel+bounces-852994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB94ABDA718
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 880565464A2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6760E303A27;
	Tue, 14 Oct 2025 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMkaAH4V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFB23009D4;
	Tue, 14 Oct 2025 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455793; cv=none; b=j1XQWKi8WN7G9scTqLgLlqifMz8E6LUlB14GppTm3GpgaMApJ0sI5c6NWHZ7qSCgsvFYaGIeOTdfCAm2Mi0Cs/acguuvWhw/74+oP4MZW647NzVOhMouA9nDKwC8IcGijt67ppD7EfDZqNiIemql979tk0+kqmXoU3ZF9hnbhog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455793; c=relaxed/simple;
	bh=zYExi83W0RHyJrqMwtyqJRZDpbfqUykmcag8kOhkVUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WpP3fCN/FAyeO/tZaFyw7dOjdU068HiY4vz9IlQVRT31a5YJLmDYsqrBFayvicpVXz20dW9grdyOw/MxcJopBdIzKrJRj9SrFbf4EO9BWc7gbW+xFIHAz3+QU2WKZKED0EcmwQm5YtRxnLV80Ikd7LNsIfqxbENqTxpc8SXusWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMkaAH4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40A1C4CEE7;
	Tue, 14 Oct 2025 15:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760455793;
	bh=zYExi83W0RHyJrqMwtyqJRZDpbfqUykmcag8kOhkVUI=;
	h=From:To:Cc:Subject:Date:From;
	b=eMkaAH4VUyJhLA+HEJG27I9pneelGaB8Y6DWmSQOO2qeeoZXmbHeHdaRSz/LHr53U
	 JPYOf98BlNoLSMpffIHQoztBZpWlMtYt//Z+NMY0C8lTN6IkgBtGj+7sZaFBKvazQK
	 E9CtgO2JZrsSYLEub6xnkVsKyOp4AhLYEisIjvdpRIP1O2+7+P2jkRaUBf1tzHqlfH
	 Od4tZLfPZ1AKRu1RegKMPhC2hGkEE4jilFtA7C3oxCdksozbgdtDOoVcIe2rNQvbih
	 2H4v9pDdDYwYpxfza+OAhd/gDcolFANkctu1tFo+4aYdsjhR+LX7aiqEH1EE3GDS1/
	 ocRhZ/HwW3phw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Corey Minyard <corey@minyard.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: openipmi-developer@lists.sourceforge.net,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: ipmi: Convert aspeed,ast2400-ibt-bmc to DT schema
Date: Tue, 14 Oct 2025 10:29:47 -0500
Message-ID: <20251014152948.3782738-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the aspeed,ast2400-ibt-bmc binding to DT schema format. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/ipmi/aspeed,ast2400-ibt-bmc.txt  | 28 ------------
 .../bindings/ipmi/aspeed,ast2400-ibt-bmc.yaml | 44 +++++++++++++++++++
 2 files changed, 44 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.txt
 create mode 100644 Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.yaml

diff --git a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.txt b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.txt
deleted file mode 100644
index 25f86da804b7..000000000000
--- a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-* Aspeed BT (Block Transfer) IPMI interface
-
-The Aspeed SOCs (AST2400 and AST2500) are commonly used as BMCs
-(BaseBoard Management Controllers) and the BT interface can be used to
-perform in-band IPMI communication with their host.
-
-Required properties:
-
-- compatible : should be one of
-	"aspeed,ast2400-ibt-bmc"
-	"aspeed,ast2500-ibt-bmc"
-	"aspeed,ast2600-ibt-bmc"
-- reg: physical address and size of the registers
-- clocks: clock for the device
-
-Optional properties:
-
-- interrupts: interrupt generated by the BT interface. without an
-  interrupt, the driver will operate in poll mode.
-
-Example:
-
-	ibt@1e789140 {
-		compatible = "aspeed,ast2400-ibt-bmc";
-		reg = <0x1e789140 0x18>;
-		interrupts = <8>;
-		clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
-	};
diff --git a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.yaml b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.yaml
new file mode 100644
index 000000000000..c4f7cdbbe16b
--- /dev/null
+++ b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-ibt-bmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed Block Transfer (BT) IPMI interface
+
+maintainers:
+  - Joel Stanley <joel@jms.id.au>
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2400-ibt-bmc
+      - aspeed,ast2500-ibt-bmc
+      - aspeed,ast2600-ibt-bmc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/aspeed-clock.h>
+
+    bt@1e789140 {
+        compatible = "aspeed,ast2400-ibt-bmc";
+        reg = <0x1e789140 0x18>;
+        interrupts = <8>;
+        clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
+    };
-- 
2.51.0



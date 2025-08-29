Return-Path: <linux-kernel+bounces-792552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253C4B3C57D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 01:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2633B5D44
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 23:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE03335AAAA;
	Fri, 29 Aug 2025 23:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQWJI8lu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA4F35A2B6;
	Fri, 29 Aug 2025 23:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756508697; cv=none; b=g251wLNnmdSzfC/6jdQ1hMKKAOJ27XXHDH1a5yZUCe7hGK8QStM0Gwbm+qxHoaVHhXs8vl7VkCJ2Ku/dgE15BFrm5rKXpwLn+h7OhodWn6dvsaS7yftj4Tw3NV0Ordqtqgq4l0yGppoyccsdVXVagnKvyZRQCw014w+Cjjh9K78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756508697; c=relaxed/simple;
	bh=cKMacLufL0Sp3xKcp2iVoauAa71+tRMKOtJUQm7TvL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jeb51UJfKy00Cm9jqzSXiK+024xyoCDRhbJR9FTaIE4xkCw1wqLXvEuh4fu8W2t5toJvmr4EhzRyPEINHopnK4fAH+cl76T3DeKroMJQRpJBzQeqg6POFo/JaUKEpx7S5yyN55g59YLYnLqxSFKFBYNqRDWnr6YM/eIIFwoz23I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQWJI8lu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA53C4CEF0;
	Fri, 29 Aug 2025 23:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756508695;
	bh=cKMacLufL0Sp3xKcp2iVoauAa71+tRMKOtJUQm7TvL8=;
	h=From:To:Cc:Subject:Date:From;
	b=VQWJI8lunJdXCat2wSxvf1PIhGKg4VXqvOMHKs1L/fyq2QteJo8FIXHCA0V85r81X
	 GInwbhqCJ7F1ejqHbzMMDPfRLMCDQBt5nrV1kXSwXJMO3NZm0jlUYkc0P3kvn9MCm+
	 9I3ebWWQQ3+rHdTZ/Mej30ZJHmGFag4zXBZyH9fN57IEnLjUHveG0GZ07vNxdjQiWh
	 iqIaA8qgF1QFZNVmAj8hD+FNrllDuy590NmEFJUtO7xeedVW6S05LipOQ/tYgE/zFp
	 lSTr1SIVMYbYdB+7hXc7liv+zIeomgASI4gTb6dNTxnTT5KcwSHrXVH3Lz5jkIy1hF
	 6bDnrOTMNcB6Q==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: Convert aspeed,ast2400-p2a-ctrl to DT schema
Date: Fri, 29 Aug 2025 18:04:49 -0500
Message-ID: <20250829230450.1496151-1-robh@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the aspeed,ast2x00-p2a-ctrl binding to DT schema format. The schema
is simple enough to just add it to the parent aspeed,ast2x00-scu binding.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/mfd/aspeed,ast2x00-scu.yaml      | 33 ++++++++++++-
 .../bindings/misc/aspeed-p2a-ctrl.txt         | 46 -------------------
 2 files changed, 32 insertions(+), 47 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt

diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
index 5eccd10d95ce..5adb7f6aca45 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
@@ -48,8 +48,34 @@ properties:
 
 patternProperties:
   '^p2a-control@[0-9a-f]+$':
-    description: See Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
+    description: >
+      PCI-to-AHB Bridge Control
+
+      The bridge is available on platforms with the VGA enabled on the Aspeed
+      device. In this case, the host has access to a 64KiB window into all of
+      the BMC's memory. The BMC can disable this bridge. If the bridge is
+      enabled, the host has read access to all the regions of memory, however
+      the host only has read and write access depending on a register
+      controlled by the BMC.
     type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        enum:
+          - aspeed,ast2400-p2a-ctrl
+          - aspeed,ast2500-p2a-ctrl
+      reg:
+        maxItems: 1
+
+      memory-region:
+        maxItems: 1
+        description:
+          A reserved_memory region to be used for the PCI to AHB mapping
+
+    required:
+      - compatible
+      - reg
 
   '^pinctrl(@[0-9a-f]+)?$':
     type: object
@@ -123,6 +149,11 @@ examples:
         #size-cells = <1>;
         ranges = <0x0 0x1e6e2000 0x1000>;
 
+        p2a-control@2c {
+            compatible = "aspeed,ast2400-p2a-ctrl";
+            reg = <0x2c 0x4>;
+        };
+
         silicon-id@7c {
             compatible = "aspeed,ast2500-silicon-id", "aspeed,silicon-id";
             reg = <0x7c 0x4>, <0x150 0x8>;
diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
deleted file mode 100644
index f2e2e28b317c..000000000000
--- a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-======================================================================
-Device tree bindings for Aspeed AST2400/AST2500 PCI-to-AHB Bridge Control Driver
-======================================================================
-
-The bridge is available on platforms with the VGA enabled on the Aspeed device.
-In this case, the host has access to a 64KiB window into all of the BMC's
-memory.  The BMC can disable this bridge.  If the bridge is enabled, the host
-has read access to all the regions of memory, however the host only has read
-and write access depending on a register controlled by the BMC.
-
-Required properties:
-===================
-
- - compatible: must be one of:
-	- "aspeed,ast2400-p2a-ctrl"
-	- "aspeed,ast2500-p2a-ctrl"
-
-Optional properties:
-===================
-
-- reg: A hint for the memory regions associated with the P2A controller
-- memory-region: A phandle to a reserved_memory region to be used for the PCI
-		to AHB mapping
-
-The p2a-control node should be the child of a syscon node with the required
-property:
-
-- compatible : Should be one of the following:
-		"aspeed,ast2400-scu", "syscon", "simple-mfd"
-		"aspeed,ast2500-scu", "syscon", "simple-mfd"
-
-Example
-===================
-
-g4 Example
-----------
-
-syscon: scu@1e6e2000 {
-	compatible = "aspeed,ast2400-scu", "syscon", "simple-mfd";
-	reg = <0x1e6e2000 0x1a8>;
-
-	p2a: p2a-control {
-		compatible = "aspeed,ast2400-p2a-ctrl";
-		memory-region = <&reserved_memory>;
-	};
-};
-- 
2.50.1



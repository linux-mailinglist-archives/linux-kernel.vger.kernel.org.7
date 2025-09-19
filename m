Return-Path: <linux-kernel+bounces-825158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE89B8B22C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DB1A812A3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5961F3233E9;
	Fri, 19 Sep 2025 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hz3mMJ8r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8A4322C8D;
	Fri, 19 Sep 2025 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311616; cv=none; b=ZRW4ShES2G5uMzWhGWJTg04GciHHS33WyhdDUjFI61yCjHiIUb9/yN7yRQGeXuSdWYBZFDCcmmz+K5wZmA+p8SH1FIbiqtZRt7yN/4P2xX4ZyeoenYdEdCJfbw9VElxvRy2HUbf8Ds7i5j5lH0cSweGAnCJnEVffbnMtk/1uATo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311616; c=relaxed/simple;
	bh=BhNfeUjBhFH3Y3XO7HytlVMbwMMe+nuaGzu6cpTp5HM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZXtxX6O3avdYnoWZqiWqK5Udpf4vuPLdeISbbSpkgjb0Ri26vSyREFmfVon61N664NoHChjtujS2JHMfJk4LIUHmbTDhxfDYjz3t2RyEMKDjrfTlCuUFvvPMfuOcoecrDqT4phCXVhJ54tz+eiEgD+U+IDpNLAjuvOLFNxi7PIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hz3mMJ8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE43C4CEF7;
	Fri, 19 Sep 2025 19:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758311616;
	bh=BhNfeUjBhFH3Y3XO7HytlVMbwMMe+nuaGzu6cpTp5HM=;
	h=From:To:Cc:Subject:Date:From;
	b=Hz3mMJ8rxvRkBOSq9Jl5+9krcajggcFHmyy/8scaXT+Kvjirh6Fh8Ylsyv2h56ulQ
	 46cQAlRB1NWdUxXmIX3+WMHHTgSKp0uyXRSO0gZ3oYtrt3tXwfPEKDOPYCfWkaY0qz
	 ryUgP1C4NloC6qW9/EWMgVU3ISCij13e18BPdHW7Q5zrQ63AmU0wJhiw0Kg2/X+1Tp
	 HT8VH//kDlU3vIY61E0eqATpUFLgRpMce/4wcV9G1DCl2tfu9jWOes3G5vmGDoEWkt
	 rqnDkyzqO1uY1cmstFFfI1tp13naHvdenJ8dTBuFFieSs6jXWQhtcaWs40Fyw6plaI
	 tZHYct2FIXyxg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Stefan Schaeckeler <sschaeck@cisco.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: edac: Convert aspeed,ast2400-sdram-edac to DT schema
Date: Fri, 19 Sep 2025 14:53:24 -0500
Message-ID: <20250919195326.2079446-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the ASpeed SDRAM EDAC binding to DT schema. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../edac/aspeed,ast2400-sdram-edac.yaml       | 48 +++++++++++++++++++
 .../bindings/edac/aspeed-sdram-edac.txt       | 28 -----------
 MAINTAINERS                                   |  2 +-
 3 files changed, 49 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml
 delete mode 100644 Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt

diff --git a/Documentation/devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml b/Documentation/devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml
new file mode 100644
index 000000000000..09735826d707
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/edac/aspeed,ast2400-sdram-edac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed BMC SoC SDRAM EDAC controller
+
+maintainers:
+  - Stefan Schaeckeler <sschaeck@cisco.com>
+
+description: >
+  The Aspeed BMC SoC supports DDR3 and DDR4 memory with and without ECC (error
+  correction check).
+
+  The memory controller supports SECDED (single bit error correction, double bit
+  error detection) and single bit error auto scrubbing by reserving 8 bits for
+  every 64 bit word (effectively reducing available memory to 8/9).
+
+  Note, the bootloader must configure ECC mode in the memory controller.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2400-sdram-edac
+      - aspeed,ast2500-sdram-edac
+      - aspeed,ast2600-sdram-edac
+
+  reg:
+    maxItems: 1
+
+  interrupts:
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
+    sdram@1e6e0000 {
+        compatible = "aspeed,ast2500-sdram-edac";
+        reg = <0x1e6e0000 0x174>;
+        interrupts = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt b/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
deleted file mode 100644
index 8ca9e0a049d8..000000000000
--- a/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-Aspeed BMC SoC EDAC node
-
-The Aspeed BMC SoC supports DDR3 and DDR4 memory with and without ECC (error
-correction check).
-
-The memory controller supports SECDED (single bit error correction, double bit
-error detection) and single bit error auto scrubbing by reserving 8 bits for
-every 64 bit word (effectively reducing available memory to 8/9).
-
-Note, the bootloader must configure ECC mode in the memory controller.
-
-
-Required properties:
-- compatible: should be one of
-	- "aspeed,ast2400-sdram-edac"
-	- "aspeed,ast2500-sdram-edac"
-	- "aspeed,ast2600-sdram-edac"
-- reg:        sdram controller register set should be <0x1e6e0000 0x174>
-- interrupts: should be AVIC interrupt #0
-
-
-Example:
-
-	edac: sdram@1e6e0000 {
-		compatible = "aspeed,ast2500-sdram-edac";
-		reg = <0x1e6e0000 0x174>;
-		interrupts = <0>;
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index ec0aba646e7e..b6800e86286a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8848,7 +8848,7 @@ F:	drivers/edac/armada_xp_*
 EDAC-AST2500
 M:	Stefan Schaeckeler <sschaeck@cisco.com>
 S:	Supported
-F:	Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
+F:	Documentation/devicetree/bindings/edac/aspeed,ast2400-sdram-edac.yaml
 F:	drivers/edac/aspeed_edac.c
 
 EDAC-BLUEFIELD
-- 
2.51.0



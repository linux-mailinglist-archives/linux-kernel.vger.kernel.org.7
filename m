Return-Path: <linux-kernel+bounces-765569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 024B4B23A1B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 22:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73D707B7126
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F085D2D73B5;
	Tue, 12 Aug 2025 20:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTUw039H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5681E2D5A10;
	Tue, 12 Aug 2025 20:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755030840; cv=none; b=oPr6b49v0U0UKTDf2uowkcYY0v2ZmamBkWziaPyHJGl+ENI8q5CHb/YNbgkcFvnvtc7CsynR6yQ5NIPcTSc/eK+C2T7hh8m0rvbaA3CvpuFLffVZrIReUoRn0b7WMbI2B+fgOYtyzJkpuOUNH/lFAykPKaOAAaa2C/t8nXBCeP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755030840; c=relaxed/simple;
	bh=rzrbO5xcK/Wu8K8pRlisGVRhj7ITITPQ2YAOSrXQ0Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/4rnIocYDsqlwKWc6Wb4kg3F/eZ8g9406LXns8P0enNybj+G4N4avWxrjzIAZyerpPcR/y0jyWxo81BxEj7VyHcHtDulQQ0kkOAN3AKpvZAtlhOgLzPCrmXkqAjVj8kpVHiIozfP7POAzmrzAhBYmzcvW6/9sNKEZLfjbSeNVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTUw039H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFFCC4CEF4;
	Tue, 12 Aug 2025 20:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755030839;
	bh=rzrbO5xcK/Wu8K8pRlisGVRhj7ITITPQ2YAOSrXQ0Hc=;
	h=From:To:Cc:Subject:Date:From;
	b=UTUw039HaDFC5GMa5FZMvSy8rNq7IVpDg2j1hK9nszqq1zwk6lAS8G0W9wnDz1AOn
	 M+a+XAXAcg7fvVWyuVXo8EGb9udEGYpSM9u93/A9dDXBmR75kCBlWpO2sL+W7Rwo+Y
	 +rtJ/gvB2Z3eYuU48L9/4hsbIgpyFHSb761ma/PYWnYW3Q+YivS1ZCYiTUzQQ+eSaw
	 AkWXv1p3WOxgpcfdVTb93cftkDI9i8omUSBAX65U2eO6RGsoQHdZv9kKe2KHI1LaYR
	 OVZ97qu9UGbS8qO4Wh5c9wzcGly5nEx2yubLGjGJUxIk770NFgDs99DsFUMJVKNkuW
	 WoPyoOJ2TRb1g==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: Convert brcm,bcm2835-i2s to DT schema
Date: Tue, 12 Aug 2025 15:33:55 -0500
Message-ID: <20250812203356.735234-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Broadcom BCM2835 I2S/PCM binding to DT schema format. It's a
straightforward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/sound/brcm,bcm2835-i2s.txt       | 24 ---------
 .../bindings/sound/brcm,bcm2835-i2s.yaml      | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.yaml

diff --git a/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt b/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
deleted file mode 100644
index 7bb0362828ec..000000000000
--- a/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-* Broadcom BCM2835 SoC I2S/PCM module
-
-Required properties:
-- compatible: "brcm,bcm2835-i2s"
-- reg: Should contain PCM registers location and length.
-- clocks: the (PCM) clock to use
-- dmas: List of DMA controller phandle and DMA request line ordered pairs.
-- dma-names: Identifier string for each DMA request line in the dmas property.
-  These strings correspond 1:1 with the ordered pairs in dmas.
-
-  One of the DMA channels will be responsible for transmission (should be
-  named "tx") and one for reception (should be named "rx").
-
-Example:
-
-bcm2835_i2s: i2s@7e203000 {
-	compatible = "brcm,bcm2835-i2s";
-	reg = <0x7e203000 0x24>;
-	clocks = <&clocks BCM2835_CLOCK_PCM>;
-
-	dmas = <&dma 2>,
-	       <&dma 3>;
-	dma-names = "tx", "rx";
-};
diff --git a/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.yaml b/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.yaml
new file mode 100644
index 000000000000..f3cfe92684d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/brcm,bcm2835-i2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM2835 SoC I2S/PCM module
+
+maintainers:
+  - Florian Fainelli <florian.fainelli@broadcom.com>
+
+properties:
+  compatible:
+    const: brcm,bcm2835-i2s
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  dmas:
+    items:
+      - description: Transmission DMA controller phandle and request line.
+      - description: Reception DMA controller phandle and request line.
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - dmas
+  - dma-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/bcm2835.h>
+
+    i2s@7e203000 {
+        compatible = "brcm,bcm2835-i2s";
+        reg = <0x7e203000 0x24>;
+        clocks = <&clocks BCM2835_CLOCK_PCM>;
+        dmas = <&dma 2>, <&dma 3>;
+        dma-names = "tx", "rx";
+    };
-- 
2.47.2



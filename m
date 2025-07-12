Return-Path: <linux-kernel+bounces-728739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A96B02C65
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 20:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B494A5A9E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 18:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D8528DEF9;
	Sat, 12 Jul 2025 18:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkm/nvcA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6771E28DB48
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 18:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752344385; cv=none; b=JRtC7qrdtJDd10srDsgCd7GMCsyrptVPoCmekT1JDaJMb32sj7HJM2uVdKexsQaSiBgZWN67S1Mnb1j+ckE/DmmdCuWDb5AbyJweZLr5zkVW6WiBy2+F3S33Y0TfBMQa8u5jOz6lzUj06DaVEpRMQv16k4HLnFQHRjckjsb4GoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752344385; c=relaxed/simple;
	bh=18JA2CFvvLjj5f+98x4TkT52FEd6gHAjRqnjGDZeXd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQYOi2iGbW34vhG6qnto4WLG8ZCe1F1VP0lF35WS5GW7W6eTs+FDtli3QIrCpZo0QALyaxj5mDIj8Ino2EMzRJBZGi6mtigZoUIt5gGQoDP8veixb6HTEYIgFVpzFbkMMudQg9yEpZScp13ZFaU0mAPFexAXR3Yhu/dF64CTXvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkm/nvcA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3D6C4CEF5;
	Sat, 12 Jul 2025 18:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752344385;
	bh=18JA2CFvvLjj5f+98x4TkT52FEd6gHAjRqnjGDZeXd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jkm/nvcAjSdUO/lFEn7mG0fX7t+E6KdOwCNHvDIZm5VXiPhNiDGvXg/Lq9Zfu1iv9
	 fUYPgBQIxhiEtsATYNTrE952ea4BMe+PkgjvHDDB985Qaw+sGXU4JXSSfFfseu8Pjd
	 DRadXP4dCcEjWp+7wZzgVhsPgcZ6XtBF5XgUMRrOKkOpuTymVA/sh6/M8+9mZ1JKhY
	 0IxJnQqm0/tOQ8ws+NNQnHnERmn1WXQ/u8RsjqitvE+tK+3dDGrsSsl+csmYf5KzwT
	 hBy/Hz3ho8VgcwQF3OYZ0ymwGFm2PStCworxGK0Udp+GPqk7AVh+aiabXnseR39T5Q
	 D4dz3FA5DN0oQ==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 4/8] dt-bindings: nvmem: convert lpc1857-eeprom.txt to yaml format
Date: Sat, 12 Jul 2025 19:19:00 +0100
Message-ID: <20250712181905.6738-5-srini@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250712181905.6738-1-srini@kernel.org>
References: <20250712181905.6738-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Li <Frank.Li@nxp.com>

Convert lpc1857-eeprom.txt to yaml format.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 .../bindings/nvmem/lpc1857-eeprom.txt         | 28 ---------
 .../bindings/nvmem/nxp,lpc1857-eeprom.yaml    | 61 +++++++++++++++++++
 2 files changed, 61 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/nvmem/lpc1857-eeprom.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/nxp,lpc1857-eeprom.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/lpc1857-eeprom.txt b/Documentation/devicetree/bindings/nvmem/lpc1857-eeprom.txt
deleted file mode 100644
index 809df68f6e14..000000000000
--- a/Documentation/devicetree/bindings/nvmem/lpc1857-eeprom.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-* NXP LPC18xx EEPROM memory NVMEM driver
-
-Required properties:
-  - compatible: Should be "nxp,lpc1857-eeprom"
-  - reg: Must contain an entry with the physical base address and length
-    for each entry in reg-names.
-  - reg-names: Must include the following entries.
-    - reg: EEPROM registers.
-    - mem: EEPROM address space.
-  - clocks: Must contain an entry for each entry in clock-names.
-  - clock-names: Must include the following entries.
-    - eeprom: EEPROM operating clock.
-  - resets: Should contain a reference to the reset controller asserting
-    the EEPROM in reset.
-  - interrupts: Should contain EEPROM interrupt.
-
-Example:
-
-  eeprom: eeprom@4000e000 {
-    compatible = "nxp,lpc1857-eeprom";
-    reg = <0x4000e000 0x1000>,
-          <0x20040000 0x4000>;
-    reg-names = "reg", "mem";
-    clocks = <&ccu1 CLK_CPU_EEPROM>;
-    clock-names = "eeprom";
-    resets = <&rgu 27>;
-    interrupts = <4>;
-  };
diff --git a/Documentation/devicetree/bindings/nvmem/nxp,lpc1857-eeprom.yaml b/Documentation/devicetree/bindings/nvmem/nxp,lpc1857-eeprom.yaml
new file mode 100644
index 000000000000..24c71252846f
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/nxp,lpc1857-eeprom.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/nxp,lpc1857-eeprom.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP LPC18xx EEPROM memory
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    const: nxp,lpc1857-eeprom
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: reg
+      - const: mem
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: eeprom
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - interrupts
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/lpc18xx-ccu.h>
+
+    eeprom@4000e000 {
+        compatible = "nxp,lpc1857-eeprom";
+        reg = <0x4000e000 0x1000>,
+              <0x20040000 0x4000>;
+        reg-names = "reg", "mem";
+        clocks = <&ccu1 CLK_CPU_EEPROM>;
+        clock-names = "eeprom";
+        resets = <&rgu 27>;
+        interrupts = <4>;
+    };
-- 
2.43.0



Return-Path: <linux-kernel+bounces-776573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F33E6B2CEFC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E1D7268EA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F61631DDB8;
	Tue, 19 Aug 2025 21:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMId4YiN"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759FC3054D2;
	Tue, 19 Aug 2025 21:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640547; cv=none; b=u/Ozzkt3KMOupZkTbF7zS4BJ6IT+Oh6xQobLikLaXFErZ+u7+TDFiBxBHDZnKQD+D0HaMJNCkOxOPmn3F22Z2XiTdhWvtLlQRfCrCr7mFp7SntnWcX7wfRQU2x/bJ+HGBy/Rt9Zpn3e9pHKuYE9R90AhWTJ0lRbNhpuaHvHHytU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640547; c=relaxed/simple;
	bh=XfLBoYLZINNadqclenDFE+6bJGfKiiwxhQla6Y8q1H8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hz7WcxZCcrJm1Sk2LG82KnyToKaNHIQ12cC6B8kL/b99X+NVuxE1xmPhQhnK/vFQBJzuTB9RlnIq/ZCGV7qTgnf18c+dKiw3KnXYqOyRLDaLO5pAjCm6YmZVplmLr2SgcXtKVP7hL9RygLSm38bjooUq8NMkHVfDePS6R2t0gRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMId4YiN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a1b098f43so35918625e9.2;
        Tue, 19 Aug 2025 14:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755640544; x=1756245344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aamE0hQaQlwYcUu6VvHYWQcCmYgaP/R035eLxhIGLn0=;
        b=VMId4YiNVAlNnRXgkuHL9e/F63zg1Fc5nky3LFJEV7LpMhDH3CRiV7RqRTyNEOmAjs
         2c20yVE//TlEpws/sB81zA0kRdq/9hG+LEpSpEubQLhrc3cvASvGVntR7jVyyFRgce78
         nbWiRI3n79KxzIrP78sSOEZTghHreBO/UfZ5aXBs5nWXcRv/cLYE0g+4VjhLwlqdGAz1
         ++wNNswuecxF4b3p/I1KyofRY/5eLQB0f5qfmv10QZggFfIbr+9ahB8NLkNI6tvtsqS3
         F10WeZsi6ILj+fSsz4ggECk5tDWH9PopFGMpJzhrfBnV+LERNA6Nsg5wC5BroMQJ4f/Y
         wcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640544; x=1756245344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aamE0hQaQlwYcUu6VvHYWQcCmYgaP/R035eLxhIGLn0=;
        b=pJLYZkpy3aYc0x16nXE6rjf1nsZ3O5f6utbOxB63jY+8GvPxa1I7tTgazEmLlll8sR
         MT7+CenkdRr9/QgbND8PRUPlQj6lo0SniXxAkFQYHGLymtGHWDIypG2p4npx+w8BP7sm
         dbcNRKgas8B0PysD50yl3W71SnP38zZp5FtiN8syg7lG4RcgItH4GXCfuJU93hAgFwXx
         bLY8YkSSkO6L/AKULsVMATNox+TP+9CCdyLc3GHXgWXK77NStPKged5tqkqsUGgpKSgp
         KUTYh2O6sDxz3EfyWqwFKZkLGyW2jUKmX0+q65GFEyI/85S+4/oNKApBWTxkjDq9279Q
         2FzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGxw8mcgj4qT/7VljQE2lxQZ2N2f60JQO+cV3R2VrefGxRpihHEjRRL+/PHejI6bG/9DS4+43mcHn5TkPE@vger.kernel.org, AJvYcCVTYtXFo4ukY+1QunKhmy2R7T+qUwdJeZp6+zjCmnzoag2y5qig3ph6uyZ0jgEfqWCD67vKzXSCjn29@vger.kernel.org, AJvYcCVmOf1KVUjg2nmhuc+KNf/kU64zoBmdWYn6rP65FoC/MTUZlazVfD9wMVurZ8+q64q6OBFz0Ok0h4Ul@vger.kernel.org
X-Gm-Message-State: AOJu0YwoPKJTlvyRYZoIChCdmFWzSBmlbzsq+5/OhAR/Bi+LTu8N3jmF
	UnQroB/0sJRbrIa/wsX4uEvJUijcEvsGnBA7b5EdI/q2+caDk2ZmH1M=
X-Gm-Gg: ASbGncv3XeKW8+ACalLkonMLgJahujczQfUHmyqUgnrukzecIEj6JOF5CQIFt5VPOtx
	BMd1u/zi7ABgXCr+hFbq0A50FDza/Aiw3divfvgXB4mdPhuhP48pVFDafa7z2XLj5LIZqz1ErEZ
	wL00KntVoni08q+pbn7oAI5pb3oCCsSY9VF3xEfz2EF8WGO7imtGbb6NMsX8s4hGjA1i64tCc8i
	oF63wmkWh/TFsGZcEo4zHpltn1QV+DU1Rc9J7gCQ/AXA9onrhUTEuC6WgGeNPjswl32kZEg4yaf
	M7ShHaaztoQwRSRUPTLPG6XXjgVXTQUoHnt4sQlZmjzpiJR+vik2r4PYKlAMcsCXEiW+IfX7m/L
	ZVx8FGwEi6tN//VI8Jgat0zXh6m3rg1uKyZbelgtpmzVAXMc=
X-Google-Smtp-Source: AGHT+IEVYY8dSLDdjaamcpglSPV1Zd5JwgwZVMHYg7lBAjyY+EnvivAk61bBZ6OqCrnKGW0qa54YSw==
X-Received: by 2002:a05:600c:4f8b:b0:456:1c4a:82ca with SMTP id 5b1f17b1804b1-45b47a03261mr2455755e9.32.1755640543373;
        Tue, 19 Aug 2025 14:55:43 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:216f:2f7a:74c6:177a:3b99:868c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47c310efsm3679565e9.7.2025.08.19.14.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 14:55:42 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: robh@kernel.org
Cc: gregkh@linuxfoundation.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	peter.ujfalusi@gmail.com,
	devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH v4] usb: dt-bindings: ti,twlxxxx-usb: convert to DT schema
Date: Tue, 19 Aug 2025 23:55:25 +0200
Message-Id: <20250819215525.137080-1-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the legacy TXT binding for the TWL4030/6030 USB module
to the modern YAML DT schema format. This adds formal validation
and improves documentation using a conditional schema.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

---
Changes in v4:
 - This patch is split from larger series per maintainer feedback.
 - v3 link:
    https://lore.kernel.org/all/20250816021523.167049-1-jihed.chaibi.dev@gmail.com/
 - Removed i2c node as it wasn't required by the old binding file.
 - Updated node names to 'usb' and 'usb-phy' in the examples to follow
   generic naming conventions per the Device Tree specification.
 - Replaced raw interrupt values with standard defines for clarity.
 - Improved formatting in the examples for clarity and consistency.

Changes in v3:
 - No changes.

Changes in v2:
 - Added '#phy-cells' property to support PHY framework integration.
---
 .../bindings/usb/ti,twlxxxx-usb.yaml          | 116 ++++++++++++++++++
 .../devicetree/bindings/usb/twlxxxx-usb.txt   |  43 -------
 2 files changed, 116 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,twlxxxx-usb.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/twlxxxx-usb.txt

diff --git a/Documentation/devicetree/bindings/usb/ti,twlxxxx-usb.yaml b/Documentation/devicetree/bindings/usb/ti,twlxxxx-usb.yaml
new file mode 100644
index 000000000..48e10c5e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ti,twlxxxx-usb.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ti,twlxxxx-usb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TWL4030/6030 USB PHY and Comparator
+
+maintainers:
+  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
+
+description: |
+  Bindings for the USB PHY and comparator module found within the
+  TWL4030 and TWL6030 family of companion chips.
+
+  TWL6030: USB COMPARATOR
+  TWL4030: USB COMPARATOR & PHY
+
+  If a sibling node is compatible with "ti,twl4030-bci", the driver for
+  that node will query this device for USB power status.
+
+properties:
+  compatible:
+    enum:
+      - ti,twl4030-usb
+      - ti,twl6030-usb
+
+  interrupts:
+    description: |
+      Interrupts for ID and VBUS events.
+      For "ti,twl6030-usb", two interrupts must be specified:
+        - The first is the OTG interrupt for ID events (host mode).
+        - The second is the USB interrupt for VBUS events (device mode).
+      For "ti,twl4030-usb", one or two interrupts can be specified:
+        - The first is the OTG interrupt for both ID and VBUS events.
+        - The second is optional.
+    minItems: 1
+    maxItems: 2
+
+  usb-supply:
+    description:
+      Phandle to the VUSB regulator. For TWL6030, this should be the 'vusb'
+      regulator. For TWL6032 subclass, it should be the 'ldousb' regulator.
+
+  usb1v5-supply:
+    description: Phandle to the VUSB1V5 regulator (for TWL4030).
+
+  usb1v8-supply:
+    description: Phandle to the VUSB1V8 regulator (for TWL4030).
+
+  usb3v1-supply:
+    description: Phandle to the USB3V1 regulator (for TWL4030).
+
+  usb_mode:
+    description: |
+      The mode used by the PHY (TWL4030 ONLY) to connect to the controller:
+        1: ULPI mode
+        2: CEA2011_3PIN mode
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2]
+
+  '#phy-cells':
+    const: 0
+
+required:
+  - compatible
+  - interrupts
+
+additionalProperties: false
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: ti,twl6030-usb
+then:
+  required:
+    - usb-supply
+  properties:
+    interrupts:
+      minItems: 2
+else:
+  required:
+    - usb1v5-supply
+    - usb1v8-supply
+    - usb3v1-supply
+    - usb_mode
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    usb-phy{
+        compatible = "ti,twl4030-usb";
+
+        // 1 interrupt: OTG (ID & VBUS events)
+        interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-parent = <&gic>;
+
+        usb1v5-supply = <&reg_vusb1v5>;
+        usb1v8-supply = <&reg_vusb1v8>;
+        usb3v1-supply  = <&reg_vusb3v1>;
+        usb_mode = <1>;
+
+        #phy-cells = <0>;
+    };
+  - |
+    usb{
+        compatible = "ti,twl6030-usb";
+
+        // 2 interrupts: OTG & USB
+        interrupts = <4 IRQ_TYPE_LEVEL_HIGH>, <10 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-parent = <&gic>;
+
+        usb-supply = <&reg_vusb>;
+    };
diff --git a/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt b/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
deleted file mode 100644
index 17327a296..000000000
--- a/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-USB COMPARATOR OF TWL CHIPS
-
-TWL6030 USB COMPARATOR
- - compatible : Should be "ti,twl6030-usb"
- - interrupts : Two interrupt numbers to the cpu should be specified. First
-   interrupt number is the otg interrupt number that raises ID interrupts when
-   the controller has to act as host and the second interrupt number is the
-   usb interrupt number that raises VBUS interrupts when the controller has to
-   act as device
- - usb-supply : phandle to the regulator device tree node. It should be vusb
-   if it is twl6030 or ldousb if it is twl6032 subclass.
-
-twl6030-usb {
-	compatible = "ti,twl6030-usb";
-	interrupts = < 4 10 >;
-};
-
-Board specific device node entry
-&twl6030-usb {
-	usb-supply = <&vusb>;
-};
-
-TWL4030 USB PHY AND COMPARATOR
- - compatible : Should be "ti,twl4030-usb"
- - interrupts : The interrupt numbers to the cpu should be specified. First
-   interrupt number is the otg interrupt number that raises ID interrupts
-   and VBUS interrupts. The second interrupt number is optional.
- - <supply-name>-supply : phandle to the regulator device tree node.
-   <supply-name> should be vusb1v5, vusb1v8 and vusb3v1
- - usb_mode : The mode used by the phy to connect to the controller. "1"
-   specifies "ULPI" mode and "2" specifies "CEA2011_3PIN" mode.
-
-If a sibling node is compatible "ti,twl4030-bci", then it will find
-this device and query it for USB power status.
-
-twl4030-usb {
-	compatible = "ti,twl4030-usb";
-	interrupts = < 10 4 >;
-	usb1v5-supply = <&vusb1v5>;
-	usb1v8-supply = <&vusb1v8>;
-	usb3v1-supply = <&vusb3v1>;
-	usb_mode = <1>;
-};
-- 
2.39.5



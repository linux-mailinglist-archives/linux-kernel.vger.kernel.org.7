Return-Path: <linux-kernel+bounces-783591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7ADB32F66
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 13:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30EAF3BD6AB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 11:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71012D641A;
	Sun, 24 Aug 2025 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVh0umVR"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F2B2C327D;
	Sun, 24 Aug 2025 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756034683; cv=none; b=jevmJnEjgswviB8B3CsSANdgLhA8F9Z+jQDv9ETJ2mBY10V+s3JRugoREJ5At6xacNd0CxSmfBf/uQnr0a+xLtscBQEctR7wIp9yE/ouwZHHkaBW2GoQ4AFb84kviF0MsIy6ej12FFUtJjEJEq2gfiD3l+OE4eTw3SKoGT9b9Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756034683; c=relaxed/simple;
	bh=5uwZEFCu1m4dfQvQINqTP0kcHQJioZ9fCKuPRDs/CAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSmvBKejFXwF62F2ju74MGQtHA9PU8RFI4dsGj3XjxQQb3Rvm6LOihpD+WTmx4nfL7ouNTzMoYmfzOYqifC7kWiUTZfznvml/k6YK4oOA14BjYmHS6w73LHP6pmdsTLwS58nP+PXxFQV6wLHbVlnVMaQnM59t3i2m/ias5DY/BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVh0umVR; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3c7edd71bbfso809533f8f.0;
        Sun, 24 Aug 2025 04:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756034679; x=1756639479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOEbrfP8D+VaWA2Vx7s3/83p5zv52znpbcd9S9mZ/1g=;
        b=iVh0umVRaMrlESNUvGQ1HeFdA9QIdtm9tyFDQVjJyh9/a1EabOMuiYRHLf4YP/bTfo
         PyXA50lsWLp3aHZ7MfMJataE+IZwNYmFPNf2LoyqpC5vA8VWBLyxonIg7qf44SM7mLcu
         PpvoWx4ZVJP6I2Opop8swUx/it3dFa4wfVNX0ekM19m5y+cwULZyuxeODcfb8O4EoQI6
         aMuKiBtsJHSjgvcIxhdbKyVVM1Qv4KSS14sdgh8kE0QSGwHqFl9n18QfygXcqRewIAoF
         Y71LtoU2fv3hi9JmnffFVMo3r77oupPGzl2B4l7cKHaNG96eplHI3vFnGgJvOgKKDQI6
         X3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756034679; x=1756639479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOEbrfP8D+VaWA2Vx7s3/83p5zv52znpbcd9S9mZ/1g=;
        b=EwEbW3BdtdtRAnEq718xKCkXNCeRcsBQNOZP8DdXadrk6Ssg90MlLMXGXK52+aUppj
         zkRwtkU7w6HmZy2lTbO0bQfMaT8VVtEIJnSQONCdwSlYUroQrAdM3gCqvPcm357oJP3j
         hqLYE8vhpL6HMipu5OHWANPHQIZvfZDyxfJ8AbL7VfMNDo9REUXo6cO0X3q2C9zs7uft
         IPQJl++Dpaga05Eb5VY21YaowHOj7JXXsZjAklxcFJf/i2AgGK82HTZ4sclPV/74o02z
         IxsnW+XiDeWqhyEmFAWPTPJUnrX4PoliXnKyPJqP57o0F3patMhbTWuPa9R/aMiYSGKd
         tPPw==
X-Forwarded-Encrypted: i=1; AJvYcCWHxK5Gn/GsMSTfP7wzY7LiZVWL3juu3wxiaCjeZBqDLmIZzstlAXuDhtIcabkEKq+SqrMWIU0wr6qegAFo@vger.kernel.org, AJvYcCWcWulCI7uIpqMt0BcY3Adr1ch3R470aP9DPcmWqlkLf3OAP4i1LYepOj71I/VF0HJZOcESdQ4yaHny@vger.kernel.org, AJvYcCXs3IYpZija+BkgShFCVHb28BcNQARTb2Ik0ZTiKVpm0Lo354Q9XzQsm4kEoGmVuuGZz+H2VYjARsM4@vger.kernel.org
X-Gm-Message-State: AOJu0YwSuuMgjSd+gSGFasHsu7PP/jPrBoO3LkoGDsDxNaFmZOo73/s5
	0Mk4K4XL2rEhmPeaOoRpPnAtWnI/YO7DNAIoiGdCMCmgqoEyw/5XcbLQKc95
X-Gm-Gg: ASbGncs7yBvJldnlg+vhRV2pxNrBszjBf5RO5OW4u56T6LZwWrjbeyxxO8CMy1G0HwL
	D/cYKBEZKzCFCi86G2EbabcPa8ky/EfMU7ArK2/RATNvHcvd8xlQ+UL1MnlMMjdX7PmHg+qC02T
	k6Cu/WX5ifYjEt92xOjSgupxZZRcVcvv1EcUDEC3hNETRkDNiU6zS7/xEOefae9vDrqOkjDqg1G
	w/Dejdl2+DZl0dLu78DaWJmwfP+42OKBbDJ2WUWVAC9HzuN0cD6fd0vqSxEpyvjkjpFnHKVo6K9
	8HYxROJx1Gu0QsUolR1sgXuUpjIFPHZKdA8ws9A0V2pyzubfkNLXoyL3mNWikyUgjjF0B5l+e4O
	/8jOzaRMYFoqBWugIGTdMhkVRtj1X3AetjeTnOrQSMg==
X-Google-Smtp-Source: AGHT+IFd+26dlGmlIWsDkA04qkxwx+PfSSK0o4dDRDELW8pSn0iyJrJmpGy9PhcZ079dzgl2jFaf9Q==
X-Received: by 2002:a05:6000:2085:b0:3c9:4e1f:ef6e with SMTP id ffacd0b85a97d-3c94e1ff593mr287662f8f.25.1756034679273;
        Sun, 24 Aug 2025 04:24:39 -0700 (PDT)
Received: from localhost.localdomain ([37.169.16.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57487c55sm67879755e9.16.2025.08.24.04.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 04:24:38 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: krzk+dt@kernel.org
Cc: gregkh@linuxfoundation.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	peter.ujfalusi@gmail.com,
	devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH v7 1/2] usb: dt-bindings: ti,twl4030-usb: convert to DT schema
Date: Sun, 24 Aug 2025 13:23:37 +0200
Message-ID: <20250824112338.64953-2-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250824112338.64953-1-jihed.chaibi.dev@gmail.com>
References: <20250824112338.64953-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the legacy TXT binding for the TWL4030 USB module
to the modern YAML DT schema format. This adds formal validation
and improves documentation using a conditional schema.

Remove the twl4030 section from the obsolete .txt binding file

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

---
Changes in v7:
 - Removed the twl4030 section from the obsolete .txt binding file

Changes in v6:
 - Reworked 'interrupts' property to use a list of items with
   descriptions instead of a single free-form text block.

Changes in v5:
 - Split combined twlxxxx-usb binding into a dedicated file for
   twl4030-usb per maintainer feedback.
 - Used more accurate header for interrupt macros.
 - Improved formatting in the examples.

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
 .../bindings/usb/ti,twl4030-usb.yaml          | 74 +++++++++++++++++++
 .../devicetree/bindings/usb/twlxxxx-usb.txt   | 22 ------
 2 files changed, 74 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,twl4030-usb.yaml

diff --git a/Documentation/devicetree/bindings/usb/ti,twl4030-usb.yaml b/Documentation/devicetree/bindings/usb/ti,twl4030-usb.yaml
new file mode 100644
index 000000000000..6ef337507425
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ti,twl4030-usb.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ti,twl4030-usb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TWL4030 USB PHY and Comparator
+
+maintainers:
+  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
+
+description:
+  Bindings for the USB PHY and comparator module found within the
+  TWL4030 family of companion chips. If a sibling node is compatible with
+  "ti,twl4030-bci", the driver for that node will query this device for
+  USB power status.
+
+properties:
+  compatible:
+    const: ti,twl4030-usb
+
+  interrupts:
+    minItems: 1
+    items:
+      - description: OTG interrupt number for ID events.
+      - description: USB interrupt number for VBUS events.
+
+  usb1v5-supply:
+    description: Phandle to the vusb1v5 regulator.
+
+  usb1v8-supply:
+    description: Phandle to the vusb1v8 regulator.
+
+  usb3v1-supply:
+    description: Phandle to the vusb3v1 regulator.
+
+  usb_mode:
+    description: |
+      The mode used by the PHY to connect to the controller:
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
+  - usb1v5-supply
+  - usb1v8-supply
+  - usb3v1-supply
+  - usb_mode
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    usb-phy {
+        compatible = "ti,twl4030-usb";
+
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
diff --git a/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt b/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
index 17327a296110..7194c9504b28 100644
--- a/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
+++ b/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
@@ -19,25 +19,3 @@ Board specific device node entry
 &twl6030-usb {
 	usb-supply = <&vusb>;
 };
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
2.47.2



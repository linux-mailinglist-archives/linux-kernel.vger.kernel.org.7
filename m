Return-Path: <linux-kernel+bounces-782674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52543B32383
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56835AC503C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112BE2D7DF4;
	Fri, 22 Aug 2025 20:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0g6JLEH"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB642036FE;
	Fri, 22 Aug 2025 20:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755893870; cv=none; b=TvQD2+TeAfz9JphciIXUD0pui/AA501g5t1EN93EiqOYnmXlL2WxGMqRe7fgFf9dJyXaxOEFBXQZEwihXDPnKEgTvMKqW+LqdA4KxNO3tZDO+CMrVtCS7yJkG4vcaLWMkwsbWB/V5VMZYUJhnJ3zJDNSXqOvfqbrMmoQyQZBgu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755893870; c=relaxed/simple;
	bh=cUCvU5SnuT568IlqHw0EE49jxcAI9amPxzCecxfDCm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OIyeMOCwtmAxhhD+jq68V/U9lr2Z0fQVHXY+tbX1c4J0CVdPi9jpGCiXlKMOTCTcB0jVPWAQLhM1Pf9HtKSfJbdEPFGFjGjaI1TvX+ZkT8cldPjV8Gg1c95sEwnKDBAEVdP1czgaMKf0PFEnDyBgrQtHyg944JEj0OpeGSytKDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0g6JLEH; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3c64123398cso420102f8f.2;
        Fri, 22 Aug 2025 13:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755893865; x=1756498665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WR7ozkqwZHCuIcMO2zXK1ZOp7WYVbbY7HwCkDpGwQ80=;
        b=K0g6JLEHQDoBWT9vKxziWwbEiZZo6srhL4v/G6AFuR3JUn1STHSx+1vaY/Hb51J48g
         51pYLhH3z6tHdfXaJAzLbAXLhDQ6IRWJZfUwuhpu+XqltF5jhjEyycHy7GT2tfhjrREU
         gyWa56s/MBC+9TPFo7RveTcjik2lz/cwwFKBIwbxCq45biuwwPyW+I1xcmv7a/vBjDSw
         TwLqfnGmMAnkBGnqK05BEujN2p7pcPCf9RAhW00k1au5djpNxRZ4PSSjHBW3ajvB00Rh
         RE9N9aVAs7pV3Kfh7zma/NWFnvaFWc1qTUy+r/91c+Gf+01QmiqBHe7L09KEdd09hleP
         gEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755893865; x=1756498665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WR7ozkqwZHCuIcMO2zXK1ZOp7WYVbbY7HwCkDpGwQ80=;
        b=AHPF26N/dUA0w8ueeH3nuUMC6KxLyQpkKWb3v31cvdGN9gTQM74NmfP3FCnzVERRjy
         BrOUe0GZvOYCMhCAwfhu0HhQdoIT1q2Luy/17OIFfDo19X0v5IFmmooyI9XpE4WJKGy7
         sHwlvIzONvpknpRnHiDdKtnf5plQC8HzJWinMuTAKeFjq9pyYKzbbPewVOQnkRDzATMZ
         FqKmXUp/W8ISjnu37LoJMaZpDYmYNVOh221TcyRVisqw+5Z/9dOYWA5rzaFptpMX44lC
         QGh13c2Q/DsLpvfl/XUbWeMsHsTXeFWvAEu9HnA9RG0BZTg6lFS9swfQMzJJdwixHsGp
         lXtg==
X-Forwarded-Encrypted: i=1; AJvYcCUPer9X3ngJ89VdYy5a7LW2KO3Brk7m7o4SdmJPMSsukP7eBNj+azmjkJwLQ+3b+OPrIDks1qNmmhY8@vger.kernel.org, AJvYcCXrFS4ecVm9OsbMOu7X5Bbj3wxZ6+Q49eXVtxo7EDj7++BCNg5mDiyxyfW7VxWmnLr0wWl9eicroeCcUpsB@vger.kernel.org, AJvYcCXyClDTDR32fvyUOj/CxSPFVDj7qt6cr4OpB2HsTI6L93XqvJRNKNHcyov53zndR8l3Lw9amDTYYFoI@vger.kernel.org
X-Gm-Message-State: AOJu0YwqkXOCSW78XDsX/twGW/mUqyTzwDLHK3OTViXxSPtcpk3XiAz3
	pSkDWz2w2WvRlqTgeKnmXffOPonZnsrrJ0THbtq/4yjhJcqhkkHhdiQ=
X-Gm-Gg: ASbGncvwN7WRjimAKf+WSRP+Ct/VAXmaMgB0p4YbsSEkkbwk4TzWcC4BctDN0W1HkHf
	OOph3t/8P3FA+902R8iFNcofR119Y0x9igXJvNKLLt0M5iSV63zDeYwB/ghHTv05Gt8JXS2NVe6
	9bQShmPgH7f1yecUeuJwMDvDUY0zuKH7qvnldqcxceORLRBQ8RwSbRg1BJfgIZpvLC9kQzHM32w
	JKI8t9NCZv0M6hK/1YeniQtJaxbf2OKzVpNkpCVAsuTCwqK2TgXZkuR6XdyhCX8h9XARYqSaaOb
	j/RvA8NDsLZEmxKmg/Wr8rv2gPvxuDky7/7uAhn3gJ2QfijfH4kFv3cQ2JdSKmOeh+CKKyLRksg
	b1Ym6giPcVfp6uae30j7vV4K4KjS1x8hDfkYhqWyCLp1rCw==
X-Google-Smtp-Source: AGHT+IFhzKuFZRKfLSvNiIHywo1grj4ElpSIWA6K2ISCPXzcM1X28l3RdSWQEJA9MZ5Fr1usu98oYA==
X-Received: by 2002:a05:6000:2288:b0:3b7:95dd:e535 with SMTP id ffacd0b85a97d-3c5dcdf9d4fmr3763888f8f.42.1755893865308;
        Fri, 22 Aug 2025 13:17:45 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:58f:6d42:4e65:e74f:bc8e:3791])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9e1fsm840377f8f.14.2025.08.22.13.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 13:17:44 -0700 (PDT)
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
Subject: [PATCH v6 1/2] usb: dt-bindings: ti,twl4030-usb: convert to DT schema
Date: Fri, 22 Aug 2025 22:17:26 +0200
Message-Id: <20250822201727.71593-2-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250822201727.71593-1-jihed.chaibi.dev@gmail.com>
References: <20250822201727.71593-1-jihed.chaibi.dev@gmail.com>
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

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

---
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
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,twl4030-usb.yaml

diff --git a/Documentation/devicetree/bindings/usb/ti,twl4030-usb.yaml b/Documentation/devicetree/bindings/usb/ti,twl4030-usb.yaml
new file mode 100644
index 000000000..6ef337507
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
-- 
2.39.5



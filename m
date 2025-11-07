Return-Path: <linux-kernel+bounces-890715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFD4C40BDF
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C44A0428106
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C3A32ED3C;
	Fri,  7 Nov 2025 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgisYtNG"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEABA26CE3F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531401; cv=none; b=k7xQUm4PEBbs/tuZnl/m+BNmX4WZRA3zMh4pPV6r8qHrAFiOBrPdKOOGTXDX/SfYklOVJFcxtMvOyzFHngyZZCYYebXg2Wvwowy5eT4YkBuMZop1vAfOAOrPEBqLERFb8FXVRD48fp54LlsnE700D/d+CunHp7Kt8bsZozDdBBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531401; c=relaxed/simple;
	bh=Mq+pgIrFVh3/1ByhZxXql+KF2fVkdYPoiizIqFlwkyI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtZ0jKL1rnAdgagzkuXBkMEGdmFKUciLRRstTqYgPCh3rqzdZZCx6x5Ij4mlNaDP5+zPuZZ29wqZbFhugjyGW8i1DR4VhHeuSiG6c/QFrLdbz2ndBXNa/7HbZ6+hMKJ2IGTPgK85ZBEm67sCg6q81+oZYbnxHNH74fZEdhoiZgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgisYtNG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429bcddad32so664607f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 08:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762531398; x=1763136198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzaa9BMZZ9jLpC9lScxxEevDvh6b6Ryte1oOB44LidE=;
        b=fgisYtNGDwd7oVej66x167ibmjBtfFpfxJW2Anfq3kOaDSsfmCsgCEooqTmOtQlq91
         SSJLuE9YL5Hv07mXrUjdkdZvYriCjz+lCw91RgaHSpCFaCKFtLDuqAKhah36D2iBHwzd
         1Y9k7CbSE9Zo5VT+t1tI+U5VZL4ZYJGoqs8FUUkH+E3GuCEXYClz9sA1M5dcHtJXt+lu
         TCA5QA1xqaYDSq1r6j3/ZhxMlUH/LsgihE42AnuPvHg+V/7Vu1OuJA5zJvkiTqC+tBKs
         LR2B7CBAdvPfhVNM4wce0LR0xNcGYV1/QDQQCbyWWGAQPo2AJK038niGyti5i71SzGun
         7wCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762531398; x=1763136198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qzaa9BMZZ9jLpC9lScxxEevDvh6b6Ryte1oOB44LidE=;
        b=asDpnTHwYQkvEpZCqVVHwlllIs+pBGkcpPW+d2f1CNvlvR2tz3hEvV0cHxL2NBOTzK
         pEflcRRxXw5VnvoWdYusGGKYrmBPYsXVSpvur+9r0MZVW+61BwW9NPA0mwOzHdFBGp4H
         BaXe7CMopHinn6mTnwagbvUODvYsplj3quLuyFkKhNaTvT/QhtGf/D6KMfDP8mCVqKO3
         om8R86HFyI8y8F2O9gUXENQ8woxcwlUA7tt3C1b43T6KHqRUubJu8K4jqdmCDPVpE4Em
         uN9UuwSxD1s0mfYM/Wvfn9YH06N4DbMB/Trts+lR7Oq0Eq6vm+zoj+3rSBjFaX6wLfu/
         OKnw==
X-Forwarded-Encrypted: i=1; AJvYcCXSy67gRVLZgAphBkg1UBOUSUbOcZsl9soPw2uzUqQIr4+WC0OLHFNRjAI6q18uC1hEYCwx48qGA+Bkcs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyDvJfhePfPcCx+s2s0r8v5CVgLU4SmL0kha4N1U8DxgQ1VH0S
	KNnoyXuY7fuixnh2a0FrgQEBfkoZye5d++szOfevzsL3SA25ORYJAfTi
X-Gm-Gg: ASbGncte+/WJzJp/U/zMITe2i7vyLINYeomX2IB1T9PLon2VT+5S/Ez/1dbxNoRIE/D
	gIM3hf2OF8M1cYD7DMwp09/kHQG8VmzA1BCl1GEH3GSu0aUf7/3eoNo9E0v8sGwnQPCwjnCqPSy
	JBWV5rtoH8iHSLuHUDRn9GO/1NFbsJib5wiwb4YmdV6v15/2K4zRqmabrzkIdurHvwiXrwzu2st
	/+xQGJOJSrjo9UA00KQ4NRVL1mpFWoLHmnWilT3lwnUGh1adIWG4IGHMaQ7kCRAvPrrawGAXoo2
	HE5VsMCrZ/BhqD7DHTGQRbm4kxBYEH0x+ZSMw4coiwZjdoBWt25mFGiqlX+jrXRb/8BRGFMWYxh
	kHrrIAyYuA9GsSbBz2lDdm6o7UcP2+ZY0qRGZnIlb4aEo+2PaPF8n0w+Q3xTX3uHl3cs4gbYmjK
	7JWOWbos3oge14azwbBSSI17DF0jqu1Q==
X-Google-Smtp-Source: AGHT+IGdev4kxanwwHINTFxMNLbZq8tVFAx4f+6eN5jOnIKPA3pJTeCx/EUTxYzn8RJNEOu19VtFkA==
X-Received: by 2002:a05:6000:4403:b0:429:d528:649f with SMTP id ffacd0b85a97d-42adc689675mr2303523f8f.2.1762531398016;
        Fri, 07 Nov 2025 08:03:18 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42abe63e13csm6058016f8f.19.2025.11.07.08.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 08:03:17 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] dt-bindings: phy: Add documentation for Airoha AN7581 USB PHY
Date: Fri,  7 Nov 2025 17:02:44 +0100
Message-ID: <20251107160251.2307088-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107160251.2307088-1-ansuelsmth@gmail.com>
References: <20251107160251.2307088-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for Airoha AN7581 USB PHY that describe the USB PHY
for the USB controller.

Airoha AN7581 SoC support a maximum of 2 USB port. The USB 2.0 mode is
always supported. The USB 3.0 mode is optional and depends on the Serdes
mode currently configured on the system for the relevant USB port.

To correctly calibrate, the USB 2.0 port require correct value in
"airoha,usb2-monitor-clk-sel" property. Both the 2 USB 2.0 port permit
selecting one of the 4 monitor clock for calibration (internal clock not
exposed to the system) but each port have only one of the 4 actually
connected in HW hence the correct value needs to be specified in DT
based on board and the physical port. Normally it's monitor clock 1 for
USB1 and monitor clock 2 for USB2.

To correctly setup the Serdes mode attached to the USB 3.0 mode, the
"airoha,usb3-serdes" property is required. This can be either
AIROHA_SCU_SERDES_USB1 or AIROHA_SCU_SERDES_USB2 and is used to identify
what modes support the PHY and what register to use to setup the
requested mode.

The first USB port on the SoC can be both used for USB 3.0 operation or
Ethernet (HSGMII).
The second USB port on the SoC can be both used for USB 3.0 operation or
for an additional PCIe line.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/phy/airoha,an7581-usb-phy.yaml   | 71 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml b/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
new file mode 100644
index 000000000000..ec467fb7f971
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/airoha,an7581-usb-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN7581 SoC USB PHY
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: >
+  The Airoha AN7581 SoC USB PHY describes the USB PHY for the USB controller.
+
+  Airoha AN7581 SoC support a maximum of 2 USB port. The USB 2.0 mode is
+  always supported. The USB 3.0 mode is optional and depends on the Serdes
+  mode currently configured on the system for the relevant USB port.
+
+  The first USB port on the SoC can be both used for USB 3.0 operation or
+  Ethernet (HSGMII).
+  The second USB port on the SoC can be both used for USB 3.0 operation or
+  for an additional PCIe line.
+
+properties:
+  compatible:
+    const: airoha,an7581-usb-phy
+
+  reg:
+    maxItems: 1
+
+  airoha,usb2-monitor-clk-sel:
+    description: Describe what oscillator across the available 4
+      should be selected for USB 2.0 Slew Rate calibration.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+
+  airoha,usb3-serdes:
+    description: Describe what Serdes line is attached to the USB 3.0 port.
+      Can be either AIROHA_SCU_SERDES_USB1 or AIROHA_SCU_SERDES_USB2 as
+      defined in dt-bindings/soc/airoha,scu-ssr.h
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+
+  '#phy-cells':
+    description: The cell contains the mode, PHY_TYPE_USB2 or PHY_TYPE_USB3,
+      as defined in dt-bindings/phy/phy.h.
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - airoha,usb2-monitor-clk-sel
+  - airoha,usb3-serdes
+  - '#phy-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/airoha,scu-ssr.h>
+
+    phy@1fac0000 {
+        compatible = "airoha,an7581-usb-phy";
+        reg = <0x1fac0000 0x10000>;
+
+        airoha,usb2-monitor-clk-sel = <1>;
+        airoha,usb3-serdes = <AIROHA_SCU_SERDES_USB1>;
+
+        #phy-cells = <1>;
+    };
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 3d599e8b8b00..8c152daa8f8a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -763,6 +763,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
 F:	drivers/spi/spi-airoha-snfi.c
 
+AIROHA USB PHY DRIVER
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
+
 AIRSPY MEDIA DRIVER
 L:	linux-media@vger.kernel.org
 S:	Orphan
-- 
2.51.0



Return-Path: <linux-kernel+bounces-876834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65048C1C8C2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D89E42707A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992563546F3;
	Wed, 29 Oct 2025 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jy5Fxrm5"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7B934FF6E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759449; cv=none; b=umlZyzbqIM3Z3H8cuXGvse9mMwtSUd/wMG0lcGSNY250SjZXD+zO5kT9s8Idf8R3qDhvVeMkkPVE97IIU+jofZK4fpLX/1rSrNeCGmmlLB39Pg8X2swz5YBo7dEfvcRBxDtrjZxwWNARuIpsaK8Dyn3zIGtK3/ZUZhixGOFtvwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759449; c=relaxed/simple;
	bh=IVDttnhItzDcgO8FDLA0XO64eO7JpqJzIxKxGaXIRTo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FcNse8k7RitPFYZ22b5JWBVeTaUFPcNlm0uROMIB18kVi24iQhyjsRtMHzd78tvm/NP0x3pZVuLiRsuEs/0DUl6hqfdq/4MF7wsq+b1By79OHO9MoSgMxH8zE+X1Or3VYbSdPDC7qo+FAkTtgHKKLNVHa9zBfe3uBG6NC9Z1/nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jy5Fxrm5; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so116527f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761759446; x=1762364246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bec5DtjUMCMZ+LaW5PfzvbvdukX10M0RMuKRh3c/XPA=;
        b=jy5Fxrm5hPMNvThTmotm0Y2iVkdTLcuUFIQBokJ4vrbMWJy7yFEziXNOE2HlUyTzDe
         l6pii5kDrp6zSEBH7C0/frnH6XXZ9+3m5l5635cAaOkZ/VwB4kBCqLITEr0bwiV28Glw
         WjiNDX1PvO8KrrTTH5ithTMMVBgPGRnshphkmPhnLH5+thlYQNE+BLiaen/7yhp37kZO
         XiFvpqwdiTCjTEx9tH4q0MVm3N9bdCn0Ci7U5xIsSqFjPqJdmteu7kY3x7KrBDdUNrOd
         swb+znO/zuMNDaHo6UEilJfsPJKISFI+q4XHwgWrcWJ8r2OwIg4rweAehRfXB3kwi7AW
         JW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759446; x=1762364246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bec5DtjUMCMZ+LaW5PfzvbvdukX10M0RMuKRh3c/XPA=;
        b=RQ0Z/ZiC8BogZ6PgCb62igjHsRAZ/BY/acsIeHP4ULWq6wwyMjx3cwcA935jcbuBa9
         R+FIMamNerqmG7a7AKfwt1R2M86ASOXSRr63uBXhuWLlKRwrTU2UqoainYPM6F2kMldK
         UhhjANoXhnz6zmkEjNX9JW5mRU8CwmlOiCblYum181kQ4kfe5CGbfu6qW5C7BfSQFwqt
         FMsD5K7upQxBIn27kjvvsOpSiHUJ1avu64U32VXxWvqyWMyWMTm7PAQqzCjQMaoDbnUd
         KJfsqSF7GK9vNnrdGkxM3dmV49GCYJSC5g/Bi8FqyZVTG82as9xau/apGdZUbp+em8d9
         hOow==
X-Forwarded-Encrypted: i=1; AJvYcCVl8ZKtJAGUSeZ7QIFjJhfwqhu2NqrwyznQqNhvdGHn3752AreC1dKk0WdJqvESX/SmBdWE2fMAbYA8Au4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtLiyGpPsEPjMVTur/nUoA8FqN5LS2UqJr66+iRtv1O5YH8d4Y
	9WkfGJbmFcVbGkepzIUAP5bZCFbSgi/AOHSEaLh00ed/uq/FDe6CbY7yUtqq/Q==
X-Gm-Gg: ASbGnctz5sSPFT4pwsvObdttg2iHm3xeFRmURebuh3MM+zTlB3kT5g0h523w3W/1Kxy
	3bkZkhaTdVVmdT+qED96U1Zs6Z+b/0ByfEAhfBbxV9G92Kjfa9cwpxLDHAP+OHX3HpxniFC1+OQ
	dqZqjNC+wLCOMOrT99hV9sOjT9wyNVt2YE81rfWBnsQZHl7C9ajFvhPKZ8RnoH34k4hNE24sVus
	R+wWOcdm3fVqCdNn/BgUFcMHFiEPM9uXi/3m/uuE3DekqmD0we3Ju7l5qW3U9tiVOGUtmOCwB8Z
	NUyLCDCnpfLS3ZcMswunnqGJa09bwDcRYkBArg16b0Jy39mfK9AMEOtvsz8ZaT2+jc3JogtuBhD
	CXb65ZPebqxBFyQvnVDdBV4pf4z/XzoKU0j7ufPHQ4oIFH6o5ftbNlzvnG2X40pM5eZxtlQozH2
	v68KqlZ9xq4Rz+2+/ZKNf0+6QQTWvz+A==
X-Google-Smtp-Source: AGHT+IGerI4odt8yvZLvuwrqAAAQ1NsWiR0PnVGWdiklZSUkMpKCbKISgvvccIoZVLhmQ6qz4uNj3g==
X-Received: by 2002:a05:6000:2481:b0:427:151:3db6 with SMTP id ffacd0b85a97d-429aef7b230mr3253676f8f.24.1761759446075;
        Wed, 29 Oct 2025 10:37:26 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429952d9e80sm27493844f8f.28.2025.10.29.10.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:37:25 -0700 (PDT)
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
Subject: [PATCH v3 2/4] dt-bindings: phy: Add documentation for Airoha AN7581 USB PHY
Date: Wed, 29 Oct 2025 18:37:10 +0100
Message-ID: <20251029173713.7670-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029173713.7670-1-ansuelsmth@gmail.com>
References: <20251029173713.7670-1-ansuelsmth@gmail.com>
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

The first USB port on the SoC can be both used for USB 3.0 operation or
Ethernet (HSGMII).
The second USB port on the SoC can be both used for USB 3.0 operation or
for an additional PCIe line.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---

For DT maintainers, in v2 there were some comments, hope the new
description and names of the property better clarify the usage and
why they are needed.

 .../bindings/phy/airoha,an7581-usb-phy.yaml   | 76 +++++++++++++++++++
 MAINTAINERS                                   |  7 ++
 .../dt-bindings/phy/airoha,an7581-usb-phy.h   | 11 +++
 3 files changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
 create mode 100644 include/dt-bindings/phy/airoha,an7581-usb-phy.h

diff --git a/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml b/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
new file mode 100644
index 000000000000..5106685c124d
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
@@ -0,0 +1,76 @@
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
+      Can be either Serdes USB1 or Serdes USB2.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [2, 3]
+
+  airoha,scu:
+    description: Phandle to the SCU syscon to configure the Serdes line.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  '#phy-cells':
+    description: Describe if the referred PHY is the USB 2.0 PHY or USB 3.0 PHY.
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - airoha,usb2-monitor-clk-sel
+  - airoha,usb3-serdes
+  - airoha,scu
+  - '#phy-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/phy/airoha,an7581-usb-phy.h>
+    #include <dt-bindings/soc/airoha,scu-ssr.h>
+
+    phy@1fac0000 {
+        compatible = "airoha,an7581-usb-phy";
+        reg = <0x1fac0000 0x10000>;
+
+        airoha,usb2-monitor-clk-sel = <AIROHA_USB2_MONCLK_SEL1>;
+        airoha,usb3-serdes = <AIROHA_SCU_SERDES_USB1>;
+        airoha,scu = <&scu>;
+
+        #phy-cells = <1>;
+    };
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 8085fdca7bcd..af23c590bbc6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -763,6 +763,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
 F:	drivers/spi/spi-airoha-snfi.c
 
+AIROHA USB PHY DRIVER
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
+F:	include/dt-bindings/phy/airoha,an7581-usb-phy.h
+
 AIRSPY MEDIA DRIVER
 L:	linux-media@vger.kernel.org
 S:	Orphan
diff --git a/include/dt-bindings/phy/airoha,an7581-usb-phy.h b/include/dt-bindings/phy/airoha,an7581-usb-phy.h
new file mode 100644
index 000000000000..efbb0ae75e3a
--- /dev/null
+++ b/include/dt-bindings/phy/airoha,an7581-usb-phy.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+
+#ifndef _DT_BINDINGS_AIROHA_AN7581_USB_PHY_H_
+#define _DT_BINDINGS_AIROHA_AN7581_USB_PHY_H_
+
+#define AIROHA_USB2_MONCLK_SEL0                 0
+#define AIROHA_USB2_MONCLK_SEL1                 1
+#define AIROHA_USB2_MONCLK_SEL2                 2
+#define AIROHA_USB2_MONCLK_SEL3                 3
+
+#endif
-- 
2.51.0



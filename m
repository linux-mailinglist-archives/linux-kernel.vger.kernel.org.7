Return-Path: <linux-kernel+bounces-782675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56ED7B3237F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69FF623FC3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2959E2D9499;
	Fri, 22 Aug 2025 20:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6201Vyy"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DC61FF7D7;
	Fri, 22 Aug 2025 20:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755893871; cv=none; b=PDvBdK00zD2EacMPk1QwlpxRDpFxFn83jDzZVtF9YJ/0rAbahpDV0Jg+eoYdb6rlmw4J3cdqqsHny6U76CheLd27iHVNFh6jqiZeLDs17oYCBNSe/GcZKkHsiszXxRsznjg6l3i3N0ye8+FRbMlgxyrNzKohtsB4EIfHyYeD9lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755893871; c=relaxed/simple;
	bh=muXhjKx/nVWZdh2mECc3ZEMQGdZE+G1XfPTIE/bobv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VQFEnhQnWvPtCYKNq0htJwdhnQPyIm6qMWGhe41wV3WioorMBV51FBZix3BZrMD4hkSevyHCbgDpRGstgQbFH6nArZtK487tdeLDXF6FxNxmOZpKHLKyq2cxAak5FP39QNFfCm4Z4hkmnbOxaRqaRaLceSsFLqCLcHU6aBRZAsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6201Vyy; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso445160f8f.2;
        Fri, 22 Aug 2025 13:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755893867; x=1756498667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePUcbf0WS2cvQ3/YKOaIepmUi6RvcPmkRDWnIHJOFAc=;
        b=K6201Vyy3pD/m/rYvcuIoU02tqAcF2NJwmBqq4qPDEzGiw6EnJ9v6zMQ/6qWq5uuq+
         W6C5+kc8Q9SRpaPdRdj522kv2J7lQBgxyrR1kDu+S6aPIgXL8wCaWfgHqikvqesMku5s
         zlmYatHHEKMmX2e7XgUBb7A8PLKgFE29W5+geXF9oSb2tYXRUmSKMr/HUQyy7a9M9TWd
         RMGSXyGXITtFL3l/00MokBTxDzdPy6MqDOYiges7ng81c7w/5yzwroOIg8Gtkchvjmg0
         E2Gag6D43RnCxLlODfXdgPrCIpJZftFPkn2ceVyfOrIcZagvcUJ4x/9gfGIjPeMCUBKx
         2Q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755893867; x=1756498667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ePUcbf0WS2cvQ3/YKOaIepmUi6RvcPmkRDWnIHJOFAc=;
        b=YZmbEuNnNDtqvsBmOEjBrG+1q1ImtuG/crH2A7cmL2PrSTkXUo/w8/pkJw2GRWowVh
         lwMPKlpxhcmXdYiTr9mDeOYSZjQem2PXA5ainegWyX5xqrLcRgOVE2OrAXqkDrtY7gSb
         FM0xrRylmTnMtjyaOrTcQGXTxlELJXwT1ppE5kLCYGmijfrgokXvrRQ4/wQ679dFyOPd
         i1JoGsua36RMBf2gyYPQoHE0NTZoQFbyLQhJZoCX9Z5FrJ39uLyP+wz9gNz7NNnX93QS
         2ToJOuuo2yhwBcrRbvfLYHgMof9+h3gzue/PcTdjS1F8BDXgTgbc4ckfiGilB28QXxNf
         ll+w==
X-Forwarded-Encrypted: i=1; AJvYcCVK3sEaYVCwNfgDrQ5Z2/UnP1gKZod9NqmyPWHs1I9QU7kkQzj9hMGWkFqAu8KwMFdJf64rNTv7VTbz@vger.kernel.org, AJvYcCVxpWdLgFRGvgpaxPQ/gpvDM6rsfEmopOtk5hZsewWF12qRs1cfGZR5Eyk1dIEvF22/tCOEtyqFjmiYH7I1@vger.kernel.org, AJvYcCXpeZzb7BWER1MNZ55lRAphL7bL7CsqSBn11DaMokMl6x9PnQ2FU62WnAYMSEk6X4ohnO0rQAZtcQFY@vger.kernel.org
X-Gm-Message-State: AOJu0YzZrzMzr2mX/OVW59PBjDB+j66sx3O3QmlJk5AlkSWPAk7RaiEO
	QhAleQms1WZE7tXFVVRybI3Ib81YksW/GN1/Xf7V8TCzwOvJpGqCkvU=
X-Gm-Gg: ASbGnctrXdEI0yg4TGkN4G0MeaR8hpseX5sKXjAAxDBXKyXLnX8ClEVCSZNXP4/BVP9
	jnQzHjuB1N9yz3HAL4s7cP2sRrVEN6cFD/1wL0L9vwGRfxv2uB8StwIyWwSejj1XiJZ+8VWMJj4
	6QlYqbpdnn85Vl4VMa3wOf9t4f4TQ41AbO17fHzSun1XPBlXFp/54aAkHKbI0ophO11rYmWqTDB
	khU9kxgP28xSxmdUivNRD3t/BGS+kfJdpafJAcdI0gK6++qBz7nTrhFR3G52I0PJ8OckNZPTC2o
	+PRO5QKB0HBgcJY8x86bFTKoBuzig+nbY6vfZ616omlT85qieBLPmPYhTLpjGBT+qTVWmyBz9iu
	2BnPBSGBINc4SAp1CquzRVPvTh7PWrNEVeQieX6nVNaet9g==
X-Google-Smtp-Source: AGHT+IGhGEhLpsLTQLY8rSdpXgYJAbMhSQwc9U8OBOEBzIM+uzFd6azqJLtxzT8N0BovShJBzLdx0g==
X-Received: by 2002:a05:6000:26c1:b0:3a4:bfda:1e9 with SMTP id ffacd0b85a97d-3c5dcc080e7mr3426817f8f.46.1755893866414;
        Fri, 22 Aug 2025 13:17:46 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:58f:6d42:4e65:e74f:bc8e:3791])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9e1fsm840377f8f.14.2025.08.22.13.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 13:17:45 -0700 (PDT)
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
Subject: [PATCH v6 2/2] usb: dt-bindings: ti,twl6030-usb: convert to DT schema
Date: Fri, 22 Aug 2025 22:17:27 +0200
Message-Id: <20250822201727.71593-3-jihed.chaibi.dev@gmail.com>
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

Convert the legacy TXT binding for the TWL6030 USB module
to the modern YAML DT schema format. This adds formal validation
and improves documentation using a conditional schema.

With the conversion of both devices complete, the legacy twlxxxx-usb.txt
file is no longer needed and is removed.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

---
Changes in v6:
 - Reworked 'interrupts' property to use a list of items with
   descriptions per reviewer feedback.

Changes in v5:
 - Split combined twlxxxx-usb binding into a dedicated file for
   twl6030-usb per maintainer feedback.
 - Used more accurate header for interrupt macros.
 - Improved formatting in the examples.
 - This patch also removes the old .txt file.

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
 .../bindings/usb/ti,twl6030-usb.yaml          | 48 +++++++++++++++++++
 .../devicetree/bindings/usb/twlxxxx-usb.txt   | 43 -----------------
 2 files changed, 48 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,twl6030-usb.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/twlxxxx-usb.txt

diff --git a/Documentation/devicetree/bindings/usb/ti,twl6030-usb.yaml b/Documentation/devicetree/bindings/usb/ti,twl6030-usb.yaml
new file mode 100644
index 000000000..bf737fa9e
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ti,twl6030-usb.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ti,twl6030-usb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TWL6030 USB Comparator
+
+maintainers:
+  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
+
+description:
+  Bindings for the USB comparator module found within the TWL6030
+  family of companion chips.
+
+properties:
+  compatible:
+    const: ti,twl6030-usb
+
+  interrupts:
+    items:
+      - description: OTG interrupt for ID events in host mode.
+      - description: USB interrupt for VBUS events in device mode.
+
+  usb-supply:
+    description:
+      Phandle to the VUSB regulator. For TWL6030, this should be the 'vusb'
+      regulator. For TWL6032 subclass, it should be the 'ldousb' regulator.
+
+required:
+  - compatible
+  - interrupts
+  - usb-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    usb {
+        compatible = "ti,twl6030-usb";
+
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



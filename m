Return-Path: <linux-kernel+bounces-780723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9EEB30860
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2665A566B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD762C11C5;
	Thu, 21 Aug 2025 21:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCQH3To+"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7332C028D;
	Thu, 21 Aug 2025 21:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755811772; cv=none; b=OzHQ/2qzwuZGJNQWH0B4oqHOADGyG84ATPBBsVjdvZAF6CfWCWIth1TVdCKiaU71DuhSMPD/zC3N7dO8GBbDv0VLBylVqSA5N78ZFlup+mwknTSP5/d+SB+RWnKgYqif3R2r/BnCw9qkPgxHIx5cPMeTcaLf7xdFS0t3RLLA0xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755811772; c=relaxed/simple;
	bh=Ifc/Lv0oOwDS7R48fFwAtfLNP6wCG8pRe1X6o4QZe7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dch4awMi6g+GiV0OfqPs76C4fVAFsn4YTQV1h/X1zlwXj26WUfP2QoCm1oHuslvLQi3s6Qo/vZkXHp+HPZoBFyVhleNhs6WTiajNvjvk0EclewTyAhATVQH72nMgBRZWKEYEiFjRJw6bdAiC1Lk0a+Z59Ad12fCmru0ZW9XsiMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCQH3To+; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3c5e043c85bso61606f8f.1;
        Thu, 21 Aug 2025 14:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755811769; x=1756416569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B94Q7Zks2oU27sNpQGwAVEoqo1XuIlLj4CM3Jhg8w0c=;
        b=FCQH3To+7XD/5PFWWu2sZshTsYugjYldqdEXPm2gAa7e1nHMoFyBN84PUKEb5hb3W1
         v5oDl0pPbrUgGvMWne8gj2e5bPI3CZhnDLobduFPZd85PzXa9y5xGiJsoel2A/LxgoLu
         FC+1IdqciE8C34EziZgQZv8LwrVJEcLjMO9B3H2BWOCJJ5XhqBwvpkApluVfJ5C/6SKj
         vhCy6qFvCjHvkzeH2aG0yvoqOwiLehoQiNa92AWDQoWKASbrX1CYdIBnFJxifiV9VsKr
         LE+0QiZ9YiyVzSMR/aYO3y/bQBSuwEuoUofUMk3QjppyNZUUwxQwXmB6cieDqDrXlQ/1
         2XQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755811769; x=1756416569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B94Q7Zks2oU27sNpQGwAVEoqo1XuIlLj4CM3Jhg8w0c=;
        b=AcXF1aq2q/kgpuI8vJkn09R7fsrmuZA8NrUFtwknqfylePZt4FHSz+gNHbSpWCAf9P
         Nocvz1AFEYuxbb2Q8HPHaNvnJFEILtCP3PYS+kq6dr+MLCsErvJ6X/iC9YYZA8Xh0kEo
         O9KEhNLfidfDhaooXrk5wmfJsp4urI7yzlDID6LuCGvUqBhNKNOscvueHM5avoWV4eQ1
         ivWxxvDFc1/AxxTaPpmSgbTlQyTvkOiZwlSKe839KOa9Ys1/l2pWg7Hw51hDKpeMe5u6
         8Uzr6ZJ0keMt2Gg64EV8mA7ch5QctQunAW95zAWYpAAdL0SrntKDVvM2ZFb6cDZhOuaJ
         zupw==
X-Forwarded-Encrypted: i=1; AJvYcCU4eL14qXTiHGQnqECI2V4gJqW4wDSVfbbcIs9PJuBBE1wgvjVaxOBhdTnwFhXH7pcK7tWP+W68QSQA@vger.kernel.org, AJvYcCU9cypvXCteYJWkvCr2AfEAj31SP9j7bnDwr/vPIvwc1w/7jkYN+5tvrUd81ZuDGYx57NakahAKnOydBDzF@vger.kernel.org, AJvYcCX1oJssWMAU/VAVZYBpVYXnDoK1kAqT4PvnMg4mF1wzUzBkIZ5mdTjdnTiwnRwczGbSsnr7K55hp6Vy@vger.kernel.org
X-Gm-Message-State: AOJu0YwXs1pQE3G3YfNwDJg5fLGB5Su73jH8evD1FKmPUgjFqY5SErgN
	AV8nhiZH2qskbQZspzstjZrLIBgzVaNGKK104uIeyFJpro3AbSJo8Uw=
X-Gm-Gg: ASbGncs+EeZvD3vJVpnaGLGZoQVeNJwC9sUUp/mlSF0ACxPJConGGDSfsDxcbHyP5mf
	33oenpoXdZCceJECxOLyhkipXaPzK8Ll3h3EFe+Z9chjdysTwkqsRn+obJiPd5Fqnep/KuUyaQw
	OXzUk/L7xR0v+FNQwAs6celu9I3HseitZBHwLanxHQDjyJg9e0gABWqxixXEcGKDDj5Zu10ggOL
	JyjRhcgDeisRoXxEAE6/P261z5tiVe0hxNxq/gKp1H/w3UmqjPaJAztFIDAhxX/SemLIB28oTXN
	rNjw5KUxn6w2aH3u4Ykjot832kHlPFLUmLpU1GeCsmlFRAz6SQNiHWm1WTR/cerp9wvfQSS2kic
	4ZaKSRjSQoXHuRMjkwh8/O2ouvxSKcaxUTad4cEea+63/uuw=
X-Google-Smtp-Source: AGHT+IFunyVEg9x6T06/I3teMC3he4HmvyNo61DBkJUeOqpeZp0mf9D7pJhPDFE6sc44aE3Vvpp/aw==
X-Received: by 2002:a5d:64e8:0:b0:3b7:910d:8054 with SMTP id ffacd0b85a97d-3c5d2bb09femr453164f8f.11.1755811769060;
        Thu, 21 Aug 2025 14:29:29 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:142f:8982:f293:902e:d51a:6b6f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c4c218c62asm3945798f8f.64.2025.08.21.14.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 14:29:28 -0700 (PDT)
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
Subject: [PATCH v5 2/2] usb: dt-bindings: ti,twl6030-usb: convert to DT schema
Date: Thu, 21 Aug 2025 23:28:24 +0200
Message-Id: <20250821212824.70569-3-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250821212824.70569-1-jihed.chaibi.dev@gmail.com>
References: <20250821212824.70569-1-jihed.chaibi.dev@gmail.com>
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

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

---
Changes in v5:

 - Split combined twlxxxx-usb binding into a dedicated file for
   twl6030-usb per maintainer feedback.
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
 .../bindings/usb/ti,twl6030-usb.yaml          | 51 +++++++++++++++++++
 .../devicetree/bindings/usb/twlxxxx-usb.txt   | 43 ----------------
 2 files changed, 51 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,twl6030-usb.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/twlxxxx-usb.txt

diff --git a/Documentation/devicetree/bindings/usb/ti,twl6030-usb.yaml b/Documentation/devicetree/bindings/usb/ti,twl6030-usb.yaml
new file mode 100644
index 000000000..76fef7911
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ti,twl6030-usb.yaml
@@ -0,0 +1,51 @@
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
+    description:
+      Interrupts for ID and VBUS events, two interrupts must be specified,
+      the first is the OTG interrupt for ID events (host mode), the second
+      is the USB interrupt for VBUS events (device mode).
+    minItems: 2
+    maxItems: 2
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



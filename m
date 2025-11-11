Return-Path: <linux-kernel+bounces-894994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1509EC4CA60
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8D37B34EBC7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011092877CB;
	Tue, 11 Nov 2025 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOMq3Pnz"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19ED28152D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853235; cv=none; b=S+KZQr9pSmMuXNR0nOUGBUIS2lbys1YHTjq1pmPKmyCVHmdpvs6gb91XKWpH1U0CR/rO1YkpmH6RSCyAkiixSPmdE98mzfiz1K81Bq3SCRcGQ/dmuG/fbYePIfbb26EqYN5GJBk9npOhDY57a3yQefbId58HWFHUHouJCHd6VQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853235; c=relaxed/simple;
	bh=pCONCT1Mz2rcdeKnyJtzVqBxrE/ew++NH2w5XjdtUno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tExfwyEVGZvGX0ADXjcWay2gxdYmUWtKEaMMvD2set01NT9RKHM0kakmWMi2wZ/c+3ZmLogb8s6xonDQP5Rm3O4YfyAwJay3XbO8YsWgwWZ+UDpsogMZPEh+lpcUg6hVhYfb0VNC4b6AakzLORxVASkM5VBv4bVHoL0Hr9vA398=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOMq3Pnz; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b2dc17965so2319599f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762853231; x=1763458031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTGHw2wYhtc4Y/i+QYoRz81XM72wiR9wQ453plCnIys=;
        b=GOMq3PnzBCLgrVUfjom3DUcYm9Dk+kwbySFMU6EwAZfsjLPk4b8760RlBmwi326tdm
         7JQ3im3M0k7GtEQZe6zHsl15P+bfatwBFGnPWwmYDDRaOtK1RSyPk/ix1Qnqa8q5uaZO
         lfr6IOk8be60KGE6IIQ19o7PdQauN+YeCIlEnTu3ZPitGAToxvE4l62RVaoyyuzT75Vo
         o0wi8UJx3/aepg/YMB3ejbaMiM009k1soWOIia0F6HJhAZz2ZxQtzmOqhDB9wNxHz3lA
         G/2zEOevqyKQ8F7NoAM50TxkAClKkaxWeqab6boNf2Wnl7hXEVQDcwn7w9TyEUhGLYql
         dUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762853231; x=1763458031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TTGHw2wYhtc4Y/i+QYoRz81XM72wiR9wQ453plCnIys=;
        b=ZwBt4K+HMnDjXRrbgyzP5LErsTJNlKz4RDGeNQhZtfiTBfSQYZrI4OkqkZtvX8jwoq
         jshZjU9rrmsgo76OzDNHAaOslqlKqxwEZjNH460wmpf9abqNRYhbpn6bKMzzNGkjuPfz
         qcbpWX1h1CEHboDGYDtjMnwXr1/peTJ5j06n7o+PKBVmx5FrUo5ubKex9K/bsuEJPAuP
         unGmmL0VLcRBngFMQul3cLA+AsHmWwGlYES/m/YojBB7jNXjSvIO+z743VpLfLlJenKu
         B/T6J72H6tpeVWdLQKgc8N5xaDQ9AfSaoI60WlsLDA1GW2ZNhqEcQbJ8pLN/BrjcsvZQ
         c3rA==
X-Forwarded-Encrypted: i=1; AJvYcCXcb+6+V2mfCCZOYHKmzsa3ynSm/6aNi7/y37GoTymoXGT3H6ta/8p74qhw3/aII9ah+QUgC6rKdL1PdGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/+UXn6ixYSD6oeOUdK79hluTuuBEDU91XZghMVsqpTBL007EN
	UqthWMFYSBruWsqUv28dCX4qHenu8iHwuyMBLU9KMdr2iM2pNwRXFpkB
X-Gm-Gg: ASbGnctE6aI7yiF6Z6DXX5R7UP895f9JNLFsQQgz4B+wUWhLNJL2AZ6Q6JZ0RC86+Au
	fpL+qPMkNEr/ch0nMmPX2azVJgTEWYg4J0TYWtSlXdt0+LlthE5ofF3zW+ARSWS43Nl6BWCTr5U
	iDFXcpEXI28VbHQEn28T3c1Rboz1cJ+/wZwJvn0QW9PMRuU18DVMnVBBXHqPkxbcHyli92siLE/
	DlIZI/9ePrd3MO+nhMW2vMVhMC9NSK2UfkzlqRi5icfM0gMq0Pqa6hdzLZtKK1Z2c2VeeWBP3M7
	ANp1MFVtmQFxMeoMZyijrgIkrXnJzSWggxbtEp1100fnNwkzoUWksU4Tg2as5puYUeUYGi8TP/s
	rs+Uc+p/Gf/JHKA+fnFq8jNkx0cSq63jAJLHfmGZkDmaV23K4xPfDyLhCdJtmGimkuPfLQW3Mo3
	OuNWI=
X-Google-Smtp-Source: AGHT+IGBifXqy242Ns3xjfBr9K2JFF4pKkxyiE/nclOky8SySYLr6IREuvFpJkHchyln+byC5Z2qSQ==
X-Received: by 2002:a05:6000:2a8a:b0:42b:3825:2ac8 with SMTP id ffacd0b85a97d-42b382530a0mr5530778f8f.59.1762853230774;
        Tue, 11 Nov 2025 01:27:10 -0800 (PST)
Received: from builder.. ([2001:9e8:f12a:4216:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac67921c3sm27464641f8f.40.2025.11.11.01.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 01:27:10 -0800 (PST)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Rosin <peda@axentia.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Richard <thomas.richard@bootlin.com>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 1/2] dt-bindings: gpio: add gpio-line-mux controller
Date: Tue, 11 Nov 2025 09:27:03 +0000
Message-ID: <20251111092705.196465-2-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251111092705.196465-1-jelonek.jonas@gmail.com>
References: <20251111092705.196465-1-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dt-schema for a gpio-line-mux controller which exposes virtual
GPIOs for a shared GPIO controlled by a multiplexer, e.g. a gpio-mux.

The gpio-line-mux controller is a gpio-controller, thus has mostly the
same semantics. However, it requires a mux-control to be specified upon
which it will operate.

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/gpio/gpio-line-mux.yaml          | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-line-mux.yaml

diff --git a/Documentation/devicetree/bindings/gpio/gpio-line-mux.yaml b/Documentation/devicetree/bindings/gpio/gpio-line-mux.yaml
new file mode 100644
index 000000000000..0228e9915b92
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-line-mux.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/gpio-line-mux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO line mux
+
+maintainers:
+  - Jonas Jelonek <jelonek.jonas@gmail.com>
+
+description: |
+  A GPIO controller to provide virtual GPIOs for a 1-to-many input-only mapping
+  backed by a single shared GPIO and a multiplexer. A simple illustrated
+  example is
+
+            +----- A
+    IN     /
+    <-----o------- B
+        / |\
+        | | +----- C
+        | |  \
+        | |   +--- D
+        | |
+       M1 M0
+
+    MUX CONTROL
+
+     M1 M0   IN
+      0  0   A
+      0  1   B
+      1  0   C
+      1  1   D
+
+  This can be used in case a real GPIO is connected to multiple inputs and
+  controlled by a multiplexer, and another subsystem/driver does not work
+  directly with the multiplexer subsystem.
+
+properties:
+  compatible:
+    const: gpio-line-mux
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-line-mux-states:
+    description: Mux states corresponding to the virtual GPIOs.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  gpio-line-names: true
+
+  mux-controls:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
+    description:
+      Phandle to the multiplexer to control access to the GPIOs.
+
+  ngpios: false
+
+  muxed-gpios:
+    maxItems: 1
+    description:
+      GPIO which is the '1' in 1-to-many and is shared by the virtual GPIOs
+      and controlled via the mux.
+
+required:
+  - compatible
+  - gpio-controller
+  - gpio-line-mux-states
+  - mux-controls
+  - muxed-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/mux/mux.h>
+
+    sfp_gpio_mux: mux-controller-1 {
+        compatible = "gpio-mux";
+        mux-gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>,
+                    <&gpio0 1 GPIO_ACTIVE_HIGH>;
+        #mux-control-cells = <0>;
+        idle-state = <MUX_IDLE_AS_IS>;
+    };
+
+    sfp1_gpio: sfp-gpio-1 {
+        compatible = "gpio-line-mux";
+        gpio-controller;
+        #gpio-cells = <2>;
+
+        mux-controls = <&sfp_gpio_mux>;
+        muxed-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
+
+        gpio-line-names = "SFP1_LOS", "SFP1_MOD_ABS", "SFP1_TX_FAULT";
+        gpio-line-mux-states = <0>, <1>, <3>;
+    };
+
+    sfp1: sfp-p1 {
+        compatible = "sff,sfp";
+
+        i2c-bus = <&sfp1_i2c>;
+        los-gpios = <&sfp1_gpio 0 GPIO_ACTIVE_HIGH>;
+        mod-def0-gpios = <&sfp1_gpio 1 GPIO_ACTIVE_LOW>;
+        tx-fault-gpios = <&sfp1_gpio 2 GPIO_ACTIVE_HIGH>;
+    };
-- 
2.48.1



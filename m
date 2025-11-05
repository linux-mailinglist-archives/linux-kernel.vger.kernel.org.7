Return-Path: <linux-kernel+bounces-886269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BD011C351EA
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6389C34578A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0151E306B11;
	Wed,  5 Nov 2025 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHHObwFS"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDE4305050
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338977; cv=none; b=K/fWpkdWkIu5kyEEPGvaYW/osiE7CLTr0L11ECoSr8exThNeIbDgjEN4EVoXpJmPzYJdorRh5nNClIW6sA6oLh6YNLqHcnpWRqb4gEtzFRtFZ9zAN4eProbXMuZLSMsxtM7Ozak+6PI0Em4DjFrBduDOrp9L8Z3dkXUGVzo2QLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338977; c=relaxed/simple;
	bh=C6xy0EtOkalUzkEAMpfGkzXo2GuppE3z47njnMHkoAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMOx/nZhkiVZoxvUbLeGbRFuA2IRFT9kA3qUgFuC8Bd0yNC8MWuXH3+SfnRfvxPY8DzyUFRmiadG9dgc+zp55iPr8qMQfFZhzNCUWB7f7hJM5rDMn8Ubg5TFub74yt/n6N5q+cfFEoe71lYtV57fQkgVTIEnq/aikPK7Vl1wRbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHHObwFS; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b726f913150so53940766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762338974; x=1762943774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z92QCHjJmqiDgUUq96F5qxg80YMYR3erevN8MU3XYkM=;
        b=CHHObwFS8eWuxXbbIri37J6j4JpDrsXYzPfj2v8p0R5ZXf5nGgAkjoqT4ZTP+ewVX3
         KEfANSwPHDGzEW0hvyeMJRGcTjGGxe0Cvw/aBXfvfW4+GW5zenYMjxb6omN3WYBh601Z
         EX/ZuIRXGn0XSX36+9nqjGamhHhahNVmOq6/pe3u+rkRhLNdY6eeJoOcL4zDeBghxghb
         ui7I2La+KkC3y3KXbqK5KDI4W28/3sLDJg8V3IdfYkMfBGyIX8HE+TuDOf/K9D/zfyV4
         FDRyuvlYQA6kPKSBeR9nMAM2Jr1nDsctOMrUZ05/uDwQvMZL9Faanepz0oCz4nvvh1f2
         MpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762338974; x=1762943774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z92QCHjJmqiDgUUq96F5qxg80YMYR3erevN8MU3XYkM=;
        b=PzLXbJd8Ifo8kPkT1lOXXn00/lywqJDmU1hb0lhKmXlwRku0Jhnc+HfOXwLc7zVZSs
         LR/ujyHWEdBoPAbBc13yWFqr6RYijERskA+eXhhM9cTQ8CPeOqf1H3IHFBgeER0mIp6W
         WAUF4+OuY+Qol3OxdPuVNg6c0sIBy8IMIMa3Yj5/XFrCSSaxc+oFcGgkxM5EWe6t+2St
         b1sNrifsCQ9j5SodCTc2qTKh4I67OfKYhT6IMLr2B86bhk2bp8gsNH1WH+w0OxhD9+ue
         PCs7oZwOCAiTdysgB4fZakwhjHusNsrb0Q2fhJpqmmeF9F8mqODcr8aCbNsEMqpQ3aGf
         7E4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLdRv3lTzZLaqpFFlrVj/8D9k65aSokI9W/w9vtpY+wZImIoOQ8aI9UqyDe2KswphFUGJRQKUDjfZ3LdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEY9REz41qGTCc/gnKcLU2Y78NXTRSy4nHgGiHHZLvFOMGmKKs
	KdkTWaVePXpEyPbeTCjqmEqk6I0AvUyE6d2VJlbZrfxWVcK1mqd0g9SD
X-Gm-Gg: ASbGncvZdMW9blRmyJ8PCk2tZTMUlxSAmTnH+jjOWLylhvDiHe3TsI+D6pIxIWdv4gB
	BtYO0mLfCyFKiTFFlyZ8zmWcHT98Ha2Za2MSg5dvg2xJUlczna4FgZT/z4pT9lSla4rPpUIWlBW
	sSXj7d6eao96a4XySma8maB6eWVbVb85M9Zxa2uzTcVlYN52wHkvfScyTRjRtq1Kdr0XlBxgWn+
	T+/YqM4U2a7Yf0cvV5OA1QgatI7kAtMYRVcROdHhUTZUoiwFvlc3LJ3ShBMG7GgYNuWsbNGDdj6
	p9qyCU8WFahwe+QJBhtJHRGzvV+bVwDmQcbQq39AYPtLd0kZjXhLe25zzIb1zaLVMeOf5l7mU1u
	S91FL5bsqzqJEJhPXDy9xZtopjDjbQQ4fM0d+Nu2oO9orQoFm1uVQtHyj7cTgOGfTqsE3xpTY3h
	jbOX0LpP9YCxABAw==
X-Google-Smtp-Source: AGHT+IGlV9RahnJjEAp0aThL3WEmwaxZ6MtiPW+SqHleirKp3I6nYlDscxLoLqIQlJkAEr5XQOfmEA==
X-Received: by 2002:a17:906:4888:b0:b72:6a39:49e6 with SMTP id a640c23a62f3a-b726a394f5cmr151258566b.18.1762338973509;
        Wed, 05 Nov 2025 02:36:13 -0800 (PST)
Received: from builder.. ([2001:9e8:f106:5b16:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7270b56f18sm83426066b.33.2025.11.05.02.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 02:36:13 -0800 (PST)
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
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2] dt-bindings: gpio: add gpio-line-mux controller
Date: Wed,  5 Nov 2025 10:36:05 +0000
Message-ID: <20251105103607.393353-2-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251105103607.393353-1-jelonek.jonas@gmail.com>
References: <20251105103607.393353-1-jelonek.jonas@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/gpio/gpio-line-mux.yaml          | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-line-mux.yaml

diff --git a/Documentation/devicetree/bindings/gpio/gpio-line-mux.yaml b/Documentation/devicetree/bindings/gpio/gpio-line-mux.yaml
new file mode 100644
index 000000000000..fb91500fa10f
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
+  shared-gpios:
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
+  - shared-gpios
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
+        shared-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
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



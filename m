Return-Path: <linux-kernel+bounces-823161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 699A6B85B46
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD701C87AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8A521B9C8;
	Thu, 18 Sep 2025 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XDfXmjVc"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1AB310652
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209798; cv=none; b=tZjdMnp3JJFqVKF0gG5JUOcrNTr1B6xQd7QbDMVeJdO0kScd7aRsdVp1HXfSd9hYBnrRtpLVld691y6hPZTku4pLty5SuuTslx5iKh9S548X/Z9oXPeLDqp7nmQp144e5m/75dm+LbUfzsvZl3mmS+glK7e2/5QQzd+O8iRCUWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209798; c=relaxed/simple;
	bh=yJbw+gSxRuXDmWufyAOowWGK2y93o+NpPc1oFEaM3c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnhCxBgr+4AJqGVzbhe83dFaJ7cOlOHHHYPIIrMdHNQBSYf6fnKPOvFC/mcRQpGxhQV9l29tg9RZZaasp1Yp/X7dggEwyex5vkrjmCJLG3N7JZUnz59tCbGJ3xsKSO+Na8pqgA3Tmw9uoD4nQ2mB9vAacG5gLJcuGgU2N8evxFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=XDfXmjVc; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb7ae31caso186985566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758209795; x=1758814595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClzalLpVry0Z3N5zOF7y4pLh21VJainWEs72sUomkbg=;
        b=XDfXmjVcwTir/COUw1XBMPcEr9jDm6d2WoWNMaYTgWlZzHqv6xwnKs0YiM+yydHpwC
         dztCK402edWN6xtSlXYe5XHj2ZoP/uNOyhFXF9CtvdEAma5Lb96zF6DU+77FOfyf4mJv
         CHEpplOz83c03qz9jSluy636aiymqTliu8YZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758209795; x=1758814595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClzalLpVry0Z3N5zOF7y4pLh21VJainWEs72sUomkbg=;
        b=U5BpdOmCfHWbu8wu60rIb73M8pqCemUWmxxqsZnCAYa1jwU1kk8UxpjNo+4zfOcfXa
         2Cx57yn4wGEn3A89GukT96gsRTi8/zGORHOoUSYH8V5eGLnH0nV4cxnP283oJ1wWoYV1
         B8N7iYjN4pbREU4/XRseIDs1z7PojRl+WeDGX4CPV4+RwyI19Kk7fbgqhx4HCtM4ZkLV
         vwJArEwWxYBL6Whkx6DOK99oHoMWG7e3mZyLVEHXIM8Puv7aDqS35z7qkrzB+TqFIfxc
         79mQYpBA92JEL9HpbnXaduV7YMPVD0yN1fYlCAb2Gvk+TTSpxgjdDI/AaGrNuGAWDb4G
         XOGA==
X-Gm-Message-State: AOJu0Yzkj8/huadpAXrz7Zh1SAIV736nLm5l6fRcUZCKdoD+1Qs9VBN0
	ZCon16dXdXcOoWEm4QdjQUNtLVKD9WzZnHZuvqjI9bqawVdaiaYQXLvK9JJhUZaCDGdmq71OJHJ
	r5zf/
X-Gm-Gg: ASbGncuSjOED7Hzf+j5rVtW94vjssobepfsLuX1lI+iXyV/jETufmxIKQWttz2ojkdB
	Kq/UzB5537BTmztUl0w5Z/48jbx1eYnz+FtV6PDbPtY41QllGDRv4hLGWce951h6JCksnlmy79/
	b99QgOQuak5U8Qzi4z4HZLCniCyVz+bxZDXDGgxv1n9O04zbYd0CDpwDkkXlkP07EQwWuNbHHgV
	/UGghr+8ueBVLuLX3KTfo6BBptp7ZJelGdmRaSdHSdkPjKfLq10QhHxsmMfD7P+4deCAgnxonLU
	uqJVYO4lHBOrxGlOiOW3xa5QoLbpvKXx4Xz+tDzvFGT1u3dwahfMHs4D+nUUsBBZBHH5SqL8Ml0
	BWsNLA/VDc/gDLkrwBZpyfnNEKn20Wdf3TxzUM/RhqPv6dCgHZb0qXJ8WgzQkKuJovSby0Jq6vT
	uCVq2rYxRt967yNXRT8LO/BH+U8ubaIURBkBOGs3hKOw4/iU4zU3WIGGw+NqE98gmmGHvc+N/rj
	7pnwVUg0BQ=
X-Google-Smtp-Source: AGHT+IHIWguhdTTcSEPHpA68B5M9ZRFqGwOkLHhqYJ7bIM1IdIIL45yanJ52h9csCvpQHzoT21dlGA==
X-Received: by 2002:a17:906:f592:b0:b07:8893:83da with SMTP id a640c23a62f3a-b1bb9b218ddmr625079866b.64.1758209794779;
        Thu, 18 Sep 2025 08:36:34 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd272026csm212430766b.102.2025.09.18.08.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:36:34 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v4 2/5] dt-bindings: touchscreen: convert eeti bindings to json schema
Date: Thu, 18 Sep 2025 17:36:07 +0200
Message-ID: <20250918153630.2535208-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918153630.2535208-1-dario.binacchi@amarulasolutions.com>
References: <20250918153630.2535208-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert EETI touchscreen controller device tree binding to json-schema.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v2)

Changes in v2:
- Added in v2

 .../bindings/input/touchscreen/eeti.txt       | 30 ---------
 .../bindings/input/touchscreen/eeti.yaml      | 62 +++++++++++++++++++
 2 files changed, 62 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/eeti.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/eeti.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/eeti.txt b/Documentation/devicetree/bindings/input/touchscreen/eeti.txt
deleted file mode 100644
index 32b3712c916e..000000000000
--- a/Documentation/devicetree/bindings/input/touchscreen/eeti.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Bindings for EETI touchscreen controller
-
-Required properties:
-- compatible:	should be "eeti,exc3000-i2c"
-- reg:		I2C address of the chip. Should be set to <0xa>
-- interrupts:	interrupt to which the chip is connected
-
-Optional properties:
-- attn-gpios:	A handle to a GPIO to check whether interrupt is still
-		latched. This is necessary for platforms that lack
-		support for level-triggered IRQs.
-
-The following optional properties described in touchscreen.txt are
-also supported:
-
-- touchscreen-inverted-x
-- touchscreen-inverted-y
-- touchscreen-swapped-x-y
-
-Example:
-
-i2c-master {
-	touchscreen@a {
-		compatible = "eeti,exc3000-i2c";
-		reg = <0xa>;
-		interrupt-parent = <&gpio>;
-		interrupts = <123 IRQ_TYPE_EDGE_RISING>;
-		attn-gpios = <&gpio 123 GPIO_ACTIVE_HIGH>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/input/touchscreen/eeti.yaml b/Documentation/devicetree/bindings/input/touchscreen/eeti.yaml
new file mode 100644
index 000000000000..97027914d6a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/eeti.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/eeti.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: EETI touchscreen controller
+
+description:
+  EETI I2C driven touchscreen controller.
+
+maintainers:
+  - Dario Binacchi <dario.binacchi@amarulasolutions.com>
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    enum:
+      - eeti,exc3000-i2c
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  attn-gpios:
+    maxItems: 1
+    description: Phandle to a GPIO to check whether interrupt is still
+                 latched. This is necessary for platforms that lack
+                 support for level-triggered IRQs.
+
+  touchscreen-inverted-x: true
+  touchscreen-inverted-y: true
+  touchscreen-swapped-x-y: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@a {
+            compatible = "eeti,exc3000-i2c";
+            reg = <0xa>;
+
+            interrupt-parent = <&gpio>;
+            interrupts = <123 IRQ_TYPE_EDGE_RISING>;
+            attn-gpios = <&gpio 123 GPIO_ACTIVE_HIGH>;
+        };
+    };
-- 
2.43.0

base-commit: 8b789f2b7602a818e7c7488c74414fae21392b63
branch: drop-touchscreen.txt


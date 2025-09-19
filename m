Return-Path: <linux-kernel+bounces-824183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7B9B884CC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCCB31C8772F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECB52FE566;
	Fri, 19 Sep 2025 07:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UF3Dw8nY"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A0B2FDC50
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758268710; cv=none; b=cTSEgmPrkIKMld6w2uU/c7zRrlNxR5wwU3x9qN7NUYtGLDBa68CeKDxNCPcp9D8wUxJVTMOL191IgG1yExaJYgj3PPGLtJBAhtNvdd6J5p1ByzXGtsUkv4IqkKtVaNca2hs7zMLzNpjLPKo3mZV2SR3qPHJq8YDsgM6p822Ru+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758268710; c=relaxed/simple;
	bh=Lj2uEzG5agUE2RHJzdnwo1ffUTOyQQbwoO2pzyDmVtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XjXUR2kEm2aGPZc4cwZMUWSET9ja+L/VQ8UugHloi2zY77Xs0rNcU3PYcCE9ucEYcLEH0T8G89RxUdWNpvxqnhAS67SReMWv35O1fk0GbL+43/5/WKJ09qtuxjTs88wX9C0p1sZjc9H+nJdYHsfFdekrVWEwIKEddNY4bvsKzTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=UF3Dw8nY; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b264afcc5c5so28893066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758268706; x=1758873506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p9578/uirUkkp2k5bMsZp24lZhySSSKPvOmDT8OQ4lc=;
        b=UF3Dw8nYii3PdfipIkhFhreSDlim9GBTzzez9Dfrg28GPhiDnTN4aazm688GWR+EVE
         RQYlxtz4aWdgzq6bpA9gkHRNNxF36Ra/ryhX+VIJSvHCsBim8GZmb9xCxEscU7hOCvdo
         Ajq6jsp/v2yPhUllk5SxN7F7TZo8V+pC1A/ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758268706; x=1758873506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9578/uirUkkp2k5bMsZp24lZhySSSKPvOmDT8OQ4lc=;
        b=gUQYialEnqIsb1gwYrhZobTyg5ZgFQ/g7a5CV5jxMBo8jaH7lW/sikxnIfjUR45KQB
         GHF2LukFWlIqzCXVPrbnfk5yiV3iIDgv1PXLghxPQ1U+TfAawfUZInQLm1O+K5yp6Ah2
         WbLV+VG86VgGwG2jh1uglnbQdIV4tdwvgcakelxQyrpA0aLW/11xEOx0OXSdxLcX7YsF
         IcCoZZ4elbD8F1JOtg59O1Unf6veWzl9ufkaTL/nUBU7uvaMkCdqCEKjX64OmehqPWt0
         XqwCu7Q6hs07nnfBuXuPXZExcOSOY3a/6PSFe43VG6oEnB0USC9mcljh0irqy6NR3icw
         AFRQ==
X-Gm-Message-State: AOJu0YwLjwwOURAsdilFeuSbKdOtM5hlpkAbatxZOWWdfLDnt6SqYYJc
	mrmg42644/P7SuBXyu/tONWbJ1qH2M5zgoOVHPVrSP2B/PQ+rTlgEx8OMOBDcQeXhnqBC+/Tzyo
	7vKpd
X-Gm-Gg: ASbGncsH96KrQzdMG42swceiGupsut4CBkQfYoHQLa20X0CFuHdhOMKGJdz7ETgLmwo
	0Mm63dtmJ9Sh6AoKNAK72g9qE/Fv/3WvG7ZD25fjNRikM81tzWUDfdv69P0q0GHmdRwbFIcewmE
	pHKO+L/0f209FYyuY/fcmy84r79m3eI5sIE6F9R5lPla0w3cZ7lFoPUr7WHR6EV/LRNxIQ0iEEK
	w1HMGwylutXfO2rqGNXLwYPTu46TfAXVa/iaLlN5iFfUtoR7qevijCpAfKr2mSgwK44KvsouAK0
	TsrTKX1Ocy5orq/UH1JGfLcrqqHNwxuG9W+zqhhWzwFkIF6IzgL8NwWj+Xd3o1vds561ieV0zaU
	z2uZt+Ozn5CTEmBjzCtFNPJK7SarIuv7ihiFo+YVTaEw8oSsXhuJEXi17AqpK/iAvabNp3zxBMx
	qAabtEEGJmOUR8zBNzt4ZzniytoSOkG+qXBC/K7sNrPdMaaf2IdG6tS6o0bc0foYSf
X-Google-Smtp-Source: AGHT+IEnosLPm4/115DGDj89OoPe3E2TW7ffbXpMYL8GXe41HW9RHehoRuoXYtnX+dYEmz19esIzgA==
X-Received: by 2002:a17:907:3fa0:b0:b04:26f2:b83 with SMTP id a640c23a62f3a-b24f3e58447mr184128366b.35.1758268706330;
        Fri, 19 Sep 2025 00:58:26 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc890cc98sm384693466b.49.2025.09.19.00.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 00:58:25 -0700 (PDT)
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
Subject: [PATCH v5 1/3] dt-bindings: touchscreen: convert eeti bindings to json schema
Date: Fri, 19 Sep 2025 09:58:09 +0200
Message-ID: <20250919075823.2557865-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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

Changes in v5:
- Move bindings into eeti,exc3000.yaml
- Remove eeti.yaml

Changes in v2:
- Added in v2

 .../input/touchscreen/eeti,exc3000.yaml       | 41 ++++++++++++++++---
 .../bindings/input/touchscreen/eeti.txt       | 30 --------------
 2 files changed, 36 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/eeti.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml b/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
index 1c7ae05a8c15..13b865d3ee58 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
@@ -9,15 +9,13 @@ title: EETI EXC3000 series touchscreen controller
 maintainers:
   - Dmitry Torokhov <dmitry.torokhov@gmail.com>
 
-allOf:
-  - $ref: touchscreen.yaml#
-
 properties:
   compatible:
     oneOf:
       - const: eeti,exc3000
       - const: eeti,exc80h60
       - const: eeti,exc80h84
+      - const: eeti,exc3000-i2c
       - items:
           - enum:
               - eeti,exc81w32
@@ -30,18 +28,34 @@ properties:
     maxItems: 1
   vdd-supply:
     description: Power supply regulator for the chip
+  attn-gpios:
+    maxItems: 1
+    description: Phandle to a GPIO to check whether interrupt is still
+                 latched. This is necessary for platforms that lack
+                 support for level-triggered IRQs.
   touchscreen-size-x: true
   touchscreen-size-y: true
   touchscreen-inverted-x: true
   touchscreen-inverted-y: true
   touchscreen-swapped-x-y: true
 
+allOf:
+  - $ref: touchscreen.yaml#
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: eeti,exc3000-i2c
+    then:
+      required:
+        - touchscreen-size-x
+        - touchscreen-size-y
+
 required:
   - compatible
   - reg
   - interrupts
-  - touchscreen-size-x
-  - touchscreen-size-y
 
 additionalProperties: false
 
@@ -51,6 +65,7 @@ examples:
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
+
         touchscreen@2a {
                 compatible = "eeti,exc3000";
                 reg = <0x2a>;
@@ -62,3 +77,19 @@ examples:
                 touchscreen-swapped-x-y;
         };
     };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include "dt-bindings/interrupt-controller/irq.h"
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@2a {
+            compatible = "eeti,exc3000-i2c";
+            reg = <0x2a>;
+            interrupt-parent = <&gpio>;
+            interrupts = <123 IRQ_TYPE_EDGE_RISING>;
+            attn-gpios = <&gpio 123 GPIO_ACTIVE_HIGH>;
+        };
+    };
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
-- 
2.43.0

base-commit: 8b789f2b7602a818e7c7488c74414fae21392b63
branch: drop-touchscreen.txt


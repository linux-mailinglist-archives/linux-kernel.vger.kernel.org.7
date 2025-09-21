Return-Path: <linux-kernel+bounces-826300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F7DB8E233
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 19:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D2474E18FC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 17:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AC82737E5;
	Sun, 21 Sep 2025 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rWdiQ7zE"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DED1271448
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758476041; cv=none; b=MDcaklmZg8VHo5d6OKlyeVhUlxqY1n7ct2LVLU7Dmbcr6IYV2k6LCYSuVSx3HtLp0Bq3eYARm/YheLYVSuLW48ixslFIUQ7EesFu4CnbvEvnO24KDARnlDjUr8XIQZTNHV2CIqQ/TWK8KYaiw1uHzznlYbBYHZeQeoHcWkAv36o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758476041; c=relaxed/simple;
	bh=s0wtb16+WYtZYmqbQuhwOOKqXNOpQ/C9gSRHXahTcjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eK/wAia0HSNLc12ICJYPLfuBsOdq58AG8/OfRlnCN1nFaVCI+XxNjHFZ8NJoHCMVkQAx/0aEDI1ByqNa8f2kJkVAWF6sJip4IkSX1yq+ChBfi/oyY36pQDG5zqX5+LGaYJsIa3JROn5Y7sCQnBGrBXj5gO1aa9ufkQvBAtN+v4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=rWdiQ7zE; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7322da8so683577666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 10:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758476036; x=1759080836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VlMcTg6rrPiR0yGZcHHVwQeIzN9BkasZ+MFuim5ZowE=;
        b=rWdiQ7zEHhlmglpEAtyeyqXk5E30jLzwySonWdlo+smYdaGi5IsTP46UJSyqfEh/4R
         CCo32hun4jgPmL6qKY2B6olEC97StMsd6m1AFKc4/Ve5gjc9gEl3iNcjKAqlOb86NCvv
         0+MGMs+QE+NUs4uR9NZdj89wZIyxsRDTnBEVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758476036; x=1759080836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VlMcTg6rrPiR0yGZcHHVwQeIzN9BkasZ+MFuim5ZowE=;
        b=Cr/pBKjuJZIillGvIE53I7Qi03QBwYadamfCgOdxmRdb5izZtWvLtn0PUDxCx8Ddah
         hQ4mbyB9vP9TJ1MSQPJqaDm9uyF4tTwIVvn6srQb91P2PMGyV4UcP3ZPud0NdXpHkasV
         Ti1m8Tjv7aBGQjMZHqSOtQQOYpFBwbRrTKQeFIOFx+BFQlMAVPUZoJVLrpVXhQZOSotS
         cGIaGzsj/zCzeHN2JsDkp8KV3uHhOL8CxNjoRWsbuH5CD80n7vmkEpbxo3LOOqTgBI0b
         DYMbZ/J65nxS4MiIq0qANvxpfCM1GBKeqrcuXBRizVXIXafRNuu/YEWuM9OVgpkSHYMr
         jNXw==
X-Gm-Message-State: AOJu0Yz/jA4fDnKtFH/NYAbRSTO5Isj+LU8d3bTpDrCa/+K/6GHJeS6w
	RN+kwNdL8HJyYw98ddLXynCo1KRanFl2id2p39hfC4L12zbpwdvUOq2K7oqxFK2Wjq8mlwbCtPg
	+OsdR
X-Gm-Gg: ASbGncsz5X2zgEPr1FY6kBBcwwP//SQW3t6wSP+gf9In1xgh7n+r/UjK1v6J1PddYHy
	P/kMUYjw1I2vx1ub8pX9BvWDFn/CL1y17YQEhCWLRyNDomISH5c98xyqk141tfiI7ohh0ugyZCI
	uiXmxXzlV3Prc7hiS7a1LVvyIkWPBP5I3kNjdqiMiM9KHJyg+b/isanIcO/kavMziwJZcjfjYD9
	fH1TXjFXkKSArpDdh4GcWyu2zXcZHGK/oTWLLcDZULOuzvMoEr1I0bv9mkFAxYQC6DUS1azd+Kl
	hJEKNp2seQa35gr/lpq7SQzNQ0O4OlqWYfR40NNc5YNm9PDTk7Nv+FSL2cOI1AaqK0/fHWjY7SI
	/+gD4AI3Fr2puRe3SvbWDdzyzwenCMTfxmakoHWyzSmxTwR0uPXKxPO0uPAV1voOYU4QTe4IGnJ
	kHzK4n4rUwcO5+fgwPjQ6bw32pI3fhVximT2jUr5FtjtmyexwIifYaJUV5vDJPx1vo2WyPqGhgQ
	qc=
X-Google-Smtp-Source: AGHT+IHxamUkl30RF3owHcmhG83KfUakWGC62WX2ylNqw9YsGCV4aiWsbPmH7Wal0ci05bSxKrJ0Nw==
X-Received: by 2002:a17:906:a99:b0:b27:95f9:e20b with SMTP id a640c23a62f3a-b2795f9e3camr589661166b.33.1758476036375;
        Sun, 21 Sep 2025 10:33:56 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2928cd31a6sm324347266b.102.2025.09.21.10.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 10:33:55 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	sebastian.reichel@collabora.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v6 1/3] dt-bindings: touchscreen: convert eeti bindings to json schema
Date: Sun, 21 Sep 2025 19:33:42 +0200
Message-ID: <20250921173353.2641438-1-dario.binacchi@amarulasolutions.com>
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

Changes in v6:
- Add deprected to the compatible string and attn-gpios
  property
- Put const 0x2a i2c address for reg property only in case
  of not eeti,exc3000-i2c.
- Put false the attn-gpios property in case of not
  eeti,exc3000-i2c..
- Drop example for eeti,exc3000-i2c.

Changes in v5:
- Move bindings into eeti,exc3000.yaml
- Remove eeti.yaml

Changes in v2:
- Added in v2

 .../input/touchscreen/eeti,exc3000.yaml       | 33 +++++++++++++++----
 .../bindings/input/touchscreen/eeti.txt       | 30 -----------------
 2 files changed, 27 insertions(+), 36 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/eeti.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml b/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
index 1c7ae05a8c15..517ec721e724 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
@@ -9,39 +9,59 @@ title: EETI EXC3000 series touchscreen controller
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
+        deprecated: true
       - items:
           - enum:
               - eeti,exc81w32
           - const: eeti,exc80h84
   reg:
-    const: 0x2a
+    maxItems: 1
   interrupts:
     maxItems: 1
   reset-gpios:
     maxItems: 1
   vdd-supply:
     description: Power supply regulator for the chip
+  attn-gpios:
+    deprecated: true
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
+      properties:
+        attn-gpios: false
+        reg:
+          const: 0x2a
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
 
@@ -51,6 +71,7 @@ examples:
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
+
         touchscreen@2a {
                 compatible = "eeti,exc3000";
                 reg = <0x2a>;
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

base-commit: f975f08c2e899ae2484407d7bba6bb7f8b6d9d40
branch: drop-touchscreen.txt


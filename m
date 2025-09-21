Return-Path: <linux-kernel+bounces-826162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 094CEB8DB7C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 14:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D911885273
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 13:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2E62D191F;
	Sun, 21 Sep 2025 12:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDLmlFQv"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DA019D083
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 12:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758459589; cv=none; b=plR6U0pQ2lJcJrPoVkZt5btbtYDKJ3BiN/NFPoFh2dPIjje+gQtDTG4Eqxkx3zA1ilub/ImCYjHfR8pLTEphLxqtCiESHh0rDAc0vG+6ZeFbd1o3UfuYsanwEDVqeHZuGrn1jlrHjO9Wq/g3/bmubW5R4Cn00IpXlFTL7ojq1oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758459589; c=relaxed/simple;
	bh=JBjh6tWinHQ8j2zeq/CGszjnQcF7SdBlIAR8B2+vUVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hW/9pmvSKx0sqTK0raedTCnZPbOT6Nkxxd4FjrQyqjSUKcF/ethdiHvtiyXy3A/6lL3Ky8+fu8GnFtRUoLix1UkAsfxBGRsLsuJ52OYPKjnNPMkei4uOHdCEh6GWCvNFzYq3hbr0pcIyL0OVE+BCHMlYu8FK7wWK94AYmcUDNSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDLmlFQv; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57bf912cbf6so773996e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 05:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758459584; x=1759064384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p+TxbCJDfqUR5usrZF8ZGw7MDVN54yzt0d/I/rO53p4=;
        b=MDLmlFQvgaoMi3LQR9IqprMfIURmz/SY2C2jLZH/ZsXIyUksEyB60ZlFfo4xqe4ac8
         XvJt4t4vhYk968kecPMKmDfvvFsklqsYw0ux6HCwWD8ni5QHZyuqN2OMLsJA2Sp0I40x
         VOrbp99oBYG3yVPn/GmOvXZd3x9nEc8LO5YC8XYI4QHJNZ0xDYphAZYRZczzqz79fSS3
         RCSJgrYBPV9U+XTNph7H8Wd7l8MHaZHgnJGeQgGOV4EYbUv/ylhFtwsDPNNaOvOv/rkv
         bNsKuwhZAM4a4wg7rLToVAYuo4hrmGzTmafzyTr3XEDPF3LGUUbCcqTZrHmuEgqBQ6dt
         p/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758459584; x=1759064384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+TxbCJDfqUR5usrZF8ZGw7MDVN54yzt0d/I/rO53p4=;
        b=SAMofNyBhr5U5AbIFJm717SgbuwxfYCPxexF5gRbSkcydu481aNOV0ejZNYJjwr2QZ
         PmK8rekNr+kk/pCZch62EZ/xMJBG8XDPq4vA4QESC/+vdo3ig/9nKiFXFT4aru+EKczd
         GGqS+n4owPnRR7a8nQzFNRd/hwQOYMtoDClNB7yCSjDCF9krDmoSAWvOdH70il6i4//F
         ZxsCoJR5EsSoJ5QApqglQGfuQwH4LPlLoj1N/PHtgzMpFuP2LiewaqSqv4HKmRaEQKDw
         EcXUF3YS15ZOsfau1/ib/gEWbU3TdULyX/1LIOXYBBavT3oUNcbSyF/aekxeinLpuJuJ
         8MTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/GdGmovhBbX6rGSIJmKq+4ONZ7/LvWH5MjWaFkSfd+5xgPhxVKAP3/nwsOQ+yUXE0ckdRKV0hR7JdXs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWTgR4WqZWa4tmAx32ZORGZZuGzOQlPJgQA2FdTd/zA1sp96WT
	llXzEpGz1182kvTJEd6190cXCOdFLTY4Reqo6vD4NpcwRrEyUgOws4wK
X-Gm-Gg: ASbGncvLmQgSkssVXotaak44qG/gluiwmAUxUlnzp5K4uO7s3A8sPSSOyRTqY6e0ICF
	L/et8KYotwKjMDDqhklYspkrjM4nZ8Sl6/Q2pwWlSbMnRoxKSh4KDDHXcy5/PrhsmCb5kY/tuSD
	GfzVuvgSQqtWuxJstQ4g/fmODzLj/GXR7aDBNdFYG+WSe1uUttp7f7ZjjobIfA1Ynzeu2eXT8H2
	qeN4z89dPFJb4//YIHDvbdeXlNmiOUqWkn8gJwzoyedxCSWMLPXLaCJbLdIRczFEbITuC8B6pog
	oqWZEDDMrVZObJWbbRkw+zJCbUPvJo7QhPOU/5m0RetIVv4RGYo6pYXehR9KqRWtXYIC+iNZ5fL
	GE5tyrQ1JbdbX9JZI+mKxpjNwCexUYPdwiW54Hq8PQ9PYdUHH53lqiFQcx30RGbbuDX+ytTMraQ
	==
X-Google-Smtp-Source: AGHT+IGYaR2gQ4apuGZRpv2ImMcFvulHtA0EBUVIq7xsH5xPkqYWo+X8dnpiiDAv7FxtRFcsrTFnrg==
X-Received: by 2002:a05:6512:6809:b0:57a:1846:9514 with SMTP id 2adb3069b0e04-57a184695b9mr2571830e87.9.1758459584177;
        Sun, 21 Sep 2025 05:59:44 -0700 (PDT)
Received: from kuzhyl-vm.home (46.205.205.154.nat.ftth.dynamic.t-mobile.pl. [46.205.205.154])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361a1e079e7sm22297751fa.13.2025.09.21.05.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 05:59:43 -0700 (PDT)
From: Oleh Kuzhylnyi <kuzhylol@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sasha Finkelstein <fnkl.kernel@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Janne Grunau <j@jannau.net>,
	Sven Peter <sven@kernel.org>,
	Neal Gompa <neal@gompa.dev>,
	Oleh Kuzhylnyi <kuzhylol@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v10 1/2] dt-bindings: input: touchscreen: add hynitron cst816x series
Date: Sun, 21 Sep 2025 14:59:38 +0200
Message-ID: <20250921125939.249788-1-kuzhylol@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for Hynitron CST816x series touchscreen bindings.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Oleh Kuzhylnyi <kuzhylol@gmail.com>
---
Changes in v10:
 - No code changes

Changes in v9:
 - Adjust linux,keycodes: Add items with event descriptions, and remove maxItems
 - Adjust dt example: Fix four-spaces indentation

Changes in v8:
 - Update the bindings title to indicate CST816x series support
 - Rephrase bindings description to describe controller more precisely
 - Remove redundant description field from the reset-gpio property
 - Completely remove cst816x,gestures object with all dependants
 - Apply linux,keycodes to represent gestures (slide up, slide down, etc.)
 - Extend dt example with linux,keycodes
 - Align indentation in dt example to use four spaces

Changes in v7:
 - Introduce the gestures field along with its sub-fields
 - Make reset-gpio property optional
 - Extend main description
 - Remove "touchscreen" reference

Changes in v6:
 - Fix minor tweak adviced by Krzysztof:
 - Move additionalProperties field after required

Changes in v5:
 - No code changes

Changes in v4:
 - Add Conor's Dooley "Reviewed-by" tag

Changes in v3:
 - Rename filename to hynitron,cst816s.yaml
 - Update description with display details

Changes in v2:
 - Apply pin definitions and DT headers
 - Use generic name for DT node
 - Drop status field

 .../input/touchscreen/hynitron,cst816x.yaml   | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml b/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml
new file mode 100644
index 000000000000..72d4da636881
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/hynitron,cst816x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hynitron CST816x Series Capacitive Touch controller
+
+maintainers:
+  - Oleh Kuzhylnyi <kuzhylol@gmail.com>
+
+description: |
+  Bindings for CST816x high performance self-capacitance touch chip series
+  with single point gesture and real two-point operation.
+
+properties:
+  compatible:
+    enum:
+      - hynitron,cst816s
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  linux,keycodes:
+    minItems: 1
+    items:
+      - description: Slide up gesture
+      - description: Slide down gesture
+      - description: Slide left gesture
+      - description: Slide right gesture
+      - description: Long press gesture
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/input/linux-event-codes.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        touchscreen@15 {
+            compatible = "hynitron,cst816s";
+            reg = <0x15>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <4 IRQ_TYPE_EDGE_RISING>;
+            reset-gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
+            linux,keycodes = <KEY_UP>, <KEY_DOWN>, <KEY_LEFT>, <KEY_RIGHT>,
+                             <BTN_TOOL_TRIPLETAP>;
+        };
+    };
+
+...
-- 
2.43.0



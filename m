Return-Path: <linux-kernel+bounces-780722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A91ABB3085F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA371CE35A5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6762C2C029E;
	Thu, 21 Aug 2025 21:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K29NIjwk"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E432D2C0279;
	Thu, 21 Aug 2025 21:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755811770; cv=none; b=uRzhkx0TFnzKDzS84AlIkPBSZKGUW1EgU5HExlbjf1mox4RxIeQQIZwQ+XyoS576tjfsMIrJzjgMjSkTYc4CUaXDPbkydBSD3H1Vv5QVbkPMqNyrPrq0SvAhT+MxX4BzC2QO5c04G4N+pE2OE4fCIgFkpjwAuakdlcyRW1zQIdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755811770; c=relaxed/simple;
	bh=MGkMWVojBi4DcnkqKXLZiZPVzHADNI9Vaw8JwD0VVeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LY/HEFm/Y0v+XY2WH2MnUgLMTXtuBrNnAwnmn8MFtsYNcTx5o4LFJG6YN1ESkVeDWn48HQCtNBrWIktzZejpgYLU6TCHs0MN3Ya0uftRpxo+NR8KRngwPrNxNP6XZ7BtZFVclaDxfCy7HOtij5UhMHfbs4v1rnPSZ+dnaIl+u+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K29NIjwk; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3c43399ea42so1020143f8f.1;
        Thu, 21 Aug 2025 14:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755811767; x=1756416567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARVHRfZ+bnQXEr3530WhZ1gxls6jH4IGcbh0pM6grxc=;
        b=K29NIjwkXqZyB9nsFeARJ2dlj5Aw4xaDtl9Tfm3EX1gjAlxX0r4I/gOCbN4/LO3if7
         KKTE6yNFl1utfyGey9rnZwJCDmqQCfUE+P3ZEmmIVg/tMMHXHe1BICflR6H+KPHn/7A6
         rqn2iLBR5PG2PjMxtk/aLxlHW99XXfDDqzhgupFlJ93qa7yl0TjCk94NHn8TmezWg0hr
         nlH5wEcY1ZAmUWHRl+K65NdVViMgYWtx5yAKsJD6ALjiJoYVDaZ1Q47vs5QTwC7iy1hE
         EJ5eT7MEj2nTlxF31WBMhxJLIDW7/ajXj5ABfuTveyX5txIcKXJNwQu8RGgkA7YyNB6I
         h70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755811767; x=1756416567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARVHRfZ+bnQXEr3530WhZ1gxls6jH4IGcbh0pM6grxc=;
        b=rudY6EN0LTpKRgczj9UU1XKXuAr4PmNPQGgMqopiceCb7ojQ2nDMUL/ZH/WpmlZCjE
         LBt69SJrblk9uYAf0ZG7Q0M5sPiZgnW8sjcCRq9YtNqmL5kZEUkg8dU/Kxd4svwp6lWI
         hRiH+xmuiTMGjtLl3Z/NABV7nABjNK8RK4HsujGA4CBczBwkERrQUuBADaS3rFlKdST7
         JQ4v5iFUvKBbdiYN/h5O54Uim0/IQYDIJxOfJ1CBJ0+8T1HadteYD7m3E30S3X8MzcoZ
         /FPeXanT4LchrVOCaxGLuRrBO+fu4I8A/2jvN3p094vOsTBuWn3cryQVatR1MpBbl9ho
         IPyg==
X-Forwarded-Encrypted: i=1; AJvYcCUwTj83osUqiTELbqgQsU3IsCblfGfPWvtGS1thbfR0brdcNTHxcEPHrT1XtuAUbdcn1dgHxuyTtt9c@vger.kernel.org, AJvYcCVLEwEBW/xaGJf/KrursJ8U/K7H5bCmwZfLYlj7XhFtSxOduHCea+1FpEnw0fqXylq7Vbs9iWfofNNq@vger.kernel.org, AJvYcCVpg4MbdZy7UZ7l2G1bp+x4huA5ETHSJ51V4elV+CNy5WQXebB/JwMVVm0/NHnbrPIuLMU0Syh7O53/xzMc@vger.kernel.org
X-Gm-Message-State: AOJu0YzGr5Zj4ziOE3ss+VX0m8i1B6rUgLNYcIbm7fw2kv+hB7dQorzS
	/cg1xuBk0dMdiD6bniBUK4IF7VOfrvJOtMp8RVUcmIASjsaSztI89fs=
X-Gm-Gg: ASbGncs8xlyQCfp5wEcQ3DI2DuNBXgLT7aORbxFU1Hlxe1cMYeSeBSmja4D6TWGmXcH
	ysg2knhBpj/EyN2OTV2kaTUvh1xPmCvptsBM8+X5fjX/t3Vy9eAGme8VU8kubx+7x4gkT0h+Ml9
	eqOkEal7aD/GthYuKQ43BgAppWJgAIrvkFcD1mP0QGPu+KX5E5WkyzYQbtb/OSdHdDPIoK5oziu
	CHu42DjiKWNbRdA7s6cmsTNiJ6AgEqKFiUS9lKe253MJ9LvMsgtzY98NatfJDW95mqLu+NasGV+
	5omDGSwcil6daJg7dMq2ubozP3QeDUmrrhz01BrEPrPqDvx69m2nVe/UTUXZzuT99jMKr7GE9rP
	qnEg2pRfskUY1EiSvpzwJK0DGflOWGxtP8EvNrY4nQv1Ig1k=
X-Google-Smtp-Source: AGHT+IEiDzxFdVgLh23klK3CW+TV6wMTaDQQPmg0KzEnRFvBy0KD4LNe0iJ34cCv5FhUbNwY6rJ8EA==
X-Received: by 2002:a05:6000:18ad:b0:3b7:8892:ed8d with SMTP id ffacd0b85a97d-3c5da54ed40mr315187f8f.6.1755811767186;
        Thu, 21 Aug 2025 14:29:27 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:142f:8982:f293:902e:d51a:6b6f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c4c218c62asm3945798f8f.64.2025.08.21.14.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 14:29:26 -0700 (PDT)
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
Subject: [PATCH v5 1/2] usb: dt-bindings: ti,twl4030-usb: convert to DT schema
Date: Thu, 21 Aug 2025 23:28:23 +0200
Message-Id: <20250821212824.70569-2-jihed.chaibi.dev@gmail.com>
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

Convert the legacy TXT binding for the TWL4030 USB module
to the modern YAML DT schema format. This adds formal validation
and improves documentation using a conditional schema.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

---
Changes in v5:

 - Split combined twlxxxx-usb binding into a dedicated file for
   twl4030-usb per maintainer feedback.
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
 .../bindings/usb/ti,twl4030-usb.yaml          | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,twl4030-usb.yaml

diff --git a/Documentation/devicetree/bindings/usb/ti,twl4030-usb.yaml b/Documentation/devicetree/bindings/usb/ti,twl4030-usb.yaml
new file mode 100644
index 000000000..a2d3c5f60
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ti,twl4030-usb.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ti,twl4030-usb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TWL4030 USB PHY and Comparator
+
+maintainers:
+  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
+
+description:
+  Bindings for the USB PHY and comparator module found within the
+  TWL4030 family of companion chips. If a sibling node is compatible with
+  "ti,twl4030-bci", the driver for that node will query this device for
+  USB power status.
+
+properties:
+  compatible:
+    const: ti,twl4030-usb
+
+  interrupts:
+    description:
+      Interrupt numbers to the CPU for ID and VBUS events. The first interrupt
+      is the OTG interrupt for both ID and VBUS events. The second interrupt
+      is optional.
+    minItems: 1
+    maxItems: 2
+
+  usb1v5-supply:
+    description: Phandle to the vusb1v5 regulator.
+
+  usb1v8-supply:
+    description: Phandle to the vusb1v8 regulator.
+
+  usb3v1-supply:
+    description: Phandle to the vusb3v1 regulator.
+
+  usb_mode:
+    description: |
+      The mode used by the PHY to connect to the controller:
+        1: ULPI mode
+        2: CEA2011_3PIN mode
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2]
+
+  '#phy-cells':
+    const: 0
+
+required:
+  - compatible
+  - interrupts
+  - usb1v5-supply
+  - usb1v8-supply
+  - usb3v1-supply
+  - usb_mode
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    usb-phy {
+        compatible = "ti,twl4030-usb";
+
+        interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-parent = <&gic>;
+
+        usb1v5-supply = <&reg_vusb1v5>;
+        usb1v8-supply = <&reg_vusb1v8>;
+        usb3v1-supply  = <&reg_vusb3v1>;
+        usb_mode = <1>;
+
+        #phy-cells = <0>;
+    };
-- 
2.39.5



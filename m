Return-Path: <linux-kernel+bounces-898730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 53726C55E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED721349B2C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7271A9FB5;
	Thu, 13 Nov 2025 06:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pegatron-corp-partner-google-com.20230601.gappssmtp.com header.i=@pegatron-corp-partner-google-com.20230601.gappssmtp.com header.b="wmJp/7/k"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7798F257835
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763013667; cv=none; b=HXsM4aQZzLPJg56In4xptbnskvf/hwmq7gp4PCbUq7B1EcIjT/EBXWDUyRGpdCt6mPJDISy2S5S4I3Fp1GDxy5P3iD1gzC6VxJmrfECgWNHY12TJJzHPRUQzhNaMFXZM9UFJiY9/CXgV8zKCVDmoX5DiNZ9yZoESi8No2IAvARo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763013667; c=relaxed/simple;
	bh=kuOeGZFQT/f/0FhAGgtzbuu2gA5P5O9d1iMM6mlyYsk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QeP5Te1rby34D7jp3mCBVj15Ns1U8B0yMxJSLE3qIoKP8MKgafYMvr3GpnbQbNwEpQ3zPVGf7JyhsS2LyCCUTtEHRdhpVvAS4WDBJoQ4hCS2hdg4FHz+QevXwSezDX46DWyfMDjX3Ddk+c62wjyx11ipwybVr2zfkgbeo+cxc5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pegatron.corp-partner.google.com; spf=pass smtp.mailfrom=pegatron.corp-partner.google.com; dkim=pass (2048-bit key) header.d=pegatron-corp-partner-google-com.20230601.gappssmtp.com header.i=@pegatron-corp-partner-google-com.20230601.gappssmtp.com header.b=wmJp/7/k; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pegatron.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pegatron.corp-partner.google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-297e982506fso4588655ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pegatron-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1763013665; x=1763618465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5oIGmmDI+hfaRP8t7dZerzB5+6Ar0oCioTjqpXWebhk=;
        b=wmJp/7/kVpElnTuNsEFi3sZoRtU103QSL8HIo2G5mmGzstU2w+bb9Y7Xi8CPi/xe2A
         LWIwqvzKUsaCaYmws+c6HtoVAp67EfZEDBVEDn60FYC0bmM50h3h+PAaBhotrf6MygyH
         SCW2kpgePSwn//9nCaQmToaWrAA8elS7Mq7jxJ00tl9AN26s5LwM5ETIqya/o9l3F0sv
         4IS7A+FaOjxtVgBbDQhWlvZCbbkSed4QaTLrbd//F5XRQucpL3J2zcRhA1nKJW/+OA9v
         vbzKWA7+zXFVc1AzPSwVmLUcIysSJNBQni+kwvu6nfm0lRXUFxwgL/BBp9uYypJ8Hhr8
         VbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763013665; x=1763618465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oIGmmDI+hfaRP8t7dZerzB5+6Ar0oCioTjqpXWebhk=;
        b=OOaIXz+YDtNZP2Y+Rz+KQhV+v1ma/4CCByMfqZyK/TFfgXl0mkysd6yIiLRIKDeYiK
         aY7XwfyWaxYAED+/4swFc9MYuwqbxL+7ztc1H7tPP23OAj/6B93IFYoKuMV5XWIeHiOd
         qcVuouca4J1cX20+BxKQWvsdKnVCzXPHb/Y9zgHZ73sz1BdeVThl9SESU+PdcWrxFTYg
         LwpYn0vfNCeuxfMtGmn+97PFMMr29oij8oZRXOfI0xwv9j3fn8k0oM4UPBXS/og0rRS7
         OO86NDYVO9NJ1gej0iZdS7xQECCX95xB/EeoQusu2kiYSoCViAbXpz78/QmZdnDdQ0D7
         +2AA==
X-Gm-Message-State: AOJu0YzkXzY9/O4FDNdibkH8irlGqf+DfGFfR4yGWdi+rmfbxXtQCXNi
	0GJ7HvATdVtprxrhT3gmLXWwG3129SGrBm/RNeFZk7jU6RDyT8L6XE6noHhH64jzwDY3HtpOzKN
	Alxs=
X-Gm-Gg: ASbGncvFBJeNCmWOMcOzXwyTLHdbn6r5tVrSk+N8tSS1fFd3o7uXPPS5gj8Khla4l0i
	ok6VoBXLtZjSLOfu4kc7YQwqWylglI0nY0EBmIFJZFTNArNTbPXh0rew8QIDPWCs0Qz8Z5mHor2
	fdxEILKn5fBIl1LORxLtUbJkUV86P3FdxrCEnonvUuVIb86uOwJTPjxMkbvDTnk1sW0UnnR44oZ
	aIiyOotD0MqYi6l3Hmf4qec9f4HVZt7/xRBUiGMc/gdmye4PabDihH594LyjIcSYGLtKgKz7aHq
	InnQ1IxoVOt+rUHkwBfz0tYBPZG3vRf68+LsU4HpNiCaMWRpD6rig2frLFBvmZG02NJf9tVOo07
	cnauo4kF9VTIsgpiT9bOwtfQWmnG7B6++V/cf/ON4b8X6mFhUWAyEUR7V+tVqRATgyfqWBoAt4C
	HFPARcal33q73ZJf3UyyhKHc03YMU29gqo2fDE9VcI4rPfd7xvQ/kZsjt3Sw3gFR/iOjoTwkQ66
	vVrTnu8JPgRFCwABM5rpoV8c/8GYC/eobRV2cDvchckfYzWXGdGVmxw4EU=
X-Google-Smtp-Source: AGHT+IHl4CMHgMPnqQlqlMpLyBS3V9JYYqv6sC4byrdMlvvBtXLGwvPWMRRpG158Vi+Psllo/1LnVQ==
X-Received: by 2002:a17:903:2f88:b0:298:250b:a547 with SMTP id d9443c01a7336-2984ee2c611mr75838625ad.56.1763013664692;
        Wed, 12 Nov 2025 22:01:04 -0800 (PST)
Received: from sw-TUF-Gaming-FX505GU-FX505GU.. (2001-b400-e2ac-65d6-f289-5b0e-1295-0dbd.emome-ip6.hinet.net. [2001:b400:e2ac:65d6:f289:5b0e:1295:dbd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bf158sm11387535ad.91.2025.11.12.22.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 22:01:04 -0800 (PST)
From: daniel_peng@pegatron.corp-partner.google.com
X-Google-Original-From: Daniel_Peng@pegatron.corp-partner.google.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: input: i2c-hid: Introduce FocalTech FT8112
Date: Thu, 13 Nov 2025 14:00:55 +0800
Message-Id: <20251113140004.v4.1.I894dde5015f4acad94cb5bada61e5811c5142395@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>

The FocalTech FT8112 touch screen chip same as Ilitek ili2901 controller
has a reset gpio. The difference is that they have different
post_gpio_reset_on_delay_ms.
FocalTech FT8112 also uses 3.3V power supply.

Signed-off-by: Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>
---

Changes in v4:
- Move change log of v3 under "---" correctly as below 4 items.

- Modified the subject description.
- Modified maintainers to myself of this binding file.
- Fixed the extra '>' on section of "interrupts = <15 IRQ_TYPE_LEVEL_LOW>;" and confirm command 'make dt_binding_check' correctly.
- Restored MAINTAINERS file.

 .../bindings/input/focaltech,ft8112.yaml      | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/focaltech,ft8112.yaml

diff --git a/Documentation/devicetree/bindings/input/focaltech,ft8112.yaml b/Documentation/devicetree/bindings/input/focaltech,ft8112.yaml
new file mode 100644
index 000000000000..197f30b14d45
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/focaltech,ft8112.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/focaltech,ft8112.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: FocalTech FT8112 touchscreen controller
+
+maintainers:
+  - Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>
+
+description:
+  Supports the FocalTech FT8112 touchscreen controller.
+  This touchscreen controller uses the i2c-hid protocol with a reset GPIO.
+
+allOf:
+  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
+
+properties:
+  compatible:
+    enum:
+      - focaltech,ft8112
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  panel: true
+
+  reset-gpios:
+    maxItems: 1
+
+  vcc33-supply: true
+
+  vccio-supply: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - vcc33-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      touchscreen@38 {
+        compatible = "focaltech,ft8112";
+        reg = <0x38>;
+
+        interrupt-parent = <&pio>;
+        interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
+
+        reset-gpios = <&pio 126 GPIO_ACTIVE_LOW>;
+        vcc33-supply = <&pp3300_tchscr_x>;
+      };
+    };
-- 
2.34.1



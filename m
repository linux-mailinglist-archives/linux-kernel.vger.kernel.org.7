Return-Path: <linux-kernel+bounces-754261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25081B19196
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 04:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF2EF7A2B37
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 02:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B5119ADA2;
	Sun,  3 Aug 2025 02:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="AFCCAYIE"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D370845C0B
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 02:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754189901; cv=none; b=TBE2bQck4z+GUkfuffOtSdPC02mNDrvX5ks1gUJsPw8hn8hv3CzJmlGQ1CyE9S/zwG8uhvhaGxNZ9JG87jwhHMZglz0ZPTAMLRBLsMjAx+3SqUmXYk1zAPrTgmmELFNMKkAHWXORA+jRPgpC4cpzfcqPlNVuH/VBiRmLzdyGSrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754189901; c=relaxed/simple;
	bh=f3e7VDZ5RpctNbfj+dyIcOXKfTplNtROBxfFMgGp3q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYep7YP+mGSCESqLFnV3YCPb0b0QL3zWn3nVxYr4pdj92wCZv5TZe1uAHPctJPu7TQV8PJnFsxK6G6GaipVAF5wtXkfu7rrBSwDtk+KPbn3aCvYK8I7ayJjO7gbqDiVmOR0GFAA3qv7Y/tbFKAPRfKOY5VFweYidmVnMdVMTVHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=AFCCAYIE; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3e3f0287842so27353655ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 19:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1754189898; x=1754794698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ek2s2DUqL/jgDZvOvv6Rjx1Dp3m/erc1mrYIyBeINSk=;
        b=AFCCAYIEp/AW/hyrmC9wCGgH4ayQm8hS9iGGTVrkoLg9svXnhJcCb2esBkWnYTdvd4
         hLB4rWiHGU4AVuJMm/v8pq6QXo27WlTJYZeGOc3RhUJnFcCigEBx/wBu8D5k2UYtORb0
         KEiAD2FbjbyvOau5tCZRI5cWHOyK7PemzitfeO5C2xI2Vwu01BTL17PygEvLmHkn4ew0
         mGTwL48nI/Wc77mkguc1qHczaW70CEF+huQGz+pKych/WGyP41KpPJWRP4K55HkO5xSN
         ZqXaMVOwdtyAt+CMRfDpu5P9vViJAEX544abp2CdtjRuJeyBU+Nt61t2RXLwLjqAvEve
         Sllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754189898; x=1754794698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ek2s2DUqL/jgDZvOvv6Rjx1Dp3m/erc1mrYIyBeINSk=;
        b=KHvjudgzKtMFinyt3iGw2TTCmdd9mIdjzhai5+rlMJKXnSk/yO4NGJZPgJ55yBLT13
         GYSUbCw1FZTCfdRisNXLAZ5zWHe6EmCyDtyn51XMS/S7UKUDwoWRSBOlY+vPaOTJm9hN
         X6QxjclhVPrRSB+/ZBLGmVUwoZYByGivyE6KVFCC9xIhoNLsKkWe9Huew4uZFDcM1IiN
         BxdaRtNJ7aiB/4btWAY9Gi1bN7t8ik/f8Yj/I08KxLYl6yxTq1KW7OcCp8ry3h+Pf77N
         9IEK+OB+MyBm7esHGOS7fnh1ZkxW1g+Sz/1ng4c8AKzbsqN0Nq7w+D6rC42TefJIbuew
         6dHg==
X-Forwarded-Encrypted: i=1; AJvYcCW7UKtxk4uZ9z71qFCd6MppY0BPIMqkJ7+qEdnq832aBillSr43nvFJQFACiTxqgm64u2aDpRv9a1zxMmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyZoiBysE3BXPUeHvkZR6WOWVHp7fNOuUDXIo/1GP/XuOLELAi
	07yqAOvUodjGvK9boaPCKh19lBJIApfYtRhcKN4i3A6s6Zyo1uKQwhkL322ol2SkVGQ=
X-Gm-Gg: ASbGncuLzk0NMDjegz60GiXfBG4S6jau3nC92tMkDfOscqmkhRZ3zVtDNeijDiS18VC
	dX96jHofYOb4kQtNngFTTuCKqesa9QILal8RVnqmRHr2yq0RjcOyMFQvIwPA2pXYhCRIdzIa8vr
	1fONsKpJs/oQKi05IK4O3q0VrOY+4z1Fz0RcV6PTljxxBy/IEOLxKTQA+jrfiygEWZ59jiKdyH/
	WnWZSocI2H6OZcSjx+BFKoviUO+k34mArbdq9OyoLgaC/fSG2oewnU5L4GnF5BkKCrhjK3R0zL6
	erHBm+APYGByxtdUygZqrDZZ94j3rI59hWbXwyzoVjk/gNf2W0RPiO2YJOmQbqUB/iPRozgN+DR
	BbHe0goVKr2mBK9lXdZg3Y1qtKqyeqtmvE8Mhrhro7TKm/3OnGnvYa1Jms7ICuz2mww==
X-Google-Smtp-Source: AGHT+IE1EI0ik3qR8R9p6oS+/rMP5rmrF5tbzg4vFpoKSdksN0WY5toRor+4wX4VhlAJ+LsTRTCKSg==
X-Received: by 2002:a05:6e02:1485:b0:3e3:c6a6:2799 with SMTP id e9e14a558f8ab-3e4161e006dmr100052085ab.21.1754189897967;
        Sat, 02 Aug 2025 19:58:17 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55b1ac2esm2251906173.1.2025.08.02.19.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 19:58:17 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: lee@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mat.jonczyk@o2.pl,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux.amoon@gmail.com,
	troymitchell988@gmail.com,
	guodong@riscstar.com,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 1/7] dt-bindings: mfd: add support the SpacemiT P1 PMIC
Date: Sat,  2 Aug 2025 21:58:05 -0500
Message-ID: <20250803025812.373029-2-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250803025812.373029-1-elder@riscstar.com>
References: <20250803025812.373029-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the SpacemiT P1, which is an I2C-controlled PMIC.  Initially
only the RTC and regulators will be supported.

Signed-off-by: Alex Elder <elder@riscstar.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/mfd/spacemit,p1.yaml  | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/spacemit,p1.yaml

diff --git a/Documentation/devicetree/bindings/mfd/spacemit,p1.yaml b/Documentation/devicetree/bindings/mfd/spacemit,p1.yaml
new file mode 100644
index 0000000000000..5cc34d4934b54
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/spacemit,p1.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/spacemit,p1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT P1 Power Management Integrated Circuit
+
+maintainers:
+  - Troy Mitchell <troymitchell988@gmail.com>
+
+description:
+  P1 is an I2C-controlled PMIC produced by SpacemiT.  It implements six
+  constant-on-time buck converters and twelve low-dropout regulators.
+  It also contains a load switch, watchdog timer, real-time clock, eight
+  12-bit ADC channels, and six GPIOs.  Additional details are available
+  in the "Power Stone/P1" section at the following link.
+    https://developer.spacemit.com/documentation
+
+properties:
+  compatible:
+    const: spacemit,p1
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vin-supply:
+    description: Input supply phandle.
+
+  regulators:
+    type: object
+
+    patternProperties:
+      "^(buck[1-6]|aldo[1-4]|dldo[1-7])$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@41 {
+            compatible = "spacemit,p1";
+            reg = <0x41>;
+            interrupts = <64>;
+
+            regulators {
+                buck1 {
+                    regulator-name = "buck1";
+                    regulator-min-microvolt = <500000>;
+                    regulator-max-microvolt = <3450000>;
+                    regulator-ramp-delay = <5000>;
+                    regulator-always-on;
+                };
+
+                aldo1 {
+                    regulator-name = "aldo1";
+                    regulator-min-microvolt = <500000>;
+                    regulator-max-microvolt = <3400000>;
+                    regulator-boot-on;
+                };
+
+                dldo1 {
+                    regulator-name = "dldo1";
+                    regulator-min-microvolt = <500000>;
+                    regulator-max-microvolt = <3400000>;
+                    regulator-boot-on;
+                };
+            };
+        };
+    };
-- 
2.48.1



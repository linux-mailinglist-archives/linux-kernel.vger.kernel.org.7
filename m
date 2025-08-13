Return-Path: <linux-kernel+bounces-765794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5274B23E57
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 04:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5275C1B63003
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 02:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42B51F12E9;
	Wed, 13 Aug 2025 02:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="sf0B3yS1"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6306312C499
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 02:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755053118; cv=none; b=SAXp4wncdjSn7EzIMfl/Bv9fyMtOT2CE0SNYbgYB6YeeQWpxhM0Eajw4ufx1bqf85ny3XySk63xeVQqvyLcKqyZsgIB5oA5enJLELSSi5D/3obLLHbAnzf2kWe1zYArxJg1nJWzQlVKSemmPpgrBJ0LoTC5UscePxTbXBLJUF0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755053118; c=relaxed/simple;
	bh=f3e7VDZ5RpctNbfj+dyIcOXKfTplNtROBxfFMgGp3q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpA+w9G7OFXCY9ymWSiv2Jmy8cHBfqZV27cN0ga1XTma8qcSI0cbBd1sA/oAVOs5Xr/bch1j4Rf9ejTbChSCSFUfTfGn2ZMwaUN5WMM7uEjrdFcB2O0FUq0XA4F9f6TkQcfHYPv+alSgnnpvrJ71XnGws6rvdrsRDno3qme12ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=sf0B3yS1; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3e5684fc1edso1342235ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 19:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755053115; x=1755657915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ek2s2DUqL/jgDZvOvv6Rjx1Dp3m/erc1mrYIyBeINSk=;
        b=sf0B3yS1qPud7q0W3S6BWnLkjqfU+/Ju2ZJenWEd5LYeNeg+/pSFoLuBki6/pm9NGN
         ZvPeNY8njAoqVaHrLOHzQAusHYSmAYC8etonHWddbRyG/tYcjaM2Nll3ynGj6F1g6min
         Q7YQMxm/flHGpB+Nk/eVBYDPWa9zAEActpDiZgoo8CtqLfYsyNGVWlHW5zOZzXycBSM3
         uUP60JNt3X3/rB8ZZiNkyz5kuf3OwzDbWthTq5aFh838vBVq3izeciEcPl5lYnXT1iu6
         AJGdWzncJuQmNv7lOjOvgRXQntzsfck1oZWkbVPMprIbUqqsbDRwHnBml4iKm18N3Yux
         7MEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755053115; x=1755657915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ek2s2DUqL/jgDZvOvv6Rjx1Dp3m/erc1mrYIyBeINSk=;
        b=rSOg5KYi9/SE4QktmzsxDNhXNaaxxVDmVWkjqKy201OokazVRIhmIuQuOGD0h8XFl8
         O2zoGXYFlUo6XGck32Lm1ILUc2j7Z+bCOvq2gxZzCr4o/pYTT2MjjKrJ2G89tGZ/ofxG
         i3Ncih+Q+/yKstzFtxZAvb4j0QhdPUl7ep2NYQq9yhS0n8Rth/3/jO3NWVJDP+zcyhbp
         bEldoUJ+3YdLLTvLMpeU8dhUsbknoLKHU2IJkrBlJAQQ0gq/mCpojIT+Fnmztme0N/Ra
         pxQYSeeA+EQ+Jf/pYz6JymvA1GzqZGmFR1znPBzAfcoE+KvNae2z6FbSiMhrT8ziKQzL
         8FFA==
X-Forwarded-Encrypted: i=1; AJvYcCXJHselZLG9GYgtg4S4QFYBPLnfA/Qo/Dqp4IPUZ1azNzZb21bi7QDE1YjmUTrYIAKlzYhW9FgGZm/ZRR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQJFhA6hRsS173anmamYc0uYZ2Td0HQKW1Op1PncWU9BAqzQxz
	JMHChHoN+0ZA9dW4YQgUPEp0PKOPh/JVNbIn7nRy6SiiAQjypWWVTFrKkaCtCvnnaDU=
X-Gm-Gg: ASbGnctBvegThw8R1dih/mnnQnBZy+7fT9jktkaUM9PIAY7hC5ugm5eteZ5IgssTC1C
	uI+oqPpM+sMHj3ZlYIddGiqP80LKUpedbKN+BMZi7bObW4vymYicRWzsPrv69EsUuO4wAEhEs95
	9agvk4hF6hI0aBTxvMdvdfwGb9leNPnDTn0FZwpkv5lH3q0NqG3DD8/WNGDyFbRB9LXfE5cMjlT
	Zb0KW7oBqotKjs8YGgu+nPUV3fbAIr+e3lM3iIYm6s8wFF2MQ6cnCG/XSz+L/jCX9XZeIWhyKz5
	319mUhypwYJo9nMgpbAb4y+l5blo6+//DUVZ7W1K6PXMe8FnRro44cwxRz60HXXtX/HAwoV96X3
	ScvGg8hsaPqXWerGcOIx2HzE3VWV4tZGfYtNyAAsTVyfb5dCmqO4tVQ2cP8lxr/mJWQ==
X-Google-Smtp-Source: AGHT+IEIj1vS5MVYprDokhwZ6AIsmFX7Hyk7OB0z1ohQkNDbaDoool+pCm1v0mkiT6rf8e612agvcw==
X-Received: by 2002:a92:cd86:0:b0:3e5:40e5:bade with SMTP id e9e14a558f8ab-3e567367d43mr30922625ab.3.1755053115415;
        Tue, 12 Aug 2025 19:45:15 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae9bcfbf6sm3430829173.54.2025.08.12.19.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 19:45:14 -0700 (PDT)
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
Subject: [PATCH v12 1/7] dt-bindings: mfd: add support the SpacemiT P1 PMIC
Date: Tue, 12 Aug 2025 21:45:02 -0500
Message-ID: <20250813024509.2325988-2-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813024509.2325988-1-elder@riscstar.com>
References: <20250813024509.2325988-1-elder@riscstar.com>
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



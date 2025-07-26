Return-Path: <linux-kernel+bounces-746733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E276DB12A95
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 15:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907814E6F4E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 13:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2FF24728F;
	Sat, 26 Jul 2025 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="MEalPpci"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA92B246776
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753535413; cv=none; b=IS5m7cley+ILPI90xmOe0C+U0YlGq65xZTbYI9gI3oPEq9txSYGW6rFRCNleF/SUbUthTYMlidv2jXpd4cTWOeoEPKejU+zm3/MeVp6D+qiUTuUkYHV1u67RefI6lwbC3vvTehpwEopIXh0NV05mZamBXOH7pLk828C2xlJli8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753535413; c=relaxed/simple;
	bh=f3e7VDZ5RpctNbfj+dyIcOXKfTplNtROBxfFMgGp3q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPN1/zbtUOynvFb3ceQqrXf69h2VdKnT3DNmJSrFVi4Y/e/ah2qi1Xs8oXG1FW6TX0s7F00+HOLHGrcW+nrW+Y1VRyixWdfwZHLkfFGuIzz2CnAPQRwAHtLnPzazAhZ4QyyKGFTrQMvWqOTCCQpxWnoURmWlQ2lghb2F3+BqXYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=MEalPpci; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-87c46159b24so110263639f.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 06:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1753535411; x=1754140211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ek2s2DUqL/jgDZvOvv6Rjx1Dp3m/erc1mrYIyBeINSk=;
        b=MEalPpciqofsTD23ypHVjOoZg3mhGgZTUzOcbhXJTTdTJEva7ETDHaxzFQzd+NzOdQ
         qAa9IffOjDq56G2SQk00cTgfbzW6PVVKLr3ebteErRFswMxoFOzqWrjIZnED2xm8egmC
         ykQXraZf/d/XWxS5mU7+GnsmMADwkKK456CO2HR+xzCNW4wlaHahXkGLfykABkJLJSoQ
         rJugMYJPbEFd4hC+ti36Pud7Nahtd3oMCmVbtX/MdpEywWPlKIm590sXN9TOvTRA8FPF
         Kur9IME8CCWZwYiOibua8U4YZb7pkOjd7eO+l5KBufTupbpmrIFlEADxuBGow7dbGHof
         hndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753535411; x=1754140211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ek2s2DUqL/jgDZvOvv6Rjx1Dp3m/erc1mrYIyBeINSk=;
        b=Ph848lKDy9BsB+6tlmAoorkWQWpCwPN8Vh1/ZplxgAUgN+TQNXC+qNiyABpZRbD//B
         z2g+W9sCsIXWd351wcqpBv/LhXR8H0EEfEzAgUzwbHbvY5mQWG/bNALxu18Ym7ZRvMuM
         IIiMl1U+hWoc7GC2sSQ2vVAgB3oSUoT2IdPUpy2K9pUbzyHRaTrDL6FWQamcqpG9oros
         DfwtiiLilMU98Oodui2Eh5GU4LytFKYnrcbNmXIAV8AY3UezHc62gHvSM1wGoMCNNK1g
         yjgXj/W5jp1OjL3D9aw93OD2wLMzWPZ4ZdqUcP6qR0SIJE65XUSeJgr0Dt5eqDTJHWY0
         iErg==
X-Forwarded-Encrypted: i=1; AJvYcCXIICSOkEUQ9Lqq49A1ZFSvugrFZGnHyrH2brVQ14+m6OGU/OJkk2oJCzua9o3jhgvUWiY9a91TE51kBhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVOiVgXuMjBDWLhlMyhNacn0X/F29fECzDW5jqBRVwYxxGPS7g
	VrGVLPj47m5wxA4tbPjNFTmPQMzJAO2KMs/EyfrPZaXFtOCt1iWFr5uCpX+mJmd7EXw=
X-Gm-Gg: ASbGncviVVUqob+mYQawpw+cU2bRi3WGXEG70zdMhS020FdW0tRNdOSYr6OfKMukPUL
	EIjAndXeVKWFMWTlBx7qb4MOO+mY/gu23a7Uafw//7PmLAHYjQ/7MLOuEDYq5VtiguUqgTuUqgA
	pqhB8lA4Kmzi/9gp/EW8p05CNAFDHnBjyQNIk6YGowfNvpqi207fMkttWZrp/q5EXmXkh3paP/x
	N7TySmFQfSwNoo9j9i5QIlenkxOYVdY0OT0DePAzMedrLUZheUdEVXqu8XbKAy6nQUiiRASyyrc
	1aQQFvt2WFKkzMPsZuNsmA5NbnJP23AwYSte2VUdu8L2psEYahX6OqZ+94tRyrFXI7ZL5Kl/TJw
	MMK9JKk+fNgbuVVQ6oW1JiobNmCMB52QqXAYp45W7OYf4Euu4lBi5ajCxW66fYHyeSqyiV1yTL4
	2A
X-Google-Smtp-Source: AGHT+IHyyfkAGrv7e9QP0fqrvp0iqIuBvwoIPIrl5BUPHk4N3KVmqmw/7gL1AW8CJAs0LQjqCf81DA==
X-Received: by 2002:a05:6602:29d2:b0:85b:476e:ede2 with SMTP id ca18e2360f4ac-8802293bd79mr912922239f.13.1753535410568;
        Sat, 26 Jul 2025 06:10:10 -0700 (PDT)
Received: from zippy.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-880f7a4ee9fsm49551439f.33.2025.07.26.06.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 06:10:09 -0700 (PDT)
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
Subject: [PATCH v10 1/8] dt-bindings: mfd: add support the SpacemiT P1 PMIC
Date: Sat, 26 Jul 2025 08:09:55 -0500
Message-ID: <20250726131003.3137282-2-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250726131003.3137282-1-elder@riscstar.com>
References: <20250726131003.3137282-1-elder@riscstar.com>
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



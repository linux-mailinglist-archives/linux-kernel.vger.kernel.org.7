Return-Path: <linux-kernel+bounces-849080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A35BCF2A2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 10:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C903E282D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687D4221FAC;
	Sat, 11 Oct 2025 08:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTGoklak"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2A6202F9C
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760172754; cv=none; b=GjWmNoGd3ZsXaNP0k5rftcibEoj04dVje+1nh6AEaSHDfMPc7a2z2fm9VfREtLoQWmuG7SqUC/kPY+87P22j5wj3c8KUbIEf86KeE1vUUSB3/9QnnWYgv672WUNoWybC2tJ6HsnWJLMNuNpv7glQTWRnfZbiu9YxOEi67LwTznQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760172754; c=relaxed/simple;
	bh=5NLvSnyuZikWYjbw37TkUeYgoM4N/stus6HiUzrLy9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BpKshCg3JCTSZg4G0Jo5AT83Z0d+BpylL3lIBXJpLq8J1N3SEsaPhM3vwRh1gngc0mAyaTCP9ELFjhufl8shTdkrPdP9b4QmsCv90Z4l2rcbs0cC7Zr5U8qz2BZREQ+QWiztMGlAWQ8e4aOgfumeceo1Vha8kQ6ZJtD0D3ZBrXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTGoklak; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27d69771e3eso18899465ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 01:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760172749; x=1760777549; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yiLmG63RpnkdfX+sUpwnDjdHi9WgZXbqCQLxRB/gE0k=;
        b=JTGoklakaz4tu0inAECC4pENcTb12em6AIM8EAkA/ZHcNNw4cJTPzk9qfpVZjJLxX8
         yahHRTT/DuSkJttspnpWb9zi8yT6m4IYG4xTU0hJARVfJZZ4KlojK2P5NxcVtLogT/lL
         hod+PjFZUJf7JiRZgBKWRR4Wpa8uoOdLlEZ2BjH1VYYuKd3n9jHoT10Ruaq3heGs/e08
         Opeo8kTCyXWyL0eu47agcWt38nTpbt0q6olIDPDOWVFfivJrGttqyuAiUqljpk+OpBFq
         ftCe/dE9FZsCoBFDekKIFV0X6Ckk41yht0Wt2QRAmiWScxmIgfCgkEvyuC4jd1UMU71j
         7Vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760172749; x=1760777549;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yiLmG63RpnkdfX+sUpwnDjdHi9WgZXbqCQLxRB/gE0k=;
        b=M82OBcPk/XHdDotWI92vgRLgsFcE1+t5yd+v6MyQ+owrj00Uof/HMiB3I5HsoasEXQ
         yuNbQLi8Mcr8G82C4uMKhk8fmi3Z/FMkCefleRGqNzX64MIbrZ4sk1XtxOmdopFr/tVm
         Klwwg7gSkmodakyHIO9M3NHeakm4n2AbgmnB+MCFzsrH9Vu5Xa/JY75hqVmxd5aLlhhI
         2DIXz1y2lb1N2Q0K3kWcxnzeO73yrd+vfgxsLTM0B9IqBoeT52ri+L9HmUIksURqYL9B
         DZYgprY7NpIgTWOFDZyopCZtfhIiVjSQJHQ6CrwxT5nUrE18hQFWqVU4gTpx2zVtD/V0
         kUzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBVxFKeJQIUgwIDfO6gtihSe/9O76bYuZLBU1k7IK6tAP6ettl9nlyP7rM9ZMoG/bOTAbn1vQ9Xz27wnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzViOh/nusctNZLBm7PBxpP0Ey3q5a209ktIA4262CItc/aQpwr
	9P7kttIozma1YXLMZsP2JJOWqyObt/oM37AH3NhNWQx7AdYnb1FcaUeA
X-Gm-Gg: ASbGncu/CrNuJRd5gUj3coO5Tqyo9ozj+2wFkxHy+uTwzqWoqEDvW5dva3ghL6hH0D5
	rhB4gHGP/Bh7zekEfEYNQhg2iPtlxLHlDNZuUem78hhC5zzmaXbz3LY4HVkAI7Vifh9DwmlGafI
	vlwtii45rn5iBzp3znSC7QmRoAU2hPplcYhw7wxku5DkAXdd1lnvBK8qYidYGyTsva9gveRj9Ed
	IIb0ILgtNGsh69Mc5+HyY/bx1G54+AOMFG3nKjyMBQw6GVB7LD2IAKKt5jKOP8RAZh2d7YY33Fq
	sNwo0oNNE5K9fze9GQUccOdsxoyzqd20QEpcTuuEVumN5N+Nn2JWUiOX65JiT/E7pgD9ouLhvG7
	bHNrR0lleDTF238dghqT3qsrRscIacU8D7N8aHTvN9QFK3rnxoVzAcn1IDqpppUKwJPmq
X-Google-Smtp-Source: AGHT+IGrw5WjnkHFl8FT4pPAuJqjzVUuVNOVKVnaUJHLbVr1wlbjuCd2icribCshUIxZPAy3fsFyKg==
X-Received: by 2002:a17:903:1a2b:b0:268:5892:6a2e with SMTP id d9443c01a7336-290272ff539mr193038375ad.56.1760172748788;
        Sat, 11 Oct 2025 01:52:28 -0700 (PDT)
Received: from Black-Pearl.localdomain ([157.50.164.155])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29034f95bd3sm79050495ad.119.2025.10.11.01.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 01:52:28 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Sat, 11 Oct 2025 08:52:07 +0000
Subject: [PATCH v2] dt-bindings: mmc: ti,da830-mmc: convert to DT schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-davinci-mmc-v2-1-355da3e25123@gmail.com>
X-B4-Tracking: v=1; b=H4sIALYa6mgC/23Myw7CIBCF4VdpZi2GcomXle9husBhbCcRMGCIp
 uHdxa5d/ic53wqFMlOB87BCpsqFU+yhdgPg4uJMgn1vUFJZaZUW3lWOyCIEFHiQxhiJ2nsJ/fH
 MdOf3pl2n3guXV8qfDa/jb/3v1FGMAolu/qit8ie8zMHxY48pwNRa+wKgU4mupgAAAA==
X-Change-ID: 20250523-davinci-mmc-c704440c3dd0
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.14.2

Convert TI Highspeed MMC host controller binding to YAML format. Define
'clocks' and 'interrupts' properties to resolve errors identified by
'dt_check' and 'dtb_check'.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
Changes in v2:
- Modified the commit message.
- Removed 'interrupts' from required properties following the old binding.
- Changed the maintainer for the binding to "Conor Dooley".
- Link to v1: https://lore.kernel.org/r/20250523-davinci-mmc-v1-1-ceebd8352d9c@gmail.com
---
 .../devicetree/bindings/mmc/davinci_mmc.txt        | 32 ------------
 .../devicetree/bindings/mmc/ti,da830-mmc.yaml      | 61 ++++++++++++++++++++++
 2 files changed, 61 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/davinci_mmc.txt b/Documentation/devicetree/bindings/mmc/davinci_mmc.txt
deleted file mode 100644
index 516fb0143d4c21d1c8e44a8846d55ea5458d7b74..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/mmc/davinci_mmc.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-* TI Highspeed MMC host controller for DaVinci
-
-The Highspeed MMC Host Controller on TI DaVinci family
-provides an interface for MMC, SD and SDIO types of memory cards.
-
-This file documents the properties used by the davinci_mmc driver.
-
-Required properties:
-- compatible:
- Should be "ti,da830-mmc": for da830, da850, dm365
- Should be "ti,dm355-mmc": for dm355, dm644x
-
-Optional properties:
-- bus-width: Number of data lines, can be <1>, <4>, or <8>, default <1>
-- max-frequency: Maximum operating clock frequency, default 25MHz.
-- dmas: List of DMA specifiers with the controller specific format
-	as described in the generic DMA client binding. A tx and rx
-	specifier is required.
-- dma-names: RX and TX  DMA request names. These strings correspond
-	1:1 with the DMA specifiers listed in dmas.
-
-Example:
-mmc0: mmc@1c40000 {
-	compatible = "ti,da830-mmc",
-	reg = <0x40000 0x1000>;
-	interrupts = <16>;
-	bus-width = <4>;
-	max-frequency = <50000000>;
-	dmas = <&edma 16
-		&edma 17>;
-	dma-names = "rx", "tx";
-};
diff --git a/Documentation/devicetree/bindings/mmc/ti,da830-mmc.yaml b/Documentation/devicetree/bindings/mmc/ti,da830-mmc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..1a97c3e447fd10f14bfe0af9e22f9479304f0f26
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/ti,da830-mmc.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/ti,da830-mmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI Highspeed MMC host controller for DaVinci
+
+description:
+  The Highspeed MMC Host Controller on TI DaVinci family
+  provides an interface for MMC, SD and SDIO types of memory cards.
+
+allOf:
+  - $ref: mmc-controller.yaml
+
+maintainers:
+  - Conor Dooley <conor+dt@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - ti,da830-mmc
+      - ti,dm355-mmc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 2
+
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    mmc@1c40000 {
+        compatible = "ti,da830-mmc";
+        reg = <0x40000 0x1000>;
+        interrupts = <16 IRQ_TYPE_LEVEL_HIGH>,
+                     <17 IRQ_TYPE_LEVEL_HIGH>;
+        bus-width = <4>;
+        max-frequency = <50000000>;
+        dmas = <&edma 16>, <&edma 17>;
+        dma-names = "rx", "tx";
+    };
+...

---
base-commit: 7bac2c97af4078d7a627500c9bcdd5b033f97718
change-id: 20250523-davinci-mmc-c704440c3dd0

Best regards,
-- 
Charan Pedumuru <charan.pedumuru@gmail.com>



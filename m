Return-Path: <linux-kernel+bounces-872173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED562C0F76A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618E83AC820
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47B7314A9E;
	Mon, 27 Oct 2025 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hx22Y6CI"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF87313E2A
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583771; cv=none; b=BhlzEwb/kcMwcv0+oKSVcEfsIa/+Nq3iG0VlEh5eC1YqhH0XoupT6bypdibJYjpziW4VXGhCLHb7ZxGOO4E3DmB/4J3WCIahAYPeOShoC7jbbZSFl8+p0s2lxBNMLXjqo3DfETR9TnGUmjCdZ99VR5xyNHBKtwpTsYuHdd5hCW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583771; c=relaxed/simple;
	bh=TWUcnMhGYjqpSEACT1hY8gU5ZXrwBEJkbZ/hFSk485A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XW9SoVa41qNdAAVEha/Ypgt5/efgGggOvPPgKL+Re9ppWoiPrLyzzhrp9dXXAu7iUN9xceI9B6dJzdNvMbjXg+LASHH6TOge89tJoTskZuYJVZB0XpQN67rH56g5MikQeermxe0bNC7MUn7H8GTAstqNaFYtd9EH0XnrxAeh5Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hx22Y6CI; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b6cdba2663dso3511624a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761583769; x=1762188569; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=geguZxaeJiqKqJQ0kK8UQgUfhxCEenMLMdjKppCx4hc=;
        b=hx22Y6CI/zP/jF+Xi3eElk/Yz7VC5/ug/78dKwna2BwOd2ohPH+vrL+8J8kaf5H61z
         GWSVoszeXs7Ig8SzkKDUo4de9dorZ1qxt88FcOchiwQBmroQgG+vr8R8F//SEHXZNNpm
         UJIi3SOBKMsoiNqLw+J3seyPQVO3A27cZItPW4lHmYvc1L58SAk8yT3BD439mkQMoILJ
         cPSUL1w7aLYQlg8R64r1Rvg5QqbUb9M+Y8bCKWwEolP1qJg5+GKCVWKU065jFbhwCJ0j
         lFLpuTHoF/ZJEN3gBiuG6qmdtXQIhybs3paDZZ+lNF9ILR4lpq0EAuJZGDwpXrqYY8I9
         jP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761583769; x=1762188569;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=geguZxaeJiqKqJQ0kK8UQgUfhxCEenMLMdjKppCx4hc=;
        b=BMWoA3JeCpGj7e8p2yDurX5OwFbdMqGyPo2/Gw6fsW1Fik2POTpgykW/p8/fS6jxJv
         9jkYmdxuONvZlodO9xk30ReFsCIOih42QDpSXWj25f6ZPvmnehXJB25yOrkK7qTNRx20
         z6D1LHqGwu0tOl3LzvV4s7jW/IaPA2GmeMxM8ItL5yMR46Ix84OmYjMYzWtNe11GbPIK
         QP45yIheuHTt3w+FjHKo/RTeDnLjHFDtt10MCTYgoSrCKnQl38St7XoT1Gwr94nRJVq/
         8QDo1KFsXMNcdodt26IG4jxcoPjPGt2B9LFSrUYZUGmUMHhiqL277g1G3LAmPUL18GVa
         uCPg==
X-Forwarded-Encrypted: i=1; AJvYcCX7EcdDYEkpGloF5K89d3B5hL6iTxnXPi3XpaU5B2yMsFX2fW9Z9VO9BegIC5LWcDKjO8jpe9cezRYor1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ+qcJcD1dtalrHskbLBPw0Ho98/mGpl7wblfq9zTg3IJmMA1Q
	5FXy9YOw5D/lAe4c7FXjkojjkgicRW/STD8/W4fBSItGOowhRESSKDQ8
X-Gm-Gg: ASbGncs9S2Ulh3Vil8fa7Df5MyrNdg+tywBp4FlMmaJ8/4+6UGgXy3Hi1yBbDn2xE3w
	dajfqUcbU6DDQwvSZg+KzgKMqYezM/wHwDHrrJ4LTOFZDk03K6BzUq5oiPPIJIidrPVqOnvuRJe
	+2arjLLWzkxZLDMefLMUQGecWNSx/Meq30XoOoXzPv0iCeUmCPzxifrFcSO6ahzMtR9/BBMSqhM
	Q2vZF7XD9Wwk2/c3/u4h2moRYTgJ9qMoD/SoLUJpgt+6Rovl5JYSKqRzFZdHk3qxGxq5I/C/bU0
	c9Yo1i+ThTJN2CUpjJGs8S14aAmsurab87+/VDP0eGVJSxJW6Jr0YnxnyHIxQST6+Rt4vUrXc6R
	QJPEGC5KWfJ1hrE8sfpsJWlyVSav5FF8rJqyvtWzjgLfFkSRih6ZQ91FmYO589xbXLtBflRE+6X
	/5OwjhK/TqBYAvFMhozxq4
X-Google-Smtp-Source: AGHT+IFsZhMXjDA3rdE7firYijUNXcnLWPPnTnb2rv5dx73e9it+zwX4W3UIHnIxK9VNAzx0q7dU+A==
X-Received: by 2002:a17:902:cecb:b0:26d:72f8:8d0a with SMTP id d9443c01a7336-294cb368bd0mr6638925ad.12.1761583768299;
        Mon, 27 Oct 2025 09:49:28 -0700 (PDT)
Received: from Black-Pearl.localdomain ([27.7.191.116])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498cf358fsm86581925ad.20.2025.10.27.09.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 09:49:27 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Mon, 27 Oct 2025 16:46:16 +0000
Subject: [PATCH v2] dt-bindings: mmc: socionext,milbeaut-m10v-sdhci-3.0:
 convert to DT schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-milbeaut-v2-1-9e1954ff7708@gmail.com>
X-B4-Tracking: v=1; b=H4sIANeh/2gC/0XMywqDMBCF4VeRWTclMxqFrvoe4iKNEx3wUhIbW
 sR3b+qmy/9w+HaIHIQj3IodAieJsi456FKAG+0ysJI+N5Amow1Vapbpwfa1KeM01U3emRzk+zO
 wl/dJtV3uUeK2hs8pJ/ytJ4Kayj+SUKEqufK+bhC17e/DbGW6unWG7jiOLz8RU8qgAAAA
X-Change-ID: 20250524-milbeaut-5c0267202e2c
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Taichi Sugaya <sugaya.taichi@socionext.com>, 
 Takao Orito <orito.takao@socionext.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.14.3

Convert SOCIONEXT Milbeaut SDHCI controller binding to YAML format.
Add a new property "voltage-ranges" to resolve dt_check errors.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
Changes in v2:
- Change the description for the property "voltage-ranges".
- Link to v1: https://lore.kernel.org/r/20251023-milbeaut-v1-1-3e4ff67110ad@gmail.com
---
 .../devicetree/bindings/mmc/sdhci-milbeaut.txt     | 30 --------
 .../mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml     | 79 ++++++++++++++++++++++
 2 files changed, 79 insertions(+), 30 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt b/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
deleted file mode 100644
index 627ee89c125b..000000000000
--- a/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-* SOCIONEXT Milbeaut SDHCI controller
-
-This file documents differences between the core properties in mmc.txt
-and the properties used by the sdhci_milbeaut driver.
-
-Required properties:
-- compatible: "socionext,milbeaut-m10v-sdhci-3.0"
-- clocks: Must contain an entry for each entry in clock-names. It is a
-  list of phandles and clock-specifier pairs.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names: Should contain the following two entries:
-	"iface" - clock used for sdhci interface
-	"core"  - core clock for sdhci controller
-
-Optional properties:
-- fujitsu,cmd-dat-delay-select: boolean property indicating that this host
-  requires the CMD_DAT_DELAY control to be enabled.
-
-Example:
-	sdhci3: mmc@1b010000 {
-		compatible = "socionext,milbeaut-m10v-sdhci-3.0";
-		reg = <0x1b010000 0x10000>;
-		interrupts = <0 265 0x4>;
-		voltage-ranges = <3300 3300>;
-		bus-width = <4>;
-		clocks = <&clk 7>, <&ahb_clk>;
-		clock-names = "core", "iface";
-		cap-sdio-irq;
-		fujitsu,cmd-dat-delay-select;
-	};
diff --git a/Documentation/devicetree/bindings/mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml b/Documentation/devicetree/bindings/mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml
new file mode 100644
index 000000000000..2ba53626a959
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SOCIONEXT Milbeaut SDHCI controller
+
+maintainers:
+  - Taichi Sugaya <sugaya.taichi@socionext.com>
+  - Takao Orito <orito.takao@socionext.com>
+
+description:
+  The SOCIONEXT Milbeaut SDHCI controller is a specialized SD Host
+  Controller found in some of Socionext's Milbeaut image processing SoCs.
+  It features a dedicated "bridge controller." This bridge controller
+  implements special functions like reset control, clock management for
+  various SDR modes (SDR12, SDR25, SDR50) and physical pin property settings.
+
+allOf:
+  - $ref: sdhci-common.yaml#
+
+properties:
+  compatible:
+    const: socionext,milbeaut-m10v-sdhci-3.0
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: core
+      - const: iface
+
+  fujitsu,cmd-dat-delay-select:
+    description:
+      Its presence indicates that the controller requires a specific command
+      and data line delay selection mechanism for proper operation, particularly
+      when dealing with high-speed SD/eMMC modes.
+    type: boolean
+
+  voltage-ranges:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    items:
+      items:
+        - description: minimum slot voltage (mV).
+        - description: maximum slot voltage (mV).
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    mmc@1b010000 {
+        compatible = "socionext,milbeaut-m10v-sdhci-3.0";
+        reg = <0x1b010000 0x10000>;
+        interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+        voltage-ranges = <3300 3300>;
+        bus-width = <4>;
+        clocks = <&clk 7>, <&ahb_clk>;
+        clock-names = "core", "iface";
+        cap-sdio-irq;
+        fujitsu,cmd-dat-delay-select;
+    };
+...

---
base-commit: 7bac2c97af4078d7a627500c9bcdd5b033f97718
change-id: 20250524-milbeaut-5c0267202e2c

Best regards,
-- 
Charan Pedumuru <charan.pedumuru@gmail.com>



Return-Path: <linux-kernel+bounces-867488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8F3C02C4E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A81D18957E0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D9034A3B7;
	Thu, 23 Oct 2025 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SC+bKV1+"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677AC30C600
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761241286; cv=none; b=n7lhJD4Ol7lOOm3tuWNOAA91D/1FMAXlAiwti7fGYR5TfHTGEm5NCmgmUPqO+cMU65QoAu1gLC0Z4i2EpiKoPVdYy0QdW3WzpVeuXBhUzPi8rY7jWJu0UonTxn/qVIhoqxa3JkfdRAOR/WDkHqy5/KOfbBt7bjAvbHilKmAqcVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761241286; c=relaxed/simple;
	bh=brq1Q6J/cHb72gyYM3jxDa4jInBHAcJnQ/osdj5Bc0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pPQw/EXLM8l0Zk0ubJ80QQfQIRGNoUUUeGw5B8gdyKlmhC3q+sMwvMOZgquGjjWvnIxcJgNT8iwqJnfDugGH8qrBiP7Gsyb84trizqPUWuP54PkPiIgJ9LUyp5DO5rzs/eu5Ut2r02oDb2qxZTfs/mZ5GAj/+OSUg2q5ISaiiFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SC+bKV1+; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6cf1a95274so853978a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761241285; x=1761846085; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+RlscW0fJPcI4w1cVrsdBX2mHMbYD0iZ1loDXnboKus=;
        b=SC+bKV1+3Nb2uPW+ss7ZfMAd23SDd9Swd2WfIHGku13Yn04sANHwSzXRLH6Gy8ACTI
         fr+aaL8qKQ45qbn42nAr6VUQyvE3eb/KvUBJaeYx84utCnxEthTU6hTSFgZGjByZzP+B
         mhnK0BqL2T+q8tuUQnFXw6/ifFqkulZzQvCeDdkwHyA5b+4aTYEBEGWYHFBcaotp4b35
         3YdVnorLuZKWcpLAyYc/ijcTzjp6UJu3QfAxnZ9ITXQFxF/tb1X1WE1mpCb7xNAoRcMu
         WUWJ83jWkFVOJE2A8XyHVlLRJxdjrWQ4oMXWNZ5YYw0tVPSkw2FSmCV9vjVxQq/QWoby
         oOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761241285; x=1761846085;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RlscW0fJPcI4w1cVrsdBX2mHMbYD0iZ1loDXnboKus=;
        b=OQ6hqt+ru2ecfZOzZu0I+iD3Z8GXowi2da9nMdUb4xrvxGuxtjSv0wTF2BoMWgPGh1
         VJVDl7d3kwf3zFIqTnUH7cHYyFrPKDmExBbk1lFuq519va73+rOqtnon9KpD6rZte4NZ
         scfbLKFwR5ptLg2WF8FLeXp99AIqG4iZoMSLfgYpw+XAPTl+ql9Moih8ZDuEOkc9fFp+
         J8C+z5Sc0Qmeg5P9Teig8WdbCZ9GYQ2tpZU02ua8Z3xmjRU+uDhlTeSoK7bfIC6Bm+hk
         nEaRHxVKpNR95VUQYWGJbE1B+PJmXdkDXcY1fcKKwzWCMBQGGPo19UcPQ9VThA6/NBa1
         YLIA==
X-Forwarded-Encrypted: i=1; AJvYcCWvOWzJAnEyQ/oTrxp6KGdi3KkMIIxrvWzsBJL12CMi8y5dgReBjcn5O9lyHyKl2Izy9Y7LFd/g80w5IJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0gcipukGVox4g95RIuDvE+PMvYOeVoNKGp6KXV1yjPT+eY0pj
	Q7Xc9Ja1nqGS3ht45VOAaEQDRN7UzVSzqV9NH3mLAtcF6EvBv259UjG0
X-Gm-Gg: ASbGncuv/3PvbLEWTo9hHveJYvTGiDbeLZh4L8RpUaz+V7T6WsxcuSv1yGkD/6Y232a
	IWaOfPl+JOKqIuocDWs9ZTZ7Ko1V5xeYiYl5SlDob0bokXxF1KCI3JSbDzsCaovsrIrwJc82Dru
	j4XNquom8uDU/SenYBI6HIoy7LiAO7fAuKgJBn87tMmkzpq6BXDZcCIw8m/WD1zCZKEFEvPpZSW
	Wsn1qHYSOfVeI7Zc7XjSWD8v+8Msk1SICUaY9L6z4hFFADmawJjmWkS1bWCqQPr1hJCfFYzCJMB
	Oz6dgC2mbEyGlZwFYcSlDtZcIxqNMRaEQV68J19V0zOEa2XeJh1tMwvvArGYKFvOo5uz24wbdis
	FbsvZcgHwHNQQLIzfCOtoE1j407t0ERCIZYhwbXVLhv5B7SrnWRxeVb5TjIZIh3wYDrKwasXzZQ
	QDjdypQnbKjeFr8ZQmFs4lHUtuPLMLOBc=
X-Google-Smtp-Source: AGHT+IFfxGetZxOYzBkLMbSAX9vob0YlVWtcztLEw1yU6xI6aPUDPEqjnKvkoiTPdJH966r2PqACrQ==
X-Received: by 2002:a17:903:2443:b0:24c:cca1:7cfc with SMTP id d9443c01a7336-290cb947830mr310655975ad.59.1761241284484;
        Thu, 23 Oct 2025 10:41:24 -0700 (PDT)
Received: from Black-Pearl.localdomain ([27.7.191.116])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2946e21fbbdsm29202205ad.99.2025.10.23.10.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 10:41:24 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Thu, 23 Oct 2025 17:37:36 +0000
Subject: [PATCH] dt-bindings: mmc: socionext,milbeaut-m10v-sdhci-3.0:
 convert to DT schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-milbeaut-v1-1-3e4ff67110ad@gmail.com>
X-B4-Tracking: v=1; b=H4sIAN9n+mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDUyMT3dzMnKTUxNISXdNkAyMzc6B4qlGyElB5QVFqWmYF2Kjo2NpaADb
 XLoxaAAAA
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
 .../devicetree/bindings/mmc/sdhci-milbeaut.txt     | 30 ---------
 .../mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml     | 78 ++++++++++++++++++++++
 2 files changed, 78 insertions(+), 30 deletions(-)

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
index 000000000000..6b67bef30347
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml
@@ -0,0 +1,78 @@
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
+    description:
+      Two cells are required, first cell specifies minimum slot voltage (mV),
+      second cell specifies maximum slot voltage (mV).
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



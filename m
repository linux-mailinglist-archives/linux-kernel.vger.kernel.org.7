Return-Path: <linux-kernel+bounces-858654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D75BEB5A7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 21:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A60F58610D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847BC31DD9B;
	Fri, 17 Oct 2025 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="XaqC+Gct"
Received: from mail-il1-f195.google.com (mail-il1-f195.google.com [209.85.166.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3113E33F8C2
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 19:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760728069; cv=none; b=ABrYlfM8ZyU8nC3itEfW2V4nQ/+GKS3XfSLTSgv/0kbYooTmFbBccW4m2IrLpZAgUxd81SWmIDN9fnan/1m87GNNZG2+aoQVre9DLiDv/C38VoHb09ApsFSAjqlx4xA6L0ZGMfYOkNHRJlOBJhkypLOUKkQfV0obBlVJqn7Y+28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760728069; c=relaxed/simple;
	bh=7WrOPVM0gt+b/Q/c9vY/ADstDCH0ZLchyGhM1A9P4gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRaNm5Wjtw5WhukcIzDAWG8n97bCap7QJ+DcrpjPOMmApTaRJlFFtmfbVD6hZpQuQjXwjWbAQgFH4/3MvlSUxjSfqpf70P8Ktkg217KbbN+ZB/TrmMS4GB6w49UK3uSmnyKBBY2/0nRWU8ZIbjFt9tWvonDxXbMtorQloVd17GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=XaqC+Gct; arc=none smtp.client-ip=209.85.166.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f195.google.com with SMTP id e9e14a558f8ab-430d098121cso1135455ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760728066; x=1761332866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnj3ndeUMae3NyNArAGupVHJsLP7DcySgmrwpRjKSkM=;
        b=XaqC+GctWKHYCQ69QE3CSwqNingyyvxRnRKsuBSNjpwZ1/hXMUEQI391D3b+ozZc3R
         KjHkZXReEq5hdqHSGNAezlzaJkPe21TozjrjMNZuEsOfl2AXs3my4MgBCnuSbXqb6P+S
         V+/66dYUCXBoWX2ZHxaTl1RNGmPmg3ooFuzo6Hjyl801XK4u5ZWZv0WzLvRSWY38IxB/
         +Lz9OTTrqDBX8e5e1sd2oeVg718Sho7fjMLps3odM3U1GoeGP62BcHevRbU6aTEv6xMu
         AkcpsKYciYb1MaM1xCNXodd9U095CSzgyO6JSmSYGJgjVz7iI2c25ks8NxJ89m39ezgl
         mpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760728066; x=1761332866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnj3ndeUMae3NyNArAGupVHJsLP7DcySgmrwpRjKSkM=;
        b=Oi81BrBHAou6AA0EBM20GP4Jl23cwZ/ktd8ifMvL4LZ05YzWB4HG1Tx8QM0HJFafoP
         ZzjPxTUt3fnao7DNqI/MSQJFbES1IVAxDifkE/+9Ju38rI9t48nT5C57yRyK20OsiV4N
         c+mB0YgDxitnV8LZfJO7DoZYlKiuwmWU27IJE/CrtrPLnZYtACYDLw5Si94OewZbNOb9
         5rKngNwQJeAvADs7XIJfKhvjnOJB+daBqbqDvDCQOhjMCP8QCTQkeOFpF4c3F8i2tQiK
         Ac8KJLYOiYi+5lCacoofYxNjhvDS4HB23fFPosDSpbvUdxcAePS9dNrS7bPv0hn4hZwk
         +0tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhu2ZSWjaErdHuaTiacQ+rNZsgxaUW2ub8qsW0THOgLRk48EV5xl0FtaHXfvWcxtUEtpYMhECTSktuZSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YylIPRzwJgmAGHghMfa4HHp81DgBLMFXvj7sAMnjLQ3g3F10Gd3
	kRgcwTZUZH6IqRk2P60BaMzhrM7evzcrTpf3ds5Xh3OD1+cWam3C3nypg1ZKRRgFO5s5gHVMPlN
	duLb1mLOaHg==
X-Gm-Gg: ASbGncugKakm13rXxRfiTBQG50AEtT3i1RDXCTY3a0+v9Pvtujna2BhCIhO4EKfb86X
	0S+0ZdBsPNSd8JoMpIzwO4er0t/QGeCZd4O163vck2i5DTCuhKhnE3gafVzPRsR03mJgtCD4Ezh
	gkDwigdd3z6LIqFy67Y74n0u1j9IbipwqZawGBwu+ikTb76rauCWoxXlcNmAfw5zrlkjUjpzACe
	Q60e0YEMOI5FtA00cuatETJrWmRwURb7miu1grSqhL9vosos/ukjUrCZ8xqwRhXsyEPYy8pt0oL
	xU/9gKQPMUpqnYjLlR/vMCe9m/Tru32Xv2t6iaJO/FCpQV145UtOgeUWVogvRsBbnotDFd37rUl
	z0NII1u4IPvoJPJkg2jePoR29FlLmqzfN9CBKP6V4SkH6tmetqw1wO1LqXw6lCQzE8X2IuS9zdf
	LSvM4qKAU9GTg4mkbE96Z4/N8z57esmW/uoHgKw9mByxYDt2UMKAug2A==
X-Google-Smtp-Source: AGHT+IHytZYPq3sSfMjOZfFYHMcFE2wOrzrpGR8N8DWI8WbrnQAptaEbQ6cEghvzh0pSWjDXYscmQg==
X-Received: by 2002:a92:ca4d:0:b0:430:b05a:ecc3 with SMTP id e9e14a558f8ab-430c525f528mr67642975ab.9.1760728065914;
        Fri, 17 Oct 2025 12:07:45 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9768b98sm153462173.46.2025.10.17.12.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 12:07:45 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org
Cc: dlan@gentoo.org,
	guodong@riscstar.com,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/7] dt-bindings: phy: spacemit: add SpacemiT PCIe/combo PHY
Date: Fri, 17 Oct 2025 14:07:33 -0500
Message-ID: <20251017190740.306780-2-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251017190740.306780-1-elder@riscstar.com>
References: <20251017190740.306780-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Device Tree binding for the PCIe/USB 3.0 combo PHY found in
the SpacemiT K1 SoC.  This is one of three PCIe PHYs, and is unusual
in that only the combo PHY can perform a calibration step needed to
determine settings used by the other two PCIe PHYs.

Calibration must be done with the combo PHY in PCIe mode, and to allow
this to occur independent of the eventual use for the PHY (PCIe or USB)
some PCIe-related properties must be supplied: clocks; resets; and a
syscon phandle.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
v3: - Added Reviewed-by from Rob Herring
    - The "phy" reset is listed first

 .../bindings/phy/spacemit,k1-combo-phy.yaml   | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml b/Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml
new file mode 100644
index 0000000000000..b59476cd78b57
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/spacemit,k1-combo-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT K1 PCIe/USB3 Combo PHY
+
+maintainers:
+  - Alex Elder <elder@riscstar.com>
+
+description: >
+  Of the three PHYs on the SpacemiT K1 SoC capable of being used for
+  PCIe, one is a combo PHY that can also be configured for use by a
+  USB 3 controller.  Using PCIe or USB 3 is a board design decision.
+
+  The combo PHY is also the only PCIe PHY that is able to determine
+  PCIe calibration values to use, and this must be determined before
+  the other two PCIe PHYs can be used.  This calibration must be
+  performed with the combo PHY in PCIe mode, and is this is done
+  when the combo PHY is probed.
+
+  The combo PHY uses an external oscillator as a reference clock.
+  During normal operation, the PCIe or USB port driver is responsible
+  for ensuring all other clocks needed by a PHY are enabled, and all
+  resets affecting the PHY are deasserted.  However, for the combo
+  PHY to perform calibration independent of whether it's later used
+  for PCIe or USB, all PCIe mode clocks and resets must be defined.
+
+properties:
+  compatible:
+    const: spacemit,k1-combo-phy
+
+  reg:
+    items:
+      - description: PHY control registers
+
+  clocks:
+    items:
+      - description: External oscillator used by the PHY PLL
+      - description: DWC PCIe Data Bus Interface (DBI) clock
+      - description: DWC PCIe application AXI-bus Master interface clock
+      - description: DWC PCIe application AXI-bus slave interface clock
+
+  clock-names:
+    items:
+      - const: refclk
+      - const: dbi
+      - const: mstr
+      - const: slv
+
+  resets:
+    items:
+      - description: PHY reset; remains deasserted after initialization
+      - description: DWC PCIe Data Bus Interface (DBI) reset
+      - description: DWC PCIe application AXI-bus Master interface reset
+      - description: DWC PCIe application AXI-bus slave interface reset
+
+  reset-names:
+    items:
+      - const: phy
+      - const: dbi
+      - const: mstr
+      - const: slv
+
+  spacemit,apmu:
+    description:
+      A phandle that refers to the APMU system controller, whose
+      regmap is used in setting the mode
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  "#phy-cells":
+    const: 1
+    description:
+      The argument value (PHY_TYPE_PCIE or PHY_TYPE_USB3) determines
+      whether the PHY operates in PCIe or USB3 mode.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - spacemit,apmu
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/spacemit,k1-syscon.h>
+    phy@c0b10000 {
+        compatible = "spacemit,k1-combo-phy";
+        reg = <0xc0b10000 0x1000>;
+        clocks = <&vctcxo_24m>,
+                 <&syscon_apmu CLK_PCIE0_DBI>,
+                 <&syscon_apmu CLK_PCIE0_MASTER>,
+                 <&syscon_apmu CLK_PCIE0_SLAVE>;
+        clock-names = "refclk",
+                      "dbi",
+                      "mstr",
+                      "slv";
+        resets = <&syscon_apmu RESET_PCIE0_GLOBAL>,
+                 <&syscon_apmu RESET_PCIE0_DBI>,
+                 <&syscon_apmu RESET_PCIE0_MASTER>,
+                 <&syscon_apmu RESET_PCIE0_SLAVE>;
+        reset-names = "phy",
+                      "dbi",
+                      "mstr",
+                      "slv";
+        spacemit,apmu = <&syscon_apmu>;
+        #phy-cells = <1>;
+    };
-- 
2.48.1



Return-Path: <linux-kernel+bounces-767353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B64B25337
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BCD81B6877C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEE72C178D;
	Wed, 13 Aug 2025 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="U+axW42m"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4933EA8D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 18:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755110832; cv=none; b=rl2SpfTaQImSg6OPUkZ2aA+bAqSGGUp97JHvb5AwVI75LeSGz9/XlrhE1QPS9nOpCJBno9jTbDsRMHRoJDZLlmvXLhqUbNaIi7xmQetZOHE5B5cA3BKicbD5smNnxlPvDxxHxEsjIqiQcJQW8yosqOVFY8N4XWYHmNsv4/cPq0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755110832; c=relaxed/simple;
	bh=6NMcmlO0IFaTOKLW3+FNqZIRth4ITeWpsFOHQnAzm1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K68tDx6hOTElgqf8Wp0hEhUmMVXS4+MQuotJoec2JTeM9PRSeV4qgvAI2kKZ57GjnVN+QAX9ugWPVS+dtIYLy1opIpD/Yf1JweFI6Nd3PMGFtsF+q78U4TNThRVVaQDZJUcU0weMfTxvfW0q2NdL3aMn9gCU0j50NQDxCW/rvpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=U+axW42m; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-61bc559482eso663027eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755110829; x=1755715629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lg6P2z9viwKwM9ymHrPPMi8WbmkY0zEdqbuXH3DZMho=;
        b=U+axW42muq6ppNsH9iYMCONjjGdinCPDUpmhDGwRkm3dou7G4FO+e4XMB2PLcUECod
         /0aPc8VtMLQ0gmJ1fdVHTAKDoAdJYBsMgZH6Sx/lpuysKB8+VYipPscD0i/5XEeJ3opA
         Edd23hhwkNeudvTBxmkvT/eJuMM8M7P+kfSEc5aKEqhvQyv9t5p2FNnQmtfVlk1k1PXP
         12gWN1diOm7beM4WPNhQy6fTgkTQCArRkYv4JiewjCd/n3nYZJtD6jEZR0pwnt/nWHFk
         Cxg6SIJ84TVHBLj8TfRSjBE48OY5IG1MD7lIjoKKzGGnt0jmu56hdC+xvehHa0bIODwi
         rIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755110829; x=1755715629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lg6P2z9viwKwM9ymHrPPMi8WbmkY0zEdqbuXH3DZMho=;
        b=vK6sCEMjNa3kvyGighTqAY+O3M2efiNu0QwGt1f7bUqHjQZ8E37kcyeHb99033Zm1g
         OiMH9Ng7nVgPTe737YilcVeWRrJpyXHMV+rmTsQNMg6I0Ob9LofWnA3pN3MMA4BRLO6O
         bYtDbX6na3fUHH2Ge+roizAVr3Tun8MBCwtfoE+Yi1sDWtua81wd8hvKcAwTv6Fbic7p
         zC5FF7KPzEAd36bbnCXtvAAwEkYR9m9R7kEZ6p3mMgA4CAiCLj56lZR/jjd2P/A0eALZ
         F1ZbTZI0cLj2PHWNqz0PEg6zdD+hWIByE0sI0UaHr8MXZTliOJSgcpfxwLmxzUG3m1KE
         ULOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkMXR8b3+5TWVEc1frP+/B1HktS6pVULcPy4C92RF02JlR8JQOGOHJ46MHQ/LVUEo3H7PlJj5UzlxPetY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTQR3cqOE8uvJVHIqbBVhBbijCXmulsHGVDoYf7nsSd12UiQFk
	HVLGQ1HMlyQWGrb5dGZi9uq7o/IUO2LaTHsyg6o85CBtwV4b589G2lqixUnDUkipDHs=
X-Gm-Gg: ASbGncs4KqfhnjOdYzwroZbi9sxwgZr+CL7bzTWTa0NH5wevcDKjBtzOpLnHVpEmuBt
	e/nrk420V4s8I3QMuZp7sDunVLgjzWYMyWr8YmYvsTZeXlhshO8GZ9dD8jADheiel0jvz3hkCJV
	Qd0QjLZx4uLsJerrPZQi3FOlBX8ihMT4X8wBgozGrTaGl0KuQQXmTaRc32BPSkCpzM1vkFY//CE
	VH3ciKz87CEL7z8CXW5T9/OA9tsLpatfHlC3QV3SubXcf9zzjGj5mGHOomPLRUfMoL2PkVksUVd
	V3d8aZxarrxuodJv07am+ZUd73OTceIQpE7lszn+ZVqERAnRZQWWeD21nsBMhbMo3vEuj3xQeBd
	M//y3o1vjG9kMO9kgsCnRNZKKBfpjilsn9J0HFUJzo9uYjPqY7xavc1sHtQV1LphtQA==
X-Google-Smtp-Source: AGHT+IGaEGAoO/Lp4qxdDE3uhCbVJtjLD2sBuNn3WDyAJ+ppizjeTU30ZG6CnqngpzRN2PHp1/gABg==
X-Received: by 2002:a05:6808:1446:b0:434:4f6:dd35 with SMTP id 5614622812f47-435dea6f7b7mr401755b6e.14.1755110828813;
        Wed, 13 Aug 2025 11:47:08 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae9bd89d7sm3933104173.59.2025.08.13.11.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 11:47:08 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	vkoul@kernel.org,
	kishon@kernel.org
Cc: dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	tglx@linutronix.de,
	johan+linaro@kernel.org,
	thippeswamy.havalige@amd.com,
	namcao@linutronix.de,
	mayank.rana@oss.qualcomm.com,
	shradha.t@samsung.com,
	inochiama@gmail.com,
	quic_schintav@quicinc.com,
	fan.ni@samsung.com,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pci@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings: phy: spacemit: add SpacemiT PCIe/combo PHY
Date: Wed, 13 Aug 2025 13:46:55 -0500
Message-ID: <20250813184701.2444372-2-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813184701.2444372-1-elder@riscstar.com>
References: <20250813184701.2444372-1-elder@riscstar.com>
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

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../bindings/phy/spacemit,k1-combo-phy.yaml   | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml b/Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml
new file mode 100644
index 0000000000000..ed78083a53231
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml
@@ -0,0 +1,110 @@
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
+description:
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
+  During normal operation, the PCIe or USB port driver is responsible
+  for ensuring all clocks needed by a PHY are enabled, and all resets
+  affecting the PHY are deasserted.  However, for the combo PHY to
+  perform calibration independent of whether it's later used for
+  PCIe or USB, all PCIe mode clocks and resets must be defined.
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
+      - description: DWC PCIe Data Bus Interface (DBI) clock
+      - description: DWC PCIe application AXI-bus Master interface clock
+      - description: DWC PCIe application AXI-bus Slave interface clock.
+
+  clock-names:
+    items:
+      - const: dbi
+      - const: mstr
+      - const: slv
+
+  resets:
+    items:
+      - description: DWC PCIe Data Bus Interface (DBI) reset
+      - description: DWC PCIe application AXI-bus Master interface reset
+      - description: DWC PCIe application AXI-bus Slave interface reset.
+      - description: Global reset; must be deasserted for PHY to function
+
+  reset-names:
+    items:
+      - const: dbi
+      - const: mstr
+      - const: slv
+      - const: global
+
+  spacemit,syscon-pmu:
+    description:
+      PHandle that refers to the APMU system controller, whose
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
+  - spacemit,syscon-pmu
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/spacemit,k1-syscon.h>
+    combo_phy: phy@c0b10000 {
+        compatible = "spacemit,k1-combo-phy";
+        reg = <0xc0b10000 0x1000>;
+        clocks = <&syscon_apmu CLK_PCIE0_DBI>,
+                 <&syscon_apmu CLK_PCIE0_MASTER>,
+                 <&syscon_apmu CLK_PCIE0_SLAVE>;
+        clock-names = "dbi",
+                      "mstr",
+                      "slv";
+        resets = <&syscon_apmu RESET_PCIE0_DBI>,
+                 <&syscon_apmu RESET_PCIE0_MASTER>,
+                 <&syscon_apmu RESET_PCIE0_SLAVE>,
+                 <&syscon_apmu RESET_PCIE0_GLOBAL>;
+        reset-names = "dbi",
+                      "mstr",
+                      "slv",
+                      "global";
+        spacemit,syscon-pmu = <&syscon_apmu>;
+        #phy-cells = <1>;
+        status = "disabled";
+    };
-- 
2.48.1



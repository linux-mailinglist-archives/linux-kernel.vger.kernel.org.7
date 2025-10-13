Return-Path: <linux-kernel+bounces-850915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA59BD4C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8806421D37
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819C73128D0;
	Mon, 13 Oct 2025 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="AiNHPnyM"
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com [209.85.166.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9274130FC35
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369735; cv=none; b=OhuiaAh2Fmyq99GLOYts19vei79tpwORcGykBjUvfS2ChFaxiPc/kt195ZYbGiloiUGWIVZhCIOsokn4Mg0w/wb83fjMQcqzejZ48ofqVJONLf5NdO2uUqY9BwOHjkOII3LQNrcM5SCU8aJUuKL5Tsmm9rFHbRH/0pBnqFZeCyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369735; c=relaxed/simple;
	bh=BpOZ7MH28/mxqVI8xL2FBxK2+2yB/1BVmp49i4x2sTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOBxMAoGwWCgk/tp8AaGOfcArod0x/CcOoCQ7nIslGYO6HEdISZ3Ne9M1wITTotVgcUBuFUqA9Z0WEvh4SNUP9jAixxF4TQXrFu3XnwGYhJfHF0q5jBLuk/40yHaxhmjnLcxIaqqXvFJalB7zLW47sMDMRGnvNjuo+E0oig3em0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=AiNHPnyM; arc=none smtp.client-ip=209.85.166.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f68.google.com with SMTP id ca18e2360f4ac-912d4135379so174756039f.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760369733; x=1760974533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoI6kMthZduzT8ZYZ3qN3cAQpgGG6MRRgU4QbQyijoo=;
        b=AiNHPnyMeR9AgSoj4A4nm0c/kJxdiAsH5EuejfXiTm596EnHvm9+tcdxMASb0VS07a
         WXks2/yY+ks1NkQ9spaDerqfJTgm7J89GTNdikXVWd7w2ap0X9aE4YWIVOw11esluXyX
         MH3GKhKDv1w9dWBRTN6KGN4MxLfzYA0mqRg0IlTIvZQjrKZKrlrtM9Lgn0sNQenNI+si
         gkzgxT+/vKaVp7KI9lQ6UxaIXvWrxoJG4/lLHiq/GHiTRztV2SLQxLRP5WI7yrOJfbNq
         Yz6ejToMa/PSwe38ToE06tbGXkdKO2vGFK35K8aYnoNiqWq0ayHvpChOpQ4GWI+2FLEP
         H7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760369733; x=1760974533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoI6kMthZduzT8ZYZ3qN3cAQpgGG6MRRgU4QbQyijoo=;
        b=hFe5QtBPPTRXs48RzLsE3ywO36wSV/Uk4PR/KspXLcjEutZAbrdQ9HH1TeFUwzxM36
         jj3b59XpxRDd7VK07jWwiiMkqCtzWk0acQjNAdIt2rjAXwCbCGc+q5nQAG7jLYUaeVHm
         wPWB3/TaJRgOjQBMbD3/g7eBPZXR0IDBWLbYsZLiV13q0xHDnc6fkNXhNEcCyl7pPLp0
         su4RguLtOG/mcH0OGjPJP3YXWuDYYa7LNzI1xwEVowxufdj8OraPyz9yIOsQ7reCbzsK
         MpdKiME9KPkJfaczeLbSOqTucOCGoWn5PCLzMkLsfnqv34C+Ngdk9DASRr1W1soz3br3
         UToQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaiWLJulhPwOPY32H9nJR6+a/I4P559sigiaB8tn8X1nuhldNJvSAUyVHIqyEsdknQacgt3uFBTrx3Orc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH8OKVK4JBjUkxy5Qti5OU5nj/9Bux/no8rC6Qt+NUQBgFFq7J
	snyv+dmgiEOaA75KkR1h1KvuIx+AgBjD3PnvraUrcHOIBxd7OKvjDEX9tHEHndeEKdc=
X-Gm-Gg: ASbGnctVM4cK2GmgcciBAZklZFxb58oRInS4vwEIT29mrsHY7wa4FjDs9BZM+OsYKJ/
	fGOyzquuJQ4jJi+gZuRupasEKUkndvK+MD6NWaTOXMYfhojT+Byf3XT0pKdqdNuwhTvIpnjk7cl
	Fn9MKCjyrUnjFoXNaocoMuAS3qTQ72G9UD9ze8jZDdjPfUPcVt5a+NmvmKqnxSFvO7L2dMWa0k0
	no4UdWC8lxzYV5WR5BV4Im3Z4UoJa4Pr64rlFPS5WcGT+/yNuvR0QDwQuT/5nPmU12y/+Xi1uIH
	Zc7uH2fg6MU67UbfuDRg9RUsQ6IaAaa6Fa0AYTt9/eYwwYyjDroj/5QGOfz/VS7xBHt+SagjYSv
	gSoUCG4BOiuSxgmMSkrFNg2Ye0ZHW6eOjJ9tjrniJoTJHuLk93xDpSZImsJkw9NUXOi7cQ8sGHp
	vK8rkzrxb4
X-Google-Smtp-Source: AGHT+IHNZy44agm51sCB0W97tyTX1zzziU2yBhjgQ7PRISv17V55+lCQRt+SG1OTrzoY5/d0w7/HeA==
X-Received: by 2002:a05:6602:492:b0:900:1fa2:5919 with SMTP id ca18e2360f4ac-93bd19882e8mr2625044139f.9.1760369732669;
        Mon, 13 Oct 2025 08:35:32 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f6c49b522sm3910266173.1.2025.10.13.08.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 08:35:32 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org
Cc: dlan@gentoo.org,
	guodong@riscstar.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	christian.bruel@foss.st.com,
	shradha.t@samsung.com,
	krishna.chundru@oss.qualcomm.com,
	qiang.yu@oss.qualcomm.com,
	namcao@linutronix.de,
	thippeswamy.havalige@amd.com,
	inochiama@gmail.com,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] dt-bindings: phy: spacemit: add SpacemiT PCIe/combo PHY
Date: Mon, 13 Oct 2025 10:35:18 -0500
Message-ID: <20251013153526.2276556-2-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251013153526.2276556-1-elder@riscstar.com>
References: <20251013153526.2276556-1-elder@riscstar.com>
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
v2: - Added '>' to the description, and reworded it a bit
    - Added an external oscillator clock, "refclk"
    - Renamed the "global" reset to be "phy"
    - Renamed a phandle property to be "spacemit,apmu"
    - Dropped the label and status property from the example

 .../bindings/phy/spacemit,k1-combo-phy.yaml   | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml b/Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml
new file mode 100644
index 0000000000000..6e2f401b0ac27
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
+      - description: DWC PCIe Data Bus Interface (DBI) reset
+      - description: DWC PCIe application AXI-bus Master interface reset
+      - description: DWC PCIe application AXI-bus slave interface reset
+      - description: PHY reset; must be deasserted for PHY to function
+
+  reset-names:
+    items:
+      - const: dbi
+      - const: mstr
+      - const: slv
+      - const: phy
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
+        resets = <&syscon_apmu RESET_PCIE0_DBI>,
+                 <&syscon_apmu RESET_PCIE0_MASTER>,
+                 <&syscon_apmu RESET_PCIE0_SLAVE>,
+                 <&syscon_apmu RESET_PCIE0_GLOBAL>;
+        reset-names = "dbi",
+                      "mstr",
+                      "slv",
+                      "phy";
+        spacemit,apmu = <&syscon_apmu>;
+        #phy-cells = <1>;
+    };
-- 
2.48.1



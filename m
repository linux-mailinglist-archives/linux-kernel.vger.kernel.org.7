Return-Path: <linux-kernel+bounces-879190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 406EBC227FF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6AC3B1D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AE0335552;
	Thu, 30 Oct 2025 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="soMjXCKA"
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com [209.85.166.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728C92BEC30
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 22:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761861790; cv=none; b=fQUqTmhBzobFTyEvho/G3R6HFWe7hP+IHiibCzQEx5m08UDN79AO41SwPRW0PLKZ4ffjr39WbRLwx3MNs3xN/QLNK7fXQOIG9kp9mah7BEzjEfmvIwzFDcv4Ss1vwbWqP1sz0hxX6Zsl+bIwuTtHddWrrWzd+Izsewg6u/r/J9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761861790; c=relaxed/simple;
	bh=AxniUDFPOEBa6Hk3PEu2qbO8OY5+iC7H8GeN4m2w6cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJld5F1joS7Gt6zWbOnGYkbZf0f8vsx6kVjFHBl7a6hKgWyChbVqN/LJNRHVmyEWJOgjKLn5WgXqMnJFDFaznEF0XSMtA/7S7BqHhf5jBVDOMew+W97Z7upSX5UYD96c5nhiCtQ5Zx+aZ4aSKh6Kl7+y9PcqXaRaLWWeNXqoXbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=soMjXCKA; arc=none smtp.client-ip=209.85.166.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f68.google.com with SMTP id ca18e2360f4ac-940d25b807bso65014839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761861786; x=1762466586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLTdLkz5qoTZ4VZft5RozafvHivyKGwCA/saZ7bnL/c=;
        b=soMjXCKA0AW8Lic0Z/Nt41XfQQfmZbYReDXWtouS4kClaOhxxuNDA2VPowC2HbisXf
         1iHT0c6bWhwBOaPOjWeei7/t2yfLoo1obFcHM9qouSzZGfWzxwNleq5xzGtwDgVDUKXN
         KYvJtBAYk1UpxTH/s3aS4HFRpeSoEm4d29Dub81ZbBCIIVdMAi1Bfg+806n8ndD0/728
         DH5r7Vm4f24RL7G6ukPw2PtIUjfFg2lKQlKkROVJgioXNvXd+hzDZiUevv8fQZiAEj70
         8qNDot22Cq1WTlu5vNwyziBuYNNULlJ89l3kaj5uDjeDRL0n2rMBgq4alHJvCkLwviSB
         y07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761861786; x=1762466586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLTdLkz5qoTZ4VZft5RozafvHivyKGwCA/saZ7bnL/c=;
        b=YQniNj29kmlvja6YISjHinjn2W4jULWEnkFYhGIHl6lo08aPXKQbdKW/+wZsEFuRdR
         BICakbppaLf+kqV5bofwPUKgU8Pn2GIKYX1ywsgKJqDPa90217FUKTJHp8PeoO5WgSDU
         hZmGEys2NtbddU0wzdbjeMMb5Inft+HXwmcjay0PzaW3VOByJvvHwq9R+hHqYOFi2B2K
         xOS9ijL2sFuNBeANRjxv5T/s9k1sYxxM94ypEcUprqc4QQPeJOe3ewHr8y181iVjkkPE
         jlAiemS7f/FfqB168XzMZEDZ6g4umRdu8Nt1W1j3DisREE9+KjHXNWNm90NFMiTyKQnk
         HWBg==
X-Forwarded-Encrypted: i=1; AJvYcCXF8QNtErFFB/SUby4/QjBy/OkvNvPN8LnXQrdUTxJl6XrjNDAicZUKTK3pUPXjTx7Zm6O3T5ZePbO65pg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2kc7w7d19eNSY5ECS4KjZFUW3159XPHbNq9KNyLhC7b4ZcIWD
	yZ41+jeAKxMAsevU3lOGpY31jUyVuEST6AGhmU+CsqX6SuMxIrIAzZnXpSlBbVZJgss=
X-Gm-Gg: ASbGnctKtf+5CrmDct29qlkzxBnHUZGGfwXd78EHfOWljeUcBzATTy7rK2TT8WjePhn
	dHzIglE6MLdWeOCzFU4ebKNBne69aNp7ldureg++lv+B9uYZddafJfCz3xLo4tbdaQJ2hQ5IM5d
	uGPY8I6D2HcYvPh/33YLtthn3Zrto3KCwY90zmYr+ru8afgzr2mNHzKhpfMxIGbNNpS5XCHK4WY
	39yK01gtddVqeNxEirVOeowmv6sDY2H/Dbfjd0OEwb72ab/E+HDSepk2kBsZ08I2deXRZw922Yv
	Gejo7CA9xmIKOfwJL2aEGujQoRoWeFHoBrCYIoE9C7YfTq2aK+l0nhL8zYk3Px2Mp8lFA4S7yuh
	TVB4J5c+b88pP0y4SgBuDGq1CzWXZGPP/oq+uhxueTwHQ6p7JBb3fWyPBW0l+u5oVFkqY8o6ZJO
	uwB4abvDfNb6AyjOG0sTS5mF0MPQJoDuaTcy7l10cCB/oU+YDbQtrUKw==
X-Google-Smtp-Source: AGHT+IERTz8/RfKm9GawJGpzZTmHeZoOg9wp59F2G+F2vF71sv/DVlu5xpB+F19/2euE1IqCd4PCrQ==
X-Received: by 2002:a05:6602:3c2:b0:945:ae17:9ae4 with SMTP id ca18e2360f4ac-94822918f39mr229079939f.1.1761861786258;
        Thu, 30 Oct 2025 15:03:06 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94359efe149sm604118039f.13.2025.10.30.15.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 15:03:05 -0700 (PDT)
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
Subject: [PATCH v4 1/7] dt-bindings: phy: spacemit: add SpacemiT PCIe/combo PHY
Date: Thu, 30 Oct 2025 17:02:52 -0500
Message-ID: <20251030220259.1063792-2-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251030220259.1063792-1-elder@riscstar.com>
References: <20251030220259.1063792-1-elder@riscstar.com>
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



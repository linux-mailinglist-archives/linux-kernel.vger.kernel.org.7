Return-Path: <linux-kernel+bounces-890930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6D8C41685
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 20:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EC4C4EE64F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 19:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCBE2FDC20;
	Fri,  7 Nov 2025 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Po2QIYw/"
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com [209.85.166.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D65C2DE713
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762542967; cv=none; b=q27H7Soi0h+xG9/9XkMieELjPT2BzFfUkms4d2HyJD5EZafnaPBqpvpPZuopFIIJu5aKobczbtr6VpLrcGxlzfrCr9cYvccSgoGJOrZHjvkKlHTyrbKDhmmlRJQqrEeaCDa9nhfgeOaQI7lQrjtk5puSa3QNdvTS6vU8TyvIcv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762542967; c=relaxed/simple;
	bh=YHBye0L9cMHXAeuikElziIHL0SY2EvFZooP/HwyaGbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzIcUrZTBPcCBru/NDRWj6bcbgfVdaJp7pfw7/NwJi980B4uxAfZoiB+XMsw40yU2egujCcMGj/gShmQBzGJXbUp18379Wyo8v33LF4FyznBNmdtkTB4qKYuLia17w4g+2P88/pHs9+qEryZS8PbjuWTxuTTLSPrSoA6x+Jph1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Po2QIYw/; arc=none smtp.client-ip=209.85.166.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f68.google.com with SMTP id ca18e2360f4ac-940d25b807bso38441339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 11:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1762542965; x=1763147765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ay3vJcZn8gR8uhIOX8xdTsiqp7cEn/zrhd4VkngAbaw=;
        b=Po2QIYw/tT5mVbbVOPa+SSXW9cr2xH6kDniuFpW+uQ7BEbNOqIm2w+wU6yDJ3B/A6A
         Jd97tKiXmYy8vI8WRsmQ+MmD3eliTgLnsKWMWqrywMzCXsfd7kx0i2syyH1dAvIKrwbK
         tS0y+59VBzx+fJpJ0zc5lld5H3YbKwz1qtcgW4PEwAf3+axkCCNrqHvjjEjx2DcbvH7/
         LwzGVl3AxkbvRhBBHdvEKSvL8OYyZHVk5UQEkECrVyRx4Cc/CErf3Z39rZr0qW7ZjKTy
         e5oD0RZGT+QQQIoR/nHcGLMhPsfVGw0GHAt9ByuOX7gttjjp2qeI7iwT3XycHAnOo2+L
         eNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762542965; x=1763147765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ay3vJcZn8gR8uhIOX8xdTsiqp7cEn/zrhd4VkngAbaw=;
        b=EHcfckvp9/6Ml2SdB+JKWHuW7bbO12HMVwU6ftf2ZKYFz8Ek5MaH8v8aOepW35ynlU
         8P17f6nGDQq/0IDU4DlVL7iSV8bDVLyO+PfxNyX2baRodEFuGfrtxxDXp6MYPEQvQOj0
         zxUZtCG117BxY/xuC1HTGsUSCcdB81K4CpLwBItmEaqbfQmokhRaJE6s02yNBaWAnfS2
         e/sbu8IWHPFYBwX1L08ifnSP01VC3AUyKdUQlU8B+dx7PKbUfSZko9hPK+TZIcWJ55qs
         16gxwk4NHKhv/lqpk54rdPZ2u/if6U1JhkmMZUk9GdpnvCquoBtR977KzvuyDvEoeOS+
         feXA==
X-Forwarded-Encrypted: i=1; AJvYcCV5ZMHzA6120+DZ+prwItL1Hhlf59JibI1pzQfpGZyNGjSM/ECW6/9adQe4WLH8ivxN/cZwUT2/WfQQx6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhgRzHuxHXjvdkMiYffPd/f1wiuEiBYIcIfcdVDqwDYswrjZfw
	bkybi/bvj2XLAKFkz6Sw8zS9C3Drocg1XmOU5oL6iDCr9SFxS6QBqo1ODh+zbZ4Jn/A=
X-Gm-Gg: ASbGnct4RjLLimyigIC+glUuRVbiw+0mU/1XS7kmdbHaDV3brqTT7GEJHoMnVCAu4sh
	O02qai70FDKxhOIzamjG1Z8wDl1xjHaLogw+BVgcsjkok89qvVpocrWbOaeOJToCt3zwZiwlUxF
	4KX/bfkcQh8jTduqquEEyfcyqHMXLf36su5K9q+dlrerDZMW2sNmZSImFqNhrRJdPvqkXhFxD+5
	0ktsNkSEAWrl8yQDmK4pOX006OnKgampFY2xuvU23GxzFFFaB9TKP70l5yJtQQDUoQ8mi6zdXNB
	Tihw/lypt1EPrt2e7A14aIB2CA9GLv0Y30QnBffA+9TsIGS15GJFQibWDUKWmbLx4tzKy9cx5HG
	bZ8fQRVPj7uoIyizIPvM7uoZBTbHRrS167BVQiZp68h3tcslDMFPNURXYRsS+c8Q/QsEDtnuOSZ
	DeLmkrX1mWeNsNkC2o/tyjlWMLWjxdnluv707/9qTPcjs=
X-Google-Smtp-Source: AGHT+IHCQMw8gkgpun15fOExG5Sy7WYN+BCNzSaipPURAOzJ4FqM/yDv4HIDN8wPjwaYW4Sy0gZ/Fw==
X-Received: by 2002:a05:6602:15cf:b0:948:7c51:1977 with SMTP id ca18e2360f4ac-94895f83afemr60413039f.4.1762542965062;
        Fri, 07 Nov 2025 11:16:05 -0800 (PST)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94888c34c6asm118772939f.10.2025.11.07.11.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 11:16:04 -0800 (PST)
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
Subject: [PATCH v5 1/7] dt-bindings: phy: spacemit: Add SpacemiT PCIe/combo PHY
Date: Fri,  7 Nov 2025 13:15:50 -0600
Message-ID: <20251107191557.1827677-2-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251107191557.1827677-1-elder@riscstar.com>
References: <20251107191557.1827677-1-elder@riscstar.com>
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
v5: - Wrap lines at 80 columns

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



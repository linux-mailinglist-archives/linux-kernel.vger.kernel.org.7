Return-Path: <linux-kernel+bounces-767355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9054EB2533D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C479A1B68669
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E8D2D3EC3;
	Wed, 13 Aug 2025 18:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="uu8PLes9"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6A32D062C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755110835; cv=none; b=RiOKl7NAxtE3h7lmG/uObURtk68gN4gh89U/L9MyYGeEHJVmknYCT/jqJe6sztsqR8Hn0bDxykxedjN8ocBBGatolNlKw4qm8Nfn7eduAmgI/Fc8YHAJc6D+FKOkCgA1xDo+dAvsFxpY5TrQlcf9sLuYuG6+gWeeeKuO57Wjsrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755110835; c=relaxed/simple;
	bh=I1Fbq3sRTWmHpHKq8gzA3D8g39oa/c4++9vGTDrE6ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmpE+/S9Up3O4fropwC/wAhBeIhN1xhbggoMGstM8GXCypnBSM8BMl/y8jtW0NhnNIz4yrimVJN8nwGjwwixu+297pibgfaJaRa0RXkkm4APruSPHfSFiPwNzGI2TZwwcMI76RMafyaUs1/JeEhM/MG0oUdikqkfBk8sr41o7fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=uu8PLes9; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-61bd4f449fbso72841eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755110833; x=1755715633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/fqC4nALQVMBj7bFUL2jEw1OtiREN8C4zl+rZu4SV8=;
        b=uu8PLes9Sbhm3NQRb63IemNTQru+V3W7jioOw4y557VHGfBodBMESRW6Ewk5Bo10BP
         dLsnoppWN7gGYT2CyJtQESomK45puLX+iZu2VMICBZYvCBQdg5zO3A8lxcpAZ0nsjJnt
         yGE/SYkys+SvfEjNR7Q9jZACw4J2SAv/gPFKmv6lT/euOOmrpJbb0dD7bAjOLhhgKEPu
         f+id3AApfFs4rUj/ECTL+KcF5ts2XkllOPA5bruZLwMuqxPeaiXMu3+eQ1TleiHxdilT
         EvYJSIaPunpl8EJH72Q+MR5tFVEn/sxv8GHnVzjmfT5EpVs0Rtr2qQa69IzBTWrtpkFX
         bWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755110833; x=1755715633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/fqC4nALQVMBj7bFUL2jEw1OtiREN8C4zl+rZu4SV8=;
        b=X+xEo4+pU9VLD59sl7gtn8pYOL9+ZQo1VhtnNVEIq5Uok7Y26diOAQ6J3SZho3riOq
         GDWziNEuHHxPuguClenqsWWR88fbisBmv6odbBDt5scKY7GGZsCos1pauG/CpK3zNW2P
         d9nAO1H7vdf6AikcD0CmKESQ5nITpnSupZ46pom+ROow+jwsBTDZkSaYFOXfZUpg/EUO
         PIDJnzITRAOgSuqoiPmN5izsAxsbDUTHHiW2el+zSS6D7nfg19bdTqamiIEyjq/Cb9cf
         cBwUErK3TkFUxpgmFgbPx7miTVivsv2mmN9HunGhjKBnOTcjY71gbgQrn0BuxAx9xfkm
         wFKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBMQIH877a7Wc0Tcqofu7NLN3j7Tsi7omjYpgcnrf27uI3nRNr8Tmc/SA2eAnq74Pj1dBNxmukjF4CEKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD+R0bfrbbiALqkRd5fPMlrfuRd66H7ibsGtTRj5/EWj0zAsX5
	R9MW2KyyJ8E934Ma3tW+Tkh0UMUnQfoa7sAupA1Gcg0YlNFThvpy+a6wDK4VLdtdvF8=
X-Gm-Gg: ASbGnctq+5jXWMm5G/Nk+35nyIl1xGEe8T8Ozfl1QUgDRK9a8viS7t+XA9chOhRgwl1
	YYsnHXIsvGqNfZz9jUFv8TuQSD9M47OuvGoP/Imhr4uWx6i2H4MlPQgSffPZOd0zgMxa4/5+icP
	7B7in2CQh6lyhD0MihqJwOD+O1TNAPdzELCFilh/OfWBvvHo8gccUtroqxYoD//SQv7IpzIHaED
	CRiwhukWbqSt+YdpUdf9YB9wXd0qM5om3w45v2mAusuxG706sOPJV6lvh9DciGMJ0W+Tyc1mL3g
	PnxMpjnhcFVhR5N9dO3aIx+z1fmB9wxpiCT2x6rW7J+zBkCRhp2epC8SDIB5gPl0IYIlcrBb7Pj
	uuejZSP3RH7Z2+XzDRBMxuXXEzPrx4fIlC7+9BkyoOdDtg9/d/OAmy1Xjz5RaQXaAb+buF4EdFR
	Kd
X-Google-Smtp-Source: AGHT+IHF1n+ZhqP61SwoH204sSXJGnu+o0AKgjp6BGFXm/PCtUV8R3O/mmBermEKt/vAX0VIMTfJcg==
X-Received: by 2002:a05:6808:7004:b0:435:6c1a:f3b with SMTP id 5614622812f47-435df6f2ce2mr177943b6e.14.1755110832896;
        Wed, 13 Aug 2025 11:47:12 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae9bd89d7sm3933104173.59.2025.08.13.11.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 11:47:12 -0700 (PDT)
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
Subject: [PATCH 3/6] dt-bindings: phy: spacemit: introduce PCIe root complex
Date: Wed, 13 Aug 2025 13:46:57 -0500
Message-ID: <20250813184701.2444372-4-elder@riscstar.com>
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

Add the Device Tree binding for the PCIe root complex found on the
SpacemiT K1 SoC.  This device is derived from the Synopsys Designware
PCIe IP.  It supports up to three PCIe ports operating at PCIe gen 2
link speeds (5 GT/sec).  One of the ports uses a combo PHY, which is
typically used to support a USB 3 port.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../bindings/pci/spacemit,k1-pcie-rc.yaml     | 141 ++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.yaml

diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.yaml
new file mode 100644
index 0000000000000..6bcca2f91a6fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.yaml
@@ -0,0 +1,141 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/spacemit,k1-pcie-rc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT K1 PCI Express Root Complex
+
+maintainers:
+  - Alex Elder <elder@riscstar.com>
+
+description:
+  The SpacemiT K1 SoC PCIe root complex controller is based on the
+  Synopsys DesignWare PCIe IP.
+
+properties:
+  compatible:
+    const: spacemit,k1-pcie-rc.yaml
+
+  reg:
+    items:
+      - description: DesignWare PCIe registers
+      - description: ATU address space
+      - description: PCIe configuration space
+      - description: Link control registers
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: atu
+      - const: config
+      - const: link
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
+  interrupts-extended:
+    maxItems: 1
+
+  spacemit,syscon-pmu:
+    description:
+      PHandle that refers to the APMU system controller, whose
+      regmap is used in managing resets and link state.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  device_type:
+    const: pci
+
+  max-link-speed:
+    const: 2
+
+  num-viewport:
+    const: 8
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - spacemit,syscon-pmu
+  - "#address-cells"
+  - "#size-cells"
+  - device_type
+  - max-link-speed
+  - bus-range
+  - num-viewport
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/spacemit,k1-syscon.h>
+    pcie0: pcie@ca000000 {
+        compatible = "spacemit,k1-pcie-rc";
+        reg = <0x0 0xca000000 0x0 0x00001000>,
+              <0x0 0xca300000 0x0 0x0001ff24>,
+              <0x0 0x8f000000 0x0 0x00002000>,
+              <0x0 0xc0b20000 0x0 0x00001000>;
+        reg-names = "dbi",
+                    "atu",
+                    "config",
+                    "link";
+
+        ranges = <0x01000000 0x8f002000 0x0 0x8f002000 0x0 0x100000>,
+                 <0x02000000 0x80000000 0x0 0x80000000 0x0 0x0f000000>;
+
+        clocks = <&syscon_apmu CLK_PCIE0_DBI>,
+                 <&syscon_apmu CLK_PCIE0_MASTER>,
+                 <&syscon_apmu CLK_PCIE0_SLAVE>;
+        clock-names = "dbi",
+                      "mstr",
+                      "slv";
+
+        resets = <&syscon_apmu RESET_PCIE0_DBI>,
+                 <&syscon_apmu RESET_PCIE0_MASTER>,
+                 <&syscon_apmu RESET_PCIE0_SLAVE>,
+                 <&syscon_apmu RESET_PCIE0_GLOBAL>;
+        reset-names = "dbi",
+                      "mstr",
+                      "slv",
+                      "global";
+
+        interrupts-extended = <&plic 141>;
+
+        spacemit,syscon-pmu = <&syscon_apmu 0x03cc>;
+
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        device_type = "pci";
+        max-link-speed = <2>;
+        bus-range = <0x00 0xff>;
+        num-viewport = <8>;
+
+        status = "disabled";
+    };
-- 
2.48.1



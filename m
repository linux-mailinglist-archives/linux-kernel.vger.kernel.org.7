Return-Path: <linux-kernel+bounces-829614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F36C0B97760
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB394284E7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5907430AAC8;
	Tue, 23 Sep 2025 20:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4aWfbJM"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA8930BF66
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758658381; cv=none; b=HYsYaggwX/5DEjBcMsC4L6UVYAsYY3S/A9uLMoY4tUL+8XBgzZkhqOxY9nLg7+0C2KzgG12bVQpDYvJc2a3PuMdHj6Xklzf5iM+vmeMrkwKGdWWFY6EQZOxnW1C7cagECmh5ESTKf07F1CzAM4M2LFY5jx7JsmqboJip2IiphAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758658381; c=relaxed/simple;
	bh=wI2EgBAstfuh0Lwsj21CyJ/ou9l4B9diH54Sb1sikXo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8N3T0WUA5ELm4K69SC4Ntwpm8F6FQlOWec2MtifFCRYCuHOi+rzxG3OO/4wMIruAXI+Kl8dRUhcGPDsN/2RiU/QkFvKKIZfI26tCyOPA3PNDqfieZz+5XwMRuIETgEreqPYnfTmtubBrGz4ciqQiGexiTzTzvJYdU8Xauykhcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4aWfbJM; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ee1381b835so3965787f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758658378; x=1759263178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojrSKhmG/fxO+GWCa4ng/6S+zCuiK4Lwk2+N5nW6KeM=;
        b=I4aWfbJMLxNGvHYHVIkYpnqu8mEh3cI/hAX5eyDZ5wTUjKLvHB2bDVv50CDshakNMb
         cjBSIVdgxBZPpzbunAzbLyksezuF01h96yPYuvUduP/NNJjegpVODYKeVlDjJmaY7W50
         9ChaMWE06wd628Utf/mDKIcqgQKkvPzgI1foL4SxuJ28vJAemWHwFgxSc00w+4KQxJ4i
         nxMjBg4FnqBj7ZUdLxXe0ogc1nnDgfNg03CNKTJ1EutTpezyKV05ihMxvPpMJqvLD6d9
         gcpgv/UX634iwwBWlda64efvWwP0ogOrTvpYzwtj6B6ccM7fvFImyr63n+JSba4Wh4D8
         cnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758658378; x=1759263178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojrSKhmG/fxO+GWCa4ng/6S+zCuiK4Lwk2+N5nW6KeM=;
        b=qFc3MKD7el2q+/Qku9PTYv5SEwgL1SYiuqsMEAAqoUZr0ytsgGbtjfpPn6PL0VwmoI
         QrNLO09HniOj0za704x0Wgndm/7FhIDtu1IXLz0X9XjbwkyH70rlDcd/In5SEQ2J11C1
         n5tSHwedtiGf/93Oy0RDjrVw0OTwZqeyTrEcRPm3SUYAeHzI3TDhSFXETDZGYrqd8nXu
         N/UJaeWpTRr3z27H6pOhJIL3m+UPS8DgJ4udQ52Nhu1LHB+euDaoQMkwF2f+vu2uYEVI
         L5NSVf5eJcltj2t4PhMxgSJNWV4YYpY6qam38GNJ7RoFjoq1vRdzlyE7HtlKmXyH0s1A
         Vy6w==
X-Forwarded-Encrypted: i=1; AJvYcCV2w5JCNXMKv0JWBAkkM0JUoTWydhpwTvPiv2BLawRB1Xscp0Byo4FEjc4LaKSpjzJd4gFgQ/pMEQoOUXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCOSib9oLBb+v2phldk6BsUCc3I4x8jbvmSguDvfLdmr4jVaq4
	3UKQUYFTL1oBAgPqggFHPg/lZ/lgAlzGkZDGb3KpZlqNYt6KpMKQYZ5D
X-Gm-Gg: ASbGnctIBj+TAjTPWW7u9tQNm+IVGnAdo1HcyYPRwLVRvW9GG8fd1vdKRpIufzSOdZj
	pvCgV6DbiF8W87BmzzgODKgClYs7LIEPtex/AVM1Hrl+xQLQdDGJ/TWovhOahHanz6s5+PERSj3
	k/AgzgwxWophyraYGbjr40AQORHf4E21VfuKW+/gwxa1gqLCGJ0wN8XmFv8kk8WaWBO93oaDmMx
	PDoUAnlsW8FIoeZm54Rx/lGfJr53MvRYimuYRm2se3Dm2ssThZj/zaUYTnKNXEXXSEOON0IFVGN
	k4yLbmU/tKG7LobaX/a2rrP+7mmd4r2k/M5LxxyYOsJoLwuHqyHVjmmcKw5KHhzQxT4Xb05Tyr4
	8G3vTGWenvjEsbfAV9VQvZVMni+vlMJgV33vc18orBATtlOHKCVy5XtKVlB5CkxzODWgq+nY=
X-Google-Smtp-Source: AGHT+IGqK47tNLWDzv+QVmr3Noen4JYHJzHX9XOvwSn6hx1DoeLXgBT/x9MNl6d/T3WqvGo45eUn9g==
X-Received: by 2002:a05:6000:4024:b0:3d5:d5ea:38d5 with SMTP id ffacd0b85a97d-405c5eb6416mr3557423f8f.25.1758658377507;
        Tue, 23 Sep 2025 13:12:57 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3ee141e9cf7sm24889690f8f.12.2025.09.23.13.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 13:12:57 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-pci@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH v2 3/4] dt-bindings: PCI: mediatek: Add support for Airoha AN7583
Date: Tue, 23 Sep 2025 22:12:31 +0200
Message-ID: <20250923201244.952-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923201244.952-1-ansuelsmth@gmail.com>
References: <20250923201244.952-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce Airoha AN7583 SoC compatible in mediatek PCIe controller
binding.

Similar to GEN3, the Airoha AN7583 GEN2 PCIe controller require the
PBUS csr property to permit the correct functionality of the PCIe
controller.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/pci/mediatek-pcie.yaml           | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
index e3afedb77a01..46000049a6c5 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
@@ -13,6 +13,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - airoha,an7583-pcie
           - mediatek,mt2712-pcie
           - mediatek,mt7622-pcie
           - mediatek,mt7629-pcie
@@ -61,6 +62,17 @@ properties:
   power-domains:
     maxItems: 1
 
+  mediatek,pbus-csr:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to pbus-csr syscon
+          - description: offset of pbus-csr base address register
+          - description: offset of pbus-csr base address mask register
+    description:
+      Phandle with two arguments to the syscon node used to detect if
+      a given address is accessible on PCIe controller.
+
   '#interrupt-cells':
     const: 1
 
@@ -96,6 +108,45 @@ required:
 allOf:
   - $ref: /schemas/pci/pci-host-bridge.yaml#
 
+  - if:
+      properties:
+        compatible:
+          const: airoha,an7583-pcie
+    then:
+      properties:
+        reg:
+          maxItems: 1
+
+        reg-names:
+          const: port1
+
+        clocks:
+          maxItems: 1
+
+        clock-names:
+          const: sys_ck1
+
+        reset:
+          maxItems: 1
+
+        reset-names:
+          const: pcie-rst1
+
+        phys:
+          maxItems: 1
+
+        phy-names:
+          const: pcie-phy1
+
+        power-domain: false
+
+      required:
+        - resets
+        - reset-names
+        - phys
+        - phy-names
+        - mediatek,pbus-csr
+
   - if:
       properties:
         compatible:
@@ -131,6 +182,8 @@ allOf:
 
         power-domains: false
 
+        mediatek,pbus-csr: false
+
       required:
         - phys
         - phy-names
@@ -169,6 +222,8 @@ allOf:
 
         phy-names: false
 
+        mediatek,pbus-csr: false
+
       required:
         - power-domains
 
@@ -209,6 +264,8 @@ allOf:
           items:
             - enum: [ pcie-phy0, pcie-phy1 ]
 
+        mediatek,pbus-csr: false
+
       required:
         - power-domains
 
@@ -243,6 +300,8 @@ allOf:
 
         power-domain: false
 
+        mediatek,pbus-csr: false
+
 unevaluatedProperties: false
 
 examples:
@@ -402,3 +461,54 @@ examples:
             };
         };
     };
+
+  # AN7583
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/en7523-clk.h>
+
+    soc_3 {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@1fa92000 {
+            compatible = "airoha,an7583-pcie";
+            device_type = "pci";
+            linux,pci-domain = <1>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+
+            reg = <0x0 0x1fa92000 0x0 0x1670>;
+            reg-names = "port1";
+
+            clocks = <&scuclk EN7523_CLK_PCIE>;
+            clock-names = "sys_ck1";
+
+            phys = <&pciephy>;
+            phy-names = "pcie-phy1";
+
+            ranges = <0x02000000 0 0x24000000 0x0 0x24000000 0 0x4000000>;
+
+            resets = <&scuclk>; /* AN7583_PCIE1_RST */
+            reset-names = "pcie-rst1";
+
+            mediatek,pbus-csr = <&pbus_csr 0x8 0xc>;
+
+            interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "pcie_irq";
+            bus-range = <0x00 0xff>;
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 7>;
+            interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+                            <0 0 0 2 &pcie_intc1 1>,
+                            <0 0 0 3 &pcie_intc1 2>,
+                            <0 0 0 4 &pcie_intc1 3>;
+
+            pcie_intc1_4: interrupt-controller {
+                interrupt-controller;
+                #address-cells = <0>;
+                #interrupt-cells = <1>;
+            };
+        };
+    };
-- 
2.51.0



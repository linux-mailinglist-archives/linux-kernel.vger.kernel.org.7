Return-Path: <linux-kernel+bounces-836233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3223BA910E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 683E44E17B0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23249301037;
	Mon, 29 Sep 2025 11:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYN+e98o"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B7B30170A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145904; cv=none; b=ZIGFUMR23Fk5tolHM2I/h0zyOxp4JCkLWXDl+4AOOQQoGEzutyC4RiVj4RZvMmYQGgpjIeo1Gwg3Yp9e9iCqhN3XdauIMr+Y7dFQcgK1viirhvyeGA6qkH2xQwJsb1/MnVZPRdHmQQRZi5esCFGiLQoD/M1DjCxLzMrrD9JPgsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145904; c=relaxed/simple;
	bh=JmJSN/YBNM+mDU5SsW6cP009KHpjO9jA4E3c7+XHHtg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZXaNRDqUgOY/09NPKAmHGfo+FjQiHaW273C0BTqSsnqzwOOewloh2uYxvXMT5BM05ll2nyEXkEQUDPLVmsgq7nnN0WOrLjZmBgE/QUJxYpW42/ETQcIxjFs7+KXFTBIy6yB+0dahrWNz+CDYKKKEiofwkbvv5UXT+llJzwAQn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYN+e98o; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e504975dbso8641705e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759145900; x=1759750700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0akVzwetHFuOLRrA1RBETtHcqSI0prdy+4IQvcPTIc=;
        b=DYN+e98oXyGkYzKeQVUq4kIMyWNoJyecT9cneTEE3SXYMgOpvNWiBzis72iZM3f0k8
         mWiwFqdiglEAvXt8g9s/IBWZF0Ycmctu/YLqhK1+53cyo5i/6BdwELSRsM7jUQt5ZWQT
         WAwLs+oSHnUdDyHwbRjuq58MzksfkKmTBIo7VOscH0FDAPzY6a21raZSpjYZp2x5Tvhw
         OoZI8TU8Bg+yhDRIOdVpIskGn+R0F3eNcytwxPrvL89gaAbHbA6CeZSkwNYn32req/+7
         y2aSAs2Cdh+1TOXrZ8S6AqwzR5ayPwmsPiH8NPAKPC/rq05G3i2PnHTCqkciZzITnUmA
         cPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759145900; x=1759750700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0akVzwetHFuOLRrA1RBETtHcqSI0prdy+4IQvcPTIc=;
        b=tFXbtIIRC5wkbaE1mZCsH9K7HszCba8GzYT1vOxvzQ39bU4WfbDq19Ty9imfu2bcwP
         WX0e1ACFQwo+P4RznSYmWVu3W7b9P1JYPrT7VxFunPfQFBDGeN1lSyMWGTR/DnGpG3om
         xxEAK5L0PtlUZbYyrW44jQsQfXlp6057HuKPgynEwGNwfrLkGY5DVGg0MXN7Uru2upex
         iPzIn56Gglj5PdgNVYDLpOXQ1POSdDZBqtjSY3Y11jpRXrvHuKBA32w/Rs1HSWA3Qlai
         V1Ds2FEsePDoUt1qv0rfLGS73n34ckfe/H+EGw+kVhuBcaFEMreTSkb0L/gSomh72pFT
         BcoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXueb5JebVrqxCL8YJD3sw/hL7PmP10qHHZl5mVoyKCLuaCTReX8Uqh4BfUbRAaW1YB+QcGtuM+I/ounE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Sk9BRo1EL6WiJYxMVvsHA18vq+O9+G2Xmi8EIv1p93PeNh6+
	05uUi3VoEfOuzz3LXVYOzFpCaue+4W12V2524mEKHAOygJLPglFvJsc+
X-Gm-Gg: ASbGnct/MyI2CTc57/ZEOM0MeZ9W2S/m5xzLC0ABcYJGKT1e4AgAz+RPFeOoS83Di4K
	A6vpXu/XnNxgq/kgJ1QbHpNFCC5PKnGowNI47ffBAAJFo2wi/T+32qT8WcVVhZbqTLnAs3TmC9I
	0o6qSlfupZCuvmbGYY5TPUGuzblO6rczjlffnPX3X3y+4gYSsmGTsEQb6kx9bqUUi1rIuXIyIcv
	X9PuNyLMGsZUTu33hINLd53YKLK9LkEaL3V4HEjxNRXxe9EE//R/72ZmysVzQnPvrKNCZZ5N/X6
	ft/tgi3c9fBB2g9rpoOUwSMTObj3TIJDVVuQpwqz3bV4TFx9iXTGXb3n0QmJO46wYx+XIdtDnYM
	wYAEZIN/ZyoE8PBk3or2cDnoupFsqp9WDQQUjlKEzHiGwP5YLlJb9m8xtj7H9hGBBmGofJvEb97
	vCpyioaA==
X-Google-Smtp-Source: AGHT+IHc2sldTrNgGF8rhPUi/DYc+1Z7wh5Q8HiRuvHW/nw/mJhTW80r4LIKdvY/BzwTBOCgANZI6A==
X-Received: by 2002:a05:600c:181c:b0:46d:996b:826f with SMTP id 5b1f17b1804b1-46e32a02d46mr117755925e9.25.1759145899467;
        Mon, 29 Sep 2025 04:38:19 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46e56f53596sm9502465e9.7.2025.09.29.04.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 04:38:19 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/5] dt-bindings: PCI: mediatek: Add support for Airoha AN7583
Date: Mon, 29 Sep 2025 13:38:02 +0200
Message-ID: <20250929113806.2484-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929113806.2484-1-ansuelsmth@gmail.com>
References: <20250929113806.2484-1-ansuelsmth@gmail.com>
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
index fca6cb20d18b..b91b13a0220c 100644
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
@@ -55,6 +56,17 @@ properties:
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
 
@@ -90,6 +102,45 @@ required:
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
@@ -106,6 +157,8 @@ allOf:
 
         power-domains: false
 
+        mediatek,pbus-csr: false
+
       required:
         - phys
         - phy-names
@@ -123,6 +176,8 @@ allOf:
 
         phy-names: false
 
+        mediatek,pbus-csr: false
+
       required:
         - power-domains
 
@@ -135,6 +190,8 @@ allOf:
         clocks:
           minItems: 6
 
+        mediatek,pbus-csr: false
+
       required:
         - power-domains
 
@@ -157,6 +214,8 @@ allOf:
 
         power-domain: false
 
+        mediatek,pbus-csr: false
+
 unevaluatedProperties: false
 
 examples:
@@ -316,3 +375,54 @@ examples:
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



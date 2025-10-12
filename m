Return-Path: <linux-kernel+bounces-849737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75599BD0C4A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 22:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C093BEFF4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 20:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA8F2459CF;
	Sun, 12 Oct 2025 20:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8fWwKog"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9968C23C8C5
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760302755; cv=none; b=feFCfJliwjdUu2MDBX4EHmdOM329suDLyptrkGaojie3+ccHB+4osz5e2pU/njQ7+R18c5Vg12kjR4TseEMCCmnrdyy9u0MTChpsmrQ7rrk23fb5LHY9EB4ujEm+O57SPhJxGhCvAE6Rdl55I8i7/k4Pf5Of0qPe1Vl/e30EjJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760302755; c=relaxed/simple;
	bh=Xxrmwc5Jl0lDYsa2HAHicVYwNz8UvXqpx68FsI5Tskw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CU6LvAEUJQraRGQ3/RoAe71B141/ZodGpDJolfftxJcduAWObfpBpMtKlyhJl/9w3dDXJ3Cek8z0xk4pWt4tuqjXUv5TUOQcAgeZ2r9c2TFnscj6+Bhy+1M6vzDFSnXXC72ltS8h6fv4mbJL50qPoj75N1araO5gBWV5pYOozdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8fWwKog; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e6674caa5so17919525e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 13:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760302752; x=1760907552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALuuSU+7OMf38Yq7lgs2vGROJq6nvro7orSmMW4CmOM=;
        b=Q8fWwKog5OknnhUvOrbLRXznt1acb2R1gowlHXDWkQt0OwGTX/i5R9V0dQknjulRdM
         9DWfmURoZdeoJRnTCxIISNyo3vg+CHm8qnM3m74eA+3OT/nvrf4NBGyR8CocfpbZ7eyS
         WsEHqZCDsCDJeaJQ/Oz0ue5Dd+Ie1wo3C92K/doGTkm1Sm9OTTATQSuo6Jz2yjVFx44X
         keitQegQeHlzXDcwzqAJpjUEECcINUlbdh7PFWs2LFcpoTz53S5azl3UFSW0aO0yD5ud
         J8T0Q1NZ+1+6rXQ3TGBHBzJstQLw1vFwoHqB4Aw7vr7hLnoOP6YHESMY4F/1D1af0q2T
         7Ibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760302752; x=1760907552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALuuSU+7OMf38Yq7lgs2vGROJq6nvro7orSmMW4CmOM=;
        b=trhKA7YbfJj4az69WdgdBJFCGx3SjD0jUziDuaREcB9Vi/cjhM3i5vYwLJ6wWA2xNI
         Pgw3FAR1CksauAi6bkCzzw2kcKIFgbBaY/FCsl/pMIyMRMtVO/E0IzQnGbXeP3vAuR78
         CJfaWrJX88oL7prYN3wS75a2lHzaeuTSQXtonXaUIJFZJgefbjEgUAeboyaxKMwGfoP6
         56s8LNnPe1+tlyXzUOLL60cLSn60AdS7nlfHxwYgjINjxEQRagXBntJQ2wV+RBgg8Tbk
         CYDr18dboJT38EZ20lWQ3WFjavUQ8+z0KrL1QVnaFyDsaNzgf8LFHS3E92vLEiqPmqPG
         l4LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJu9hRrR5NaQvW9w3Rt3plZOFRQZ6Pcc743B4go6ksI5GAcG4cQgJlKEM0vuMSy8+FtlctbIrmZGTB1mY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt2eRGXowvtp4C7sHgHde9XS3CUPTRqQTee2Ee9ZysLu2hxte9
	iS7fNmyHgE0i3/JuVTOyGIeuEIuL8ux+ctohI7X1H0wihv8LmvW97epP
X-Gm-Gg: ASbGncvuO8qXMDx6UHBsHbrnbzkR0a7DbP61ue3kNHkiqncmHAMODS7fvrZoeKETfvl
	JKqqCWoO1Ncbq0vJcz/D0sWlWh5KZaRB26L6F5g3tQQixD7UZujfx/ZTwmT/hU6rMYwuL0l4P8R
	o6A+xBYhhYkdfoKiMtgd1KSxWH5r9afNILbp5l5jfCRchmxD2FdE5snTNijANFRzJ7yG7S+sQEY
	zIdUR3zHB0IGdz3DDlAN3y6pVX+Gzb49NeymTGVfimh8D1e4U7wzP4NQKLZXkbY++f0dbGYKzyj
	H3yqrUwf2pUT43hDYCzjTjZ3XfAmLIsoMNQTa+l1J4n4vTMVXVkKbONgJXS9o3Kc36HC36bzjT4
	QFeGK3hzzkEYYSU4l/u5O5nwenEYsgY+KA+bkwL0poIU61lGLXl8LULQkEUgokDtyyNhYMWDUbD
	OnTtT3OOKl
X-Google-Smtp-Source: AGHT+IG/dpUbIS0g2Y3eod2I3EyF2R8BKbiMyTePG06XGuV1O4BBygByLPvF2RP+JjrNujG+8ex+nQ==
X-Received: by 2002:a7b:ca44:0:b0:46d:e5bd:2ba4 with SMTP id 5b1f17b1804b1-46fa29ffedemr100671465e9.18.1760302751667;
        Sun, 12 Oct 2025 13:59:11 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46fb489197dsm156506505e9.10.2025.10.12.13.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 13:59:11 -0700 (PDT)
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
	linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com
Subject: [PATCH v5 3/5] dt-bindings: PCI: mediatek: Add support for Airoha AN7583
Date: Sun, 12 Oct 2025 22:56:57 +0200
Message-ID: <20251012205900.5948-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012205900.5948-1-ansuelsmth@gmail.com>
References: <20251012205900.5948-1-ansuelsmth@gmail.com>
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
 .../bindings/pci/mediatek-pcie.yaml           | 120 ++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
index fca6cb20d18b..0b8c78ec4f91 100644
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
@@ -40,6 +41,12 @@ properties:
       - enum: [ obff_ck0, obff_ck1 ]
       - enum: [ pipe_ck0, pipe_ck1 ]
 
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: pcie-rst1
+
   interrupts:
     maxItems: 1
 
@@ -55,6 +62,17 @@ properties:
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
 
@@ -90,6 +108,33 @@ required:
 allOf:
   - $ref: /schemas/pci/pci-host-bridge.yaml#
 
+  - if:
+      properties:
+        compatible:
+          const: airoha,an7583-pcie
+    then:
+      properties:
+        reg-names:
+          const: port1
+
+        clocks:
+          maxItems: 1
+
+        clock-names:
+          const: sys_ck1
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
@@ -104,8 +149,14 @@ allOf:
           minItems: 2
           maxItems: 2
 
+        reset: false
+
+        reset-names: false
+
         power-domains: false
 
+        mediatek,pbus-csr: false
+
       required:
         - phys
         - phy-names
@@ -119,10 +170,16 @@ allOf:
         clocks:
           minItems: 6
 
+        reset: false
+
+        reset-names: false
+
         phys: false
 
         phy-names: false
 
+        mediatek,pbus-csr: false
+
       required:
         - power-domains
 
@@ -135,6 +192,12 @@ allOf:
         clocks:
           minItems: 6
 
+        reset: false
+
+        reset-names: false
+
+        mediatek,pbus-csr: false
+
       required:
         - power-domains
 
@@ -151,12 +214,18 @@ allOf:
         clock-names:
           maxItems: 1
 
+        reset: false
+
+        reset-names: false
+
         phys: false
 
         phy-names: false
 
         power-domain: false
 
+        mediatek,pbus-csr: false
+
 unevaluatedProperties: false
 
 examples:
@@ -316,3 +385,54 @@ examples:
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



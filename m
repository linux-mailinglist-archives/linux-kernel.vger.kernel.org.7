Return-Path: <linux-kernel+bounces-893786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C22C485D3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11748188E1E9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706152D9EE8;
	Mon, 10 Nov 2025 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JhA4EfbX"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10D129D275
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796022; cv=none; b=KNaPymIKf1KCjqZcH9TGsPb7RvlUQaAJRauzdp/zFogQHF+8fuuznqIVeiEcboxxm04DyYWm6b8r+JPQ5pwCJQVy3Sytijf0hZeuLPY59VhhAJGCiSbF3/TRgfLQXAn7zmNAq/UIIScutZzhkUOz0LamZG2IZgsb+5FBpF/Qfxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796022; c=relaxed/simple;
	bh=VwXqjqb0vlwdIay3FsUmamgWNpL8wpFbJjWxzHFn1II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXx+N5AlLwjBEnVa9Xvxq8NkZ8SeITyTKqbEFsaiggvDZiomTi7AJ1xBESAXrqFiWI9sXl2+NFn7brrjgKv3WeHE4lsVxmtD9ByMT6QC/tdpSRqTZK2ghKgvYrimCQTRN3sk5sHuX9WZaruecWihqIQRi+vNlJsYCfZHqNjXtao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JhA4EfbX; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4775ae77516so39289005e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762796017; x=1763400817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sHMOBUaDG1Wui3cyeff4HsBqo1sgWu6v9dYZ/ORpKI=;
        b=JhA4EfbXTf9abdSiI+V6pCyRrMr6CWyFePgvp73X10+h8HfUJI/PFP//a1EWNCbX5o
         9IzISxq3CEMPmy55baTMok7GD6snldJHOWUey8X1k+M64sAx2JCKL3D2qZtZGn4klvbU
         i7/DsmQXcltWhM4oTkuz15WUYaMIXNIRkqa271oSzXuuo1cRUTb2e8E4NLEn7I5kMF7c
         Zu8LEc9dAP65JN7LZcfzNQZSsisgI7rFyPNgx7v2WVlbnBvTgukVw2vUo4vUTrwaz6Os
         EXMtTRk/qgTvOTM2Q6tR480rx+dBewIqCmJv2Muh5zOpq7qlIWRTDzr3CWuA1/+w1xNt
         /wQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762796017; x=1763400817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7sHMOBUaDG1Wui3cyeff4HsBqo1sgWu6v9dYZ/ORpKI=;
        b=QrHehi0hlFWh4RyY5W0ID0NVdwezelqX1s50Tl1+by2AjkD3aUqs7nXKh01qE0wpX9
         Bl18qO34xkeIFsvAGA6EOVZ9cnfN4tZ1M0SFpfooffcpb7K5gvooPceTEO8JPeKDIpSb
         TYmvYe/8Y5jQz74pHPrE+fTwupHkwYwqivVktPEhpXV0n2PFFKFtXN8i4BiX8FRVn5n0
         HUT1KTmBq93rbbaB0NmpJtsqmPQVneu2Y8KnDaiCF7MXkJQ1Ph2ZeouHw3zCMhQHJdy0
         zwmRQIHn1FD68e1+H0AuwZbdiU9MA2kfomCtmGLuFy8uOf7LFrh65II1bz0T8gvUfvqe
         sxYg==
X-Forwarded-Encrypted: i=1; AJvYcCXkMU9HkNk7OW5YGgDmk5YVZhLJ6hSXyeWYCmPjqe3D65T5jxrAKlKOzzp23XN30xIMYOinz/CAKOwVc4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM1ArTRoPaeHiZn5Q+M0Q0LZk7r3/u6GeD5bSGslEQn3eIs6CG
	DDGzA0Mr4fEQxGVvbPGy7Y9f7pUCawG9udCgwsAU5UAFLHpYmQv44XmO3xlta7O063I=
X-Gm-Gg: ASbGncvhXX0G3nlh48KVV3eqinMircm/J9PRz8R8YIFMXlgqfPU/NPwCQjA2YhPF9jp
	innbkOwL8ShrpaLHQORNzxI57U3BWIRXIl4fJdLpuIxYXb/D8uW1l7UEKCHiAppLCbQjs0nkxvz
	NzJtw6KLd0N+KgTLZsJSt6eew5GyBQf33HQmLWSXJjBELVnCS4AnsS7ZQXjxbeRlC3H1xomjaUK
	mhxyfSVoKtAolbyxncAxeH6c7qInsrIIl4GtyfdzRFUCQfSYb0FBOllORYOchN2d5yOH4QXseuS
	OhUagKkkuOt0wLn+IXiwYQjqUAAt4cs45GorHd2VJyuowLV+2MCBf8BEkOQxUQqZItjrGYAZDMb
	9XrSMwqYms4TWtHgrDE0GhNEgU7N7r9imkiJrGJ2F3bXErK2ydH4lHFMvvqY73k1JEYEUr6CZv4
	jSvfKGP+2D
X-Google-Smtp-Source: AGHT+IFFes5RpqIkwRV81cjLZLjmcQ90Ib1gecuHLTiUtJRRieBtbR+NqpbH88IgcfUI1Bw2hVKcTw==
X-Received: by 2002:a05:600c:474c:b0:475:da13:256b with SMTP id 5b1f17b1804b1-4777329777amr79682445e9.38.1762796017253;
        Mon, 10 Nov 2025 09:33:37 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:d5ec:666a:8d59:87fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47774df2d80sm140111375e9.14.2025.11.10.09.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 09:33:36 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com,
	s32@nxp.com,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com,
	ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com,
	Frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Cc: cassel@kernel.org
Subject: [PATCH 1/4 v4] dt-bindings: PCI: s32g: Add NXP PCIe controller
Date: Mon, 10 Nov 2025 18:33:31 +0100
Message-ID: <20251110173334.234303-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110173334.234303-1-vincent.guittot@linaro.org>
References: <20251110173334.234303-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the PCIe host controller available on the S32G platforms.

Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
Co-developed-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
Signed-off-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Co-developed-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Co-developed-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
Signed-off-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 .../bindings/pci/nxp,s32g-pcie.yaml           | 130 ++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
new file mode 100644
index 000000000000..6077c251c2cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
@@ -0,0 +1,130 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/nxp,s32g-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP S32G2xxx/S32G3xxx PCIe Root Complex controller
+
+maintainers:
+  - Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
+  - Ionut Vicovan <ionut.vicovan@nxp.com>
+
+description:
+  This PCIe controller is based on the Synopsys DesignWare PCIe IP.
+  The S32G SoC family has two PCIe controllers, which can be configured as
+  either Root Complex or Endpoint.
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - nxp,s32g2-pcie
+      - items:
+          - const: nxp,s32g3-pcie
+          - const: nxp,s32g2-pcie
+
+  reg:
+    maxItems: 6
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: dbi2
+      - const: atu
+      - const: dma
+      - const: ctrl
+      - const: config
+
+  interrupts:
+    maxItems: 2
+
+  interrupt-names:
+    items:
+      - const: msi
+      - const: dma
+    minItems: 1
+
+  pcie@0:
+    description:
+      Describe the S32G Root Port.
+    type: object
+    $ref: /schemas/pci/pci-pci-bridge.yaml#
+
+    properties:
+      reg:
+        maxItems: 1
+
+      phys:
+        maxItems: 1
+
+    required:
+      - reg
+      - phys
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - ranges
+  - pcie@0
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/phy/phy.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@40400000 {
+            compatible = "nxp,s32g3-pcie",
+                         "nxp,s32g2-pcie";
+            reg = <0x00 0x40400000 0x0 0x00001000>,   /* dbi registers */
+                  <0x00 0x40420000 0x0 0x00001000>,   /* dbi2 registers */
+                  <0x00 0x40460000 0x0 0x00001000>,   /* atu registers */
+                  <0x00 0x40470000 0x0 0x00001000>,   /* dma registers */
+                  <0x00 0x40481000 0x0 0x000000f8>,   /* ctrl registers */
+                  <0x5f 0xffffe000 0x0 0x00002000>;   /* config space */
+            reg-names = "dbi", "dbi2", "atu", "dma", "ctrl", "config";
+            dma-coherent;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            device_type = "pci";
+            ranges =
+                     <0x81000000 0x0 0x00000000 0x5f 0xfffe0000 0x0 0x00010000>,
+                     <0x82000000 0x0 0x00000000 0x58 0x00000000 0x0 0x80000000>,
+                     <0x82000000 0x1 0x00000000 0x59 0x00000000 0x6 0xfffe0000>;
+
+            bus-range = <0x0 0xff>;
+            interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi", "dma";
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0x7>;
+            interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+                            <0 0 0 2 &gic 0 0 GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+                            <0 0 0 3 &gic 0 0 GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+                            <0 0 0 4 &gic 0 0 GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+
+            pcie@0 {
+                reg = <0x0 0x0 0x0 0x0 0x0>;
+                #address-cells = <3>;
+                #size-cells = <2>;
+                ranges;
+
+                device_type = "pci";
+                phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
+            };
+        };
+    };
-- 
2.43.0



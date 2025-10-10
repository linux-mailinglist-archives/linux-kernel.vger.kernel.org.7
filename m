Return-Path: <linux-kernel+bounces-848738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4895BCE763
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D8D7425CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA26302745;
	Fri, 10 Oct 2025 20:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AvwG2dEM"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2D3301493
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760127385; cv=none; b=a5/VgzQPvruIEw9vz0FGTS9IAVFpW1RCjQqojuze5iDPOq4FkIV1V1wR6FbU1x4VYuzCKWfPzZHSw2Vec+U3GRZD5rDyirY52OkBjGnjO7e8PrrtqGULfOzPwjgeEKzYp2RJgDgtFGzPuHHUWdGkIu2uBjusDB0c24/ZXedgMxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760127385; c=relaxed/simple;
	bh=m+F37612IGMHvLc16v/jAtfnK17+MxK/JVaGZhH/rOw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AEa0x2m+/Udbp/q/kSeLP7a0LA8qGOnEjbZ8gkFAERBlA/BcjnnQs03TCo4VZ/a4lSiLThPWEyVnxgNw6RxKX8+7Fclt68+FVuXrOnIcea5NGzn8UQ0hAPy0YP97tS6jdDItzY8TsFhXS0ushlGBcfwQ1VRrZIcWm1TE8qsEP/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AvwG2dEM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3304def7909so5631399a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760127383; x=1760732183; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wl+K3dr5aF0u4Q2P+9MDk1HHOxlzdHXYY9jrwJSxmqs=;
        b=AvwG2dEMN1E/R9BuifQ/5Lp2oQ8QpsbrARbrFMTKu89cbaFyB60CxRQ/G+xD/K+fb5
         0Pt5QGrJNZ7bW/GfAK/mRON/H+mSPEcLuICSVIqDhUfmFXQ7QWf+z2JtqK7knYI68GH7
         czLFJ2eCMXJQyx1RXs7jbeTPOF1K8Bg7iy0SgIixC+B7rgbo12Y/nd0Jnlnkt3tMuJX6
         LXSFf6igA0u2tsNE8O9B+AFoZB6rauCf/+JzHlEO0cIIeN/6Mv7YkKOlnsFk1hylq9uv
         ZurQQ2WWoYz9kUL3y5EggkjjDc/OFdLS7rvVtfLR3iDPqK1tnx6HKjbZUZT37K+0MthX
         wTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760127383; x=1760732183;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wl+K3dr5aF0u4Q2P+9MDk1HHOxlzdHXYY9jrwJSxmqs=;
        b=r6zol4uez8DKMapJm14prsWtqe5gUkk25zNwjd3szgm2flZptGmUoJhTbWYf143r9P
         M0MP+BdOLGpMMwggwgeM4HB3OM09OMQ/N22v/PZvcmD3CtmZ9+TTWl3xx9a6udTm5NYK
         mg83oLAg1Hi2d9VeLRr7MO6QXl0MoWDPYxm262+3vElf+z7qKImPppy6VQw6fmDD+9k5
         TamYRcE2X7lyX9cuwjj4tWrknEO+uqccdC/Gitn9JegHU6wGL25HqeQVneAsPHGR3p7K
         LMSl1Ctj0bY4adQlsFcJh6KnHH02UMKrQ3rjLIG5Fs4F6cuquitbYlf/ZoyekNrEBYQq
         92BA==
X-Forwarded-Encrypted: i=1; AJvYcCU25wn/z0DC9V7WF6CNJvQ+4YZf6D6dnYbZgJjROPKY5/x+ETWSyLk6c0+xIUP9WwzQ0I63l+GpcEUeF3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyr65zh8rWsx7HEyV1taAQabOyDnJq+j7L1/EOiOz2lprVRn82
	RHWFaGrdmkPEAx237+hjGhyXgRvortS6OiPfvBkVeJ2L7SRQQYS6bzr7Wo+x/3LnVkY2t3++dNK
	NDu4uLw==
X-Google-Smtp-Source: AGHT+IFk8ClGIAy+ZveXDAUA46gMVmfQcViJcyf3PjbmPLP8E3Q60Y+VuC/rLX+rN4bo089j/56MJ/qKNBU=
X-Received: from pjbfr18.prod.google.com ([2002:a17:90a:e2d2:b0:33b:51fe:1a90])
 (user=royluo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e07:b0:339:f09b:d372
 with SMTP id 98e67ed59e1d1-33b513b4c91mr19379313a91.23.1760127382638; Fri, 10
 Oct 2025 13:16:22 -0700 (PDT)
Date: Fri, 10 Oct 2025 20:16:04 +0000
In-Reply-To: <20251010201607.1190967-1-royluo@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251010201607.1190967-1-royluo@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251010201607.1190967-2-royluo@google.com>
Subject: [PATCH v3 1/4] dt-bindings: usb: dwc3: Add Google Tensor G5 DWC3
From: Roy Luo <royluo@google.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Peter Griffin <peter.griffin@linaro.org>, 
	"=?UTF-8?q?Andr=C3=A9=20Draszik?=" <andre.draszik@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Joy Chakraborty <joychakr@google.com>, Naveen Kumar <mnkumar@google.com>, Roy Luo <royluo@google.com>, 
	Badhri Jagan Sridharan <badhri@google.com>, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Document the device tree bindings for the DWC3 USB controller found in
Google Tensor SoCs, starting with the G5 generation.

The Tensor G5 silicon represents a complete architectural departure from
previous generations (like gs101), including entirely new clock/reset
schemes, top-level wrapper and register interface. Consequently,
existing Samsung/Exynos DWC3 USB bindings are incompatible, necessitating
this new device tree binding.

The USB controller on Tensor G5 is based on Synopsys DWC3 IP and features
Dual-Role Device single port with hibernation support.

Signed-off-by: Roy Luo <royluo@google.com>
---
 .../bindings/usb/google,gs5-dwc3.yaml         | 141 ++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/google,gs5-dwc3.yaml

diff --git a/Documentation/devicetree/bindings/usb/google,gs5-dwc3.yaml b/Documentation/devicetree/bindings/usb/google,gs5-dwc3.yaml
new file mode 100644
index 000000000000..6fadea7f41e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/google,gs5-dwc3.yaml
@@ -0,0 +1,141 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (c) 2025, Google LLC
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/google,gs5-dwc3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google Tensor Series (G5+) DWC3 USB SoC Controller
+
+maintainers:
+  - Roy Luo <royluo@google.com>
+
+description:
+  Describes the DWC3 USB controller block implemented on Google Tensor SoCs,
+  starting with the G5 generation. Based on Synopsys DWC3 IP, the controller
+  features Dual-Role Device single port with hibernation add-on.
+
+properties:
+  compatible:
+    const: google,gs5-dwc3
+
+  reg:
+    items:
+      - description: Core DWC3 IP registers.
+      - description: USB host controller configuration registers.
+      - description: USB custom interrrupts control registers.
+
+  reg-names:
+    items:
+      - const: dwc3_core
+      - const: host_cfg
+      - const: usbint_cfg
+
+  interrupts:
+    items:
+      - description: Core DWC3 interrupt.
+      - description: High speed power management event for remote wakeup from hibernation.
+      - description: Super speed power management event for remote wakeup from hibernation.
+
+  interrupt-names:
+    items:
+      - const: dwc_usb3
+      - const: hs_pme
+      - const: ss_pme
+
+  clocks:
+    items:
+      - description: Non-sticky module clock.
+      - description: Sticky module clock.
+      - description: USB2 PHY APB clock.
+
+  clock-names:
+    items:
+      - const: non_sticky
+      - const: sticky
+      - const: u2phy_apb
+
+  resets:
+    items:
+      - description: Non-sticky module reset.
+      - description: Sticky module reset.
+      - description: USB2 PHY APB reset.
+      - description: DRD bus reset.
+      - description: Top-level reset.
+
+  reset-names:
+    items:
+      - const: non_sticky
+      - const: sticky
+      - const: u2phy_apb
+      - const: drd_bus
+      - const: top
+
+  power-domains:
+    items:
+      - description: Power switchable domain, the child of top domain.
+          Turning it on puts the controller into full power state,
+          turning it off puts the controller into power gated state.
+      - description: Top domain, the parent of power switchable domain.
+          Turning it on puts the controller into power gated state,
+          turning it off completely shuts off the controller.
+
+  power-domain-names:
+    items:
+      - const: psw
+      - const: top
+
+  iommus:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - power-domains
+  - power-domain-names
+
+allOf:
+  - $ref: snps,dwc3-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        usb@c400000 {
+            compatible = "google,gs5-dwc3";
+            reg = <0 0x0c400000  0 0xd060>, <0 0x0c450000 0 0x14>, <0 0x0c450020 0 0x8>;
+            reg-names = "dwc3_core", "host_cfg", "usbint_cfg";
+            interrupts = <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH 0>,
+                         <GIC_SPI 597 IRQ_TYPE_LEVEL_HIGH 0>,
+                         <GIC_SPI 598 IRQ_TYPE_LEVEL_HIGH 0>;
+            interrupt-names = "dwc_usb3", "hs_pme", "ss_pme";
+            clocks = <&hsion_usbc_non_sticky_clk>,  <&hsion_usbc_sticky_clk>,
+                     <&hsion_u2phy_apb_clk>;
+            clock-names = "non_sticky", "sticky", "u2phy_apb";
+            resets = <&hsion_resets_usbc_non_sticky>, <&hsion_resets_usbc_sticky>,
+                     <&hsion_resets_u2phy_apb>, <&hsion_resets_usb_drd_bus>,
+                     <&hsion_resets_usb_top>;
+            reset-names = "non_sticky", "sticky", "u2phy_apb", "drd_bus", "top";
+            power-domains = <&hsio_n_usb_psw>, <&hsio_n_usb>;
+            power-domain-names = "psw", "top";
+            phys = <&usb_phy 0>;
+            phy-names = "usb2-phy";
+            snps,quirk-frame-length-adjustment = <0x20>;
+            snps,gfladj-refclk-lpm-sel-quirk;
+            snps,incr-burst-type-adjustment = <4>;
+        };
+    };
+...
-- 
2.51.0.740.g6adb054d12-goog



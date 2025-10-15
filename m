Return-Path: <linux-kernel+bounces-854805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F80BDF71B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E9254E464F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF42B302CC7;
	Wed, 15 Oct 2025 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWEUMbZ7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1993322DD0;
	Wed, 15 Oct 2025 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542870; cv=none; b=AnqXd4ADWw4n8NKM3Uw+TjioTQJ/qj/uQd/3y/eqguvDoCbhtiJ649YhaEE6+cE1a+RcDJQ4EBIJI/hGeAOPVYSxARoiZ6zrQxV26J8bkD3ac0Bsj4I6xLRz2T68UfNvRQEKJRBUu/zCp5zZK+7CCl95C4UE2wziXJW/eiuEolA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542870; c=relaxed/simple;
	bh=z/OSrLCIdtmRJvitAMSoC1V/ZcKkiBQ7+CQlgJR3nQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z1cqGwpmte0PSB82UQv5tEOlIP9WW6J++yDK1OaOy9bQ/33Y+iZYbhTQ92hgBwjc8hN0V91LYf08hkl9GtsvxOuDWvqYQJIVaqVRcrKvVE93pw60AuDei6GiQZClj39l0EPfdCs1FxL04hG1eqxnuhyGgH4cQGlqvMlqXrKP03s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWEUMbZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 724D1C4CEFB;
	Wed, 15 Oct 2025 15:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760542869;
	bh=z/OSrLCIdtmRJvitAMSoC1V/ZcKkiBQ7+CQlgJR3nQ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CWEUMbZ7FkIaiyoh13AUuwttA8tD/Rb7mB6L1upR6nEj5AvQzsFbMn3Zu6BC1ieMg
	 NjOBlWmjyDytBDeqwLWEn8o6CJp8KlSXZRcXJ5aI2Slb8FnWXVcmHE5nCM/TUNVTEF
	 gAjm6cOg+0nrncu/Sdq6tnv4Kin0R7mYfiEv2tMaNHQWmL4vXGxxqmmVXHnr7GadNu
	 LkTG2XLNPnWy4bhHW99Yy96R8yHSdi+MxZ97iRluGZdgoYKvQonXWNXwjf0U7n/Sre
	 4eBFw/JjJ1qd7whJx+LBbCBmJdpUG/hlsb0W0gWKrntlURy6hM4P/Sok08E3DHqYpl
	 gQCs024IdKOVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A63CCD194;
	Wed, 15 Oct 2025 15:41:09 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Wed, 15 Oct 2025 15:40:41 +0000
Subject: [PATCH usb-next v2 1/5] dt-bindings: usb: Add Apple dwc3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-b4-aplpe-dwc3-v2-1-cbd65a2d511a@kernel.org>
References: <20251015-b4-aplpe-dwc3-v2-0-cbd65a2d511a@kernel.org>
In-Reply-To: <20251015-b4-aplpe-dwc3-v2-0-cbd65a2d511a@kernel.org>
To: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sven Peter <sven@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3194; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=z/OSrLCIdtmRJvitAMSoC1V/ZcKkiBQ7+CQlgJR3nQ4=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8b7A70WgSbmX7V3HjZ/Jrxpq6XVobuLPLzehC258XnnT
 u2EJc8EO0pZGMQ4GGTFFFm277c3ffLwjeDSTZfew8xhZQIZwsDFKQATcc1gZLh7w3j77f+bWsWq
 nazmfpN0Oxn+6bd4uPHh8wczS1eHTp/MyHD2YWH2Fqkr4iU1offTi5/s903c9+Pr3UWBb0OTz3Q
 rhLECAA==
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

Apple Silicon uses Synopsys DesignWare dwc3 based USB controllers for
their Type-C ports.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Sven Peter <sven@kernel.org>
---
 .../devicetree/bindings/usb/apple,dwc3.yaml        | 80 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 81 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/apple,dwc3.yaml b/Documentation/devicetree/bindings/usb/apple,dwc3.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..f70c33f32c5d6172224c524fe8e7218071eb4e9b
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/apple,dwc3.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/apple,dwc3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple Silicon DWC3 USB controller
+
+maintainers:
+  - Sven Peter <sven@kernel.org>
+
+description:
+  Apple Silicon SoCs use a Synopsys DesignWare DWC3 based controller for each of
+  their Type-C ports.
+
+allOf:
+  - $ref: snps,dwc3-common.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - apple,t6000-dwc3
+              - apple,t6020-dwc3
+              - apple,t8112-dwc3
+          - const: apple,t8103-dwc3
+      - const: apple,t8103-dwc3
+
+  reg:
+    items:
+      - description: Core DWC3 region
+      - description: Apple-specific DWC3 region
+
+  reg-names:
+    items:
+      - const: dwc3-core
+      - const: dwc3-apple
+
+  interrupts:
+    maxItems: 1
+
+  iommus:
+    maxItems: 2
+
+  resets:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - iommus
+  - resets
+  - power-domains
+  - usb-role-switch
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/apple-aic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    usb@82280000 {
+      compatible = "apple,t8103-dwc3";
+      reg = <0x82280000 0xcd00>, <0x8228cd00 0x3200>;
+      reg-names = "dwc3-core", "dwc3-apple";
+      interrupts = <AIC_IRQ 777 IRQ_TYPE_LEVEL_HIGH>;
+      iommus = <&dwc3_0_dart_0 0>, <&dwc3_0_dart_1 1>;
+
+      power-domains = <&ps_atc0_usb>;
+      resets = <&atcphy0>;
+
+      usb-role-switch;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 46126ce2f968e4f9260263f1574ee29f5ff0de1c..fa238b5371b9c5942dc89ec4fa6b1d28e2d4dda3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2437,6 +2437,7 @@ F:	Documentation/devicetree/bindings/power/reset/apple,smc-reboot.yaml
 F:	Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
 F:	Documentation/devicetree/bindings/spi/apple,spi.yaml
 F:	Documentation/devicetree/bindings/spmi/apple,spmi.yaml
+F:	Documentation/devicetree/bindings/usb/apple,dwc3.yaml
 F:	Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
 F:	arch/arm64/boot/dts/apple/
 F:	drivers/bluetooth/hci_bcm4377.c

-- 
2.34.1




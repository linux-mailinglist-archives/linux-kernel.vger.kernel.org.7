Return-Path: <linux-kernel+bounces-804329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2129BB4723E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E661B260B6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4502F1FF6;
	Sat,  6 Sep 2025 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWerm7Pv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB20C21ADAE;
	Sat,  6 Sep 2025 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757173419; cv=none; b=C8Q9ZP3/yM+ORilB/EZMdRSrM1p1JFXKsn0XK7e43MOBB065CTh5n3oL3X0BO4Do+MF78jpglSZ+tJG2eBj1VTyw8Pe4sd/Oi/hzfvyQ5bjwMNo0E0sj6l7jo2ZkCX/0oHXwYy1JvnJ0r1Cd+T8FqcLlbnCOauqu3U0cvZzcFZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757173419; c=relaxed/simple;
	bh=ijo1hW/xWUy1/m3cbnSQCqYPTm7fk4/pyNoDtB66FEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HAa0730A1VvTbz3o3rqA9Rfn5snlFa7gpx7DCRtdqQPW29dKjTQ8Lz3yR2N6CIThFqFumXnQY7nnhwERA1kWns1Pma5wcxCC9W4FyFvGRcozFo0ZtcEd1L2gpAtQT37Akpq/ouPqlk3P0XG+4nTl75BXqhN5IxX+phEnsvBN2o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWerm7Pv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E97AC4CEF7;
	Sat,  6 Sep 2025 15:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757173419;
	bh=ijo1hW/xWUy1/m3cbnSQCqYPTm7fk4/pyNoDtB66FEQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qWerm7PvhC+FRMtxnYufAPBQprwLjvFkcA6/A07k70IekDAWpMWyC7IM/AlGvasUh
	 9oxKn6j6RhnY5eqG5QVnDHOSpETO/OicZ/ERbPtKzwabsJNOppU8D3XThFx1w/SN4J
	 3nzhbH4k0Co/835Zbp/FiCBhTx5mUYb9R4Ab9V8JW4hVuLPwDGo5VMIXX2UauQFDQC
	 uNcNjXLHMSYNhiKIdHvJxYqVzWqQu3HaIAYJL1V4ggnZxUfd/wtsBgoqp6ztkD8O1b
	 PWhRdXPRWOVZqZhwNDXUm0zHLLJDp1JxCbVbf5pj4GUg0BobV6t98n9+CIjLpOhBiP
	 w/tI7jM7eKleQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCB3CA1012;
	Sat,  6 Sep 2025 15:43:39 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Sat, 06 Sep 2025 15:43:14 +0000
Subject: [PATCH v2 01/22] dt-bindings: usb: Add Apple dwc3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-atcphy-6-17-v2-1-52c348623ef6@kernel.org>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
In-Reply-To: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Ran Wang <ran.wang_1@nxp.com>, Peter Chen <peter.chen@nxp.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
 Sven Peter <sven@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3085; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=ijo1hW/xWUy1/m3cbnSQCqYPTm7fk4/pyNoDtB66FEQ=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8aesJlHJ09wPGhpqSoWlrB1t1jvi52zQmV2Nfv98rP6+
 H/SmxfCHaUsDGIcDLJiiizb99ubPnn4RnDppkvvYeawMoEMYeDiFICJXFdk+MN34WbjvRwt82d8
 fXHav37y/0w83TJzZbZV5ouycjOuvlRGhq9W7Y/atPWuu+y72HtviirTtCShvrvRFxZyr9hWPat
 xHQcA
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

Apple Silicon uses Synopsys DesignWare dwc3 based USB controllers for
their Type-C ports.

Signed-off-by: Sven Peter <sven@kernel.org>
---
 .../devicetree/bindings/usb/apple,dwc3.yaml        | 80 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 81 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/apple,dwc3.yaml b/Documentation/devicetree/bindings/usb/apple,dwc3.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..7c8708143696faf2133c141d2a78abd3b5813979
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
+      reg = <0x82280000 0xce00>, <0x8228cd00 0x3200>;
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
index fe168477caa45799dfe07de2f54de6d6a1ce0615..0e085cb0762f765958d67be61ae0d3d773503431 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2399,6 +2399,7 @@ F:	Documentation/devicetree/bindings/power/reset/apple,smc-reboot.yaml
 F:	Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
 F:	Documentation/devicetree/bindings/spi/apple,spi.yaml
 F:	Documentation/devicetree/bindings/spmi/apple,spmi.yaml
+F:	Documentation/devicetree/bindings/usb/apple,dwc3.yaml
 F:	Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
 F:	arch/arm64/boot/dts/apple/
 F:	drivers/bluetooth/hci_bcm4377.c

-- 
2.34.1




Return-Path: <linux-kernel+bounces-860312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4698EBEFD2F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43DCE3E6B01
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740BE2E9EBB;
	Mon, 20 Oct 2025 08:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OuaRBEmw"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D622E7F2A;
	Mon, 20 Oct 2025 08:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947678; cv=none; b=D/VQAD2tmMxUkxo1rEa03Gy7M4NS0250n/mASuO5Wzk8Xs7skXfc/EbjWOPEzEKuqDbgIGXXsIJgXs7QauDy+5fNDQKtS4fnx8JD9KpqWHrMgi/eRW5mdsKvRAJTK2x4fGU+ExEWn1d+1n+zFs1MOYies1cktm6WcyC1rCjWQxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947678; c=relaxed/simple;
	bh=uGBLXgnUrlLVjDhuMDNfxA+QGBNAkCfVO4UZ7VlkCus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJfTqGtNxgDGwQcz1gtS5DrmNmKvMoeJkG2zQAC6hiVbKhs7F5GtjFgzDQLGb6yjOdasbLceJduWq4dvPXHrCKttSPjK+m6b/qrvL+UZcYPcb6WWWDDcbJUOqgdl03XW0D+Z/fT11LnzYy+QF4odH4NouC8qs1mK23j3JbTuwIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OuaRBEmw; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5969EC0AFE0;
	Mon, 20 Oct 2025 08:07:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DDFBA606D5;
	Mon, 20 Oct 2025 08:07:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8F659102F23A5;
	Mon, 20 Oct 2025 10:07:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760947670; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=FTceJ1AfG6euN/rxJqPmyPNg4jkFl17k3/UGNUrVjHo=;
	b=OuaRBEmwVuTzjo4iPDVUxe54HUPVYcBws3w5G3qRBrUSrHTOwgNX7AiDovoT262U4ssG4X
	X6creKFvGHsbE9zkaV8NSgWwxJyUqdjWfqTWLkUOR9s42w2+uZbfuNfzkiEdoveIsD7pJr
	VM7RvlXXAV9AUq26BvphwNMzo2KlaauyBHkDddtU/W/4nPiQzUX6oG4SbP3Raa2bxLPLyF
	HygeRU83Xhublz4WiTYLLOmixCP67X+v8wY3Hg03aWwxn5oftMdxWBy/WxYflsOkPXIB/u
	+B4Ke405DqfSmz6PFwWZZ2CXwSOOhD4DeyvrEL8f3jhSZTJ9acB+MvLzgWYRRQ==
From: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Hoan Tran <hoan@os.amperecomputing.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Saravana Kannan <saravanak@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v5 6/8] dt-bindings: soc: renesas: Add the Renesas RZ/N1 GPIO Interrupt Multiplexer
Date: Mon, 20 Oct 2025 10:06:42 +0200
Message-ID: <20251020080648.13452-7-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020080648.13452-1-herve.codina@bootlin.com>
References: <20251020080648.13452-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On the Renesas RZ/N1 SoC, GPIOs can generate interruptions. Those
interruption lines are multiplexed by the GPIO Interrupt Multiplexer in
order to map 32 * 3 GPIO interrupt lines to 8 GIC interrupt lines.

The GPIO interrupt multiplexer IP does nothing but select 8 GPIO
IRQ lines out of the 96 available to wire them to the GIC input lines.

Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 .../soc/renesas/renesas,rzn1-gpioirqmux.yaml  | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/renesas/renesas,rzn1-gpioirqmux.yaml

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas,rzn1-gpioirqmux.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas,rzn1-gpioirqmux.yaml
new file mode 100644
index 000000000000..1a31c11bc3b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas,rzn1-gpioirqmux.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/renesas/renesas,rzn1-gpioirqmux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/N1 SoCs GPIO Interrupt Multiplexer
+
+description: |
+   The Renesas RZ/N1 GPIO Interrupt Multiplexer multiplexes GPIO interrupt
+   lines to the interrupt controller available in the SoC.
+
+   It selects up to 8 of the 96 GPIO interrupt lines available and connect them
+   to 8 output interrupt lines.
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a06g032-gpioirqmux
+      - const: renesas,rzn1-gpioirqmux
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 0
+
+  "#interrupt-cells":
+    const: 1
+
+  interrupt-map-mask:
+    items:
+      - const: 0x7f
+
+  interrupt-map:
+    description: |
+      Specifies the mapping from external GPIO interrupt lines to the output
+      interrupts. The array has up to 8 items defining the mapping related to
+      the output line 0 (GIC 103) up to the output line 7 (GIC 110).
+
+      The child interrupt number set in arrays items is computed using the
+      following formula:
+          gpio_bank * 32 + gpio_number
+      with:
+        - gpio_bank: The GPIO bank number
+            - 0 for GPIO0A,
+            - 1 for GPIO1A,
+            - 2 for GPIO2A
+        - gpio_number: Number of the gpio in the bank (0..31)
+    minItems: 1
+    maxItems: 8
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#interrupt-cells"
+  - interrupt-map-mask
+  - interrupt-map
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    gic: interrupt-controller {
+        interrupt-controller;
+        #address-cells = <0>;
+        #interrupt-cells = <3>;
+    };
+
+    interrupt-controller@51000480 {
+        compatible = "renesas,r9a06g032-gpioirqmux", "renesas,rzn1-gpioirqmux";
+        reg = <0x51000480 0x20>;
+        #address-cells = <0>;
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0x7f>;
+        interrupt-map =
+            <32 &gic GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, /* line 0, GPIO1A.0 */
+            <89 &gic GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>, /* line 1, GPIO2A.25 */
+            <9 &gic GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>; /* line 3, GPIO0A.9 */
+    };
-- 
2.51.0



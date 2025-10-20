Return-Path: <linux-kernel+bounces-860314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B029BEFD41
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CBE93E7F86
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268762E92A6;
	Mon, 20 Oct 2025 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TyxiXm/t"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A172EA729
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947693; cv=none; b=ehX74wgHyVQd2qTz7ZmIYVz3BV78WJ3+f/xtmrI49o+VNEMvm0WiTXvZIku65ttldl2+A5QF/K30NFfowEqCtPK2WGQLJi1veG6cf807pW+RKo6UAViRaI1ngpj9HOV1yftjJQ5qk3HPJJo3bKKo1HGH0f8YwFAWmOv5FLDKNOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947693; c=relaxed/simple;
	bh=2L21Qopfly/U4b9yKtsDB4jlN3j5TDLRZmMl98kJ+LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZIqClohs9xwi3rKNZV2VkrsPcDx8+qzMPyqCa9EweAXBqYuu66Cnk9chRy6cJCdd2RBaA+w879uQK07gboeExC9NlwEYJSsNzWnISrTPsrKdNEopCELgvx+EXsWD6X46nuWUPYSZXTK2n97aZJ//f7mC68LXL6C1mPjfIjUqFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TyxiXm/t; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4326F4E411EE;
	Mon, 20 Oct 2025 08:08:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 17A74606D5;
	Mon, 20 Oct 2025 08:08:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1F488102F239E;
	Mon, 20 Oct 2025 10:08:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760947685; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=+v8XTZeq0pOdpvOANy27ZmijoxF+wc+fMdKurB1Y/rc=;
	b=TyxiXm/tltgqYMOJvaHd+RodIIPn8VuM3f4rLSKo98iXzyARLyfVefDl2PW0jGzSNhnd3d
	zc250nIn4vaayJZYFR3YnL1Vq3M6YUXKRbt3ptC2BM0QRizdA+YFtcn8ttyVRD0mTjKNuz
	1kjWHvmBSk0YVpKBzTOZs9sl7d7IOmmitLndSosxwx6Ywfw5jcJaqfo83GZ/4FvqyO7M7L
	oxqx3cgd91CrTmctmk5hzW3CCezO1AUfqW++8y+FIVwO3kryF7Hf5Wejetb6osQQvmWXkk
	GFnX/4aCeil4dnEi8sKej8r/K/8EPFvUkJYkOh8m2G1aN1RRJeyVKZR5PxqU7g==
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5 8/8] ARM: dts: r9a06g032: Add support for GPIO interrupts
Date: Mon, 20 Oct 2025 10:06:44 +0200
Message-ID: <20251020080648.13452-9-herve.codina@bootlin.com>
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

In the RZ/N1 SoC, the GPIO interrupts are multiplexed using the GPIO
Interrupt Multiplexer.

Add the multiplexer node and connect GPIO interrupt lines to the
multiplexer.

The interrupt-map available in the multiplexer node has to be updated in
dts files depending on the GPIO usage. Indeed, the usage of an interrupt
for a GPIO is board dependent.

Up to 8 GPIOs can be used as an interrupt line (one per multiplexer
output interrupt).

Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm/boot/dts/renesas/r9a06g032.dtsi | 41 ++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/renesas/r9a06g032.dtsi b/arch/arm/boot/dts/renesas/r9a06g032.dtsi
index da977cdd8487..c7196e720c6c 100644
--- a/arch/arm/boot/dts/renesas/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/renesas/r9a06g032.dtsi
@@ -534,6 +534,14 @@ gpio0a: gpio-port@0 {
 				#gpio-cells = <2>;
 				snps,nr-gpios = <32>;
 				reg = <0>;
+
+				interrupt-controller;
+				interrupt-parent = <&gpioirqmux>;
+				interrupts = < 0  1  2  3  4  5  6  7
+					       8  9 10 11 12 13 14 15
+					      16 17 18 19 20 21 22 23
+					      24 25 26 27 28 29 30 31 >;
+				#interrupt-cells = <2>;
 			};
 
 			/* GPIO0b[0..1]   connected to pins GPIO1..2   */
@@ -576,6 +584,14 @@ gpio1a: gpio-port@0 {
 				#gpio-cells = <2>;
 				snps,nr-gpios = <32>;
 				reg = <0>;
+
+				interrupt-controller;
+				interrupt-parent = <&gpioirqmux>;
+				interrupts = < 32 33 34 35 36 37 38 39
+					       40 41 42 43 44 45 46 47
+					       48 49 50 51 52 53 54 55
+					       56 57 58 59 60 61 62 63 >;
+				#interrupt-cells = <2>;
 			};
 
 			/* GPIO1b[0..1]   connected to pins GPIO55..56 */
@@ -608,6 +624,14 @@ gpio2a: gpio-port@0 {
 				#gpio-cells = <2>;
 				snps,nr-gpios = <32>;
 				reg = <0>;
+
+				interrupt-controller;
+				interrupt-parent = <&gpioirqmux>;
+				interrupts = < 64 65 66 67 68 69 70 71
+					       72 73 74 75 76 77 78 79
+					       80 81 82 83 84 85 86 87
+					       88 89 90 91 92 93 94 95 >;
+				#interrupt-cells = <2>;
 			};
 
 			/* GPIO2b[0..9] connected to pins GPIO160..169 */
@@ -620,6 +644,23 @@ gpio2b: gpio-port@1 {
 			};
 		};
 
+		gpioirqmux: interrupt-controller@51000480 {
+			compatible = "renesas,r9a06g032-gpioirqmux", "renesas,rzn1-gpioirqmux";
+			reg = <0x51000480 0x20>;
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			interrupt-map-mask = <0x7f>;
+
+			/*
+			 * Example mapping entry. Board DTs need to overwrite
+			 * 'interrupt-map' with their specific mapping. Check
+			 * the irqmux binding documentation for details.
+			 */
+			interrupt-map = <0 &gic GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+
+			status = "disabled";
+		};
+
 		can0: can@52104000 {
 			compatible = "renesas,r9a06g032-sja1000", "renesas,rzn1-sja1000";
 			reg = <0x52104000 0x800>;
-- 
2.51.0



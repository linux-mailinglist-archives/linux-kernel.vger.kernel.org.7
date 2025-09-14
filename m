Return-Path: <linux-kernel+bounces-815852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3998EB56BDC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 21:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 034AA7A7B2B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 19:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4842E543B;
	Sun, 14 Sep 2025 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="hlF+P4hg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mu937apJ"
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E052DEA73;
	Sun, 14 Sep 2025 19:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757878748; cv=none; b=ttYA/0SIwT0WaYEzpGpqXjlMQeWCiUje+Tj/yyl+agRe+fskw8CL19W58OcqWIZ7HblPBlHEAQtNtBh1XWCLwc6gKeFXen8hVKDq3zfS6PMmKECKo7JZzcbX6kzNpium5VtJRwPzKD7CIMGG9GEqqGw/WFNJwK1/KhfTel1er7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757878748; c=relaxed/simple;
	bh=ulmJ9Q9E5wPu/53catabwVrJTmiDve5jseB6PwOjhFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f9ORAfy4qE2mcJOiycceK7cbOuo9GemeSF5e8IZQtoLix6Casts31eOBQ2T8RGN/1cKIUBF5XQ8s2UWqJUoln5Bj8C0pG1gmg6/GliVkMDNDyWM/lt4jL8WIFmZ12TOEtOaNCODp/7ilRvbie+4gepk5wD1EnSeYkEPBihgegeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=hlF+P4hg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mu937apJ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BC0AE7A0129;
	Sun, 14 Sep 2025 15:39:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 14 Sep 2025 15:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757878745;
	 x=1757965145; bh=NNFFfF25lXEY7p77+bLlpT+o/t57hb4SlnKLE4oaBVA=; b=
	hlF+P4hgJWKomKFdlxJ3/QGEkLspoNnGGoLXdhQ2MrYyZjINDzgHXlp+M7vnhmTH
	qCdv2gQ9IuitD/YZ8xQUSZMIcpe/WonyqkNzViUFtCNWhKEoZ4WnuWCvDkXyU6RL
	2lMfUW4XXO06OCSqcLLsGgsEihD/hb9lhx5Ts4O7YbfUMfesdF5RATvXBM/VlYNv
	QqFZgJThEURxCovei0+Qu9rkF90D8lruTTO3kIzZY8wWvnxJtESLyWNKnnvzctrm
	aszy1MatQKzeKpA1SFt6gsyhnJ7A41Qj4CcHlHgGmBsMdJJAGidM5Um7uod+yL3b
	cdKC47oItG/FZnTgMnsmvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757878745; x=
	1757965145; bh=NNFFfF25lXEY7p77+bLlpT+o/t57hb4SlnKLE4oaBVA=; b=M
	u937apJ4SFW4Ucal+RAAosFsp1u2831wfYlfK9uImJg9w8vT5heb2ZXoByMwQiuO
	8+as0mKVHLZnkvFdXUTosHjUIyZTcgeoEjNgGLDQ+ZNWNaFYt7BbIYJqOn/B27rg
	UG2oO9LO4xE2j8i9XJSxrixF8tRrFs8OCH3guY5dZhR/9xOomwTonceWdBa24CUH
	ViSjoJKrLrS9biqno9N8n7Jk0S9rKh/3BJGtx44u+jjyOe8g55lZLJDXaWyD53zd
	y0/H12ngtBvWvy9hazpYy0d2l3IBqSrQOmmflfea7C6v2n8EHThJ/BoU6sdijBZK
	k/lEKpBuUuD1ZxAuzNAZQ==
X-ME-Sender: <xms:2RnHaKxroVjAx4-e2g9xWMsXaX8-nf1aWYcCbo4sDCMhuI6yOPv8LQ>
    <xme:2RnHaNitfvVtl55OD09AeG-FG92Di4djKsFsay-0t8jdfN-OrkKqJWeikEu_FY_WN
    NkB84fx8W3mChHlcLI>
X-ME-Received: <xmr:2RnHaHNcwBpYy7p4ujKru-6WDtFZJkBiVjzTtEu9ScHp5qx3rBdzJwciUtdmg4r_6jshQmvsFLhzbAcZPk7Njw8x1ycbbv29O7FD1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefheeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfgrnhhnvgcu
    ifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpeefhe
    ehieeludffheetiefhvddtleffuddtleduudeiudetvdefffehkeehgfettdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruh
    drnhgvthdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvrghlsehgohhmph
    grrdguvghvpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvghtpdhrtghpthhtoheprghs
    rghhiheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdgrrh
    hmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthho
    pehmrgiisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsvhgvnheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghlhihsshgrsehrohhsvghniiifvghighdrihho
X-ME-Proxy: <xmx:2RnHaAc3ZUrh4vpwSM98yipTkTWR0tGr2nal3fjzUms7KSuwzRzwxg>
    <xmx:2RnHaBz3GgfYW2UR-YMl54fe_8ZY6xuqVaumRvejUGS-Wuh_dHSGDg>
    <xmx:2RnHaF3yyTjvqm8cqtRdfSn51zcmDdmHIQMI22tJYRMmHjPaQQqRkg>
    <xmx:2RnHaIc_WPK-0pWIVbXSXxs7VVLcsVHtv_igdog0s-kC0GEHpypXeQ>
    <xmx:2RnHaFwBTmiMwRElvVKUQngMeVL1iKJrSM8J-B_tWOoXk3mAjx9poj9H>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 15:39:04 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Sun, 14 Sep 2025 21:38:48 +0200
Subject: [PATCH v2 5/6] arm64: dts: apple: Add J474s, J475c and J475d
 device trees
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250914-dt-apple-t6020-v2-5-1a738a98bb43@jannau.net>
References: <20250914-dt-apple-t6020-v2-0-1a738a98bb43@jannau.net>
In-Reply-To: <20250914-dt-apple-t6020-v2-0-1a738a98bb43@jannau.net>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Marc Zyngier <maz@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7359; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=ulmJ9Q9E5wPu/53catabwVrJTmiDve5jseB6PwOjhFc=;
 b=kA0DAAoWoRs8240vZWYByyZiAGjHGcqgLIp38IO8CSIRV+2sw3PRIytJCg8rLZdRyv147Sacv
 oh1BAAWCgAdFiEEYivpiACrfCFcfeBWoRs8240vZWYFAmjHGcoACgkQoRs8240vZWahlAD+OdwY
 is1e4dkCtjwaZ3Shn9aeJLoCsFjvjDGyESB4bRQBANqtXkdaXw1biDHV7Gbqs773X9AajSklOya
 WSPMiAw4M
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

Add device trees for the M2 Pro Mac mini and the M2 Max and Ultra
Mac Studio. These devices are very similar to the M1 Max and Ultra
Mac Studio so reuse the device template, include the .dtsi for the new
SocS and correct for the minimal differences.

Co-developed-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm64/boot/dts/apple/Makefile             |  3 ++
 arch/arm64/boot/dts/apple/t6020-j474s.dts      | 47 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t6021-j475c.dts      | 37 ++++++++++++++++++++
 arch/arm64/boot/dts/apple/t6022-j475d.dts      | 42 +++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t6022-jxxxd.dtsi     | 38 +++++++++++++++++++++
 arch/arm64/boot/dts/apple/t602x-j474-j475.dtsi | 38 +++++++++++++++++++++
 6 files changed, 205 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
index e97a6676387c6e4cbaf3b0834c4e59338d08d1b8..21c4e02a4429fa1db506dd85637a44000073590e 100644
--- a/arch/arm64/boot/dts/apple/Makefile
+++ b/arch/arm64/boot/dts/apple/Makefile
@@ -83,6 +83,9 @@ dtb-$(CONFIG_ARCH_APPLE) += t6020-j414s.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6021-j414c.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6020-j416s.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6021-j416c.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t6020-j474s.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t6021-j475c.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t6022-j475d.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8112-j413.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8112-j415.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8112-j473.dtb
diff --git a/arch/arm64/boot/dts/apple/t6020-j474s.dts b/arch/arm64/boot/dts/apple/t6020-j474s.dts
new file mode 100644
index 0000000000000000000000000000000000000000..7c7ad5b8ad189e5d04d03189a07c82426185dd7d
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6020-j474s.dts
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Mac mini (M2 Pro, 2023)
+ *
+ * target-type: J474s
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t6020.dtsi"
+
+/*
+ * This model is very similar to M1 and M2 Mac Studio models so base it on those
+ * and remove the missing SDHCI controller.
+ */
+
+#include "t602x-j474-j475.dtsi"
+
+/ {
+	compatible = "apple,j474s", "apple,t6020", "apple,arm-platform";
+	model = "Apple Mac mini (M2 Pro, 2023)";
+};
+
+/* PCIe devices */
+&wifi0 {
+	compatible = "pci14e4,4434";
+	brcm,board-type = "apple,tasmania";
+};
+
+&bluetooth0 {
+	compatible = "pci14e4,5f72";
+	brcm,board-type = "apple,tasmania";
+};
+
+/*
+ * port01 is unused, remove the PCIe sdhci0 node from t600x-j375.dtsi and adjust
+ * the iommu-map.
+ */
+/delete-node/ &sdhci0;
+
+&pcie0 {
+	iommu-map = <0x100 &pcie0_dart_0 1 1>,
+			<0x200 &pcie0_dart_2 1 1>,
+			<0x300 &pcie0_dart_3 1 1>;
+};
diff --git a/arch/arm64/boot/dts/apple/t6021-j475c.dts b/arch/arm64/boot/dts/apple/t6021-j475c.dts
new file mode 100644
index 0000000000000000000000000000000000000000..533e3577487469e868c05976013f0d89ff3faea0
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6021-j475c.dts
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Mac Studio (M2 Max, 2023)
+ *
+ * target-type: J475c
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t6021.dtsi"
+#include "t602x-j474-j475.dtsi"
+
+/ {
+	compatible = "apple,j475c", "apple,t6021", "apple,arm-platform";
+	model = "Apple Mac Studio (M2 Max, 2023)";
+};
+
+&wifi0 {
+	compatible = "pci14e4,4434";
+	brcm,board-type = "apple,canary";
+};
+
+&bluetooth0 {
+	compatible = "pci14e4,5f72";
+	brcm,board-type = "apple,canary";
+};
+
+/* enable PCIe port01 with SDHCI */
+&port01 {
+	status = "okay";
+};
+
+&pcie0_dart_1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t6022-j475d.dts b/arch/arm64/boot/dts/apple/t6022-j475d.dts
new file mode 100644
index 0000000000000000000000000000000000000000..736594544f79b5e45f6ea0c98e6c71d948ef7a43
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6022-j475d.dts
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Mac Studio (M2 Ultra, 2023)
+ *
+ * target-type: J475d
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t6022.dtsi"
+#include "t602x-j474-j475.dtsi"
+#include "t6022-jxxxd.dtsi"
+
+/ {
+	compatible = "apple,j475d", "apple,t6022", "apple,arm-platform";
+	model = "Apple Mac Studio (M2 Ultra, 2023)";
+};
+
+&framebuffer0 {
+	power-domains = <&ps_dispext0_cpu0_die1>, <&ps_dptx_phy_ps_die1>;
+};
+
+/* enable PCIe port01 with SDHCI */
+&port01 {
+	status = "okay";
+};
+
+&pcie0_dart_1 {
+	status = "okay";
+};
+
+&wifi0 {
+	compatible = "pci14e4,4434";
+	brcm,board-type = "apple,canary";
+};
+
+&bluetooth0 {
+	compatible = "pci14e4,5f72";
+	brcm,board-type = "apple,canary";
+};
diff --git a/arch/arm64/boot/dts/apple/t6022-jxxxd.dtsi b/arch/arm64/boot/dts/apple/t6022-jxxxd.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..4f7bf2ebfe397dbde6451672d74ef76fe782bcd0
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6022-jxxxd.dtsi
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Mac Pro (M2 Ultra, 2023) and Mac Studio (M2 Ultra, 2023)
+ *
+ * This file contains the parts common to J180 and J475 devices with t6022.
+ *
+ * target-type: J180d / J475d
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/* delete power-domains for missing disp0 / disp0_die1 */
+/delete-node/ &ps_disp0_cpu0;
+/delete-node/ &ps_disp0_fe;
+
+/delete-node/ &ps_disp0_cpu0_die1;
+/delete-node/ &ps_disp0_fe_die1;
+
+/* USB Type C */
+&i2c0 {
+	/* front-right */
+	hpm4: usb-pd@39 {
+		compatible = "apple,cd321x";
+		reg = <0x39>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <44 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+
+	/* front-left */
+	hpm5: usb-pd@3a {
+		compatible = "apple,cd321x";
+		reg = <0x3a>;
+		interrupt-parent = <&pinctrl_ap>;
+		interrupts = <44 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "irq";
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t602x-j474-j475.dtsi b/arch/arm64/boot/dts/apple/t602x-j474-j475.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..ee12fea5b12cb37f95d9cb531c9065403665e8ca
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t602x-j474-j475.dtsi
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Mac mini (M2 Pro, 2023) and Mac Studio (2023)
+ *
+ * This file contains the parts common to J474 and J475 devices with t6020,
+ * t6021 and t6022.
+ *
+ * target-type: J474s / J475c / J475d
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/*
+ * These models are very similar to the previous generation Mac Studio, other
+ * than GPIO indices.
+ */
+
+#include "t600x-j375.dtsi"
+
+&framebuffer0 {
+	power-domains = <&ps_dispext0_cpu0>, <&ps_dptx_phy_ps>;
+};
+
+&hpm0 {
+	interrupts = <44 IRQ_TYPE_LEVEL_LOW>;
+};
+
+&hpm1 {
+	interrupts = <44 IRQ_TYPE_LEVEL_LOW>;
+};
+
+&hpm2 {
+	interrupts = <44 IRQ_TYPE_LEVEL_LOW>;
+};
+
+&hpm3  {
+	interrupts = <44 IRQ_TYPE_LEVEL_LOW>;
+};

-- 
2.51.0



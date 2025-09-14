Return-Path: <linux-kernel+bounces-815851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1788BB56BD9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 21:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BACD189F65C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 19:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E971D2E22AB;
	Sun, 14 Sep 2025 19:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="gpEiXPOf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GGX7vSm8"
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B942E3703;
	Sun, 14 Sep 2025 19:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757878746; cv=none; b=FVgpFUainQ6OnfwQEx8ROSHdVcV+RrZ15qAe8wF0uiuckax7Ac7iszMmhHOliDEWVy78THaKLiUxKUXX7ZLTog72ZIDnLI1q7ZwAw/evhPn7UMk6x5Lo2QjGRmZQIMey1Hw1M/kvmGM/x+xXaK725PLT/t2FBbGOXUF2vhi8PYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757878746; c=relaxed/simple;
	bh=cjU+1HnKx8cMnWzT5c1Fiqdr5ZojYR69fHv87Y8LTCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G7oy9OQi3k1yKde/cXrcwzB6KUufMySFGC4xzrM13ILfrfL0kXbZGSQ06h1betIsUHzype/04CJ7ip4HptbJuWkIWmrVZ75dbVX+IEgo+pGVQpnegl5Taj764ygS96OczU9eJ/2ZhbzWm40j8QBNIQr7s2mnuwypWP4cfQHDk18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=gpEiXPOf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GGX7vSm8; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 546B61D0010D;
	Sun, 14 Sep 2025 15:39:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 14 Sep 2025 15:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757878743;
	 x=1757965143; bh=XjlapULTO6hTJfr3bvq+ZxAp5iYYz6A+cVH1XanrK1A=; b=
	gpEiXPOfS5YrtkcpVFeWma+0iDGAkK8rAop45cXNo0yr24dl6aR/CoaR2efctUpz
	VUARFxA7+B/N4NA6sABIHaUhxD80detnpCo/xqBzSM4ZLDIDWMylhs/rwTJVbrtj
	vsaeUFBxdURqvC9JAcLKZ29P3reTWmL/p5EvGYf6oh05qj1ZZ+2AKG51TSuMPaw8
	75lfLrldrBLEos5asel0+MYp5m7z9b9UMmCV1JTSGmwJtqul6PdqaW7dBwfSgvlM
	NGiodu7oCOFmFawJxtztlluscVUT9mN0yj5OCcyg3yuwLDtQEFeqfA3mPPp1+THQ
	YotXRY7pA342FYm3Q5HM4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757878743; x=
	1757965143; bh=XjlapULTO6hTJfr3bvq+ZxAp5iYYz6A+cVH1XanrK1A=; b=G
	GX7vSm8aObElQy+PxgmDeggs8H5pokOZIhC1LwIupdAmESAQXS0uFNnauQSb6bJM
	DOFBCikyYfWvoB+TXK9J+V51phdPmuMQuAxB9QleZo3+kkAGuNMhRZR1ez5GH2cn
	oOmbKQR52NJrmEo1NEt3HXm09I/E4uKC+dPUpxSsD/lD+F48y/iZHTrm0bZeWPR1
	toBkAHihQ9QaqBB9+eMhc8VtLNfGzQjxpiOgq7WI3Tocpr++Qzlovput+k73MzaG
	+vI3zE4PJIBqjZDhe+77rSOtqAjsKxcGE3hodoMcnrqChReFCwtlFoyLDaW5J+ey
	Q4CX8Rs/JOORE4LCoh8Hw==
X-ME-Sender: <xms:1xnHaMUNZIgXdgHVUg2S8Qpyx4f7gpdnXj90mM2bkCUOvzj864dncQ>
    <xme:1xnHaH0oDEZ33wb2vnVg_feELloJBN24-d2y-AXNKAtpdUa-Aqbo5B1hYXmYiPyXb
    GafS3wU4ECaf0Lzqc8>
X-ME-Received: <xmr:1xnHaLTSSalG5USPiFFj1ikhp4yWPfAnemIgpVvykSXceFxTNBizpdH_sw54Av87W3DmWy1oZKCFpBnaW8iUXiBUrllOvNb21IS4Mw>
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
X-ME-Proxy: <xmx:1xnHaLT2Ft1PAStIhg6v8yi4ytRqh7EvCqWuZSC8Gfn0iPbYQzGKjA>
    <xmx:1xnHaMUBe-jdBV9GWTqbF8EDg07Hh1aGPyanFUuNQKJ7OrUdcmg7-Q>
    <xmx:1xnHaFJSDtqVG0Kh2b7c_EkqkT9oObrAhgoXpPB6y0e55x22xNUDCA>
    <xmx:1xnHaNg4h_bXM_kwLhpGWPsj6CoT8t0CWmOcq4hN8ATjSohbEeEqGw>
    <xmx:1xnHaGGaobKKscVSXpt_tWBmcNY5v5tyo1xs3NaBBsQVPc9W3kyvhRu0>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 15:39:02 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Sun, 14 Sep 2025 21:38:47 +0200
Subject: [PATCH v2 4/6] arm64: dts: apple: Add J414 and J416 Macbook Pro
 device trees
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250914-dt-apple-t6020-v2-4-1a738a98bb43@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6075; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=oB8WY/oI9CwdJKKcWEmxl1NGWszokRrC4s3dN4D19h0=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhozjkqcKX5swaLq/9TPd8mH6dqG5zHX24Yu8zp6tODG3e
 9LlW9MvdJSyMIhxMciKKbIkab/sYFhdoxhT+yAMZg4rE8gQBi5OAZjI3ksM/x0nyBe+URdhznX6
 66Pt9fbqitac+CqGgHtXXp96zHc3eAsjQ2NK+c2kWhXBgtULrpWpXo/9N/nCNYl61TniCxpm1J/
 ayQEA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

From: Hector Martin <marcan@marcan.st>

Add device trees for the T6020 and T6021 based Macbook Pros (M2 Pro/Max,
14/16-inch). The devices are very similar to the T6000/T6001 based ones
so reuse the device templates, include the new SoCs and correct for the
minimal differences.

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Co-developed-by: Janne Grunau <j@jannau.net>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm64/boot/dts/apple/Makefile             |  4 +++
 arch/arm64/boot/dts/apple/t6020-j414s.dts      | 26 +++++++++++++++
 arch/arm64/boot/dts/apple/t6020-j416s.dts      | 26 +++++++++++++++
 arch/arm64/boot/dts/apple/t6021-j414c.dts      | 26 +++++++++++++++
 arch/arm64/boot/dts/apple/t6021-j416c.dts      | 26 +++++++++++++++
 arch/arm64/boot/dts/apple/t602x-j414-j416.dtsi | 45 ++++++++++++++++++++++++++
 6 files changed, 153 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/apple/Makefile
index df4ba8ef6213c9f7e4ef02a50d7250008977cc71..e97a6676387c6e4cbaf3b0834c4e59338d08d1b8 100644
--- a/arch/arm64/boot/dts/apple/Makefile
+++ b/arch/arm64/boot/dts/apple/Makefile
@@ -79,6 +79,10 @@ dtb-$(CONFIG_ARCH_APPLE) += t6000-j316s.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6001-j316c.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6001-j375c.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t6002-j375d.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t6020-j414s.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t6021-j414c.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t6020-j416s.dtb
+dtb-$(CONFIG_ARCH_APPLE) += t6021-j416c.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8112-j413.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8112-j415.dtb
 dtb-$(CONFIG_ARCH_APPLE) += t8112-j473.dtb
diff --git a/arch/arm64/boot/dts/apple/t6020-j414s.dts b/arch/arm64/boot/dts/apple/t6020-j414s.dts
new file mode 100644
index 0000000000000000000000000000000000000000..631c54c5f03dee9e7d37a7811f87f939e5187b10
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6020-j414s.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * MacBook Pro (14-inch, M2 Pro, 2023)
+ *
+ * target-type: J414s
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t6020.dtsi"
+#include "t602x-j414-j416.dtsi"
+
+/ {
+	compatible = "apple,j414s", "apple,t6020", "apple,arm-platform";
+	model = "Apple MacBook Pro (14-inch, M2 Pro, 2023)";
+};
+
+&wifi0 {
+	brcm,board-type = "apple,tokara";
+};
+
+&bluetooth0 {
+	brcm,board-type = "apple,tokara";
+};
diff --git a/arch/arm64/boot/dts/apple/t6020-j416s.dts b/arch/arm64/boot/dts/apple/t6020-j416s.dts
new file mode 100644
index 0000000000000000000000000000000000000000..c277ed5889a2145a4043b7f3230dbd49971d3068
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6020-j416s.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * MacBook Pro (16-inch, M2 Pro, 2023)
+ *
+ * target-type: J416s
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t6020.dtsi"
+#include "t602x-j414-j416.dtsi"
+
+/ {
+	compatible = "apple,j416s", "apple,t6020", "apple,arm-platform";
+	model = "Apple MacBook Pro (16-inch, M2 Pro, 2023)";
+};
+
+&wifi0 {
+	brcm,board-type = "apple,amami";
+};
+
+&bluetooth0 {
+	brcm,board-type = "apple,amami";
+};
diff --git a/arch/arm64/boot/dts/apple/t6021-j414c.dts b/arch/arm64/boot/dts/apple/t6021-j414c.dts
new file mode 100644
index 0000000000000000000000000000000000000000..cdcf0740714dcf71e8d0cead879bce8f27431ccf
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6021-j414c.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * MacBook Pro (14-inch, M2 Max, 2023)
+ *
+ * target-type: J414c
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t6021.dtsi"
+#include "t602x-j414-j416.dtsi"
+
+/ {
+	compatible = "apple,j414c", "apple,t6021", "apple,arm-platform";
+	model = "Apple MacBook Pro (14-inch, M2 Max, 2023)";
+};
+
+&wifi0 {
+	brcm,board-type = "apple,tokara";
+};
+
+&bluetooth0 {
+	brcm,board-type = "apple,tokara";
+};
diff --git a/arch/arm64/boot/dts/apple/t6021-j416c.dts b/arch/arm64/boot/dts/apple/t6021-j416c.dts
new file mode 100644
index 0000000000000000000000000000000000000000..6d8146b941703692a0cd92508add1784e0fc211b
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6021-j416c.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * MacBook Pro (16-inch, M2 Max, 2022)
+ *
+ * target-type: J416c
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/dts-v1/;
+
+#include "t6021.dtsi"
+#include "t602x-j414-j416.dtsi"
+
+/ {
+	compatible = "apple,j416c", "apple,t6021", "apple,arm-platform";
+	model = "Apple MacBook Pro (16-inch, M2 Max, 2023)";
+};
+
+&wifi0 {
+	brcm,board-type = "apple,amami";
+};
+
+&bluetooth0 {
+	brcm,board-type = "apple,amami";
+};
diff --git a/arch/arm64/boot/dts/apple/t602x-j414-j416.dtsi b/arch/arm64/boot/dts/apple/t602x-j414-j416.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..0e806d8ddf81b1073bfced964fa64c4e75a9e998
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t602x-j414-j416.dtsi
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * MacBook Pro (14/16-inch, 2022)
+ *
+ * This file contains the parts common to J414 and J416 devices with both t6020 and t6021.
+ *
+ * target-type: J414s / J414c / J416s / J416c
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+/*
+ * These models are essentially identical to the previous generation, other than
+ * the GPIO indices.
+ */
+
+#include "t600x-j314-j316.dtsi"
+
+&framebuffer0 {
+	power-domains = <&ps_disp0_cpu0>, <&ps_dptx_phy_ps>;
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
+&hpm5 {
+	interrupts = <44 IRQ_TYPE_LEVEL_LOW>;
+};
+
+&wifi0 {
+	compatible = "pci14e4,4434";
+};
+
+&bluetooth0 {
+	compatible = "pci14e4,5f72";
+};

-- 
2.51.0



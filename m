Return-Path: <linux-kernel+bounces-798568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10490B41FDD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD17188E576
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7780E3090DB;
	Wed,  3 Sep 2025 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BF3nfutE"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57857307482
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903685; cv=none; b=rCa5kOXhZHTAjv7DsJpiXukQKnua8bMlsGMI0dJPLApiopB/4IuXUwWZ2LG49SopoNBqSjUc4J/D0qCnMO1n2jS+Ya57BhURT6PC5OkFupCOAqQYXNfjCnHuO0XgB2wxB9ltaRNuFvtQfpw6c5653Kk4i8m0IcEbCm8BnYlp3wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903685; c=relaxed/simple;
	bh=YbkzBj87bNiH9dr8n9qI7MSjJOTkbr6y/UMdoSkgchc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b8Bp8q1uUlBZinPabhgHjG2NK/g1BeAZgFg6+m4F9G7E7vWHd/HXL6Wu32hCwP07WSuEHE3RckWUosvEcPKlrY7RYXc5SgVSgOGZwnIP57sBTPskQ1jtkytaQW+8ncD7Hzbycx0oZsZA8BiBABKTTXRssxh3H0rLUgvi2HP2Nb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BF3nfutE; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 852F04E40C0A;
	Wed,  3 Sep 2025 12:48:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5930B606C3;
	Wed,  3 Sep 2025 12:48:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C837B1C22CCD6;
	Wed,  3 Sep 2025 14:47:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756903680; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=x+dTceR5i9aJItNSeVUHs9v1PElS49Iavdx8taEX/wI=;
	b=BF3nfutEUj+Fd2eM2kLx0t4H3wEUBM82BpCgKh436gGxGMfLnym2wsqciJbmMfYIAEbHrr
	yRNNri9FM7sez2d1k2H55hDZwSRPAoW/dD34v7NTLYl6cvbsKLnS1TOsGuEe8vvxGKNPwM
	hnxVspArgSKsbjWzm0LZ0sPXNr6vS3NNN4CQnWGerlk0TVyVsiBg+/cvove0nay7H37YM0
	BC+E4ixLABpsAyk/IBw7pCfg85CqnU9xvWZ9YF5E8IGHy+pGZ7fGlAqDpkGXe5x7iDJYKD
	UL4jjl8ePyvH7tbHXnXWeTJ35HVsKnEsLjD6yXzNcZ20FD57QRhyhDNltgBdrw==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Wed, 03 Sep 2025 14:47:20 +0200
Subject: [PATCH 13/19] clk: eyeq: prefix the PLL registers with the PLL
 type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250903-clk-eyeq7-v1-13-3f5024b5d6e2@bootlin.com>
References: <20250903-clk-eyeq7-v1-0-3f5024b5d6e2@bootlin.com>
In-Reply-To: <20250903-clk-eyeq7-v1-0-3f5024b5d6e2@bootlin.com>
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Sari Khoury <sari.khoury@mobileye.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Rename the PLL registers to make room for other PLL types that are
present in the eyeQ7H.

We only prefix the register with the PLL type (FRACG), no other change.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/clk/clk-eyeq.c | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/clk-eyeq.c b/drivers/clk/clk-eyeq.c
index a0581016100c7367efb373a3fb3b7c6d51b49912..63093a3099261e6798a6752651d25efa1b3e7592 100644
--- a/drivers/clk/clk-eyeq.c
+++ b/drivers/clk/clk-eyeq.c
@@ -47,28 +47,28 @@
 #include <dt-bindings/clock/mobileye,eyeq-clk.h>
 
 /* In frac mode, it enables fractional noise canceling DAC. Else, no function. */
-#define PCSR0_DAC_EN			BIT(0)
+#define FRACG_PCSR0_DAC_EN			BIT(0)
 /* Fractional or integer mode */
-#define PCSR0_DSM_EN			BIT(1)
-#define PCSR0_PLL_EN			BIT(2)
+#define FRACG_PCSR0_DSM_EN			BIT(1)
+#define FRACG_PCSR0_PLL_EN			BIT(2)
 /* All clocks output held at 0 */
-#define PCSR0_FOUTPOSTDIV_EN		BIT(3)
-#define PCSR0_POST_DIV1			GENMASK(6, 4)
-#define PCSR0_POST_DIV2			GENMASK(9, 7)
-#define PCSR0_REF_DIV			GENMASK(15, 10)
-#define PCSR0_INTIN			GENMASK(27, 16)
-#define PCSR0_BYPASS			BIT(28)
+#define FRACG_PCSR0_FOUTPOSTDIV_EN		BIT(3)
+#define FRACG_PCSR0_POST_DIV1			GENMASK(6, 4)
+#define FRACG_PCSR0_POST_DIV2			GENMASK(9, 7)
+#define FRACG_PCSR0_REF_DIV			GENMASK(15, 10)
+#define FRACG_PCSR0_INTIN			GENMASK(27, 16)
+#define FRACG_PCSR0_BYPASS			BIT(28)
 /* Bits 30..29 are reserved */
-#define PCSR0_PLL_LOCKED		BIT(31)
+#define FRACG_PCSR0_PLL_LOCKED			BIT(31)
 
-#define PCSR1_RESET			BIT(0)
-#define PCSR1_SSGC_DIV			GENMASK(4, 1)
+#define FRACG_PCSR1_RESET			BIT(0)
+#define FRACG_PCSR1_SSGC_DIV			GENMASK(4, 1)
 /* Spread amplitude (% = 0.1 * SPREAD[4:0]) */
-#define PCSR1_SPREAD			GENMASK(9, 5)
-#define PCSR1_DIS_SSCG			BIT(10)
+#define FRACG_PCSR1_SPREAD			GENMASK(9, 5)
+#define FRACG_PCSR1_DIS_SSCG			BIT(10)
 /* Down-spread or center-spread */
-#define PCSR1_DOWN_SPREAD		BIT(11)
-#define PCSR1_FRAC_IN			GENMASK(31, 12)
+#define FRACG_PCSR1_DOWN_SPREAD			BIT(11)
+#define FRACG_PCSR1_FRAC_IN			GENMASK(31, 12)
 
 struct eqc_pll {
 	unsigned int	index;
@@ -167,29 +167,29 @@ static int eqc_pll_parse_registers(u32 r0, u32 r1, unsigned long *mult,
 {
 	u32 spread;
 
-	if (r0 & PCSR0_BYPASS) {
+	if (r0 & FRACG_PCSR0_BYPASS) {
 		*mult = 1;
 		*div = 1;
 		*acc = 0;
 		return 0;
 	}
 
-	if (!(r0 & PCSR0_PLL_LOCKED))
+	if (!(r0 & FRACG_PCSR0_PLL_LOCKED))
 		return -EINVAL;
 
-	*mult = FIELD_GET(PCSR0_INTIN, r0);
-	*div = FIELD_GET(PCSR0_REF_DIV, r0);
+	*mult = FIELD_GET(FRACG_PCSR0_INTIN, r0);
+	*div = FIELD_GET(FRACG_PCSR0_REF_DIV, r0);
 
 	/* Fractional mode, in 2^20 (0x100000) parts. */
-	if (r0 & PCSR0_DSM_EN) {
+	if (r0 & FRACG_PCSR0_DSM_EN) {
 		*div *= (1ULL << 20);
-		*mult = *mult * (1ULL << 20) + FIELD_GET(PCSR1_FRAC_IN, r1);
+		*mult = *mult * (1ULL << 20) + FIELD_GET(FRACG_PCSR1_FRAC_IN, r1);
 	}
 
 	if (!*mult || !*div)
 		return -EINVAL;
 
-	if (r1 & (PCSR1_RESET | PCSR1_DIS_SSCG)) {
+	if (r1 & (FRACG_PCSR1_RESET | FRACG_PCSR1_DIS_SSCG)) {
 		*acc = 0;
 		return 0;
 	}
@@ -204,10 +204,10 @@ static int eqc_pll_parse_registers(u32 r0, u32 r1, unsigned long *mult,
 	 *   with acc in parts per billion and,
 	 *        spread in parts per thousand.
 	 */
-	spread = FIELD_GET(PCSR1_SPREAD, r1);
+	spread = FIELD_GET(FRACG_PCSR1_SPREAD, r1);
 	*acc = spread * 500000;
 
-	if (r1 & PCSR1_DOWN_SPREAD) {
+	if (r1 & FRACG_PCSR1_DOWN_SPREAD) {
 		/*
 		 * Downspreading: the central frequency is half a
 		 * spread lower.

-- 
2.51.0



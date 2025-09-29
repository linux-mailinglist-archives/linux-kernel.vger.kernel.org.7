Return-Path: <linux-kernel+bounces-836206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9B9BA8FF2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74B564E182C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371092FFFBD;
	Mon, 29 Sep 2025 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2oEOtbS"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD9D2FF67B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145014; cv=none; b=cMGgA55uzn69lDvbVjs9BrmEl2TXZxU7tAxnyQRCL5pjALDqNRkogHgwBbHy/Ie952XVZ9QXWdeQpB03phHrnMKWtdqDIGv40klKYibxz4tCDKyV6/1GNz9pok+/zK3ZsDOp5b3A2uReQntslzEvLlUpyloH9J9xSZvBrTmbx+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145014; c=relaxed/simple;
	bh=o6GH9yM5X/l45RBwJ3B7UFsxj4Ov3IBjhVL8z/0/vWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZD4XKH/O6jRZ3gCbWp5rGQL8psOWEL8wZ2c1AyJApp5axkPwVrlSDIC7V8/O8xZcp7HA+7JdvGZSD17RuePpT2y1q8vRe9F688qWeKlbdVyGY8z1kwzKz1JR4EhLVRaMMVUjlpTwYHe5BMIZaj4L5+QgHC0fIJyZRR+OKPoOHB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2oEOtbS; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3f42b54d1b9so4417071f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759145011; x=1759749811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cHIeUtwUMwlpj/aPUYic3SGp0yyW1lvSsod+CzPmLm8=;
        b=P2oEOtbSaavfn66LK7SWH5vfedPyrqeQC1Gz5X00DD/awXDlc/hGm2rsLhd2kGwMEi
         /n+W8LEf/8TdtLDTJsv8oAGkbFps1crJ5yHHqatkg+UWzc2rkT6vd/rfLvrePSK5Vwoc
         VaW7NAN6eNdXjVf6wW6BVBUBdarnslhgnJtLw8clRSm0gjUa7gClYwNv8+xu+Z9CJ8eK
         lqu9PqIqbPMIEL+suur4S3ICA1qxmXo0ogrTbk9AXp6BJZtUgIWl41rjoW6hxKQaRRsT
         Ff8v23bI6QGsmQ/NzkbgOooTY5xLz0eA5Ia3PrOsMo/YwxkKuVAllmvUWtrG4BJtywlR
         Mk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759145011; x=1759749811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cHIeUtwUMwlpj/aPUYic3SGp0yyW1lvSsod+CzPmLm8=;
        b=FQJcb9xED/LR3iFkJB9jzftN/JFUQGI+tyUL8Pf49YDTkkhwVqhCGw4jj60kdGBZNO
         LAAGrGVWFrV2QdiP2PTJ6jkcj1lOsAt3bslDRdz9gOhnIRFj5UP5GmreGNHmkjIkasu9
         Tx3h4i0LrM3EK5D8NYDmEJlc5PFxq+ys97ejBdwKTgIPLHYAYKquQia2+rRSxr1s2zNv
         O5M9a75t3P0FgqUYipEu/a4yf6jXpfXWRnAR6pG9BKST8e8igFTFtT+BW0zzWobqkxhF
         bdNBOX2AELRmTowaZ4UTaAfRQOQlMgZ7+ix6kn3awV7IQvMfMNcCxF2swptSYumgL29t
         JzSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxdG1Z+Z/BDjaH/u1VcQ1888xW4KrW9hBzoFywuw11OQy58jCEYnVUHqCVnC8kioulW6COBCiJNAstt6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA+SiOlxluMZX9i0/optVQwr7TrGdEgKut3tTnYUqxN4XIYIdy
	W/o5o3yDB70EvlmPn9ul0R5SSMQU/iHOAgECb+hSiaqkvYruD+JLSZEM
X-Gm-Gg: ASbGncuaFw5oT/NWCGZKHE/jzv2yLSKjRQpH9Wv6ktD7PmFvaMLAOBYgZEi1WZIeQdT
	bKTqixrEOZX7NAnL8J5SM2iMseRErNVxt2QmN9lnDEjkUQbHJG357c5shQBOIGAVgu8H6E3MaDJ
	aD5cmWIxphKx3Eu2vw5e47OF46hgc9VK0j72vJrXuoosSbFwQ2O9onZbDUDiPaQE4EGVDhuaPO5
	YJWw/OakIA33fg4cr3iyxPJqRbbJQZBDDIE3beEDTWehLhyOYvbr4vjbk/1MhJNinnBrUTRWmzO
	GkbV3v4XkyHUrekgDTeksf2wahxP7eLOsj4T4feF4lSgoc1SlaihT+u8BH4xb4tzwScak+woQ6C
	puzKH9dwCGQnwQ8aVYyLvlZExsD0qxl5jfPoPYP4htZnuPvL9El7SH2JGgO9+Xksg6A==
X-Google-Smtp-Source: AGHT+IF7t6Y5sr/tULnaPZaeuk2hwGoBeQF4vR7bTyautiXiyjXn+xefZSwap9LxXcjToXlLJXaF7A==
X-Received: by 2002:a5d:588d:0:b0:3e9:d9bd:5043 with SMTP id ffacd0b85a97d-40e3ab8747emr14437342f8f.0.1759145010463;
        Mon, 29 Sep 2025 04:23:30 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:6614:1d02:ab7a:3f9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-41f00aebdb7sm5143046f8f.57.2025.09.29.04.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 04:23:29 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4] clk: renesas: cpg-mssr: Add module reset support for RZ/T2H
Date: Mon, 29 Sep 2025 12:23:24 +0100
Message-ID: <20250929112324.3622148-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add support for module reset handling on the RZ/T2H SoC. Unlike earlier
CPG/MSSR variants, RZ/T2H uses a unified set of Module Reset Control
Registers (MRCR) where both reset and deassert actions are done via
read-modify-write (RMW) to the same register.

Introduce a new MRCR offset table (mrcr_for_rzt2h) for RZ/T2H and assign
it to reset_regs. For this SoC, the number of resets is based on the
number of MRCR registers rather than the number of module clocks. Also
add cpg_mrcr_reset_ops to implement reset, assert, and deassert using RMW
while holding the spinlock. This follows the RZ/T2H requirements, where
processing after releasing a module reset must be secured by performing
seven dummy reads of the same register, and where a module that is reset
and released again must ensure the target bit in the Module Reset Control
Register is set to 1.

Update the reset controller registration to select cpg_mrcr_reset_ops for
RZ/T2H, while keeping the existing cpg_mssr_reset_ops for other SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3->v4:
- Renamed cpg_mrcr_set_bit() to cpg_mrcr_set_reset_state() for clarity.
- Updated the parameters in cpg_mrcr_set_reset_state().

v2->v3:
- Simplifed the code by adding a common function cpg_mrcr_set_bit() to handle
  set/clear of bits with options for verify and dummy reads.
- Added a macro for the number of dummy reads required.

v1->v2:
- Added cpg_mrcr_reset_ops for RZ/T2H specific handling
- Updated commit message
---
 drivers/clk/renesas/renesas-cpg-mssr.c | 111 ++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index de1cf7ba45b7..fcb2c3c22f87 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -40,6 +40,8 @@
 #define WARN_DEBUG(x)	do { } while (0)
 #endif
 
+#define RZT2H_RESET_REG_READ_COUNT	7
+
 /*
  * Module Standby and Software Reset register offets.
  *
@@ -137,6 +139,22 @@ static const u16 srcr_for_gen4[] = {
 	0x2C60, 0x2C64, 0x2C68, 0x2C6C, 0x2C70, 0x2C74,
 };
 
+static const u16 mrcr_for_rzt2h[] = {
+	0x240,	/* MRCTLA */
+	0x244,	/* Reserved */
+	0x248,	/* Reserved */
+	0x24C,	/* Reserved */
+	0x250,	/* MRCTLE */
+	0x254,	/* Reserved */
+	0x258,	/* Reserved */
+	0x25C,	/* Reserved */
+	0x260,	/* MRCTLI */
+	0x264,	/* Reserved */
+	0x268,	/* Reserved */
+	0x26C,	/* Reserved */
+	0x270,	/* MRCTLM */
+};
+
 /*
  * Software Reset Clearing Register offsets
  */
@@ -736,6 +754,72 @@ static int cpg_mssr_status(struct reset_controller_dev *rcdev,
 	return !!(readl(priv->pub.base0 + priv->reset_regs[reg]) & bitmask);
 }
 
+static int cpg_mrcr_set_reset_state(struct reset_controller_dev *rcdev,
+				    unsigned long id, bool set)
+{
+	struct cpg_mssr_priv *priv = rcdev_to_priv(rcdev);
+	unsigned int reg = id / 32;
+	unsigned int bit = id % 32;
+	u32 bitmask = BIT(bit);
+	void __iomem *reg_addr;
+	unsigned long flags;
+	unsigned int i;
+	u32 val;
+
+	dev_dbg(priv->dev, "%s %u%02u\n", set ? "assert" : "deassert", reg, bit);
+
+	spin_lock_irqsave(&priv->pub.rmw_lock, flags);
+
+	reg_addr = priv->pub.base0 + priv->reset_regs[reg];
+	/* Read current value and modify */
+	val = readl(reg_addr);
+	if (set)
+		val |= bitmask;
+	else
+		val &= ~bitmask;
+	writel(val, reg_addr);
+
+	/*
+	 * For secure processing after release from a module reset, dummy read
+	 * the same register at least seven times.
+	 */
+	for (i = 0; !set && i < RZT2H_RESET_REG_READ_COUNT; i++)
+		readl(reg_addr);
+
+	/* Verify the operation */
+	val = readl(reg_addr);
+	if ((set && !(bitmask & val)) || (!set && (bitmask & val))) {
+		dev_err(priv->dev, "Reset register %u%02u operation failed\n", reg, bit);
+		spin_unlock_irqrestore(&priv->pub.rmw_lock, flags);
+		return -EIO;
+	}
+
+	spin_unlock_irqrestore(&priv->pub.rmw_lock, flags);
+
+	return 0;
+}
+
+static int cpg_mrcr_reset(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	int ret;
+
+	ret = cpg_mrcr_set_reset_state(rcdev, id, true);
+	if (ret)
+		return ret;
+
+	return cpg_mrcr_set_reset_state(rcdev, id, false);
+}
+
+static int cpg_mrcr_assert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	return cpg_mrcr_set_reset_state(rcdev, id, true);
+}
+
+static int cpg_mrcr_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	return cpg_mrcr_set_reset_state(rcdev, id, false);
+}
+
 static const struct reset_control_ops cpg_mssr_reset_ops = {
 	.reset = cpg_mssr_reset,
 	.assert = cpg_mssr_assert,
@@ -743,6 +827,13 @@ static const struct reset_control_ops cpg_mssr_reset_ops = {
 	.status = cpg_mssr_status,
 };
 
+static const struct reset_control_ops cpg_mrcr_reset_ops = {
+	.reset = cpg_mrcr_reset,
+	.assert = cpg_mrcr_assert,
+	.deassert = cpg_mrcr_deassert,
+	.status = cpg_mssr_status,
+};
+
 static int cpg_mssr_reset_xlate(struct reset_controller_dev *rcdev,
 				const struct of_phandle_args *reset_spec)
 {
@@ -760,11 +851,23 @@ static int cpg_mssr_reset_xlate(struct reset_controller_dev *rcdev,
 
 static int cpg_mssr_reset_controller_register(struct cpg_mssr_priv *priv)
 {
-	priv->rcdev.ops = &cpg_mssr_reset_ops;
+	/*
+	 * RZ/T2H (and family) has the Module Reset Control Registers
+	 * which allows control resets of certain modules.
+	 * The number of resets is not equal to the number of module clocks.
+	 */
+	if (priv->reg_layout == CLK_REG_LAYOUT_RZ_T2H) {
+		priv->rcdev.ops = &cpg_mrcr_reset_ops;
+		priv->rcdev.nr_resets = ARRAY_SIZE(mrcr_for_rzt2h) * 32;
+	} else {
+		priv->rcdev.ops = &cpg_mssr_reset_ops;
+		priv->rcdev.nr_resets = priv->num_mod_clks;
+	}
+
 	priv->rcdev.of_node = priv->dev->of_node;
 	priv->rcdev.of_reset_n_cells = 1;
 	priv->rcdev.of_xlate = cpg_mssr_reset_xlate;
-	priv->rcdev.nr_resets = priv->num_mod_clks;
+
 	return devm_reset_controller_register(priv->dev, &priv->rcdev);
 }
 
@@ -1169,6 +1272,7 @@ static int __init cpg_mssr_common_init(struct device *dev,
 		priv->control_regs = stbcr;
 	} else if (priv->reg_layout == CLK_REG_LAYOUT_RZ_T2H) {
 		priv->control_regs = mstpcr_for_rzt2h;
+		priv->reset_regs = mrcr_for_rzt2h;
 	} else if (priv->reg_layout == CLK_REG_LAYOUT_RCAR_GEN4) {
 		priv->status_regs = mstpsr_for_gen4;
 		priv->control_regs = mstpcr_for_gen4;
@@ -1265,8 +1369,7 @@ static int __init cpg_mssr_probe(struct platform_device *pdev)
 		goto reserve_exit;
 
 	/* Reset Controller not supported for Standby Control SoCs */
-	if (priv->reg_layout == CLK_REG_LAYOUT_RZ_A ||
-	    priv->reg_layout == CLK_REG_LAYOUT_RZ_T2H)
+	if (priv->reg_layout == CLK_REG_LAYOUT_RZ_A)
 		goto reserve_exit;
 
 	error = cpg_mssr_reset_controller_register(priv);
-- 
2.51.0



Return-Path: <linux-kernel+bounces-824713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2CAB89F95
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98AFFA80143
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2083030EF9A;
	Fri, 19 Sep 2025 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="VGS1tB3a"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8359311598;
	Fri, 19 Sep 2025 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292111; cv=none; b=sdAbZSjCp9o3BoNyDjMRcViVpSF5sj9DPxPqCp4sy86huyaZ1l2e/7r3Q5JI7fTpyATtl2BcVvS4GZ8rv7Kc21AEGBtxx2dyaRklsfYp9pXoR3kRug+mU86Iu2hw1IfyI75c19JTNdc/D31NPMA3FtkNCj4DusZO9vtmjicLkSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292111; c=relaxed/simple;
	bh=n1QnYDVCfHltlrVwLHzffulyUTZaDsxj2VCKz6sGX0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6tam5Af1chebZzkTgBEkgJKwzhrzM/P05zogxc0Gq8nd37EWUYKC8IZH5Obop8C5xmGQScJ5+4bT2Je/pXqIUSPGEafywejE6fXuXJyoKDgfngrRe8Nrj2syoNajB+IxRaHoqTpFWWpJtXBUCkU4Ek3HO+EyjduwZ3cKYqNTqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=VGS1tB3a; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 9500420CA1;
	Fri, 19 Sep 2025 16:28:28 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tSjKgGo6epkK; Fri, 19 Sep 2025 16:28:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1758292108; bh=n1QnYDVCfHltlrVwLHzffulyUTZaDsxj2VCKz6sGX0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VGS1tB3aQwDZB70EIbUG5O5mhxHj6j5XQ0/aEEmVE3BSht6uczZiSnLhYXcikkbaj
	 LjGS3Eq677BSSnIWRNLWPNPwyUJcwgXoMQhbEDPFH9Hhbl46Ffp5+MI714ktzm/4qM
	 Uios1HSKWREG1ilyZUIXijN/KM7+gPw0WkK86u4GVQqM3jOb+5ts8/bIio2HzRYTrL
	 1ydPwnN+1ocuz+ep1ZKVVkVO6FLnX4J8vXkMDYRehfaziyzHITFldCdb38dGHh9Snc
	 YQnwRhfn1kD74Ou1wDXhdz+W58qw6VEFa7jeWkh+meCUzBuwI1jMWeCq1M17wo0y2h
	 RIJi1fEaX/rwA==
From: Yao Zi <ziyao@disroot.org>
To: Yinbo Zhu <zhuyinbo@loongson.cn>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v4 3/8] clk: loongson2: Support scale clocks with an alternative mode
Date: Fri, 19 Sep 2025 14:26:44 +0000
Message-ID: <20250919142649.58859-4-ziyao@disroot.org>
In-Reply-To: <20250919142649.58859-1-ziyao@disroot.org>
References: <20250919142649.58859-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LS2K0300 and LS2K1500 ship scale clocks with an alternative mode.
There's one mode bit in clock configuration register indicating the
operation mode.

When mode bit is unset, the scale clock acts the same as previous
generation of scale clocks. When it's set, a different equation for
calculating result frequency, Fout = Fin / (scale + 1), is used.

This patch adds frequency calculation support for the scale clock
variant. A helper macro, CLK_SCALE_MODE, is added to simplify
definitions.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/clk/clk-loongson2.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-loongson2.c b/drivers/clk/clk-loongson2.c
index cc3fb13e770f..bba97270376c 100644
--- a/drivers/clk/clk-loongson2.c
+++ b/drivers/clk/clk-loongson2.c
@@ -42,6 +42,7 @@ struct loongson2_clk_data {
 	u8 div_width;
 	u8 mult_shift;
 	u8 mult_width;
+	u8 bit_idx;
 };
 
 struct loongson2_clk_board_info {
@@ -96,6 +97,19 @@ struct loongson2_clk_board_info {
 		.div_width	= _dwidth,			\
 	}
 
+#define CLK_SCALE_MODE(_id, _name, _pname, _offset,		\
+		  _dshift, _dwidth, _midx)			\
+	{							\
+		.id		= _id,				\
+		.type		= CLK_TYPE_SCALE,		\
+		.name		= _name,			\
+		.parent_name	= _pname,			\
+		.reg_offset	= _offset,			\
+		.div_shift	= _dshift,			\
+		.div_width	= _dwidth,			\
+		.bit_idx	= _midx + 1,			\
+	}
+
 #define CLK_GATE(_id, _name, _pname, _offset, _bidx)		\
 	{							\
 		.id		= _id,				\
@@ -243,13 +257,18 @@ static const struct clk_ops loongson2_pll_recalc_ops = {
 static unsigned long loongson2_freqscale_recalc_rate(struct clk_hw *hw,
 						     unsigned long parent_rate)
 {
-	u64 val, mult;
+	u64 val, scale;
+	u32 mode = 0;
 	struct loongson2_clk_data *clk = to_loongson2_clk(hw);
 
 	val  = readq(clk->reg);
-	mult = loongson2_rate_part(val, clk->div_shift, clk->div_width) + 1;
+	scale = loongson2_rate_part(val, clk->div_shift, clk->div_width) + 1;
+
+	if (clk->bit_idx)
+		mode = val & BIT(clk->bit_idx - 1);
 
-	return div_u64((u64)parent_rate * mult, 8);
+	return mode == 0 ? div_u64((u64)parent_rate * scale, 8) :
+			   div_u64((u64)parent_rate, scale);
 }
 
 static const struct clk_ops loongson2_freqscale_recalc_ops = {
@@ -284,6 +303,7 @@ static struct clk_hw *loongson2_clk_register(struct loongson2_clk_provider *clp,
 	clk->div_width	= cld->div_width;
 	clk->mult_shift	= cld->mult_shift;
 	clk->mult_width	= cld->mult_width;
+	clk->bit_idx	= cld->bit_idx;
 	clk->hw.init	= &init;
 
 	hw = &clk->hw;
-- 
2.50.1



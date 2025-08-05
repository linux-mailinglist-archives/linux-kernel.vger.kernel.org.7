Return-Path: <linux-kernel+bounces-756631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E75DB1B70D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158CD168D69
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155862797AE;
	Tue,  5 Aug 2025 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="axLbpURP"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B80273805;
	Tue,  5 Aug 2025 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406273; cv=none; b=k0q2BjXf6UraXOJawRR8HHD4XgBEPDAKYpQl1jINCjWElkZC3hea62pdrjcbL2sWYJw7xagmT+58TmSurUuVbvEKmo0+bStYDxV8mf7NPaUGIlF8tv5XrCWNvMkbrZYSMEoMSLtwIb9KQcqRAorF5zXntUEd2JwwhavvOvFs0Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406273; c=relaxed/simple;
	bh=vWymD5YE3JfeQfyR3NVLfRHmsx4EBqNPAgdwvWcHF00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ov/a17DN21yvLDjhSxjhRvrzWVOXeSdlhWKFqHUryUdHv7HwdwaNkCeBKdhOHFvysCTXthoDarjzja8WdPzQK7eSShgvB+0WE2jrWaLTRvVyEN7Qj/ifq4I7TrkgIHT3ApwHnPAjpLwLwLFy0Mf5WRtKViSC7z8pROZhGeNCiss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=axLbpURP; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B3B5920012;
	Tue,  5 Aug 2025 17:04:30 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jagGzta6IOGh; Tue,  5 Aug 2025 17:04:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754406270; bh=vWymD5YE3JfeQfyR3NVLfRHmsx4EBqNPAgdwvWcHF00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=axLbpURPFc6nGaIgHXQweXVHSSmL8sq23L0dr+yTbSIXy2PA/n5uDXKtpyckx2m7i
	 Oh0HVjXSrsG2Ib4FCKkudDdLhwO/5wJKPLfvpPwAABbeYP/xO7561YNZBQZaQH7zFW
	 xX2Sz+SIl8Eah6pahywaYum4SJkgqBZ4wMXyMYlUbIPSW0MUc6A7LmN5wxnsqSlLnw
	 O/a1mvB9MJw1umDlQsSYMRN8X5mKqeM8KahcednGPsTLHM1D4IXStiMo0j4Z6p/ODg
	 HHs83dqAAIrs9/D87RLxoFuFcn5RHW13VKW4syZMCFExsKL/EOjCIu5Fy7vUbPa5jl
	 WpNSO/VLK7XwA==
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
Subject: [PATCH v3 3/8] clk: loongson2: Support scale clocks with an alternative mode
Date: Tue,  5 Aug 2025 15:01:42 +0000
Message-ID: <20250805150147.25909-4-ziyao@disroot.org>
In-Reply-To: <20250805150147.25909-1-ziyao@disroot.org>
References: <20250805150147.25909-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Loongson 2K0300 and 2K1500 ship scale clocks with an alternative mode.
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



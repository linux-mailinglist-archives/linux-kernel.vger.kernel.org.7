Return-Path: <linux-kernel+bounces-762830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 113B5B20B32
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 053384E36EB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729FD23BD0E;
	Mon, 11 Aug 2025 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="DGH2nRgR"
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79535233715;
	Mon, 11 Aug 2025 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921105; cv=none; b=eAdNEpHy2Cs9Pxqv5kpMkLoFJZlKgF+OgbG4UO0gFzX+s3GzyYwQqQWtpvVbhZp6ufjovAhRr6ueAagIHKW1zjxh+N2NjwGDefoH6SLlmMuubdJ981O1j01Hns8oic4xFf7K8mF4ml+RMO20q/w215P00T4phmuiQkIRAZPuUV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921105; c=relaxed/simple;
	bh=i8wU+l87tRxkjkfc5X201U4kzijJu18Cxdb+J92Erc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gK0anpH088oeoXNdUCiwcIWcZI5ulPmyna9FbNYhVNvBPJEnhGKyIdQf87HgTxXbsozKk5PqWF1X5q7kw69/tUMfWTleXyQ1Wg864391g21W5q+JBgJdt8J25JKRDGEOdm6L8VJmqyN9iuItpQXl5AH3ScRsXPymzqogrbK8Or0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=DGH2nRgR; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1754921087;
	bh=wb4h/OzfiqKCugrfopSTO9j+qCnAteCd8FPyFMBUIrg=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=DGH2nRgR4hXl9hLuExezpROCW2ZLA8j1FDnPD/UH9qq+1OvRqIDp6uGy8yhg5RYyD
	 /RzhaGL5SdDk6dyFivq8qnpBL1HwQBQChvvCW2ZIB2i43GKLJrb2Hv8rrNwc465+4x
	 dH/HUxbZpRGVKEhU3yDoH7KefVxArlVxeWrQQPhc=
X-QQ-mid: zesmtpip3t1754921086t50d3704e
X-QQ-Originating-IP: JMkenniBoL8H4OuTkxR7yA/i0LlRFQMennh9ZMVZn1g=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 Aug 2025 22:04:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14415561950656257543
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Mon, 11 Aug 2025 22:04:29 +0800
Subject: [PATCH v2 3/4] clk: spacemit: introduce factor for div clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-k1-clk-i2s-generation-v2-3-e4d3ec268b7a@linux.spacemit.com>
References: <20250811-k1-clk-i2s-generation-v2-0-e4d3ec268b7a@linux.spacemit.com>
In-Reply-To: <20250811-k1-clk-i2s-generation-v2-0-e4d3ec268b7a@linux.spacemit.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>, 
 Inochi Amaoto <inochiama@outlook.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Jinmei Wei <weijinmei@linux.spacemit.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754921074; l=2765;
 i=troy.mitchell@linux.spacemit.com; s=20250712; h=from:subject:message-id;
 bh=i8wU+l87tRxkjkfc5X201U4kzijJu18Cxdb+J92Erc8=;
 b=5bYOJwOIPnJ/yb9gowQbTXUnpNhSF41jaer7Ec5uqwQ4SUs2RhfWuZYmkUBZV0RJlUF22yTdI
 f9QrHsd/QeiAx6X4tRJQwIKyGruc31IuNhBS+tahC7EoeXzknkZDTIm
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=zhRP1xE0bftrurqSWI+SzcSdJGIZ0BTTY9Id0ESzqlI=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MT2+grFT7YMrE87ljq9KG5N/MqSGuuFmBMEHpt2cgwzmXLZzhTPPhi3G
	UanISi74r4OA+MJ3j1kWvfEjkgHu4+4yrFsxXB3b82lZ0RDjF78ZFLbl4DjVppcgcaxfvJI
	6TYNKfoCkK9uuVHKo68OvW/5UrWBAIcOcM81Ef7SQ6aaWXQJqd3RxpZLvJDeH8TwtCJvmFd
	1UATqpia7ciZQ5XDE3KCq0SvQlPqrjxlWv8IPN8o17fLmU490/r3B9Z9SXQgTq+UrshyWSU
	kGDbKlwRSE91agO5JoIubdTbMC5L1oSXChz0XnXgMj0g8ltWqFD+5Sx4kREkpjCGXlFDvOh
	1j93om0wg/z4/KqfvwUUp3xa/JGzczVeCJ+KtmDtxeEi8Xxl0eHJers9MEgmlj5KIkl4BTy
	dWHoblQDCr/SSG8pMp50H6I+x9iLSTrsPLXLCgFXNSR/h0uQie8P4OiLfsT8Ap2WCFzOjaQ
	oq/HdBlSGj+4oIDgC0xrIHLzcmZ20pRGl+8vXXAWS5zstICIP2KZS7udhv2WHc/YojJGqAu
	R8/9mnQBh4muRxl4MDsS/qoDKiDPTb1E2gX8P4P6Ie7PZclo+AJPLxchEd7e+bVxEWrpCpQ
	IP/EEhnu+4R0tUsqGAfa2JH0b2nCucW37vKYCA023nKz3N3he3Y96zTIHmqFjqTX0ih3FNz
	7tG2jT4Zr5cnpRjirwjn4p1Y5ewlQGtw8jaunolOUfe2R48jh6aQNtJK6m+wgtdsBaX2/Mf
	xz2RcgIPtWFzUVqg3mwerbQIQ+yGuhKtfFrcWi1k7OZnYry7zHzw8VgpL87X2CNS6ibhx6i
	gYMQVwxULCapa8rbULFYqbhorE+wskEFS6baGO0S0hgzJKG/kz5aJp962E0Oy21LCwBN41O
	S1ggLVHGj5wjAKMZZoQ58+YCMcLeDh0va6T8LXcU4OwkE5+Ruzcfz3N/9YI2WP0EefFIqiQ
	n/tdPCPp16TQDaB2Fp7YMrGP504gCuNY6oM5Rv6PbfiSkLGTtQgm5Yfbn9CrYMhQmLhyJvs
	QTyu8LaFwdeYVN2LB1SGm5OOuJUkAk1aSJExQsN0J5u1XJwfPpSpc4K789S8ZNl1K4GnR+t
	lxygSqLSRe+GUFHL0m+LReDI2viSitITl5ijb14nitmAsII1q47P7UTqWxOgbPreg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

From the definition of register, The i2s_bclk is a non-linear,
discrete divider clock.

The following table shows the correspondence between index
and frequency division coefficients:

| index |  div  |
|-------|-------|
|   0   |   2   |
|   1   |   4   |
|   2   |   6   |
|   3   |   8   |

But from a software perspective and this table, dividing the
actual div value by 2 is sufficient to obtain a continuous
divider clock.

Rather than introducing a new clock type to handle this case,
a factor parameter has been added to CCU_DIV_GATE_DEFINE.

Suggested-by: Haylen Chu <heylenay@4d2.org>
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 drivers/clk/spacemit/ccu_mix.c | 7 ++++++-
 drivers/clk/spacemit/ccu_mix.h | 4 +++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/spacemit/ccu_mix.c b/drivers/clk/spacemit/ccu_mix.c
index 9b852aa61f78aed5256bfe6fc3b01932d6db6256..dbd2cf234bf81d8e110b19868ff9af7373e2ab55 100644
--- a/drivers/clk/spacemit/ccu_mix.c
+++ b/drivers/clk/spacemit/ccu_mix.c
@@ -56,7 +56,10 @@ static unsigned long ccu_div_recalc_rate(struct clk_hw *hw,
 	val = ccu_read(&mix->common, ctrl) >> div->shift;
 	val &= (1 << div->width) - 1;
 
-	return divider_recalc_rate(hw, parent_rate, val, NULL, 0, div->width);
+	if (!div->factor)
+		return divider_recalc_rate(hw, parent_rate, val, NULL, 0, div->width);
+
+	return divider_recalc_rate(hw, parent_rate, val, NULL, 0, div->width) / div->factor;
 }
 
 /*
@@ -115,6 +118,8 @@ ccu_mix_calc_best_rate(struct clk_hw *hw, unsigned long rate,
 
 		for (int j = 1; j <= div_max; j++) {
 			unsigned long tmp = DIV_ROUND_CLOSEST_ULL(parent_rate, j);
+			if (mix->div.factor)
+				tmp /= mix->div.factor;
 
 			if (abs(tmp - rate) < abs(best_rate - rate)) {
 				best_rate = tmp;
diff --git a/drivers/clk/spacemit/ccu_mix.h b/drivers/clk/spacemit/ccu_mix.h
index 54d40cd39b2752260f57d2a96eb8d3eed8116ecd..7dd00d24ec4b1dab70663b9cb7b9ebb02abeaecb 100644
--- a/drivers/clk/spacemit/ccu_mix.h
+++ b/drivers/clk/spacemit/ccu_mix.h
@@ -34,6 +34,7 @@ struct ccu_mux_config {
 struct ccu_div_config {
 	u8 shift;
 	u8 width;
+	unsigned int factor;
 };
 
 struct ccu_mix {
@@ -130,10 +131,11 @@ static struct ccu_mix _name = {							\
 }
 
 #define CCU_DIV_GATE_DEFINE(_name, _parent, _reg_ctrl, _shift, _width,		\
-			    _mask_gate,	_flags)					\
+			    _mask_gate,	_factor, _flags)			\
 static struct ccu_mix _name = {							\
 	.gate	= CCU_GATE_INIT(_mask_gate),					\
 	.div	= CCU_DIV_INIT(_shift, _width),					\
+	.div.factor = _factor,						\
 	.common = {								\
 		.reg_ctrl	= _reg_ctrl,					\
 		CCU_MIX_INITHW(_name, _parent, spacemit_ccu_div_gate_ops,	\

-- 
2.50.1



Return-Path: <linux-kernel+bounces-774702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BBEB2B65A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6CF1893B41
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65A222579E;
	Tue, 19 Aug 2025 01:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="jyTix/ku"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EFC1F03C5;
	Tue, 19 Aug 2025 01:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567339; cv=none; b=V+KlT/dfPZONVS+ueTWUl/cgAA44fLPXiXuHXil+iLHqHJwPB6lViZZdonHddEktyWESnWz2tsktNKKW0aqTMV8LKq3OMnEb/KtcsVuyyvVgTkqx2j/zkk+p6blg5I/EIKUuqapR8atle3ZEL146qPWsCWM0DWydY97jNGjCTHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567339; c=relaxed/simple;
	bh=wdMPiVIeJsJzFwdu5LLU9FO4SL7n/gJ/QmRKRGDI5Co=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pIV/7YXm4ftWE67dUFrEbAXLGnQcY+tcpEGLZ4hezmQpDlhpO68lPnl4uGU4brbUTJsLQJP5/l96If6O5DrrVZrm8JB2CvzsE3HszuGcnPq6lE4an3rL+ufP71cxQhR4j6G2y5i2HvumqgHWfBul8Jluj0Zx0zodUZAtU2wKHsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=jyTix/ku; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755567325;
	bh=fgMPbHla/RHj3NVfFAEZIZq6Vq/k5kuht5xvr+kXOT0=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=jyTix/kuLgR+700TPPDZiPW/RyP2UEQngj9FnKwJyhXciKWaCGDTf5dclP6NF3AhD
	 6yfixNk2/o54JUPwT4LELLE6xSrS0+lluNe1VieI/wnVKwDqn3bc/cMSyBFxmcEknu
	 AC+G0CGc2b3jGCmXfPifgGQ+rD7heZSs/mMsbgOA=
X-QQ-mid: zesmtpgz9t1755567324tc7ddb23a
X-QQ-Originating-IP: A3TFw07MyzdE9155DEy/FetY79CGxV5ka6P9joBSQeA=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 19 Aug 2025 09:35:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4631062309127417572
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Tue, 19 Aug 2025 09:35:10 +0800
Subject: [PATCH v4 2/3] clk: spacemit: introduce pre-div for ddn clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-k1-clk-i2s-generation-v4-2-80174edd04eb@linux.spacemit.com>
References: <20250819-k1-clk-i2s-generation-v4-0-80174edd04eb@linux.spacemit.com>
In-Reply-To: <20250819-k1-clk-i2s-generation-v4-0-80174edd04eb@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755567312; l=4272;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=wdMPiVIeJsJzFwdu5LLU9FO4SL7n/gJ/QmRKRGDI5Co=;
 b=Q96ug52EU2Of0CxnUDnM1QxIBiIB6dMVI3LNmdn95jtmBy6J49sjtf0UQlZIK6LCsXkS7hvlT
 GShMocafTUADz1shi8qPp6VGkCF/l6kJst+nFIuet3CgGN9G0euqG2j
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MfNNfhyevLfQqjeUwZbVBIIDq6L92UOAHS14XXAgE0QP9uejH1UBTkUQ
	tqZK5bxSKEcp8F0FD35Qoibvx0Qa4GemoDFRw3TAXgoqKaCWhbjnQdwnq5lWkbKw8D/JKHe
	p+SaPJPz8zgv77BfofgNKsmNv951Xk1w4o5aO6JOsKt1tTJ+MltAb2ytymdViStSbpw8Qk3
	amzPSa7hTP8Mc7mCQUzzu7bVrZmTg9+WlXrXKI4Q2jwSy/kKFKLCgtk6CN6R1qMk8yyY7Cx
	vitex0w3taNRKFy0OPE9zMYqVcgbCr2bp+M7ypTbeUEV9G5EKEwGoq8mTZ2SWAnZHVGrH9c
	V1lQrt7ePqZgzX3f3tKZFsSW5Zz3ELnMinjznGSzyrrYexs+p9+i9nB6RhAMANBi2kAezyf
	k2GYvRaw4spMD4M2zqoMZeX1mpjsTUcYRQY3z8CBjhWKTafnC3kGrDvVF4r6+mNc8f7I7Sb
	E8JpibhhrON1DnN3e7GyZvjAZcJgnEgYcI/0bl6/HEn1PiHasGX5lxqsOfeXH8zBGWO9N+t
	6XwZgBxFZccko/U3o/hlHKg9gxnxPZwJMYTiKgoznWu9z/ktmTvre+2FB8NQ0ZcbCpHEM9a
	+VP99cNl+rTeKtExmtgrw0fUEafODB+dia6Jx2mCffWQw49FYLWCBfriD5DdATcCeXYU5Mo
	q+ucr2ya9uuCfLAW9mWiaLHH1aJnOAkIes/dcSFelmVEsxF52XRdTO4OKk4o9VDTY4dN2Uu
	Jsdjwz4b1c2gnMKbsxPY6gFzx5tf/KTSt4AhBoQ+QI7rjxxQNl2mY2Az9HO5XrfTNsWV5j4
	j/19c0IyP4wegbLvCzOug3F1gAeWU4pHE+C01vjK0nIZ2TRkr/7y6sUHCK8chQqk+s6aCfz
	gx7otbpVdG7owUb+h7y/A9qSkwz5NaEcXwnCHrzNtmeQvQ+Ah7oM4+5r0Jg30llFlwUrPKw
	ZtQ/ckekgh6/6FnpiPrOZSEmHpBleuX2ya7COfFRdB2z2Nl34yHC9LSU9bWKSeYHqKKYTJ5
	fgeZVRWAFlN99TxeKKDjgw6my7e4ZHDzJQO205umk3foYFbin/uINBV4VvZJ+YdXZ2LCae4
	0Dh9K/sPgs5u0hpsFIhrofAIVGJTLEbi2l6nSBXaYL+Uq4aIqOa9lOwwvMOuAkt/GzVBjlY
	gL0BB3NroUm6bTcZiPj+LUW6SRC5wjDeWDzoW+lT4Is29Dw=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

The original DDN operations applied an implicit divide-by-2, which should
not be a default behavior.

This patch removes that assumption, letting each clock define its
actual behavior explicitly.

Reviewed-by: Haylen Chu <heylenay@4d2.org>
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 drivers/clk/spacemit/ccu-k1.c  |  4 ++--
 drivers/clk/spacemit/ccu_ddn.c | 12 ++++++------
 drivers/clk/spacemit/ccu_ddn.h |  6 ++++--
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
index 65e6de030717afa60eefab7bda88f9a13b857650..7155824673fb450971439873b6b6163faf48c7e5 100644
--- a/drivers/clk/spacemit/ccu-k1.c
+++ b/drivers/clk/spacemit/ccu-k1.c
@@ -136,8 +136,8 @@ CCU_GATE_DEFINE(pll1_d3_819p2, CCU_PARENT_HW(pll1_d3), MPMU_ACGR, BIT(14), 0);
 CCU_GATE_DEFINE(pll1_d2_1228p8, CCU_PARENT_HW(pll1_d2), MPMU_ACGR, BIT(16), 0);
 
 CCU_GATE_DEFINE(slow_uart, CCU_PARENT_NAME(osc), MPMU_ACGR, BIT(1), CLK_IGNORE_UNUSED);
-CCU_DDN_DEFINE(slow_uart1_14p74, pll1_d16_153p6, MPMU_SUCCR, 16, 13, 0, 13, 0);
-CCU_DDN_DEFINE(slow_uart2_48, pll1_d4_614p4, MPMU_SUCCR_1, 16, 13, 0, 13, 0);
+CCU_DDN_DEFINE(slow_uart1_14p74, pll1_d16_153p6, MPMU_SUCCR, 16, 13, 0, 13, 2, 0);
+CCU_DDN_DEFINE(slow_uart2_48, pll1_d4_614p4, MPMU_SUCCR_1, 16, 13, 0, 13, 2, 0);
 
 CCU_GATE_DEFINE(wdt_clk, CCU_PARENT_HW(pll1_d96_25p6), MPMU_WDTPCR, BIT(1), 0);
 
diff --git a/drivers/clk/spacemit/ccu_ddn.c b/drivers/clk/spacemit/ccu_ddn.c
index be311b045698e95a688a35858a8ac1bcfbffd2c7..06d86748182bd1959cdab5c18d0a882ee25dcade 100644
--- a/drivers/clk/spacemit/ccu_ddn.c
+++ b/drivers/clk/spacemit/ccu_ddn.c
@@ -22,21 +22,21 @@
 
 #include "ccu_ddn.h"
 
-static unsigned long ccu_ddn_calc_rate(unsigned long prate,
-				       unsigned long num, unsigned long den)
+static unsigned long ccu_ddn_calc_rate(unsigned long prate, unsigned long num,
+				       unsigned long den, unsigned int pre_div)
 {
-	return prate * den / 2 / num;
+	return prate * den / pre_div / num;
 }
 
 static unsigned long ccu_ddn_calc_best_rate(struct ccu_ddn *ddn,
 					    unsigned long rate, unsigned long prate,
 					    unsigned long *num, unsigned long *den)
 {
-	rational_best_approximation(rate, prate / 2,
+	rational_best_approximation(rate, prate / ddn->pre_div,
 				    ddn->den_mask >> ddn->den_shift,
 				    ddn->num_mask >> ddn->num_shift,
 				    den, num);
-	return ccu_ddn_calc_rate(prate, *num, *den);
+	return ccu_ddn_calc_rate(prate, *num, *den, ddn->pre_div);
 }
 
 static long ccu_ddn_round_rate(struct clk_hw *hw, unsigned long rate,
@@ -58,7 +58,7 @@ static unsigned long ccu_ddn_recalc_rate(struct clk_hw *hw, unsigned long prate)
 	num = (val & ddn->num_mask) >> ddn->num_shift;
 	den = (val & ddn->den_mask) >> ddn->den_shift;
 
-	return ccu_ddn_calc_rate(prate, num, den);
+	return ccu_ddn_calc_rate(prate, num, den, ddn->pre_div);
 }
 
 static int ccu_ddn_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/spacemit/ccu_ddn.h b/drivers/clk/spacemit/ccu_ddn.h
index a52fabe77d62eba16426867a9c13481e72f025c0..4838414a8e8dc04af49d3b8d39280efedbd75616 100644
--- a/drivers/clk/spacemit/ccu_ddn.h
+++ b/drivers/clk/spacemit/ccu_ddn.h
@@ -18,13 +18,14 @@ struct ccu_ddn {
 	unsigned int num_shift;
 	unsigned int den_mask;
 	unsigned int den_shift;
+	unsigned int pre_div;
 };
 
 #define CCU_DDN_INIT(_name, _parent, _flags) \
 	CLK_HW_INIT_HW(#_name, &_parent.common.hw, &spacemit_ccu_ddn_ops, _flags)
 
 #define CCU_DDN_DEFINE(_name, _parent, _reg_ctrl, _num_shift, _num_width,	\
-		       _den_shift, _den_width, _flags)				\
+		       _den_shift, _den_width, _pre_div, _flags)		\
 static struct ccu_ddn _name = {							\
 	.common = {								\
 		.reg_ctrl	= _reg_ctrl,					\
@@ -33,7 +34,8 @@ static struct ccu_ddn _name = {							\
 	.num_mask	= GENMASK(_num_shift + _num_width - 1, _num_shift),	\
 	.num_shift	= _num_shift,						\
 	.den_mask	= GENMASK(_den_shift + _den_width - 1, _den_shift),	\
-	.den_shift	= _den_shift,					\
+	.den_shift	= _den_shift,						\
+	.pre_div	= _pre_div,						\
 }
 
 static inline struct ccu_ddn *hw_to_ccu_ddn(struct clk_hw *hw)

-- 
2.50.1



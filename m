Return-Path: <linux-kernel+bounces-811295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1785B52719
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B901C83746
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E958224BD04;
	Thu, 11 Sep 2025 03:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="SGJu44LT"
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D516243367;
	Thu, 11 Sep 2025 03:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757561693; cv=none; b=VY+PpnDa9+JP8D9qm8VpsDiqRyO00k5VC6gpX3n0RMnKWy9khoOekKYZzyoQkfUayWbUgqYKIdJI3hnrGXOJzCOY1W9W6SRhvK8piloM+5Wqv7X1pGPAvaZ8GQzF1PZ5vSy0CKBS3Yez4T8VnplnVOxwhrjFIXTeHe/YIXvtu80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757561693; c=relaxed/simple;
	bh=um/BmDrcrL0kuow4Mg9YUsckGkNepV1kSLVg1UlzI78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hoBqPRL4NrW9OWi6I2MkFddP6hMh9IU54msL4VxOgodDvon7RIu0rBbKpW1lCSsDSiimS2DeEm4dT8pddas3PfY0omjh34A7g17anKrpejyz93EJht7WCUQyocO6RXVkQRUD7zetEOckTMfvihttjK+Qc2pyLsLT3T+LlD8im9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=SGJu44LT; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1757561658;
	bh=6dv7CsMYSMIwRgfQgFkuw6XwJ6YSMwlWfwNLaJZz9VU=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=SGJu44LTkeobZJOHSxoXXJZqzgBl1pbm3qzi4KPNbOvM2M6mO4NFA9B5YbuX7yBn7
	 DGCT90m7TROWvcyd68hs11PofwpXxu7i8gOB54aFZgfL2WjxEP/mAfqLngOZZIH1vv
	 x0OhCGsvGAJRpzODoJdS6SiB+RsM86Q9PkIwt3gU=
X-QQ-mid: zesmtpsz8t1757561656t73c75677
X-QQ-Originating-IP: atI6jdhOTO99dK0qo4mLzd5Ax7YIXq4ZclxUwACk0GM=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 11 Sep 2025 11:34:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11099552558053467934
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Thu, 11 Sep 2025 11:34:04 +0800
Subject: [PATCH RESEND v4 2/3] clk: spacemit: introduce pre-div for ddn
 clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-k1-clk-i2s-generation-v4-2-cba204a50d48@linux.spacemit.com>
References: <20250911-k1-clk-i2s-generation-v4-0-cba204a50d48@linux.spacemit.com>
In-Reply-To: <20250911-k1-clk-i2s-generation-v4-0-cba204a50d48@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757561644; l=4272;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=um/BmDrcrL0kuow4Mg9YUsckGkNepV1kSLVg1UlzI78=;
 b=z1OFKwF+QDZ8bs6TETX7P1vRlSxis+A8oFuHuR8uWEkspKrqdM5HtNAflp/q3Caesb+NZ4VCC
 2mRA2Y3Z890DxgfO37pcYRwxZBERKDeqLbN/s0p/Im+sPeHcAL8fo2d
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NGdvwxE97AwefNdEJpmYM6lo32jNovIfqsteg/zFKVwyphdsCpoAyLAo
	JBWn4ezbzcYk67Cx/0pIecmT6kz7JVjcbCEp7I07iquPs76+U4zw+b4Y5smPoyEOS9TTuet
	upOlJfrBC6gsmbkuEXaGvtqV7HsjWx+4ZYc95T/Cs1UQpDJuNRWqiWK5TYcuiXPNog3qaMj
	sk44pVtNP+BET11gdxPp8XhtzUP4NfHmA8CiWaZsYdwufE81HLOce+ubSTFMNqDpf0UROpK
	b7KKs9/8uKtWeAABrjYXS8KDsRnZGgFpiQMwJEWvaQ7lOYqqunXil71b+ZwQkpIaMAf3mRt
	8dYdEG776sOLL5sO1l0x9sRnoalE2XOmoG3Z4SiEkf9pJ+KL7gZ7440N8ASNFijCw51xv4U
	nZxqkFZ9ZPHbp0ib7AyEz8jD+AiaNFgiN19iyFbiWpv+0Ado12i2ZoHt1/XfGeUHB2HZfTw
	9UEmWWDawTVBZ/GsFzbg+bGGepwk8IUBTdoMrbeTmP/SRnZlRnZ+9+7dkFNG0gow5oTxli7
	9HsSvFBfnHMk+PFDwqAgnv6nSbJjJjD99f4Ds4nWKY9O/yk7+728wHi/TjfUkl2RTeGavMz
	o+BFwMHxvykWMsX9aBx6cfSaZpMBc9JmOCRPUKC29mS9N8vyyaihSXJs0MMs+4L/oTgJ8NH
	BkjqHJLAsUiKu87S1rvdIhpdmzC7Oz0JKYcqqcqvv6zGPhA981f6CxgUYQ4ZDzlGkHFlCnf
	/LxLfhbopWG7N7RAWcFd3o7nah23uDZrysvWrF5yTNCboOrBV+SboBWZ/lpc3/WgJ8rJIzH
	FJXeKw93fs33LoSGx326hie/Ls4siWAUlYjQSnmnzXA3aF5S1l7TA6IVQZthXMxO/HfKF3A
	N2oomjfd8g9xpmUc1zw8rO8voqX4Spf9Fi6MeHXEaNw1EatZ15QQidUbwYuuiCV5uD0Kzj+
	77nfbM5b827NuIpkMjbiXVFweQmRJNAtercR4kreuU9+xBdBAU+b3Xgii4LQpebFE3E4Ziz
	/UzDSYfIdYCj1Eq7SFY+faAW30J57TOKZrLWMzf6ZaPaEGFDhs6j9i6EPn+z+Rwf45p6qbe
	f6JjPL73CnvSf52x9lfDJmVzEZuqDO4SsspqoQUwl1i
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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
2.51.0



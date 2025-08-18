Return-Path: <linux-kernel+bounces-773296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC36EB29DE6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6922A5154
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745EB30E0D7;
	Mon, 18 Aug 2025 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="c2L9gJ+G"
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2327D220687;
	Mon, 18 Aug 2025 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509336; cv=none; b=nKqxcKwMO9f2//wON7/F5+qT5dawlC9q32eiU4HZSM0Nw5za1LmyrJsdFhtNqC1x+zZMfFQ2RFhu90QPG/nqxEn/wKEnarOvceiorGAybp9YtIZ7xrATtZlfAOV685L6H8wDbhTU7oIMr6r9dGAU1D2bO9aq1x8xcgQqdIFU6ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509336; c=relaxed/simple;
	bh=FOB7j1hlhVZDsG+zyDRMWyOCbt8PIEXCVAaCiq/WXRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nf/aBzGsmGjk2s3ZFIzMbd+UVWmGLeENf/aHubDSdnlFkDXkqcm50187e+ec0smGQbn2E7IbcyXKoKQya5TGxxi2MAw6on28XnlOZ3RivoHlQCCWIkRaEzwGNqFopTckDLIPxppte593o/RusJplRcxNO27qqEhjwrbneK2bIug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=c2L9gJ+G; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755509319;
	bh=P0uoMf5MS5hqK/AadmBbjxqCSSW+t8LKJc1Paz1/HdI=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=c2L9gJ+GZUI2IhrlapTezgMA1hwdXeTzdf1ySEYLc0G2aa57WQ+M0BkMI4e28KPdp
	 wI8gGt4r7wVU6pAZUUKmqxzUmY35UIpl6PwR+Xz2xtsCG+eZ0bwaCRPntA+WyLW9HB
	 AG9ER5Dxi/iJUqPsOOPYn2pIzYLMxefhtd6Lvh+0=
X-QQ-mid: zesmtpsz6t1755509318tefe082fa
X-QQ-Originating-IP: h/AA42SpewFkwa0CFAT8ZKkIBNMIUI7l+DNAVLVoz1M=
Received: from = ( [14.123.254.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Aug 2025 17:28:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14834764785882491220
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Mon, 18 Aug 2025 17:28:21 +0800
Subject: [PATCH v3 2/3] clk: spacemit: introduce pre-div for ddn clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-k1-clk-i2s-generation-v3-2-8139b22ae709@linux.spacemit.com>
References: <20250818-k1-clk-i2s-generation-v3-0-8139b22ae709@linux.spacemit.com>
In-Reply-To: <20250818-k1-clk-i2s-generation-v3-0-8139b22ae709@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755509307; l=4228;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=FOB7j1hlhVZDsG+zyDRMWyOCbt8PIEXCVAaCiq/WXRc=;
 b=M/lFs4kyl89mj2sEORYsOaGP3qlKajC1gTtgFdc/qX9ZBRO7aDVIo9wGpaaLa6UjHn9XEOTSZ
 O5QXfiPnJeZC/zgHitor1IuClRtwCBaR92PmkyrzarTgog/NntUIRYC
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NELwyfGakffP+9L3bDaMONw9vb6nlkH+SL0tIki6+Lhoki/bBZ+oRp91
	MqgF6/sfSTp2XFH9IIwVYLl+8Nuxclypjb/v9hTn+IFW4qE8l63OhJKSepg/x/2tOv2G0cz
	6AbpzKufG+eT72YEo/ViNTV/8e0Hkn1mkcvmwdTXDF/WE7PrR9bmU4cAFnIAT2vYSAs3cez
	3cHKLPXEg0bddeDcnaa7t9Ll504V9zQCDPZU5Zq+tZHWDK7PaS4T/uoZ2vF9f1weDn2BHdp
	M9Hxzadt2hdoDamDrmMzTb+g0wLZloN3tJ+Nz8ynl3eMtjBDZYEX8B/bvHVV/J6ideBiZnS
	LDcu0Yb6BBscVddoQUBtwmGOglZd/ctw5P+Bp/glCal8CY9bAwMxsQCGCYtAETPP0tgQoug
	7q/P7Rt4sjc9cndzlnBA0uN1QnA6htw0Ph8kB4AFleurSRMghMFvkQd7t1UaTfMOjoCSLaB
	oG3kbnWuFVM0stzHDNJAXintwHh+CegIGPckL88E7fBJZLlDzc1GwmLi79TZTi9dMw3JohY
	OGbLildh6Ees+3zduj1RZnX1uS33ijlV1Tp/inG2aFFAc+sQMNCXlLVs9Fk1ItFs1wlXx9R
	gTfukO8PImQsAoueknhJvxg7N6Pxu8jffFVhEf+JM7XUawP5j3228EtOHYU93vM0BBxNRYn
	lGI1HxP/tVnvHS4WLzZ9m1N4kZpFi1ODLxWKBJJXiMyewM+VpaJU8Ajx+LtzL/wKedyr7mv
	UI/m69qE2igLhKRKYVvOExZOXL3dhEaUARPKIm6kTlrv+MrObmg7kFMaWkhjCuYEXIN6CYD
	cJlqjaJ8UzNxEY1zLchmwjmmf79Fa6SG63fMO1eJpwD7L9q1GB8sBprvuVmrWEA9U/yE5a4
	swcddASc6YEjslnXdw8oNul644wexl0NZGjC3TclFebZB/4fX6Klpt/QDKF/b3TbmtWRl+F
	YvkrKx81dZnp9yNMn45giWbd8BnQS4FCAnl7So4zI3lJAzWCXRx27q/eqACo/LwTEOiNh1e
	LqiBHzBuJO+ijYqzKgdYqHQL/XVu84Is8i8a3cqyh1hXU+ax7Zsjiiek41X5oZYT7LV6mvk
	bgoz5S58/Fn1vDViZs3KfJD7d5um8fhuRsmbeMeVEOy
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

The original DDN operations applied an implicit divide-by-2, which should
not be a default behavior.

This patch removes that assumption, letting each clock define its
actual behavior explicitly.

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



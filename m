Return-Path: <linux-kernel+bounces-774704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9149EB2B64B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BE177AC310
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BE323B61A;
	Tue, 19 Aug 2025 01:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="EQ3at5az"
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADAE230269;
	Tue, 19 Aug 2025 01:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567352; cv=none; b=oikRpdKA6gB/iDk26ZrY2LPs4yVdywp9mX+BNr2W8gK6i3mVp/AyA376HBM6edWfHlTLw4MWGgBzCnHBlnkLetcwmxBEOZXnoVNSX68JpEmVNpGQR1mqlrGLQw5+5ErtYqqFyF8v9JMVAnSguxXU2qD+8YhzWl7QDr18YSPK/Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567352; c=relaxed/simple;
	bh=cbYO9pZP3k7Ta6Ig4gCsEs6GQb+qs2EuZyhEONUipoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kwm5vo283feQ5Rs3gLtFjCYkQkwKgdAm7BNbOvEwJFyCzOW4on1LMTOO00getsivH164wXlfxSfvWDNZFUGiRtdF84WE+x6OAXo6ZM+IXDP98CnY6i2LtPVTkuQUkxXuTookl3kvcwXZ/lACGBNaOYLjQsjs9nVI3DWIAmBhQdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=EQ3at5az; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755567329;
	bh=uhl8/t0StcVqCaIWEKD+VuekI6N7mwpFLjkaIlWp5yw=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=EQ3at5azQ8aYnyLn82PEuvhoL6PapiDIcshDoSU2YbXiy5XoTlGSkS5dhMflNnDsT
	 elZ14fBMyAXGGuJun5CwQ7ZkGB8MSuhbmttTyVqwmh0g/dl02u0edbJV43Asc0B5Jb
	 nmejDhFlpkuQAYTlxSa70oKMyhKF0pTQqP13aqvU=
X-QQ-mid: esmtpgz10t1755567327t312bb98c
X-QQ-Originating-IP: iIZs0ikRtkS/JR0i6or1EkTqIWUaffHSmjp2ixQuz30=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 19 Aug 2025 09:35:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12480758067493020977
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Tue, 19 Aug 2025 09:35:11 +0800
Subject: [PATCH v4 3/3] clk: spacemit: fix i2s clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-k1-clk-i2s-generation-v4-3-80174edd04eb@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755567313; l=4010;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=cbYO9pZP3k7Ta6Ig4gCsEs6GQb+qs2EuZyhEONUipoQ=;
 b=t5XOT52tWGiOmBs4rOz5QVFCAK7ITGOYNwnrlciH8aM2d6IIZ2C8YkmqNKa9jpLE2wLrM/PuA
 doV1k5Qt+g7CfXA/hJHL/QNk7LDMqztlWm1EgWJHTb/4s4zYoLqlanY
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: Mjc5Shoq7MT/bc2/K5mBRkhYj7Dpkql/PbUeEAlc6F+C9pv9zBt8/vnA
	MyCATrn47mcqpw3RCTCXJI2zrbnaiZJ7remXhQNyf95rLM75mFb2iZS8qRxmzkMyZBlPhC1
	qjQ751tbj9jyljIojTWPSon1oyzymwkJTVqujMI+HsrmF80UtT8mR4y0yqGXHwQgfe7cnkp
	FZJFKLXmUN4fBl9/5b/s6B+jMdzhQpFfC67FdaEFEUT7fIVV+kV8v8QA7ifrEMaJJvi0gMB
	ezNzvlYfsXJNCROZrHTQ+w6tJX3E5SlwHphIFp12pqUyRsCeVNj+he6BTljwmKZD5k8Gbdp
	gpW9wT1LJZWGWLq3TggZXxBeuct1bI74E/gjl/5ZMRglonAmi815YtLTI3a+AJ1HdZ55VDJ
	sVN5YYQdI60FMvSo7TY2QeFPL/RXwSfWx0+Wcj7H22tOVjaoimFPv68+zXP79yNyVRVVfPO
	+9TnVg6eGgtCjCeo3ZCVWrJkbp0j3NxxMnSgqf1GvKHnqot8WDmaoViDw9J/DuryXobHIQI
	zVHLv6L5qcogkjxkHsLg/pjteW5y7bDDj+9B/xB4Zb6gZgNiE25PS+6FmdSZELtD737pqQD
	lul1Trx2HkB5dRSSc0iMpRrpXZGoTLSu1RJ4glIx/pUASrvcmSrHJQSKUdsARfxunWk0FXj
	nmYPsQI3WubUyOqmVMhWnJ0Cvlf+DJVLaebf2KTBz9De4VflFSNhBImsipTRcMhb7Qi07n8
	pkHK0gMkZEtyT67chG+Lz3zErlkZ7Rr23vJWiAC9FsPsYV9byy22ramttqYn2KkW3xuIyP7
	eo5tVBWwqAK4efsICGtHwpkv6E6X0yw/0md69OO3ssJMq7Esq/C+YuFv6ALHdDCr7zZLYkS
	NZfUR0MWdzTAdWhfI/PRcUYOs9qLqPBeo7FW4JSVyHdiHIUlvZ7DX9Lc8A5io2QnaI1x55q
	48kJXM4iyGGakEYuDZTiStcCXkNV13ClyHtzbeRncIrNDOhZEOd/iO98eys8Dswk4gk2hwD
	OgUviuwqxI4QwgMpcyLsY7wIKlvAVY6Ho/TwwO1BqvA3XHkIUPJta1Rkj0eP0uEESyzlxxZ
	wRoVewTUbkIUI/cA0/XbfysSfLD54GQgqLc57HC9qCX0Oek/GJx8RKEeEV/kFlFDlyRerjt
	BEDU
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Defining i2s_bclk and i2s_sysclk as fixed-rate clocks is insufficient
for real I2S use cases.

Moreover, the current I2S clock configuration does not work as expected
due to missing parent clocks.

This patch adds the missing parent clocks, defines i2s_sysclk as
a DDN clock, and i2s_bclk as a DIV clock.

A special note for i2s_bclk:

From the register definition, the i2s_bclk divider always implies
an additional 1/2 factor.

The following table shows the correspondence between index
and frequency division coefficients:

| index |  div  |
|-------|-------|
|   0   |   2   |
|   1   |   4   |
|   2   |   6   |
|   3   |   8   |

From a software perspective, introducing i2s_bclk_factor as the
parent of i2s_bclk is sufficient to address the issue.

The I2S-related clock registers can be found here [1].

Link:
https://developer.spacemit.com/documentation?token=LCrKwWDasiJuROkVNusc2pWTnEb
[1]

Fixes: 1b72c59db0add ("clk: spacemit: Add clock support for SpacemiT K1 SoC")
Co-developer: Jinmei Wei <weijinmei@linux.spacemit.com>
Suggested-by: Haylen Chu <heylenay@4d2.org>
Signed-off-by: Jinmei Wei <weijinmei@linux.spacemit.com>
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 drivers/clk/spacemit/ccu-k1.c    | 28 ++++++++++++++++++++++++++--
 include/soc/spacemit/k1-syscon.h |  1 +
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
index 7155824673fb450971439873b6b6163faf48c7e5..50b472a2721121414f33e9fac6370f544e6b8229 100644
--- a/drivers/clk/spacemit/ccu-k1.c
+++ b/drivers/clk/spacemit/ccu-k1.c
@@ -141,8 +141,28 @@ CCU_DDN_DEFINE(slow_uart2_48, pll1_d4_614p4, MPMU_SUCCR_1, 16, 13, 0, 13, 2, 0);
 
 CCU_GATE_DEFINE(wdt_clk, CCU_PARENT_HW(pll1_d96_25p6), MPMU_WDTPCR, BIT(1), 0);
 
-CCU_FACTOR_GATE_DEFINE(i2s_sysclk, CCU_PARENT_HW(pll1_d16_153p6), MPMU_ISCCR, BIT(31), 50, 1);
-CCU_FACTOR_GATE_DEFINE(i2s_bclk, CCU_PARENT_HW(i2s_sysclk), MPMU_ISCCR, BIT(29), 1, 1);
+CCU_FACTOR_DEFINE(i2s_153p6, CCU_PARENT_HW(pll1_d8_307p2), 2, 1);
+
+static const struct clk_parent_data i2s_153p6_base_parents[] = {
+	CCU_PARENT_HW(i2s_153p6),
+	CCU_PARENT_HW(pll1_d8_307p2),
+};
+CCU_MUX_DEFINE(i2s_153p6_base, i2s_153p6_base_parents, MPMU_FCCR, 29, 1, 0);
+
+static const struct clk_parent_data i2s_sysclk_src_parents[] = {
+	CCU_PARENT_HW(pll1_d96_25p6),
+	CCU_PARENT_HW(i2s_153p6_base)
+};
+CCU_MUX_GATE_DEFINE(i2s_sysclk_src, i2s_sysclk_src_parents, MPMU_ISCCR, 30, 1, BIT(31), 0);
+
+CCU_DDN_DEFINE(i2s_sysclk, i2s_sysclk_src, MPMU_ISCCR, 0, 15, 15, 12, 1, 0);
+
+CCU_FACTOR_DEFINE(i2s_bclk_factor, CCU_PARENT_HW(i2s_sysclk), 2, 1);
+/*
+ * Divider of i2s_bclk always implies a 1/2 factor, which is
+ * described by i2s_bclk_factor.
+ */
+CCU_DIV_GATE_DEFINE(i2s_bclk, CCU_PARENT_HW(i2s_bclk_factor), MPMU_ISCCR, 27, 2, BIT(29), 0);
 
 static const struct clk_parent_data apb_parents[] = {
 	CCU_PARENT_HW(pll1_d96_25p6),
@@ -756,6 +776,10 @@ static struct clk_hw *k1_ccu_mpmu_hws[] = {
 	[CLK_I2S_BCLK]		= &i2s_bclk.common.hw,
 	[CLK_APB]		= &apb_clk.common.hw,
 	[CLK_WDT_BUS]		= &wdt_bus_clk.common.hw,
+	[CLK_I2S_153P6]		= &i2s_153p6.common.hw,
+	[CLK_I2S_153P6_BASE]	= &i2s_153p6_base.common.hw,
+	[CLK_I2S_SYSCLK_SRC]	= &i2s_sysclk_src.common.hw,
+	[CLK_I2S_BCLK_FACTOR]	= &i2s_bclk_factor.common.hw,
 };
 
 static const struct spacemit_ccu_data k1_ccu_mpmu_data = {
diff --git a/include/soc/spacemit/k1-syscon.h b/include/soc/spacemit/k1-syscon.h
index c59bd7a38e5b4219121341b9c0d9ffda13a9c3e2..354751562c55523ef8a22be931ddd8aca9651084 100644
--- a/include/soc/spacemit/k1-syscon.h
+++ b/include/soc/spacemit/k1-syscon.h
@@ -30,6 +30,7 @@ to_spacemit_ccu_adev(struct auxiliary_device *adev)
 
 /* MPMU register offset */
 #define MPMU_POSR			0x0010
+#define MPMU_FCCR			0x0008
 #define  POSR_PLL1_LOCK			BIT(27)
 #define  POSR_PLL2_LOCK			BIT(28)
 #define  POSR_PLL3_LOCK			BIT(29)

-- 
2.50.1



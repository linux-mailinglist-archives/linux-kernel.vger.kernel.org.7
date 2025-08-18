Return-Path: <linux-kernel+bounces-773300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2A3B29DED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BB055E124A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5081A30E0F4;
	Mon, 18 Aug 2025 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="NHMquLN8"
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EAF30EF6C;
	Mon, 18 Aug 2025 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.65.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509354; cv=none; b=e2PylMaz1rNf7G0SHXBpXhj6Ni34l4PJxRDbKCbJ95xbV2rZM0MgFzO06yyWhpxWUa9ap46DhuF//BLjzWoM1g48/HrTKI0X3yffLWnr39adYEEWk4uRRzU9QvYrxHO2vUXRKJqMSFPwrLVXtB9BRCRYzn0xqeCQDzWEQ1U81n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509354; c=relaxed/simple;
	bh=EbxNhhULS7njhbvu3e7GjERZF4MmhlDW5guLkzvyZP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X0zikphuFVgGYxGRyEXAg6Bp9REYDV6m6Sl10NFS+wR6WK97LOQWgvlSpisxpERE+Mg9/f46qQBy34fxLPTLq8gt8l4/X2CezBMIqLNK5CoXihwu3SsFEYL9+63hCB3bqvDTuvxbLK2WFJsx/9UBOuJ2FR156/KC92xGhHiTyAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=NHMquLN8; arc=none smtp.client-ip=114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755509323;
	bh=gcsRKHyAKuMtB+ZuHSQSM7MM8/icoYyw0uVo9I/iac4=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=NHMquLN8mmrPgmGH08tPxZWxhwgF8yJ9HZkbQ7yUVEmqI+A8mz++tvJx0j5hi9QD5
	 FleXMP/K+qHXAQ6Tn37D1pTRyW/XXOQUwr9xI6Sme5DkF5++P7AG/Eh80HoFXqKjEd
	 hkHbZ+9s2/tYR3ZAmJCNDtBM6SgN02eOb5UM+ezQ=
X-QQ-mid: esmtpsz21t1755509322t40396246
X-QQ-Originating-IP: B3DkngCQnn0bbz9w7FXWq/lfnZGvWROgMlt3PBsCQy8=
Received: from = ( [14.123.254.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Aug 2025 17:28:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16519149024286198019
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Mon, 18 Aug 2025 17:28:22 +0800
Subject: [PATCH v3 3/3] clk: spacemit: fix i2s clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-k1-clk-i2s-generation-v3-3-8139b22ae709@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755509307; l=4733;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=EbxNhhULS7njhbvu3e7GjERZF4MmhlDW5guLkzvyZP4=;
 b=c0A8Dxfc6KBKkPbV9tt0qoy/mYxWLZhU7nqpIZSp7tr0i5kxJIeA12u+q5lGGBGPFh+y1JtJk
 c+jkw2SU6PyAXlo+xKUN9avrR2Awz55sq+It+J+QpXjwn7tILizpJtR
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: M+Qa/yP3m2vGCAhUJiJg8RjSxFqRv6mp0DHJa6FCcIqJ7WEhdSs5ucr+
	7jkTgHZ2xYhsCa7nJzpVKGKQNsyVJ+OqdujsBSLWU/HBwiRPBDJtFkyMfqHf2UKvNWiLc+8
	ZwwJRCLGbeDFYomj94mCTDC33ClXps2BFcFCQe3M+OQNBw2WzjJWyVhU+Y72W5oVb9VvFCl
	jU4dXh4FNdXjdAo8QQq9Vs3mp6xjSepnLLWja/ixN74Y/PoBxiE/DhSVpRaiq/oBh2EBRie
	l2ZrgBzhEcBc+XwSCaTGMMQjF+2TA5i1yKVBR+bgQxyqtqCxFtxTp6lPtK7Glt+2YaPqOdR
	Y90fihELssYbn9RPtegE0BhlJZEmwZGsR0Db7gLNXLa+M4ePEJew7QXdRfdce5XJJwGa4ar
	/Yli//5kwRsPucVm5rivsSGsmpz5sGwB9IsQLg6Kra3qCDrSArGjL3oOwhejPL54b8q0JCl
	k5mAVX1MR6+Qm6Ae6Ad/HkutCCEZXCk+D7+vHunJi5I96i76jB9kcoyNcWfmNkunDQkbd/z
	N5ZoXlLLToPAKvcaHb+m7Y43ZDxTOTh7XXX4E8ktMQEHNnfHfDYWEpCC0k7nMbgMsFkNi0J
	z8oG0JUfiKY6HMQ28kAKr3WzY/ve3zRdVvjjPe0PDtmIlV51uYW6TQGC9hDmNe90imT0NXB
	ZfYKSPqpmjuLjBfk2Mu+C6WdDDTRzpUe1yQGEy3L54TCtDoNeCSTBucpeCb5udaVlNVupHc
	/ftsbVGVxGd5vAmbuUvqdL2J4buHu7tCKOZGLYcIsfzukaIAds/izyj+oLG5EmVw+NATRsZ
	520GnbCmpADk7zDE/zdVi2j8eThPuhMSv8bEPSPN9HEauKaQ3RhUw6EpZLDy2DZgrGsAQCe
	rHWRutUgqiK1Ucw9SE86ZZVPFc4wginY1zPFFUogJ6i15s1PuYwOqDCpetsgDsRHYob36ld
	yWgOYSriC+aKi2iImckfMH2k1o9wrPj7EEoAYWQ9BlBCTctiKkAr4C7cldMrWBZutOnEBo+
	cDBCMiNpfGrYtAwmnlAC6IXqB/jW3xBWJv32LHsS/JIaQ7oHVMV6yswOf97TsXiOuun4LJx
	EX9pZTJgmZ7t7Nc8URR7TUgt5Zo57guiaH1UQFecPpEWmaoXdKaxhXcYvYC+f/m2MqH8As1
	u19F2tlZIS17gLc=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Defining i2s_bclk and i2s_sysclk as fixed-rate clocks is insufficient
for real I2S use cases.

Moreover, the current I2S clock configuration does not work as expected
due to missing parent clocks.

This patch adds the missing parent clocks, defines i2s_sysclk as
a DDN clock, and i2s_bclk as a DIV clock.

A special note for i2s_bclk:

From the definition of register, The i2s_bclk is a non-linear,
discrete divider clock.

The following table shows the correspondence between index
and frequency division coefficients:

| index |  div  |
|-------|-------|
|   0   |   2   |
|   1   |   4   |
|   2   |   6   |
|   2   |   8   |

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
 drivers/clk/spacemit/ccu-k1.c    | 29 +++++++++++++++++++++++++++--
 drivers/clk/spacemit/ccu_mix.h   |  2 +-
 include/soc/spacemit/k1-syscon.h |  1 +
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
index 7155824673fb450971439873b6b6163faf48c7e5..b2c426b629a37a9901bbced26fc55c5f1b34eba5 100644
--- a/drivers/clk/spacemit/ccu-k1.c
+++ b/drivers/clk/spacemit/ccu-k1.c
@@ -141,8 +141,29 @@ CCU_DDN_DEFINE(slow_uart2_48, pll1_d4_614p4, MPMU_SUCCR_1, 16, 13, 0, 13, 2, 0);
 
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
+ * i2s_bclk is a non-linear discrete divider clock.
+ * Using i2s_bclk_factor as its parent simplifies software handling
+ * and avoids dealing with the non-linear division directly.
+ */
+CCU_DIV_GATE_DEFINE(i2s_bclk, CCU_PARENT_HW(i2s_bclk_factor), MPMU_ISCCR, 27, 2, BIT(29), 0);
 
 static const struct clk_parent_data apb_parents[] = {
 	CCU_PARENT_HW(pll1_d96_25p6),
@@ -756,6 +777,10 @@ static struct clk_hw *k1_ccu_mpmu_hws[] = {
 	[CLK_I2S_BCLK]		= &i2s_bclk.common.hw,
 	[CLK_APB]		= &apb_clk.common.hw,
 	[CLK_WDT_BUS]		= &wdt_bus_clk.common.hw,
+	[CLK_I2S_153P6]		= &i2s_153p6.common.hw,
+	[CLK_I2S_153P6_BASE]	= &i2s_153p6_base.common.hw,
+	[CLK_I2S_SYSCLK_SRC]	= &i2s_sysclk_src.common.hw,
+	[CLK_I2S_BCLK_FACTOR]	= &i2s_bclk_factor.common.hw,
 };
 
 static const struct spacemit_ccu_data k1_ccu_mpmu_data = {
diff --git a/drivers/clk/spacemit/ccu_mix.h b/drivers/clk/spacemit/ccu_mix.h
index 54d40cd39b2752260f57d2a96eb8d3eed8116ecd..5b5c3bb958167a68736587e9097a1ca6f94d22fa 100644
--- a/drivers/clk/spacemit/ccu_mix.h
+++ b/drivers/clk/spacemit/ccu_mix.h
@@ -130,7 +130,7 @@ static struct ccu_mix _name = {							\
 }
 
 #define CCU_DIV_GATE_DEFINE(_name, _parent, _reg_ctrl, _shift, _width,		\
-			    _mask_gate,	_flags)					\
+			    _mask_gate, _flags)			\
 static struct ccu_mix _name = {							\
 	.gate	= CCU_GATE_INIT(_mask_gate),					\
 	.div	= CCU_DIV_INIT(_shift, _width),					\
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



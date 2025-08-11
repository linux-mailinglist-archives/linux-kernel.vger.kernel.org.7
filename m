Return-Path: <linux-kernel+bounces-762832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4961BB20B71
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 838907AC69E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610E8242923;
	Mon, 11 Aug 2025 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="PpR8rMpZ"
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5466E23BCF5;
	Mon, 11 Aug 2025 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921109; cv=none; b=kZUSGUNroSbgh24SJHiINMdR+3aTLiyiPrkUJ6ytNFAz5UXCBQwm0UNaKwbgUoP0zeYpwfprBUtuWF4vQUsNo5sgKdMEc0aHG16P0xoiysga/fQ0NTx0RzhPc+WLaCOTtcz0fBcPtE9Gnx1yAiVeL26Gv+xkdJ3STfm178zseMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921109; c=relaxed/simple;
	bh=/eP5t1s0TqmJIvJ8sxEMoPxPa8mRQSEXNyaZxgSUlDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e0NB4bH7v7+MqFHBeuSQvyRLgV8/pVG9uzAbti7oW+jg6/NyBLN4WqLQkjEeb7iz0Ud+smj3mG7Ht6aYJdKl7RDN0AdoqfYXsKNrED4MI/M1pWXscuqZPuEXWmnI57BU/Xmtzf5crOGZ+z2uH62pFpBsA2PFGtBIzfeBa+BBXdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=PpR8rMpZ; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1754921091;
	bh=oUvLpctbzw/WmMzpaNN8M2oVwo9YJxXCqlSJR/iqBr4=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=PpR8rMpZadtp6AJTmxAaNaejQAbvdZuhyYchCHs9cQVWRiLb0ggFzFqjAFFUblaQo
	 V/OM16U7ZhMzJIJpudurQZeh8Yo1Q00hPgRlt6mTAdxp1CvH1cLKRSMH2shyAgneut
	 DAakkYe4btH/T+qnRulXl/4G5XBk48POVAPZc51k=
X-QQ-mid: zesmtpip3t1754921090t5adf6c6f
X-QQ-Originating-IP: 77QCtEo+rzaJ27LWZg1zIIO7xOaXq4U7Kmzsi4q9YBI=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 Aug 2025 22:04:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11959351235578941372
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Mon, 11 Aug 2025 22:04:30 +0800
Subject: [PATCH v2 4/4] clk: spacemit: fix i2s clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-k1-clk-i2s-generation-v2-4-e4d3ec268b7a@linux.spacemit.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754921074; l=4205;
 i=troy.mitchell@linux.spacemit.com; s=20250712; h=from:subject:message-id;
 bh=/eP5t1s0TqmJIvJ8sxEMoPxPa8mRQSEXNyaZxgSUlDo=;
 b=p3HEwh3FPsXPkPLayk+Nv8p8KIP+CiyvupGRdd/M1EW0hj4BIzjQBvfOmJJNmHfWUf4zpTd/I
 nJgeuQ4Q9vuDlqsdURTkbApXuDuq6R9iYSatGTdLH23AW4EG0Ve1q42
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=zhRP1xE0bftrurqSWI+SzcSdJGIZ0BTTY9Id0ESzqlI=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NYSbNmQ6i3UflGZQAhExDUD5lezifgMNpg/HQ1y4ZLzfvJpN3ogzQQwc
	OClc6N7TR4/Mz+5fYUZG0dtigTV+p7cnXhu35WSp28lmhVwoI6RpjYmOv1MiDQwDvxDVGFy
	VY6kbg3oezvzNIpp170m21rA0V6NOiVFowef0WyXOJtfBsuF4UmvDx+UD56s/8n8UMpDIF7
	mWZ00dOOJOo3EdUZwXUbloRolVgzEcvhewsYYncpjDVj34207OP7ycRs5hrdVOZf7k/MABt
	yhf6wXG/p94NgPac5yAV0/yjFL1dgU+P8tMKj047P9noiKJ4TQvJESkax6AupUml7hR23Q6
	mJbUl3UW2xRUu67eOsE2Yx9PelRIGnyj4ImELM3BPEpH5QeKkpanDN8JVR8zt7RmaatqGcM
	AouqxkonTeIdPyy4c0cJ8/rsB80QMVF7338X8U6207WQ090WgzZHaFlVJIuRH40RKAr6Sjj
	CbdhKeKQfIXvOfx5AzTw8kOkbyz0BJf8/cAU8oskaasVWhoTbN47wBF3MMDjCKaafRPmRHQ
	j+lSNSFdusI7CjQRZM3jBDdYx9tZQf/F9xQXeQrBZ6fXXUfnpm1Uf26ySGTfTEHvXp0MlX2
	4tVh7g0mEDUca8U0WaZzwCC4ZEPvWnn3YZvgYrw8aOOmAMK3qpwld9JDdJHRaBH958LuJ/S
	+AkevnVIbnIcrX7DczPgDsC2eqRjlGVZHyag6CqnYCaewUrDQyTKsgh9rLeX6dvjQdQgOIW
	wrENzLyg1aHOzEYpYLZixq1wsNtSNrxgW+JnT4N+c2X5Ypr3tJwn9YJ82Ho52PR9UWc6a/x
	n3XWvpqVnxG2zFViht4tFNg3P17sYc4dX1ZIIRxKQNzq0WCcavh2fAb8xLNOx0h8nS1C0PT
	ws6xnxsHJFjNRTjEHS7jKGRudJsOB0UW4hnOJFfNXd/FhmDQ90PtVYrjZg501peYDBBml2j
	hNKjM/yx1CwbXgw4S3gCwpqMBb1FDMjsfgSUxE6qsjXDVf82Rqyrn19YqYuHYCDcC3096Pr
	WJYtH5rYqa9DMxP9ji/s1xIIKpXLTyBQjBYCNKWqH7BpCvjvs9Vh872WBMvgFH+PdhjTj/0
	8otdT8tiRWD71bdUGBwTmob+NkcUACYbFRsALWFboueB3isN548EDet7w7KnIeGPSvvljK1
	ktQnHkq6yc4Wm6vIz9gx/qoTSNlz7dZ6fZ7o
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Defining i2s_bclk and i2s_sysclk as fixed-factor clocks is insufficient
for real I2S use cases.

Moreover, the current I2S clock configuration does not work as expected
due to missing parent clocks.

This patch adds the missing parent clocks, defines i2s_sysclk as
a DDN clock, and i2s_bclk as a DIV clock.

The I2S-related clock registers can be found here [1].

Link:
https://developer.spacemit.com/documentation?token=LCrKwWDasiJuROkVNusc2pWTnEb
[1]

Fixes: 1b72c59db0add ("clk: spacemit: Add clock support for SpacemiT K1 SoC")
Co-developer: Jinmei Wei <weijinmei@linux.spacemit.com>
Signed-off-by: Jinmei Wei <weijinmei@linux.spacemit.com>
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 drivers/clk/spacemit/ccu-k1.c    | 28 +++++++++++++++++++++++-----
 include/soc/spacemit/k1-syscon.h |  1 +
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
index 65e6de030717afa60eefab7bda88f9a13b857650..3a885d64fb09144bb0d40024fea9415d66eba01b 100644
--- a/drivers/clk/spacemit/ccu-k1.c
+++ b/drivers/clk/spacemit/ccu-k1.c
@@ -136,13 +136,28 @@ CCU_GATE_DEFINE(pll1_d3_819p2, CCU_PARENT_HW(pll1_d3), MPMU_ACGR, BIT(14), 0);
 CCU_GATE_DEFINE(pll1_d2_1228p8, CCU_PARENT_HW(pll1_d2), MPMU_ACGR, BIT(16), 0);
 
 CCU_GATE_DEFINE(slow_uart, CCU_PARENT_NAME(osc), MPMU_ACGR, BIT(1), CLK_IGNORE_UNUSED);
-CCU_DDN_DEFINE(slow_uart1_14p74, pll1_d16_153p6, MPMU_SUCCR, 16, 13, 0, 13, 0);
-CCU_DDN_DEFINE(slow_uart2_48, pll1_d4_614p4, MPMU_SUCCR_1, 16, 13, 0, 13, 0);
+CCU_DDN_DEFINE(slow_uart1_14p74, pll1_d16_153p6, MPMU_SUCCR, 16, 13, 0, 13, 2, 0);
+CCU_DDN_DEFINE(slow_uart2_48, pll1_d4_614p4, MPMU_SUCCR_1, 16, 13, 0, 13, 2, 0);
 
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
+CCU_DIV_GATE_DEFINE(i2s_bclk, CCU_PARENT_HW(i2s_sysclk), MPMU_ISCCR, 27, 2, BIT(29), 2, 0);
 
 static const struct clk_parent_data apb_parents[] = {
 	CCU_PARENT_HW(pll1_d96_25p6),
@@ -639,7 +654,7 @@ static const struct clk_parent_data emmc_parents[] = {
 CCU_MUX_DIV_GATE_FC_DEFINE(emmc_clk, emmc_parents, APMU_PMUA_EM_CLK_RES_CTRL, 8, 3, BIT(11),
 			   6, 2, BIT(4), 0);
 CCU_DIV_GATE_DEFINE(emmc_x_clk, CCU_PARENT_HW(pll1_d2_1228p8), APMU_PMUA_EM_CLK_RES_CTRL, 12,
-		    3, BIT(15), 0);
+		    3, BIT(15), 1, 0);
 
 static const struct clk_parent_data audio_parents[] = {
 	CCU_PARENT_HW(pll1_aud_245p7),
@@ -756,6 +771,9 @@ static struct clk_hw *k1_ccu_mpmu_hws[] = {
 	[CLK_I2S_BCLK]		= &i2s_bclk.common.hw,
 	[CLK_APB]		= &apb_clk.common.hw,
 	[CLK_WDT_BUS]		= &wdt_bus_clk.common.hw,
+	[CLK_I2S_153P6]		= &i2s_153p6.common.hw,
+	[CLK_I2S_153P6_BASE]	= &i2s_153p6_base.common.hw,
+	[CLK_I2S_SYSCLK_SRC]	= &i2s_sysclk_src.common.hw,
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



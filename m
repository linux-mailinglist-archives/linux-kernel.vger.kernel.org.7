Return-Path: <linux-kernel+bounces-812629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F46DB53AAA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA8C5647C0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662A8369982;
	Thu, 11 Sep 2025 17:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSk0avWo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69D63680B6;
	Thu, 11 Sep 2025 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757612835; cv=none; b=GmE4K3KYKEpsoRqRUvr8zG5PNalr9PZ+PlM/mcbk2orGRzRxpjr0LSzEYBx/bICQGGtqfQwk+thSYy6kSCbRLR29EkB/w+L63EOE2DKqpqHjjjjMlIXQZVzEEku5LXKPGXMN/kRxUKeR3Fn3NH1udRGhIuWtBCUQrycV1kYKPUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757612835; c=relaxed/simple;
	bh=1VGX+X5eVJrtg3lTD0x2fIATGMZKPMhLF6+i7bBsWgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C8wCj2pHeKO5MMRmBEUbpYsIHaxMRVs/M9lqEdRnw8LjFokRBJqR2pBRLSesu0hAJZisvcgPeKa4fB80jol/OP5zsUq/lfV5JEyEVYuQMbrQVBruEno1T5bc+JyvXHnGfK3EncWQmXYMdQWuzeYIzc4YI1CSVPNxBs62HzboVGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSk0avWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386C1C4CEF8;
	Thu, 11 Sep 2025 17:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757612834;
	bh=1VGX+X5eVJrtg3lTD0x2fIATGMZKPMhLF6+i7bBsWgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qSk0avWok6UUo8+7Qj1RGhmQs+DEqs0rzebZrjRrWeMTSgtz9uMp45NiFgOlwj9tm
	 pcrp5RizhnRej7FQqGEHgngogSObR9g7j5Xdkg8gquBWKTk91RTJbOjcaHp9I1qPE7
	 6NqA1Zz04o7Hmu7oD3xzv3otpuSJxOASYsNfvv32JTBusFItsmZls7cq/sstsVGwD1
	 7MflRHWH8VU8k+5GYsMnyU0IdMsNMQD/4v1If/cLHTIFYsmpi1tX7SlvIqcb9WzVuh
	 X1nbsgjR0khHgzc1x+p7ICXXIKb0d+H4jiikSdQHs8Mq1bgg77M8D7Pcj4q70FnfVz
	 U7fXT+ONz1S/A==
Received: by wens.tw (Postfix, from userid 1000)
	id E25D75FE35; Fri, 12 Sep 2025 01:47:11 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-sunxi@lists.linux.dev,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] clk: sunxi-ng: sun55i-a523-ccu: Add missing NPU module clock
Date: Fri, 12 Sep 2025 01:47:06 +0800
Message-Id: <20250911174710.3149589-4-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250911174710.3149589-1-wens@kernel.org>
References: <20250911174710.3149589-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The main clock controller on the A523/T527 has the NPU's module clock.
It was missing from the original submission, likely because that was
based on the A523 user manual; the A523 is marketed without the NPU.

Also, merge the private header back into the driver code itself. The
header only contains a macro containing the total number of clocks.
This has to be updated every time a missing clock gets added. Having
it in a separate file doesn't help the process. Instead just drop the
macro, and thus the header no longer has any reason to exist.

Also move the .num value to after the list of clks to make it obvious
that it should be updated when new clks are added.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v1:
- Move .num to after list of clks
---
 drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 21 ++++++++++++++++++---
 drivers/clk/sunxi-ng/ccu-sun55i-a523.h | 14 --------------
 2 files changed, 18 insertions(+), 17 deletions(-)
 delete mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523.h

diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
index 1a9a1cb869e2..acb532f8361b 100644
--- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
+++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
@@ -11,6 +11,9 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
+#include <dt-bindings/clock/sun55i-a523-ccu.h>
+#include <dt-bindings/reset/sun55i-a523-ccu.h>
+
 #include "../clk.h"
 
 #include "ccu_common.h"
@@ -25,8 +28,6 @@
 #include "ccu_nkmp.h"
 #include "ccu_nm.h"
 
-#include "ccu-sun55i-a523.h"
-
 /*
  * The 24 MHz oscillator, the root of most of the clock tree.
  * .fw_name is the string used in the DT "clock-names" property, used to
@@ -486,6 +487,18 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(ve_clk, "ve", ve_parents, 0x690,
 
 static SUNXI_CCU_GATE_HWS(bus_ve_clk, "bus-ve", ahb_hws, 0x69c, BIT(0), 0);
 
+static const struct clk_hw *npu_parents[] = {
+	&pll_periph0_480M_clk.common.hw,
+	&pll_periph0_600M_clk.hw,
+	&pll_periph0_800M_clk.common.hw,
+	&pll_npu_2x_clk.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(npu_clk, "npu", npu_parents, 0x6e0,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    CLK_SET_RATE_PARENT);
+
 static SUNXI_CCU_GATE_HWS(bus_dma_clk, "bus-dma", ahb_hws, 0x70c, BIT(0), 0);
 
 static SUNXI_CCU_GATE_HWS(bus_msgbox_clk, "bus-msgbox", ahb_hws, 0x71c,
@@ -1217,6 +1230,7 @@ static struct ccu_common *sun55i_a523_ccu_clks[] = {
 	&bus_ce_sys_clk.common,
 	&ve_clk.common,
 	&bus_ve_clk.common,
+	&npu_clk.common,
 	&bus_dma_clk.common,
 	&bus_msgbox_clk.common,
 	&bus_spinlock_clk.common,
@@ -1343,7 +1357,6 @@ static struct ccu_common *sun55i_a523_ccu_clks[] = {
 };
 
 static struct clk_hw_onecell_data sun55i_a523_hw_clks = {
-	.num	= CLK_NUMBER,
 	.hws	= {
 		[CLK_PLL_DDR0]		= &pll_ddr_clk.common.hw,
 		[CLK_PLL_PERIPH0_4X]	= &pll_periph0_4x_clk.common.hw,
@@ -1524,7 +1537,9 @@ static struct clk_hw_onecell_data sun55i_a523_hw_clks = {
 		[CLK_FANOUT0]		= &fanout0_clk.common.hw,
 		[CLK_FANOUT1]		= &fanout1_clk.common.hw,
 		[CLK_FANOUT2]		= &fanout2_clk.common.hw,
+		[CLK_NPU]		= &npu_clk.common.hw,
 	},
+	.num	= CLK_NPU + 1,
 };
 
 static struct ccu_reset_map sun55i_a523_ccu_resets[] = {
diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.h b/drivers/clk/sunxi-ng/ccu-sun55i-a523.h
deleted file mode 100644
index fc8dd42f1b47..000000000000
--- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright 2024 Arm Ltd.
- */
-
-#ifndef _CCU_SUN55I_A523_H
-#define _CCU_SUN55I_A523_H
-
-#include <dt-bindings/clock/sun55i-a523-ccu.h>
-#include <dt-bindings/reset/sun55i-a523-ccu.h>
-
-#define CLK_NUMBER	(CLK_FANOUT2 + 1)
-
-#endif /* _CCU_SUN55I_A523_H */
-- 
2.39.5



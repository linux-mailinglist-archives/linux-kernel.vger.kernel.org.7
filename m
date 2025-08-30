Return-Path: <linux-kernel+bounces-793077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1741DB3CDED
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 19:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9F51897D92
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 17:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12632D375F;
	Sat, 30 Aug 2025 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADz7qX1H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B692D063B;
	Sat, 30 Aug 2025 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756573760; cv=none; b=DrmZCSqDHtBPjedvpBdeF2OSHJgdyTJKHD6z7BjC8KBXJAn9ioOQylS41Lew3UghTzip+K65NdiDEhf8WT0p3tXVLJCle+E52T4sJKX3b6Ja5Uln1wtoUF7yLuZUMzJgu4cIlEv0nBmSLtLPjtj5rbvksyRysSEPj+M4/ax/YmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756573760; c=relaxed/simple;
	bh=4OLevTh3b36nlwjrJIA5aTqk2G4cIdcN5We4TCuVE+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wmsxp9ANtBM8qs9I9xLGe4YMKwL1mfpDiQ1VhCPm4zF5WYyaaLdMmtISnhkWa/Mb7eJEEqeoawTONGEIIbBWwaVbRBQwHPxqol/4cPOlpD+ryNx7q1ThB4X3D1qiaKW/foYM0LBWoIrfp/OVw/AlU9XjKfhr6T/dWbZLkqt2n9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADz7qX1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF3FC4CEF7;
	Sat, 30 Aug 2025 17:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756573759;
	bh=4OLevTh3b36nlwjrJIA5aTqk2G4cIdcN5We4TCuVE+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ADz7qX1HOjj4VOTKZPo4teWE33XK3WTl1vO6KNwr1cBCxvr+seHz8DnXJl4MkXDKk
	 jqW2I37Pfmj2GdypwtLGPj7gORCCqzEHwlgMvyRI7h8ocNjZAuprP+RsP3cq+z8OYb
	 3SlPfqH0yZVY3+uOvNK7G9qYylSsVaX0y9Wh1ktILv90gY98Ef98+IjxMlAM3SFUia
	 xxB04Boc7KyZm9CUjUIDmKnZ+vJaQ/MPof/zglnGp9SfwwQFip29IUYt7mvoWbd2uQ
	 /3k3DqVkDgT7T8MDFe+YHtlLxN/7OAT72xdSAJ+1EOoOvkm9g3AU0NUOjARDcuAQDN
	 4K/nqAjoNW7+Q==
Received: by wens.tw (Postfix, from userid 1000)
	id 4EFF15FD53; Sun, 31 Aug 2025 01:09:17 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-sunxi@lists.linux.dev,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] clk: sunxi-ng: sun55i-a523-ccu: Add missing NPU module clock
Date: Sun, 31 Aug 2025 01:08:57 +0800
Message-Id: <20250830170901.1996227-5-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250830170901.1996227-1-wens@kernel.org>
References: <20250830170901.1996227-1-wens@kernel.org>
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

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 21 ++++++++++++++++++---
 drivers/clk/sunxi-ng/ccu-sun55i-a523.h | 14 --------------
 2 files changed, 18 insertions(+), 17 deletions(-)
 delete mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523.h

diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
index 1a9a1cb869e2..88405b624dc5 100644
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
@@ -1343,7 +1357,7 @@ static struct ccu_common *sun55i_a523_ccu_clks[] = {
 };
 
 static struct clk_hw_onecell_data sun55i_a523_hw_clks = {
-	.num	= CLK_NUMBER,
+	.num	= CLK_NPU + 1,
 	.hws	= {
 		[CLK_PLL_DDR0]		= &pll_ddr_clk.common.hw,
 		[CLK_PLL_PERIPH0_4X]	= &pll_periph0_4x_clk.common.hw,
@@ -1524,6 +1538,7 @@ static struct clk_hw_onecell_data sun55i_a523_hw_clks = {
 		[CLK_FANOUT0]		= &fanout0_clk.common.hw,
 		[CLK_FANOUT1]		= &fanout1_clk.common.hw,
 		[CLK_FANOUT2]		= &fanout2_clk.common.hw,
+		[CLK_NPU]		= &npu_clk.common.hw,
 	},
 };
 
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



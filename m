Return-Path: <linux-kernel+bounces-783499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D46B32E66
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 10:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35BE4245F6C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 08:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AB625FA24;
	Sun, 24 Aug 2025 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="oJYTOiwX"
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F195B25B1D8;
	Sun, 24 Aug 2025 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756024876; cv=none; b=Lgt4b4iguSi3oh5z5KWfvWVxAgJBn5G3s78ebK5b3IslzRM1UKu/3GOWfn83nIBQ4xYwt6A/mUTSxqnRXg38cRHjMFqEUwPw/mgLYmE3CjRzaUf+/AA5K/6+63QDslvGmuCSFV5HOFr6t876oG5o3JpJCWRcjIhT8XvtXys/fbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756024876; c=relaxed/simple;
	bh=EwKVSE+xlhWtppMsIC0wFkFKY+Ek8JZOdL9HhV7w8qQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eAbI3YpCsZSxQifbEYJh5v8dS9DpxDUWdhh94ZtcUPLG7279bFxr5iETJ9XfyFx2h9wfNQkD022PS7A1k+qIHoKbiEV4QCniEGie68CHJL2Ia0+yCLCjj2pZjEbhSrYweQgHK3O/gr04ec4Sdzfm62BgW8RVozzyg8K1MhLZi1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=oJYTOiwX; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1756024843;
	bh=+0D/xtSyclY9YeXodV2ESPW/VNymBxUPSTcmaRsZFQk=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=oJYTOiwX0cJkSJqsbv9PAMLj85cW5waPRAkxBqa7iOO8i4v06uByEcO2PFOLd/YSx
	 i7AfYfFguyT9qB1XJb6ZYhH4tsVv+Z47HRjUFuxB6nM83tjua9Bl/NEnj1xpPzPyJW
	 uBfN86b5ymi1hz8xwQdptt/6gVcxpFYPOsdOyN6c=
X-QQ-mid: zesmtpip4t1756024837t616a7bdf
X-QQ-Originating-IP: PUsKbz+++SlMt/xebBO1hY0S118liMczPg+o1fjZI/g=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 24 Aug 2025 16:40:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9689889897890366230
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Sun, 24 Aug 2025 16:40:01 +0800
Subject: [PATCH RESEND v5 2/2] clk: spacemit: fix sspax_clk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250824-k1-clk-i2s-v5-2-217b6b7cea06@linux.spacemit.com>
References: <20250824-k1-clk-i2s-v5-0-217b6b7cea06@linux.spacemit.com>
In-Reply-To: <20250824-k1-clk-i2s-v5-0-217b6b7cea06@linux.spacemit.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>, 
 Inochi Amaoto <inochiama@outlook.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Yao Zi <ziyao@disroot.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756024814; l=3086;
 i=troy.mitchell@linux.spacemit.com; s=20250712; h=from:subject:message-id;
 bh=EwKVSE+xlhWtppMsIC0wFkFKY+Ek8JZOdL9HhV7w8qQ=;
 b=Glx1thNAZLGwZF+ZRevm8+R6O87PYXOxfak/RqijosoYktJgN4SadVOOB7TzA7d15sqnpnFNj
 OAy5yz77XPgBXfWp/q1GWBFbmWDkYKOX2ioCS3c+xwdTaqoRyC+np7p
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=zhRP1xE0bftrurqSWI+SzcSdJGIZ0BTTY9Id0ESzqlI=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NXtyInqyccVAfA/KTya7VOKhMfGC6hhxYJQGiJRWj77GCTvRq3TB0VXB
	mQe9t6r0sj22nim7Veir8jPLLkubsxsuvq841cNrtF5jnFMFlyPn7dhjAQg2Utg7aFALojl
	XvZ4ygQvG+m2S5YpKOAy25v40OlxMVVP1/ink+wYoSCl9J3Cue2Q4jVKEZljBEVRyVrAZaL
	zEUjOzPh5JGXyVvR1neXvyuVupTQiAixjNtV+1gAq1FWo4bIQCrlNUqjMUQCBS8gOYARGsq
	tprq339vfCtkQvEidW5K5MzlMtCMpE59bg7j1/FL1Z3nOky+3b9uTeLH4fZ5Jv/gL/ZBgw2
	kQ1dk8btAvwPqHmWc+X7/xqo31zcJAkfIxWgNmh2Hz/CWOwmGEqR+aHJUL2+ocZfx/RmcGq
	jmah8I4+DLvrDOMndsl1QVf0ZsOhfdE30dg81/AMczug4q9iTBJRVm450SKpqq5ovpmZuJy
	iCbEV1hh1T/I4Lgx+0LDcubNs8fRo54y+lNBlfp10jAnVqhyJoPOrizSVxuxmxRwU1drm21
	DtX6OkLXUAs3wlwmZ7OY9014G6GSNFqNlbNlCmUMK6fyVOyffQiAy7u+V4y+ItdJsIufo41
	PtYfvgTtYvqVWEtI9Ws8Zp/yHXigesVH8ubEUpHvqDRr7H5lgcq4FhmAWruOkGuRT+PCPa9
	e+T1ELxmaICvYtxvHkvIXm7GFGt9K0tVgIM3VtpnvJfa2GrMtwD4wP/lX6h2fXNHDpEAbto
	jzs+z0yMNxRMpU4vwhgwi+IMozBNvnrpG07Ui0175gwyPFQr8teGW/PJQvKC2567UGKCyAs
	Wnez4drhjD/GkPJyHTtUT2r9oQ39gLgbbCsrqYchHEmbMOXAJ2x1BGp7LK4zlPlgeAvY3d3
	8AK2vCRC0G0NU1Ix1y+cTCzFzCyxa3fvDHJgvxO/dmSGX4fJqeL7EzmC1YKC2ss0zI7nIW1
	zDj4MwJH/UWYKaulQmVqvHt+eVlB9hMATNIVUMi3Ttg2EHXuvZ2pzfUO+LLigYqkdXcAaRF
	0jzxkQvkqTdkjo//Xe58QUsHV1uPK6EmOpuKwI3B0skEMMZTywSZL/+JO58Ul26htjZSRHQ
	4BrldibFiWWiQqkusGPonlz9I3WGVU8LN1conXukj50
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Hardware Requirement:

BIT[3] of this register must be set if need to select i2s_bclk as
SSPA parent clock, to solve this, introduces a new SSPAx_I2S_BCLK
clock as the virtual gate clock.

Fixes: 1b72c59db0add ("clk: spacemit: Add clock support for SpacemiT K1 SoC")
Suggested-by: Yao Zi <ziyao@disroot.org>
Reviewed-by: Haylen Chu <heylenay@4d2.org>
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 drivers/clk/spacemit/ccu-k1.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
index 65e6de030717afa60eefab7bda88f9a13b857650..62cdba516a29f960e15e04642470f55e3d85bfad 100644
--- a/drivers/clk/spacemit/ccu-k1.c
+++ b/drivers/clk/spacemit/ccu-k1.c
@@ -247,7 +247,14 @@ CCU_GATE_DEFINE(aib_clk, CCU_PARENT_NAME(vctcxo_24m), APBC_AIB_CLK_RST, BIT(1),
 
 CCU_GATE_DEFINE(onewire_clk, CCU_PARENT_NAME(vctcxo_24m), APBC_ONEWIRE_CLK_RST, BIT(1), 0);
 
-static const struct clk_parent_data sspa_parents[] = {
+/*
+ * When i2s_bclk is selected as the parent clock of sspa,
+ * the hardware requires bit3 to be set
+ */
+CCU_GATE_DEFINE(sspa0_i2s_bclk, CCU_PARENT_HW(i2s_bclk), APBC_SSPA0_CLK_RST, BIT(3), 0);
+CCU_GATE_DEFINE(sspa1_i2s_bclk, CCU_PARENT_HW(i2s_bclk), APBC_SSPA1_CLK_RST, BIT(3), 0);
+
+static const struct clk_parent_data sspa0_parents[] = {
 	CCU_PARENT_HW(pll1_d384_6p4),
 	CCU_PARENT_HW(pll1_d192_12p8),
 	CCU_PARENT_HW(pll1_d96_25p6),
@@ -255,10 +262,22 @@ static const struct clk_parent_data sspa_parents[] = {
 	CCU_PARENT_HW(pll1_d768_3p2),
 	CCU_PARENT_HW(pll1_d1536_1p6),
 	CCU_PARENT_HW(pll1_d3072_0p8),
-	CCU_PARENT_HW(i2s_bclk),
+	CCU_PARENT_HW(sspa0_i2s_bclk),
 };
-CCU_MUX_GATE_DEFINE(sspa0_clk, sspa_parents, APBC_SSPA0_CLK_RST, 4, 3, BIT(1), 0);
-CCU_MUX_GATE_DEFINE(sspa1_clk, sspa_parents, APBC_SSPA1_CLK_RST, 4, 3, BIT(1), 0);
+CCU_MUX_GATE_DEFINE(sspa0_clk, sspa0_parents, APBC_SSPA0_CLK_RST, 4, 3, BIT(1), 0);
+
+static const struct clk_parent_data sspa1_parents[] = {
+	CCU_PARENT_HW(pll1_d384_6p4),
+	CCU_PARENT_HW(pll1_d192_12p8),
+	CCU_PARENT_HW(pll1_d96_25p6),
+	CCU_PARENT_HW(pll1_d48_51p2),
+	CCU_PARENT_HW(pll1_d768_3p2),
+	CCU_PARENT_HW(pll1_d1536_1p6),
+	CCU_PARENT_HW(pll1_d3072_0p8),
+	CCU_PARENT_HW(sspa1_i2s_bclk),
+};
+CCU_MUX_GATE_DEFINE(sspa1_clk, sspa1_parents, APBC_SSPA1_CLK_RST, 4, 3, BIT(1), 0);
+
 CCU_GATE_DEFINE(dro_clk, CCU_PARENT_HW(apb_clk), APBC_DRO_CLK_RST, BIT(1), 0);
 CCU_GATE_DEFINE(ir_clk, CCU_PARENT_HW(apb_clk), APBC_IR_CLK_RST, BIT(1), 0);
 CCU_GATE_DEFINE(tsen_clk, CCU_PARENT_HW(apb_clk), APBC_TSEN_CLK_RST, BIT(1), 0);
@@ -865,6 +884,8 @@ static struct clk_hw *k1_ccu_apbc_hws[] = {
 	[CLK_SSPA1_BUS]		= &sspa1_bus_clk.common.hw,
 	[CLK_TSEN_BUS]		= &tsen_bus_clk.common.hw,
 	[CLK_IPC_AP2AUD_BUS]	= &ipc_ap2aud_bus_clk.common.hw,
+	[CLK_SSPA0_I2S_BCLK]	= &sspa0_i2s_bclk.common.hw,
+	[CLK_SSPA1_I2S_BCLK]	= &sspa1_i2s_bclk.common.hw,
 };
 
 static const struct spacemit_ccu_data k1_ccu_apbc_data = {

-- 
2.50.1



Return-Path: <linux-kernel+bounces-756464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 218BCB1B4B1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE2D3BBA0F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568AB2750E7;
	Tue,  5 Aug 2025 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="gPRmjtcF"
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33872749E8;
	Tue,  5 Aug 2025 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399844; cv=none; b=TN67hRcC+QZch+eE0r7IsN2/MZraxP9ICA/scz58U2hlV7NkS+hohuhZu8R/Z1yAO+uGPqR4A6JQu7dsw7BViLa2BpdofxH3w26f98vOgX0dkDh0mtkUl5qa1yyUohtyMTgB5LhqzWQt2QAm4E8sJoFc0r9Oq4THWZilYoLbZ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399844; c=relaxed/simple;
	bh=GXDLqZ9n8KfIJNwv8n0LBseFgDTIjbKd+WPaDTIUSTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COnqlUPm0n7iuUBU+OaE6U2XK9fqfHS6l4mR7Qsh8zrgQM7zZuFq9Ejzq/Rj1HvTx1CmCGngtePPDc6pD4jeLfxW/vCK10KZClyKpyydSu8QGSBx6RcJzuk74QHLKmmNiMebgyGq6+XPuyJG5l4lE9uHypcOjA167wB9S+/31BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=gPRmjtcF; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1754399817;
	bh=uKRpwftHd76ByzGCZwStgONS7ug7yWYWivbpDDIKLDM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=gPRmjtcFZIBvcf4kfA2Jn5jj5E45wBKOivzeUG5hPLzQXd4zShfMSq1dcnZCii4bs
	 ZRykz/awaPcBbUGHNtdB4LeutACzV8McUnY4YoLCyhnHIaAoLJ8PIBnUMe9WkXKS07
	 AYC4tgGMOLDGrK/v0sYprNy6HqWGi91S0puRLQv4=
X-QQ-mid: zesmtpip2t1754399812tfdd1d4e4
X-QQ-Originating-IP: v37YLt7kMBXvE8kdPSfrSPPwxyTY26MVd1UE+ZktKOw=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 05 Aug 2025 21:16:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11721054069434364327
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: troy.mitchell@linux.spacemit.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlan@gentoo.org,
	elder@riscstar.com,
	heylenay@4d2.org,
	inochiama@outlook.com,
	krzk+dt@kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	mturquette@baylibre.com,
	robh@kernel.org,
	sboyd@kernel.org,
	spacemit@lists.linux.dev,
	ziyao@disroot.org
Subject: [PATCH v4 2/2] clk: spacemit: fix sspax_clk
Date: Tue,  5 Aug 2025 21:16:46 +0800
Message-ID: <E801E7AF425E08C7+20250805131646.2216375-1-troy.mitchell@linux.spacemit.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250805-k1-clk-i2s-v4-0-038181284dd4@linux.spacemit.com>
References: <20250805-k1-clk-i2s-v4-0-038181284dd4@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NOIkHYnr7VzduGTDUA6sSxXnskMShZ49WC7yc4MwFchWXBEOWt2lOsWL
	CXQql0tErv+Ekm7CgkH/Lhrfu2TYBHY3RkDEuVQyP/rXbYV6tgUhisydoh6DSoY6pB7Nl48
	EOQINuC1n6LS3kPLBUyCjesQWMFGDK3xuelTopgtX5SBPOXI8U+ZsOqd/EWQjiP7UPVxJ+a
	O2GEnu+yy4vin8hD4A/8LkEDiDS85oaZcyq/8c8Mz8aheWNfhIW6w5PCJ6SmgHqi3nZH1Rz
	IQIvYo03XhLKcVAITNMyaBWMLyjs+lu2iDsqGDNEJG+4X4wB7/uiG9eoIhYt7g5Kn+aEYoB
	4F1vFjKUY72F7zThaNgRFf92bGzLf3wA+emCnu0vnNHaABADgLOVB1BXlUcfaMEsImwjjPr
	F/LIir8oby04L5R0f1F+9EPI4Tasnv2mymV9GjL8eSvtlJdiYiAU6kgjXx2lAMSvI9qsVx3
	AvlyQqf8hwGGSBdsd/QaYENThMqsBegRcRQomkTBQYt4c78o2olw2gnha1sbSwCvB17lycj
	wc8mmTUFlOoupWyCpOnamnJmlwGivFN3oMsHByTxf9oWRNNf67cPIj5Qk3fViTj/l6DCrEx
	V5WsSNuNB4OBSRvYO+erk0LOa4EBYPt/YJqEZ/R6RpL0VPuza7zO/q3LDBOBVqkNpfQJsd5
	7drK+5VxEZGn9aXWuLHP+ckCDW7V5gXGV1ebz+kWb/QNcbNyuptf0bbT+ZPAIyv2NvoAZBj
	B1D8XIo6/U1H8GVJQTFTcqBXx/Y0frEhuao1+OhwTfbTFVEGZWo0z4VjyKL+JNOs1wY1neH
	JN1y0rCs5YZ5ue1lnk233ImlFFBJiaF4lQlVfqxliNqU5uylNIYLGUePkwhwXZeFPPqHuZK
	SAItQVfqCiccYZI7OI3cTjKUGC2PXaXEAsVmbeMnfXH9W+dwMHEHspU/7z8Nvb3Zyx6rVnq
	eTTHtao6Mcu5JNogecmIgWkAkB1jPKStYmu2oXYSRwPJzndZuNhXw8RgLxm9GxJehqZGw1u
	XhXJ48YHp922M7yb9NeCgcpJTu+y+5MxDAZu7zAH2aES1Uvs8tobxvdUwMCN2ijy5wt3r3v
	NAKisuJdhs+
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Hardware Requirement:
When FNCLKSEL in APBC_SSPAX_CLK_RST is set to 7 (3'b111),
BIT3 must be set to 1 for the SSPAx parent clock to be I2S_BCLK.

This patch introduces SSPAx_I2S_BCLK as a virtual gate to enable BIT3.

Suggested-by: Yao Zi <ziyao@disroot.org>
Reviewed-by: Haylen Chu <heylenay@4d2.org>
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 drivers/clk/spacemit/ccu-k1.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
index cdde37a05235..4a91d28da2fb 100644
--- a/drivers/clk/spacemit/ccu-k1.c
+++ b/drivers/clk/spacemit/ccu-k1.c
@@ -349,7 +349,14 @@ CCU_GATE_DEFINE(aib_clk, CCU_PARENT_NAME(vctcxo_24m), APBC_AIB_CLK_RST, BIT(1),
 
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
@@ -357,10 +364,22 @@ static const struct clk_parent_data sspa_parents[] = {
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
@@ -965,6 +984,8 @@ static struct clk_hw *k1_ccu_apbc_hws[] = {
 	[CLK_SSPA1_BUS]		= &sspa1_bus_clk.common.hw,
 	[CLK_TSEN_BUS]		= &tsen_bus_clk.common.hw,
 	[CLK_IPC_AP2AUD_BUS]	= &ipc_ap2aud_bus_clk.common.hw,
+	[CLK_SSPA0_I2S_BCLK]	= &sspa0_i2s_bclk.common.hw,
+	[CLK_SSPA1_I2S_BCLK]	= &sspa1_i2s_bclk.common.hw,
 };
 
 static const struct spacemit_ccu_data k1_ccu_apbc_data = {
-- 
2.50.0



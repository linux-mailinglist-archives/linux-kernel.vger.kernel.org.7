Return-Path: <linux-kernel+bounces-875375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE58CC18D12
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0BD51C66787
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE163112C2;
	Wed, 29 Oct 2025 07:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=yuji2.ishikawa@toshiba.co.jp header.b="NkAaHME4"
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1802.securemx.jp [210.130.202.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EE231195F;
	Wed, 29 Oct 2025 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761724708; cv=none; b=dV7HlPQRRy4rrcNUTJyt2F3GA5eZSXGEsIQIma5Yqdep9tlc6GIY6NkAXjtAAX94pcINemosHTR4vgkicS2InR16kR3AIUh2JwlxAlz07t2CSTXL1aZ+YUqNCk5Ot//iuFzWyyAgx+uGQUSLlVo6tJYUNgh+zh8SlxpX2k9wz3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761724708; c=relaxed/simple;
	bh=XQbm9gT0FmsvNn/DCDwiVeIZ+/JgLi9QBanOXYYx3M4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MMG6cR0HZFhJ3x8ht76RpvK/96lbSmeLsdw+3N+bpeqOPWYmqxj2aw+SIe+/xnu9moRj+XpZiM/HKfAEiW4w7aB+SXAG837eEKW3ZSdD4iMyTzS33vWFaCSgGKKedRJbVMoNulhEdVqV9oYdnf7pNnudMBZLJrcuWdxdxaZHocs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=yuji2.ishikawa@toshiba.co.jp header.b=NkAaHME4; arc=none smtp.client-ip=210.130.202.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1802) id 59T6JjeM2015011; Wed, 29 Oct 2025 15:19:45 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding;i=yuji2.ishikawa@toshiba.co.jp;s=key1.smx;t=
	1761718755;x=1762928355;bh=XQbm9gT0FmsvNn/DCDwiVeIZ+/JgLi9QBanOXYYx3M4=;b=NkA
	aHME4WgdZ7HUujpiLX+NIB4iI1nTVQSXiXv/6MO5bBDcP4r+mZH19HjpSCi6LjbF+7zyLVFINqLIp
	DIXVVdxsucADivJDWH4yEavDpaAQ/Uzcqmc8aqnHf1q8V4xIesR1I9rrukTPJC76psKbPw5OLKppT
	kyGI/ZzpZqDqNl/gxZJOQjEYjlbDe9xTZDT2jH3xrSCleFSGo9G5FjIoN6AhPoe4jAuyWYHILVRoC
	plYvTl1okMVlqSdqEVb82TpmICTfYpdMhLvLuHGuIq0pgschGYdJq6P2WelqDg7TvBXtGjls8pY5s
	Eq5pcM4a1kUvbwmnRGfyZ1AuGP8YpDg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 59T6JEMD1316549; Wed, 29 Oct 2025 15:19:14 +0900
X-Iguazu-Qid: 2yAbDoX6mRH41gehdo
X-Iguazu-QSIG: v=2; s=0; t=1761718753; q=2yAbDoX6mRH41gehdo; m=pclAYtZ7pBrHZt8LYmpYud/jNnTsExEG04RaG1tDPQk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cxHBm4wzRz1xnc; Wed, 29 Oct 2025 15:19:12 +0900 (JST)
X-SA-MID: 53851528
From: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Subject: [PATCH v2 2/2] clk: visconti: Add definition of VIIF on Toshiba Visconti TMPV770x SoC
Date: Wed, 29 Oct 2025 15:13:44 +0900
X-TSB-HOP2: ON
Message-Id: <20251029061344.451222-3-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029061344.451222-1-yuji2.ishikawa@toshiba.co.jp>
References: <20251029061344.451222-1-yuji2.ishikawa@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the control sequence of register bits to handle the clocks and the
resets of Video Input Interface.

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
---
Changelog v2:
- Update clk_gate_tables to reflect changes in bindings identifiers.
---
 drivers/clk/visconti/clkc-tmpv770x.c | 71 ++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/clk/visconti/clkc-tmpv770x.c b/drivers/clk/visconti/clkc-tmpv770x.c
index 6c753b2cb..b3f4de671 100644
--- a/drivers/clk/visconti/clkc-tmpv770x.c
+++ b/drivers/clk/visconti/clkc-tmpv770x.c
@@ -28,6 +28,10 @@ static const struct clk_parent_data pietherplls_parent_data[] = {
 	{ .fw_name = "pietherpll", .name = "pietherpll", },
 };
 
+static const struct clk_parent_data pidnnplls_parent_data[] = {
+	{ .fw_name = "pidnnpll", .name = "pidnnpll", },
+};
+
 static const struct visconti_fixed_clk fixed_clk_tables[] = {
 	/* PLL1 */
 	/* PICMPT0/1, PITSC, PIUWDT, PISWDT, PISBUS, PIPMU, PIGPMU, PITMU */
@@ -64,6 +68,41 @@ static const struct visconti_clk_gate_table pietherpll_clk_gate_tables[] = {
 		TMPV770X_RESET_PIETHER_125M, },
 };
 
+static const struct visconti_clk_gate_table pidnnpll_clk_gate_tables[] = {
+	{ TMPV770X_CLK_VIIFBS0, "viifbs0",
+		pidnnplls_parent_data, ARRAY_SIZE(pidnnplls_parent_data),
+		0, 0x58, 0x158, 1, 1,
+		NO_RESET, },
+	{ TMPV770X_CLK_VIIFBS0_PROC, "viifbs0_proc",
+		pidnnplls_parent_data, ARRAY_SIZE(pidnnplls_parent_data),
+		0, 0x58, 0x158, 18, 1,
+		NO_RESET, },
+	{ TMPV770X_CLK_VIIFBS0_L1ISP, "viifbs0_l1isp",
+		pidnnplls_parent_data, ARRAY_SIZE(pidnnplls_parent_data),
+		0, 0x58, 0x158, 17, 1,
+		NO_RESET, },
+	{ TMPV770X_CLK_VIIFBS0_L2ISP, "viifbs0_l2isp",
+		pidnnplls_parent_data, ARRAY_SIZE(pidnnplls_parent_data),
+		0, 0x58, 0x158, 16, 1,
+		NO_RESET, },
+	{ TMPV770X_CLK_VIIFBS1, "viifbs1",
+		pidnnplls_parent_data, ARRAY_SIZE(pidnnplls_parent_data),
+		0, 0x58, 0x158, 5, 1,
+		NO_RESET, },
+	{ TMPV770X_CLK_VIIFBS1_PROC, "viifbs1_proc",
+		pidnnplls_parent_data, ARRAY_SIZE(pidnnplls_parent_data),
+		0, 0x58, 0x158, 22, 1,
+		NO_RESET, },
+	{ TMPV770X_CLK_VIIFBS1_L1ISP, "viifbs1_l1isp",
+		pidnnplls_parent_data, ARRAY_SIZE(pidnnplls_parent_data),
+		0, 0x58, 0x158, 21, 1,
+		NO_RESET, },
+	{ TMPV770X_CLK_VIIFBS1_L2ISP, "viifbs1_l2isp",
+		pidnnplls_parent_data, ARRAY_SIZE(pidnnplls_parent_data),
+		0, 0x58, 0x158, 20, 1,
+		NO_RESET, },
+};
+
 static const struct visconti_clk_gate_table clk_gate_tables[] = {
 	{ TMPV770X_CLK_HOX, "hox",
 		clks_parent_data, ARRAY_SIZE(clks_parent_data),
@@ -185,6 +224,22 @@ static const struct visconti_clk_gate_table clk_gate_tables[] = {
 		clks_parent_data, ARRAY_SIZE(clks_parent_data),
 		0, 0x14, 0x114, 0, 4,
 		TMPV770X_RESET_SBUSCLK, },
+	{ TMPV770X_CLK_VIIF0_CFGCLK, "csi2rx0cfg",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x58, 0x158, 0, 24,
+		NO_RESET, },
+	{ TMPV770X_CLK_VIIF0_APBCLK, "csi2rx0apb",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x58, 0x158, 2, 4,
+		NO_RESET, },
+	{ TMPV770X_CLK_VIIF1_CFGCLK, "csi2rx1cfg",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x58, 0x158, 4, 24,
+		NO_RESET, },
+	{ TMPV770X_CLK_VIIF1_APBCLK, "csi2rx1apb",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x58, 0x158, 6, 4,
+		NO_RESET, },
 };
 
 static const struct visconti_reset_data clk_reset_data[] = {
@@ -220,6 +275,14 @@ static const struct visconti_reset_data clk_reset_data[] = {
 	[TMPV770X_RESET_PIPCMIF]	= { 0x464, 0x564, 0, },
 	[TMPV770X_RESET_PICKMON]	= { 0x410, 0x510, 8, },
 	[TMPV770X_RESET_SBUSCLK]	= { 0x414, 0x514, 0, },
+	[TMPV770X_RESET_VIIFBS0]	= { 0x458, 0x558, 0, },
+	[TMPV770X_RESET_VIIFBS0_APB]	= { 0x458, 0x558, 1, },
+	[TMPV770X_RESET_VIIFBS0_L2ISP]	= { 0x458, 0x558, 16, },
+	[TMPV770X_RESET_VIIFBS0_L1ISP]	= { 0x458, 0x558, 17, },
+	[TMPV770X_RESET_VIIFBS1]	= { 0x458, 0x558, 4, },
+	[TMPV770X_RESET_VIIFBS1_APB]	= { 0x458, 0x558, 5, },
+	[TMPV770X_RESET_VIIFBS1_L2ISP]	= { 0x458, 0x558, 20, },
+	[TMPV770X_RESET_VIIFBS1_L1ISP]	= { 0x458, 0x558, 21, },
 };
 
 static int visconti_clk_probe(struct platform_device *pdev)
@@ -272,6 +335,14 @@ static int visconti_clk_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = visconti_clk_register_gates(ctx, pidnnpll_clk_gate_tables,
+				    ARRAY_SIZE(pidnnpll_clk_gate_tables),
+				    clk_reset_data, &tmpv770x_clk_lock);
+	if (ret) {
+		dev_err(dev, "Failed to register pidnnpll clock gate: %d\n", ret);
+		return ret;
+	}
+
 	return of_clk_add_hw_provider(np, of_clk_hw_onecell_get, &ctx->clk_data);
 }
 
-- 
2.34.1




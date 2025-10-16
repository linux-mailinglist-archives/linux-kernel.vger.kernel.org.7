Return-Path: <linux-kernel+bounces-855471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E01FBE15AA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 05:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 806C54EB16D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 03:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6502135B8;
	Thu, 16 Oct 2025 03:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=yuji2.ishikawa@toshiba.co.jp header.b="mMeIQAw3"
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1801.securemx.jp [210.130.202.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AE51DDF7;
	Thu, 16 Oct 2025 03:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760585229; cv=none; b=WF8flhyYC1bSdp64VxfV2yNudM8Aw9nLLWugSly/eUDrwFsIguetsVZb35urLdAVteg1Qr8SHqsb6UzcrQiHGVT3hh4tFMcjoLEYCeNsMTNkyHqoZZLEhRXmWXSXDP3VQMeVGgZwqOEUkgISEuUDbOw+t6SBdVXz9dKlOjb0EiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760585229; c=relaxed/simple;
	bh=KF95KHIF5n/NWiouxrR5rmaymihnIGb3Q0Ytf6BThGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XIkcWwSpCXw/H9aR0Cfqa3uIi2IgsnUKFGWXnN5oaIQUaMxNkphMWnKJZWPgwd5NLMywnMciO0BKDk+4LsIHgSo3Pj7wzbm0YK4HvlPRsBPWEH/OyxUTFM/wDfq/y0XsIbGZh0qc/aPK1gl1frnsEGVnaiSuZx3AXXCFAX1BcSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=yuji2.ishikawa@toshiba.co.jp header.b=mMeIQAw3; arc=none smtp.client-ip=210.130.202.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1801) id 59G1dv5b2725744; Thu, 16 Oct 2025 10:39:57 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding;i=yuji2.ishikawa@toshiba.co.jp;s=key1.smx;t=
	1760578761;x=1761788361;bh=KF95KHIF5n/NWiouxrR5rmaymihnIGb3Q0Ytf6BThGw=;b=mMe
	IQAw312Oe3tLd2Nl0dF0+9zwfXtYrTkqD3w4nCAZAXhKyFJrsF0CVFs0dmO29p0hNOLvZNCIzKZFq
	LIrzeL19Nlhl4iKfEm5qPDcXDxR8JE966yfcQWBBes538C6rY4udwMTQYQk4NGxWm1rMCFnUfYCHd
	0UNh2qC6wucKmmmzB2uokxWT4FFrkftzzk4nqhZUV9JGa5HdczhqXX/64JB2Nk3KzWRthJb0maP5l
	oUO68kX7fUjNBiUYVdYSmWq5YJVeABQEzofZ5sb+O7E/4/l+8qA5ixXWwUzUpu7tVOALj6qqLAk67
	8E1GZp57se7TSmC8xu0G65poz6v0Hjw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 59G1dJcC3273527; Thu, 16 Oct 2025 10:39:19 +0900
X-Iguazu-Qid: 2yAbS6oRblA7hVjuDT
X-Iguazu-QSIG: v=2; s=0; t=1760578759; q=2yAbS6oRblA7hVjuDT; m=a/gZ+VdfESH340MKbFeYWjJkiTiKn1u2fVvkgx1fU+o=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cn9bp24k6z1xnf; Thu, 16 Oct 2025 10:39:18 +0900 (JST)
X-SA-MID: 53068316
From: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] clk: visconti: Add definition of VIIF on Toshiba Visconti TMPV770x SoC
Date: Thu, 16 Oct 2025 10:33:28 +0900
X-TSB-HOP2: ON
Message-Id: <20251016013328.303611-3-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251016013328.303611-1-yuji2.ishikawa@toshiba.co.jp>
References: <20251016013328.303611-1-yuji2.ishikawa@toshiba.co.jp>
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
 drivers/clk/visconti/clkc-tmpv770x.c | 71 ++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/clk/visconti/clkc-tmpv770x.c b/drivers/clk/visconti/clkc-tmpv770x.c
index 6c753b2cb5..26cdfa565e 100644
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
+	{ TMPV770X_CLK_VIIFBS0_PROC, "viif0bsproc",
+		pidnnplls_parent_data, ARRAY_SIZE(pidnnplls_parent_data),
+		0, 0x58, 0x158, 1, 1,
+		NO_RESET, },
+	{ TMPV770X_CLK_VIIF0_PROC, "viif0proc",
+		pidnnplls_parent_data, ARRAY_SIZE(pidnnplls_parent_data),
+		0, 0x58, 0x158, 18, 1,
+		NO_RESET, },
+	{ TMPV770X_CLK_VIIF0_L1ISP, "viif0l1isp",
+		pidnnplls_parent_data, ARRAY_SIZE(pidnnplls_parent_data),
+		0, 0x58, 0x158, 17, 1,
+		NO_RESET, },
+	{ TMPV770X_CLK_VIIF0_L2ISP, "viif0l2isp",
+		pidnnplls_parent_data, ARRAY_SIZE(pidnnplls_parent_data),
+		0, 0x58, 0x158, 16, 1,
+		NO_RESET, },
+	{ TMPV770X_CLK_VIIFBS1_PROC, "viif1bsproc",
+		pidnnplls_parent_data, ARRAY_SIZE(pidnnplls_parent_data),
+		0, 0x58, 0x158, 5, 1,
+		NO_RESET, },
+	{ TMPV770X_CLK_VIIF1_PROC, "viif1proc",
+		pidnnplls_parent_data, ARRAY_SIZE(pidnnplls_parent_data),
+		0, 0x58, 0x158, 22, 1,
+		NO_RESET, },
+	{ TMPV770X_CLK_VIIF1_L1ISP, "viif1l1isp",
+		pidnnplls_parent_data, ARRAY_SIZE(pidnnplls_parent_data),
+		0, 0x58, 0x158, 21, 1,
+		NO_RESET, },
+	{ TMPV770X_CLK_VIIF1_L2ISP, "viif1l2isp",
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
+	{ TMPV770X_CLK_VIIFBS0_CFG, "csi2rx0cfg",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x58, 0x158, 0, 24,
+		NO_RESET, },
+	{ TMPV770X_CLK_VIIFBS0_APB, "csi2rx0apb",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x58, 0x158, 2, 4,
+		NO_RESET, },
+	{ TMPV770X_CLK_VIIFBS1_CFG, "csi2rx1cfg",
+		clks_parent_data, ARRAY_SIZE(clks_parent_data),
+		0, 0x58, 0x158, 4, 24,
+		NO_RESET, },
+	{ TMPV770X_CLK_VIIFBS1_APB, "csi2rx1apb",
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
2.43.0




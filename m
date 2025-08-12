Return-Path: <linux-kernel+bounces-764049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FBDB21D5D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22BC16A318
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBBB2E7168;
	Tue, 12 Aug 2025 05:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="XfHOBXNk"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8062E5407;
	Tue, 12 Aug 2025 05:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754977486; cv=pass; b=TesWktHmnSyFrdM8V6Sksqfo7QJVv7ukXO3/GIbsK/wifvmdTBN0g3fnDEtJzEaat5DfXqmXGlf5Wg2mLNoU9zwq3KDNGwtJdscWAeOZOFWuTxqRWsQs9Hl2F8hzNbc1eP8iEm3p9n1tlTSQQ4LL8TRqF3GV1STuaZI1FMknh7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754977486; c=relaxed/simple;
	bh=/0GKlmKPf9OIDeLDdM+TlP8fVa2Np9w3HM91T90VPy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6jytOY+JXu6Tf/OPqQmTDMBDWNDkFOjKr8/DDhHyKH2/xsoGhE+wsq5uy8wuW6rYoWDw6aMybidbnVWsFx/Oe6eoHVl3Vt3PLdbRRtL7UxQnSUlIy8xmK2YOCjF6ANZP1hDzpxTNWRLAgdCg6h+pfh9C2kC4kRHFprkBaJVslw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=XfHOBXNk; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1754977468; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GTOk9dSM/nldXsxlkCoBezuU6yI7FxzYJgGHhiopghUuMo+to2DNjf5ikbZ9jK9CePc4iDnK4WLLg3etDYF0A4j3LyqKzVU+HcpKFRCT/iav4QaOQFfbVddA/Yapa8PtQXt8z5RQG0yabD6CDbbA58D3ZIP7l9sDdhiBvkpr+yc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754977468; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6fYvGF/ZMDrhZnjggXvZnM2YjJQQ/SQWPvQ9u+iXNEY=; 
	b=FXuBQQsOPp5bzW734qs+2liLxhhAQk1UWWuCkSOGrGwvpTI0oWwtukcKDUovwideS9a5uxFahM9q0pzNvWVeG+USWhMSONc+gEMbhXB2GhCIIGT4bSef8XHPqfKcWcxXiTmLM/V98rQ6/9cf1wDccQoHwMSWszKSdHAvyMtwtQo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754977468;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=6fYvGF/ZMDrhZnjggXvZnM2YjJQQ/SQWPvQ9u+iXNEY=;
	b=XfHOBXNkw2v+MZCs2CW3OLdOIfZCoNjYoibHbTr9DNxEjbCREf7vC++ziz/tNPqV
	k/qvl94ylJke/10p9Rm3SYiYWet43KdoY0O8xoeIptW47PjoZzSKpDb9J7C6sEvaYDs
	/OaDzaFmg2p47cP7Ig0loPTMpD8Baf7qYWNeKcQqkWogiWmLr2NKWesu9jVfxqNFBR8
	dka8JflZOp7BQys2+Qj+2IY/62sBa8pop/usE21JQC78SwA3a5o2PMUpz2tPIhoRujY
	I0rHTjh+k0N2dW8oCzlhJPDLngTLYUz5zGpDk0Jfc19WF+KWyKReWVERYWR2IxibI4m
	MicNnxSe7A==
Received: by mx.zohomail.com with SMTPS id 1754977466694911.6346152553465;
	Mon, 11 Aug 2025 22:44:26 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 4/4] clk: thead: th1520-ap: fix parent of padctrl0 clock
Date: Tue, 12 Aug 2025 13:42:58 +0800
Message-ID: <20250812054258.1968351-5-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812054258.1968351-1-uwu@icenowy.me>
References: <20250812054258.1968351-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The padctrl0 clock seems to be a child of the perisys_apb4_hclk clock,
gating the later makes padctrl0 registers stuck.

Fix this relationship.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 drivers/clk/thead/clk-th1520-ap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index 0117e5ea1bf58..19f6b0285390d 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -917,6 +917,11 @@ static CCU_GATE(CLK_PERISYS_APB3_HCLK, perisys_apb3_hclk, "perisys-apb3-hclk", p
 		0x150, BIT(11), CLK_IS_CRITICAL);
 static CCU_GATE(CLK_PERISYS_APB4_HCLK, perisys_apb4_hclk, "perisys-apb4-hclk", perisys_ahb_hclk_pd,
 		0x150, BIT(12), 0);
+
+static const struct clk_parent_data perisys_apb4_hclk_pd[] = {
+	{ .hw = &perisys_apb4_hclk.common.hw },
+};
+
 static CCU_GATE(CLK_NPU_AXI, npu_axi_clk, "npu-axi", axi_aclk_pd, 0x1c8, BIT(5), 0);
 static CCU_GATE(CLK_CPU2VP, cpu2vp_clk, "cpu2vp", axi_aclk_pd, 0x1e0, BIT(13), 0);
 static CCU_GATE(CLK_NPU_AXI, npu_axi_clk, "npu-axi", axi_aclk_pd, 0x1c8, BIT(5), CLK_IS_CRITICAL);
@@ -925,7 +930,7 @@ static CCU_GATE(CLK_EMMC_SDIO, emmc_sdio_clk, "emmc-sdio", emmc_sdio_ref_clk_pd,
 static CCU_GATE(CLK_GMAC1, gmac1_clk, "gmac1", gmac_pll_clk_pd, 0x204, BIT(26), 0);
 static CCU_GATE(CLK_PADCTRL1, padctrl1_clk, "padctrl1", perisys_apb_pclk_pd, 0x204, BIT(24), 0);
 static CCU_GATE(CLK_DSMART, dsmart_clk, "dsmart", perisys_apb_pclk_pd, 0x204, BIT(23), 0);
-static CCU_GATE(CLK_PADCTRL0, padctrl0_clk, "padctrl0", perisys_apb_pclk_pd, 0x204, BIT(22), 0);
+static CCU_GATE(CLK_PADCTRL0, padctrl0_clk, "padctrl0", perisys_apb4_hclk_pd, 0x204, BIT(22), 0);
 static CCU_GATE(CLK_GMAC_AXI, gmac_axi_clk, "gmac-axi", axi4_cpusys2_aclk_pd, 0x204, BIT(21), 0);
 static CCU_GATE(CLK_GPIO3, gpio3_clk, "gpio3-clk", peri2sys_apb_pclk_pd, 0x204, BIT(20), 0);
 static CCU_GATE(CLK_GMAC0, gmac0_clk, "gmac0", gmac_pll_clk_pd, 0x204, BIT(19), 0);
-- 
2.50.1



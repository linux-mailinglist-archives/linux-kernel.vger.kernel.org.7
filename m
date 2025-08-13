Return-Path: <linux-kernel+bounces-767252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD007B251AE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16AFA7BE75F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AE729A31A;
	Wed, 13 Aug 2025 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="fsJES7vx"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F962298CDE;
	Wed, 13 Aug 2025 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755105140; cv=pass; b=JsgJC8baUv1Jn+V/K+hofR6eesHvbd1MOAaY5KJjxubTKuMhAWCmAt2SBZ3dPWHAcIu765ZFMLs9RLZdFpM8IRveA2J3OZ0bGajui3Q2dxpndrson/tSYicbHmOdQfQPCw95L7oYsHhl76TGXxMeLE1SVxt/eFGfVO5L9JqYYo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755105140; c=relaxed/simple;
	bh=lq4E8uDYxybf6MBYCQF96tK/11IoWCGiggBaoiTpEDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQDhhRSYmBpTwpq1o1YNcz3m+jF/V09wRFEzLaUrkXwoIoJCucwZOCPCtkGj/uI97pk/LpvBT1RpXL3odIY+yoKu46HUb21Oa8OwV0Y6ee4fE+PBJzCuHG5AEy1dzwWDKVhLyer0cxRMDdvmY1IkLp0Axk82Nd0aKakDFT9sDnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=fsJES7vx; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755105123; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=X74hhdnBJMAtasZ6RnolPQcFaxE7Qj7hEqUs5Sndo7Dyjs+bBQPvi6CHau51knFzlPrb9zKJ1ICjPuNdBw48d21h34KZzE/52liJReh6N3JQ7b8iHwxkLeLCI/pbZMyJAvzprf+Gsc28wm6m50JhXW3axNE22aLxXeHxCvRKitY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755105123; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AH26u+CRfsSyZs8D6QdA2w4FMIPclZcydL3ktbsJNXY=; 
	b=RyjvCwFy2si5Z9Vi7gDR6eJat3gBpIIDLNREz4+EtzAiQ9CZPJIucgO6uZ30L3/tJBOvlC1HTUHJz2QMiaJAfwwcML5xh7mUWmcqZV0FNb5cZOr3J9oEIB8r3xfNkzg4Es/Mom8hl1D5HegBVJg615VmNd1ZpfkRv3UofGZZI1A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755105123;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=AH26u+CRfsSyZs8D6QdA2w4FMIPclZcydL3ktbsJNXY=;
	b=fsJES7vxoUPtH68zK3KoG9hjar1y61p8w7je1P/N8KBhkdKuxsVGebeknwfZBPcf
	/4N0xH3ig0xIMwyMWmNtamVE4ZNBsropBdk720NSS6bLS5v8p+rkAMvlgSx+xJ6I6lB
	oFMLTaQXCcw7sHxNuZykWASLzI1P5KwAJ2elWV6HIOCdeKHKAFCmplM3fRRa4/hUTTS
	KE0eUtIDXUAayZQa6sfzyuHQ+L9QL0WEUI8H9I8qwW8pDz62QYCZDyKNj5XMPiK8OSh
	acSVYCHxknQz85ttCwmVY8z5+pROIvbr305dSVovcu/8gL8eo0lXSGdbo7ipUhdTUHS
	IaBILJO+Tg==
Received: by mx.zohomail.com with SMTPS id 1755105121243515.2930883745289;
	Wed, 13 Aug 2025 10:12:01 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>,
	Yao Zi <ziyao@disroot.org>,
	Han Gao <rabenda.cn@gmail.com>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 2/2] clk: thead: th1520-ap: fix parent of padctrl0 clock
Date: Thu, 14 Aug 2025 01:11:36 +0800
Message-ID: <20250813171136.2213309-3-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813171136.2213309-1-uwu@icenowy.me>
References: <20250813171136.2213309-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The padctrl0 clock seems to be a child of the perisys_apb4_hclk clock,
gating the later makes padctrl0 registers stuck too.

Fix this relationship.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 drivers/clk/thead/clk-th1520-ap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index d08e7fb387e50..f6f3d63d53353 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -888,13 +888,16 @@ static CCU_GATE(CLK_PERISYS_APB3_HCLK, perisys_apb3_hclk, "perisys-apb3-hclk", p
 		0x150, 11, CLK_IS_CRITICAL);
 static CCU_GATE(CLK_PERISYS_APB4_HCLK, perisys_apb4_hclk, "perisys-apb4-hclk", perisys_ahb_hclk_pd,
 		0x150, 12, 0);
+static const struct clk_parent_data perisys_apb4_hclk_pd[] = {
+	{ .hw = &perisys_apb4_hclk.gate.hw },
+};
 static CCU_GATE(CLK_NPU_AXI, npu_axi_clk, "npu-axi", axi_aclk_pd, 0x1c8, 5, CLK_IS_CRITICAL);
 static CCU_GATE(CLK_CPU2VP, cpu2vp_clk, "cpu2vp", axi_aclk_pd, 0x1e0, 13, CLK_IS_CRITICAL);
 static CCU_GATE(CLK_EMMC_SDIO, emmc_sdio_clk, "emmc-sdio", emmc_sdio_ref_clk_pd, 0x204, 30, 0);
 static CCU_GATE(CLK_GMAC1, gmac1_clk, "gmac1", gmac_pll_clk_pd, 0x204, 26, 0);
 static CCU_GATE(CLK_PADCTRL1, padctrl1_clk, "padctrl1", perisys_apb_pclk_pd, 0x204, 24, 0);
 static CCU_GATE(CLK_DSMART, dsmart_clk, "dsmart", perisys_apb_pclk_pd, 0x204, 23, 0);
-static CCU_GATE(CLK_PADCTRL0, padctrl0_clk, "padctrl0", perisys_apb_pclk_pd, 0x204, 22, 0);
+static CCU_GATE(CLK_PADCTRL0, padctrl0_clk, "padctrl0", perisys_apb4_hclk_pd, 0x204, 22, 0);
 static CCU_GATE(CLK_GMAC_AXI, gmac_axi_clk, "gmac-axi", axi4_cpusys2_aclk_pd, 0x204, 21, 0);
 static CCU_GATE(CLK_GPIO3, gpio3_clk, "gpio3-clk", peri2sys_apb_pclk_pd, 0x204, 20, 0);
 static CCU_GATE(CLK_GMAC0, gmac0_clk, "gmac0", gmac_pll_clk_pd, 0x204, 19, 0);
-- 
2.50.1



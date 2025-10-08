Return-Path: <linux-kernel+bounces-845730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 026B9BC5F34
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 839384EB453
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94282287268;
	Wed,  8 Oct 2025 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="KzNFGIie"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3022629E109;
	Wed,  8 Oct 2025 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759939633; cv=pass; b=VGZXvQuCF/p8M7gUoKrZtasjdJmb3NgFpJwOf+5Fi1yCBaZu2aCljcgVne/oS687MwsgeoR4dzQuPkdaAeB7MFSi+u5TTnesCrT5iuGRN2FIXAtIrx6scBLbQmGfiycPAeeNurqBWbxPFKA2ZejnpGUOhaVmaTKKAoeL5TNxPys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759939633; c=relaxed/simple;
	bh=8Kg+ZqfUphNmvU4IK0EE6Ciy+Dgs1wiV/H7VPqsSXU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LDbWOCrSviHL59idqVo/1P2n/Zik2ct0wcKUMmYfJQWWZANFOBqDwMvFkG/aYaSU8kMRTxptIOtlgOIR2Nl08uK/RZNaQ0ZWIGEcgBs+LH0jvHUM6vFmdaTVX7OvbURTTJzMobbE7SzallaKuFDy0hzB+dCMx9Ev/gwKVRJVKuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=KzNFGIie; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759939565; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lctHQh5LNPjM6hMcCkjrr9YeG4BxrIkZdmUcoZH1HbkJ0kIc5DU06gtscxfdFLNYltMckLT418OnzEb27mlFOt//PBMihQMpS77y2ARiKzapwv4tEuiPIxa15JdCUOKpuvLWaMD37h+4kCG8CHdGdL4x7Iq/uaV5/dvIaWyhhII=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759939565; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kJsRAjav3ZDmi2sZG+xEBRsiXb29hae9R43qCC2s6lg=; 
	b=QPBTOsR8DJfkJIo6ZAN4no1FEtH0PjWxfIi9UnEXqIYTLeDv4o7zSyg37QEREHYmOivwnsKlfTv35SHGN16BOJ/9Y14N09nWhSsGtXmp8wMtQ3tfhyKjfx8wxAP7qyOCzLDseThOYSXBeBlM2nScR9HH8okCQ/biPPVlupk4frA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759939565;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=kJsRAjav3ZDmi2sZG+xEBRsiXb29hae9R43qCC2s6lg=;
	b=KzNFGIie44JP/rsyaLC5S5HXBHSNvKJ/ON+RZxYmV0KYKMH1gqGQG1/6c4nKHhtY
	DfOE0ZKGukffQiU8tEqTCmRR34Fi4LbpVh0f+tmxv7p1d1fLw4Vfg6T675XznMrUd4W
	oEyN9AldhDUQcKFjlH1QBEyMqSESZVFDU5Jq7rG8=
Received: by mx.zohomail.com with SMTPS id 1759939563610836.7617931382553;
	Wed, 8 Oct 2025 09:06:03 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 08 Oct 2025 18:05:39 +0200
Subject: [PATCH v2 5/5] clk: mediatek: Add mfg_eb as parent to mt8196
 mfgpll clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-mtk-pll-rpm-v2-5-170ed0698560@collabora.com>
References: <20251008-mtk-pll-rpm-v2-0-170ed0698560@collabora.com>
In-Reply-To: <20251008-mtk-pll-rpm-v2-0-170ed0698560@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Yassine Oudjana <y.oudjana@protonmail.com>, 
 Laura Nao <laura.nao@collabora.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Stephen Boyd <sboyd@codeaurora.org>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

All the MFGPLL require MFG_EB to be on for any operation on them, and
they only tick when MFG_EB is on as well, therefore making this a
parent-child relationship.

This dependency wasn't clear during the initial upstreaming of these
clock controllers, as it only made itself known when I could observe
the effects of the clock by bringing up a different piece of hardware.

Add a new PLL_PARENT_EN flag to mediatek's clk-pll.h, and check for it
when initialising the pll to then translate it into the actual
CLK_OPS_PARENT_ENABLE flag.

Then add the mfg_eb parent to the mfgpll clocks, and set the new
PLL_PARENT_EN flag.

Fixes: 03dc02f8c7dc ("clk: mediatek: Add MT8196 mfg clock support")
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/clk/mediatek/clk-mt8196-mfg.c | 3 ++-
 drivers/clk/mediatek/clk-pll.c        | 3 +++
 drivers/clk/mediatek/clk-pll.h        | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8196-mfg.c b/drivers/clk/mediatek/clk-mt8196-mfg.c
index 8e09c0f7b7548f8e286671cea2dac64530b8ce47..de6f426f148184e1bb95b5cfca590b1763fc0573 100644
--- a/drivers/clk/mediatek/clk-mt8196-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8196-mfg.c
@@ -45,7 +45,7 @@
 		.en_reg = _en_reg,				\
 		.en_mask = _en_mask,				\
 		.pll_en_bit = _pll_en_bit,			\
-		.flags = _flags,				\
+		.flags = (_flags) | PLL_PARENT_EN,		\
 		.rst_bar_mask = _rst_bar_mask,			\
 		.fmax = MT8196_PLL_FMAX,			\
 		.fmin = MT8196_PLL_FMIN,			\
@@ -58,6 +58,7 @@
 		.pcw_shift = _pcw_shift,			\
 		.pcwbits = _pcwbits,				\
 		.pcwibits = MT8196_INTEGER_BITS,		\
+		.parent_name = "mfg_eb",			\
 	}
 
 static const struct mtk_pll_data mfg_ao_plls[] = {
diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index c4f9c06e5133dbc5902f261353c197fbde95e54d..0f3759fcd9d0228c23f4916d041d17b731a6c838 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -359,6 +359,9 @@ struct clk_hw *mtk_clk_register_pll_ops(struct mtk_clk_pll *pll,
 
 	init.name = data->name;
 	init.flags = (data->flags & PLL_AO) ? CLK_IS_CRITICAL : 0;
+	if (data->flags & PLL_PARENT_EN)
+		init.flags |= CLK_OPS_PARENT_ENABLE;
+
 	init.ops = pll_ops;
 	if (data->parent_name)
 		init.parent_names = &data->parent_name;
diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
index 0f2a1d19eea78b7390b221af47016eb9897f3596..492cad8ff80ba31a78a96085285cb938e9b978e9 100644
--- a/drivers/clk/mediatek/clk-pll.h
+++ b/drivers/clk/mediatek/clk-pll.h
@@ -21,6 +21,7 @@ struct mtk_pll_div_table {
 
 #define HAVE_RST_BAR	BIT(0)
 #define PLL_AO		BIT(1)
+#define PLL_PARENT_EN	BIT(2)
 #define POSTDIV_MASK	GENMASK(2, 0)
 
 struct mtk_pll_data {

-- 
2.51.0



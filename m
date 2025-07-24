Return-Path: <linux-kernel+bounces-743824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9465BB103BE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A5B1C2590A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5F6274FC1;
	Thu, 24 Jul 2025 08:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QAKurpH/"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D195D274B37;
	Thu, 24 Jul 2025 08:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753346353; cv=none; b=WY6900U6fisak9m4HLo1MgNZGBjctsYgNuDpePm2+CFzPqz1pHR+STc112OQiSrXcZYJ5huG4+yXii8MH6Zzt5TazPcvosOzNSwU92VcfFmXJSKqb6bU366nO8FN13nXplSosxDvmMB4uMeDcsVx2g80j6jMky1zInkoRqm7m5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753346353; c=relaxed/simple;
	bh=rjcZHS4zMiYwGcIC7g009niYBuPFGQqt0YpNefU9dyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZM70HYjRHVC7Xh2kfglm/YGbbm4y9xBPQHUBY7+koKTyiVc5m4IruyXmR/O8JwO/60nnlZtNnNxNfE59KuJ9Vy0Ua3AoCJXSTv0aH3lk/bmW4IFGKUIncDwYA9G0UZC94AbowGOF2sGEhbwhLlEV3uEY/6e8s/fwC1uylVLqWSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QAKurpH/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753346344;
	bh=rjcZHS4zMiYwGcIC7g009niYBuPFGQqt0YpNefU9dyA=;
	h=From:To:Cc:Subject:Date:From;
	b=QAKurpH/cGlJDYa3bpE9sc3ZroFZ7RvOgUgOMxeTqXFFjvK7yrfRgUp3i29v6aPDO
	 pXWKtIl/Q3181+IoYdWf6mZB8D/GW5j/FQokVoESudhWnbovMvszgprUeoMWaZB6/Y
	 NQj6LiGUvYJFXJqBzZ7U9aS9MeSz6pARSkLemnSAsZJNhWSTOHDWX3nDp9JR2kA9Wh
	 R7LOpSwSLt7UQFYrLn2Xtdx8Ke/ZQoTJafaGT/A4UP0UNSN7Nvx/lEJSWcHk8g3+xY
	 2sObhWmefeDSoHgSC3o/SLB67hLFoce9if6Zezw7BFngpsXkbVc4gEgsC4KRXOem3o
	 XRYq9tXygKGSw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 87CDE17E0FC2;
	Thu, 24 Jul 2025 10:39:03 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: sboyd@kernel.org
Cc: mturquette@baylibre.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	u.kleine-koenig@baylibre.com,
	geert+renesas@glider.be,
	chun-jie.chen@mediatek.com,
	wenst@chromium.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH] clk: mediatek: mt8195-infra_ao: Fix parent for infra_ao_hdmi_26m
Date: Thu, 24 Jul 2025 10:38:28 +0200
Message-ID: <20250724083828.60941-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The infrastructure gate for the HDMI specific crystal needs the
top_hdmi_xtal clock to be configured in order to ungate the 26m
clock to the HDMI IP, and it wouldn't work without.

Reparent the infra_ao_hdmi_26m clock to top_hdmi_xtal to fix that.

Fixes: e2edf59dec0b ("clk: mediatek: Add MT8195 infrastructure clock support")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8195-infra_ao.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8195-infra_ao.c b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
index bb648a88e43a..ad47fdb23460 100644
--- a/drivers/clk/mediatek/clk-mt8195-infra_ao.c
+++ b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
@@ -103,7 +103,7 @@ static const struct mtk_gate infra_ao_clks[] = {
 	GATE_INFRA_AO0(CLK_INFRA_AO_CQ_DMA_FPC, "infra_ao_cq_dma_fpc", "fpc", 28),
 	GATE_INFRA_AO0(CLK_INFRA_AO_UART5, "infra_ao_uart5", "top_uart", 29),
 	/* INFRA_AO1 */
-	GATE_INFRA_AO1(CLK_INFRA_AO_HDMI_26M, "infra_ao_hdmi_26m", "clk26m", 0),
+	GATE_INFRA_AO1(CLK_INFRA_AO_HDMI_26M, "infra_ao_hdmi_26m", "top_hdmi_xtal", 0),
 	GATE_INFRA_AO1(CLK_INFRA_AO_SPI0, "infra_ao_spi0", "top_spi", 1),
 	GATE_INFRA_AO1(CLK_INFRA_AO_MSDC0, "infra_ao_msdc0", "top_msdc50_0_hclk", 2),
 	GATE_INFRA_AO1(CLK_INFRA_AO_MSDC1, "infra_ao_msdc1", "top_axi", 4),
-- 
2.50.1



Return-Path: <linux-kernel+bounces-756347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E06B1B2F1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52BC5167A91
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55BC274FCE;
	Tue,  5 Aug 2025 11:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EEBgMiME"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BA0274668
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754395019; cv=none; b=K6Q2fDVEre2bhYYookvSjk+yqbiNrcFANk3APxlCEMoQIx0PFLJBgpXqnBBml156GdpuMO+Rxm5a1hFRBNb2Dn07xLTjmqtGUTa1JqqfgyNiu7PvlXdwGDoMaCl0tsp511M/ACk1re38PDNiThUS9M7kFcf8lvx4aXXEVT9pc14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754395019; c=relaxed/simple;
	bh=VVmcfxwz/BIjTaYrLE6b0OQS4rHqgOp2ro0shp9GpoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FsxK0DZ6Pw3jmAsuZsain/BbRWf1i767pNGMHnYTWYdI63GiXNz2RDKnqAjJ07d3DujnWThJOua2isLz5R84Z5UnxLu4PWscYXRN8tfMO0jN/PayDgdxJ6HMcQ8Ch8YPnKWueuX4IR+Ck0D+nTsCwvDBk3Y96z7glIJe75ji+vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EEBgMiME; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754395015;
	bh=VVmcfxwz/BIjTaYrLE6b0OQS4rHqgOp2ro0shp9GpoA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EEBgMiMEnk8SQQZYs2TryGS1bx22u+SdTv9GxwTxdjJA00AUecm07rND6PKz+veyO
	 V7BqGCfBAuJfjSPxct5It7wYPcgLlebUxGciA08nBWX3TXuN75+OR6JqXa9kAF5Ybo
	 pewZb0LBehJRjiH2a6xSraMtAQEZ4+vWqP31HzH0MjyZ3hCVZYRNp58yO608snmcaU
	 koe+uaApRIanZWCc0Q6fzM1WJp/iAkw7S1adytoiwwS/yl9aKnUfXzHYYUv1Nty/Xg
	 +auifagiw6ODgVOo91wHCUSfu/wSZyrydEbQwVclx9wfgcOjGNUuxcF8q98xwx0azS
	 Gbzer4JM67WHg==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id BD24D17E0DB9;
	Tue,  5 Aug 2025 13:56:55 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 05 Aug 2025 14:56:53 +0300
Subject: [PATCH v2 11/14] phy: rockchip: samsung-hdptx: Drop hw_rate driver
 data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-phy-hdptx-frl-v2-11-d118bd4b6e0b@collabora.com>
References: <20250805-phy-hdptx-frl-v2-0-d118bd4b6e0b@collabora.com>
In-Reply-To: <20250805-phy-hdptx-frl-v2-0-d118bd4b6e0b@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2

The ->hw_rate member of struct rk_hdptx_phy was mainly used to keep
track of the clock rate programmed in hardware and support implementing
the ->recalc_rate() callback in hdptx_phy_clk_ops.

Computing the clock rate from the actual PHY PLL configuration seems to
work reliably, hence remove the now redundant struct member.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 6e2443f78968948b84e4261e33761fe0d189553b..4195387108d8786c2b7cabb6d2f3c07315fefd88 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -401,7 +401,6 @@ struct rk_hdptx_phy {
 
 	/* clk provider */
 	struct clk_hw hw;
-	unsigned long hw_rate;
 	bool restrict_rate_change;
 
 	atomic_t usage_count;
@@ -964,7 +963,7 @@ static int rk_hdptx_tmds_ropll_cmn_config(struct rk_hdptx_phy *hdptx)
 {
 	const struct ropll_config *cfg = NULL;
 	struct ropll_config rc = {0};
-	int ret, i;
+	int i;
 
 	if (!hdptx->hdmi_cfg.tmds_char_rate)
 		return 0;
@@ -1026,12 +1025,7 @@ static int rk_hdptx_tmds_ropll_cmn_config(struct rk_hdptx_phy *hdptx)
 	regmap_update_bits(hdptx->regmap, CMN_REG(0086), PLL_PCG_CLK_EN_MASK,
 			   FIELD_PREP(PLL_PCG_CLK_EN_MASK, 0x1));
 
-	ret = rk_hdptx_post_enable_pll(hdptx);
-	if (!ret)
-		hdptx->hw_rate = DIV_ROUND_CLOSEST_ULL(hdptx->hdmi_cfg.tmds_char_rate * 8,
-						       hdptx->hdmi_cfg.bpc);
-
-	return ret;
+	return rk_hdptx_post_enable_pll(hdptx);
 }
 
 static int rk_hdptx_tmds_ropll_mode_config(struct rk_hdptx_phy *hdptx)
@@ -1936,9 +1930,6 @@ static unsigned long rk_hdptx_phy_clk_recalc_rate(struct clk_hw *hw,
 	u64 rate;
 	int ret;
 
-	if (hdptx->hw_rate)
-		return hdptx->hw_rate;
-
 	ret = regmap_read(hdptx->grf, GRF_HDPTX_CON0, &status);
 	if (ret || !(status & HDPTX_I_PLL_EN))
 		return 0;

-- 
2.50.0



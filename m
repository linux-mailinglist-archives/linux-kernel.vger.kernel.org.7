Return-Path: <linux-kernel+bounces-873226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E399DC136EA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C07C35008BA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292472C21C0;
	Tue, 28 Oct 2025 08:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="e9Hz6KMZ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1FA18C031
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761638528; cv=none; b=n5jpgMyxFKnw4b6qjyThvYJrqpmqsHjUmtPDl4Tb2u5y/Qd6dFwlS9qtOuXlKXjMYBLZ2o5IPXBu9Ymny6PnilydI/3ZQ2yPT6WsOlZpealfr/N9XVGjyCQwMxXSctO/HcwHwv57x2ojps1xRFaqlJKkOkEmyrFtCJiHT9D/4qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761638528; c=relaxed/simple;
	bh=+JaO/wn2a0pnTQvwJNdanN5Q+8X01ku/lGh6qKEDcJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CKRX6yax6oakUz1GZm0cf0oSGvzh48E+Kqgq+nsMV3JOPXlIglRqBCKAFnnc18ND0xwETPusmFDz0miDPk6SiMRtDRmc7TLZ9tz81k9Xg5UQkNrP3Y4VL9UOpeOghczJdQ5xJwPQEs4ocAuihn7bAdad6q35atMhDou7ZMbVfE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=e9Hz6KMZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761638524;
	bh=+JaO/wn2a0pnTQvwJNdanN5Q+8X01ku/lGh6qKEDcJ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e9Hz6KMZa11eaxEdEPfxtLPu9zRlks3hP2x/VScVLONAgu8FzfZDzAn7VdHE2xdgx
	 WIIFJ7kgmIOR1zaD9BkEv20aPKIHzGCLFNQYwFTzz6dWl24Izm50NjUjLIHEhHk64e
	 RifcOpsBwSohlRH9gG2Gv9Zu6NIxxytsW3FcrR3O5J1/tyM5sxlXYSqJRqTk32roPU
	 c5QinLdG7mTFEMTawySGHn+jl0YRx38GZ4qsIngaOtE6nY/1JETBr/t1AQRsBR5gRE
	 Q+ImwqkR/FeKA44kVqHkus+wrAJ8dMSB3NN5QMRB8XI1SnQYqYbx48eY8sph/xJ+Nr
	 3GkCD9XrM9poA==
Received: from localhost (unknown [82.79.138.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id A3CA917E12BA;
	Tue, 28 Oct 2025 09:02:04 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 28 Oct 2025 10:00:54 +0200
Subject: [PATCH RESEND 1/3] phy: rockchip: samsung-hdptx: Fix reported
 clock rate in high bpc mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-phy-hdptx-fixes-v1-1-ecc642a59d94@collabora.com>
References: <20251028-phy-hdptx-fixes-v1-0-ecc642a59d94@collabora.com>
In-Reply-To: <20251028-phy-hdptx-fixes-v1-0-ecc642a59d94@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Dmitry Baryshkov <lumag@kernel.org>, 
 Algea Cao <algea.cao@rock-chips.com>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andy Yan <andy.yan@rock-chips.com>
X-Mailer: b4 0.14.3

When making use of the clock provider functionality, the output clock
does normally match the TMDS character rate, which is what the PHY PLL
gets configured to.

However, this is only applicable for default color depth of 8 bpc.  For
higher depths, the output clock is further divided by the hardware
according to the formula:

  output_clock_rate = tmds_char_rate * 8 / bpc

Since the existence of the clock divider wasn't taken into account when
support for high bpc has been introduced, make the necessary adjustments
to report the correct clock rate.

Fixes: 9d0ec51d7c22 ("phy: rockchip: samsung-hdptx: Add high color depth management")
Reported-by: Andy Yan <andy.yan@rock-chips.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 01bbf668e05e..aee03e8655f6 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -1037,7 +1037,8 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx)
 
 	ret = rk_hdptx_post_enable_pll(hdptx);
 	if (!ret)
-		hdptx->hw_rate = hdptx->hdmi_cfg.tmds_char_rate;
+		hdptx->hw_rate = DIV_ROUND_CLOSEST_ULL(hdptx->hdmi_cfg.tmds_char_rate * 8,
+						       hdptx->hdmi_cfg.bpc);
 
 	return ret;
 }
@@ -1895,19 +1896,20 @@ static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 	 * hence ensure rk_hdptx_phy_clk_set_rate() won't be invoked with
 	 * a different rate argument.
 	 */
-	return hdptx->hdmi_cfg.tmds_char_rate;
+	return DIV_ROUND_CLOSEST_ULL(hdptx->hdmi_cfg.tmds_char_rate * 8, hdptx->hdmi_cfg.bpc);
 }
 
 static int rk_hdptx_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 				     unsigned long parent_rate)
 {
 	struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
+	unsigned long long tmds_rate = DIV_ROUND_CLOSEST_ULL(rate * hdptx->hdmi_cfg.bpc, 8);
 
 	/* Revert any unlikely TMDS char rate change since round_rate() */
-	if (hdptx->hdmi_cfg.tmds_char_rate != rate) {
-		dev_warn(hdptx->dev, "Reverting unexpected rate change from %lu to %llu\n",
-			 rate, hdptx->hdmi_cfg.tmds_char_rate);
-		hdptx->hdmi_cfg.tmds_char_rate = rate;
+	if (hdptx->hdmi_cfg.tmds_char_rate != tmds_rate) {
+		dev_warn(hdptx->dev, "Reverting unexpected rate change from %llu to %llu\n",
+			 tmds_rate, hdptx->hdmi_cfg.tmds_char_rate);
+		hdptx->hdmi_cfg.tmds_char_rate = tmds_rate;
 	}
 
 	/*

-- 
2.51.0



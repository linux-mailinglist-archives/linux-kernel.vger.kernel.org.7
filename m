Return-Path: <linux-kernel+bounces-797087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0AAB40BA2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5FF3A417F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4326341AD7;
	Tue,  2 Sep 2025 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pHqNrY+N"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8FF340DBD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832842; cv=none; b=e3/NEan/OXCEvzzTMZylq0ETNC4lXVB7B/nvC0q8Ndwy0blNSRvSqvWH5FITIF11YwceDkEFBxXAoRXZz/Q/4ZoxsEmc1tGbujNCX7D58gzAfHSAw7VXn7V8FnL3ZksXr3SMqSFWmd00vNIMIIl0wfwm3gcYdyt+QMklpGtWWLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832842; c=relaxed/simple;
	bh=p9G1JdZNHBB20Qe5ZLlqmEbY+P1qY7hzK//FQaEBq4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uxQ9S9QEYc8i8Sv0lGqbV6fBdjwo3xkAtx8MDxSYPiC93EU+nNQHWheqhfSqyXroNOUC0b+SiH2eyzPWERkAyRotr0cflbKqTeC68L9rdok/XxQJH8AgCy5uKyY0IDkabRxoFEchU5itXZiLdq79keDWJ5uY1dSH2b69wZ7/Wu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pHqNrY+N; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756832838;
	bh=p9G1JdZNHBB20Qe5ZLlqmEbY+P1qY7hzK//FQaEBq4w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pHqNrY+N3mjBpHj7h9Np5BDPKapnNxYvnrQXzeOAGKI8HtnIFXX5EPfwWSkIz3i/y
	 tUD/nEEExEbYIBUZPCdQyaez4Y4X01ZwJ8ScgRVjC+t3igaf6EFbByj7mm0GXLzaiE
	 pAb50nhqMjAGswxxp2F8hRypBsluV8Yp3ZqBLxo8CDrbCFcJJGqYpADUIRbZtUUT0/
	 1mcpsWqp5N+/zSBOMX5SAAb2FV6cA/Hiv7IltdnIJhBV7n/Nri7g0o5UgIQQsetcwm
	 1sMIb2/CfTLu9tR9NSJQT0INuNpaNBeW9feFC3Hjn/Gn+RHmOQHtRliBRAkt6i1Evb
	 mKJHf14x1V5kg==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 4D9F417E1301;
	Tue,  2 Sep 2025 19:07:18 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 20:06:59 +0300
Subject: [PATCH 1/3] phy: rockchip: samsung-hdptx: Fix reported clock rate
 in high bpc mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-phy-hdptx-fixes-v1-1-e8d9ef9748d6@collabora.com>
References: <20250902-phy-hdptx-fixes-v1-0-e8d9ef9748d6@collabora.com>
In-Reply-To: <20250902-phy-hdptx-fixes-v1-0-e8d9ef9748d6@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Dmitry Baryshkov <lumag@kernel.org>, 
 Algea Cao <algea.cao@rock-chips.com>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andy Yan <andy.yan@rock-chips.com>
X-Mailer: b4 0.14.2

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
index 01bbf668e05ef94e24a3fa11f96f219c4f942451..aee03e8655f66d4b25de39bd2b2bf49d7a8b5b86 100644
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



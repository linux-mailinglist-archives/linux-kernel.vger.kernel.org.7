Return-Path: <linux-kernel+bounces-722273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46227AFD72F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26591BC8566
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87590238157;
	Tue,  8 Jul 2025 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MiPsqYXD"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423A3239E66
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003452; cv=none; b=RtgONzOTUpRh+fZwaT9R32C1WTDWdR03ru61BR4etk0GjE0vX+fFkuXvNVwW2XbNkxYXS5hk2jObsRarChlC15+SL2In0xIHqrA7TU29KFDLXqOh+T3V1rmKAeBvuLNB1rascmOCCWPtLEs6Uwm0qi9xEdD9rnCOZa4axO5lvDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003452; c=relaxed/simple;
	bh=x3VrdnN8H7+3VouRioNhlNkYqCVQfVdWis1xzS7nIV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jpDMLTVJWaNrEI792cyUNSSP20s/bsg1eHjlOW/CfFH7taUFTupyj1Ihj22DZN2uv9Hg7tcOkiLQLsNBisRWjMDSYFD8ufn4DvilMgmunBdPg/+G3aMiw8Anwd/wFdrSERe+D956kFYsT34Fbk5aX+hWzXzVjhJrN1UGuHtstZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MiPsqYXD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752003448;
	bh=x3VrdnN8H7+3VouRioNhlNkYqCVQfVdWis1xzS7nIV8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MiPsqYXDXczW6Gpqi4ohDUsAv1PqbvdAinJX6VOPjWgfJA+mBSCjlLnVJZayPREro
	 OLF1VGHRfStWZr07bXzvxYzaZ7CvT9AagysD+TZHVq6KijKY3gpOXE0pWwUgS8ASAi
	 fc2h3YJMoCDIEWOwMpc1vDA4o30ANF2gT904r8u3NXjaC2SMGZZwJdicvpVuC1jvLI
	 rmeL276eotb8bA2rYjyu7t9gDY6gNHfHYtUVyT5D0irn1Ry2ohSuC8QdV72S+zOUga
	 oenOYB67SqDTlPRaAi/bc9SdKiD7OYSRbBjB28iCQ5gVVDjd+Z2eDaSr4rE4wnq00P
	 /RSTtEhT0A1Ow==
Received: from localhost (unknown [212.93.144.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 70E8317E04AA;
	Tue,  8 Jul 2025 21:37:28 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 08 Jul 2025 22:35:48 +0300
Subject: [PATCH 07/12] phy: rockchip: samsung-hdptx: Enable lane output in
 common helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-phy-hdptx-frl-v1-7-cfe096e224f4@collabora.com>
References: <20250708-phy-hdptx-frl-v1-0-cfe096e224f4@collabora.com>
In-Reply-To: <20250708-phy-hdptx-frl-v1-0-cfe096e224f4@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2

In preparation to support FRL mode, move the PHY lane output enablement
from the TMDS specific configuration to the common *_post_enable_lane()
helper and make sure it gets turned off in *_phy_disable().

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 21b8ed427baf338300a0bce813037a54121e9ed9..595aa94eb2dd22acd44c653e51d85ac497a1cc44 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -830,6 +830,8 @@ static int rk_hdptx_post_enable_lane(struct rk_hdptx_phy *hdptx)
 	       HDPTX_I_BIAS_EN | HDPTX_I_BGR_EN;
 	regmap_write(hdptx->grf, GRF_HDPTX_CON0, val);
 
+	regmap_write(hdptx->regmap, LNTOP_REG(0207), 0x0f);
+
 	ret = regmap_read_poll_timeout(hdptx->grf, GRF_HDPTX_STATUS, val,
 				       (val & HDPTX_O_PHY_RDY) &&
 				       (val & HDPTX_O_PLL_LOCK_DONE),
@@ -883,6 +885,7 @@ static void rk_hdptx_phy_disable(struct rk_hdptx_phy *hdptx)
 	usleep_range(20, 30);
 	reset_control_deassert(hdptx->rsts[RST_APB].rstc);
 
+	regmap_write(hdptx->regmap, LNTOP_REG(0207), 0x0);
 	regmap_write(hdptx->regmap, LANE_REG(0300), 0x82);
 	regmap_write(hdptx->regmap, SB_REG(010f), 0xc1);
 	regmap_write(hdptx->regmap, SB_REG(0110), 0x1);
@@ -1059,7 +1062,6 @@ static int rk_hdptx_tmds_ropll_mode_config(struct rk_hdptx_phy *hdptx)
 	}
 
 	regmap_write(hdptx->regmap, LNTOP_REG(0206), 0x07);
-	regmap_write(hdptx->regmap, LNTOP_REG(0207), 0x0f);
 
 	rk_hdptx_multi_reg_write(hdptx, rk_hdptx_common_lane_init_seq);
 	rk_hdptx_multi_reg_write(hdptx, rk_hdptx_tmds_lane_init_seq);

-- 
2.50.0



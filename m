Return-Path: <linux-kernel+bounces-797312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE344B40EB3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC161B64015
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFB335A293;
	Tue,  2 Sep 2025 20:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eD5GWMEi"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488E8353347
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756845900; cv=none; b=EkWIBhlVfD+WeIBtBr3ohWu2eHPlcgQ5RtKgmVQNj1kXIBdNlXh5qomAcsKXlEJAb0jp+OhpUYsRHRhDV+8BjrWhU38EUoqVMaivxC2DgKJiSOlqrWVnpbD8llK59SVMacb7O7KQgidm7DyY/gCxVCWmLI0UR7iAS0HDW9H8xhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756845900; c=relaxed/simple;
	bh=7AowFKcQ6ftl6MWCdo8QAHRnpCY0dnS6YSkmNWNruhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tcs9I0ySMXIMrPCMVBQ4+78IMJWhVOHT1laycRh5zHoUssChvhEgtgPCvuYTkTzbGmIv/tfNlYz+/hEud8teuScHX03zP9Q0th6/xIVBM2RdV2KhvsUz2Uh3HhO6vLlt97Ig1ztbOi+CYidHU4FmoPJoqDZa18ZkDN08pNAh5r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eD5GWMEi; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756845896;
	bh=7AowFKcQ6ftl6MWCdo8QAHRnpCY0dnS6YSkmNWNruhw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eD5GWMEimerrSlIh52M9jcWTDkmLCiDhiys7GC/jfdw02kWvh7gSQtvZtlzvKCe3q
	 6hQRboqvL/n/1unykLuPAYy3cpGUtlNprZ+snZkvjRDR3KKSO5WGxy2r4x3DuNOMHo
	 KLGzLOGrFi73wZ1IVvJV89aKS09mBTqn3hourRRz5ektUZVwbqljXQsq2K85nXOHif
	 yxO2+17/tnvEwNojXK2xWL8Jluk0MmizLpOmJCLqbr3kjNP9ea8+V+n3tC51wQCfhk
	 vT8k5GOt3+R3Tc3DHFeqZMqlarBND2GxpLJt49uiIGfj1hvm6b27gkV8AdL7/KD7BD
	 kv582yO3MA4NQ==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 8A49717E138B;
	Tue,  2 Sep 2025 22:44:56 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 23:44:40 +0300
Subject: [PATCH v4 05/11] phy: rockchip: samsung-hdptx: Enable lane output
 in common helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-phy-hdptx-frl-v4-5-7d69176373ce@collabora.com>
References: <20250902-phy-hdptx-frl-v4-0-7d69176373ce@collabora.com>
In-Reply-To: <20250902-phy-hdptx-frl-v4-0-7d69176373ce@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
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
index 44fda739705abc86428fa6fb41c545aceafbb28f..574e468e5070d225aa5ce4d648aad2bcae851b4b 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -829,6 +829,8 @@ static int rk_hdptx_post_enable_lane(struct rk_hdptx_phy *hdptx)
 	       HDPTX_I_BIAS_EN | HDPTX_I_BGR_EN;
 	regmap_write(hdptx->grf, GRF_HDPTX_CON0, val);
 
+	regmap_write(hdptx->regmap, LNTOP_REG(0207), 0x0f);
+
 	ret = regmap_read_poll_timeout(hdptx->grf, GRF_HDPTX_STATUS, val,
 				       (val & HDPTX_O_PHY_RDY) &&
 				       (val & HDPTX_O_PLL_LOCK_DONE),
@@ -882,6 +884,7 @@ static void rk_hdptx_phy_disable(struct rk_hdptx_phy *hdptx)
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
2.51.0



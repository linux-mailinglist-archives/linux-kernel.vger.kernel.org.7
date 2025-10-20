Return-Path: <linux-kernel+bounces-860350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AC9BEFEE0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C54FA4F0495
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F69D2ECD06;
	Mon, 20 Oct 2025 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="v2x/H7jj"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26532EA752;
	Mon, 20 Oct 2025 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948757; cv=none; b=ubCItEjYrgiYtruq7dxnnHfCT3us5Znb9YNbwpxJ2gb9UWY2LWP3c6jrC4oagg3aewPfqLiUt2oynH6m8OQyTqvsbG0blaTZMKyrYDVAM4pbvc2TXiwFXONxnSHsTkXOBpxTKcJ6sJJ0MMcvVjjX4FQo/36xyF09GHKJ55smDAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948757; c=relaxed/simple;
	bh=rZhKAyiqSuSxCrlr7TE4Ukg9BFQY9d1O007hPrVAGlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERnuJIk+W/BKCbm7/bv9iW7falgkdyDDy5Ld5aYWB/pTJxipbd4cMVpTx3KIFTOSA15fvTAmNQnz9seNFJw5IFNbb7oSHrHxfymJitCHjprDShNsDkBly3fzpf4utat/LFLeQzWZygRz9yj8IiBKXg+2DM1VnK9MV0kGTaNRur0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=v2x/H7jj; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=Yj6MA66tzVBn+KRYXc/UT/sYW9ZjhkSRMZ8pqWy1J7g=; b=v2x/H7jjQM2bM50tAt6guxmne9
	3RK9T2Rp+ZjfBlQNhgis87jMVhX25x4gHOUTVHfePIjXqEfsS4SRzYGz3kYSzYzeSWbeGsPHmsbFE
	QQX60MsGnpDvBcgDf3SVjv8d1d5yQ2FCwsolFl5yNqZN6jgAbnJHJWJoeTdMmyLbUGWJMVaFd3u+A
	jG2bwh9VpTt3EMzFxgNOJgvXD08GuCM4wp64KueWM90+7WNMSQBOfeVXww+e+Rv676rupj8g+Y5jb
	fY8z6sE5jVmTwHDMIxRw/+5d7+kmZq1Kjfhgeciai5BRqCraZrA8yhQ1qAyfhC31+jLkbZ3AmAZ0z
	wJ1BOxAg==;
Received: from [141.76.253.240] (helo=phil.eduroam.local)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vAlCy-00078O-Ha; Mon, 20 Oct 2025 10:25:36 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	quentin.schulz@cherry.de,
	andy.yan@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	cn.liweihao@gmail.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 2/9] drm/rockchip: hdmi: add RK3368 controller variant
Date: Mon, 20 Oct 2025 10:25:01 +0200
Message-ID: <20251020082508.3636511-3-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251020082508.3636511-1-heiko@sntech.de>
References: <20251020082508.3636511-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The RK3368 has only one VOP, so there is no source selection happening
and the controller uses an internal phy for the HDMI output.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 7b613997bb50..95ff3fce97a3 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -467,6 +467,19 @@ static const struct dw_hdmi_plat_data rk3328_hdmi_drv_data = {
 	.use_drm_infoframe = true,
 };
 
+static struct rockchip_hdmi_chip_data rk3368_chip_data = {
+	.lcdsel_grf_reg = -1,
+};
+
+static const struct dw_hdmi_plat_data rk3368_hdmi_drv_data = {
+	.mode_valid = dw_hdmi_rockchip_mode_valid,
+	.mpll_cfg   = rockchip_mpll_cfg,
+	.cur_ctr    = rockchip_cur_ctr,
+	.phy_config = rockchip_phy_config,
+	.phy_data = &rk3368_chip_data,
+	.use_drm_infoframe = true,
+};
+
 static struct rockchip_hdmi_chip_data rk3399_chip_data = {
 	.lcdsel_grf_reg = RK3399_GRF_SOC_CON20,
 	.lcdsel_big = FIELD_PREP_WM16_CONST(RK3399_HDMI_LCDC_SEL, 0),
@@ -507,6 +520,9 @@ static const struct of_device_id dw_hdmi_rockchip_dt_ids[] = {
 	{ .compatible = "rockchip,rk3328-dw-hdmi",
 	  .data = &rk3328_hdmi_drv_data
 	},
+	{ .compatible = "rockchip,rk3368-dw-hdmi",
+	 .data = &rk3368_hdmi_drv_data
+	},
 	{ .compatible = "rockchip,rk3399-dw-hdmi",
 	  .data = &rk3399_hdmi_drv_data
 	},
-- 
2.47.2



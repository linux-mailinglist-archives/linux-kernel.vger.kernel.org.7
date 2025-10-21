Return-Path: <linux-kernel+bounces-862336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E11BF5086
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D0A04F3AA1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A449C28B7DB;
	Tue, 21 Oct 2025 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="QCpsxy9c"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DCD280CFB;
	Tue, 21 Oct 2025 07:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032612; cv=none; b=ZJn3ls/onK8b63gxTVUFE7639W2hIcQGQNG2WtPjqjfCbFcnbLScNnTz30Tas0Bp7e9eD1viy0lCbkSZc1+1PiNTU94UkWEwjLfS0KWZ71UFGqSOIcvlwjNt3MIaiFNnzIGUOVrudULmXFBUGSGAkCbVf0ge55uD7oOtL4cmbuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032612; c=relaxed/simple;
	bh=VRhiyPyyKDnX9z2ZdRGv8JRlIhCWSif+N76png4X5E0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVd+4tysXtSE7MoWeiUZGAefzUDXw1RTB/7b+OPAzsNcWjHCIWCbgr1atYCvTYCGbz9ETXMjbDldZ50F4DL/LigJFjAgOoM/F2AxmcYumAfH7ol/XawL5dYEEYQbYUBN8SaGtpyacX2C1dLEVTVto4icO4bz7FohIE0CGDraTPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=QCpsxy9c; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=FS4dERJDFsHCnVZ76N6RaaiZZW7ln6HmoGA7DcqZWmQ=; b=QCpsxy9cZFNcyN9fqhpFFoyzIU
	GLVWRogS3VEDnMPTV8IPVtHV7fz8uqB/C3C43KKxi1Rvh7kYoAGMVo+HKCP31BbcYRn9XN5y5+E2D
	utJ1RiHVoWLeLUt+aW2K4cG9+1NPtWRDCWAKa8GBNDrA0fU6KKs+yuMUeagUtcPRlUfHlusR0FpLe
	oG6vxv7zv6UbAke9k2lqVFaIyR/K1fYp968iaIyHNPTurlad1Xqcw2J3djCsdEaNpLyD0wMqtsHs3
	BcIHvNvAchMJliCvGSrc020sgzMjL1sWvMzjhnfJOvPq2MvRaNUd8VN0VGhBlxkBNL2ECwWX5M4ve
	RRVsz1hg==;
Received: from [212.111.240.218] (helo=phil.guestnet.ukdd.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vB71N-0000uy-BF; Tue, 21 Oct 2025 09:43:05 +0200
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
Subject: [PATCH v2 2/9] drm/rockchip: hdmi: add RK3368 controller variant
Date: Tue, 21 Oct 2025 09:42:47 +0200
Message-ID: <20251021074254.87065-3-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251021074254.87065-1-heiko@sntech.de>
References: <20251021074254.87065-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The RK3368 has only one VOP, so there is no source selection happening
and the controller uses an internal PHY for the HDMI output.

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



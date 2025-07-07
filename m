Return-Path: <linux-kernel+bounces-720244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CD6AFB90C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 251B27B05D8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2109239E9F;
	Mon,  7 Jul 2025 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="rNXX5d1u"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE5F23534D;
	Mon,  7 Jul 2025 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906991; cv=none; b=FwQU9JYREzUgurP0aDGUDL0y7LwAz5gb1mCWKs/XiiiW40JcNqSb8qn3eVij+vnC9y3F41txs3hSXvApIPNSYhq9aC5smAE9dF20b+PMO1RBplpHyuMzlr5gWeAHrgPb6yLzO0vq4y9cN/efoe/2liQytYSrHdLoecY3M/+GFNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906991; c=relaxed/simple;
	bh=nwnkywKkZ2yW7obRzxv3ivkf/5jICPCX8W5fi86WMPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNk8L8fIEb9/6F6EMHKNMgj2H0B+VV0SaoPAOoEwbJ/3eHGB/Bpe4FyCjjStv1GoGlYAyrFGazmhLTNIVRLxWXpSzY8KhOGplNRLhg4tlbEs3QfUoqTzb0Qae/gFwfDonTvH8LOLhGX0dxqPxQrySENxk/WJAA1AAgYqty7dJ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=rNXX5d1u; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=58erMwoxBaQAKtl014X0pCQs9xXgy2ZbGkCMSXmUpbI=; b=rNXX5d1ukA1xbpvXU3rwD2i/6k
	R9uWibvpvUbZ/AglO1KOIH02VeJWvrWsUfa7di7XPVJOn5WyolKx17r3Ssb6Hb++Ik476zksJeS91
	PQmqBlDVRq//zRNVcltwajqqlxGCKMRiYV4/TFui7b/a+Wt7ywycIey0VGW1cSOlZx2yihLxzAeih
	SC0HI79+QmgiXfb+vx/tBAS/JW4BqAOv6U2MDhhmSOZC/2funCEIADqlbH3ZfXn/TOtQlL63lQ1LD
	8opC/6wBye9qFSa1ByrkTiz5yzbLuqNiSfXJllq0upwjk8Aqh5MGloiSbSpxzbErtekkUU8GqoNTN
	h3OiLYQg==;
Received: from i53875bf5.versanet.de ([83.135.91.245] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uYp1v-0004yl-Fu; Mon, 07 Jul 2025 18:49:23 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	andyshrk@163.com,
	nicolas.frattaroli@collabora.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Guochun Huang <hero.huang@rock-chips.com>
Subject: [PATCH 09/13] drm/rockchip: dsi2: add support rk3576
Date: Mon,  7 Jul 2025 18:49:02 +0200
Message-ID: <20250707164906.1445288-10-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250707164906.1445288-1-heiko@sntech.de>
References: <20250707164906.1445288-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guochun Huang <hero.huang@rock-chips.com>

Add the necessary specific bits to support the rk3576-variant of the
DW-DSI2 controller.

Signed-off-by: Guochun Huang <hero.huang@rock-chips.com>
[adapted from the vendor-kernel for mainline]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c  | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
index cdd490778756..0aea764e29b2 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
@@ -437,6 +437,15 @@ static void dw_mipi_dsi2_rockchip_remove(struct platform_device *pdev)
 	dw_mipi_dsi2_remove(dsi2->dmd);
 }
 
+static const struct dsigrf_reg rk3576_dsi_grf_reg_fields[MAX_FIELDS] = {
+	[TXREQCLKHS_EN]		= { 0x0028, 1,  1 },
+	[GATING_EN]		= { 0x0028, 0,  0 },
+	[IPI_SHUTDN]		= { 0x0028, 3,  3 },
+	[IPI_COLORM]		= { 0x0028, 2,  2 },
+	[IPI_COLOR_DEPTH]	= { 0x0028, 8, 11 },
+	[IPI_FORMAT]		= { 0x0028, 4,  7 },
+};
+
 static const struct dsigrf_reg rk3588_dsi0_grf_reg_fields[MAX_FIELDS] = {
 	[TXREQCLKHS_EN]		= { 0x0000, 11, 11 },
 	[GATING_EN]		= { 0x0000, 10, 10 },
@@ -455,6 +464,15 @@ static const struct dsigrf_reg rk3588_dsi1_grf_reg_fields[MAX_FIELDS] = {
 	[IPI_FORMAT]		= { 0x0004,  0,  3 },
 };
 
+static const struct rockchip_dw_dsi2_chip_data rk3576_chip_data[] = {
+	{
+		.reg = 0x27d80000,
+		.grf_regs = rk3576_dsi_grf_reg_fields,
+		.max_bit_rate_per_lane = 2500000ULL,
+	},
+	{ /* sentinel */ }
+};
+
 static const struct rockchip_dw_dsi2_chip_data rk3588_chip_data[] = {
 	{
 		.reg = 0xfde20000,
@@ -470,6 +488,9 @@ static const struct rockchip_dw_dsi2_chip_data rk3588_chip_data[] = {
 
 static const struct of_device_id dw_mipi_dsi2_rockchip_dt_ids[] = {
 	{
+		.compatible = "rockchip,rk3576-mipi-dsi2",
+		.data = &rk3576_chip_data,
+	}, {
 		.compatible = "rockchip,rk3588-mipi-dsi2",
 		.data = &rk3588_chip_data,
 	},
-- 
2.47.2



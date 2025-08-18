Return-Path: <linux-kernel+bounces-774587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ED3B2B483
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4724B5E4B51
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F7C27C869;
	Mon, 18 Aug 2025 23:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9ucp7Uc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19F12765C1;
	Mon, 18 Aug 2025 23:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755558874; cv=none; b=ue+cJ9miZPFaB7vythPqyHdMi9VD6Dd533h2YOooOeNfm6WQN7smzirrNVi2lR20+lBhyfN9BDSXGgfJnWugPcWEIOuu9I2PaxLKR5MhILHBIccxv4yPLJhGgT9LeH9VjK5GfzCphJ/kaVJvWbNM+aYFBmRT8LWs5gKoN7INXl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755558874; c=relaxed/simple;
	bh=wzR4Qs8i+nZbzUbJH0z7ZvWkf0jeanCfOT0T/c8WVY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XA/B1fOfi8sI3NZ/vaHy9TOfYUVNBfDC0Orw9rR76XSCmCkEmLAx9esRiGfhtbV2YWihQWxnmRr8Py+Kkam4OyOg371aERnzyjDIEODKUklgyN4WbFlI35ynqfK/Mt3E5eX59EJTILp9Q8Xx3K5zylDKG9k9nRIrlNWcK+M3mso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9ucp7Uc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 854FFC19422;
	Mon, 18 Aug 2025 23:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755558873;
	bh=wzR4Qs8i+nZbzUbJH0z7ZvWkf0jeanCfOT0T/c8WVY0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=L9ucp7Uc0m8SjWdcDmIQXxiOl51ybpRVUE07PHOWyBiCmBI0rRCH06d4EGEArP+6d
	 1Sj1yIldLWSRSUONlREC6FYRwJgLL+k7xeiRO2bKsiX/dpu0ZUmzdEjm39MMYHmCbm
	 r+ag05HrAk8COsjTfcYl4IgZCZg40XB2JAh6385czQsGEUxpWXGD65a2tSlCRUjlIp
	 QLSqKJ9WNMuS1eK1IPGV7uTRgIC31Y/tUGlZZlBNOmC3aItamImegnP+o5Ak+tSWG0
	 yaPllTB+wylW7Zt/q7FRN3P9LrmzjBGd4I53+/LyA8/ZkB2f/rHzsJsrVmAPXa7Mv9
	 ti+E9E31Pf29g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4CECA0EEB;
	Mon, 18 Aug 2025 23:14:33 +0000 (UTC)
From: Michael Riesch via B4 Relay <devnull+michael.riesch.collabora.com@kernel.org>
Date: Tue, 19 Aug 2025 01:00:38 +0200
Subject: [PATCH v2 4/7] phy: rockchip: phy-rockchip-inno-csidphy: allow
 writes to grf register 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rk3588-csi-dphy-v2-4-7a94f079b712@collabora.com>
References: <20250616-rk3588-csi-dphy-v2-0-7a94f079b712@collabora.com>
In-Reply-To: <20250616-rk3588-csi-dphy-v2-0-7a94f079b712@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Diederik de Haas <didi.debian@cknow.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Collabora Kernel Team <kernel@collabora.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, 
 Michael Riesch <michael.riesch@collabora.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755558041; l=1635;
 i=michael.riesch@collabora.com; s=20250410; h=from:subject:message-id;
 bh=l+DL7hvrQb52Alb7OjVyKnZ7Z6pkTmglNXwtSvoPg4M=;
 b=pXPJZwAy06i273TUpg9KStsF+R+c795F7yrhSxnbDxTPGjyeDidNQSJcylokou69ywyeFxbSe
 DW2SJ7n2sj3C+8v1jwb9/XmlIWoeYc+HwLDA+foqYa9v4RP1NChfR7J
X-Developer-Key: i=michael.riesch@collabora.com; a=ed25519;
 pk=+MWX1fffLFZtTPG/I6XdYm/+OSvpRE8D9evQaWbiN04=
X-Endpoint-Received: by B4 Relay for michael.riesch@collabora.com/20250410
 with auth_id=371
X-Original-From: Michael Riesch <michael.riesch@collabora.com>
Reply-To: michael.riesch@collabora.com

From: Michael Riesch <michael.riesch@collabora.com>

The driver for the Rockchip MIPI CSI-2 DPHY uses GRF register offset
value 0 to sort out undefined registers. However, the RK3588 CSIDPHY GRF
this offset is perfectly fine (in fact, register 0 is the only one in
this register file).
Introduce a boolean variable to indicate valid registers and allow writes
to register 0.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Michael Riesch <michael.riesch@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-csidphy.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-csidphy.c b/drivers/phy/rockchip/phy-rockchip-inno-csidphy.c
index 2ab99e1d47eb..75533d071025 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-csidphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-csidphy.c
@@ -87,10 +87,11 @@ struct dphy_reg {
 	u32 offset;
 	u32 mask;
 	u32 shift;
+	u8 valid;
 };
 
 #define PHY_REG(_offset, _width, _shift) \
-	{ .offset = _offset, .mask = BIT(_width) - 1, .shift = _shift, }
+	{ .offset = _offset, .mask = BIT(_width) - 1, .shift = _shift, .valid = 1, }
 
 static const struct dphy_reg rk1808_grf_dphy_regs[] = {
 	[GRF_DPHY_CSIPHY_FORCERXMODE] = PHY_REG(RK1808_GRF_PD_VI_CON_OFFSET, 4, 0),
@@ -145,7 +146,7 @@ static inline void write_grf_reg(struct rockchip_inno_csidphy *priv,
 	const struct dphy_drv_data *drv_data = priv->drv_data;
 	const struct dphy_reg *reg = &drv_data->grf_regs[index];
 
-	if (reg->offset)
+	if (reg->valid)
 		regmap_write(priv->grf, reg->offset,
 			     HIWORD_UPDATE(value, reg->mask, reg->shift));
 }

-- 
2.39.5




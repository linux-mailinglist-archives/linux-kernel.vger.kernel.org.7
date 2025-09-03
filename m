Return-Path: <linux-kernel+bounces-799156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AE1B427D0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1635F3BD14F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96175321420;
	Wed,  3 Sep 2025 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dn3tsSzu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F9A2BE7B8;
	Wed,  3 Sep 2025 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919953; cv=none; b=N8HhCLskK8KTmDdy2NjU1QueoixNZ9IXvAw+bYEYYIVsqPKPr4JZUkigDs1r7YPAtiNqm3lC0IY7tZzKg6jz2mZ6bVkYikiM54IYMnAd+QikWvXHRZZc7QsILrWbLb9HtmgLwKa/NtC/EYk20AQHacKgmO/NbwqYldPqL+UHoN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919953; c=relaxed/simple;
	bh=wzR4Qs8i+nZbzUbJH0z7ZvWkf0jeanCfOT0T/c8WVY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qQ6VsyTagMguPZdg8MrhI8cqJKSckKEdwr8tnqob0e8OgsQgZlYCZRRat9NwrYlkJn9ARrBa6HHTxD1kvuFrnSbhvPtb0ZY9Tl6kmUeYNGtRqKI0njIYNu/Y7OwiYE1s1UPgFdk4RItKDUcXjaeP1oLgsTJ6R9pcF4Fjnl94QZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dn3tsSzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FD88C4CEFA;
	Wed,  3 Sep 2025 17:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756919953;
	bh=wzR4Qs8i+nZbzUbJH0z7ZvWkf0jeanCfOT0T/c8WVY0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dn3tsSzudAg8L9PZhg+TO90PaiBGUQS5eUz9TInxk5VqlsByoUQ0c1osaxAV5PUjQ
	 ar82Y/xLUBrhx9yDV0sY98jDmw5aJIZIubklqmEmPP7NT9f8n+Zs0RwZwaH9iFWqod
	 prNbCOckRkOXqogYQhDcYBMU6Es0S7R1WtlDRi9ardpQtbL0SmTGTiCSYXgWk+Zwc8
	 xhIaC4LXNiYLLZ4c7PvZonkTOxvsmHB/hWwXyzXAfDe+YlLFzUE13Uio9v1V2MRj2f
	 u7wiPaCkrdVq69fbohbAgab9yjx2GsZeqIakbLV4qSZqaGPRBTRegbOyhe6VQsvWZt
	 CocBk/2oZ7KJg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EAFCA1016;
	Wed,  3 Sep 2025 17:19:13 +0000 (UTC)
From: Michael Riesch via B4 Relay <devnull+michael.riesch.collabora.com@kernel.org>
Date: Wed, 03 Sep 2025 19:04:52 +0200
Subject: [PATCH v4 4/7] phy: rockchip: phy-rockchip-inno-csidphy: allow
 writes to grf register 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rk3588-csi-dphy-v4-4-a4f340a7f0cf@collabora.com>
References: <20250616-rk3588-csi-dphy-v4-0-a4f340a7f0cf@collabora.com>
In-Reply-To: <20250616-rk3588-csi-dphy-v4-0-a4f340a7f0cf@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756919100; l=1635;
 i=michael.riesch@collabora.com; s=20250410; h=from:subject:message-id;
 bh=l+DL7hvrQb52Alb7OjVyKnZ7Z6pkTmglNXwtSvoPg4M=;
 b=hux9Hi/hrFdC+fr/TFtPwShVrl0HCnByOxlQmOFhR4GbeK1nmM67xDBCiv0RTujZoeN/yY3bL
 Su+l7pFF4SIC+u5Lf28nxI84VUoBS06Vnc0Sp/h6XmIdEIgtQb4/2rK
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




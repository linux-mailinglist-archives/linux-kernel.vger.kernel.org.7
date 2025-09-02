Return-Path: <linux-kernel+bounces-797309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DD4B40EB0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320665E795F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABA33570AA;
	Tue,  2 Sep 2025 20:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pS73GTkW"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EBC2E7F38
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 20:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756845898; cv=none; b=u7AOYdpmL1kzNlqEP7OLQXsapHUd1A9tbbHwC6RMhejvG2jr8Ybdgpb2R3SmpOzVEJ5mEELkcK3dbssn6Mi82QLBu5CPB2IDKZ2jGRM0qkOUvhIzwgrBsaYWlhENx8qy0031TstVxxA7sc8G2y0ShJYkwIt9MNtnyizpnrnkUs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756845898; c=relaxed/simple;
	bh=NJrsZm+XslOrstRkwUP+LGJxEKnCXN99uXajYxVhMJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b11qnRhojA1sRrl9zXeol+MFJ8NA9iPgMu0b7qctE2lOthWhmg1HxQSpFmgJyklAqJWBSrequsGg0xaA79PuLkKbKLyl0v0l1TCLbOjfc2MkE/Cm7v4skqXoQhOSq7KcqdxvYQmQfb3WX4ezrcSABjXyDyLnbKz5m6/grgctjnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pS73GTkW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756845895;
	bh=NJrsZm+XslOrstRkwUP+LGJxEKnCXN99uXajYxVhMJw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pS73GTkWNh0xdCU1QBI5BCUSS67msH4gcPfcvBSg4jTFOF6OsZafA70swschM0Css
	 86h3Hh4qcbdCowrcDZp8xlab4lT7UG08ne8jCQh8OXvygZR7VnYEifPuEIjXvDkNHA
	 NquFhW3FXue03lr0Xo7TlOtAVRYT4BifZZbEm8BDFp7Umj1Mz3l3gBG8CTTnAJhNfO
	 rcmDdEx29DB9LdvtjUu6tPj3bPL08nyAm3e0crDtOlS7flNyLc7EIO1OwztVSC8kHZ
	 lFomolsYWVZHdO1id24Xns7wxkxxBbugHfa/9upA6FcoqzpilBQ0hPIjNVe872TU+h
	 A7ear5u/tcJ1w==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id CFEE417E136C;
	Tue,  2 Sep 2025 22:44:54 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 23:44:38 +0300
Subject: [PATCH v4 03/11] phy: rockchip: samsung-hdptx: Fix coding style
 alignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-phy-hdptx-frl-v4-3-7d69176373ce@collabora.com>
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

Handle a bunch of reported checkpatch.pl complaints:

  CHECK: Alignment should match open parenthesis

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index b7af27eac293c46647c3abbcb7128939d4ee012d..a729e15de9e097a54c02ea965c5cc85534338302 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -1656,11 +1656,11 @@ static void rk_hdptx_phy_set_voltage(struct rk_hdptx_phy *hdptx,
 		regmap_update_bits(hdptx->regmap, LANE_REG(030a) + offset,
 				   LN_TX_JEQ_EVEN_CTRL_RBR_MASK,
 				   FIELD_PREP(LN_TX_JEQ_EVEN_CTRL_RBR_MASK,
-				   ctrl->tx_jeq_even_ctrl));
+					      ctrl->tx_jeq_even_ctrl));
 		regmap_update_bits(hdptx->regmap, LANE_REG(030c) + offset,
 				   LN_TX_JEQ_ODD_CTRL_RBR_MASK,
 				   FIELD_PREP(LN_TX_JEQ_ODD_CTRL_RBR_MASK,
-				   ctrl->tx_jeq_odd_ctrl));
+					      ctrl->tx_jeq_odd_ctrl));
 		regmap_update_bits(hdptx->regmap, LANE_REG(0311) + offset,
 				   LN_TX_SER_40BIT_EN_RBR_MASK,
 				   FIELD_PREP(LN_TX_SER_40BIT_EN_RBR_MASK, 0x1));
@@ -1670,11 +1670,11 @@ static void rk_hdptx_phy_set_voltage(struct rk_hdptx_phy *hdptx,
 		regmap_update_bits(hdptx->regmap, LANE_REG(030b) + offset,
 				   LN_TX_JEQ_EVEN_CTRL_HBR_MASK,
 				   FIELD_PREP(LN_TX_JEQ_EVEN_CTRL_HBR_MASK,
-				   ctrl->tx_jeq_even_ctrl));
+					      ctrl->tx_jeq_even_ctrl));
 		regmap_update_bits(hdptx->regmap, LANE_REG(030d) + offset,
 				   LN_TX_JEQ_ODD_CTRL_HBR_MASK,
 				   FIELD_PREP(LN_TX_JEQ_ODD_CTRL_HBR_MASK,
-				   ctrl->tx_jeq_odd_ctrl));
+					      ctrl->tx_jeq_odd_ctrl));
 		regmap_update_bits(hdptx->regmap, LANE_REG(0311) + offset,
 				   LN_TX_SER_40BIT_EN_HBR_MASK,
 				   FIELD_PREP(LN_TX_SER_40BIT_EN_HBR_MASK, 0x1));
@@ -1685,11 +1685,11 @@ static void rk_hdptx_phy_set_voltage(struct rk_hdptx_phy *hdptx,
 		regmap_update_bits(hdptx->regmap, LANE_REG(030b) + offset,
 				   LN_TX_JEQ_EVEN_CTRL_HBR2_MASK,
 				   FIELD_PREP(LN_TX_JEQ_EVEN_CTRL_HBR2_MASK,
-				   ctrl->tx_jeq_even_ctrl));
+					      ctrl->tx_jeq_even_ctrl));
 		regmap_update_bits(hdptx->regmap, LANE_REG(030d) + offset,
 				   LN_TX_JEQ_ODD_CTRL_HBR2_MASK,
 				   FIELD_PREP(LN_TX_JEQ_ODD_CTRL_HBR2_MASK,
-				   ctrl->tx_jeq_odd_ctrl));
+					      ctrl->tx_jeq_odd_ctrl));
 		regmap_update_bits(hdptx->regmap, LANE_REG(0311) + offset,
 				   LN_TX_SER_40BIT_EN_HBR2_MASK,
 				   FIELD_PREP(LN_TX_SER_40BIT_EN_HBR2_MASK, 0x1));

-- 
2.51.0



Return-Path: <linux-kernel+bounces-756342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6095CB1B2EC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C01267AEA4B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED84A2737FB;
	Tue,  5 Aug 2025 11:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bj3i2tDo"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC872701D6
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754395015; cv=none; b=Ys2rNCxPsCMdy16QdXxGC/Gf2ODz0Z2Ep5P/2AE6nGl5Qrutsisnuczm61QnvFfpQo15Aferf+gpvMh/RqnDKiRfjkZ9rRDYvC6ZseS19/F+BcoVzBEoIgjTvvbfz3XJwQ/1bCL+HTeWjD1MiQNLoNej1psaWDxWqxuDFWnS+fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754395015; c=relaxed/simple;
	bh=ihOAcadKmnLSfVxfdb1gvr6FclHQYIa9zchja9/Uthg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jJfwvZHEbqOEc75IKTDJTQYFN7qr4YWWygjvNBoNQoY22cGeq5tr5f9U6VT02t530HMRfOQcPvGG/8LKopI2dNq4+NLvBKtNyEQ9+JEOzGt/wjJma59mglkzINRDuT3+2vqc8dKG8bAngj8EGjF6RwoI9fdljtGd9WFfBQE2dbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bj3i2tDo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754395011;
	bh=ihOAcadKmnLSfVxfdb1gvr6FclHQYIa9zchja9/Uthg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bj3i2tDo+MpShmIo61x0MJ9RbjRLrGcT+iVpmJK4rzhAxV46d3uVgD9bBo0ahMaUc
	 bSxigP2QqGp27wcmP/+tq9HCC4d7bUa9DPvRB5BYurq6Nd+3TS3mAJNedCqTHUNBAs
	 AB0DO9fcMOvHPxJMPkpro+V66dmIsLdcy0Yne9q1BThFlmcXqtvonsj0fpKQ8cQMHr
	 +geMP4FlSCWCbYaHTmMo2ViJh3lbwjM/FkcxEKQGvhuqfs8Jp1lit5vy9K0f1Lklpi
	 9N81sBZO1hAdjVcYHnHF/YUPAy2yXMqjzClItRa6AxwYH0Ti3x7fQ2/9HNgh4XxY7s
	 PbPOiLnWlv4Ew==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id A95F217E0E33;
	Tue,  5 Aug 2025 13:56:51 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 05 Aug 2025 14:56:48 +0300
Subject: [PATCH v2 06/14] phy: rockchip: samsung-hdptx: Fix coding style
 alignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-phy-hdptx-frl-v2-6-d118bd4b6e0b@collabora.com>
References: <20250805-phy-hdptx-frl-v2-0-d118bd4b6e0b@collabora.com>
In-Reply-To: <20250805-phy-hdptx-frl-v2-0-d118bd4b6e0b@collabora.com>
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
index 83ec892bd6760865fc9e361f4003c5bfbef55608..495427fc44b385e23da02cd21eefdb137d8b5fdb 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -1657,11 +1657,11 @@ static void rk_hdptx_phy_set_voltage(struct rk_hdptx_phy *hdptx,
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
@@ -1671,11 +1671,11 @@ static void rk_hdptx_phy_set_voltage(struct rk_hdptx_phy *hdptx,
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
@@ -1686,11 +1686,11 @@ static void rk_hdptx_phy_set_voltage(struct rk_hdptx_phy *hdptx,
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
2.50.0



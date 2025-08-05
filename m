Return-Path: <linux-kernel+bounces-756340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2BDB1B2EB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B642A3BA794
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5672627145D;
	Tue,  5 Aug 2025 11:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oPCFnH14"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D3226562D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754395013; cv=none; b=leyMLf5tGHcI3nbHnvZBFDxH7S9TOsMpsrBsF7f0WH6+mvjl5LUN3b9zKEWZnZr0HBgQOh77cvc9nDovRoZkjgnFzH4f8rK9QytFtano1Dimsh0H0direy+Nc17HNMeedyePrRAGcLXCHtb1aJ+odrB6UiDk039z/xJMI1ajBo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754395013; c=relaxed/simple;
	bh=9wBU8JhYvPoGSnFJGrsrJAwh7o0Eea54GHItRyyGWzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hQdMDHzr4MEf1h5taZF3s8bODpQGktaEZVs4bHEg5YFcPkA0OEF4qqB9fHiGvtxt+MASTcf1+fyZ0fIHBg23rcetzSXLQf0EYiC/9oaXlVnt3W4v2jsRKt2TptXeYb23Ac8LjioRiY1zXSBVcHtY9B+zKMfETlW0AjPa9X2M/vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oPCFnH14; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754395010;
	bh=9wBU8JhYvPoGSnFJGrsrJAwh7o0Eea54GHItRyyGWzE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oPCFnH14qsLIiH8VY0hDLco2H6q/IXPxjJj0g409wqgUvql3hoPa6qq1Kjf2vtsWg
	 lt48I9SnqAxTEZy0uoCmZ+RdngcCBUshHunQ91wKZf7ky8w1LHhWcp6w1/QjcLYzjf
	 G8AW30wRaumJOGYn157CbIi/TQ6HTnybXL3B6ExQNKbmeTEaHYpezGFBfxDwsmyCG2
	 umY2CAyInKY6hCCGBU617/TFW49VgaF2LG4XJmN+bLDYtyPZB1r7z8yOC2Q/5CWVxk
	 o9X6UE1LFcdI8NSYX69dxxYhPSdbfZDbf/pa3M6HfmEJas+EEaNfQ7WxuyTNSqyhPr
	 S0vQZOUVn6fVA==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 0412D17E0DB9;
	Tue,  5 Aug 2025 13:56:49 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 05 Aug 2025 14:56:46 +0300
Subject: [PATCH v2 04/14] phy: rockchip: samsung-hdptx: Prevent Inter-Pair
 Skew from exceeding the limits
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-phy-hdptx-frl-v2-4-d118bd4b6e0b@collabora.com>
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

Fixup PHY deskew FIFO to prevent the phase of D2 lane going ahead of
other lanes.  It's worth noting this might only happen when dealing with
HDMI 2.0 rates.

Fixes: 553be2830c5f ("phy: rockchip: Add Samsung HDMI/eDP Combo PHY driver")
Co-developed-by: Algea Cao <algea.cao@rock-chips.com>
Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 9751f7ad00f4faf7041dbf4339f633e09f97b107..5605610465bc812737f773e0f6232cb6dbdc78a4 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -668,13 +668,9 @@ static const struct reg_sequence rk_hdtpx_common_lane_init_seq[] = {
 
 static const struct reg_sequence rk_hdtpx_tmds_lane_init_seq[] = {
 	REG_SEQ0(LANE_REG(0312), 0x00),
-	REG_SEQ0(LANE_REG(031e), 0x00),
 	REG_SEQ0(LANE_REG(0412), 0x00),
-	REG_SEQ0(LANE_REG(041e), 0x00),
 	REG_SEQ0(LANE_REG(0512), 0x00),
-	REG_SEQ0(LANE_REG(051e), 0x00),
 	REG_SEQ0(LANE_REG(0612), 0x00),
-	REG_SEQ0(LANE_REG(061e), 0x08),
 	REG_SEQ0(LANE_REG(0303), 0x2f),
 	REG_SEQ0(LANE_REG(0403), 0x2f),
 	REG_SEQ0(LANE_REG(0503), 0x2f),
@@ -687,6 +683,11 @@ static const struct reg_sequence rk_hdtpx_tmds_lane_init_seq[] = {
 	REG_SEQ0(LANE_REG(0406), 0x1c),
 	REG_SEQ0(LANE_REG(0506), 0x1c),
 	REG_SEQ0(LANE_REG(0606), 0x1c),
+	/* Keep Inter-Pair Skew in the limits */
+	REG_SEQ0(LANE_REG(031e), 0x02),
+	REG_SEQ0(LANE_REG(041e), 0x02),
+	REG_SEQ0(LANE_REG(051e), 0x02),
+	REG_SEQ0(LANE_REG(061e), 0x0a),
 };
 
 static struct tx_drv_ctrl tx_drv_ctrl_rbr[4][4] = {

-- 
2.50.0



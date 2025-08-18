Return-Path: <linux-kernel+bounces-774314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E0EB2B114
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 754EB17F346
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28731311946;
	Mon, 18 Aug 2025 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Gg2zHW0y"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5E22750E2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543566; cv=none; b=GFt9ZPdfpRuB4ZunXBn/E0D1ewe3dD8ypC6lfSxc0O3x+jo10G52+3DU91Qm1kB5UCnnn60u9gvPKlt/Ym0SqkekPLjczOFUZRW+zxDu2Z2dUQ0seWmFD7P/8/RJL5os7F/ijby1fd39iCzzfKiNDzp2w0LuX1aSiH2mxf/oHKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543566; c=relaxed/simple;
	bh=irKcJZIe7TwYJwaAlkqPUW4Mfr+hk+yQ1POjL3nKlqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VHRLS/FIx7tKs4pqIXaSH7fXVk2rwWF5VXD5UMMoFjhY0f7Ag9HYnYAB/SZXGcj8nXchrsMQUhGN9ZGqWtY9dIQ0qCq8gstVVxlQR0ru6lvb1XWVuZK5LpMEgfV/5HbBom1IcC3zd6as5yGnCytGD/ay+ehWhBlmW5XBU7l6QVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Gg2zHW0y; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755543563;
	bh=irKcJZIe7TwYJwaAlkqPUW4Mfr+hk+yQ1POjL3nKlqA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Gg2zHW0y2Tjh07zwpmlmP3KHnbkcmbsMGXc25TtK7hXPakcZkBydjH4gWiZpN3JEx
	 7YdFxvhCYjXSi4Gfm4odO89syIWdkBGH72t+KZ5QfWZHOux8vJIX77A/Dj+T1T9wj8
	 gcmgclIbdlan25Nu/gferlg7cMAy6MPqSve3ZX23jCkmfGRhLjW6RfU8DdVgZ/odnD
	 09V4GyC9Mx6yL5ynED0Qoa0pvwQZxMc8PDG9NC1omF923ixvP/3dhyzHtPurdi6u18
	 Wpbk781Ts3PR0FnAzao8GsdTh0q8ZWKPU71bTlj3U8PRzXX0Tf3jemqzXYbf8NOWxt
	 oIjuXIfAEs6JA==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 0AFAF17E1322;
	Mon, 18 Aug 2025 20:59:23 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Mon, 18 Aug 2025 21:59:04 +0300
Subject: [PATCH v3 04/14] phy: rockchip: samsung-hdptx: Prevent Inter-Pair
 Skew from exceeding the limits
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-phy-hdptx-frl-v3-4-c79997d8bb2b@collabora.com>
References: <20250818-phy-hdptx-frl-v3-0-c79997d8bb2b@collabora.com>
In-Reply-To: <20250818-phy-hdptx-frl-v3-0-c79997d8bb2b@collabora.com>
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
2.50.1



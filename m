Return-Path: <linux-kernel+bounces-873228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43392C136BA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509481A240CF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28902D7DF3;
	Tue, 28 Oct 2025 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YpAVHajv"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463B224E4A8
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761638530; cv=none; b=H3qVwhgZhDl6YgImXc9SwY8JKt8gxtBaj2R3RJv6mMxREbqnuE7tuv6F0VT3KPxXCyWGk7nU9LmBin4PAqmPrXU12g6wqj3Mlz1Z7FrYkHk/w/dwLYsyGYInFOf59EyYrCK+NGxgYRGtOVYInpugeom7BcECkJGJ7JgBnI8FQXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761638530; c=relaxed/simple;
	bh=TNHkPXwgc5tmqyvbeK2fXln0nHFwJI1Jb/ffLMCgK9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BC90e9Uzsfkif8iRF+QIJXh8zFSsvLESfbN4OgX3FRc3jodNvlv0VFYD+4bLAdiDmSX5N4u0YUKk16DDtR2X32bhZrQDX5z9mUEI/Zriprn+k3Pp1v4gpKNBgoh8mXNclNf3TnFRciJxqe54ULAIyuCb1RfwyLUf1MuBBzMptxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YpAVHajv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761638526;
	bh=TNHkPXwgc5tmqyvbeK2fXln0nHFwJI1Jb/ffLMCgK9k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YpAVHajvBYQsiyXBva9b/ZbbvasCAkium04BpsQHT811VRI+ZWsW56dwQ8IkgKHx8
	 1WfbIgZeGvoIZItIrt49UgGPZW3uGC7F/+kq7VvzSKS91+irYZwqVTr6VSGYhzDVjm
	 wTvNtczckSYHaP48GpJ4SNpn3hFzWXSNiPeEbScHF00gB+Fu60F/chkUmREdNLhbeU
	 tEAQ/zFnMm/0zN8yse8MKFPKlcvoZuD8gL156hCWDrkgJbLKQZ3WhXnBYZB3GfZBb5
	 yhFx9Mpq7GfhWUJjxSv9hL3gWUSMEosGDtDhwNyIlC36UUWhfU5UBG8qrOQDbiUUxP
	 VqfINe2aqWPFw==
Received: from localhost (unknown [82.79.138.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 5679A17E1402;
	Tue, 28 Oct 2025 09:02:06 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 28 Oct 2025 10:00:56 +0200
Subject: [PATCH RESEND 3/3] phy: rockchip: samsung-hdptx: Prevent
 Inter-Pair Skew from exceeding the limits
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-phy-hdptx-fixes-v1-3-ecc642a59d94@collabora.com>
References: <20251028-phy-hdptx-fixes-v1-0-ecc642a59d94@collabora.com>
In-Reply-To: <20251028-phy-hdptx-fixes-v1-0-ecc642a59d94@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Dmitry Baryshkov <lumag@kernel.org>, 
 Algea Cao <algea.cao@rock-chips.com>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3

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
index 8ba9b53c2309..29de2f7bdae8 100644
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
2.51.0



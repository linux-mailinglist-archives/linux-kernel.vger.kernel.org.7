Return-Path: <linux-kernel+bounces-756341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8674EB1B2EA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB4E18A1BC0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B273272813;
	Tue,  5 Aug 2025 11:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DJy+8UEv"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A02C26D4E7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754395014; cv=none; b=VJhE/ihWDfbgiu3i9yOsygox2vVWfJma9SeGILEfEiOB3lvaWgPxJr9pZkP2NuI5ZGEfKfpu2OPjJJCkTeYfhonMMxqZXDwtsoM0q+YtnBizRUPMXpZdjizf4KAWsfjHCO8hhlpl7FrvRMkdxzzLlRC7OToj8BuyxQjTVdRokCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754395014; c=relaxed/simple;
	bh=jBClv5lGREd65CCDreNGe33Ns5EABFagpEUptp20jjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZInt6qQBPkPe4VIp9Lso1koXlRYBurSc3xTXG4+RMj6Ga0Fv9uW89ABmlxq1qtQBEyPG1IJWvZdrcElMF0cSamS11iH8MLSxPXGa6lLLiR5VrC8WSh7AKdHFWsB5vdQl0DBNvuZ5wGV9yJCyYMhNr3DT5wj0OUHci8C8xWxl9AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DJy+8UEv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754395011;
	bh=jBClv5lGREd65CCDreNGe33Ns5EABFagpEUptp20jjo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DJy+8UEvGMVv/QCTPj/gcbJijEyo7UDPA4ZARkuEnNWwWfSjwxNKrzv9mGLAaCLIE
	 ukwBh5kgfbP2379yNFR6dw0LsFPWvSj8YtarlYiPFiD4IasquXu4H6M6nG8MeFIlId
	 wgevIum98Qv5qJS3YDGzdAMlcSKyafRJwL4pM599n/1Er6Cl0X4GhuC3IFzjw/6TlH
	 yWFHq1vDIVXUAuIbZVhyGgJpOZjRRGb5lyr8UWRgtkgbgcL7FTcVpkqiELLqJHQRaT
	 i/x3jkA4lIoCbXqzZtpXjkZJOS/mxwbahk8KrPh7/NnOIVR+GhPpDFTnpBLXHWNxJX
	 bQQA7ETVcENrw==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id CB0B917E0DD0;
	Tue,  5 Aug 2025 13:56:50 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 05 Aug 2025 14:56:47 +0300
Subject: [PATCH v2 05/14] phy: rockchip: samsung-hdptx: Use usleep_range()
 instead of udelay()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-phy-hdptx-frl-v2-5-d118bd4b6e0b@collabora.com>
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

rk_hdptx_dp_reset() is allowed to sleep, hence replace the busy waiting
with usleep_range(), to allow other threads to run.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 5605610465bc812737f773e0f6232cb6dbdc78a4..83ec892bd6760865fc9e361f4003c5bfbef55608 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -1075,7 +1075,7 @@ static void rk_hdptx_dp_reset(struct rk_hdptx_phy *hdptx)
 	reset_control_assert(hdptx->rsts[RST_INIT].rstc);
 
 	reset_control_assert(hdptx->rsts[RST_APB].rstc);
-	udelay(10);
+	usleep_range(10, 15);
 	reset_control_deassert(hdptx->rsts[RST_APB].rstc);
 
 	regmap_update_bits(hdptx->regmap, LANE_REG(0301),

-- 
2.50.0



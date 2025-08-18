Return-Path: <linux-kernel+bounces-774315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65756B2B10D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5EEB7B6664
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DA831B101;
	Mon, 18 Aug 2025 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ivgTVbxj"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985812773CC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543567; cv=none; b=ZtlW5v8qI6V3x20NsTLRDEshv8sT8igmTI6cEfpIOqO3v3+vSGPAIWC8saWak33QGnRZjJHJEmQiLIfs8KfUui1HSVYI9VPc6ET1odxeytu1cb2OEnJSgtZUDSNTfqvBQ5hdiUBlEhinHpdT8nrGRCLBVBCFDM6nsNLrdl5WO2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543567; c=relaxed/simple;
	bh=M1dIcKPewO8GjoiDE0+H9+TiBwX2gefN9QiT1gI6ePo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NkIFE89rzDsg9cUy7FqGJY5QtRzlEt01ruAFoSugzsa7ne+SD8gr0mkAs4qc3T/W/OimzLCjlzqW1Py3/3GTtrEwkbDFXvyA9KjKwhdgiP3yp8ZuT9ktYYb320Tkliypm1N8FbkDa0NhRev/7pqWK35cM8AkSZT+syAGNqULCgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ivgTVbxj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755543564;
	bh=M1dIcKPewO8GjoiDE0+H9+TiBwX2gefN9QiT1gI6ePo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ivgTVbxjl01+N69VTQFV5SLwFWo5Hh5J+7LLAqX13Kk+cuLs4eBoYOQpY1xvbQLi8
	 L2PevdS2lm3HMrb19yn/0MhkZXZJvXb9u7sY5yQPQhitkYyl9NwdVmmV/6P9KWgSYu
	 5UIbs6LETd6uoACcmShm2mgWpZ0/vj+JEufDXFa/DwXAaHr36hksIxafkWEDpUUKrm
	 IiaVRv0yV4yVfMBCHiP+UF6pkfD0yTQo9DzEyBgIrfrkxqVrtLGBJfdUJA2NxDoJcs
	 Ct6vwGvmOvaDt2epQuhhHvQRKb6Hn4yprzaJSA/+wJGKoNSE+VdqN5NYLvtW16D1cy
	 R7W3tvCsP2C/g==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id C445817E1357;
	Mon, 18 Aug 2025 20:59:23 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Mon, 18 Aug 2025 21:59:05 +0300
Subject: [PATCH v3 05/14] phy: rockchip: samsung-hdptx: Use usleep_range()
 instead of udelay()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-phy-hdptx-frl-v3-5-c79997d8bb2b@collabora.com>
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
2.50.1



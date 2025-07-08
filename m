Return-Path: <linux-kernel+bounces-722270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB571AFD72C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A1D27B5E9E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBF4230BEF;
	Tue,  8 Jul 2025 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ph0J5lb5"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F39225793
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 19:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003444; cv=none; b=PKLhF4cEUcWEIE597uQFnI6Pyyg1PBdsTtxTqDlnyUhYsR2Pr0kLVbHnB90mXskTeu1lr9O3ZTKxf8C3eaLQn7XWErkAZGz5Q3EYwT0jjIXLvRza67dcDCeuFKJMztXjF4AqzCuQqkxU5NfBymJxKzj4+vguBcmKg2gKvugVCTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003444; c=relaxed/simple;
	bh=+erTwrLAUAZ2OsDl2bkXkrwnk4JpthhQCZF8qikCfo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qF3KsKnddxEJ0UHb8E79zRvyImmzkAGn1ksJf0qPXYghTAuOqNQt/FhGGdwXlmbYS6Rw42c+Rv5cVBXc00pVTJzTEuCkXjHzS3doDE1G7DdHRkFnet6l4G6L4HCBbiBxATPOSmOB+gi0DnI66MrWQ+pk4VTG4dc96fV4D1q+55o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ph0J5lb5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752003441;
	bh=+erTwrLAUAZ2OsDl2bkXkrwnk4JpthhQCZF8qikCfo4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ph0J5lb58BZKDnah1X9pNHZcabTHk+EwvqIKCARjcKyhFI8esQ4Ummsy3erLqvLPP
	 cSV5GbvvnCPMfkCcJzveqn7BY4uga8EZwN0/JO6T3Oki4FFLIkfnzbUQ9+alxfqz7T
	 i+QY6YAnDA62YNH97ROBm9k5m16zlslFHHk8l44Lu02XVWskxFR5RseDGmmoIJaPsB
	 P/UGj7My5M6V4teGLlph7tmgSF9K04lndrBtmAxkAeZSX1YalBDqO4DtEUgdRTnGzz
	 X8W3ID9XVBbhteAOsIJn0PZwXYEBM+CpjkaGliRtPf2ei6UVvxDOlIo/oo5g2SEYx+
	 0FzkarYZiEBMw==
Received: from localhost (unknown [212.93.144.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 0B6F017E04AA;
	Tue,  8 Jul 2025 21:37:21 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 08 Jul 2025 22:35:45 +0300
Subject: [PATCH 04/12] phy: rockchip: samsung-hdptx: Use usleep_range()
 instead of udelay()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-phy-hdptx-frl-v1-4-cfe096e224f4@collabora.com>
References: <20250708-phy-hdptx-frl-v1-0-cfe096e224f4@collabora.com>
In-Reply-To: <20250708-phy-hdptx-frl-v1-0-cfe096e224f4@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>
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
index 2dd70f0cd8de34aad957d4d146366e5521cd897e..6f12ac54abc1e1f0d67226899bb2c394e71a99cf 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -1074,7 +1074,7 @@ static void rk_hdptx_dp_reset(struct rk_hdptx_phy *hdptx)
 	reset_control_assert(hdptx->rsts[RST_INIT].rstc);
 
 	reset_control_assert(hdptx->rsts[RST_APB].rstc);
-	udelay(10);
+	usleep_range(10, 15);
 	reset_control_deassert(hdptx->rsts[RST_APB].rstc);
 
 	regmap_update_bits(hdptx->regmap, LANE_REG(0301),

-- 
2.50.0



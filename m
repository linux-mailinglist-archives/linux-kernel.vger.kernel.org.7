Return-Path: <linux-kernel+bounces-797088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B01B40BA4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762A93B63C0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8288A342CBB;
	Tue,  2 Sep 2025 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nfaH1FYX"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1092DC34E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832842; cv=none; b=mzV51VwQH0L87tyLeBejHoJ51zufzbl7gk26+paadnY1jMlEnPMBl3XxX6mo1y7OlmAd3s5uEbladJrXPtXtcRZT7ESmvVL4CMMhqrnmtRy4RG40FThUJoqJpU6epPVj2v8qDADjHdJyYtYMgRDOEbYngqzJ1qhEsDkHrJROXXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832842; c=relaxed/simple;
	bh=QPBBXvF4CU0wV1LurPOFo7Rxahye8bU0R5m3P6yDM8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c03pjec67YcRWNmI0vSf3LrdWepieVRbShGST5ZpTNh8sPpTyqyv+0ZAUACMlWs1NwQbjV342zEvTmv4N0Q+TkUlrgcaqhPU21fMO2i5MvEbc+oNktmDogM/32ecZeCsbm9H9KvDb6m5rd2l3+d1fVHH3UFlsB5vd/pQYMbpRFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nfaH1FYX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756832839;
	bh=QPBBXvF4CU0wV1LurPOFo7Rxahye8bU0R5m3P6yDM8c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nfaH1FYXk8NE2nhYBWpJ4GjKfiCFL1R2a1VfYh0O5CXkelLtWCQJZr+csyO+pyFgv
	 GiVe7Bn6OXoWqGRzoZiY3ZLdueArI4zcdVRUHtNpGRv5SOgzNkchztqHWoev+P2wgF
	 OLvpUjl4LcfBSI7MrmehNPWxUVnaRnv1Iqitd9z0iJ7AeWXJMamgR0XIByjY618Nwy
	 j2fvbO/mpc5rM7ozFc9O67qHAIMEDNDwbr0Uv9Z22OqTKWmKQsvr9lSXXpQl+SO4SJ
	 GIHB4RskvpkOe0z/L0SqN0sJMzjGLwFqNYRjCPHYTHa4CptHwfuIVipwoDIquEvHM0
	 4AdEe9XBVWU8w==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 2630F17E131D;
	Tue,  2 Sep 2025 19:07:19 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 20:07:00 +0300
Subject: [PATCH 2/3] phy: rockchip: samsung-hdptx: Reduce ROPLL loop
 bandwidth
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-phy-hdptx-fixes-v1-2-e8d9ef9748d6@collabora.com>
References: <20250902-phy-hdptx-fixes-v1-0-e8d9ef9748d6@collabora.com>
In-Reply-To: <20250902-phy-hdptx-fixes-v1-0-e8d9ef9748d6@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Dmitry Baryshkov <lumag@kernel.org>, 
 Algea Cao <algea.cao@rock-chips.com>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Due to its relatively low frequency, a noise stemming from the 24MHz PLL
reference clock may traverse the low-pass loop filter of ROPLL, which
could potentially generate some HDMI flash artifacts.

Reduce ROPLL loop bandwidth in an attempt to mitigate the problem.

Fixes: 553be2830c5f ("phy: rockchip: Add Samsung HDMI/eDP Combo PHY driver")
Co-developed-by: Algea Cao <algea.cao@rock-chips.com>
Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index aee03e8655f66d4b25de39bd2b2bf49d7a8b5b86..8ba9b53c2309b22a496574b7731377049f50068f 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -500,9 +500,7 @@ static const struct reg_sequence rk_hdtpx_common_cmn_init_seq[] = {
 	REG_SEQ0(CMN_REG(0043), 0x00),
 	REG_SEQ0(CMN_REG(0044), 0x46),
 	REG_SEQ0(CMN_REG(0045), 0x24),
-	REG_SEQ0(CMN_REG(0046), 0xff),
 	REG_SEQ0(CMN_REG(0047), 0x00),
-	REG_SEQ0(CMN_REG(0048), 0x44),
 	REG_SEQ0(CMN_REG(0049), 0xfa),
 	REG_SEQ0(CMN_REG(004a), 0x08),
 	REG_SEQ0(CMN_REG(004b), 0x00),
@@ -575,6 +573,8 @@ static const struct reg_sequence rk_hdtpx_tmds_cmn_init_seq[] = {
 	REG_SEQ0(CMN_REG(0034), 0x00),
 	REG_SEQ0(CMN_REG(003d), 0x40),
 	REG_SEQ0(CMN_REG(0042), 0x78),
+	REG_SEQ0(CMN_REG(0046), 0xdd),
+	REG_SEQ0(CMN_REG(0048), 0x11),
 	REG_SEQ0(CMN_REG(004e), 0x34),
 	REG_SEQ0(CMN_REG(005c), 0x25),
 	REG_SEQ0(CMN_REG(005e), 0x4f),

-- 
2.51.0



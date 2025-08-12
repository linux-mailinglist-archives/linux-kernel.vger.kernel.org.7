Return-Path: <linux-kernel+bounces-765097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D311B22B5A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57DA33AA6D3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A37C2EF645;
	Tue, 12 Aug 2025 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="wifyCwkw"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D1028000D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755010939; cv=none; b=VayV3c26zChrT42sGVMQfut358KtOBtZ8Ccr85/3hnLd9UXiWllysvDyGG1zr0rXSNqu0OWlfsly9VFwpWodhifi8o/fmzmww3lLm/dsMVcNNhRbd5bjQhI6lLsJLjLdC/SqLaaS8yE8AoUe9OH/iRhy1iJL2fL/ir9t1BdLzCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755010939; c=relaxed/simple;
	bh=+i9M0gmIij0VNVeyBfq3lwmL+fMAyFN7TKXMhNT7Sig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PjXJ/dfIbXznKt8d1MR5mH8pLltiwPQdZ7r55Ivwdy/t19Gz+XtwtKpzbrpvyoMzSQwmFZiy1HUodDC2xCgb5nhdvCyHauFX6snqrwxDB8qaThYEBOmX8MpiyO5UlX//BHnQ+fopP7R7ODqUnlsMIsJPloVGUyFN1Sf2+oenaZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=wifyCwkw; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=2VkIKlblba9WFkmenTXpPIqq84rYzCyImM7Q0AHXy3k=; b=wifyCwkwUbqJZwuXlj5yaBcMH1
	2/TVBmEOOq9QpItnTrSOyY0MjmhVotrk1eRpimODPFcZDC1bjmMuIjo44t2PwbAtOw7jYOm3pwvC6
	7+CS6oidJ+xLxi6IFeQ1Sy9atvU8XHsmDNiqmwbsR6qqCVAgfqcDb2/ETKjtf30xp9KTEhqhZOWWs
	JrJu2OP/N+rejZVBlSiX9w3Uh+s3f5UCB4Lw5g/W8sK5nWcZl7UHzf5n4Zj2lgRO9NJa/YcMDZ8WB
	jbn9TrNJ+iIMj8PIEkU+0IOB9QZDj79lEMKMB+p8WaA4opNYq5bTcir8TJnAgEAIIL7lMwToMbni2
	B/tzhhzw==;
Received: from i53875a42.versanet.de ([83.135.90.66] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ulqVd-0004VY-UD; Tue, 12 Aug 2025 17:01:53 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/rockchip: vop2: move clk-disable into its own function
Date: Tue, 12 Aug 2025 17:01:43 +0200
Message-ID: <20250812150143.1126584-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right now vop2_enable calls vop2_core_clks_prepare_enable to handle the
vop clocks, but vop2_disable directly disables the clocks.

Not nice from a symmetry point of view and also if we ever need to disable
the clocks elsewhere, this would become a problem, so move clock disable
into its own function as well.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 07ea2d2cf6d6..827ce440026c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -785,6 +785,13 @@ static int vop2_core_clks_prepare_enable(struct vop2 *vop2)
 	return ret;
 }
 
+static void vop2_core_clks_disable_unprepare(struct vop2 *vop2)
+{
+	clk_disable_unprepare(vop2->pclk);
+	clk_disable_unprepare(vop2->aclk);
+	clk_disable_unprepare(vop2->hclk);
+}
+
 static void rk3588_vop2_power_domain_enable_all(struct vop2 *vop2)
 {
 	u32 pd;
@@ -867,9 +874,7 @@ static void vop2_disable(struct vop2 *vop2)
 
 	regcache_drop_region(vop2->map, 0, vop2_regmap_config.max_register);
 
-	clk_disable_unprepare(vop2->pclk);
-	clk_disable_unprepare(vop2->aclk);
-	clk_disable_unprepare(vop2->hclk);
+	vop2_core_clks_disable_unprepare(vop2);
 }
 
 static bool vop2_vp_dsp_lut_is_enabled(struct vop2_video_port *vp)
-- 
2.47.2



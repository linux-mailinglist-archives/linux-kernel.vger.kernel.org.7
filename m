Return-Path: <linux-kernel+bounces-783432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 128A0B32D88
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 06:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DCDD1895F93
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 04:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACFA1C3027;
	Sun, 24 Aug 2025 04:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Lx3OufbY"
Received: from mail-m83233.xmail.ntesmail.com (mail-m83233.xmail.ntesmail.com [156.224.83.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E949F393DD8
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 04:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.224.83.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756010163; cv=none; b=OHBeIk6GvZj9CONHdJhITwOrsXJckTnJFOuZCTJ3MQK1XOoE5Ut5OF0xp8RI0DJ1//lJ87Fh69S7pgzWs0qVjwYmLwZ7IHz+0k6p+h0ZOnivhwAl96nZFfLMEzdFYUQWwY0jH/iSDpsbyqfzCJHeQ5/7/ijUVSj0jtx27TtocSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756010163; c=relaxed/simple;
	bh=h8R0pwzX6jVl/Zeo1RplmvRoc0EOqmNZ8U7PJ2NO06I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ulO7nBYdKGuBnXlyai29DJBAzNq6g4YqqFESv/gPCeeyVrgFFC9GHd5XT0uj3a2guK3Vw/0zbY+9E8+hR1U71FqA7zkrBnjPHIQtoEShU4YKx1+aNJAIcN7T4hhdyWe86mihz00ZySyMxrmcsbjA0aK2RVxKynHOaTgJGhqLdHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Lx3OufbY; arc=none smtp.client-ip=156.224.83.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2061a0ed0;
	Sun, 24 Aug 2025 11:20:20 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: heiko@sntech.de,
	andy.yan@rock-chips.com,
	hjc@rock-chips.com
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dmitry.baryshkov@oss.qualcomm.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v1] drm/rockchip: analogix_dp: Apply devm_clk_get_optional() for &rockchip_dp_device.grfclk
Date: Sun, 24 Aug 2025 11:19:32 +0800
Message-Id: <20250824031932.3204920-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98da175af603a3kunmd9d8bd7f283bbc
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR4aSlYaQ0hDGU4eGEIfGR9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Lx3OufbYegL70szaqn0wNQFhAMi9nw0CxufPmzZR6NNkQ09LpQry93DJzGXEF7ptgCqtYPbu2rT950PixuQ0WWO/GMvz18xww0H+DGQEjT9gaehtu2XOqGvfmYx2IdeSbWLo4qKxY30hICmSYXiHiHh7vumK9J7XyAOSqEEBokU=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=tIZnIOy9j57D5cV3OPQ/tYhpxNdNBEy5VY9qhEUGWMI=;
	h=date:mime-version:subject:message-id:from;

The "grf" clock is optional for Rockchip eDP controller(RK3399 needs
while RK3288 and RK3588 do not).

It can make the code more consice to use devm_clk_get_optional()
instead of devm_clk_get() with extra checks.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index d30f0983a53a..d0f78ab9faa6 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -335,12 +335,8 @@ static int rockchip_dp_of_probe(struct rockchip_dp_device *dp)
 		return PTR_ERR(dp->grf);
 	}
 
-	dp->grfclk = devm_clk_get(dev, "grf");
-	if (PTR_ERR(dp->grfclk) == -ENOENT) {
-		dp->grfclk = NULL;
-	} else if (PTR_ERR(dp->grfclk) == -EPROBE_DEFER) {
-		return -EPROBE_DEFER;
-	} else if (IS_ERR(dp->grfclk)) {
+	dp->grfclk = devm_clk_get_optional(dev, "grf");
+	if (IS_ERR(dp->grfclk)) {
 		DRM_DEV_ERROR(dev, "failed to get grf clock\n");
 		return PTR_ERR(dp->grfclk);
 	}
-- 
2.34.1



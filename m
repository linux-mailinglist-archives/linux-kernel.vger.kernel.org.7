Return-Path: <linux-kernel+bounces-892533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF48C454BC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43A4188F05F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5002E8E14;
	Mon, 10 Nov 2025 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Lokkuw3y"
Received: from mail-m49194.qiye.163.com (mail-m49194.qiye.163.com [45.254.49.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3323B212560
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762761842; cv=none; b=Cme/QX6jK4z2zXs3l4kBFURhhqiLUy3axUZ80bCay92HvDmgEkRu7ubWC+Mgw70lQOkB+m4mw9AvCMfiS6QbmHYB4P9bIS7eS6rp9ty/LKPR9FKYUvshfQbdGXyS2NdzXMdPpuXzVtrG4urDm1Q+AqK/Mnh3G8VWSQbh8Z/tm6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762761842; c=relaxed/simple;
	bh=Ra+ykURHlHSSqUFO9vQS2wp7i4FSmbC+PxD4uqsXlDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PXLvuWLOTMrxCo5jlwngmeZPNCsPGcVWtnaJkpdsdOqo5VPZwgTyNrOZaWZodKHMRvmzfE+tIkYJ8gGlDDWdqdhgC7Y/MN8uPzV6TX2PLlPpZtLet8X7ZPjKNU/UPZ2QEovM3Fd3nvbDm5YhTswnXFVvQ1/Ay648LdK2bRJeRas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Lokkuw3y; arc=none smtp.client-ip=45.254.49.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2903d7367;
	Mon, 10 Nov 2025 15:58:41 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: heiko@sntech.de,
	andy.yan@rock-chips.com,
	hjc@rock-chips.com
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v1] drm/rockchip: analogix_dp: Use dev_err_probe() instead of DRM_DEV_ERROR() during probing
Date: Mon, 10 Nov 2025 15:58:17 +0800
Message-Id: <20251110075817.1159857-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a6cc63ab203a3kunm8d5d83d11091403
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkkZSVYfQ0xDQh0ZSB8ZGh5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Lokkuw3yyN+NLB/K0CY5sAgotoS17XdzjMh0apqMeFsC0A/x7oRiYIywvudPBCawqyiKJrIZr2++pegwKJdImi/A9g6/3d/P4FAXyUwVNEkfK0xNognTWpS5pG5GREbmQvJ4WBLPNnWvNB2DgJCjhcbirpW2ne8axrlZ2BayWL4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=cBL7Pcb/kOyjsK6nTlHrlSIR86VZRY5J3XGsowllQ1M=;
	h=date:mime-version:subject:message-id:from;

The DRM_DEV_ERROR() has been deprecated, and use dev_err_probe()
can be better. The other reason is that dev_err_probe() help avoid
unexpected repeated err logs during defered probing.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

As Heiko suggested[0], the other similar codes in
rockchip_dp_of_probe() should be modified to dev_err_probe().

[0] https://lore.kernel.org/all/8513b4b6-0b59-4b42-864b-0fe0423cd7fd@rock-chips.com/
---
 .../gpu/drm/rockchip/analogix_dp-rockchip.c   | 31 +++++++++----------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 937f83cf42fc..94da0f745525 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -330,32 +330,29 @@ static int rockchip_dp_of_probe(struct rockchip_dp_device *dp)
 	struct device_node *np = dev->of_node;
 
 	dp->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
-	if (IS_ERR(dp->grf)) {
-		DRM_DEV_ERROR(dev, "failed to get rockchip,grf property\n");
-		return PTR_ERR(dp->grf);
-	}
+	if (IS_ERR(dp->grf))
+		return dev_err_probe(dev, PTR_ERR(dp->grf),
+				     "failed to get rockchip,grf property\n");
 
 	dp->grfclk = devm_clk_get_optional(dev, "grf");
 	if (IS_ERR(dp->grfclk))
-		return dev_err_probe(dev, PTR_ERR(dp->grfclk), "failed to get grf clock\n");
+		return dev_err_probe(dev, PTR_ERR(dp->grfclk),
+				     "failed to get grf clock\n");
 
 	dp->pclk = devm_clk_get(dev, "pclk");
-	if (IS_ERR(dp->pclk)) {
-		DRM_DEV_ERROR(dev, "failed to get pclk property\n");
-		return PTR_ERR(dp->pclk);
-	}
+	if (IS_ERR(dp->pclk))
+		return dev_err_probe(dev, PTR_ERR(dp->pclk),
+				     "failed to get pclk property\n");
 
 	dp->rst = devm_reset_control_get(dev, "dp");
-	if (IS_ERR(dp->rst)) {
-		DRM_DEV_ERROR(dev, "failed to get dp reset control\n");
-		return PTR_ERR(dp->rst);
-	}
+	if (IS_ERR(dp->rst))
+		return dev_err_probe(dev, PTR_ERR(dp->rst),
+				     "failed to get dp reset control\n");
 
 	dp->apbrst = devm_reset_control_get_optional(dev, "apb");
-	if (IS_ERR(dp->apbrst)) {
-		DRM_DEV_ERROR(dev, "failed to get apb reset control\n");
-		return PTR_ERR(dp->apbrst);
-	}
+	if (IS_ERR(dp->apbrst))
+		return dev_err_probe(dev, PTR_ERR(dp->apbrst),
+				     "failed to get apb reset control\n");
 
 	return 0;
 }
-- 
2.34.1



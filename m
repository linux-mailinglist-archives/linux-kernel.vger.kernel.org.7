Return-Path: <linux-kernel+bounces-813319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC442B5437D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A731C80C15
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BDB29E101;
	Fri, 12 Sep 2025 07:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="T6HBA5xo"
Received: from mail-m1973191.qiye.163.com (mail-m1973191.qiye.163.com [220.197.31.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765E2299A8E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757660826; cv=none; b=Ehqh157iEoGbV/bKovvU5J63z51t+ZR6SbsP8SUCDM3R+CMq6cGwhWHm9ro2V4DHvgfMdwFoi1Ak5CcQ3rWjsEHcloWsS6IYCz4LAMbZPPpIg80wKdsJo3aMx5inFwmG3zR2z50qtfGi9ZGMh5BEeWVlTU1QNtNCbVIbhhv5ERQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757660826; c=relaxed/simple;
	bh=XAzsXpm0YeVBnC+4rYOk6KkHRI2q7s9VMRz/i1NcDug=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fqd9p/+dq1YSQvWQAtCQbvRLi4IEpLgrnNHm22gQA2ij0XVwdAQ0LWJioEn6OVvOBEsRXzGXWQFzi+CGQnSWnf8oSFkT7eXQdRefpAdkzFAVFoHBKUgJzc4gexu6IoDSACG6Ec/bXS5auPoNA12qXqrt3BWMpx0HlT6M0WU2dRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=T6HBA5xo; arc=none smtp.client-ip=220.197.31.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 228cf42bf;
	Fri, 12 Sep 2025 11:37:50 +0800 (GMT+08:00)
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
	Damon Ding <damon.ding@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v3] drm/rockchip: analogix_dp: Apply devm_clk_get_optional() for &rockchip_dp_device.grfclk
Date: Fri, 12 Sep 2025 11:37:25 +0800
Message-Id: <20250912033725.4054304-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a993c0034cc03a3kunm74a946b99d0374
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUgfQ1ZOSE9KTkoYHx9CHx1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=T6HBA5xoEntcxaxL1UxN5gxv62xuBDnFoO4RPii/PwIzDb4I4xGBN26QdOMZCfoDyG8kt+BKR7SdhdDsXfyU+A8GTsYSXLE4GNIGdJngnC8Yt8L7VBSVO2VXMlMxG6EERgJp9C1MMtnn6Scw5UmIfjYmXdpFgmosYrpio+6oEV8=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=0W+y5K8NTQvQx4kvJHari7pfRGCnr5lxmaUJ+MriK1E=;
	h=date:mime-version:subject:message-id:from;

The "grf" clock is optional for Rockchip eDP controller(RK3399 needs
while RK3288 and RK3588 do not).

It can make the code more consice to use devm_clk_get_optional()
instead of devm_clk_get() with extra checks.

In addtion, DRM_DEV_ERROR() is replaced by dev_err_probe().

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

------

Changes in v2:
- Replace DRM_DEV_ERROR() with dev_err_probe().

Changes in v3:
- Update Reviewed-by tag.
---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index d30f0983a53a..937f83cf42fc 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -335,15 +335,9 @@ static int rockchip_dp_of_probe(struct rockchip_dp_device *dp)
 		return PTR_ERR(dp->grf);
 	}
 
-	dp->grfclk = devm_clk_get(dev, "grf");
-	if (PTR_ERR(dp->grfclk) == -ENOENT) {
-		dp->grfclk = NULL;
-	} else if (PTR_ERR(dp->grfclk) == -EPROBE_DEFER) {
-		return -EPROBE_DEFER;
-	} else if (IS_ERR(dp->grfclk)) {
-		DRM_DEV_ERROR(dev, "failed to get grf clock\n");
-		return PTR_ERR(dp->grfclk);
-	}
+	dp->grfclk = devm_clk_get_optional(dev, "grf");
+	if (IS_ERR(dp->grfclk))
+		return dev_err_probe(dev, PTR_ERR(dp->grfclk), "failed to get grf clock\n");
 
 	dp->pclk = devm_clk_get(dev, "pclk");
 	if (IS_ERR(dp->pclk)) {
-- 
2.34.1



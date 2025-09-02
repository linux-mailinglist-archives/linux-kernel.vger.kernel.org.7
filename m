Return-Path: <linux-kernel+bounces-796247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAA3B3FDC9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1432A2C27D5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80220258EF0;
	Tue,  2 Sep 2025 11:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bb4+6FXc"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCD72F2E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756812618; cv=none; b=BXBajxGfm8P/5yZp9svkfGvooMQ1CPGn6q5NAAi1zp3k5Bx9pdOVNrW1x4yZOPKZWCvnIxFgnhjpossTA2910P3FeySZkn89nbVVrZWhO7/u+3NqLbosfyxe8CbDQkK2Yndnf32qxy7FrUInLMEZ+fme/gIoPWWVZB8RaNMHFMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756812618; c=relaxed/simple;
	bh=RPhlQObkoHAre6eeYwTwGveSbepWwNsly9sy7ZckOMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L3dOwvK0P3cT1ok3mThKdLoHTpAxxev0sdmyXDxk/LE+Q6mum/2xoTDWsNv3rwgaZ31Pmos4EoxPG7b+dYbOkmHdZTWDLvdxTXrSu24zZ1LyPY64RtC/81JffzaOgrRqQDIfZiRqelqsF43s2XqtEssdQNkREtBVlIdUQVUWZsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bb4+6FXc; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=O2
	jNJs+6gEldsE4ZESof941zcVbZy7vYJYussm6EMM4=; b=bb4+6FXcO+dUnuA5vP
	Q+gC8qX1EszRH3+3iHMBw2qMoZzn1JexMrUw9egT6C90O7KbqA3WMvGxk/tpG4xV
	JFrDVp3/EozsWzFJeFQxKKk4RNo+ehRq0NeD3TTlFmL/7G8iJYk0vI93ZZQ6/7L7
	BMbpxf02clp5mEc0ttzo2e0xk=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBnL9cT1bZoLZjNGA--.11797S2;
	Tue, 02 Sep 2025 19:29:27 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: dmitry.baryshkov@oss.qualcomm.com
Cc: dan.carpenter@linaro.org,
	jonas@kwiboo.se,
	Laurent.pinchart@ideasonboard.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH] drm/bridge: dw-dp: Fix the EMPHASIS_SHIFT for dw_dp_voltage_max
Date: Tue,  2 Sep 2025 19:29:14 +0800
Message-ID: <20250902112922.684581-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnL9cT1bZoLZjNGA--.11797S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFyUCr45Aw1UurWrtry7Jrb_yoW8GrWkpF
	sxWFy7Kr1kXF43ta4xCr109Fn8ZasrZaySqFW7Jwsavr17uF1fuasFkFW3Wryqgw1UGrWj
	vFs3Xry5Gw1qkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UvD7-UUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEAC8Xmi20iFqcwAAsG

From: Andy Yan <andy.yan@rock-chips.com>

The p(pre_emphasis) should be left-shifted by DP_TRAIN_PRE_EMPHASIS_SHIFT
to match the logic of dw_dp_voltage_max.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/dri-devel/aLaQLlJC8qMrnDAf@stanley.mountain/T/#u
Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support library")
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 9bbfe8da3de02..e23462b49a4fb 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -767,7 +767,7 @@ static bool dw_dp_link_get_adjustments(struct dw_dp_link *link,
 			adj->pre_max_reached[i] = false;
 		}
 
-		v = min(v, dw_dp_voltage_max(p));
+		v = min(v, dw_dp_voltage_max(p << DP_TRAIN_PRE_EMPHASIS_SHIFT));
 		if (v >= (DP_TRAIN_VOLTAGE_SWING_LEVEL_3 >> DP_TRAIN_VOLTAGE_SWING_SHIFT)) {
 			adj->voltage_swing[i] = DP_TRAIN_VOLTAGE_SWING_LEVEL_3 >>
 						DP_TRAIN_VOLTAGE_SWING_SHIFT;
-- 
2.43.0

base-commit: cbcbb361cba5016331b2ba03fc09d755fc7cde38
branch: heads/drm-misc-next-2025-08-28



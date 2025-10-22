Return-Path: <linux-kernel+bounces-864730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A77BFB6B2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D9F427355
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD403126A3;
	Wed, 22 Oct 2025 10:33:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B2930FC07
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761129186; cv=none; b=YB+K/vjVKs+be2YLyf6z6SQd9ion8D8W+ccwqVnoXUTS4P2jBdIxbMlLnOwDMth3XYGaMPZk3DNXP4tVP8fGH9RHanB6mqloaEftUqSvejwl6cDSkSB5dtvao33E3jSWZZBMCMv7hWh3fGWlmZmM6OfCuiNU0OUHONjTwIdbm5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761129186; c=relaxed/simple;
	bh=XIybbZVPQMIeA4WthW522FPDGleKduA3FvaiiL/HsDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=itvFA9kppyMh8Mq1oEw7uTrx8e4WsCj7XKFXsehUgnNQ1sz7Rj9KBGyLYx38sUkBtnSEbUiPlI+xkfTg4QVPFPjYfclAKeqhidaRvPYoSpA+V1kdWQLCZcJQVB0MO0r3mmvaJ4JwRhpU7jqARt3x/FDR08luaQMIaVHaLhvHzkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 610511655;
	Wed, 22 Oct 2025 03:32:55 -0700 (PDT)
Received: from e120398-lin.trondheim.arm.com (e120398-lin.trondheim.arm.com [10.40.16.110])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62FA53F63F;
	Wed, 22 Oct 2025 03:33:00 -0700 (PDT)
From: Ketil Johnsen <ketil.johnsen@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Ketil Johnsen <ketil.johnsen@arm.com>,
	Grant Likely <grant.likely@linaro.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panthor: Fix race with suspend during unplug
Date: Wed, 22 Oct 2025 12:32:41 +0200
Message-ID: <20251022103242.1083311-1-ketil.johnsen@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a race between panthor_device_unplug() and
panthor_device_suspend() which can lead to IRQ handlers running on a
powered down GPU. This is how it can happen:
- unplug routine calls drm_dev_unplug()
- panthor_device_suspend() can now execute, and will skip a lot of
  important work because the device is currently marked as unplugged.
- IRQs will remain active in this case and IRQ handlers can therefore
  try to access a powered down GPU.

The fix is simply to take the PM ref in panthor_device_unplug() a
little bit earlier, before drm_dev_unplug().

Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
Fixes: 5fe909cae118a ("drm/panthor: Add the device logical block")
---
 drivers/gpu/drm/panthor/panthor_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 81df49880bd87..962a10e00848e 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -83,6 +83,8 @@ void panthor_device_unplug(struct panthor_device *ptdev)
 		return;
 	}
 
+	drm_WARN_ON(&ptdev->base, pm_runtime_get_sync(ptdev->base.dev) < 0);
+
 	/* Call drm_dev_unplug() so any access to HW blocks happening after
 	 * that point get rejected.
 	 */
@@ -93,8 +95,6 @@ void panthor_device_unplug(struct panthor_device *ptdev)
 	 */
 	mutex_unlock(&ptdev->unplug.lock);
 
-	drm_WARN_ON(&ptdev->base, pm_runtime_get_sync(ptdev->base.dev) < 0);
-
 	/* Now, try to cleanly shutdown the GPU before the device resources
 	 * get reclaimed.
 	 */
-- 
2.47.2



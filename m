Return-Path: <linux-kernel+bounces-864725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAC2BFB694
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7521F34F132
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3C32FD7CD;
	Wed, 22 Oct 2025 10:30:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E24322C70
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761129033; cv=none; b=pfymNo2X2ZEylcx8IuDDtyLw7z0XWsV8U74k6X3/VxAPCc5A5KEWoLJpyI4LjBeKuolDvrI31DtnSHwCkE/2WIQEWqBhRY3KPivdpE7g61nLhV5CY91PUUM+ajrcisEd9LE4ko5+ah9apb9gaKidFV3GXWwySAvMS1XlG8xWNRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761129033; c=relaxed/simple;
	bh=aD6XyuR7K01qcJEkjdhYbtcXdjBYvp/UzfIpOZaS7jY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QGOCMux22MeXWiRUuXlvPjiPEKzA4V7Zw0FUPUiL2Z3TyDjgW8DH0L2nqyodKfILeTcLD40cwHJpUk7+bv4TTtZxDI88HIcNsZjszClXl85MQ4jNalPas8XVwEYMdgNoldgfj0N/TqVKMWXPe1zwoF4UhYfhc+J8baP6+IO7NEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A11A1063;
	Wed, 22 Oct 2025 03:30:21 -0700 (PDT)
Received: from e120398-lin.trondheim.arm.com (e120398-lin.trondheim.arm.com [10.40.16.110])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73E363F63F;
	Wed, 22 Oct 2025 03:30:26 -0700 (PDT)
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
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/panthor: Fix UAF race between device unplug and FW event processing
Date: Wed, 22 Oct 2025 12:30:13 +0200
Message-ID: <20251022103014.1082629-1-ketil.johnsen@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function panthor_fw_unplug() will free the FW memory sections.
The problem is that there could still be pending FW events which are yet
not handled at this point. process_fw_events_work() can in this case try
to access said freed memory.

This fix introduces a destroyed state for the panthor_scheduler object,
and we check for this before processing FW events.

Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
Fixes: de85488138247 ("drm/panthor: Add the scheduler logical block")
---
v2:
- Followed Boris's advice and handle the race purely within the
  scheduler block (by adding a destroyed state)
---
 drivers/gpu/drm/panthor/panthor_sched.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 0cc9055f4ee52..4996f987b8183 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -315,6 +315,13 @@ struct panthor_scheduler {
 		 */
 		struct list_head stopped_groups;
 	} reset;
+
+	/**
+	 * @destroyed: Scheduler object is (being) destroyed
+	 *
+	 * Normal scheduler operations should no longer take place.
+	 */
+	bool destroyed;
 };
 
 /**
@@ -1765,7 +1772,10 @@ static void process_fw_events_work(struct work_struct *work)
 	u32 events = atomic_xchg(&sched->fw_events, 0);
 	struct panthor_device *ptdev = sched->ptdev;
 
-	mutex_lock(&sched->lock);
+	guard(mutex)(&sched->lock);
+
+	if (sched->destroyed)
+		return;
 
 	if (events & JOB_INT_GLOBAL_IF) {
 		sched_process_global_irq_locked(ptdev);
@@ -1778,8 +1788,6 @@ static void process_fw_events_work(struct work_struct *work)
 		sched_process_csg_irq_locked(ptdev, csg_id);
 		events &= ~BIT(csg_id);
 	}
-
-	mutex_unlock(&sched->lock);
 }
 
 /**
@@ -3882,6 +3890,7 @@ void panthor_sched_unplug(struct panthor_device *ptdev)
 	cancel_delayed_work_sync(&sched->tick_work);
 
 	mutex_lock(&sched->lock);
+	sched->destroyed = true;
 	if (sched->pm.has_ref) {
 		pm_runtime_put(ptdev->base.dev);
 		sched->pm.has_ref = false;
-- 
2.47.2



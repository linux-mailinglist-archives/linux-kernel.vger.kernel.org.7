Return-Path: <linux-kernel+bounces-875847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C5CC19F20
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27D61C208E3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7D132C320;
	Wed, 29 Oct 2025 11:14:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E6E21B192
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736467; cv=none; b=ZGYmZ0Hlc0EjXpM7GOlVHQFG9YWCSAm3a3Xe/+TOewLmf2atTeMaBPwTuItLbvcSHcNcEKpcYfFReZKuAyOGCBSpRknxi/iAcGPyVGplRHH7B274c4APooIbUEMKS5QHe6XRsjI/gVMPFYBzwZ6vrvss8w/JqUs6vDXBf5BmGnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736467; c=relaxed/simple;
	bh=vRoXGz+VRKT5LTr5J4wU+aCmZ6BEFvX+kiigiwxOU5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TV0G9w5dKdC5OE5/e3P7MPmxSbYB3sERzW0DrHIg+fra5UMtZ3lmhP8xtmBhppmFLzmhHvexWMRDr3Q3JvndoWE0Zgabec8Q1m+rarOOWxWWWcPXOHOQZU1tUDSXZ7rCscg5WrJP0+igUcBqCkvfAQwQskvbbD+414FYOIhynmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8CE01655;
	Wed, 29 Oct 2025 04:14:15 -0700 (PDT)
Received: from e120398-lin.trondheim.arm.com (e120398-lin.trondheim.arm.com [10.40.16.110])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E4323F673;
	Wed, 29 Oct 2025 04:14:21 -0700 (PDT)
From: Ketil Johnsen <ketil.johnsen@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Ketil Johnsen <ketil.johnsen@arm.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panthor: disable async work during unplug
Date: Wed, 29 Oct 2025 12:14:10 +0100
Message-ID: <20251029111412.924104-1-ketil.johnsen@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A previous change, "drm/panthor: Fix UAF race between device unplug and
FW event processing", fixes a real issue where new work was unexpectedly
queued after cancellation. This was fixed by a disable instead.

Apply the same disable logic to other device level async work on device
unplug as a precaution.

Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 2 +-
 drivers/gpu/drm/panthor/panthor_fw.c     | 2 +-
 drivers/gpu/drm/panthor/panthor_sched.c  | 5 ++---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 962a10e00848e..c4ae78545ef03 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -120,7 +120,7 @@ static void panthor_device_reset_cleanup(struct drm_device *ddev, void *data)
 {
 	struct panthor_device *ptdev = container_of(ddev, struct panthor_device, base);
 
-	cancel_work_sync(&ptdev->reset.work);
+	disable_work_sync(&ptdev->reset.work);
 	destroy_workqueue(ptdev->reset.wq);
 }
 
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 9bf06e55eaeea..ceb249da8b336 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1162,7 +1162,7 @@ void panthor_fw_unplug(struct panthor_device *ptdev)
 {
 	struct panthor_fw_section *section;
 
-	cancel_delayed_work_sync(&ptdev->fw->watchdog.ping_work);
+	disable_delayed_work_sync(&ptdev->fw->watchdog.ping_work);
 
 	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev)) {
 		/* Make sure the IRQ handler cannot be called after that point. */
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index b7595beaa0205..278434da8926d 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3879,8 +3879,9 @@ void panthor_sched_unplug(struct panthor_device *ptdev)
 {
 	struct panthor_scheduler *sched = ptdev->scheduler;
 
-	cancel_delayed_work_sync(&sched->tick_work);
+	disable_delayed_work_sync(&sched->tick_work);
 	disable_work_sync(&sched->fw_events_work);
+	disable_work_sync(&sched->sync_upd_work);
 
 	mutex_lock(&sched->lock);
 	if (sched->pm.has_ref) {
@@ -3898,8 +3899,6 @@ static void panthor_sched_fini(struct drm_device *ddev, void *res)
 	if (!sched || !sched->csg_slot_count)
 		return;
 
-	cancel_delayed_work_sync(&sched->tick_work);
-
 	if (sched->wq)
 		destroy_workqueue(sched->wq);
 
-- 
2.47.2



Return-Path: <linux-kernel+bounces-845329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF10FBC474E
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB8D84E5AE9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133BC2F6168;
	Wed,  8 Oct 2025 10:54:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26356208CA
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759920849; cv=none; b=bsjn8J2KjX2ixzMxYXd9QFDRA0J3ziuSc1mkiHAukrVym7lI8Bq17dozpoDhz8pwu4Eb5nbPY9HezSClBGArxj8woTeBw5F0HC0vdISRamUYbmfrEumz6WkIu9CKgwuezxE5Au2XfLVdPeP5WU0ZkWoNSA+ssEftpm2K4K/YW3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759920849; c=relaxed/simple;
	bh=DjhfrL7ZSC0i5vvnh+IQN5w26CvkCgKwVdb/OHIUqYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SisplQ0LXcaO0ZtPVthh2pU89uDZH2g5YdJoO1RI1NMnVObpD6ArFLSHZUNfvaYBMjL22hQsbnzpnDqWeu+CjFy9+QDTcgwn+ceOqcDZC0avB48B5Ee2muK52EVAUSdKgDw+lx3vfAvt3B9FQo2tUFH0Ezt2teGuFFThaaivUP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CF2622FC;
	Wed,  8 Oct 2025 03:53:59 -0700 (PDT)
Received: from e120398-lin.trondheim.arm.com (e120398-lin.trondheim.arm.com [10.40.16.110])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D3793F59E;
	Wed,  8 Oct 2025 03:54:04 -0700 (PDT)
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
Subject: [PATCH] drm/panthor: Fix UAF race between device unplug and FW event processing
Date: Wed,  8 Oct 2025 12:53:20 +0200
Message-ID: <20251008105322.4077661-1-ketil.johnsen@arm.com>
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

The fix is to stop FW event processing after IRQs are disabled but before
the FW memory is freed.

Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c    |  3 +++
 drivers/gpu/drm/panthor/panthor_sched.c | 12 ++++++++++++
 drivers/gpu/drm/panthor/panthor_sched.h |  1 +
 3 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 9bf06e55eaee..4f393c5cd26f 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1172,6 +1172,9 @@ void panthor_fw_unplug(struct panthor_device *ptdev)
 		panthor_fw_stop(ptdev);
 	}
 
+	/* Any pending FW event processing must stop before we free FW memory */
+	panthor_sched_stop_fw_events(ptdev);
+
 	list_for_each_entry(section, &ptdev->fw->sections, node)
 		panthor_kernel_bo_destroy(section->mem);
 
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 0cc9055f4ee5..d150c8d99432 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -1794,6 +1794,18 @@ void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events)
 	sched_queue_work(ptdev->scheduler, fw_events);
 }
 
+/**
+ * panthor_sched_stop_fw_events() - Stop processing FW events.
+ */
+void panthor_sched_stop_fw_events(struct panthor_device *ptdev)
+{
+	if (!ptdev->scheduler)
+		return;
+
+	atomic_set(&ptdev->scheduler->fw_events, 0);
+	cancel_work_sync(&ptdev->scheduler->fw_events_work);
+}
+
 static const char *fence_get_driver_name(struct dma_fence *fence)
 {
 	return "panthor";
diff --git a/drivers/gpu/drm/panthor/panthor_sched.h b/drivers/gpu/drm/panthor/panthor_sched.h
index f4a475aa34c0..4393599ed330 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.h
+++ b/drivers/gpu/drm/panthor/panthor_sched.h
@@ -51,6 +51,7 @@ void panthor_sched_resume(struct panthor_device *ptdev);
 
 void panthor_sched_report_mmu_fault(struct panthor_device *ptdev);
 void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events);
+void panthor_sched_stop_fw_events(struct panthor_device *ptdev);
 
 void panthor_fdinfo_gather_group_samples(struct panthor_file *pfile);
 
-- 
2.43.0



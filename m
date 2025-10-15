Return-Path: <linux-kernel+bounces-853516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67270BDBE16
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 02:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06E454EF907
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9241DC994;
	Wed, 15 Oct 2025 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="NXsN6Mjh"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB38B1B0439
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760487060; cv=pass; b=KnyQf0jzSPdvXJvGS2wHX32e6MrWHoVlOm2dGuEjRRuuY5iZGlr4aL7Y+xBdkgMo0vqfkskeWwsNgV+HZF2Gs6zZ4N1EzfL7cl5FgK/Z/bEEPGridBSYhws3DXZ8kLL7t4HipElW8jSLWHjnN7tid4DD7Z80UQjCg/XFpIKBpLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760487060; c=relaxed/simple;
	bh=uGW5J4Trku58q1Fd3sbLc1adx+P1UW8kSOxIl7NZj8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UleMB6GimeIw5kX1DUH7JYK/pFHOfvOJpBGMUKi7XAoc6JB8iXPsjAJTvP4lxZ/v0Qv1TsA44rM/6U4a31E62d5qGRVTsy66GLOch2EECqZaJXZPgDUxgp00lGYVuwC47ySjR9qhYGs2+TMLbDg3P2yqN4PeOBt4QVTX2Vyo0Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=NXsN6Mjh; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760487041; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=n+/7LNiBcp6WPMVoHOFHfNEKbLylncLZLd4dxIQdezB4ZsuRQqOnXMXQY3Mh96dnVXV4aZKkpO/sqk/scXQq2aLOXKUF76NAbIX01/8Rl4swkB+6x3hCoM+1kq2aJxspkf06GX//vb6JxbHAd6HcyhKTNJp6BxBVmGl+FxisPDM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760487041; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NvlUmEj9PDrocHhWP4M43AeiLB0qXVThncf7ebSPeG8=; 
	b=jVj1qbaNHexO6H4WwTNvubVwv2AM5Gz2ik45BCUqIhJ8t5G2RCF2+f5d1d4R9sm3Uh89zeB/CAgrvKIGSMMJJqP0Aii9MbB2Zrp8GZL3Vyb7bGV4uEGs/PKRlASnaKSf3oHLvwKixtdx/2G+ePhGfQZBy17ZzwXR51x7iaEHSh4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760487041;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NvlUmEj9PDrocHhWP4M43AeiLB0qXVThncf7ebSPeG8=;
	b=NXsN6MjhBSI/evqQxyqcQmHeAqvemba/xFf/7q3YwbyQvwir3gypGMJMw1ZTxNt1
	GDHbiBQe6sr3+P6IKU61y8nX9IFOlQ8O/mN57ySb1q5q+pHUOWJwjF2Uw8yNqSEzqB7
	3IO9C7JIAUe0klTe36SH8W3h1om8Wgtf8wrVv9bE=
Received: by mx.zohomail.com with SMTPS id 1760487039159738.4528465490444;
	Tue, 14 Oct 2025 17:10:39 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v6 08/12] drm/panfrost: Make re-enabling job interrupts at device reset optional
Date: Wed, 15 Oct 2025 01:09:14 +0100
Message-ID: <20251015000930.356073-9-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015000930.356073-1-adrian.larumbe@collabora.com>
References: <20251015000930.356073-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rather than remasking interrupts after a device reset in the main reset
path, allow selecting whether to do this with an additional bool parameter.

To this end, split reenabling job interrupts into two functions, one that
clears the interrupts and another one which unmasks them conditionally.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c |  9 ++++++---
 drivers/gpu/drm/panfrost/panfrost_device.h |  2 +-
 drivers/gpu/drm/panfrost/panfrost_job.c    | 17 ++++++++---------
 drivers/gpu/drm/panfrost/panfrost_job.h    |  1 +
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 733b728ec75f..f1d811a6de6c 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -400,13 +400,16 @@ bool panfrost_exception_needs_reset(const struct panfrost_device *pfdev,
 	return false;
 }
 
-void panfrost_device_reset(struct panfrost_device *pfdev)
+void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
 {
 	panfrost_gpu_soft_reset(pfdev);
 
 	panfrost_gpu_power_on(pfdev);
 	panfrost_mmu_reset(pfdev);
-	panfrost_job_enable_interrupts(pfdev);
+
+	panfrost_job_reset_interrupts(pfdev);
+	if (enable_job_int)
+		panfrost_job_enable_interrupts(pfdev);
 }
 
 static int panfrost_device_runtime_resume(struct device *dev)
@@ -430,7 +433,7 @@ static int panfrost_device_runtime_resume(struct device *dev)
 		}
 	}
 
-	panfrost_device_reset(pfdev);
+	panfrost_device_reset(pfdev, true);
 	panfrost_devfreq_resume(pfdev);
 
 	return 0;
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index ac7147ed806b..45d77cda8b89 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -250,7 +250,7 @@ int panfrost_unstable_ioctl_check(void);
 
 int panfrost_device_init(struct panfrost_device *pfdev);
 void panfrost_device_fini(struct panfrost_device *pfdev);
-void panfrost_device_reset(struct panfrost_device *pfdev);
+void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int);
 
 extern const struct dev_pm_ops panfrost_pm_ops;
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index dc4228af78f9..39e919420aaf 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -430,11 +430,14 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
 	return fence;
 }
 
+void panfrost_job_reset_interrupts(struct panfrost_device *pfdev)
+{
+	job_write(pfdev, JOB_INT_CLEAR, ALL_JS_INT_MASK);
+}
+
 void panfrost_job_enable_interrupts(struct panfrost_device *pfdev)
 {
 	clear_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended);
-
-	job_write(pfdev, JOB_INT_CLEAR, ALL_JS_INT_MASK);
 	job_write(pfdev, JOB_INT_MASK, ALL_JS_INT_MASK);
 }
 
@@ -727,12 +730,7 @@ panfrost_reset(struct panfrost_device *pfdev,
 	spin_unlock(&pfdev->js->job_lock);
 
 	/* Proceed with reset now. */
-	panfrost_device_reset(pfdev);
-
-	/* panfrost_device_reset() unmasks job interrupts, but we want to
-	 * keep them masked a bit longer.
-	 */
-	job_write(pfdev, JOB_INT_MASK, 0);
+	panfrost_device_reset(pfdev, false);
 
 	/* GPU has been reset, we can clear the reset pending bit. */
 	atomic_set(&pfdev->reset.pending, 0);
@@ -754,7 +752,7 @@ panfrost_reset(struct panfrost_device *pfdev,
 		drm_sched_start(&pfdev->js->queue[i].sched, 0);
 
 	/* Re-enable job interrupts now that everything has been restarted. */
-	job_write(pfdev, JOB_INT_MASK, ALL_JS_INT_MASK);
+	panfrost_job_enable_interrupts(pfdev);
 
 	dma_fence_end_signalling(cookie);
 }
@@ -907,6 +905,7 @@ int panfrost_job_init(struct panfrost_device *pfdev)
 		}
 	}
 
+	panfrost_job_reset_interrupts(pfdev);
 	panfrost_job_enable_interrupts(pfdev);
 
 	return 0;
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.h b/drivers/gpu/drm/panfrost/panfrost_job.h
index 458666bf684b..f6d9960740ae 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.h
+++ b/drivers/gpu/drm/panfrost/panfrost_job.h
@@ -69,6 +69,7 @@ void panfrost_job_close(struct drm_file *file);
 int panfrost_job_get_slot(struct panfrost_job *job);
 int panfrost_job_push(struct panfrost_job *job);
 void panfrost_job_put(struct panfrost_job *job);
+void panfrost_job_reset_interrupts(struct panfrost_device *pfdev);
 void panfrost_job_enable_interrupts(struct panfrost_device *pfdev);
 void panfrost_job_suspend_irq(struct panfrost_device *pfdev);
 int panfrost_job_is_idle(struct panfrost_device *pfdev);
-- 
2.51.0



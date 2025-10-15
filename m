Return-Path: <linux-kernel+bounces-853510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E2ABDBDFB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 02:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32CE519A2504
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D3B3BB5A;
	Wed, 15 Oct 2025 00:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="DDAjlZLW"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915DD81ACA
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760487040; cv=pass; b=STC5RQdDlUWfaIPLUNMDApkxydpNDltL5geMgnVc36u7JFiNcDl0AwV+uoMnU5ENFrBR1VUECtz90/589hxHidL2ZAqjZGTe9iEforM06V5qv1xEh6gKsAHjCc1OkD5MEW5qlGS4y8YVsrHazV+mR22DgOFiLv+WXSXCuBQIeMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760487040; c=relaxed/simple;
	bh=CDUWg4RMhLPB/eMMYYKM274m/xkXTWb7rHVUCUus9Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XX4P1NOARtEiqPASeU2bXzP56xmHTQ5BX6szYpXWqTBQOGft2N1ariMCgBD/bn+4OBA1uAkn/UH7fn6N1F5DlB1WShQeglu536IkVdnLRuYFbemvWqJvI/Itk/j9LCQc80mOgQHpxjH/9grXuAoB/5jY1tYDsfNSuPD/+Xf5A5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=DDAjlZLW; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760487023; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=M56dqULHHgkAGT0GksMUBTKwIPQ5ij54/e/X2AWo6u++W8LatC4rI8Z8jSSfQz4ahaq2A+8wA+aHFM5XZzX4WAs1tpQzAkSgBMpnrdIoAh3e7h2kzWMiSUOwmhgdtxfkhr1nswowonDa3JkTLxKm3ludtFxac4tfSm4nHufc4vU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760487023; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=v1IpcpKR3g0F9ydq0m+FZmd92uhepeBS1D5E7R899Oo=; 
	b=GkvTw94H+33fdUjiyEPsTWWzKWmFTVWvX0UIor2+qvz2cCCyk3HmdCykyaLI45+AuW4dUS6oaa3itmB7qKjkSzZKT1yfnqE+opynBc0mbemrxv66JvXKzce3d3fc+ElVuiRy8Gku/U+3J87SXe+l6KdozhlxG1oO9hLAl+mkJsM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760487023;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=v1IpcpKR3g0F9ydq0m+FZmd92uhepeBS1D5E7R899Oo=;
	b=DDAjlZLW5nvjs51OsFTFnkoC8n+c6WILtAa43qR/RaCWD5NpwJdb4560XI5tpjmK
	Owqvgi63vz+Gc8NcGqSQKwUI4Q2fwjEtnGmGznSIubPjWHWukAroUD1fbjEpXMmcS7o
	JMwfbXTuxtlHoq12TUfmPtBwTQtFC9f/jR9qN6PU=
Received: by mx.zohomail.com with SMTPS id 1760487021927185.1040602868145;
	Tue, 14 Oct 2025 17:10:21 -0700 (PDT)
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
Subject: [PATCH v6 03/12] drm/panfrost: Handle job HW submit errors
Date: Wed, 15 Oct 2025 01:09:09 +0100
Message-ID: <20251015000930.356073-4-adrian.larumbe@collabora.com>
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

Avoid waiting for the DRM scheduler job timedout handler, and instead, let
the DRM scheduler core signal the error fence immediately when HW job
submission fails.

That means we must also decrement the runtime-PM refcnt for the device,
because the job will never be enqueued or inflight.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 01fcba4e0d57..0722f297d142 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -200,7 +200,7 @@ panfrost_enqueue_job(struct panfrost_device *pfdev, int slot,
 	return 1;
 }
 
-static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
+static int panfrost_job_hw_submit(struct panfrost_job *job, int js)
 {
 	struct panfrost_device *pfdev = job->pfdev;
 	unsigned int subslot;
@@ -208,18 +208,19 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
 	u64 jc_head = job->jc;
 	int ret;
 
-	panfrost_devfreq_record_busy(&pfdev->pfdevfreq);
-
 	ret = pm_runtime_get_sync(pfdev->base.dev);
 	if (ret < 0)
-		return;
+		goto err_hwsubmit;
 
 	if (WARN_ON(job_read(pfdev, JS_COMMAND_NEXT(js)))) {
-		return;
+		ret = -EINVAL;
+		goto err_hwsubmit;
 	}
 
 	cfg = panfrost_mmu_as_get(pfdev, job->mmu);
 
+	panfrost_devfreq_record_busy(&pfdev->pfdevfreq);
+
 	job_write(pfdev, JS_HEAD_NEXT_LO(js), lower_32_bits(jc_head));
 	job_write(pfdev, JS_HEAD_NEXT_HI(js), upper_32_bits(jc_head));
 
@@ -266,6 +267,12 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
 			job, js, subslot, jc_head, cfg & 0xf);
 	}
 	spin_unlock(&pfdev->js->job_lock);
+
+	return 0;
+
+err_hwsubmit:
+	pm_runtime_put_autosuspend(pfdev->base.dev);
+	return ret;
 }
 
 static int panfrost_acquire_object_fences(struct drm_gem_object **bos,
@@ -388,6 +395,7 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
 	struct panfrost_device *pfdev = job->pfdev;
 	int slot = panfrost_job_get_slot(job);
 	struct dma_fence *fence = NULL;
+	int ret;
 
 	if (job->ctx->destroyed)
 		return ERR_PTR(-ECANCELED);
@@ -409,7 +417,11 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
 		dma_fence_put(job->done_fence);
 	job->done_fence = dma_fence_get(fence);
 
-	panfrost_job_hw_submit(job, slot);
+	ret = panfrost_job_hw_submit(job, slot);
+	if (ret) {
+		dma_fence_put(fence);
+		return ERR_PTR(ret);
+	}
 
 	return fence;
 }
-- 
2.51.0



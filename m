Return-Path: <linux-kernel+bounces-844408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09541BC1D87
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1383E11DE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BB92E2DDC;
	Tue,  7 Oct 2025 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="R+P3ENCU"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAAD19E7F8
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759849389; cv=pass; b=Xz6D7w93L1qrFKUcxbxpwUDsueIjFn+Ut+zYr37yEeoYklbKvLM3sqHVHOXX2fvanWR6ITH8PF6eUILLPtk+dG6cY2Iv+blGyHQwF5ab6TrOEqwbRlT7MYEVHC67SDBbJLg8R+HfEpp6DiIwrsUDY/PlnPvODfcy7ONbjM7J870=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759849389; c=relaxed/simple;
	bh=Q2JyqzuUUVJuVav/1DPTyVjMjSRAt96rkvOjBOMlxxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYWZhp2tCFPexrbnP01gmpKDpHcIezPdz+CY7pRSkOZuqocyVt40uXVR2UTEu/Rh3D/mIID0XXUWzOp/LPqSZOLy69T/7V061l8KZ4Pv65db69VkgkdnVwBYz8PidikGxYRA7xN5rWDTvTJKf/1/LBXtqMEsdAPMn0Xs0eIj5nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=R+P3ENCU; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759849370; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LmZH+dYpXU98Heu+EknHxSo9ofLp+ajdl1o9CTRYnhiIn0EEKtPBw1IX/cioq9B0ez1j7fIvhSnNqpwVG/6TxfAdwFfKDvEfdbcg9++4x1yduqA0zHUcCOrrPEeQjr/n57k/YxKc16VtJzVsj43fFm3V76mo9jatUuT5BjP4HJI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759849370; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yNLqPyTiIlF6Zhy2wQlpa8VaHQnH4QkqTFpBcauDt+M=; 
	b=mlnB61NwkonuAdegag3B0JGbR+KM4GyxVeboO0VkKpC4MkxjRo0LFDawndu2ywZwEB9YDC1nSaTjiRcMNPPma42XnKJoQKggsT1E2eVbwdgrK4qx5G1fkvDz+2T/nah5YJxg1O3QUGwM2YALIVN+3CsOWDvsmIUPcBFs+fYmlOE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759849370;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=yNLqPyTiIlF6Zhy2wQlpa8VaHQnH4QkqTFpBcauDt+M=;
	b=R+P3ENCUCdiZE62r/RoHuoS7TKkf1pp6W5IxOqIpPXuusKWiHNXHRGqO0U0yJEAf
	7xr3neTQ+mSZLDic780wokcnxD2gatsSX+0gQDT23ppIWRwix0/e3VMwntapvldLd5K
	UYffXobHx8FaeXivRQJZud4aFDRciGNbncb7x8DE=
Received: by mx.zohomail.com with SMTPS id 1759849368265828.0588811465709;
	Tue, 7 Oct 2025 08:02:48 -0700 (PDT)
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
Subject: [PATCH v5 03/12] drm/panfrost: Handle job HW submit errors
Date: Tue,  7 Oct 2025 16:01:45 +0100
Message-ID: <20251007150216.254250-4-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007150216.254250-1-adrian.larumbe@collabora.com>
References: <20251007150216.254250-1-adrian.larumbe@collabora.com>
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

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index a0123d0a1b7d..ea3f2878fd15 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -196,7 +196,7 @@ panfrost_enqueue_job(struct panfrost_device *pfdev, int slot,
 	return 1;
 }
 
-static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
+static int panfrost_job_hw_submit(struct panfrost_job *job, int js)
 {
 	struct panfrost_device *pfdev = job->pfdev;
 	unsigned int subslot;
@@ -204,18 +204,19 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
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
 
@@ -262,6 +263,12 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
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
@@ -384,6 +391,7 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
 	struct panfrost_device *pfdev = job->pfdev;
 	int slot = panfrost_job_get_slot(job);
 	struct dma_fence *fence = NULL;
+	int ret;
 
 	if (job->ctx->destroyed)
 		return ERR_PTR(-ECANCELED);
@@ -405,7 +413,11 @@ static struct dma_fence *panfrost_job_run(struct drm_sched_job *sched_job)
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



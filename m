Return-Path: <linux-kernel+bounces-844410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EC2BC1D93
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B7719A49AE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CB42E3B10;
	Tue,  7 Oct 2025 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Cs1IE0sH"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069F370808
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759849394; cv=pass; b=HTbgz3bv472gLCyUJ2IX8TCGC3kGChC7i4tt6yO85U566vgwLgTQZX5gwWGp7HrqZ/t72YQglyWALtBP0IKxs9IHq64j1dloMNj42VdYsDxi87iOaviaqWAF05cjccTHR0DmXidBdCwcheTqKL+2rvcyF5aTIJ3wqMoAILIcNzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759849394; c=relaxed/simple;
	bh=Oyr1e/HZ7fU2y8GN6HzDvUsK4jKhYqouACgymN7hNYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WBFe+LpGtMId/xdRUChaFznBKnWOmXK5S5IvRfsr+CKCk5779fuQFVmpFM2CUE2SmJNadDnwv2FTctV2I2zEZTA4GezY7QdL2CK2gMw1cQ6qO2oEoCdetBwHNtFvsgylMAHWrLyFixo31iVs7KTAZxHabgzCj9o+5OKIfJRX/Ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=Cs1IE0sH; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759849372; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FI9AXdmxbe1mcEgX6Yk/rVx3kuCTDKRI6a69WKF6MVJk8VTb5wgwPOpYIduWq0xj7VsQNTkLAKtVSPTI6e7wvHBGu1kpyrGqqhB0+yF1ySdX1LP1LiedIfyrmaqgWQxuaeiX8ggBk+W+n+ktgxE9aJ3PhjMznVNa0wosuYi7NlU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759849372; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mAFxYhUsOhKLUvfxrFb1kbakoj2z/l+mKVg6lYFhsdg=; 
	b=WzHeFICgDBpgIpt3knhudwAL6chbNE7MbUI8Z0kpqivoO2Bjxcw0d6ZjrfSxN4VHhbwNU6QIoG2xTT/g3nn6j8eXNRIUqvRwasxfo04Tizmb85+BPqWgfN1iZQSwaeOLhrheSiwOS00ew+mXKgOERuRtYxwYV+itTFNZjVK0vEM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759849372;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=mAFxYhUsOhKLUvfxrFb1kbakoj2z/l+mKVg6lYFhsdg=;
	b=Cs1IE0sHlsIaAg/y0SPXnZfCFJBYe6klCIl4ZKvLnS5PxyxVnX/Bw4UF/Ta5AjPH
	zLT3sAh8Of+Ve8wujz2JzASKb7IWfYonA316JyK6Bs90rp80KTLFzgxrH9fd3rlHTv5
	PH8kGzwZxzMsOh/oTmErpgDp5XoSv2wAZ5cIbeAI=
Received: by mx.zohomail.com with SMTPS id 1759849371389871.748175971017;
	Tue, 7 Oct 2025 08:02:51 -0700 (PDT)
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
Subject: [PATCH v5 04/12] drm/panfrost: Handle error when allocating AS number
Date: Tue,  7 Oct 2025 16:01:46 +0100
Message-ID: <20251007150216.254250-5-adrian.larumbe@collabora.com>
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

If we reach the beginning of the LRU AS list, then return an error.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c     | 6 +++++-
 drivers/gpu/drm/panfrost/panfrost_mmu.c     | 5 +++--
 drivers/gpu/drm/panfrost/panfrost_mmu.h     | 2 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 9 ++++++++-
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index ea3f2878fd15..1b3af5d52081 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -213,7 +213,11 @@ static int panfrost_job_hw_submit(struct panfrost_job *job, int js)
 		goto err_hwsubmit;
 	}
 
-	cfg = panfrost_mmu_as_get(pfdev, job->mmu);
+	ret = panfrost_mmu_as_get(pfdev, job->mmu);
+	if (ret < 0)
+		goto err_hwsubmit;
+
+	cfg = ret;
 
 	panfrost_devfreq_record_busy(&pfdev->pfdevfreq);
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 1d696eeea2fa..cf272b167feb 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -258,7 +258,7 @@ static int panfrost_mmu_cfg_init(struct panfrost_mmu *mmu,
 	}
 }
 
-u32 panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)
+int panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)
 {
 	int as;
 
@@ -300,7 +300,8 @@ u32 panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)
 			if (!atomic_read(&lru_mmu->as_count))
 				break;
 		}
-		WARN_ON(&lru_mmu->list == &pfdev->as_lru_list);
+		if (WARN_ON(&lru_mmu->list == &pfdev->as_lru_list))
+			return -EBUSY;
 
 		list_del_init(&lru_mmu->list);
 		as = lru_mmu->as;
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.h b/drivers/gpu/drm/panfrost/panfrost_mmu.h
index 022a9a74a114..e6e6966a0cca 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.h
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.h
@@ -16,7 +16,7 @@ void panfrost_mmu_fini(struct panfrost_device *pfdev);
 void panfrost_mmu_reset(struct panfrost_device *pfdev);
 void panfrost_mmu_suspend_irq(struct panfrost_device *pfdev);
 
-u32 panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu);
+int panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu);
 void panfrost_mmu_as_put(struct panfrost_device *pfdev, struct panfrost_mmu *mmu);
 
 struct panfrost_mmu *panfrost_mmu_ctx_get(struct panfrost_mmu *mmu);
diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
index 718eb44b40f8..a8d821e1bde2 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
@@ -132,7 +132,12 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
 
 	perfcnt->user = user;
 
-	as = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
+	ret = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
+	if (ret < 0)
+		goto err_unsetuser;
+
+	as = ret;
+
 	cfg = GPU_PERFCNT_CFG_AS(as) |
 	      GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_MANUAL);
 
@@ -166,6 +171,8 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
 
 	return 0;
 
+err_unsetuser:
+	perfcnt->user = NULL;
 err_vunmap:
 	drm_gem_vunmap(&bo->base, &map);
 err_put_mapping:
-- 
2.51.0



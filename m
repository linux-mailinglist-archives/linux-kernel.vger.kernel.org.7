Return-Path: <linux-kernel+bounces-844418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B663BC1DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5723E1480
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03102E6CC1;
	Tue,  7 Oct 2025 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="VEar9x57"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDFD2E2DFA
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759849415; cv=pass; b=hJw0g7sXnEb6GNCzlbSGVHpzUoKY9scLpiCrFmQn52h2baFlxw1usLpGO3nh2ubmlbS2fxzlrDYBx8gTOUBk3lVEbIbWZOBNBkwNUm+cQp74GnYdRtNJjyS78fth5YHNOLgmLw5M31P137z9+DPQZvYHUA6zXFYGkiua4nt6ui0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759849415; c=relaxed/simple;
	bh=VQcgzKHrfgFSkKzxVITxcF60nlqVDf9A81hNAKwpPao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLHQ/J9eV3cQKvSO59ozASKHasMIGxB9Ds56e7rPiuqHJCuBmnBroTWs5dE0n165f59CN1xIhrhOb2wpGmPNmYQYwcje+wZXAzDwciL+R95zphi+dsTUBYkCiNqkGGGJVcvTDNDTFAYjtG5WUIvd4eTR9gXnzZKjx2mh1b/mKks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=VEar9x57; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759849394; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hEbIouERM2bLnyAQohqDFhByypVP7DwnK32pZqzwXVegZxELzrZ8MB+1YV6pZoxG3vhUt8UzOdCrTC9WOWPa5swUxf2QNwQImu/GDwSwvB8FhWFP3zJ5A7MwQ2hHPRVgZRGDqIev4F/tHHZMeFZ3rYjvfSFkq25tvQamhy2EsMA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759849394; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/bjV+nl7u3/n9NT5M8RFhOQDeuj2mv8Kb3eLCOpKlQQ=; 
	b=BI9adq28uTuNZALBC/QohfWaYmWc7qr/cAGJNpN9R4SYt7rkIbDbBHOhrbG2LBrz2gdHp56iL/YC383ckr3f9JEGGOWdwmOaLwS8dKILLaf8EYsb2pX1PL0WpT7uXozL0bmtt4L6cDZ3/gExomNv3uF9uHuOqR955BEVGdXgUj8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759849394;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=/bjV+nl7u3/n9NT5M8RFhOQDeuj2mv8Kb3eLCOpKlQQ=;
	b=VEar9x57NUedEyvvUYLCRN4N8wmFhbT4FClaoeKuJlZGkJkIBJEsBcjQbPCsKlcq
	yygyCNcwANlRrSXIyCZL/c62YUzCb41jX0zveP3X+DJzF/fWKCwrlG/KGdWYSpHiDXu
	WutEEhI1QARXlUYweS8W7Mkor6Sx2Qf4IAtf112I=
Received: by mx.zohomail.com with SMTPS id 1759849391971864.1167364591405;
	Tue, 7 Oct 2025 08:03:11 -0700 (PDT)
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
Subject: [PATCH v5 10/12] drm/panfrost: Remove unused device property
Date: Tue,  7 Oct 2025 16:01:52 +0100
Message-ID: <20251007150216.254250-11-adrian.larumbe@collabora.com>
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

The as_in_use_mask device state variable is no longer in use.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.h | 1 -
 drivers/gpu/drm/panfrost/panfrost_mmu.c    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 45d77cda8b89..e61c4329fd07 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -147,7 +147,6 @@ struct panfrost_device {
 	DECLARE_BITMAP(is_suspended, PANFROST_COMP_BIT_MAX);
 
 	spinlock_t as_lock;
-	unsigned long as_in_use_mask;
 	unsigned long as_alloc_mask;
 	unsigned long as_faulty_mask;
 	struct list_head as_lru_list;
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 7bf386d25453..69699b3c756a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -719,7 +719,6 @@ static void panfrost_mmu_release_ctx(struct kref *kref)
 		pm_runtime_put_autosuspend(pfdev->base.dev);
 
 		clear_bit(mmu->as, &pfdev->as_alloc_mask);
-		clear_bit(mmu->as, &pfdev->as_in_use_mask);
 		list_del(&mmu->list);
 	}
 	spin_unlock(&pfdev->as_lock);
-- 
2.51.0



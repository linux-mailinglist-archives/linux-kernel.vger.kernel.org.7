Return-Path: <linux-kernel+bounces-859752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F1FBEE7C5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 16:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC4054EB9CB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 14:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808552EBBB7;
	Sun, 19 Oct 2025 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="SBzkJsb9"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8132EBDEA
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760885601; cv=pass; b=J2319GoH1vn2YFH7F1gStQ+ohHG4+rr0F3hBlJeEs4T7eprA0Hz6QO9DTrV7r8E0lntoDp6sJUZ8RHEa3Fe+GlMrhA9rX06DpQjbVKj/qMnwk7pnZ2j12CLgmR/fK8Wx0FOJOdrrlSNNqWTEFEh05X2huGPpJfcs0+jgVyd+18c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760885601; c=relaxed/simple;
	bh=umalvuOpxMDhoxQuxqSMfYryHFuJuiu03SH927k0cRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8Tb9Vdoi8QbTliuIARgOUS/5H/YU/rzKYvcQYdFGZOoYg4eT/O2LJX8vozizkM9qW2lLizbguW7BUISJ90tmAvJQGdk0vq8y8x9D+w1GNg6elZlIxaII66NpVZI95JRJQbteQaGIeT5ONIK3Q3n8DpqAlk/J1NP3y+1AE5hywI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=SBzkJsb9; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760885580; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c4wsGzDPodBPUGwFho1hFUiWntunnmPui9qzS67QgDKoC0xBoW+PCA0H2d40xwi7F7v7AyXkDhmI29dmtYnbGlJtSsTLqDjN6Y9tujgXnxBznIa+xqX8RTHyKFqH/o+Vt96VuIDo4YHZ8Y6syj0L1yeXFZHG+4Juttzbm7va3Io=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760885580; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3YromqIs1sZbK7OLU2StQyuL7NbGqysFZCG57y8jh44=; 
	b=lnWEOvkbxOCGC7QQ/fPLQroQMhWu5bXZt/mDHhPe8gV4TAMMOEFFxsc0zPee8HifpjSTWATP/6eIKyiXuU4qQhYzTcpjCyf0h+5W3Cct6Xwk/PEndW+HGvkEOom/78kLT4B8RBnjLBld6Z0uoFesIYaHs7QX1HT2QpQb37rhre4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760885580;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=3YromqIs1sZbK7OLU2StQyuL7NbGqysFZCG57y8jh44=;
	b=SBzkJsb9H/VDzHSUuWiMAop8gvZVmRXutj5799Ai+7bA0rlIBYKFeuB4mzUXsnL1
	MqEdqEEf374t691f/blYzQ898AGndPtemI4Ox/m86SEiH6+1fQcuGoqn8E1ihv8w72j
	Yc0Zz8o1lCBWlaQTDKWIwA8BIswmnvgaO3ZfPdBI=
Received: by mx.zohomail.com with SMTPS id 1760885578454549.4564550026287;
	Sun, 19 Oct 2025 07:52:58 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v7 05/12] drm/panfrost: Check sgt to know whether pages are already mapped
Date: Sun, 19 Oct 2025 15:52:10 +0100
Message-ID: <20251019145225.3621989-6-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019145225.3621989-1-adrian.larumbe@collabora.com>
References: <20251019145225.3621989-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the MMU's page fault ISR for a heap object, determine whether the
faulting address belongs to a 2MiB block that was already mapped by
checking its corresponding sgt in the Panfrost BO.

This is done in preparation for a future commit in which the MMU mapping
helper might fail, but the page array is left populated, so this cannot
be used as a check for an early bail-out.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index fd148d5746c0..17897edaa2b4 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -602,10 +602,12 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 		refcount_set(&bo->base.pages_use_count, 1);
 	} else {
 		pages = bo->base.pages;
-		if (pages[page_offset]) {
-			/* Pages are already mapped, bail out. */
-			goto out;
-		}
+	}
+
+	sgt = &bo->sgts[page_offset / (SZ_2M / PAGE_SIZE)];
+	if (sgt->sgl) {
+		/* Pages are already mapped, bail out. */
+		goto out;
 	}
 
 	mapping = bo->base.base.filp->f_mapping;
@@ -627,7 +629,6 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 		}
 	}
 
-	sgt = &bo->sgts[page_offset / (SZ_2M / PAGE_SIZE)];
 	ret = sg_alloc_table_from_pages(sgt, pages + page_offset,
 					NUM_FAULT_PAGES, 0, SZ_2M, GFP_KERNEL);
 	if (ret)
-- 
2.51.0



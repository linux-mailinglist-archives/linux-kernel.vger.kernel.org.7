Return-Path: <linux-kernel+bounces-862741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAFCBF60E5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 97A84348172
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130F832ED4F;
	Tue, 21 Oct 2025 11:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jkEGlLvJ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625CD32E748;
	Tue, 21 Oct 2025 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046261; cv=none; b=qeQjfMRqbQ+tJCaoVT3qP/rDeZHavhztWpIbR2BTSoUedJAwZZQ8B/KXpUbcyx/SW69NfPgQomA7XliUNugp0dcnI0/2uaIKYfwz6uqbsPXCoW63LX4+B2TleibiXpZEM0LM7M+OYsLP5uDxM8qUKTwybT77y673I/0p27+/7Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046261; c=relaxed/simple;
	bh=KOWDNuw2RyynKmJ4ZsE60XfwYk9U21BJtK/dnqbhV5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FEOH2iBTQM9Cp157W+87xJwepXMuRS7zs2X2PEJ3h9pxf8SSlw7szaOPJzKgDO0cwQrfYq3naTznHQ7GlTAatPoVjhJ0eZPGdgP43lshSpL0HAg4TLMDKhFpZAT5Mi5KdIogtaFuQsc+9GQ3ey2s4BV7T2vU/XCaU0ToGMXf3wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jkEGlLvJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761046257;
	bh=KOWDNuw2RyynKmJ4ZsE60XfwYk9U21BJtK/dnqbhV5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jkEGlLvJpL5ipkJhIbJS1NwsbTwZgBAiguvdFmT0Nrqj06FOVmUzTIWBEcuNmQBk8
	 GEDWAi9ffa5cUQhGgT5n7+VowfmdGSL99UAfy4SCACh7QyOhfvA+q+Sx4VNM6vah1p
	 TZyULGL0sK0Gf8OSBJDt1Z6OSbOo1x5ck3NP+Go821cvK0Cp22bfiYQ1T9QI65iGXT
	 KT90nErM0JkINFpGUfL1KglP4AaAgr1ukN37aLDcsHac/I3VzPt9Bx+cLChW1OjxSa
	 rZRTmqatrZkOTx02CzNmrOSNrtB0O7nhwSis/C/pHb6G6jeTfn993Bl0m+kSqjot2q
	 z5hExxJfWZ56g==
Received: from debian-rockchip-rock5b-rk3588.. (unknown [IPv6:2a01:e0a:5e3:6100:826d:bc07:e98c:84a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: loicmolinari)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BB76A17E1404;
	Tue, 21 Oct 2025 13:30:56 +0200 (CEST)
From: =?UTF-8?q?Lo=C3=AFc=20Molinari?= <loic.molinari@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Melissa Wen <mwen@igalia.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Lo=C3=AFc=20Molinari?= <loic.molinari@collabora.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	=?UTF-8?q?Miko=C5=82aj=20Wasiak?= <mikolaj.wasiak@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Nitin Gote <nitin.r.gote@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Christopher Healy <healych@amazon.com>,
	Matthew Wilcox <willy@infradead.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v5 02/12] drm/shmem-helper: Implement map_pages fault-around handler
Date: Tue, 21 Oct 2025 13:30:39 +0200
Message-ID: <20251021113049.17242-3-loic.molinari@collabora.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251021113049.17242-1-loic.molinari@collabora.com>
References: <20251021113049.17242-1-loic.molinari@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This gives the mm subsystem the ability to increase fault handling
performance by proposing the insertion of a range of pages around the
faulty address in a single batch.

v4:
- implement map_pages instead of huge_fault

v5:
- improve patch series progression
- use dma_resv_trylock() in map_pages (many thanks to Matthew Wilcox)
- validate map_pages range based on end_pgoff instead of start_pgoff

Signed-off-by: Loïc Molinari <loic.molinari@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 72 ++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index be89be1c804c..2a9fbc9c3712 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -567,31 +567,82 @@ int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_dumb_create);
 
-static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
+static bool drm_gem_shmem_fault_is_valid(struct drm_gem_object *obj,
+					 pgoff_t pgoff)
+{
+	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
+
+	if (drm_WARN_ON_ONCE(obj->dev, !shmem->pages) ||
+	    pgoff >= (obj->size >> PAGE_SHIFT) ||
+	    shmem->madv < 0)
+		return false;
+
+	return true;
+}
+
+static vm_fault_t drm_gem_shmem_map_pages(struct vm_fault *vmf,
+					  pgoff_t start_pgoff,
+					  pgoff_t end_pgoff)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct drm_gem_object *obj = vma->vm_private_data;
 	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
-	loff_t num_pages = obj->size >> PAGE_SHIFT;
+	struct page **pages = shmem->pages;
+	unsigned long addr, pfn;
 	vm_fault_t ret;
-	struct page *page;
+
+	start_pgoff -= vma->vm_pgoff;
+	end_pgoff -= vma->vm_pgoff;
+	addr = vma->vm_start + (start_pgoff << PAGE_SHIFT);
+
+	/* map_pages is called with the RCU lock for reading (sleep isn't
+	 * allowed) so just fall through to the more heavy-weight fault path.
+	 */
+	if (unlikely(!dma_resv_trylock(shmem->base.resv)))
+		return 0;
+
+	if (unlikely(!drm_gem_shmem_fault_is_valid(obj, end_pgoff))) {
+		ret = VM_FAULT_SIGBUS;
+		goto out;
+	}
+
+	/* Map a range of pages around the faulty address. */
+	do {
+		pfn = page_to_pfn(pages[start_pgoff]);
+		ret = vmf_insert_pfn(vma, addr, pfn);
+		addr += PAGE_SIZE;
+	} while (++start_pgoff <= end_pgoff && ret == VM_FAULT_NOPAGE);
+
+ out:
+	dma_resv_unlock(shmem->base.resv);
+
+	return ret;
+}
+
+static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct drm_gem_object *obj = vma->vm_private_data;
+	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
+	struct page **pages = shmem->pages;
 	pgoff_t page_offset;
+	unsigned long pfn;
+	vm_fault_t ret;
 
 	/* Offset to faulty address in the VMA (without the fake offset). */
 	page_offset = vmf->pgoff - vma->vm_pgoff;
 
 	dma_resv_lock(shmem->base.resv, NULL);
 
-	if (page_offset >= num_pages ||
-	    drm_WARN_ON_ONCE(obj->dev, !shmem->pages) ||
-	    shmem->madv < 0) {
+	if (unlikely(!drm_gem_shmem_fault_is_valid(obj, page_offset))) {
 		ret = VM_FAULT_SIGBUS;
-	} else {
-		page = shmem->pages[page_offset];
-
-		ret = vmf_insert_pfn(vma, vmf->address, page_to_pfn(page));
+		goto out;
 	}
 
+	pfn = page_to_pfn(pages[page_offset]);
+	ret = vmf_insert_pfn(vma, vmf->address, pfn);
+
+ out:
 	dma_resv_unlock(shmem->base.resv);
 
 	return ret;
@@ -632,6 +683,7 @@ static void drm_gem_shmem_vm_close(struct vm_area_struct *vma)
 }
 
 const struct vm_operations_struct drm_gem_shmem_vm_ops = {
+	.map_pages = drm_gem_shmem_map_pages,
 	.fault = drm_gem_shmem_fault,
 	.open = drm_gem_shmem_vm_open,
 	.close = drm_gem_shmem_vm_close,
-- 
2.47.3



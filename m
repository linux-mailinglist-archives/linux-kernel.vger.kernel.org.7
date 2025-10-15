Return-Path: <linux-kernel+bounces-854781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56509BDF624
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FCD919C7C36
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EAC306B38;
	Wed, 15 Oct 2025 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bbJ9H8kS"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A79B1547D2;
	Wed, 15 Oct 2025 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542237; cv=none; b=uocceaw0zex7hRbOKQpLbRWbScDRItpCcKsjlZrReJNJfQRKEesLHkVHvNKglQcsKODFwBtuxCMGGLBY//4zIURDA34iGtTUn6gwacq4xGZrMI3hTVsb0bwnykiZPjuHphT6hLzpn5yzqzkflrm6f9SxFuJWFxl7DaLiaGRSWSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542237; c=relaxed/simple;
	bh=i4jm8rfdS6G2Q04+yn738KVCd/HzsGzB/QnSS+UslAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jqs5uAcZzjze364u9Kgegi+/3ptYtS+vH5ZIdaestm/aeWifpHZU/OF0EHmxfiSlg62HgS6AK5H6vF8bYOGk6rRtDpCdOtVQ2HqHM1JVtExgenXFhYjNG+IybEQSQy/qc1Mc0tpSGHwJZGrOaiLKi6HKhTbNLD6jrZgzNIz1U7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bbJ9H8kS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760542233;
	bh=i4jm8rfdS6G2Q04+yn738KVCd/HzsGzB/QnSS+UslAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bbJ9H8kSS1f9ZoeWKjtxRJDn57F4aP9klFG+XuHkXvOM8yZFcdQTWI5cb2BEuBEk1
	 gVlMJJSTxWdv7EeLK6TeJ7u5ga9M4xvTanGsth/ibKUIo0KZC3bn7JO+7mQYiswrYR
	 pkac4KqbcFUdapTzUYAgNaWFReRqspgUU8FjvxSyQ5H14ybi4wPK/XEgakwCCCjVM4
	 Kj3PtLfZOyhbkx1CKLrHBeYNCKoCZCdQKzmNbkwp61DBH5Ok3vzetZkd8rGCiKiE0p
	 inqYp/LBPgAunLivVYd7YRz17mgsyxLAww+B6EVZZ/EllLRF1uf5lGlsRpq8/qrnQ6
	 OtowYlUAfOltg==
Received: from debian-rockchip-rock5b-rk3588.. (unknown [IPv6:2a01:e0a:5e3:6100:826d:bc07:e98c:84a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: loicmolinari)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7DF5917E055D;
	Wed, 15 Oct 2025 17:30:32 +0200 (CEST)
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
Subject: [PATCH v4 03/13] drm/shmem-helper: Map huge pages in fault handlers
Date: Wed, 15 Oct 2025 17:30:07 +0200
Message-ID: <20251015153018.43735-4-loic.molinari@collabora.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251015153018.43735-1-loic.molinari@collabora.com>
References: <20251015153018.43735-1-loic.molinari@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Check whether the starting address in the fault-around handler or the
faulty address in the fault handler is part of a huge page in order to
attempt a PMD sized PFN insertion into the VMA.

On builds with CONFIG_TRANSPARENT_HUGEPAGE enabled, if the mmap() user
address is PMD size aligned, if the GEM object is backed by shmem
buffers on mount points setting the 'huge=' option and if the shmem
backing store manages to allocate a huge folio, CPU mapping would then
benefit from significantly increased memcpy() performance. When these
conditions are met on a system with 2 MiB huge pages, an aligned copy
of 2 MiB would raise a single page fault instead of 4096.

v4:
- Implement map_pages instead of huge_fault

Signed-off-by: Loïc Molinari <loic.molinari@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 57 +++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index e151262332f9..5d11bea573fe 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -580,6 +580,26 @@ static bool drm_gem_shmem_fault_is_valid(struct drm_gem_object *obj,
 	return true;
 }
 
+static bool drm_gem_shmem_map_pmd(struct vm_fault *vmf, unsigned long addr,
+				  struct page *page)
+{
+#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
+	unsigned long pfn = page_to_pfn(page);
+	unsigned long paddr = pfn << PAGE_SHIFT;
+	bool aligned = (addr & ~PMD_MASK) == (paddr & ~PMD_MASK);
+
+	if (aligned &&
+	    pmd_none(*vmf->pmd) &&
+	    folio_test_pmd_mappable(page_folio(page))) {
+		pfn &= PMD_MASK >> PAGE_SHIFT;
+		if (vmf_insert_pfn_pmd(vmf, pfn, false) == VM_FAULT_NOPAGE)
+			return true;
+	}
+#endif
+
+	return false;
+}
+
 static vm_fault_t drm_gem_shmem_map_pages(struct vm_fault *vmf,
 					  pgoff_t start_pgoff,
 					  pgoff_t end_pgoff)
@@ -587,6 +607,7 @@ static vm_fault_t drm_gem_shmem_map_pages(struct vm_fault *vmf,
 	struct vm_area_struct *vma = vmf->vma;
 	struct drm_gem_object *obj = vma->vm_private_data;
 	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
+	struct page **pages = shmem->pages;
 	unsigned long addr, pfn;
 	vm_fault_t ret;
 
@@ -598,15 +619,22 @@ static vm_fault_t drm_gem_shmem_map_pages(struct vm_fault *vmf,
 
 	if (unlikely(!drm_gem_shmem_fault_is_valid(obj, start_pgoff))) {
 		ret = VM_FAULT_SIGBUS;
-	} else {
-		/* Map a range of pages around the faulty address. */
-		do {
-			pfn = page_to_pfn(shmem->pages[start_pgoff]);
-			ret = vmf_insert_pfn(vma, addr, pfn);
-			addr += PAGE_SIZE;
-		} while (++start_pgoff <= end_pgoff && ret == VM_FAULT_NOPAGE);
+		goto out;
 	}
 
+	if (drm_gem_shmem_map_pmd(vmf, addr, pages[start_pgoff])) {
+		ret = VM_FAULT_NOPAGE;
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
 	dma_resv_unlock(shmem->base.resv);
 
 	return ret;
@@ -617,8 +645,9 @@ static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	struct drm_gem_object *obj = vma->vm_private_data;
 	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
-	struct page *page;
+	struct page **pages = shmem->pages;
 	pgoff_t page_offset;
+	unsigned long pfn;
 	vm_fault_t ret;
 
 	/* Offset to faulty address in the VMA (without the fake offset). */
@@ -628,12 +657,18 @@ static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
 
 	if (unlikely(!drm_gem_shmem_fault_is_valid(obj, page_offset))) {
 		ret = VM_FAULT_SIGBUS;
-	} else {
-		page = shmem->pages[page_offset];
+		goto out;
+	}
 
-		ret = vmf_insert_pfn(vma, vmf->address, page_to_pfn(page));
+	if (drm_gem_shmem_map_pmd(vmf, vmf->address, pages[page_offset])) {
+		ret = VM_FAULT_NOPAGE;
+		goto out;
 	}
 
+	pfn = page_to_pfn(pages[page_offset]);
+	ret = vmf_insert_pfn(vma, vmf->address, pfn);
+
+ out:
 	dma_resv_unlock(shmem->base.resv);
 
 	return ret;
-- 
2.47.3



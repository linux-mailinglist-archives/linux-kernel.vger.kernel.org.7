Return-Path: <linux-kernel+bounces-854780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A76ABDF61E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF37119C7E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122363054F6;
	Wed, 15 Oct 2025 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eHAmHCJq"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F3A302CC7;
	Wed, 15 Oct 2025 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542235; cv=none; b=FgknN1GZx7gQBuojlnZS5d1ooaB5DUPXRcSQB3t99ntQTb74mfDLe8e7TghxvPSR7at2dPphyff37NaLLvNFnEWS7ojweJ97Gcf9HHvdmgQcCYlttrvIxw9WIomX3t3xvuLyV+mEjRs9RkEW0xcXD+2yjwS1LYGtZe2AAEIcjXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542235; c=relaxed/simple;
	bh=KQV7Ou7tPtnCCwHJMiVJOpNVyDdq8Ql41g0y4SHmXds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fJuJJXQtmLzOyl4k4PHHUS1rfY+tdqjQGxvCjslthVtnbWGvf5tK6Rb5a9OCkdTtFnSzqileuifr7URLY/zc/cYpejAEq47L68+aeW38DeBE4PFKbtuO0YgY/IT+g8kvfZzr8QiMSrYkQluhRLV5m4S9leXxLhZ4IKFaQ4QFn5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eHAmHCJq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760542230;
	bh=KQV7Ou7tPtnCCwHJMiVJOpNVyDdq8Ql41g0y4SHmXds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eHAmHCJq9CHmEpVjvgz1qigTjIVJFFK9ZhUOKlaOXjDfZD2eF49vJtX3YAl+J4qG5
	 dEOcBvyK4cfnxwjrhL2CZslgUJNpEnIhuJY67F8Ok+Kt1pUTHwIsQzThMUEY59EDLx
	 9W7FHK5G5o2bk8opmpCRQU57tGjObB4fdsOpm6EabsOEkP6r0nIrjiJcLnSuD/NmiM
	 hHVcEqg/Wy4+yOf5+6exKsv8odBVsInQoQGmsORy1pXP8E0xwImciHf65R8gewSSXy
	 n3N/G7Phsqm286vuMG05Z/YZT/xKLbzRzl8UaI/cP6lqItS/4OG6gMSgngdmNgYg+q
	 VKp6Xyv4Rq+Jw==
Received: from debian-rockchip-rock5b-rk3588.. (unknown [IPv6:2a01:e0a:5e3:6100:826d:bc07:e98c:84a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: loicmolinari)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E5BF917E00A3;
	Wed, 15 Oct 2025 17:30:29 +0200 (CEST)
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
Subject: [PATCH v4 02/13] drm/shmem-helper: Implement map_pages fault-around handler
Date: Wed, 15 Oct 2025 17:30:06 +0200
Message-ID: <20251015153018.43735-3-loic.molinari@collabora.com>
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

This gives the mm subsystem the ability to increase fault handling
performance by proposing the insertion of a range of pages around the
faulty address in a single batch.

v4:
- Implement map_pages instead of huge_fault

Signed-off-by: Loïc Molinari <loic.molinari@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 53 +++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index be89be1c804c..e151262332f9 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -567,24 +567,66 @@ int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
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
+	unsigned long addr, pfn;
 	vm_fault_t ret;
+
+	start_pgoff -= vma->vm_pgoff;
+	end_pgoff -= vma->vm_pgoff;
+	addr = vma->vm_start + (start_pgoff << PAGE_SHIFT);
+
+	dma_resv_lock(shmem->base.resv, NULL);
+
+	if (unlikely(!drm_gem_shmem_fault_is_valid(obj, start_pgoff))) {
+		ret = VM_FAULT_SIGBUS;
+	} else {
+		/* Map a range of pages around the faulty address. */
+		do {
+			pfn = page_to_pfn(shmem->pages[start_pgoff]);
+			ret = vmf_insert_pfn(vma, addr, pfn);
+			addr += PAGE_SIZE;
+		} while (++start_pgoff <= end_pgoff && ret == VM_FAULT_NOPAGE);
+	}
+
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
 	struct page *page;
 	pgoff_t page_offset;
+	vm_fault_t ret;
 
 	/* Offset to faulty address in the VMA (without the fake offset). */
 	page_offset = vmf->pgoff - vma->vm_pgoff;
 
 	dma_resv_lock(shmem->base.resv, NULL);
 
-	if (page_offset >= num_pages ||
-	    drm_WARN_ON_ONCE(obj->dev, !shmem->pages) ||
-	    shmem->madv < 0) {
+	if (unlikely(!drm_gem_shmem_fault_is_valid(obj, page_offset))) {
 		ret = VM_FAULT_SIGBUS;
 	} else {
 		page = shmem->pages[page_offset];
@@ -632,6 +674,7 @@ static void drm_gem_shmem_vm_close(struct vm_area_struct *vma)
 }
 
 const struct vm_operations_struct drm_gem_shmem_vm_ops = {
+	.map_pages = drm_gem_shmem_map_pages,
 	.fault = drm_gem_shmem_fault,
 	.open = drm_gem_shmem_vm_open,
 	.close = drm_gem_shmem_vm_close,
-- 
2.47.3



Return-Path: <linux-kernel+bounces-841991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAB4BB8BCC
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 11:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7E434E3341
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 09:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3D826E16F;
	Sat,  4 Oct 2025 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BKGLKEfc"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3B5339A8
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759570267; cv=none; b=ZjwkI7QblDq+xUJFR17QV0QOePphJ4iI2EAjOjpS1pcXecncye4UbnlkwxNCbjbV7iR3sNaK7y94qE3N7/9KZx1CS5jtgARJ3wW5KgXDo9fDnkw8UvtQyaSaaNbbVkajs6UNySWjTmDpoiQNdr3a+Zxzu4SkxXXxt+YJWmcTRaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759570267; c=relaxed/simple;
	bh=oHlg+HHZ07jVp8oeT+nYSiSbJP/e2FkVTYagFoTUkDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FK0ucLEnhocAZFTVYl+1OeduuL9e55xvAptLlIs/hToaUGVoAMMTEj/72y3BgkkBMc1qE+FgbCjfsOOCjMoo0WLXVXQeuxFWGAf2/hem8dtjWJRN9J7ODpzLjiFIfqFUTdGkKPwsgszR7nWmZKwAz0WEjAlfSD3IYzFZSAC9xXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BKGLKEfc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759570261;
	bh=oHlg+HHZ07jVp8oeT+nYSiSbJP/e2FkVTYagFoTUkDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BKGLKEfcHJNZ+yGu1I0N7U6Owv318R8F1qC+6XrCbc5IyG8d7z+wooJU1ULUB+Vjx
	 QWtAFrKmLhOhx0+pYau0H0q7ZYtnWBAxykiTVJjJWpd4J7fI2o/0YHixzIJY0TbQCB
	 Eto6lS7tb8g4vlG0Dqt3ngxVwHp0uWoPgl1BuLjtb1FWHBnoKluDS3UB2VmtsPKzmj
	 yl+6ogpx+7N1FYPmxjMlZV5oH2+MEi1kXknLyDPdHWlF8NeEKjptHyQ3UYr7omPMRP
	 c3accRYVOOiNbIcnGWICfN/k532H6uRqliHmoibXLrsLF9+T0ZVN2mKKd9qA4isC+5
	 wbzMlkTjdBWSg==
Received: from debian-rockchip-rock5b-rk3588.. (unknown [IPv6:2a01:e0a:5e3:6100:2e0:4cff:fe03:d8c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: loicmolinari)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DB01617E0A2B;
	Sat,  4 Oct 2025 11:31:00 +0200 (CEST)
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
	Christopher Healy <healych@amazon.com>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-mm@kvack.org,
	kernel@collabora.com,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3 01/10] drm/shmem-helper: Add huge page fault handler
Date: Sat,  4 Oct 2025 11:30:44 +0200
Message-ID: <20251004093054.21388-2-loic.molinari@collabora.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251004093054.21388-1-loic.molinari@collabora.com>
References: <20251004093054.21388-1-loic.molinari@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This gives the mm subsystem the ability to propose the insertion of
PUD or PMD-sized mappings for the faulting addresses.

On builds with CONFIG_TRANSPARENT_HUGEPAGE enabled, if the mmap() user
address is aligned to a huge page size, if the GEM object is backed by
shmem buffers on mount points setting the 'huge=' option and if the
shmem backing store manages to allocate a huge folio, the CPU mapping
will then benefit from significantly increased memcpy() performance.
When these conditions are met on a system with 2 MiB huge pages, an
aligned copy of 2 MiB would raise a single page fault instead of 4096.

v2:
- set ret to VM_FAULT_FALLBACK in default switch statement
- ifdef out paddr declaration

Signed-off-by: Loïc Molinari <loic.molinari@collabora.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509241315.8jjCyL7U-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202509241654.qJk1H5kr-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202509241920.PtSEkfd4-lkp@intel.com/
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 56 ++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 50594cf8e17c..22c4b09e10a3 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -573,7 +573,8 @@ int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_dumb_create);
 
-static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
+static vm_fault_t drm_gem_shmem_huge_fault(struct vm_fault *vmf,
+					   unsigned int order)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct drm_gem_object *obj = vma->vm_private_data;
@@ -582,6 +583,10 @@ static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
 	vm_fault_t ret;
 	struct page *page;
 	pgoff_t page_offset;
+	unsigned long pfn;
+#if defined(CONFIG_ARCH_SUPPORTS_PMD_PFNMAP) || defined(CONFIG_ARCH_SUPPORTS_PUD_PFNMAP)
+	unsigned long paddr;
+#endif
 
 	/* We don't use vmf->pgoff since that has the fake offset */
 	page_offset = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
@@ -592,17 +597,57 @@ static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
 	    drm_WARN_ON_ONCE(obj->dev, !shmem->pages) ||
 	    shmem->madv < 0) {
 		ret = VM_FAULT_SIGBUS;
-	} else {
-		page = shmem->pages[page_offset];
+		goto out;
+	}
 
-		ret = vmf_insert_pfn(vma, vmf->address, page_to_pfn(page));
+	page = shmem->pages[page_offset];
+	pfn = page_to_pfn(page);
+
+	switch (order) {
+	case 0:
+		ret = vmf_insert_pfn(vma, vmf->address, pfn);
+		break;
+
+#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
+	case PMD_ORDER:
+		paddr = pfn << PAGE_SHIFT;
+		if (((vmf->address & ~PMD_MASK) == (paddr & ~PMD_MASK)) &&
+		    (folio_order(page_folio(page)) == PMD_ORDER))
+			ret = vmf_insert_pfn_pmd(
+				    vmf, pfn & (PMD_MASK >> PAGE_SHIFT), false);
+		else
+			ret = VM_FAULT_FALLBACK;
+		break;
+#endif
+
+#ifdef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
+	case PUD_ORDER:
+		paddr = pfn << PAGE_SHIFT;
+		if (((vmf->address & ~PUD_MASK) == (paddr & ~PUD_MASK)) &&
+		    (folio_order(page_folio(page)) == PUD_ORDER))
+			ret = vmf_insert_pfn_pud(
+				    vmf, pfn & (PUD_MASK >> PAGE_SHIFT), false);
+		else
+			ret = VM_FAULT_FALLBACK;
+		break;
+#endif
+
+	default:
+		ret = VM_FAULT_FALLBACK;
+		break;
 	}
 
+ out:
 	dma_resv_unlock(shmem->base.resv);
 
 	return ret;
 }
 
+static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
+{
+	return drm_gem_shmem_huge_fault(vmf, 0);
+}
+
 static void drm_gem_shmem_vm_open(struct vm_area_struct *vma)
 {
 	struct drm_gem_object *obj = vma->vm_private_data;
@@ -639,6 +684,9 @@ static void drm_gem_shmem_vm_close(struct vm_area_struct *vma)
 
 const struct vm_operations_struct drm_gem_shmem_vm_ops = {
 	.fault = drm_gem_shmem_fault,
+#if defined(CONFIG_ARCH_SUPPORTS_PMD_PFNMAP) || defined(CONFIG_ARCH_SUPPORTS_PUD_PFNMAP)
+	.huge_fault = drm_gem_shmem_huge_fault,
+#endif
 	.open = drm_gem_shmem_vm_open,
 	.close = drm_gem_shmem_vm_close,
 };
-- 
2.47.3



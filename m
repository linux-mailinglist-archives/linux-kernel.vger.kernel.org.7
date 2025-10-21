Return-Path: <linux-kernel+bounces-862742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF1BBF60F4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09D474F1080
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B142330B0E;
	Tue, 21 Oct 2025 11:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JBo247+a"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CEE32E69B;
	Tue, 21 Oct 2025 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046263; cv=none; b=sYwevmqv883rRekw1vcSrWIGEkNisv5n8nnPPG1W5DNx2aJomJuj63FPeU9SkqGrUmSX0Bz7AXZWXSjiFBujhesFI98u2wC17juDsnDa8lAoOd1LvJlw9+Ew0LTBxh7smm8Mr3PuOmBf1xyLDSqwDeLtKAAw3yy7cSOt7PTGA5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046263; c=relaxed/simple;
	bh=b5DjKy8Ku5W6YjxLJ5sbdp7mTOI5CNz17N4tCTUcgu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i8rpqzJzvqAxkGRFgUk4+qVlEl0T+NMqgHpkojFvZkWd69q/KA+NOxR4Si/Nm3L6ukheAy5j0h6Rk9PRIE69RMtFft/71sGBSCD6R3gFi61uoVKtC7A9mXejP3rGvF4f/GV1eKLYfokZwkJhpsUk0XksPWpJada9M6rCt2CBERo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JBo247+a; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761046258;
	bh=b5DjKy8Ku5W6YjxLJ5sbdp7mTOI5CNz17N4tCTUcgu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JBo247+aL1JX25fByWt1HEwt3SEbx1YeMbAdQ0IqQ67eXRvH9z9JYIOkfGwTd+U8l
	 QiIDDrF74o723OS5FwS7yv15E72pHMPEq4cdEVkVsxqkLq4zTH/K0PFuHLNWwb0i6r
	 jwrMmgi5KWer3/K585iB6n3sFieDrCdYYINNW7Qkaz9F4AXfUL1reEx00L+3Vu8kT7
	 hzKIdP4jN24BBm25ssnHeSV9uVYyn33s/mYOtZgxkhLnoFjzu65AHsB25SIlYwL3FX
	 g9jSs0j2u6AsE/oI/z4fSiiKG06CTZQtgtO78ervT37fjs3alX+3CkWciZc4HxbHWA
	 mTb0hr/n2bIvQ==
Received: from debian-rockchip-rock5b-rk3588.. (unknown [IPv6:2a01:e0a:5e3:6100:826d:bc07:e98c:84a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: loicmolinari)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BFFB917E1407;
	Tue, 21 Oct 2025 13:30:57 +0200 (CEST)
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
Subject: [PATCH v5 03/12] drm/shmem-helper: Map huge pages in fault handlers
Date: Tue, 21 Oct 2025 13:30:40 +0200
Message-ID: <20251021113049.17242-4-loic.molinari@collabora.com>
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

Check whether the starting address in the fault-around handler or the
faulty address in the fault handler is part of a huge page in order to
attempt a PMD sized PFN insertion into the VMA.

On builds with CONFIG_TRANSPARENT_HUGEPAGE enabled, if the mmap() user
address is PMD size aligned, if the GEM object is backed by shmem
buffers on mountpoints setting the 'huge=' option and if the shmem
backing store manages to allocate a huge folio, CPU mapping would then
benefit from significantly increased memcpy() performance. When these
conditions are met on a system with 2 MiB huge pages, an aligned copy
of 2 MiB would raise a single page fault instead of 4096.

v4:
- implement map_pages instead of huge_fault

Signed-off-by: Loïc Molinari <loic.molinari@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 2a9fbc9c3712..b7238448d4f9 100644
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
@@ -606,6 +626,11 @@ static vm_fault_t drm_gem_shmem_map_pages(struct vm_fault *vmf,
 		goto out;
 	}
 
+	if (drm_gem_shmem_map_pmd(vmf, addr, pages[start_pgoff])) {
+		ret = VM_FAULT_NOPAGE;
+		goto out;
+	}
+
 	/* Map a range of pages around the faulty address. */
 	do {
 		pfn = page_to_pfn(pages[start_pgoff]);
@@ -639,6 +664,11 @@ static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
 		goto out;
 	}
 
+	if (drm_gem_shmem_map_pmd(vmf, vmf->address, pages[page_offset])) {
+		ret = VM_FAULT_NOPAGE;
+		goto out;
+	}
+
 	pfn = page_to_pfn(pages[page_offset]);
 	ret = vmf_insert_pfn(vma, vmf->address, pfn);
 
-- 
2.47.3



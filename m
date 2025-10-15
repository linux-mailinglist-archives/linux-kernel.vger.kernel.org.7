Return-Path: <linux-kernel+bounces-854779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D67BDF5F2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45EC44E3ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E665301709;
	Wed, 15 Oct 2025 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VHdkIRj7"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85951547D2;
	Wed, 15 Oct 2025 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542231; cv=none; b=i1ARhRdIDN0o0TUJbKCjmWLPsgfVJEqtisxMHpGExnb9Rmg0Jzt+UhhC4LbtQmLgB7oXuNIu8aKaVytEdnK4lP+L2xDnZql615dssmh1TdWM7vB9DkGmvkNigpK+5TyJ+oHPfX/jsc1OItaAdKBybLwPk6pu9o40MMPWO+1O4Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542231; c=relaxed/simple;
	bh=sQcBV/ZWlVLGeAwivyndjv3Kv+k/mZS823qVLbIeFmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1Umb48aCU96uQ/dzRLsN8OnpgX1sBbu3+T2MBoPMukLi2GWqscf9efcac0MYyyLWQtOs7E1sxZiqNP1hKwHSwvRBrnWalWkH0IROxdg1+8NnXCsdCK62EgP5XjyN+cyE1Jf2tcVzkwogTS+Kl8t6pZqS/YXV0l8Sf5ZwPJYpK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VHdkIRj7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760542227;
	bh=sQcBV/ZWlVLGeAwivyndjv3Kv+k/mZS823qVLbIeFmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VHdkIRj7sg4VwSgsQanwXYtbK/UcvTe7EmUkEqqxHkXOqGzYygtHQ7zYKzTzN0BW0
	 DVlMfVVHuUVa4r3IHy86HYMx7KYMhmY6osKmaU4PMNbo+WlYSZefsYM7zb639o0aA/
	 ywmDIaSM8jVfaDD9GVr7KGmxiAMWOMnqZJI4O5IeZq7EcOlIu749ykkS7wXJ2xxBD4
	 Qb3umxLKhtjCGU/3anoP0khorYvpn7lF4YwEktiPC00IvTmS5qwmS1vf0pjGegIhmI
	 cxfqel3TgrUMeNW//bU37J3wRhpV55lJlZy1Qeq8HVTySPa4FIJHJRhrHnwvayxp17
	 yopEYsaDRwSIA==
Received: from debian-rockchip-rock5b-rk3588.. (unknown [IPv6:2a01:e0a:5e3:6100:826d:bc07:e98c:84a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: loicmolinari)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0BD0E17E1340;
	Wed, 15 Oct 2025 17:30:27 +0200 (CEST)
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
Subject: [PATCH v4 01/13] drm/shmem-helper: Simplify page offset calculation in fault handler
Date: Wed, 15 Oct 2025 17:30:05 +0200
Message-ID: <20251015153018.43735-2-loic.molinari@collabora.com>
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

For a fault at address addr, the page offset is
  page_offset = (vmf->address - vma->vm_start) >> PAGE_SHIFT
              = ((addr & PAGE_MASK) - vma->vm_start) >> PAGE_SHIFT
	      = (addr - vma->vm_start) >> PAGE_SHIFT

Since the faulty logical page offset based on VMA is
  vmf->pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT)

We can slightly simplify the calculation using
  page_offset = vmf->pgoff - vma->vm_pgoff

Signed-off-by: Loïc Molinari <loic.molinari@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index dc94a27710e5..be89be1c804c 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -577,8 +577,8 @@ static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
 	struct page *page;
 	pgoff_t page_offset;
 
-	/* We don't use vmf->pgoff since that has the fake offset */
-	page_offset = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
+	/* Offset to faulty address in the VMA (without the fake offset). */
+	page_offset = vmf->pgoff - vma->vm_pgoff;
 
 	dma_resv_lock(shmem->base.resv, NULL);
 
-- 
2.47.3



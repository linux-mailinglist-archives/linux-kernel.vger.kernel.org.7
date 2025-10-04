Return-Path: <linux-kernel+bounces-842000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8352DBB8C01
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 11:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F9E5345CF6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 09:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2E0283FD4;
	Sat,  4 Oct 2025 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AMlhrgUf"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016E22820A9
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759570281; cv=none; b=KIRW35kSqp3TzXzvmutUwFKkdg3t3gJgRueyBwRerUXVRnLwH4Nynfigjv4SCHcwUBXEE4iyXN7WH6qCUkaRTY6QyMjIaIKyg0i80ZBO1x5IpZmhGzvYQrn3/1dmDMlVLIEQhZbJrUS1rzDFZ2l1FuvlzCIiI0Qvn5QHHUYGR1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759570281; c=relaxed/simple;
	bh=D0Fu/ldQhntehM2Mq/IXQJTZKKJwzHie8we5EhgLjv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gtP1DctedtEgGhIT7EX1MoEazmeQsnfU8/tHpDvWgRrZ9EHm9aBY2xrOuKBSUaSYYmlRVEzUyc44ZthizJNUVm+3fIM4uZjAvjbwfAs34w7WSWQR5Ssgsc6z+st/16VQbcII4O8Nru0YGMQNujZPMOxe6+GlVBrEDJ+bd+QF+54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AMlhrgUf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759570278;
	bh=D0Fu/ldQhntehM2Mq/IXQJTZKKJwzHie8we5EhgLjv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AMlhrgUfj67oXsQPTFjfkhXxPYErzu07l7zcQuFt1VeLOO4l1kddXtiTb2X/cetOS
	 6XMF0S8g5Fu73Rg3lAVLMWykZe56IdRC60HwD9pv/MEZTOZ6Rsmkio0eJfbmu1nwCK
	 d4IdxOltI8YwNAtsLWvnJxFMf/9AVfESz8Ub5ydUncWsPC7OnRkCO+XAq+H4dRQyS2
	 llItYjnG94oPb9HEZHBOeRVHE+Lsuht91g6GWGJTZzTqRPBN3VlqNnsa57784xcp1/
	 Of2brQuMsVBOznatNjK2ireFQDvmFsXBo6sqcHe+RO6GcwaxxUcglmxauY2WbuVjd7
	 UuGUKAQRIUOaA==
Received: from debian-rockchip-rock5b-rk3588.. (unknown [IPv6:2a01:e0a:5e3:6100:2e0:4cff:fe03:d8c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: loicmolinari)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9C0FC17E13DA;
	Sat,  4 Oct 2025 11:31:17 +0200 (CEST)
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
	kernel@collabora.com
Subject: [PATCH v3 10/10] Documentation/gpu/drm-mm: Add THP paragraph to GEM mapping section
Date: Sat,  4 Oct 2025 11:30:53 +0200
Message-ID: <20251004093054.21388-11-loic.molinari@collabora.com>
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

Add a paragraph to the GEM objects mapping section explaining how
transparent huge pages are handled by GEM.

Signed-off-by: Loïc Molinari <loic.molinari@collabora.com>
---
 Documentation/gpu/drm-mm.rst | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/drm-mm.rst b/Documentation/gpu/drm-mm.rst
index d55751cad67c..0ce6e27f8463 100644
--- a/Documentation/gpu/drm-mm.rst
+++ b/Documentation/gpu/drm-mm.rst
@@ -283,6 +283,8 @@ made up of several fields, the more interesting ones being:
 		void (*open)(struct vm_area_struct * area);
 		void (*close)(struct vm_area_struct * area);
 		vm_fault_t (*fault)(struct vm_fault *vmf);
+		vm_fault_t (*huge_fault)(struct vm_fault *vmf,
+					 unsigned int order);
 	};
 
 
@@ -290,7 +292,7 @@ The open and close operations must update the GEM object reference
 count. Drivers can use the drm_gem_vm_open() and drm_gem_vm_close() helper
 functions directly as open and close handlers.
 
-The fault operation handler is responsible for mapping individual pages
+The fault operation handlers are responsible for mapping individual pages
 to userspace when a page fault occurs. Depending on the memory
 allocation scheme, drivers can allocate pages at fault time, or can
 decide to allocate memory for the GEM object at the time the object is
@@ -299,6 +301,19 @@ created.
 Drivers that want to map the GEM object upfront instead of handling page
 faults can implement their own mmap file operation handler.
 
+In order to reduce page table overhead, if the internal shmem mountpoint
+"shm_mnt" is configured to use transparent huge pages (for builds with
+CONFIG_TRANSPARENT_HUGEPAGE enabled) and if the shmem backing store
+manages to allocate huge pages, faulty addresses within huge pages will
+be mapped into the tables using the huge page fault handler. In such
+cases, mmap() user address alignment for GEM objects is handled by
+providing a custom get_unmapped_area properly forwarding to the shmem
+backing store. For most drivers, which don't create a huge mountpoint by
+default or through a module parameter, transparent huge pages can be
+enabled by either setting the "transparent_hugepage_shmem" kernel
+parameter or the "/sys/kernel/mm/transparent_hugepage/shmem_enabled"
+sysfs knob.
+
 For platforms without MMU the GEM core provides a helper method
 drm_gem_dma_get_unmapped_area(). The mmap() routines will call this to get a
 proposed address for the mapping.
-- 
2.47.3



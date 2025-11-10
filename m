Return-Path: <linux-kernel+bounces-893568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C78C47D76
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FA9F423030
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2087B315D49;
	Mon, 10 Nov 2025 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YaqYP3BY"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5433112DA;
	Mon, 10 Nov 2025 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789821; cv=none; b=qxbDJovwYmq+E9vEmXNTU8D0Xv/829EpNJfID0wWDgFgsfuzjc1qEyXgyFdnJzIKxAvfyIGCapQJ0r+B5gZLdi/1VKaL/wE8GxcIhYMrVlGONZ0SwJz/fUiqXKjCbbplmTsGiGthzRO7PWS4i2wCSMIaZy5pNfU4DnbzNz+qybM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789821; c=relaxed/simple;
	bh=40WG8/2e61IMWsDRpUFUHulUyBgQPDILQimEoI6b3o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBySLEyxG3nwO4v00m3oDMUpiq78XA8qDxU345H+RLWFotTJZAk3tt9CAwRCeubICRxOrAlssWi09Ev/Wq8VH0gtkrIS6dse1fQ/Mf3SuYdyA1UdniXj9Sjcfly4tVd3Pa4PbSHFkWHfDRddHyJTjIArD4yeEnOehTOKdCKteoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YaqYP3BY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762789818;
	bh=40WG8/2e61IMWsDRpUFUHulUyBgQPDILQimEoI6b3o0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YaqYP3BYvVXp0RXTFrTVDF4A/I7xHNeDivG/xTI2MY0FwQuRsUvecjSJKhlVo7qLc
	 K/nwzBWJAFb/N7lzH0T+FKNRytciqwTzNDOIo8mrmlVxMDoaObzqT4WxrQtcs+BBLq
	 WpSeDlotcm7Lq18kiR0amNlSkEa8qqOI0Q1nZTSdupPdf8wHNoKdCNgUfC7Q2W/gvE
	 Ie0bBykl7eaA6dzrY2ixza+QNyH3Qv5/AXou8oA6k/BN71QT85PyQ3xWkJc7yN2Vz1
	 w/SKZkkQLurmWGEV3gXNhJBekN7CP8t7KsDKXTxaIqNJHimPG6zjDWlRVDehTRsnVE
	 GfDus8gNJFZjA==
Received: from debian-rockchip-rock5b-rk3588.. (unknown [IPv6:2a01:e0a:5e3:6100:826d:bc07:e98c:84a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: loicmolinari)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 30D3317E15C9;
	Mon, 10 Nov 2025 16:50:17 +0100 (CET)
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
Subject: [PATCH v7 11/11] Documentation/gpu/drm-mm: Add THP paragraph to GEM mapping section
Date: Mon, 10 Nov 2025 16:49:59 +0100
Message-ID: <20251110155000.2936-12-loic.molinari@collabora.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251110155000.2936-1-loic.molinari@collabora.com>
References: <20251110155000.2936-1-loic.molinari@collabora.com>
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

v4:
- fix wording after huge_pages handler removal

v6:
- fix wording after map_pages handler removal

Signed-off-by: Loïc Molinari <loic.molinari@collabora.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/gpu/drm-mm.rst | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/gpu/drm-mm.rst b/Documentation/gpu/drm-mm.rst
index d55751cad67c..d69eab0b4093 100644
--- a/Documentation/gpu/drm-mm.rst
+++ b/Documentation/gpu/drm-mm.rst
@@ -290,15 +290,27 @@ The open and close operations must update the GEM object reference
 count. Drivers can use the drm_gem_vm_open() and drm_gem_vm_close() helper
 functions directly as open and close handlers.
 
-The fault operation handler is responsible for mapping individual pages
-to userspace when a page fault occurs. Depending on the memory
-allocation scheme, drivers can allocate pages at fault time, or can
-decide to allocate memory for the GEM object at the time the object is
-created.
+The fault operation handler is responsible for mapping pages to
+userspace when a page fault occurs. Depending on the memory allocation
+scheme, drivers can allocate pages at fault time, or can decide to
+allocate memory for the GEM object at the time the object is created.
 
 Drivers that want to map the GEM object upfront instead of handling page
 faults can implement their own mmap file operation handler.
 
+In order to reduce page table overhead, if the internal shmem mountpoint
+"shm_mnt" is configured to use transparent huge pages (for builds with
+CONFIG_TRANSPARENT_HUGEPAGE enabled) and if the shmem backing store
+managed to allocate a huge page for a faulty address, the fault handler
+will first attempt to insert that huge page into the VMA before falling
+back to individual page insertion. mmap() user address alignment for GEM
+objects is handled by providing a custom get_unmapped_area file
+operation which forwards to the shmem backing store. For most drivers,
+which don't create a huge mountpoint by default or through a module
+parameter, transparent huge pages can be enabled by either setting the
+"transparent_hugepage_shmem" kernel parameter or the
+"/sys/kernel/mm/transparent_hugepage/shmem_enabled" sysfs knob.
+
 For platforms without MMU the GEM core provides a helper method
 drm_gem_dma_get_unmapped_area(). The mmap() routines will call this to get a
 proposed address for the mapping.
-- 
2.47.3



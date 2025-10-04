Return-Path: <linux-kernel+bounces-841990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCABBB8BB6
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 11:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67CA189742B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 09:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8E526CE0A;
	Sat,  4 Oct 2025 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="B92Qmfz2"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BD3219A8E
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 09:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759570267; cv=none; b=c1cOf7boO8Hz2ngSO1lwe2WlRRvnwjBvdzE4aRQFMTnPO/E/7V0RsBKHtUCQdVX90uuyf2doe6YyhIfj1kVPsmKDgQOjhiabUcxbvRLfFSqbOcYCCXbgVxYcBs9GNSjMgAVHO7FmOPDDEu6W5/QPy+frJe9bV8PvLdd1Qygx4EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759570267; c=relaxed/simple;
	bh=Zyw08bkZU/RFYvECKvHpLAFO6ylayKQuE2OJk52VPYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oXRhvpBph8kW9y61/rKvxbZpN8CFgxUiIAiEMrRjAlKpIyuTf6OPH0eftA0dIuIf5q/3+qHhbffd6EaYP0Hn0mqB9saLgz4fZmeuyy3LUc34J3kUt3A4Bfxhng1yvTXUCEJZeO1/gvwiS09B3q38D73IhR0sIx//fkxqYhKCWFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=B92Qmfz2; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759570259;
	bh=Zyw08bkZU/RFYvECKvHpLAFO6ylayKQuE2OJk52VPYk=;
	h=From:To:Cc:Subject:Date:From;
	b=B92Qmfz2VEGT/TPbfUoV4sbwP3GI/HZAc8B4wnjS04PfteyS3k6L7N6vVvHFFbo/y
	 fkiZJnat2/pOTLzkItB8GsGhoU/pJvHPHuLLF8/YOKbec9EZUgTvbRuKI8/VvgeTZ/
	 9BYFVDuBSCCcfLH1Mt6Iy0B/KiEHhXAXb9IA2WTCjFFHeGsZec/qn5HH8c1DVySQ9G
	 dCZh+0BkMUakVbOTww4H6rFfXBTbGZ+vmHmMrvT1HlEHTxskKXGlitl6fOQOeVr9Y4
	 2BmIATH6Z9FIHx0nJoX92FAMYp9/JHHic10icyUjk4yYnDG2CyUwcTw0nr0GKg87Fc
	 BBuTp6pGe3y0A==
Received: from debian-rockchip-rock5b-rk3588.. (unknown [IPv6:2a01:e0a:5e3:6100:2e0:4cff:fe03:d8c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: loicmolinari)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AB0AC17E07EE;
	Sat,  4 Oct 2025 11:30:58 +0200 (CEST)
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
Subject: [PATCH v3 00/10] drm: Reduce page tables overhead with THP
Date: Sat,  4 Oct 2025 11:30:43 +0200
Message-ID: <20251004093054.21388-1-loic.molinari@collabora.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series aims to reduce the page tables overhead of DRM drivers for
builds with CONFIG_TRANSPARENT_HUGEPAGE enabled and either the sysfs
knob '/sys/kernel/mm/transparent_hugepage/shmem_enabled' appropriately
set or drivers using a dedicated huge tmpfs mount point.

It starts by adding a huge page fault handler for GEM objects to
insert PMD or PUD mappings whenever the shmem backing store manages to
create huge folios. It then introduces a dedicated get_unmapped_area
file operation on the DRM file descriptor for GEM objects to get the
best virtual address alignment for the underlying shmem buffers.

The remaining commits propose shmem helpers to create and release huge
tmpfs mount points and adapt the i915 and V3D drivers. The helpers are
then used to optionally enable Transparent Hugepage for Panfrost and
Panthor.

For Panthor on a Rock 5B, this series makes the first memcpy() to an
entire BO object mapped in userspace about twice as fast with
Transparent Hugepage enabled.

Loïc Molinari (10):
  drm/shmem-helper: Add huge page fault handler
  drm/gem: Introduce drm_gem_get_unmapped_area() fop
  drm/gem: Add huge tmpfs mount point helper
  drm/i915: Use huge tmpfs mount point helper
  drm/v3d: Use huge tmpfs mount point helper
  drm/gem: Get rid of *_with_mnt helpers
  drm/panthor: Introduce huge tmpfs mount point option
  drm/panthor: Improve IOMMU map/unmap debugging logs
  drm/panfrost: Introduce huge tmpfs mount point option
  Documentation/gpu/drm-mm: Add THP paragraph to GEM mapping section

 Documentation/gpu/drm-mm.rst                  |  17 +-
 drivers/gpu/drm/drm_gem.c                     | 208 ++++++++++++++----
 drivers/gpu/drm/drm_gem_shmem_helper.c        |  94 +++++---
 drivers/gpu/drm/i915/Makefile                 |   3 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c     |  52 +++--
 drivers/gpu/drm/i915/gem/i915_gemfs.c         |  74 -------
 drivers/gpu/drm/i915/gem/i915_gemfs.h         |  14 --
 .../gpu/drm/i915/gem/selftests/huge_pages.c   |  10 +-
 drivers/gpu/drm/i915/i915_drv.h               |   5 -
 drivers/gpu/drm/panfrost/panfrost_device.c    |   3 +
 drivers/gpu/drm/panfrost/panfrost_drv.c       |   6 +
 drivers/gpu/drm/panfrost/panfrost_drv.h       |  11 +
 drivers/gpu/drm/panfrost/panfrost_gem.c       |  19 ++
 drivers/gpu/drm/panfrost/panfrost_gem.h       |   2 +
 drivers/gpu/drm/panthor/panthor_device.c      |   3 +
 drivers/gpu/drm/panthor/panthor_drv.c         |   7 +
 drivers/gpu/drm/panthor/panthor_drv.h         |  11 +
 drivers/gpu/drm/panthor/panthor_gem.c         |  19 ++
 drivers/gpu/drm/panthor/panthor_gem.h         |   2 +
 drivers/gpu/drm/panthor/panthor_mmu.c         |  19 +-
 drivers/gpu/drm/v3d/Makefile                  |   3 +-
 drivers/gpu/drm/v3d/v3d_bo.c                  |   6 +-
 drivers/gpu/drm/v3d/v3d_drv.c                 |   2 +-
 drivers/gpu/drm/v3d/v3d_drv.h                 |  11 +-
 drivers/gpu/drm/v3d/v3d_gem.c                 |  33 ++-
 drivers/gpu/drm/v3d/v3d_gemfs.c               |  65 ------
 include/drm/drm_device.h                      |  11 +
 include/drm/drm_gem.h                         |   8 +-
 include/drm/drm_gem_shmem_helper.h            |   3 -
 mm/shmem.c                                    |   1 +
 30 files changed, 431 insertions(+), 291 deletions(-)
 delete mode 100644 drivers/gpu/drm/i915/gem/i915_gemfs.c
 delete mode 100644 drivers/gpu/drm/i915/gem/i915_gemfs.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_drv.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_drv.h
 delete mode 100644 drivers/gpu/drm/v3d/v3d_gemfs.c

-- 
2.47.3



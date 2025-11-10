Return-Path: <linux-kernel+bounces-893557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB04DC47C08
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 617A74FB3E9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCADD276038;
	Mon, 10 Nov 2025 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kVBeK96T"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB239274B27;
	Mon, 10 Nov 2025 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789811; cv=none; b=gCoYsUAzIKuQk1Qu7hMG2JXYK1OodYsSYeEED1Zi2KroiNDYGPxBFpy+/YEg4kED9bIQQhsNnk0zd3Ab1GqdgIR3oiOSR8jNKM56PyDAH1nQqj48B8Vogz7eQ6bTk03yXwkXimY2xM4De3X2d758/sFcwCl768pQzCCv9n976s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789811; c=relaxed/simple;
	bh=p9SPlBZbb3hx77u0jsPbAy3OBjtm4qTHZI5QsOsS5bA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g7OlFL1BrapGyfReVqBjL8Fznpk/TgCsJXL6k00GInozuwixXmFnPnrB1hAWphMg7fYFldppEP18VloBbY+aRxlgGV3CoOn6Pi0ibbahlWBqgpHT2SGJVsuUh3xVwhibnCRIbaCxDA0+v6Yq4djw/5GfXSTTravQPLtK8Pkuu4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kVBeK96T; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762789806;
	bh=p9SPlBZbb3hx77u0jsPbAy3OBjtm4qTHZI5QsOsS5bA=;
	h=From:To:Cc:Subject:Date:From;
	b=kVBeK96TLCe4OlS9VXlxGINkfLW8tU/oB5kw9/AbkQHxF73BkOfwfxQLi+26ZXDMb
	 WInTDEH0EMCseRiBqOTjCLSl1K3lqr/Yb/snuB6GzH1UEmc/L3w6JzyRCo3hEwLbm/
	 eT3V6sEySoSXmfdUDitLjBu5NDzCxolhrvLFco/LretkDrmxAyLwriOEtsnNFVvqSe
	 hP6AHszaNWp2O3aemirJ8fJfNLWWueZ+0M+wmKMT/3257BIYNXlarAvPrXsGYeZIwY
	 7cW9TLLGOycPOegO3iNIqcnnknyxcSkF0Irh+BC9XsaknN2HG3mNU/gSElbUPVIS4n
	 yyz7QV1R2pkOA==
Received: from debian-rockchip-rock5b-rk3588.. (unknown [IPv6:2a01:e0a:5e3:6100:826d:bc07:e98c:84a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: loicmolinari)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0961117E0610;
	Mon, 10 Nov 2025 16:50:06 +0100 (CET)
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
Subject: [PATCH v7 00/11] drm: Reduce page tables overhead with THP
Date: Mon, 10 Nov 2025 16:49:48 +0100
Message-ID: <20251110155000.2936-1-loic.molinari@collabora.com>
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

It starts by checking whether a faulty address in the page fault
handler is part of a huge page in order to attempt a PMD sized PFN
insertion into the VMA. It then introduces a dedicated
get_unmapped_area file operation on the DRM file descriptor for GEM
objects to get the best virtual address alignment for the underlying
shmem buffers.

The remaining commits propose shmem helpers to create and release huge
tmpfs mount points and adapt the i915 and V3D drivers. The helpers are
then used to optionally enable Transparent Hugepage for Panfrost and
Panthor.

For Panthor on a Rock 5B, this series makes the first memcpy() to an
entire BO object mapped in userspace about twice as fast with
Transparent Hugepage enabled.

Implementing a fault-around handler using the arm64 contiguous page
hint (contptes) could also greatly help reduce page tables overhead
for small pages by mapping several contiguous pages around a faulty
address at once. This will be proposed in another patch series.

Loïc Molinari (11):
  drm/shmem-helper: Simplify page offset calculation in fault handler
  drm/shmem-helper: Map huge pages in fault handler
  drm/gem: Introduce drm_gem_get_unmapped_area() fop
  drm/gem: Add huge tmpfs mountpoint helpers
  drm/i915: Use huge tmpfs mountpoint helpers
  drm/v3d: Use huge tmpfs mountpoint helpers
  drm/gem: Get rid of *_with_mnt helpers
  drm/panthor: Introduce huge tmpfs mountpoint option
  drm/panthor: Improve IOMMU map/unmap debugging logs
  drm/panfrost: Introduce huge tmpfs mountpoint option
  Documentation/gpu/drm-mm: Add THP paragraph to GEM mapping section

 Documentation/gpu/drm-mm.rst                  |  22 +-
 drivers/gpu/drm/drm_gem.c                     | 203 +++++++++++++-----
 drivers/gpu/drm/drm_gem_shmem_helper.c        |  97 +++++----
 drivers/gpu/drm/i915/Makefile                 |   3 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c     |  48 +++--
 drivers/gpu/drm/i915/gem/i915_gemfs.c         |  71 ------
 drivers/gpu/drm/i915/gem/i915_gemfs.h         |  14 --
 .../gpu/drm/i915/gem/selftests/huge_pages.c   |  11 +-
 drivers/gpu/drm/i915/i915_drv.h               |   5 -
 drivers/gpu/drm/panfrost/panfrost_device.c    |   3 +
 drivers/gpu/drm/panfrost/panfrost_drv.c       |   6 +
 drivers/gpu/drm/panfrost/panfrost_drv.h       |   9 +
 drivers/gpu/drm/panfrost/panfrost_gem.c       |  18 ++
 drivers/gpu/drm/panfrost/panfrost_gem.h       |   2 +
 drivers/gpu/drm/panthor/panthor_device.c      |   3 +
 drivers/gpu/drm/panthor/panthor_drv.c         |   7 +
 drivers/gpu/drm/panthor/panthor_drv.h         |   9 +
 drivers/gpu/drm/panthor/panthor_gem.c         |  18 ++
 drivers/gpu/drm/panthor/panthor_gem.h         |   2 +
 drivers/gpu/drm/panthor/panthor_mmu.c         |  19 +-
 drivers/gpu/drm/v3d/Makefile                  |   3 +-
 drivers/gpu/drm/v3d/v3d_bo.c                  |   6 +-
 drivers/gpu/drm/v3d/v3d_drv.c                 |   2 +-
 drivers/gpu/drm/v3d/v3d_drv.h                 |  11 +-
 drivers/gpu/drm/v3d/v3d_gem.c                 |  27 ++-
 drivers/gpu/drm/v3d/v3d_gemfs.c               |  62 ------
 include/drm/drm_device.h                      |  15 ++
 include/drm/drm_gem.h                         |  40 +++-
 include/drm/drm_gem_shmem_helper.h            |   3 -
 29 files changed, 443 insertions(+), 296 deletions(-)
 delete mode 100644 drivers/gpu/drm/i915/gem/i915_gemfs.c
 delete mode 100644 drivers/gpu/drm/i915/gem/i915_gemfs.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_drv.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_drv.h
 delete mode 100644 drivers/gpu/drm/v3d/v3d_gemfs.c

-- 
2.47.3



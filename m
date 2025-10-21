Return-Path: <linux-kernel+bounces-862739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AB1BF60D4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9689334726A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC7832E73E;
	Tue, 21 Oct 2025 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AHmyR08t"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD7032E698;
	Tue, 21 Oct 2025 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046259; cv=none; b=jGXAWRqMrKXdT006+Mdb9e+wLE/Hbo0RYjerBguD5GJTp/yKSwAf64oob1YgovcBKrR6UabZYw9Olakzro9rR3dhf3Sx5WNIl/P6gEVIGba9HRo2KT3HGMWF5e08512m4D/QHwiDol/B/hU1iT/GaYOzgGOMsQzMpdBQPpef2J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046259; c=relaxed/simple;
	bh=W6xHmv8+Mi9P5OoxStkwLLPt5j3jLHnOTcNSO0Jg0pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MDKn9XptO75Z1AKt4e7/3f1jOyhnYRQ2MTOATLZ87OW/eob0XfZMZ8rSbIfIrBI7V2o8TGRGIGesKOD4SXG883ieF+pav8H5HdMocyhPwCcQs0NaGIojU4VE/xRD6BpHId0+0vv7NGKjYPpOg+7aWAxp2pYr9EXpTYpFcmgJXPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AHmyR08t; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761046255;
	bh=W6xHmv8+Mi9P5OoxStkwLLPt5j3jLHnOTcNSO0Jg0pk=;
	h=From:To:Cc:Subject:Date:From;
	b=AHmyR08tB2G3J/sn9dARyHQC5PN8/CsdOZ20Jo/YPza0VhWIPPyoWKc+yVrqD0N8l
	 BxY7maAFsPGS6VRcibQAnfcxxNvgZu6b6AiPknxVpk/zS7mivA07AguIdtXrGCjgle
	 dqbCoeV73L+buesw0pdbB76vLyaMBFkpfT7mQRlIGLcR9oezn+EAxBfYyZqDS1Aa2G
	 /1kYwhsxmvIlq9TkEzuT4gPItOG2orS8CN1GaASyyfhcckiBeam5t/05A038C4iMe2
	 4Tc/ZiLOcYSHzC1WZpnFDdMqkfCXorqFe02TzPjEE416F+YNjAtFtmmy3FY41ZQksO
	 XQLx4I4TPvoVQ==
Received: from debian-rockchip-rock5b-rk3588.. (unknown [IPv6:2a01:e0a:5e3:6100:826d:bc07:e98c:84a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: loicmolinari)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B547A17E129E;
	Tue, 21 Oct 2025 13:30:54 +0200 (CEST)
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
Subject: [PATCH v5 00/12] drm: Reduce page tables overhead with THP
Date: Tue, 21 Oct 2025 13:30:37 +0200
Message-ID: <20251021113049.17242-1-loic.molinari@collabora.com>
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

It starts by implementing a map_pages handler for GEM objects to map
pages around a faulty address in a single batch. It also checks in
both the fault and fault-around handlers whether a faulty address is
part of a huge page in order to attempt a PMD sized PFN insertion into
the VMA. It then introduces a dedicated get_unmapped_area file
operation on the DRM file descriptor for GEM objects to get the best
virtual address alignment for the underlying shmem buffers.

The remaining commits propose shmem helpers to create and release huge
tmpfs mount points and adapt the i915 and V3D drivers. The helpers are
then used to optionally enable Transparent Hugepage for Panfrost and
Panthor.

For Panthor on a Rock 5B, this series makes the first memcpy() to an
entire BO object mapped in userspace about twice as fast with
Transparent Hugepage enabled.

Note that some architectures like arm64 with the contiguous page hint
(contptes) would very likely benefit from a vmf_insert_pfns() function
based on set_ptes() to insert a range of contiguous ptes.

Loïc Molinari (12):
  drm/shmem-helper: Simplify page offset calculation in fault handler
  drm/shmem-helper: Implement map_pages fault-around handler
  drm/shmem-helper: Map huge pages in fault handlers
  drm/gem: Introduce drm_gem_get_unmapped_area() fop
  drm/gem: Add huge tmpfs mountpoint helpers
  drm/i915: Use huge tmpfs mountpoint helpers
  drm/v3d: Use huge tmpfs mountpoint helpers
  drm/gem: Get rid of *_with_mnt helpers
  drm/panthor: Introduce huge tmpfs mountpoint option
  drm/panthor: Improve IOMMU map/unmap debugging logs
  drm/panfrost: Introduce huge tmpfs mountpoint option
  Documentation/gpu/drm-mm: Add THP paragraph to GEM mapping section

 Documentation/gpu/drm-mm.rst                  |  25 ++-
 drivers/gpu/drm/drm_gem.c                     | 184 +++++++++++++-----
 drivers/gpu/drm/drm_gem_shmem_helper.c        | 142 ++++++++++----
 drivers/gpu/drm/i915/Makefile                 |   3 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c     |  47 +++--
 drivers/gpu/drm/i915/gem/i915_gemfs.c         |  69 -------
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
 drivers/gpu/drm/v3d/v3d_gemfs.c               |  60 ------
 include/drm/drm_device.h                      |  15 ++
 include/drm/drm_gem.h                         |  59 +++++-
 include/drm/drm_gem_shmem_helper.h            |   3 -
 mm/shmem.c                                    |   1 +
 30 files changed, 491 insertions(+), 292 deletions(-)
 delete mode 100644 drivers/gpu/drm/i915/gem/i915_gemfs.c
 delete mode 100644 drivers/gpu/drm/i915/gem/i915_gemfs.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_drv.h
 create mode 100644 drivers/gpu/drm/panthor/panthor_drv.h
 delete mode 100644 drivers/gpu/drm/v3d/v3d_gemfs.c

-- 
2.47.3



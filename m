Return-Path: <linux-kernel+bounces-699870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9B5AE606E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 11:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619833A57F4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 09:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ECE26A1C1;
	Tue, 24 Jun 2025 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpQGURUc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1876D3D3B8
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750756522; cv=none; b=fBAPsoy1zR6S1niLG/P6HxeoM1J4SIsPgBTRLIxPgda6v8u2kbtSsrwH/ZGvBoJizlG2EgheqkA1F8I0oJwlGM3kmIoguy3+OZe2+5NOotJTGHaZE/7SaKnDRf+JZsQQMKE8G/eBLuVWe/qM5vD7rSoHM18SODXLn2o40IjZkRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750756522; c=relaxed/simple;
	bh=8LiZqQq7+C/4FTXMbhhNu+KDmSddT3vqrMT27sjv9Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UYWeVw2ga5NHAykPGaApGLk3/Jus65iR93BQ9/1Q7iK+LBpgGd8Hx5wa4dlLUHiH0SASLTOt0r6uXsOuDgNoWWulF0VeWEts5u0ubG1Jg2Y064ZT8YEWm3i0qGn1E+sDhBxogNJ/DZH1Y7ZRKNwgYNKvgqf+T1IXKTBknBE0V/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fpQGURUc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750756519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RSfMZ1nHfNC+ISCEN7sRBSU6EdL8uqjDNRxVT2qKqq0=;
	b=fpQGURUchHctqtWxl0UFbNG9n0YKVZW8kciIZ7zl/EsDWzBeO546xECwx1fZdT9ef+/mmJ
	svIAFNb/jxGZt4vjxghnHbmqPi0o/1cRSwhSUdQq9exxcxX+S5iGqvkWkweHY3tdmUrsdj
	V87MxY0LT0ZmIXU7gsTKitmZzjEF44o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-o-Wein_EO7ugO5715e2OjA-1; Tue,
 24 Jun 2025 05:15:14 -0400
X-MC-Unique: o-Wein_EO7ugO5715e2OjA-1
X-Mimecast-MFC-AGG-ID: o-Wein_EO7ugO5715e2OjA_1750756512
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7180A1809C82;
	Tue, 24 Jun 2025 09:15:11 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.45.224.209])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5D02F180045C;
	Tue, 24 Jun 2025 09:15:03 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH v11 00/11] drm/i915: Add drm_panic support
Date: Tue, 24 Jun 2025 11:01:09 +0200
Message-ID: <20250624091501.257661-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This adds drm_panic support for i915 and xe driver.

I've tested it on the 4 intel laptops I have at my disposal.
 * Haswell with 128MB of eDRAM.
 * Comet Lake  i7-10850H
 * Raptor Lake i7-1370P (with DPT, and Y-tiling).
 * Lunar Lake Ultra 5 228V (with DPT, and 4-tiling, and using the Xe driver.

I tested panic in both fbdev console and gnome desktop.
I think it won't work yet on discrete GPU, but that can be added later.

Best regards,

v2:
 * Add the proper abstractions to build also for Xe.
 * Fix dim checkpatch issues.

v3:
 * Add support for Y-tiled framebuffer when DPT is enabled.

v4:
 * Add support for Xe driver, which shares most of the code.
 * Add support for 4-tiled framebuffer found in newest GPU.

v5:
 * Rebase on top of git@gitlab.freedesktop.org:drm/i915/kernel.git drm-intel-next
 * Use struct intel_display instead of drm_i915_private.
 * Use iosys_map for intel_bo_panic_map().

v6:
 * Rebase on top of git@gitlab.freedesktop.org:drm/i915/kernel.git drm-intel-next
 * Use struct intel_display instead of drm_i915_private for intel_atomic_plane.c

v7:
 * Fix mismatch {} in intel_panic_flush() (Jani Nikula)
 * Return int for i915_gem_object_panic_map() (Ville Syrjälä)
 * Reword commit message about alignment/size when disabling tiling (Ville Syrjälä)

v8:
 * Use kmap_try_from_panic() instead of vmap, to access the framebuffer.
 * Add ttm_bo_kmap_try_from_panic() for the xe driver, that uses ttm.
 * Replace intel_bo_panic_map() with a setup() and finish() function,
   to allow mapping only one page of teh framebuffer at a time.
 * Configure psr to send the full framebuffer update.

v9:
 * Fix comment in ttm_bo_kmap_try_from_panic(), this can *only* be called
   from the panic handler (Christian König)
 * Fix missing kfree() for i915_panic_pages in i915_gem_object_panic_finish()
   Also change i915_panic_pages allocation to kmalloc, as kvmalloc is not
   safe to call from the panic handler.
 * Fix dim checkpatch warnings.

v10:
 * Add a private field to struct drm_scanout_buffer
 * Replace static variables with new fields in struct intel_framebuffer
   (Maarten Lankhorst)
 * Add error handling if i915_gem_object_panic_pages() returns NULL
 * Declare struct drm_scanout_buffer instead of including <drm/drm_panic.h>
   in intel_bo.h

v11:
 * Encapsulate the struct intel_framebuffer into a xe_framebuffer or
   i915_framebuffer, to make it easier to add a struct xe_res_cursor
   to support discrete GPU later.


Jocelyn Falempe (11):
  drm/panic: Add a private field to struct drm_scanout_buffer
  drm/i915/fbdev: Add intel_fbdev_get_map()
  drm/i915/display/i9xx: Add a disable_tiling() for i9xx planes
  drm/i915/display: Add a disable_tiling() for skl planes
  drm/ttm: Add ttm_bo_kmap_try_from_panic()
  drm/i915: Add intel_bo_alloc_framebuffer()
  drm/i915: Add intel_bo_panic_setup() and intel_bo_panic_finish()
  drm/i915/display: Add drm_panic support
  drm/i915/display: Add drm_panic support for Y-tiling with DPT
  drm/i915/display: Add drm_panic support for 4-tiling with DPT
  drm/i915/psr: Add intel_psr2_panic_force_full_update

 drivers/gpu/drm/i915/display/i9xx_plane.c     |  26 ++-
 drivers/gpu/drm/i915/display/intel_bo.c       |  17 ++
 drivers/gpu/drm/i915/display/intel_bo.h       |   5 +
 .../drm/i915/display/intel_display_types.h    |   4 +
 drivers/gpu/drm/i915/display/intel_fb.c       |   2 +-
 drivers/gpu/drm/i915/display/intel_fb_pin.c   |   5 +
 drivers/gpu/drm/i915/display/intel_fb_pin.h   |   2 +
 drivers/gpu/drm/i915/display/intel_fbdev.c    |   5 +
 drivers/gpu/drm/i915/display/intel_fbdev.h    |   6 +-
 drivers/gpu/drm/i915/display/intel_plane.c    | 170 +++++++++++++++++-
 drivers/gpu/drm/i915/display/intel_psr.c      |  20 +++
 drivers/gpu/drm/i915/display/intel_psr.h      |   2 +
 .../drm/i915/display/skl_universal_plane.c    |  29 ++-
 drivers/gpu/drm/i915/gem/i915_gem_object.h    |   6 +
 drivers/gpu/drm/i915/gem/i915_gem_pages.c     | 142 +++++++++++++++
 drivers/gpu/drm/i915/i915_vma.h               |   5 +
 drivers/gpu/drm/ttm/ttm_bo_util.c             |  27 +++
 drivers/gpu/drm/xe/display/intel_bo.c         |  91 ++++++++++
 drivers/gpu/drm/xe/display/xe_fb_pin.c        |   5 +
 include/drm/drm_panic.h                       |   6 +
 include/drm/ttm/ttm_bo.h                      |   1 +
 21 files changed, 571 insertions(+), 5 deletions(-)


base-commit: 266907bb491f2bdd731139792b5a5056b6d0a482
-- 
2.49.0



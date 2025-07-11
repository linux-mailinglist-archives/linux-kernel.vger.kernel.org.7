Return-Path: <linux-kernel+bounces-728326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9038AB026D0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102033B03D6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 22:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623E521FF4D;
	Fri, 11 Jul 2025 22:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RpcvX3Ov"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FAF21B9E5
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 22:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752271891; cv=none; b=AVxJeC+vUbGMZNyx4JXBUU7D/XX9uw7ioVsbz1maxTmJnvp9hkgA0J/L7vBhh38BXtLyTbatyUwRehAZKw+KZBIeMYqA2RSBUvrG1QMvjhNhGxBTb6OA8qA/ZGDOUp/bRvKOoK4jVs3eULEoXTG2JyXJvReOeD72/gGSwrytVGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752271891; c=relaxed/simple;
	bh=IDNGjPZveu23hK/BMruXaxasRSZ6QyyDaqQBL3h2TNo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rSRrt2jSDnQVnhZXGzumRWmcuyAyx/aivhUjaIXGpPM8b7cge0gGjz6ejRxgoaQONt3gniHgUeGPJbUpfoGJl4zpwm7/1psMpu5oIF80/Yk0gxcZ0XaZP/15Oo4OQHYLr6MqQxNiue2ARjjHnAUUj/ddXxhgwdPFTIU+gQAYFuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=RpcvX3Ov; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4f379662cso2186005f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1752271888; x=1752876688; darn=vger.kernel.org;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMZOK0zGE3QkqzeUwZ/9p4zQ/N/Yvn8raXUpAZ5Ygfs=;
        b=RpcvX3OvO3nyFixG4uTnzir09Y68SaZHuC/+gxD2jZy6eoyK/aSxwORJC6/I3sD4R/
         Qw7ZY5HqqHaASlpaPRYR3jHxLMK6HtcWq91p7cpNO0VgRWgA1oUX+Mt5VqMecEeqTIEo
         /YdPuK7gJdGqywMZ0wHCnJKJhoPF4eY4X7n7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752271888; x=1752876688;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMZOK0zGE3QkqzeUwZ/9p4zQ/N/Yvn8raXUpAZ5Ygfs=;
        b=H0ckrFEOzO/ZHXu9eCkUid6AZgr95rI5Zn8rLPVk6/4UR1xUMkDCOKmbbtPyt8PL7b
         GUXClC42ueKRuWTWs881usB5hm9bt1QPQAeSeJ24CHE2zwTReqcUnQIa7JUPqC7amJ14
         3gzFOS2dGEO5v3gl9JWTkkp1XuVpLLmAdB9bvGymRRIvK/ZqKveYH3QL/OLky78PJiZG
         WFpnaIaaVb3wiD4LyWOSRXxUJhatMbZ16sIV+ky3puxxC/0S/xQaO9W+9MjzwgTmFUxS
         cd5sCwglcN3i/LuBvd55Eqi50uiQe8bHyLV2idzf4PVS40Ge1+tJo3rKoHvkyWYNL608
         sRAw==
X-Gm-Message-State: AOJu0Yw8h6byCxxsDelNrLGbZOmV0DjJUwoI6k4bwVA/4OyyfkDAmc3z
	O6vFUpUm9Ix0QO/O95AscZIAUBvGIVtv2Lat62QJ/ypInTr1sUqfGt0SdcCaxMxUlQo=
X-Gm-Gg: ASbGncsv3KrPpr/1QKWFOMmNY04UXJ3UnjJrzZ2f6rKkELdXX6Fl7Sn0X2siONKVWVB
	hcqIs1PnuWcwVUcCeP2vz1euH1kQIzQEYvfpPR1Ioxju1nSC0HPMziUS+dp/0l1rsr9gyUyqnik
	syztbu/zlXlICZcXxw1t+W5zsYGWgc5OI6LkULW8rdugwi4FUao/INKUchpbz7gqrT0lGQtCgKM
	yrN6ZA1hAR0cOSLLAzUV+R//ooxBs7rH5Kxow/7kdGrIqTGpRtxSi4W3jIa9M7zbmRHQPmpIoCJ
	lD6oJ+JYf8/cn7cDQJaIrm5XyEUXy+Uz2H6NmoSEcw+uRnDbZnWhXtrvaawlHtSf7kksw3OAWU7
	1VHaufz6r+slNUK9tq6bGp4+jqdbOWaYFfEGFBlDmnugd
X-Google-Smtp-Source: AGHT+IENs36yvqEFOzAaZMmMAzahdZcvrKbkWM9wENAz8j26+W7id5gTIuIu7J6ieHmuNJ8X1FqSxA==
X-Received: by 2002:a5d:5f88:0:b0:3b5:e077:af24 with SMTP id ffacd0b85a97d-3b5f2dc21famr4032648f8f.14.1752271887721;
        Fri, 11 Jul 2025 15:11:27 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd4b32d8sm58626325e9.17.2025.07.11.15.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 15:11:27 -0700 (PDT)
Date: Sat, 12 Jul 2025 00:11:25 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	DRI Development <dri-devel@lists.freedesktop.org>,
	Dave Airlie <airlied@gmail.com>
Subject: [PULL] drm-fixes for 6.16-rc6
Message-ID: <aHGMDdZNDhjND0iT@phenom.ffwll.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	DRI Development <dri-devel@lists.freedesktop.org>,
	Dave Airlie <airlied@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux phenom 6.12.30-amd64 

Hi Linus,

The much-anticipated handle_count regression fix from -rc5, but as
discussed, not the pile of reverts - we'll go with what we have for at
least this rc to not rush into yet another issue. The
gem_handle_create_tail fix is another one that's a bit more tricky, but
not something legit userspace will ever hit. Otherwise just the usual pile
of small driver fixes as expected.

Next week should be back to Dave.

drm-fixes-2025-07-12:
drm-fixes for 6.16-rc6

Cross-subsystem Changes:
- agp/amd64 binding dmesg noise regression fix

Core Changes:
- fix race in gem_handle_create_tail
- fixup handle_count fb refcount regression from -rc5, popular with
  reports ...
- call rust dtor for drm_device release

Driver Changes:
- nouveau: magic 50ms suspend fix, acpi leak fix
- tegra: dma api error in nvdec
- pvr: fix device reset
- habanalbs maintainer update

- intel display: fix some dsi mipi sequences

- xe fixes: SRIOV fixes, small GuC fixes, disable indirect ring due to
  issues, compression fix for fragmented BO, doc update

Cheers, Sima

The following changes since commit d7b8f8e20813f0179d8ef519541a3527e7661d3a:

  Linux 6.16-rc5 (2025-07-06 14:10:26 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-07-12

for you to fetch changes up to b7dc79a6332fe6f58f2e6b2a631bad101dc79107:

  Merge tag 'drm-misc-fixes-2025-07-10' of https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes (2025-07-11 14:11:19 +0200)

----------------------------------------------------------------
drm-fixes for 6.16-rc6

Cross-subsystem Changes:
- agp/amd64 binding dmesg noise regression fix

Core Changes:
- fix race in gem_handle_create_tail
- fixup handle_count fb refcount regression from -rc5, popular with
  reports ...
- call rust dtor for drm_device release

Driver Changes:
- nouveau: magic 50ms suspend fix, acpi leak fix
- tegra: dma api error in nvdec
- pvr: fix device reset
- habanalbs maintainer update

- intel display: fix some dsi mipi sequences

- xe fixes: SRIOV fixes, small GuC fixes, disable indirect ring due to
  issues, compression fix for fragmented BO, doc update

----------------------------------------------------------------
Aaron Thompson (1):
      drm/nouveau: Do not fail module init on debugfs errors

Alessio Belle (1):
      drm/imagination: Fix kernel crash when hard resetting the GPU

Ben Skeggs (1):
      drm/nouveau/gsp: fix potential leak of memory used during acpi init

Danilo Krummrich (1):
      rust: drm: device: drop_in_place() the drm::Device in release()

Dave Airlie (1):
      nouveau/gsp: add a 50ms delay between fbsr and driver unload rpcs

Hans de Goede (1):
      drm/i915/bios: Apply vlv_fixup_mipi_sequences() to v2 mipi-sequences too

Julia Filipchuk (1):
      drm/xe/guc: Recommend GuC v70.46.2 for BMG, LNL, DG2

Lucas De Marchi (1):
      drm/xe/guc: Default log level to non-verbose

Lukas Wunner (1):
      agp/amd64: Check AGP Capability before binding to unsupported devices

Matthew Auld (1):
      drm/xe/bmg: fix compressed VRAM handling

Matthew Brost (2):
      drm/xe: Allocate PF queue size on pow2 boundary
      Revert "drm/xe/xe2: Enable Indirect Ring State support for Xe2"

Michal Wajdeczko (2):
      drm/xe/pf: Clear all LMTT pages on alloc
      drm/xe/bmg: Don't use WA 16023588340 and 22019338487 on VF

Mikko Perttunen (1):
      drm/tegra: nvdec: Fix dma_alloc_coherent error check

Ofir Bitton (1):
      MAINTAINERS: Change habanalabs maintainer

Shuicheng Lin (3):
      drm/xe/pm: Restore display pm if there is error after display suspend
      drm/xe: Release runtime pm for error path of xe_devcoredump_read()
      drm/xe/pm: Correct comment of xe_pm_set_vram_threshold()

Simona Vetter (4):
      drm/gem: Fix race in drm_gem_handle_create_tail()
      Merge tag 'drm-intel-fixes-2025-07-10' of https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2025-07-11' of https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2025-07-10' of https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes

Tamir Duberstein (1):
      rust: drm: remove unnecessary imports

Thomas Zimmermann (1):
      drm/framebuffer: Acquire internal references on GEM handles

 MAINTAINERS                                        |  2 +-
 drivers/char/agp/amd64-agp.c                       | 16 ++++----
 drivers/gpu/drm/drm_framebuffer.c                  | 31 +++++++++++++-
 drivers/gpu/drm/drm_gem.c                          | 48 +++++++++++++++-------
 drivers/gpu/drm/drm_gem_framebuffer_helper.c       | 16 ++++----
 drivers/gpu/drm/drm_internal.h                     |  2 +-
 drivers/gpu/drm/drm_panic_qr.rs                    |  2 +-
 drivers/gpu/drm/i915/display/intel_bios.c          |  8 ++--
 drivers/gpu/drm/imagination/pvr_power.c            |  4 +-
 drivers/gpu/drm/nouveau/nouveau_debugfs.c          |  6 +--
 drivers/gpu/drm/nouveau/nouveau_debugfs.h          |  5 +--
 drivers/gpu/drm/nouveau/nouveau_drm.c              |  4 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c  | 27 +++++++++---
 drivers/gpu/drm/tegra/nvdec.c                      |  6 +--
 drivers/gpu/drm/xe/xe_devcoredump.c                | 38 ++++++++++++-----
 drivers/gpu/drm/xe/xe_gt_pagefault.c               |  1 +
 drivers/gpu/drm/xe/xe_lmtt.c                       | 11 +++++
 drivers/gpu/drm/xe/xe_migrate.c                    |  2 +-
 drivers/gpu/drm/xe/xe_module.c                     |  2 +-
 drivers/gpu/drm/xe/xe_pci.c                        |  1 -
 drivers/gpu/drm/xe/xe_pm.c                         | 11 ++---
 drivers/gpu/drm/xe/xe_uc_fw.c                      |  6 +--
 drivers/gpu/drm/xe/xe_wa_oob.rules                 |  4 +-
 include/drm/drm_file.h                             |  3 ++
 include/drm/drm_framebuffer.h                      |  7 ++++
 rust/kernel/drm/device.rs                          | 12 +++++-
 rust/kernel/drm/driver.rs                          |  1 -
 27 files changed, 187 insertions(+), 89 deletions(-)

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch


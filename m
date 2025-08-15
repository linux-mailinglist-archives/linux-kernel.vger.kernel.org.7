Return-Path: <linux-kernel+bounces-771467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F0DB287B2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937D060547F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21422242D6C;
	Fri, 15 Aug 2025 21:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xq0OtT6u"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7E572606
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755293089; cv=none; b=XPElQiG5uBbn5CY4Mz0VYjvGJm2OEq88TZ/cChNE5Dnbq0ChY/0fU4kaxnflHBExpynNqe3Smxx17Nydjp9Cq7AOdQzWfAFJdDp09apAsalHcgxO/etOy6Gq9VcyqrpAXNom2cN5QToR+BLRJ7e2IJl2+I4mDPxpxtMqF6/ZL0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755293089; c=relaxed/simple;
	bh=lbi4c0J8To6S0l8OkFautL55noGGa95SKZeWFLn2/8k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LeaIj3ynZo5pAEHzlwAarBie6+Jla87if8iO8rRvQLVEGf5PdqzlzvJppVv+8jIExmpTRiMBlOciowMAyIMAjOeB8CYG/pQvzRjA6UAy+A30HNnMNIJbMYV46e9C5a9aMRSq9VYb3zp+Hpr0yen+2f+rWRbmS7Et0wgfoVf1zuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xq0OtT6u; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7abfc5cso415452366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755293086; x=1755897886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+qIOb7MhZrTM3Gz78VAP2PB6SLSWwwc3h6Nvb8V9Yw8=;
        b=Xq0OtT6uaTGZSpt3sAixMedt8SCwWkcpOtLkz4JyQrvy1kJHVUGI5j9BuwYpFfTnIj
         vwkGDCKcAjzCoSFByDtNXfdbMgHC70cC7cCLY/FvZ17JgUeUP3KmiNxV3xWnb+2il8pg
         YWLht0QoU6YlZQmxerFVuHDlwQ2kz5JHswFxvFyWj4pgnEoIclhxpcYuZMr3L60lZL28
         0so/8Ybt0SrHsHqmfYT9Hp0E071x0lJdNNLA9dR2LyuPtInLirdzXVCbAtwGG7a78IoV
         FjSFaIDXhMus0QcMsYeD2cVa3sq8QbDr1uGpM9FvWlCcy9bG+IwMgQipnSTYzjkjLubG
         KiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755293086; x=1755897886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qIOb7MhZrTM3Gz78VAP2PB6SLSWwwc3h6Nvb8V9Yw8=;
        b=P0KXvebc7ZZuLcvXKwl4bYinqm+RXQ6lOaCCnvbOwjs4wPVppbOLh9aUqIa1bAy5qi
         olIQVNI7jAlc9XrzAvebk/LWDymwkkGTNPWuQWej4xLSEOSzQftmPqq5Rlpaca1A+wRF
         oTAX0KUJm2NqOOznuqjH0caaNtX9lbpZLA/GDj0WCRQiNQY5W1r4fon3H04prlRHlCFI
         4BzqxaWMeIhOiihciYtsDbHYDnFWKxjIQmKQ4ygdX11B2uqeNGkj1O2fgWbYlQm6WHy7
         KGjDee49ZEExo1PDHxQ8TGeOSZ6bJcYnv7MDRPx2E1hrhszkxUh/lGwIuFvK9yux0HSQ
         dYLA==
X-Forwarded-Encrypted: i=1; AJvYcCUIGXLcqxi6fAiMPToN6PYj4SJGvi4+oNZnS5ZdlDDMHFGikATBzwHf9wRuAjCnTxGUOBtt5Ixk1DbIFQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT6JaxYwR2LUfVkzZw6LhEgFsupn9vs5WyuWhXMAEI21rtRFlZ
	wJsMA3DhhPcsxf9aoFxe0Ote3K1/bdKMbXxLsQ4EbYvkXdlot5Tr7e7w0OSlzV/oD3lz0kukDDW
	4d9mtjt8tJ8D7qRG3QBb+NrCyukI5dRY=
X-Gm-Gg: ASbGncs2Pu7H4i/+JEpmfTR0/3TyD8GugTs14u+sDr2If3OvmY3mSF7YCQeO2gIouIa
	KQtM/ne2XdIYDv/xWRS2w74f7DHal67+hSLJ6zGaCIkhSTTKpV/nvHsq3sTKz0sHzoz5AdDzz2g
	bh9M2RpPQFIjQ66jxO1wCq7gJ5000w6DPEno0DR4r+KOVMMRWIEXXTiZNWniYXt7o4x1eNDcdj0
	40DOw==
X-Google-Smtp-Source: AGHT+IE6pRkR/84obWyVnodDN8VDnr+5+cDXMo6Igk/em5zWcMgiul9+ruHVvYBSchwOZOf+qVWqCEldj/tmMZ1NlSc=
X-Received: by 2002:a17:907:3e12:b0:ae0:a483:39bc with SMTP id
 a640c23a62f3a-afcdc3d5787mr334171766b.46.1755293085346; Fri, 15 Aug 2025
 14:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 16 Aug 2025 07:24:32 +1000
X-Gm-Features: Ac12FXzcsWgm2tWARMaCU44DETAAph3R26z-4uVWJpMBPaXG3-N6W3_AWU5vGJs
Message-ID: <CAPM=9tyB2nWb_L8DvXFQ3PUo516j2Z6UW9-t3d9o0yBM7TzBuw@mail.gmail.com>
Subject: [git pull] drm fixes for 6.17-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Relatively quiet week, usual amdgpu/i915/xe fixes along with a set of
fixes for fbdev format info, which fix some regressions seen in with
rc1.

Thanks,
Dave.

drm-fixes-2025-08-16:
drm fixes for 6.17-rc2

bridge:
- fix OF-node leak
- fix documentation

fbdev-emulation:
- pass correct format info to drm_helper_mode_fill_fb_struct()

panfrost:
- print correct RSS size

amdgpu:
- PSP fix
- VRAM reservation fix
- CSA fix
- Process kill fix

i915:
- Fix the implementation of wa_18038517565 [fbc]
- Do not trigger Frame Change events from frontbuffer flush [psr]

xe:
- Some more xe_migrate_access_memory fixes (Auld)
- Defer buffer object shrinker write-backs and GPU waits (Thomas)
- HWMON fix for clamping limits (Karthik)
- SRIOV-PF: Set VF LMEM BAR size (Michal)
The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585=
:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-08-16

for you to fetch changes up to 00062ea01d35eaca34d561e5c76cd988dc8c3b83:

  Merge tag 'drm-xe-fixes-2025-08-14' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2025-08-15 09:50:26 +1000)

----------------------------------------------------------------
drm fixes for 6.17-rc2

bridge:
- fix OF-node leak
- fix documentation

fbdev-emulation:
- pass correct format info to drm_helper_mode_fill_fb_struct()

panfrost:
- print correct RSS size

amdgpu:
- PSP fix
- VRAM reservation fix
- CSA fix
- Process kill fix

i915:
- Fix the implementation of wa_18038517565 [fbc]
- Do not trigger Frame Change events from frontbuffer flush [psr]

xe:
- Some more xe_migrate_access_memory fixes (Auld)
- Defer buffer object shrinker write-backs and GPU waits (Thomas)
- HWMON fix for clamping limits (Karthik)
- SRIOV-PF: Set VF LMEM BAR size (Michal)

----------------------------------------------------------------
Adri=C3=A1n Larumbe (1):
      drm/panfrost: Print RSS for tiler heap BO's in debugfs GEMS file

Andy Yan (1):
      drm/bridge: Describe the newly introduced drm_connector
parameter for drm_bridge_detect

Dave Airlie (4):
      Merge tag 'drm-misc-next-fixes-2025-08-12' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-6.17-2025-08-13' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2025-08-13' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2025-08-14' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

Dmitry Baryshkov (1):
      drm/bridge: document HDMI CEC callbacks

Frank Min (1):
      drm/amdgpu: Add PSP fw version check for fw reserve GFX command

Imre Deak (3):
      drm/omap: Pass along the format info from .fb_create() to
drm_helper_mode_fill_fb_struct()
      drm/nouveau: Pass along the format info from .fb_create() to
drm_helper_mode_fill_fb_struct()
      drm/radeon: Pass along the format info from .fb_create() to
drm_helper_mode_fill_fb_struct()

Jack Xiao (1):
      drm/amdgpu: fix incorrect vm flags to map bo

Johan Hovold (1):
      drm/bridge: fix OF node leak

Jouni H=C3=B6gander (1):
      drm/i915/psr: Do not trigger Frame Change events from frontbuffer flu=
sh

Karthik Poosa (1):
      drm/xe/hwmon: Add SW clamp for power limits writes

Liu01 Tong (1):
      drm/amdgpu: fix task hang from failed job submission during process k=
ill

Maarten Lankhorst (1):
      Merge remote-tracking branch 'drm/drm-next' into drm-misc-next-fixes

Matthew Auld (3):
      drm/xe/migrate: prevent infinite recursion
      drm/xe/migrate: don't overflow max copy size
      drm/xe/migrate: prevent potential UAF

Micha=C5=82 Winiarski (1):
      drm/xe/pf: Set VF LMEM BAR size

Thomas Hellstr=C3=B6m (1):
      drm/xe: Defer buffer object shrinker write-backs and GPU waits

Vinod Govindapillai (1):
      drm/i915/fbc: fix the implementation of wa_18038517565

YiPeng Chai (1):
      drm/amdgpu: fix vram reservation issue

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c       |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c      |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c      | 19 +++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c       | 15 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c |  3 +-
 drivers/gpu/drm/bridge/aux-bridge.c          |  2 ++
 drivers/gpu/drm/drm_bridge.c                 |  1 +
 drivers/gpu/drm/i915/display/intel_fbc.c     |  8 ++---
 drivers/gpu/drm/i915/display/intel_psr.c     | 14 +++++---
 drivers/gpu/drm/nouveau/nouveau_display.c    |  9 ++---
 drivers/gpu/drm/nouveau/nouveau_display.h    |  3 ++
 drivers/gpu/drm/omapdrm/omap_fb.c            | 23 ++++++-------
 drivers/gpu/drm/omapdrm/omap_fb.h            |  2 ++
 drivers/gpu/drm/omapdrm/omap_fbdev.c         |  5 ++-
 drivers/gpu/drm/panfrost/panfrost_gem.c      |  2 +-
 drivers/gpu/drm/radeon/radeon_display.c      |  5 +--
 drivers/gpu/drm/radeon/radeon_fbdev.c        | 11 +++---
 drivers/gpu/drm/radeon/radeon_mode.h         |  2 ++
 drivers/gpu/drm/xe/regs/xe_bars.h            |  1 +
 drivers/gpu/drm/xe/xe_hwmon.c                | 29 ++++++++++++++++
 drivers/gpu/drm/xe/xe_migrate.c              | 42 +++++++++++++++--------
 drivers/gpu/drm/xe/xe_pci_sriov.c            | 22 ++++++++++++
 drivers/gpu/drm/xe/xe_shrinker.c             | 51 ++++++++++++++++++++++++=
+---
 include/drm/drm_bridge.h                     | 48 ++++++++++++++++++++++++=
++
 24 files changed, 257 insertions(+), 67 deletions(-)


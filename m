Return-Path: <linux-kernel+bounces-736701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBF2B0A0C3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43743A4613
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3EC29E101;
	Fri, 18 Jul 2025 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adrGEnPX"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C623198A2F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752834845; cv=none; b=eWi9XCdk8fhYg0HPQI/IrBoHuWHLuNa4SWHyzbEZjPSg4CqesMs6kkHI1NrsfqD2xsipWL06dReRbIpakGohT2+Q8DLYcn2/OmR8yQFec7rZfwWvJE4mjFVgr+/UKTttEGWzGr38eYS5psXCJt0lVZGxpW7ZDnkHnwYU47hVrV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752834845; c=relaxed/simple;
	bh=jfhIWJJcVzr4ySSMl+IA99FXWWWI1LaROD0wLAlGR0Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Yg9j5hIRnxMRa/HvuBoa/XmVlM1RlluHfTHvfSzc2oh5c2neXmGYz+aSwNfRJ5ytLzJpgrrQtMN30t4WsfVnaeEX2IZJgb1k4GNIaqzkqmyoD/cVSRJcO0g3gdStXmDdwn0Jtbg0TeCy/bHLqYJHMbaBxVa7FStyreifenfEv+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adrGEnPX; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso3380396a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752834841; x=1753439641; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2qBzQmRBIh3BDUW1vW6d6WLsqLJRkox9K+h2IOJ36Pw=;
        b=adrGEnPXdJW8C6mBYe6Olg81faCpk/mNTcJ36msj4NFe4Lb3Ar2LXKOhSZ60FzmeuG
         OZbhrrL5txB/8LYlrUwfh3kIA4Z7l+QTDqdbcvXu5bmEIfWqDi6u/zXgwtd9EKf7kabm
         Wk8/6MGf68kx9Ju6/NSZ9b6XzOnUaSCopO2KMjCrTrYUMvV/MAVuLnAVyKV26Ufx4P9c
         11EFoPOLlXQ7wxEs49kaw7Rk7lbU5JYGu31bW+PoqWMFt7vK9AdKO6dXlZVg3OOwmVRj
         Ip35hDbJDoUgsKBIe+s380J9xYGYg4gQro0IpPyiS4CO3QdJTGj/NxCVS+o6A2ypA5C5
         ZZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752834841; x=1753439641;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2qBzQmRBIh3BDUW1vW6d6WLsqLJRkox9K+h2IOJ36Pw=;
        b=LRFbu/tAbrlyAMTLZ+bNHggCUGarM8zEp02lTAYl1bMpj6siG3tf8fMRGMldf+Ynft
         LgukpbFKMz8nVgo9iR3mMK+YvpzZOxsK1bpOstHoFsksxVy9E80IsPJ5/VSP8nxN1l3s
         qIVQpuRl9duzy0pQYOsR+j+obs3ZI1hk0FSHW8X9Z4zGVvCWTX6h8jgRKarFPWgsOK9/
         QmnuYP0oOwOoFsC1UjRHBGeOfZNiQkwHvXv1L+3t1YSIO7a8RRWLJqpqMXLEhQkVW+Yq
         Q5Y6EFZrIHG4cDr8bnXhFi3yboiEnw/fWeohx8VVZDD6OD981iRhY0pBQ5r4lxXrnH+4
         vzqA==
X-Forwarded-Encrypted: i=1; AJvYcCVxYLJdo+g61w5BGt9wlVX6gd5vaFVJi3XvhfXf2xY8N9yrFBxu1vq5MLi24WbUOb+YmO054kKygCF5nPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGQITZ2ZbCWEWdE4PjbLLKvLoK1TZEs9/wauspSdZT/5xm2CZ2
	QWTa+koAbylxsnOnsAq2uxt50JZkZKB7HBy0NphNqN7LFvS48FOH8MTtSWu1LtfmBBhRvBTdQyA
	rn8lEJBuzWsYJW4xSly+gyrQMIq9a5x0kwReaYr8=
X-Gm-Gg: ASbGncs/bz+FlhxZXyISXhBtjJx2M3Bv6ugHnwWhSzmjsFXKHdnMHsHKX2o39CubN1W
	F/mjiZigCUUqOo9NxSbCAmysAgrLF5genxGXwDjdcu37+CjmJBJ23VQ7JkrsXJnF81myBpmy7Bk
	f3p2fCU2UGpLSKLrqpmdinRR4YFAdTcxnAfRJ10Hhf2CnKB48SZnYMs+7Z4HT7NfOLtoc9UYnYq
	glTBQ==
X-Google-Smtp-Source: AGHT+IG2UzroybGbjxMAlDl+usjSPFuJ7OORDuvOW1+VPzbf93etkJSI7Wt8vOuBB4n18PT3HeNRfnA/8mQpbZ7TJ1A=
X-Received: by 2002:a17:907:3e9c:b0:ae3:c968:370 with SMTP id
 a640c23a62f3a-ae9ce1e8c11mr801676266b.59.1752834841039; Fri, 18 Jul 2025
 03:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 18 Jul 2025 20:33:49 +1000
X-Gm-Features: Ac12FXxPoz0a_9s4aNvXMBUDtxzj332uUJx2lcLhSuVeOysV_Ak0Yc-0WKNLnIg
Message-ID: <CAPM=9tzJPpV89V934YdOO=i1gEVwx9NOMV+w8+hqRgDLk+6L+A@mail.gmail.com>
Subject: [git pull] drm fixes for 6.16-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Thanks to Simona for taking over the fixes duties last week, it seems
like I missed a fun week of regression hunting!

Seems like a quiet enough week, xe/amdgpu being the usual suspects,
then mediatek with a few fixes, and otherwise just misc other bits.

Dave.

drm-fixes-2025-07-18-1:
drm fixes for 6.16-rc7

dp:
- aux dpcd address fix

xe:
- SR-IOV fixes for GT reset and TLB invalidation
- Fix memory copy direction during migration
- Fix alignment check on migration
- Fix MOCS and page fault init order to correctly
  account for topology

amdgpu:
- Fix a DC memory leak
- DCN 4.0.1 degamma LUT fix
- Fix reset counter handling for soft recovery
- GC 8 fix

radeon:
- Drop console locks when suspending/resuming

nouveau:
- ioctl validation fix

panfrost:
- scheduler bug fix

mediatek:
- Add wait_event_timeout when disabling plane
- only announce AFBC if really supported
- mtk_dpi: Reorder output formats on MT8195/88
The following changes since commit 347e9f5043c89695b01e66b3ed111755afcf1911:

  Linux 6.16-rc6 (2025-07-13 14:25:58 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-07-18-1

for you to fetch changes up to 4d33ed640ffc06734271cebda5ac2e3b5a79f453:

  Merge tag 'drm-xe-fixes-2025-07-17' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2025-07-18 14:04:06 +1000)

----------------------------------------------------------------
drm fixes for 6.16-rc7

dp:
- aux dpcd address fix

xe:
- SR-IOV fixes for GT reset and TLB invalidation
- Fix memory copy direction during migration
- Fix alignment check on migration
- Fix MOCS and page fault init order to correctly
  account for topology

amdgpu:
- Fix a DC memory leak
- DCN 4.0.1 degamma LUT fix
- Fix reset counter handling for soft recovery
- GC 8 fix

radeon:
- Drop console locks when suspending/resuming

nouveau:
- ioctl validation fix

panfrost:
- scheduler bug fix

mediatek:
- Add wait_event_timeout when disabling plane
- only announce AFBC if really supported
- mtk_dpi: Reorder output formats on MT8195/88

----------------------------------------------------------------
Arnd Bergmann (1):
      drm/nouveau: check ioctl command codes better

Balasubramani Vivekanandan (1):
      drm/xe/mocs: Initialize MOCS index early

Clayton King (1):
      drm/amd/display: Free memory allocation

Dave Airlie (5):
      Merge tag 'drm-misc-fixes-2025-07-16' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-intel-fixes-2025-07-17' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-6.16-2025-07-17' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'mediatek-drm-fixes-20250718' of
https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux
into drm-fixes
      Merge tag 'drm-xe-fixes-2025-07-17' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

Eeli Haapalainen (1):
      drm/amdgpu/gfx8: reset compute ring wptr on the GPU on resume

Icenowy Zheng (1):
      drm/mediatek: only announce AFBC if really supported

Imre Deak (1):
      drm/dp: Change AUX DPCD probe address from LANE0_1_STATUS to
TRAINING_PATTERN_SET

Jason-JH Lin (1):
      drm/mediatek: Add wait_event_timeout when disabling plane

Lijo Lazar (1):
      drm/amdgpu: Increase reset counter only on success

Louis-Alexis Eyraud (1):
      drm/mediatek: mtk_dpi: Reorder output formats on MT8195/88

Lucas De Marchi (1):
      drm/xe/migrate: Fix alignment check

Matthew Auld (1):
      drm/xe/migrate: fix copy direction in access_memory

Matthew Brost (1):
      drm/xe: Move page fault init after topology init

Melissa Wen (1):
      drm/amd/display: Disable CRTC degamma LUT for DCN401

Michal Wajdeczko (2):
      drm/xe/pf: Prepare to stop SR-IOV support prior GT reset
      drm/xe/pf: Resend PF provisioning after GT reset

Philipp Stanner (1):
      drm/panfrost: Fix scheduler workqueue bug

Tejas Upadhyay (1):
      drm/xe: Dont skip TLB invalidations on VF

Thomas Zimmermann (2):
      drm/radeon: Do not hold console lock while suspending clients
      drm/radeon: Do not hold console lock during resume

 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |  9 ++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |  1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 11 ++++++-
 .../amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c |  3 +-
 drivers/gpu/drm/display/drm_dp_helper.c            |  2 +-
 drivers/gpu/drm/mediatek/mtk_crtc.c                | 36 +++++++++++++++++++++-
 drivers/gpu/drm/mediatek/mtk_crtc.h                |  1 +
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c            |  1 +
 drivers/gpu/drm/mediatek/mtk_ddp_comp.h            |  9 ++++++
 drivers/gpu/drm/mediatek/mtk_disp_drv.h            |  1 +
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c            |  7 +++++
 drivers/gpu/drm/mediatek/mtk_dpi.c                 |  4 +--
 drivers/gpu/drm/mediatek/mtk_plane.c               | 12 ++++++--
 drivers/gpu/drm/mediatek/mtk_plane.h               |  3 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              | 11 +++----
 drivers/gpu/drm/panfrost/panfrost_job.c            |  2 +-
 drivers/gpu/drm/radeon/radeon_device.c             | 23 ++++----------
 drivers/gpu/drm/xe/xe_gt.c                         | 15 +++++----
 drivers/gpu/drm/xe/xe_gt_sriov_pf.c                | 19 ++++++++++++
 drivers/gpu/drm/xe/xe_gt_sriov_pf.h                |  5 +++
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c         | 27 ++++++++++++++++
 drivers/gpu/drm/xe/xe_migrate.c                    |  6 ++--
 drivers/gpu/drm/xe/xe_ring_ops.c                   | 22 ++++++-------
 23 files changed, 174 insertions(+), 56 deletions(-)


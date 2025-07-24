Return-Path: <linux-kernel+bounces-743397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF1EB0FE37
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 02:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9301CC6B30
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F8622097;
	Thu, 24 Jul 2025 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/dL0sm9"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E112CA8
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 00:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753317624; cv=none; b=fq5pnJ2yYucKp3XLoSGIYOjIs0GXicvLIqt+Z9Xq5iECRu0mRCSw/584YZUrbdSDdgMk7RqNfeUavv+0GkANF+ysZ9DnDnFQJUHH3YB35LlRIJkDn/LsiMLXHH43T/KxqBXZAqfFi18Sn2Cfduz25MSv51qJwyaFflc9icWRg2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753317624; c=relaxed/simple;
	bh=mMaDZhTHUbfOChAraBaxg5dZizMHTxQVeXskqQx18Lk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bpk79ne20A8dHvp6XReTfUyqwxSYPx0nNHjqSdH0FsZkxCh9R0WtTGH44aoy2ZJWJtiLJMKT/4glAtF4lX8pEwgUW54Noooe+hGabNID1QvDrsOB0M1C5hs6H+NKiZcuaJvocqsbRsh6UDP72K557flejMd/8WK09cEgRTzQFbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/dL0sm9; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aec46b50f33so63325466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 17:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753317621; x=1753922421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bYY19ksHI4zoByV1B9q9CP9AFpfJQb60S1A3kUxuBpc=;
        b=S/dL0sm90slVG6dVoB10FUDX19kkVHN/4Lsh3u/Jn95Y03IAxLPGUgVkLPs9YuYhXw
         FFKmJ6WCwxebsKN9G1zXEzEd+qzRJe17VNaWKQb+3mx1HPLcRyCn1srC4rW98r6ibyem
         5kYpn6C9CRwhJSIAHR8H8J8zZq0vCXmaXQ3AN5Sh22sc1lLTXla0x9z4NDVBUPo76rHN
         Nr5/Tfv/t2rdGbEFMGcu5WKNruQ1P/sXyP7y42NHZ3oa4jbcM/UneSpBAkKOLaaXGQqO
         3HCSXuEy0Mezp/n2knAF7sNO7WSKUiThyka+WjH4kZCj+gx4SvbtXsOGdpfHfzxoRvIr
         GIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753317621; x=1753922421;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bYY19ksHI4zoByV1B9q9CP9AFpfJQb60S1A3kUxuBpc=;
        b=GFWWu9Gynjaphs5K0b2vCgpLy9uIhdRis+iyqNqSmNZK+tVOz0DllKncdDhgC1XD95
         z0vdWQzRTy4i+wRuakDh1zvkuUJKXTXMBFGE3RIL1uRU7E66ac1Shv/B6Tiy8MrU4qjy
         fw33+Qzwj2WeAu0U+wt2uFbUnX1KR/R/D7zamkfbnj00TSWGO+QC9rGS74LVOwKy811b
         IUwslN0LJvcVTRoFapY8ksTRkgCnUiaE0luXx3qBrm6Vbc1pprWeguHG73//7MNpJUgs
         579IqyKclJw9n1OxsxGMngmnkuOecX8JpJVRNDq/TZClsisXDEPtyYkvX2UnYXziJgJZ
         N65w==
X-Forwarded-Encrypted: i=1; AJvYcCV2AMwDxE8uJVcN5YGMHUrqmKYJMDOP3J5ceFrP0iIF6PDu2/C79IYYH2VuObVNOrSjcuG1HANKEKKuqO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUnIPP4SXvpLfU1ojtKFSWls4GQkHaEewyvliVGoPgyzQ49YiY
	YihbPscpa5mSdWkez2nKip81FpYxf+d9QLlzDmMPy0sNvKJ52O8Bc/xgbXkjr8NXeqa1vG7LQjt
	VuxsVWbRyOQ8p1P2xiWQhGJTWVDyVnGI9pNlvIpo=
X-Gm-Gg: ASbGncsV3Nowk1AmWAau4DHZB+F/8gqIKbdjxaUm0cPZpSNU86vb3yvdyuhQyqmPjHw
	g/UYd/80iwldu3m9NZ9AQ0v6cIPa6ax7fXf1p9Guowxj5nC+L5q/18LjimDKcOty6XAQK2fewhi
	hydNVhmQ5YagCqasQ1lcUXMy/dLeo0zvOwmuBkOu4DGhqze5UriQ4mVxrgAx+F2WIUfvZLbq1wc
	QpRUQ==
X-Google-Smtp-Source: AGHT+IG9y6VkIrO75qO4lo12ZQavYt3nvisHQqeDLTk6ayFcLfJXriUBF6ZrqPRyCZcfGoFOiPLtfxCavUhwKOR9u2o=
X-Received: by 2002:a17:906:f585:b0:ae9:bf1c:50a4 with SMTP id
 a640c23a62f3a-af2f866213bmr485570666b.36.1753317620362; Wed, 23 Jul 2025
 17:40:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 24 Jul 2025 10:40:08 +1000
X-Gm-Features: Ac12FXzbqY7taRY-jUUQcQ_iVcWk0mzydt-j1ETeclZ5kTfsUCaTyBa2i1rwIlI
Message-ID: <CAPM=9twUCJj4X-2jf0VG5+A2YN9Gk8hjOAhJ2hxq4SdgZfvtMA@mail.gmail.com>
Subject: [git pull] drm fixes for 6.16-rc8/final (resend in txt for sure)
To: Linus Torvalds <torvalds@linux-foundation.org>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

(this time for sure, plain text).

Hi Linus,

This might just be part one, but I'm sending it a bit early as it has
two sets of reverts for regressions, one is all the gem/dma-buf
handling and another was a nouveau ioctl change.

Otherwise there is an amdgpu fix, nouveau fix and a scheduler fix.

If any other changes come in I'll follow up with another more usual Fri/Sat MR.

Dave.

drm-fixes-2025-07-24:
drm fixes for 6.16-rc8

gem:
- revert all the dma-buf/gem changes
  as there as lifetime issues with it.

nouveau:
- revert an ioctl change as it causes issues
- fix NULL ptr on fermi

bridge:
- remove extra semicolon

sched:
- remove hang causing optimisation

amdgpu:
- fix garbage in cleared vram after resume
The following changes since commit 89be9a83ccf1f88522317ce02f854f30d6115c41:

  Linux 6.16-rc7 (2025-07-20 15:18:33 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-07-24

for you to fetch changes up to 337666c522b9eca36deabf4133f7b2279155b69f:

  Merge tag 'drm-misc-fixes-2025-07-23' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
(2025-07-24 06:49:38 +1000)

----------------------------------------------------------------
drm fixes for 6.16-rc8

gem:
- revert all the dma-buf/gem changes
  as there as lifetime issues with it.

nouveau:
- revert an ioctl change as it causes issues
- fix NULL ptr on fermi

bridge:
- remove extra semicolon

sched:
- remove hang causing optimisation

amdgpu:
- fix garbage in cleared vram after resume

----------------------------------------------------------------
Arnd Bergmann (1):
      Revert "drm/nouveau: check ioctl command codes better"

Arunpravin Paneer Selvam (1):
      drm/amdgpu: Reset the clear flag in buddy during resume

Ben Skeggs (1):
      drm/nouveau/nvif: fix null ptr deref on pre-fermi boards

Dave Airlie (1):
      Merge tag 'drm-misc-fixes-2025-07-23' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes

Douglas Anderson (1):
      drm/bridge: ti-sn65dsi86: Remove extra semicolon in ti_sn_bridge_probe()

Lin.Cao (1):
      drm/sched: Remove optimization that causes hang when killing
dependent jobs

Thomas Zimmermann (7):
      Revert "drm/virtio: Use dma_buf from GEM object instance"
      Revert "drm/vmwgfx: Use dma_buf from GEM object instance"
      Revert "drm/etnaviv: Use dma_buf from GEM object instance"
      Revert "drm/prime: Use dma_buf from GEM object instance"
      Revert "drm/gem-framebuffer: Use dma_buf from GEM object instance"
      Revert "drm/gem-shmem: Use dma_buf from GEM object instance"
      Revert "drm/gem-dma: Use dma_buf from GEM object instance"

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 17 +++++++++++
 drivers/gpu/drm/bridge/ti-sn65dsi86.c        |  2 +-
 drivers/gpu/drm/drm_buddy.c                  | 43 ++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_gem_dma_helper.c         |  2 +-
 drivers/gpu/drm/drm_gem_framebuffer_helper.c |  8 ++++--
 drivers/gpu/drm/drm_gem_shmem_helper.c       |  4 +--
 drivers/gpu/drm/drm_prime.c                  |  8 +++++-
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c  |  4 +--
 drivers/gpu/drm/nouveau/nouveau_drm.c        | 11 +++----
 drivers/gpu/drm/nouveau/nvif/chan.c          |  3 ++
 drivers/gpu/drm/scheduler/sched_entity.c     | 21 ++------------
 drivers/gpu/drm/virtio/virtgpu_prime.c       |  5 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c          |  6 ++--
 include/drm/drm_buddy.h                      |  2 ++
 16 files changed, 101 insertions(+), 38 deletions(-)


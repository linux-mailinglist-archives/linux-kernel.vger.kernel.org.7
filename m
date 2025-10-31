Return-Path: <linux-kernel+bounces-880966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E4EC27111
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 22:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61AAF4EF30A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 21:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6457E31282D;
	Fri, 31 Oct 2025 21:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gdhsFu4/"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3F331D736
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 21:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761946877; cv=none; b=iifXf7VncRVJ1jlXDeftpggpOXJtUVzwKcj2rFCgvdTRtQFeXG3vxjz/4FLatH+jn9ChegNZ1KrhaYTqwvQc/o9hyO+KsUCTfhfHWK5DrFmw84ANN9wO24WAFAtsBE2g27q1WM6SvB1/l8IUyXYhrqoHLh630KHbfdvJnd57rXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761946877; c=relaxed/simple;
	bh=6MtEmEaJh3nxcX2uMGlgpTluWVWazqTSqDzUGXkNFxI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sfO7qZSyztLyz8xq2OemLydcaWHLkcP/mPFfhwdJAwW1oWIjzmZC/qGvqJJCDAkZZKs4vpww5ALThgrt61eUhqn3zSg4NUWfktDv8hdRmk+IpejE/dF1cEXorTsaZk1IYfTpLJ/8QKCjr0RSOkFETK/y5c8G8ULGDtu2YGYtSPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=gdhsFu4/; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63bea08a326so3993165a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1761946873; x=1762551673; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gC5sTtfAvSyQHR4mobZLPuXmwMYo0V5dj6CktU4oAJw=;
        b=gdhsFu4/L+D3ZpE8zy614XnXc9T2G3SeO+RyBxY4YMbl1Y6Kqq06SAdJ3pIKlKz5sz
         7YAUvsKF5fDZ5KYktLV+VOaR3cr1Q2ATi0rXq6j20mPxQ3AW7CkR+CuLJnl2E1OmKAK+
         m99K5VmOrDrMAjzn24li5QWCiLuM7JkQv//e8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761946873; x=1762551673;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gC5sTtfAvSyQHR4mobZLPuXmwMYo0V5dj6CktU4oAJw=;
        b=wgdN2WkZkJFjGmOt8sKzsBgXc60RXYFa5aX+k21VVWf+awHFd6S4ZtZgJfEOyhAWRw
         Ju1sPl8HM03VsMOiTXzs2lhK9GpNA04io4rZiuQZLCNvBj/WKy3L2BJVQilBKhEZhyJO
         2fQnBdofF4bBj9S5ZV1A5PoG3Mq8RaLwjrv37jzBBfxUYaPDcJbQT8pMp6PSsGx1ZzjC
         BcguG7PUkpg3Zecnw4HD1nOajRiwB6HuOFVwO9a60Cz5TSGUprb6KFETdEJzUVRAWECk
         d2vBrVGHp5xRfMVbOG6FnSLDZY/M/PKux4tFDEMg1KcsHKAknePtCd54/PmloqX2zQpH
         waVw==
X-Forwarded-Encrypted: i=1; AJvYcCVWxyGI5ZjoeR83rNwzyAsjJGDQ3leEp9b6Y2pkrWokvra3juJmgICLUO6DPRRo9OnE8ErsRNYI/6PYxVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGYYIae/VIr9NOHD7MCV5KWg+U+L6hYD/IqoE/YErLQc+rledJ
	SVpVSjmswT68gkBCtcqJZ9FYxkmG57WfwO9MIjI1BdiRttFRq5klyGToaevcybM+Ku4=
X-Gm-Gg: ASbGnctkKwasKJsWAAl48lap7OL3ecL8tI2aoIdRDeFpmb+PG4PRhdJb8HvjBIOMpUY
	VHI2MHTX69SsVSL6nGSSwajtJ26jt+5prMhz9rmNihVcXsK37eiTWY0NxilJQPG2RI2lS6RrSNb
	dZVh3eoC2E8VlzjdWEFCvR3iwegdYXSCtzEYqFLvfw8W/LhUsJ1bC5B6g4zUfntYiDQ+mmuSMko
	gbURhuukKe7l27Ay961AppmQCs9/qFh0rlHTYTDigXwrqE56xaVd5EC9wzFAWUNkAVdlE3XTDkM
	RC734Nvb6sRPjcM+0vkgMFCyRdUolDjolzFsK2ILss7AWMUVkfm6GmlbusFt3C2HiWp5htV9tzP
	pfc/TOG2HQwdbACwpg6kkBs33dyA4THdAyzl3K5/8yr2b18YeqF+U5fbTRuWP76nrh5JQJ42DMB
	A8IT7RYCr8km8eoMGBwRzYIQ==
X-Google-Smtp-Source: AGHT+IEyzhm8HSLGfVjjm5ExA/PArguFWn0TFH9erwh22ZxH4PwQ4aIuGkCuU2k9hsI3Oje3HzALng==
X-Received: by 2002:a05:6402:2102:b0:640:74f5:d9f6 with SMTP id 4fb4d7f45d1cf-6407702086emr4004994a12.25.1761946872952;
        Fri, 31 Oct 2025 14:41:12 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b34a7bbsm2510457a12.7.2025.10.31.14.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 14:41:12 -0700 (PDT)
Date: Fri, 31 Oct 2025 22:41:10 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Dave Airlie <airlied@gmail.com>
Subject: [PULL] drm-fixes for 6.18-rc4
Message-ID: <aQUs9m_M8NbteVhR@phenom.ffwll.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	DRI Development <dri-devel@lists.freedesktop.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Dave Airlie <airlied@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Operating-System: Linux phenom 6.12.38+deb13-amd64 

Hi Linus,

Looks like stochastics conspired to make this one a bit bigger, but
nothing scary at all. Also first examples of the new Link: tags, yay!

Next week Dave should be back.

And yes, the tag is a bit wrong, I was asleep (or well more correctly,
processing some 6.19 -next PRs while this one one was simmering and gotten
confused).  But it's pretty much w/e here already so apologies for not
re-running the script with that typo fixed and nothing else changed.

drm-fixes-2025-10-31:
drm-fixes for 6.19-rc4

Drivers:
- mediatek: uaf in unbind, fixes -rc2 boot regression
- radeon: devm conversion fixes
- amdgpu: VPE idle handler, re-enable DM idle optimization, DCN3, SMU,
  vblank, HDP eDP, powerplay fixes for fiji/iceland
- msm: bunch of gem error path fixes, gmu fw parsing fix, dpu fixes
- intel: fix dmc/dc6 asserts on ADL-S
- xe: fix xe_validation_guard(), wake device handling around gt reset
- ast: fix display output on AST2300
- etnaviv: fix gpu flush
- imx: fix parallel bridge handling
- nouveau: scheduler locking fix
- panel: fixes for kingdisplay-kd097d04 and sitronix-st7789v

Core Changes:

- CI: disable broken sanity job
- sysfb: fix NULL pointer access
- sched: fix SIGKILL handling, locking for race condition
- dma_fence: better timeline name for signalled fences

Cheers, Sima

The following changes since commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa:

  Linux 6.18-rc3 (2025-10-26 15:59:49 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-10-31

for you to fetch changes up to 41dacb39fe79cd2fce42d31fa6658d926489a548:

  Merge tag 'drm-xe-fixes-2025-10-30' of https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes (2025-10-31 19:11:16 +0100)

----------------------------------------------------------------
drm-fixes for 6.19-rc4

Drivers:
- mediatek: uaf in unbind, fixes -rc2 boot regression
- radeon: devm conversion fixes
- amdgpu: VPE idle handler, re-enable DM idle optimization, DCN3, SMU,
  vblank, HDP eDP, powerplay fixes for fiji/iceland
- msm: bunch of gem error path fixes, gmu fw parsing fix, dpu fixes
- intel: fix dmc/dc6 asserts on ADL-S
- xe: fix xe_validation_guard(), wake device handling around gt reset
- ast: fix display output on AST2300
- etnaviv: fix gpu flush
- imx: fix parallel bridge handling
- nouveau: scheduler locking fix
- panel: fixes for kingdisplay-kd097d04 and sitronix-st7789v

Core Changes:

- CI: disable broken sanity job
- sysfb: fix NULL pointer access
- sched: fix SIGKILL handling, locking for race condition
- dma_fence: better timeline name for signalled fences

----------------------------------------------------------------
Akash Goel (1):
      dma-fence: Fix safe access wrapper to call timeline name method

Akhil P Oommen (1):
      drm/msm/a6xx: Fix GMU firmware parser

Alex Deucher (4):
      drm/amdgpu: fix SPDX headers on amdgpu_cper.c/h
      drm/amdgpu: fix SPDX header on amd_cper.h
      drm/amdgpu: fix SPDX header on irqsrcs_vcn_5_0.h
      drm/amdgpu: fix SPDX header on cyan_skillfish_reg_init.c

Alex Hung (1):
      drm/amd/display: Add HDR workaround for a specific eDP

Anna Maniscalco (1):
      drm/msm: make sure last_fence is always updated

Daniel Palmer (2):
      drm/radeon: Do not kfree() devres managed rdev
      drm/radeon: Remove calls to drm_put_dev()

David Rosca (1):
      drm/sched: avoid killing parent entity on child SIGKILL

Ivan Lipski (1):
      drm/amd/display: Fix incorrect return of vblank enable on unconfigured crtc

Jessica Zhang (1):
      drm/msm/dpu: Fix adjusted mode clock check for 3d merge

Johan Hovold (1):
      drm/mediatek: Fix device use-after-free on unbind

John Smith (2):
      drm/amd/pm/powerplay/smumgr: Fix PCIeBootLinkLevel value on Fiji
      drm/amd/pm/powerplay/smumgr: Fix PCIeBootLinkLevel value on Iceland

Kenneth Feng (1):
      drm/amd/display: pause the workload setting in dm

Luca Ceresoli (2):
      drm/imx: parallel-display: convert to devm_drm_bridge_alloc() API
      drm/imx: parallel-display: add the bridge before attaching it

Mario Limonciello (1):
      drm/amd: Check that VPE has reached DPM0 in idle handler

Matthew Brost (1):
      drm/xe: Do not wake device during a GT reset

Matthew Schwartz (1):
      drm/amd/display: Don't program BLNDGAM_MEM_PWR_FORCE when CM low-power is disabled on DCN30

Neil Armstrong (1):
      drm/msm: dsi: fix PLL init in bonded mode

Philipp Stanner (2):
      drm/sched: Fix race in drm_sched_entity_select_rq()
      drm/nouveau: Fix race in nouveau_sched_fini()

Rob Clark (4):
      drm/msm: Fix GEM free for imported dma-bufs
      drm/msm: Fix pgtable prealloc error path
      drm/msm: Reject MAP_NULL op if no PRR
      drm/msm: Ensure vm is created in VM_BIND ioctl

Sebastian Fleer (1):
      drm/panel: kingdisplay-kd097d04: Disable EoTp

Sebastian Reichel (1):
      drm/panel: sitronix-st7789v: fix sync flags for t28cp45tn89

Simona Vetter (6):
      Merge tag 'mediatek-drm-fixes-20251028' of https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux into drm-fixes
      Merge tag 'amd-drm-fixes-6.18-2025-10-29' of https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-msm-fixes-2025-10-29' of https://gitlab.freedesktop.org/drm/msm into drm-fixes
      Merge tag 'drm-intel-fixes-2025-10-30' of https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2025-10-30' of https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2025-10-30' of https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

Thomas Hellström (1):
      drm/xe: Fix uninitialized return value from xe_validation_guard()

Thomas Zimmermann (2):
      drm/sysfb: Do not dereference NULL pointer in plane reset
      drm/ast: Clear preserved bits from register output value

Tomeu Vizoso (1):
      drm/etnaviv: fix flush sequence logic

Vignesh Raman (1):
      drm/ci: disable broken MR check in sanity job

Ville Syrjälä (1):
      drm/i915/dmc: Clear HRR EVT_CTL/HTP to zero on ADL-S

Vladimir Lypak (6):
      drm/msm/dpu: Fix allocation of RGB SSPPs without scaling
      drm/msm/dpu: Propagate error from dpu_assign_plane_resources
      drm/msm/dpu: Disable scaling for unsupported scaler types
      drm/msm/dpu: Fix pixel extension sub-sampling
      drm/msm/dpu: Require linear modifier for writeback framebuffers
      drm/msm/dpu: Disable broken YUV on QSEED2 hardware

Yang Wang (1):
      drm/amd/pm: fix smu table id bound check issue in smu_cmn_update_table()

 drivers/dma-buf/dma-fence.c                        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c            | 34 +++++++++++--
 .../gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c   |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 21 +++++++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  1 +
 .../gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c   |  3 --
 drivers/gpu/drm/amd/include/amd_cper.h             |  2 +-
 .../drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_5_0.h  |  2 +-
 .../gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c  |  2 +-
 .../drm/amd/pm/powerplay/smumgr/iceland_smumgr.c   |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |  2 +-
 drivers/gpu/drm/ast/ast_drv.h                      |  8 ++--
 drivers/gpu/drm/ci/gitlab-ci.yml                   |  2 +-
 drivers/gpu/drm/drm_gem_atomic_helper.c            |  8 +++-
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c           |  2 +-
 drivers/gpu/drm/i915/display/intel_dmc.c           | 55 +++++++++++++++++++++-
 drivers/gpu/drm/imx/ipuv3/parallel-display.c       | 18 +++----
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             | 10 ----
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |  5 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |  7 ---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |  3 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          | 14 +++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c             |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c      |  3 ++
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h              |  1 -
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c          | 18 +------
 drivers/gpu/drm/msm/msm_gem.c                      | 10 ++--
 drivers/gpu/drm/msm/msm_gem_submit.c               |  9 ++--
 drivers/gpu/drm/msm/msm_gem_vma.c                  |  8 +++-
 drivers/gpu/drm/msm/msm_gpu.h                      | 11 +++++
 drivers/gpu/drm/msm/msm_iommu.c                    |  5 ++
 drivers/gpu/drm/nouveau/nouveau_sched.c            | 14 +++++-
 drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c |  2 +-
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c     |  7 ++-
 drivers/gpu/drm/radeon/radeon_drv.c                | 25 ++--------
 drivers/gpu/drm/radeon/radeon_kms.c                |  1 -
 drivers/gpu/drm/scheduler/sched_entity.c           |  6 ++-
 drivers/gpu/drm/xe/xe_gt.c                         | 19 +++++---
 drivers/gpu/drm/xe/xe_validation.h                 |  8 ++--
 42 files changed, 234 insertions(+), 128 deletions(-)

-- 
Simona Vetter
Software Engineer
http://blog.ffwll.ch


Return-Path: <linux-kernel+bounces-857365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27576BE6A73
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0266628117
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15BB30FC3F;
	Fri, 17 Oct 2025 06:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSLkVvsp"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B0830F7F5
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681697; cv=none; b=izBDb5qG80JniouT6LV/+191mCLPRCYZYeN0ka9fSaY/ZooqNDP7xT8HuIUbQeX/ryGL4Hv1H/Y/vPmU144C8SvBi6jq7UL+mD5bgS0xwZeEUN0flFZx7grAh2IP+xXt9Ltfnr8ltE8e9gnpCMIrpgm/oKuD2HQJW3WoQ6Epsl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681697; c=relaxed/simple;
	bh=nAXbuGUbF5/3V17OdO9AY2jgJOIq5emE5S7RRJ+nPYQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iHpbX9ngyBcXHwf9j4jkffcA/AbtR25xB4ndo3nB2mGUpyaZrE6qpr2d9ujjfvnEU640w8EmAuNlLJU6LgaPauuqFjdAmooUidxcP39NlTZ5LPENC2pgfOCD5c+HP8ZYbAghsnQBCoQRtemAKkEhSHLAz2htH2gmSe66/RdRrrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSLkVvsp; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-79599d65f75so20189746d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760681694; x=1761286494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A3XeTmm9S0/KH1ozCT5gCMzWfpKyleaB4bZi5LBr8ZU=;
        b=FSLkVvspA1B/R3/35jG85UMhj/rNwKcprf1TxBkFLPuRmtv737jbt04YdYlVEMVKaZ
         EIePWhy+lYnAu13mOADMaDG5NI/9RqDJDPmKGv4CTSydHZrt6K9dNi1wY6IJQYjz58tC
         h6m3/5ham6DXvWAuUGHCX6IrGTE/lm9TAyOHW4v+dgnhUodnUdfqvZC0A4MLscepr3EQ
         78LMasyGz1WvpAty8zhOx39Me/eGyu7is8K6aSLK75Q1CNnhIp5CVdFaCOXsvPGLM6Od
         +XCnpg0+fd389poc2555DWq2U9XmCDLihpld1hI36uBK3QTjW7/aRCqNAyDa+Kn5ULfm
         X0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760681694; x=1761286494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3XeTmm9S0/KH1ozCT5gCMzWfpKyleaB4bZi5LBr8ZU=;
        b=YPbykT8aWv4Y3vUHxQPV4nUNViDmPPYT8FtGno/tEx6SrBYxZvr5IeVwf5z96YMpQ0
         W5szGnzU5PWHEMmp8eeHf8shAOZ+7lbPIw7EVa9Dyw+R13mQh/GOKClYKkLYk8xKXY04
         Ibs4/8ZpGoGYcNg+LQ2SHQgBTG52N07UelWZ7zqya8EG+14m7N4acDAUhM5wmGGEpSMk
         JlNsgalImDDJS1I5zX9Id1P2RQin53bvTCSmQdJdXasewwb2q7Evap3eiXZUQqDU29bo
         gwbjrwVmwoiqCkpWwj56yI8WkvMhUJ73dxK8aRqjGZ18l42dXSgTbmIXH6eDJGl24BF6
         Be0g==
X-Forwarded-Encrypted: i=1; AJvYcCWxeHKWDz/jc57WIYB1uh7IB8/tjoIKrZ9tHIr588YtgRTkecf54ZOtQtjlGBQVoozoz/MXn3B1OlOV0ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEvyLQitX7tNRHITWNqlEQryYePnD/kqhN8xcCwRVLRCE+F+k6
	zvTy4OPA7VnjK31e2isjYu5kpy0YSOsVpHFqTxncoimzfzT+cu3Pgl2nqcQjoBfgQgAfW1f7XoU
	M8JP5VUeer/w9Kc6+P7rz+VndFqZ10ZI/EJ/A
X-Gm-Gg: ASbGncuOdyODpOMT7cr9yBvxUCsixUsdqgc8Ntf1oXAdmd7+kcvyMsdzwWLJZujMFN3
	A5l62Hvp5GI+l4ISG2/mF9Edb2hEqhEC2f7XZAjo3NiAnvs4N4ihcOXH2GWkjE1VB/Mzb3kEq5l
	gIcAtcTe683Uw8b4mh/WuUPCGMR3cxjW1V7JExDopImaaflKntXTNXJlRGXrO8g2SslKuVoqByL
	ByWQ2FLjwtNR96kRMfoisICNhfKqAwGulYLz1r+USnaGxylrsAohHUUmZI=
X-Google-Smtp-Source: AGHT+IEQsufXcIx8Krs6nP/lweJKZeyCsP6WTIz8ZCU++sdGoxXhbDi9ma9j6dV978PF9tqViOzUusF/jmxozJN37yw=
X-Received: by 2002:a05:6214:e6e:b0:87c:277f:8d38 with SMTP id
 6a1803df08f44-87c277f8e56mr6327566d6.50.1760681694520; Thu, 16 Oct 2025
 23:14:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 17 Oct 2025 16:14:43 +1000
X-Gm-Features: AS18NWDKSxGl43IaXOFEF1uKosllUK22aaCX2nC5QmqShyKH7WAlzAyiwm_9teQ
Message-ID: <CAPM=9ty=C+PAgZD44Y_LkUuKkRtLFGffjX9rZX8=fkP0s-8zSg@mail.gmail.com>
Subject: [git pull] drm fixes for 6.18-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Linus,

Weekly pull request, fixes for rc2. As per usual xe/amdgpu are the
leaders, with some i915 and then a bunch of scattered fixes. There are
a bunch of stability fixes for some older amdgpu cards, but older than
yours.

Otherwise, I'm travelling from the middle of next week for the next
two weekends at least, so Sima has offered to take over fixes for the
next couple of weeks, I'll be around email at some point if anything
comes up, but otherwise not much use.

Dave.

drm-fixes-2025-10-17:
drm fixes for 6.18-rc2

draw:
- Avoid color truncation

gpuvm:
- Avoid kernel-doc warning

sched:
- Avoid double free

i915:
- Skip GuC communication warning if reset is in progress
- Couple frontbuffer related fixes
- Deactivate PSR only on LNL and when selective fetch enabled

xe:
- Increase global invalidation timeout to handle some workloads
- Fix NPD while evicting BOs in an array of VM binds
- Fix resizable BAR to account for possibly needing to move BARs other
  than the LMEMBAR
- Fix error handling in xe_migrate_init()
- Fix atomic fault handling with mixed mappings or if the page is
  already in VRAM
- Enable media samplers power gating for platforms before Xe2
- Fix de-registering exec queue from GuC when unbinding
- Ensure data migration to system if indicated by madvise with SVM
- Fix kerneldoc for kunit change
- Always account for cacheline alignment on migration
- Drop bogus assertion on eviction

amdgpu:
- Backlight fix
- SI fixes
- CIK fix
- Make CE support debug only
- IP discovery fix
- Ring reset fixes
- GPUVM fault memory barrier fix
- Drop unused structures in amdgpu_drm.h
- JPEG debugfs fix
- VRAM handling fixes for GPUs without VRAM
- GC 12 MES fixes

amdkfd:
- MES fix

ast:
- Fix display output after reboot

bridge:
- lt9211: Fix version check

panthor:
- Fix MCU suspend

qaic:
- Init bootlog in correct order
- Treat remaining =3D=3D 0 as error in find_and_map_user_pages()
- Lock access to DBC request queue

rockchip:
- vop2: Fix destination size in atomic check
The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787=
:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-10-17

for you to fetch changes up to 62cab426d0e340cd38893227c279705cc9e8416a:

  Merge tag 'drm-xe-fixes-2025-10-16' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2025-10-17 09:39:53 +1000)

----------------------------------------------------------------
drm fixes for 6.18-rc2

draw:
- Avoid color truncation

gpuvm:
- Avoid kernel-doc warning

sched:
- Avoid double free

i915:
- Skip GuC communication warning if reset is in progress
- Couple frontbuffer related fixes
- Deactivate PSR only on LNL and when selective fetch enabled

xe:
- Increase global invalidation timeout to handle some workloads
- Fix NPD while evicting BOs in an array of VM binds
- Fix resizable BAR to account for possibly needing to move BARs other
  than the LMEMBAR
- Fix error handling in xe_migrate_init()
- Fix atomic fault handling with mixed mappings or if the page is
  already in VRAM
- Enable media samplers power gating for platforms before Xe2
- Fix de-registering exec queue from GuC when unbinding
- Ensure data migration to system if indicated by madvise with SVM
- Fix kerneldoc for kunit change
- Always account for cacheline alignment on migration
- Drop bogus assertion on eviction

amdgpu:
- Backlight fix
- SI fixes
- CIK fix
- Make CE support debug only
- IP discovery fix
- Ring reset fixes
- GPUVM fault memory barrier fix
- Drop unused structures in amdgpu_drm.h
- JPEG debugfs fix
- VRAM handling fixes for GPUs without VRAM
- GC 12 MES fixes

amdkfd:
- MES fix

ast:
- Fix display output after reboot

bridge:
- lt9211: Fix version check

panthor:
- Fix MCU suspend

qaic:
- Init bootlog in correct order
- Treat remaining =3D=3D 0 as error in find_and_map_user_pages()
- Lock access to DBC request queue

rockchip:
- vop2: Fix destination size in atomic check

----------------------------------------------------------------
Alex Deucher (4):
      drm/amdgpu: fix handling of harvesting for ip_discovery firmware
      drm/amdgpu: handle wrap around in reemit handling
      drm/amdgpu: set an error on all fences from a bad context
      drm/amdgpu: drop unused structures in amdgpu_drm.h

Alok Tiwari (1):
      drm/rockchip: vop2: use correct destination rectangle height check

Ankan Biswas (1):
      drm/gpuvm: Fix kernel-doc warning for drm_gpuvm_map_req.map

Christian K=C3=B6nig (3):
      drm/amdgpu: remove two invalid BUG_ON()s
      drm/amdgpu: block CE CS if not explicitely allowed by module option
      drm/amdgpu: hide VRAM sysfs attributes on GPUs without VRAM

Dave Airlie (4):
      Merge tag 'drm-intel-fixes-2025-10-16' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-6.18-2025-10-16' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2025-10-16' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2025-10-16' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

Francesco Valla (1):
      drm/draw: fix color truncation in drm_draw_fill24

Gui-Dong Han (1):
      drm/amdgpu: use atomic functions with memory barriers for vm fault in=
fo

Jeff Hugo (1):
      accel/qaic: Fix bootlog initialization ordering

Jesse.Zhang (1):
      drm/amdgpu: Fix NULL pointer dereference in VRAM logic for APU device=
s

Jonathan Kim (5):
      drm/amdgpu: fix gfx12 mes packet status return check
      drm/amdgpu: fix initialization of doorbell array for detect and hang
      drm/amdgpu: fix hung reset queue array memory allocation
      drm/amdgpu: enable suspend/resume all for gfx 12
      drm/amdkfd: fix suspend/resume all calls in mes based eviction path

Jouni H=C3=B6gander (1):
      drm/i915/psr: Deactivate PSR only on LNL and when selective fetch ena=
bled

Kenneth Graunke (1):
      drm/xe: Increase global invalidation timeout to 1000us

Ketil Johnsen (1):
      drm/panthor: Ensure MCU is disabled on suspend

Lucas De Marchi (1):
      drm/xe: Move rebar to be done earlier

Marek Vasut (1):
      drm/bridge: lt9211: Drop check for last nibble of version register

Matt Roper (1):
      drm/xe/kunit: Fix kerneldoc for parameterized tests

Matthew Auld (2):
      drm/xe/migrate: don't misalign current bytes
      drm/xe/evict: drop bogus assert

Matthew Brost (2):
      drm/xe: Don't allow evicting of BOs in same VM in array of VM binds
      drm/xe: Handle mixed mappings and existing VRAM on atomic faults

Matthew Schwartz (1):
      Revert "drm/amd/display: Only restore backlight after
amdgpu_dm_init or dm_resume"

Pranjal Ramajor Asha Kanojiya (1):
      accel/qaic: Synchronize access to DBC request queue head & tail point=
er

Sathishkumar S (1):
      drm/amdgpu: fix bit shift logic

Shuicheng Lin (1):
      drm/xe/guc: Check GuC running state before deregistering exec queue

Thomas Hellstr=C3=B6m (2):
      drm/xe/migrate: Fix an error path
      drm/xe/svm: Ensure data will be migrated to system if indicated
by madvise.

Thomas Zimmermann (2):
      Merge drm/drm-fixes into drm-misc-fixes
      drm/ast: Blank with VGACR17 sync enable, always clear VGACRB6 sync of=
f

Timur Krist=C3=B3f (3):
      drm/amd/pm: Disable MCLK switching on SI at high pixel clocks
      drm/amd: Disable ASPM on SI
      drm/amd/powerplay: Fix CIK shutdown temperature

Tvrtko Ursulin (1):
      drm/sched: Fix potential double free in
drm_sched_job_add_resv_dependencies

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915/frontbuffer: Move bo refcounting
intel_frontbuffer_{get,release}()
      drm/i915/fb: Fix the set_tiling vs. addfb race, again

Vinay Belgaumkar (1):
      drm/xe: Enable media sampler power gating

Youssef Samir (1):
      accel/qaic: Treat remaining =3D=3D 0 as error in find_and_map_user_pa=
ges()

Zhanjun Dong (1):
      drm/i915/guc: Skip communication warning on reset in progress

 drivers/accel/qaic/qaic.h                          |  2 +
 drivers/accel/qaic/qaic_control.c                  |  2 +-
 drivers/accel/qaic/qaic_data.c                     | 12 +++-
 drivers/accel/qaic/qaic_debugfs.c                  |  5 +-
 drivers/accel/qaic/qaic_drv.c                      |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  8 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  7 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      | 18 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  8 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          | 54 +++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |  7 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            | 20 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c       |  3 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |  2 -
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |  2 -
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |  7 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |  7 +--
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |  6 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |  8 ++-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c             | 15 +++--
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 73 +++++++-----------=
----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 12 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  7 ---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         |  5 ++
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |  3 +-
 drivers/gpu/drm/ast/ast_mode.c                     | 18 +++---
 drivers/gpu/drm/ast/ast_reg.h                      |  1 +
 drivers/gpu/drm/bridge/lontium-lt9211.c            |  3 +-
 drivers/gpu/drm/drm_draw.c                         |  2 +-
 drivers/gpu/drm/drm_draw_internal.h                |  2 +-
 drivers/gpu/drm/i915/display/intel_fb.c            | 38 +++++------
 drivers/gpu/drm/i915/display/intel_frontbuffer.c   | 10 ++-
 drivers/gpu/drm/i915/display/intel_psr.c           | 12 +++-
 .../gpu/drm/i915/gem/i915_gem_object_frontbuffer.h |  2 -
 drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c          |  9 ++-
 drivers/gpu/drm/panthor/panthor_fw.c               |  1 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       |  2 +-
 drivers/gpu/drm/scheduler/sched_main.c             | 13 ++--
 drivers/gpu/drm/xe/regs/xe_gt_regs.h               |  1 +
 drivers/gpu/drm/xe/tests/xe_pci.c                  |  5 ++
 drivers/gpu/drm/xe/xe_bo_evict.c                   |  8 ---
 drivers/gpu/drm/xe/xe_device.c                     |  2 +-
 drivers/gpu/drm/xe/xe_gt_idle.c                    |  8 +++
 drivers/gpu/drm/xe/xe_guc_submit.c                 | 13 +++-
 drivers/gpu/drm/xe/xe_migrate.c                    |  6 +-
 drivers/gpu/drm/xe/xe_pci.c                        |  2 +
 drivers/gpu/drm/xe/xe_svm.c                        | 17 ++++-
 drivers/gpu/drm/xe/xe_vm.c                         | 32 +++++++---
 drivers/gpu/drm/xe/xe_vm_types.h                   |  1 +
 drivers/gpu/drm/xe/xe_vram.c                       | 34 +++++++---
 drivers/gpu/drm/xe/xe_vram.h                       |  1 +
 include/drm/drm_gpuvm.h                            |  2 +-
 include/uapi/drm/amdgpu_drm.h                      | 21 -------
 60 files changed, 355 insertions(+), 224 deletions(-)


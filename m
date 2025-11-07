Return-Path: <linux-kernel+bounces-891087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDE0C41CBE
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 23:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1361895D0E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 22:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5443128AC;
	Fri,  7 Nov 2025 22:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiUzXAqf"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235E623D28F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 22:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762553333; cv=none; b=cGw/1Y/wI1P+oW6QNVwTN/qButoDMsyLJoZd0DbmhaWZ47lmJ4MvC1wktK931hxbOg7fVIVkUehpYw7KM1CZqkk0Xyaj9g4zCT8yMN4yRNz7L5l2mZercfIgqGdBWeIDL+h1yAEvDNYrQcjevOjphMtxFa9U/Wj32jj133BtcNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762553333; c=relaxed/simple;
	bh=nZ2jht07mNFzKmliY4am8bNln2BWzyLaTfPcNWOb/fQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ud6AGSvcvg8XPWnpcyPGYyFFfHD2no82cJf/NZMXuPlyAc46gpMNl/JPAn+K4LIoAnv8O6m9bZZEECxPAkQPpvX7o/4Z7qC6tKZQBEtio43MEGyWXWrVtOWY1IFUIFSCi6n1ycHib/mK+OTsZzGfkXcYxIc1ORDkGsRAyfx92cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiUzXAqf; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b23b68a41bso121685685a.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 14:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762553331; x=1763158131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=01pzKBDiqVli+bpe2zFIkuZQy1Np00Dk6ZGYQl/DblI=;
        b=HiUzXAqfE7lyp3ffuaZeJRnWv916E5B9PZKjDimbdbTqcVF1WyT2CF0YVI7kJEeW6d
         BLq33UgMtJVfDixp5vHW0YgXx9BQIgeWCJRpC5e72KMcZJS3dyPXRv26laHJcLY+r/We
         SO00AppK9MDqZ9+9y6JdR/jdgbyed/9hlo5YOsb/OzTAxr1GP8LPuU7oVEZ87VqYyZRN
         yBzx9n7otu+EecnstUvgyubfwyeHQv70avy8fqbGn+ceHaHPuF6g7DnkKn3CYQFIbrCS
         dz0h2J1EvLbQ18Dn7II9/o8vEHdklfKm1QgAlin2I3hZFi5erEN2flaHp40JNV6dy3tj
         +QUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762553331; x=1763158131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01pzKBDiqVli+bpe2zFIkuZQy1Np00Dk6ZGYQl/DblI=;
        b=o05erqBDNA1YsilJ+IKIY33tuiS0Zksaz/oLMAefyNQkvdkG9rnEDcn/bflqPlt9is
         28DFEQrqiFWqrFv60JQf8xpKCqcly4lirO6tbjStuK5F67Lxa1SSKtMom8lQcXjdGUcj
         JmLQAKR/WCZ+ryzLV9QsCBVEZY9hoq8YcacDdwjdeiYyuVkj9ziguHFdSH1qlIAkrkCO
         QQLE+dQag4JhsbJt+dB1wz9ikaL6giDRIg6iAvUO5QHZEGxq6lDt6ATdsE5mBuq0Z5cI
         aFnVaB3NgUxV+gaEXpfU3zfQeDSGN/6asKicF+KXiSmahd5Q4pzl1i9FlM8VSzxAnKQh
         zr0g==
X-Forwarded-Encrypted: i=1; AJvYcCU10Uz/iDB/zBk8WNgjmUZxk3++sUGdsGNTZJ7+euAL6zm67HBhIbAs01zEZ5OYoKNDIRTWuHrlVc6nOuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyveMuaO34zf/FRe8TMjIfZaRC4AnKDHxV75ohftFO8qdBk9OUz
	AiojZfXVqA26eeuxkBREG/uU6w5OgoT3X8fl+OKsAwBOKAY8Cohwg2K+f0CtSNFBdXi+9duasLf
	0zJBoFxj8UfBcaZQr9CraxCw529SGQIr6223s
X-Gm-Gg: ASbGncvRzGhmBEjEmPwUMExmHnBkKxNwJ8PvD/BKZ+MYHeDvwmDpZ/GU5315IIisf5n
	nVHLA1Nc18J2L02eih6tT9udQ4cAxVCoR4q7x6Lipn4Fw6+aVtRuojjpJSpR2q1gw7gy7XqQj/Y
	uA/C53wS/L/yujvnCyzOyYY7eUZb7PiQ29n5lcTbGceK4v5egHQqT6pSezBijIWAvyoVca68rpc
	TF2c62mfkmkQA4JDCva8lHOilJLs84OWBfBlxsragD4J4gfOXv6zx9CTww=
X-Google-Smtp-Source: AGHT+IEzYzQmeeVeXDG23zQ8MrHHuuq9MmLbSEPhthEbo253f2i4Kiwi3LynISbfiO+JjVeQ9BYuT079AAcp4oQ90jg=
X-Received: by 2002:a05:620a:294d:b0:8b2:2800:d646 with SMTP id
 af79cd13be357-8b257f87105mr115152485a.88.1762553330861; Fri, 07 Nov 2025
 14:08:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 8 Nov 2025 08:08:39 +1000
X-Gm-Features: AWmQ_bl4fJKuoszi5FUAbI1Tcjc2zge1wQUwnNCNCt8rT_VZHdC889N-xr6DgjA
Message-ID: <CAPM=9tx60Q0o7v1hK-GJ_iKs7J0dVgQENM44T=gM_KWZXoA4YA@mail.gmail.com>
Subject: [git pull] drm fixes for 6.18-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Back from travel, thanks to Simona for handling things. regular fixes,
seems about the right size, but spread out a bit.

amdgpu has the usual range of fixes, xe has a few fixes, and nouveau
has a couple of fixes, one for blackwell modifiers on 8/16 bit
surfaces.

Otherwise a few small fixes for mediatek, sched, imagination and pixpaper.

Dave.

drm-fixes-2025-11-08:
drm fixes for 6.18-rc5

sched:
- Fix deadlock

amdgpu:
- Reset fixes
- Misc fixes
- Panel scaling fixes
- HDMI fix
- S0ix fixes
- Hibernation fix
- Secure display fix
- Suspend fix
- MST fix

amdkfd:
- Process cleanup fix

xe:
- Fix missing  synchronization on unbind
- Fix device shutdown when doing FLR
- Fix user fence signaling order

i915:
- Avoid lock inversion when pinning to GGTT on CHV/BXT+VTD
- Fix conversion between clock ticks and nanoseconds

mediatek:
- Disable AFBC support on Mediatek DRM driver
- Add pm_runtime support for GCE power control

imagination:
- kconfig: Fix dependencies

nouveau:
- Set DMA mask earlier
- Advertize correct modifiers for GB20x

pixpaper:
- kconfig: Fix dependencies
The following changes since commit 6146a0f1dfae5d37442a9ddcba012add260bceb0=
:

  Linux 6.18-rc4 (2025-11-02 11:28:02 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-11-08

for you to fetch changes up to d439acbbfb9a982f152c5f806b4592431a80c4fd:

  Merge tag 'drm-xe-fixes-2025-11-07' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2025-11-08 07:39:54 +1000)

----------------------------------------------------------------
drm fixes for 6.18-rc5

sched:
- Fix deadlock

amdgpu:
- Reset fixes
- Misc fixes
- Panel scaling fixes
- HDMI fix
- S0ix fixes
- Hibernation fix
- Secure display fix
- Suspend fix
- MST fix

amdkfd:
- Process cleanup fix

xe:
- Fix missing  synchronization on unbind
- Fix device shutdown when doing FLR
- Fix user fence signaling order

i915:
- Avoid lock inversion when pinning to GGTT on CHV/BXT+VTD
- Fix conversion between clock ticks and nanoseconds

mediatek:
- Disable AFBC support on Mediatek DRM driver
- Add pm_runtime support for GCE power control

imagination:
- kconfig: Fix dependencies

nouveau:
- Set DMA mask earlier
- Advertize correct modifiers for GB20x

pixpaper:
- kconfig: Fix dependencies

----------------------------------------------------------------
Alex Deucher (3):
      drm/amdgpu: set default gfx reset masks for gfx6-8
      drm/amdgpu: Drop PMFW RLC notifier from amdgpu_device_suspend()
      drm/amdgpu/smu: Handle S0ix for vangogh

Alex Hung (1):
      drm/amd/display: Fix black screen with HDMI outputs

Ariel D'Alessandro (1):
      drm/mediatek: Disable AFBC support on Mediatek DRM driver

Balasubramani Vivekanandan (1):
      drm/xe/guc: Synchronize Dead CT worker with unbind

Dave Airlie (5):
      Merge tag 'drm-misc-fixes-2025-11-06' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-intel-fixes-2025-11-06' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-6.18-2025-11-06' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'mediatek-drm-fixes-20251105' of
https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux
into drm-fixes
      Merge tag 'drm-xe-fixes-2025-11-07' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

James Jones (2):
      drm: define NVIDIA DRM format modifiers for GB20x
      drm/nouveau: Advertise correct modifiers on GB20x

Janusz Krzysztofik (1):
      drm/i915: Avoid lock inversion when pinning to GGTT on CHV/BXT+VTD

Jason-JH Lin (1):
      drm/mediatek: Add pm_runtime support for GCE power control

Jouni H=C3=B6gander (1):
      drm/xe: Do clean shutdown also when using flr

LiangCheng Wang (1):
      drm/tiny: pixpaper: add explicit dependency on MMU

Lijo Lazar (1):
      drm/amdgpu: Fix wait after reset sequence in S3

Mario Limonciello (1):
      drm/amd: Fix suspend failure with secure display TA

Mario Limonciello (AMD) (1):
      drm/amd/display: Don't stretch non-native images by default in eDP

Matt Coster (1):
      drm/imagination: Optionally depend on POWER_SEQUENCING

Matthew Brost (1):
      drm/xe: Enforce correct user fence signaling order using

Philip Yang (1):
      drm/amdkfd: Don't clear PT after process killed

Pierre-Eric Pelloux-Prayer (1):
      drm/sched: Fix deadlock in drm_sched_entity_kill_jobs_cb

Rong Zhang (1):
      drm/amd/display: Fix NULL deref in debugfs odm_combine_segments

Samuel Zhang (1):
      drm/amdgpu: fix gpu page fault after hibernation on PF passthrough

Tejas Upadhyay (1):
      drm/xe: Move declarations under conditional branch

Timur Tabi (1):
      drm/nouveau: set DMA mask before creating the flush page

Umesh Nerlige Ramappa (1):
      drm/i915: Fix conversion between clock ticks and nanoseconds

Wayne Lin (1):
      drm/amd/display: Enable mst when it's detected but yet to be initiali=
zed

Yang Wang (1):
      drm/amd/pm: fix missing device_attr cleanup in amdgpu_pm_sysfs_init()

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  4 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  9 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  5 ++-
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c         |  3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |  5 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |  5 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |  5 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c            |  4 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             | 26 ++++++++++++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 12 +++++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |  3 +-
 .../gpu/drm/amd/display/dc/link/link_detection.c   |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                | 18 ---------
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  4 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h            |  2 -
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  6 +++
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |  3 ++
 drivers/gpu/drm/i915/gt/intel_gt_clock_utils.c     |  4 +-
 drivers/gpu/drm/i915/i915_vma.c                    | 16 +++++++-
 drivers/gpu/drm/imagination/Kconfig                |  1 +
 drivers/gpu/drm/mediatek/mtk_crtc.c                |  7 ++++
 drivers/gpu/drm/mediatek/mtk_plane.c               | 24 +-----------
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |  4 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.h            |  1 +
 drivers/gpu/drm/nouveau/dispnv50/wndw.c            | 24 +++++++++++-
 drivers/gpu/drm/nouveau/dispnv50/wndwca7e.c        | 33 ++++++++++++++++
 drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c   | 24 ++++++------
 drivers/gpu/drm/scheduler/sched_entity.c           | 34 ++++++++--------
 drivers/gpu/drm/tiny/Kconfig                       |  1 +
 drivers/gpu/drm/xe/xe_device.c                     | 14 +++----
 drivers/gpu/drm/xe/xe_exec.c                       |  3 +-
 drivers/gpu/drm/xe/xe_exec_queue.c                 | 14 +++++++
 drivers/gpu/drm/xe/xe_exec_queue_types.h           |  7 ++++
 drivers/gpu/drm/xe/xe_guc_ct.c                     |  3 ++
 drivers/gpu/drm/xe/xe_oa.c                         | 45 ++++++++++++++----=
----
 drivers/gpu/drm/xe/xe_oa_types.h                   |  8 ++++
 drivers/gpu/drm/xe/xe_sync.c                       | 17 +++++++-
 drivers/gpu/drm/xe/xe_sync.h                       |  3 ++
 drivers/gpu/drm/xe/xe_sync_types.h                 |  3 ++
 drivers/gpu/drm/xe/xe_vm.c                         |  4 ++
 include/uapi/drm/drm_fourcc.h                      | 23 +++++++----
 42 files changed, 311 insertions(+), 125 deletions(-)


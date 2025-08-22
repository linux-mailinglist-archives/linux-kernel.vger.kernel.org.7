Return-Path: <linux-kernel+bounces-782747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 246B0B324BA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3E01D27F33
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B82296BBF;
	Fri, 22 Aug 2025 21:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVcQccSg"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD4A21256B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 21:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755899390; cv=none; b=sTSqKK3y+pvCdhBTgLOI3ahPWoP6mPRjhT2aUycoSWgADWzipbllQb0eS+Ku1NvIYnpyqkcSAjOD4Af4Hl2mc4dLsevkYOFpwhlx3OSIWd+px0Sk4citmany7wG/DWYNK1l1Fb2EnQPeGohDkifDPC38a5TfL6HBol/HtTm4eCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755899390; c=relaxed/simple;
	bh=+FrMZfWcjQgZuKgbRsksGjZtSASXu9Yk1wxo0Gw5APY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bWFq0on/PKyaNYy+VDD7DxYJAjHHO3eEvM2hFQtIUQ8pyz1Fv5C0pxR5lyWiIJMqxNXqfqLF/V+bQt9YmTw2IxYD5sMjs0GOWm78E4fVHOOMumlIOimCkAVPSsRt5+vPL1BXWmLPm6hGLDdgO05Q/Iox77aEmupWUeCHhmHXGS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVcQccSg; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61c26f3cf6fso1758974a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 14:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755899385; x=1756504185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3shbphJfK82NW9CE0mD0B4j3zJqllorZS6U3aG69qqI=;
        b=MVcQccSgPoh1MJ1ZK1Siuwa28cknURTX0L197dxtMQQc68s7Wjfr4uz/xzR/mN/Y/p
         PXTbdJ4fQ2ZV6hn7Wie2/rUtTZu/HZFcrq8preV+89h680j4XSwU2Oin8FrimtRZroNo
         8Z/b1SanHThvosIidcUug4ns7aSM/7yIwKoiMDzI5o6XUTTa4WDX7vpSyUf03Bzr5+j0
         geZjVwGyUnp3sgjm10GQXi6ZTKXBgYJhs0P85JL0woq7FGVq7Js8yscLwTkFTbK8VXOG
         HJGbixQu3PFtUMJTk2xerQCNcNs1qyyFqLPOZdiR3rty7GPcgTzuqtMjOiSWF5rqUItU
         Mkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755899386; x=1756504186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3shbphJfK82NW9CE0mD0B4j3zJqllorZS6U3aG69qqI=;
        b=Hypbe1JIF9DoRyl9+YkwSLdg4Ys2UHaDNsNmwsnuEzFtpweA0v4iKzF7snC2g362KE
         8v5P9LKqobg2BF6US+GhNmBHh+y0UjdQyO/Bt+QodFihkPOkzzYBZ/B1ftB7VQKnKShI
         QcmlxbgITrnxOsio7/FkTjN4vpA52JuhABbE0qorVmHRw1wOf5Qpjzejh02Dk2pR3SDA
         KtHnFf4RmCiwlQ1t4tXd7cBU8TvNKO0NYFQtdDttaFLS7TfFacbW6HWCnhXWsPdT76bA
         hg68dVwxw0E/OJ/Vb3cTGJkVRhzNibnLoFzN0JU7zn+KkHjjNBXBrhTwsPMPNmkHjhlL
         FbJg==
X-Forwarded-Encrypted: i=1; AJvYcCXQCsIgrhEWDnaVqf1u9smJUmnxaeuBx9YpXZ2J3kIef5XYOpl9Oqsy8Ox+8hgfwsaZkEtUAyvTIOxOxJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwNkScc0mkFAoRD9fVFUOVZKB61YMYYQoNE8kDK2XysYwmBaAs
	J0b2e8bkrFwEOzAstq1JfvVmJwOzhgXC36ANClbO/QjCgXgutlLtU7NExB67c6euNIEkAwccrPi
	/iwR+ZoxUbgmdpCMjzWDHItfFVmolTESAGtgX
X-Gm-Gg: ASbGncu/IBy/6H0CH+cANBUyQFRw7d26bm0RvET2ldZ9Sqzyn3Uu83v55Btk5goAaOa
	3RGnIPyf5lf6j4FmIZ0VqeE5uV4wPZQH036VrsoC2xE2rwDDLLyFI/go2J2fEyWBuhQUqI1699b
	FiiyR4t6usciPn3aQYds24TXVgMlPlr7u9HaCKPKC1XmffFtlgKBE8l285In9asysu1engEU8il
	2hmOQ==
X-Google-Smtp-Source: AGHT+IGanrr+UttB/kvILsftCspDHCpVG9G13dKdpZOX3YfV6wjphNp3XhgWAGRjxZde4BtwsyEY+Stv6NkP5jvJhVQ=
X-Received: by 2002:a17:907:9305:b0:af6:a116:f13c with SMTP id
 a640c23a62f3a-afe28f16478mr403341566b.23.1755899385298; Fri, 22 Aug 2025
 14:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 23 Aug 2025 07:49:34 +1000
X-Gm-Features: Ac12FXxhMoyarJu_LO9T1fG6x0ENHPEHj4XKRy_sSg7dcDoC7fdvmkDyet6C7FY
Message-ID: <CAPM=9tx3c2SzxmsTaySLHVVUyHd+zcB-axUL0Hbtk5DdQQ8rrQ@mail.gmail.com>
Subject: [git pull] drm fixes for 6.17-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Weekly drm fixes. Looks like things did indeed get busier after rc2,
nothing seems too major, but stuff scattered all over the place,
amdgpu, xe, i915, hibmc, rust support code, and other small fixes.

Regards,
Dave.


drm-fixes-2025-08-23-1:
drm fixes for 6.17-rc3

rust:
- drm device memory layout and safety fixes

tests:
- Endianness fixes

gpuvm:
- docs warning fix

panic:
- fix division on 32-bit arm

i915:
- TypeC DP display Fixes
- Silence rpm wakeref asserts on GEN11_GU_MISC_IIR access
- Relocate compression repacking WA for JSL/EHL

xe:
- xe_vm_create fixes
- fix vm bind ioctl double free

amdgpu:
- Replay fixes
- SMU14 fix
- Null check DC fixes
- DCE6 DC fixes
- Misc DC fixes

bridge:
- analogix_dp: devm_drm_bridge_alloc() error handling fix

habanalabs:
- Memory deallocation fix

hibmc:
- modesetting black screen fixes
- fix UAF on irq
- fix leak on i2c failure path

nouveau:
- memory leak fixes
- typos

rockchip:
- Kconfig fix
- register caching fix
The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9=
:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-08-23-1

for you to fetch changes up to a60f5ee68efd91b4507eacbb40d4024ecf363304:

  Merge tag 'drm-xe-fixes-2025-08-21-1' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2025-08-23 07:24:52 +1000)

----------------------------------------------------------------
drm fixes for 6.17-rc3

rust:
- drm device memory layout and safety fixes

tests:
- Endianness fixes

gpuvm:
- docs warning fix

panic:
- fix division on 32-bit arm

i915:
- TypeC DP display Fixes
- Silence rpm wakeref asserts on GEN11_GU_MISC_IIR access
- Relocate compression repacking WA for JSL/EHL

xe:
- xe_vm_create fixes
- fix vm bind ioctl double free

amdgpu:
- Replay fixes
- SMU14 fix
- Null check DC fixes
- DCE6 DC fixes
- Misc DC fixes

bridge:
- analogix_dp: devm_drm_bridge_alloc() error handling fix

habanalabs:
- Memory deallocation fix

hibmc:
- modesetting black screen fixes
- fix UAF on irq
- fix leak on i2c failure path

nouveau:
- memory leak fixes
- typos

rockchip:
- Kconfig fix
- register caching fix

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/swm14: Update power limit logic

Avizrat, Yaron (1):
      MAINTAINERS: Change habanalabs maintainers

Baihan Li (5):
      drm/hisilicon/hibmc: fix the i2c device resource leak when vdac
init failed
      drm/hisilicon/hibmc: fix irq_request()'s irq name variable is local
      drm/hisilicon/hibmc: fix the hibmc loaded failed bug
      drm/hisilicon/hibmc: fix rare monitors cannot display problem
      drm/hisilicon/hibmc: fix dp and vga cannot show together

Chenyuan Yang (1):
      drm/amd/display: Add null pointer check in mod_hdcp_hdcp1_create_sess=
ion()

Christoph Manszewski (1):
      drm/xe: Fix vm_bind_ioctl double free bug

Danilo Krummrich (5):
      MAINTAINERS: entry for DRM GPUVM
      rust: alloc: replace aligned_size() with Kmalloc::aligned_layout()
      rust: drm: ensure kmalloc() compatible Layout
      rust: drm: remove pin annotations from drm::Device
      rust: drm: don't pass the address of drm::Device to drm_dev_put()

Dave Airlie (4):
      Merge tag 'drm-intel-fixes-2025-08-20' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-6.17-2025-08-20' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2025-08-21' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2025-08-21-1' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

Fanhua Li (1):
      drm/nouveau/nvif: Fix potential memory leak in nvif_vmm_ctor().

Gabe Teeger (1):
      drm/amd/display: Revert Add HPO encoder support to Replay

Imre Deak (5):
      drm/i915/lnl+/tc: Fix handling of an enabled/disconnected dp-alt sink
      drm/i915/icl+/tc: Cache the max lane count value
      drm/i915/lnl+/tc: Fix max lane count HW readout
      drm/i915/lnl+/tc: Use the cached max lane count value
      drm/i915/icl+/tc: Convert AUX powered WARN to a debug message

Jani Nikula (1):
      drm/i915: silence rpm wakeref asserts on GEN11_GU_MISC_IIR access

Javier Garcia (1):
      drm: Add directive to format code in comment

Jocelyn Falempe (1):
      drm/panic: Add a u64 divide by 10 for arm32

Jos=C3=A9 Exp=C3=B3sito (2):
      drm/tests: Fix endian warning
      drm/tests: Fix drm_test_fb_xrgb8888_to_xrgb2101010() on big-endian

Liu Ying (1):
      drm/bridge: analogix_dp: Fix bailout for devm_drm_bridge_alloc()

Madhur Kumar (1):
      drm/nouveau: fix typos in comments

Mario Limonciello (1):
      drm/amd/display: Avoid a NULL pointer dereference

Maxime Ripard (1):
      Merge drm/drm-fixes into drm-misc-fixes

Miguel Ojeda (2):
      drm: nova-drm: fix 32-bit arm build
      rust: alloc: fix `rusttest` by providing `Cmalloc::aligned_layout` to=
o

Nitin Gote (1):
      iosys-map: Fix undefined behavior in iosys_map_clear()

Piotr Pi=C3=B3rkowski (2):
      drm/xe: Assign ioctl xe file handler to vm in xe_vm_create
      drm/xe: Move ASID allocation and user PT BO tracking into xe_vm_creat=
e

Piotr Zalewski (1):
      drm/rockchip: vop2: make vp registers nonvolatile

Qianfeng Rong (1):
      drm/nouveau/gsp: fix mismatched alloc/free for kvmalloc()

Rudi Heitbaum (1):
      drm/rockchip: cdn-dp: select bridge for cdp-dp

Sebastian Brzezinka (1):
      drm/i915/gt: Relocate compression repacking WA for JSL/EHL

Thomas Zimmermann (2):
      Merge drm/drm-fixes into drm-misc-fixes
      Revert "drm/amdgpu: Use dma_buf from GEM object instance"

Thorsten Blum (1):
      accel/habanalabs/gaudi2: Use kvfree() for memory allocated with kvcal=
loc()

Timur Krist=C3=B3f (8):
      drm/amd/display: Don't overclock DCE 6 by 15%
      drm/amd/display: Adjust DCE 8-10 clock, don't overclock by 15%
      drm/amd/display: Find first CRTC and its line time in
dce110_fill_display_configs
      drm/amd/display: Fill display clock and vblank time in
dce110_fill_display_configs
      drm/amd/display: Don't warn when missing DCE encoder caps
      drm/amd/display: Don't print errors for nonexistent connectors
      drm/amd/display: Fix fractional fb divider in set_pixel_clock_v3
      drm/amd/display: Fix DP audio DTO1 clock source on DCE 6.

Tom Chung (1):
      drm/amd/display: Fix Xorg desktop unresponsive on Replay panel

 MAINTAINERS                                        | 14 +++-
 drivers/accel/habanalabs/gaudi2/gaudi2.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  3 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 19 +++++
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  |  5 +-
 .../gpu/drm/amd/display/dc/bios/command_table.c    |  2 +-
 .../amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c    | 14 ++--
 .../amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c | 40 ++++++----
 .../amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c   | 31 +++-----
 drivers/gpu/drm/amd/display/dc/core/dc.c           | 15 +++-
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |  8 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c   | 43 +---------
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h   |  2 +-
 .../dc/link/protocols/link_edp_panel_control.c     |  2 +-
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    | 20 -----
 .../gpu/drm/amd/display/modules/hdcp/hdcp_psp.c    |  3 +
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   | 30 +++++--
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  4 +-
 drivers/gpu/drm/drm_gpuvm.c                        |  2 +
 drivers/gpu/drm/drm_panic_qr.rs                    | 22 ++++-
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c       | 14 +++-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    | 22 ++---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h    |  1 +
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c    |  5 ++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c   | 11 ++-
 drivers/gpu/drm/i915/display/intel_display_irq.c   |  4 +
 drivers/gpu/drm/i915/display/intel_tc.c            | 93 +++++++++++++++++-=
----
 drivers/gpu/drm/i915/gt/intel_workarounds.c        | 20 ++---
 drivers/gpu/drm/nouveau/nouveau_exec.c             |  6 +-
 drivers/gpu/drm/nouveau/nvif/vmm.c                 |  3 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c  |  4 +-
 drivers/gpu/drm/nova/file.rs                       |  3 +-
 drivers/gpu/drm/rockchip/Kconfig                   |  1 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       |  9 ++-
 drivers/gpu/drm/tests/drm_format_helper_test.c     |  3 +-
 drivers/gpu/drm/xe/xe_migrate.c                    |  2 +-
 drivers/gpu/drm/xe/xe_pxp_submit.c                 |  2 +-
 drivers/gpu/drm/xe/xe_vm.c                         | 48 ++++++-----
 drivers/gpu/drm/xe/xe_vm.h                         |  2 +-
 include/linux/iosys-map.h                          |  7 +-
 rust/kernel/alloc/allocator.rs                     | 30 ++++---
 rust/kernel/alloc/allocator_test.rs                | 11 +++
 rust/kernel/drm/device.rs                          | 32 ++++++--
 46 files changed, 382 insertions(+), 239 deletions(-)


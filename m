Return-Path: <linux-kernel+bounces-823958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83543B87D17
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E841C27DDB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A185422F757;
	Fri, 19 Sep 2025 03:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWanTIy9"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E28F1E5B82
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758252751; cv=none; b=IMc2mTsHYgHbD0tOa1uQqqOHyc5wCNxQPkH3ca4LCoH9eHwIKzftq4bpldSkJah93CXOKmchg1OZSgwkkPiwj5ejEqzXR+itnWci9bLB5w3O80uo3cRdLVv3mUKSRZkuzsSVk6/Rx/lh3UiMXn1BAuF3Xh/VNMnUyEUDUSqTc8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758252751; c=relaxed/simple;
	bh=23vBnGFAtWDFF/Rr8hSGr+2b20W5ze+NzoXtVI/lyg0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JirO6P+rcy0tQGF2zQjELK528jqm54Xb6qeBHgWca8/5aE4iPCkqT3KkoWHKmSvdCe7rmp87D1jHbyhsqURKMETIYM2cHyt4SEbFRArAbIIqW97AFdXP+0EHURMa6jHBd1etG5C5worzuyeHjz6GE6kLdesAD7DWr++8odtggJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWanTIy9; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b2391596dcfso142788266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758252748; x=1758857548; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ooofDMiH4HFG0EEg7RXIqPBnN/m1Kg0lPTZg7tt9ZG4=;
        b=XWanTIy9QDB1r71IbX5H3Fzt6X0IGACQCLovywPrLKJ5NccFooTxPSmz09ZzjydKvE
         rR4Zk3kEuoUCvsdjKJGCnLp8qD7gRr7Xq0RM7YKsLIYEfdMD3m4gelR0CgM2amxZB/xQ
         lxdmQuDbY5QXhZ8Jjm/IQEkbq5ML5sOMH6pkNoLVT+YnIeLaYuHeoZARrMYrSmBiVP4Y
         s2gda8p9VY9COZRxz7Jl6FIOyjbbGN/5mD5vqiUP5d8kqS26Ur+eNO0GtygqZcopuJvC
         waTAw0teV30qoNQk77Ei4k7Ahg1nNo8pphTgwIpPn/f0jGZEI+3HARk32QhGyReVV2NQ
         L/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758252748; x=1758857548;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ooofDMiH4HFG0EEg7RXIqPBnN/m1Kg0lPTZg7tt9ZG4=;
        b=u8OYVhxTbD60YIO3ZXpM5yfHMWuyh9xLp9IuS8TfnuKFMI9zQ4p/4HLTgC8a1XVdCr
         +I7P9AUuZbT7OM/mmhyy0ewDTsVprmDjnGIz+h5VUcDwdlNZTOzPb5Hb9LlgGL/BYBz/
         lhWjAJAetzT7Fm80r6s/I/C5WozfNb9jlR9lo/LmuZIJqZL8JiVaxcVrn8+q3CSW9kYk
         vH5Q9aDHhvwlDliDbVbX0dJMwe7R2HG/nzjTh6Tte087zgqDghLQj/GA+WboFF1i4wU7
         YheTO8S1fOc61968EAHpiitUq/e8tVmbcK1huq1r+HomOmtvQ7zYils3AklcV+qi7brB
         WJlA==
X-Forwarded-Encrypted: i=1; AJvYcCWFta7HGo4xCiZW8Wz/TCWm2z6YoaCWoObWpvS3OJ9pPVaNfEepKLbZ4r8tQdC9ppBeNAmTDuEH+aAZkCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsIovvmPZxtFhuWlvtdQR7s4d5xAktigU+HuHK2pNXJoOEDYoX
	khFOdZX8iv1cIkP1J1mCbZ7gPDKn7M4mKYPWBl8n/zywkVaQQwPMM+VyO2vWHjXyb61Oyj2SKGW
	xBIxpK1wM5TaxbZ+P/W/U1nfRkocpbD85OPZKxAU=
X-Gm-Gg: ASbGncsB9wK3ddcz7/rcr1UuyHU/oZYHhEwrApAsG80rZM1QdyxeV3zPtNRa8H97KX8
	X3FCYTC6hqnblVM3zwNBgGo5kdECZdjuDG1v/SMabPI6hbxXCz2hGw1+SQR0UaFNJ0+xaJ1Ii2Q
	pYih9PYRF7zr87E6lZS5dvOSnzwgNKk1CoLYpG4XC/VeVsVB/RZaWgpPyTfBS2tGuNvT4iCuUl3
	MMP1g==
X-Google-Smtp-Source: AGHT+IGw+X/9W3XV9luI4F9/vbade2aPJwKztbAKXXkZ9MjMWlFJ5BBWI1kPE2FV25oLM+14Bmayy9AAc+QA8NxUPcc=
X-Received: by 2002:a17:906:3c0c:b0:b07:e207:1530 with SMTP id
 a640c23a62f3a-b24ee6ef41dmr142878966b.26.1758252747992; Thu, 18 Sep 2025
 20:32:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 19 Sep 2025 13:32:16 +1000
X-Gm-Features: AS18NWAPYnEGuVm5VVwywtBO7jJYOlW93Cb3YKJLIjZJI9nNy0SThykk6dnRenM
Message-ID: <CAPM=9txMJGoLbbEHXCXKzx4=gYSKbKDpar7z5FOHaBgeLagr6Q@mail.gmail.com>
Subject: [git pull] drm fixes for 6.17-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Weekly fixes for drm, it's a bit busier than I'd like on the xe side
this week, but otherwise amdgpu and some smaller fixes for i915/bridge
and a revert on docs.

Dave.

drm-fixes-2025-09-19:
drm fixes for 6.17-rc7

docs:
- fix docs build regression

i915:
- Honor VESA eDP backlight luminance control capability

bridge:
- anx7625: Fix NULL pointer dereference with early IRQ
- cdns-mhdp8546: Fix missing mutex unlock on error path

xe:
- Release kobject for the failure path
- SRIOV PF: Drop rounddown_pow_of_two fair
- Remove type casting on hwmon
- Defer free of NVM auxiliary container to device release
- Fix a NULL vs IS_ERR
- Add cleanup action in xe_device_sysfs_init
- Fix error handling if PXP fails to start
- Set GuC RCS/CCS yield policy

amdgpu:
- GC 11.0.1/4 cleaner shader support
- DC irq fix
- OD fix

amdkfd:
- S0ix fix
The following changes since commit f83ec76bf285bea5727f478a68b894f5543ca76e:

  Linux 6.17-rc6 (2025-09-14 14:21:14 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-09-19

for you to fetch changes up to feb96ccb33189244eaa5a7e8064e623976dbbfe3:

  Merge tag 'amd-drm-fixes-6.17-2025-09-18' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2025-09-19
12:35:09 +1000)

----------------------------------------------------------------
drm fixes for 6.17-rc7

docs:
- fix docs build regression

i915:
- Honor VESA eDP backlight luminance control capability

bridge:
- anx7625: Fix NULL pointer dereference with early IRQ
- cdns-mhdp8546: Fix missing mutex unlock on error path

xe:
- Release kobject for the failure path
- SRIOV PF: Drop rounddown_pow_of_two fair
- Remove type casting on hwmon
- Defer free of NVM auxiliary container to device release
- Fix a NULL vs IS_ERR
- Add cleanup action in xe_device_sysfs_init
- Fix error handling if PXP fails to start
- Set GuC RCS/CCS yield policy

amdgpu:
- GC 11.0.1/4 cleaner shader support
- DC irq fix
- OD fix

amdkfd:
- S0ix fix

----------------------------------------------------------------
Aaron Ma (1):
      drm/i915/backlight: Honor VESA eDP backlight luminance control capability

Alex Deucher (2):
      drm/amdkfd: add proper handling for S0ix
      drm/amdgpu: suspend KFD and KGD user queues for S0ix

Bagas Sanjaya (1):
      Revert "drm: Add directive to format code in comment"

Dan Carpenter (1):
      drm/xe: Fix a NULL vs IS_ERR() in xe_vm_add_compute_exec_queue()

Daniele Ceraolo Spurio (2):
      drm/xe: Fix error handling if PXP fails to start
      drm/xe/guc: Set RCS/CCS yield policy

Dave Airlie (4):
      Merge tag 'drm-intel-fixes-2025-09-17' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2025-09-18' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2025-09-18' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-6.17-2025-09-18' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Ivan Lipski (1):
      drm/amd/display: Allow RX6xxx & RX7700 to invoke amdgpu_irq_get/put

Loic Poulain (1):
      drm: bridge: anx7625: Fix NULL pointer dereference with early IRQ

Mallesh Koujalagi (1):
      drm/xe/hwmon: Remove type casting

Mario Limonciello (1):
      drm/amd: Only restore cached manual clock settings in restore if
OD enabled

Michal Wajdeczko (1):
      drm/xe/pf: Drop rounddown_pow_of_two fair LMEM limitation

Nitin Gote (1):
      drm/xe: defer free of NVM auxiliary container to device release callback

Qi Xi (1):
      drm: bridge: cdns-mhdp8546: Fix missing mutex unlock on error path

Shuicheng Lin (1):
      drm/xe/tile: Release kobject for the failure path

Srinivasan Shanmugam (1):
      drm/amdgpu/gfx11: Add Cleaner Shader Support for GFX11.0.1/11.0.4 GPUs

Zongyao Bai (1):
      drm/xe/sysfs: Add cleanup action in xe_device_sysfs_init

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |  16 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |  12 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  24 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |  15 +++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |  36 +++++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  39 ++++++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |   2 +-
 drivers/gpu/drm/bridge/analogix/anx7625.c          |   6 +-
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.c    |   6 +-
 drivers/gpu/drm/drm_gpuvm.c                        |   2 -
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c  |   2 +-
 drivers/gpu/drm/xe/abi/guc_actions_abi.h           |   1 +
 drivers/gpu/drm/xe/abi/guc_klvs_abi.h              |  25 +++++
 drivers/gpu/drm/xe/xe_device_sysfs.c               |   8 +-
 drivers/gpu/drm/xe/xe_exec_queue.c                 |  22 ++--
 drivers/gpu/drm/xe/xe_exec_queue_types.h           |   8 +-
 drivers/gpu/drm/xe/xe_execlist.c                   |  25 +++--
 drivers/gpu/drm/xe/xe_execlist_types.h             |   2 +-
 drivers/gpu/drm/xe/xe_gt.c                         |   3 +-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c         |   1 -
 drivers/gpu/drm/xe/xe_guc.c                        |   6 +-
 drivers/gpu/drm/xe/xe_guc_exec_queue_types.h       |   4 +-
 drivers/gpu/drm/xe/xe_guc_submit.c                 | 120 +++++++++++++++++----
 drivers/gpu/drm/xe/xe_guc_submit.h                 |   2 +
 drivers/gpu/drm/xe/xe_hwmon.c                      |  35 +++---
 drivers/gpu/drm/xe/xe_nvm.c                        |   5 +-
 drivers/gpu/drm/xe/xe_tile_sysfs.c                 |  12 ++-
 drivers/gpu/drm/xe/xe_vm.c                         |   4 +-
 28 files changed, 342 insertions(+), 101 deletions(-)


Return-Path: <linux-kernel+bounces-752675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC26B1793E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 01:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67EE23AE22F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D21279DAE;
	Thu, 31 Jul 2025 23:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7UtFy8+"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BB6153598
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 23:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754003122; cv=none; b=RUzTqNOoE0f2excSh2tWICztYErHJbaLNXDJNB4gYJDJ9UfkCF3vGRFFaKQ1d0pT77QJ7EYvHiQqwAXoiXEopzVfkZLPqK9N1FQ65FchjpyTe+QXqpEpwYWuvr9L3vloIi5lIeiPSuFT6FAbC6PReN+AV8iluS8y3dlHxOIIBoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754003122; c=relaxed/simple;
	bh=qyrEcm1NlPlGbu8ZuWQ9vviPWGLJcyji7SbAaMgFsaU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iY4qMN35HOBpZ3TGLGtJ0e/blBpRoBLKEzH6H2yPSFN3ORNMbWZHoOUACR98VUQ6W5aRi4m0qZA/mto5vI0ciZy9LmsV9MMg7pT7YvWisJjR2IH7KFB1wjLoVIGj3cebmk09SLwFjG5VaVbkvfB4StNsogToghuSR5gT1dJUAN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7UtFy8+; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-af66d49daffso50651666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 16:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754003119; x=1754607919; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nl4NbPVd+NNf+u5SeidN/gG+qLoaVuZAjBLn9hC2Fi0=;
        b=G7UtFy8+NScbmAOcPc+J/iEqvXZ5aKWYL/3+GkfZ9RdNenTec7GmzxxHgtSgxJGVt0
         6RcdUXz+6hZIYUC3UvDsL5+oNzWpFRbCPdnVFuxUJdw4Ws4zEIslS/SXy3DuIIaNdg+K
         HpDyIAS7XPnoesQCbupSfbEIBaEAJ863mD1/G6i9IE/MQ2xhvsGyn48kyCRfvag7bRwD
         NUyR2RqV6T/YoGwzYs6DEuKAue9tlTVmNIrt5f4aTDeltpslwGwBUMZYBpjpTAd7fL9a
         CtEBjatcVdzxJYPFkHkMkj4t57AAxetreu3YDI7cDa/m5IlmpLy/dl7DespvCCxQ7Bgo
         caJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754003119; x=1754607919;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nl4NbPVd+NNf+u5SeidN/gG+qLoaVuZAjBLn9hC2Fi0=;
        b=p6ThRmnAstaaTpX+1SeDmaFhfJXFCMfKLCeH55e7Nxs8y/ZRKiDUyRJRXRv52lObJF
         Kvz8cmf9iPepyQNFLQSH9vE1RSkQDVURKq0cbQqGdcs6GVuV0Bt1V5ytvnMYGmhxV+HJ
         Iu/3QpN3FWlOCyyJf9u2Gg4t1W7+wRPzubJY12hjGTNmj53sxQAc5u2AUQ2hSEuCmjRk
         ihQom3x/m7jX2GXGBbocBQXdIeUxv7s0UVwHFijZpgExCXd6+XbjXIy+gHK0wkJkCkMr
         wfVnKyM+YundqIws3iF2AXh8mcwM8Aiua+mWqbvnxJ10uzeLoNhcrzRKmIHFH+yHTNrr
         mmWA==
X-Forwarded-Encrypted: i=1; AJvYcCWdBBBqNYPjDYFCyTMrHqcMh75UYYSuRqRkDXMVCZLe+YOFZnvMKEBmlfqleF8v4fAxNdt5+KjNrpkx5YA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznY8snMwMT9Kpv2cHSQTEqNSKo7GKqKhE1gq2UCOgplbr2gXy9
	r1bL/e2siIUjd254+FzD1c6i1pZ39e5gCZDBZByfjf485eSpOWHMmFZ9wKD8exxfZTrZDTj4a+Y
	TzL4p7atM8PSZufcv9kw9DkLqtFQu9zM=
X-Gm-Gg: ASbGncua8SMxkdOugS2gKX+ix4U05rgztC8TkuR+vLCljYQARts5VK4t0jik93FJmiD
	clDYTt6rwGwnvyLFw3xLe1jJw+MF6l6csL/mUtHSWE8V/WLaLqExlM8zPXBDPRGtgmaGQbY60oh
	IdbN+QZcuZufTS8IRTqkWRfAnU/b5oClFsc7cMdjWJGKOjftMCi19xg0gmHEQUGF2iYn7U2aL4e
	mr1/2vNZCgHNCz6f3WeKAiGFTA275YTBMz1Ib8G7a9+XBduNQ==
X-Google-Smtp-Source: AGHT+IG2EPrRFEvuffrWgcTEueq+xlLXsUddLPK7dBDblnaf7RNtAg2x/iRfKZFI+JgGHMDq4I5RxRRMWfulZVBXQ1E=
X-Received: by 2002:a17:906:6a18:b0:af9:3341:8dd with SMTP id
 a640c23a62f3a-af933413ce5mr29098566b.31.1754003118910; Thu, 31 Jul 2025
 16:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 1 Aug 2025 09:05:07 +1000
X-Gm-Features: Ac12FXzYSSUx_DR0oQGRrzUbfDO7jlTV1z6QKC-g4IH-MBsIe24fxN8xWapYCG4
Message-ID: <CAPM=9twBSSdGXPYQMTz9yWqKg=8RNpAXui4Uf=BvB60mUiZqfw@mail.gmail.com>
Subject: [git pull] drm fixes for 6.17-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

I'm sending these out because it has the DSC fix in it, there was also
a set of xe fixes in the queue, so may as well send those out as well.

Just a bunch of amdgpu and xe fixes, let me know if anything else shows up,

Dave.

drm-next-2025-08-01:
drm fixes for 6.17-rc1

amdgpu:
- DSC divide by 0 fix
- clang fix
- DC debugfs fix
- Userq fixes
- Avoid extra evict-restore with KFD
- Backlight fix
- Documentation fix
- RAS fix
- Add new kicker handling
- DSC fix for DCN 3.1.4
- PSR fix
- Atomic fix
- DC reset fixes
- DCN 3.0.1 fix
- MMHUB client mapping fix

xe:
- Fix BMG probe on unsupported mailbox command
- Fix OA static checker warning about null gt
- Fix a NULL vs IS_ERR() bug in xe_i2c_register_adapter
- Fix missing unwind goto in GuC/HuC
- Don't register I2C devices if VF
- Clear whole GuC g2h_fence during initialization
- Avoid call kfree for drmm_kzalloc
- Fix pci_dev reference leak on configfs
- SRIOV: Disable CSC support on VF
The following changes since commit 711fa2667d8b230ff31f1855d0f25e3263268d8a:

  Merge tag 'drm-misc-next-fixes-2025-07-24' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-next
(2025-07-29 16:53:20 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2025-08-01

for you to fetch changes up to 6531a2cf07ef156956840853692755cc7e1621b7:

  Merge tag 'drm-xe-next-fixes-2025-07-31' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-next (2025-08-01
07:09:16 +1000)

----------------------------------------------------------------
drm fixes for 6.17-rc1

amdgpu:
- DSC divide by 0 fix
- clang fix
- DC debugfs fix
- Userq fixes
- Avoid extra evict-restore with KFD
- Backlight fix
- Documentation fix
- RAS fix
- Add new kicker handling
- DSC fix for DCN 3.1.4
- PSR fix
- Atomic fix
- DC reset fixes
- DCN 3.0.1 fix
- MMHUB client mapping fix

xe:
- Fix BMG probe on unsupported mailbox command
- Fix OA static checker warning about null gt
- Fix a NULL vs IS_ERR() bug in xe_i2c_register_adapter
- Fix missing unwind goto in GuC/HuC
- Don't register I2C devices if VF
- Clear whole GuC g2h_fence during initialization
- Avoid call kfree for drmm_kzalloc
- Fix pci_dev reference leak on configfs
- SRIOV: Disable CSC support on VF

----------------------------------------------------------------
Alex Deucher (2):
      drm/amdgpu: track whether a queue is a kernel queue in amdgpu_mqd_prop
      drm/amdgpu: update mmhub 4.1.0 client id mappings

Ashutosh Dixit (1):
      drm/xe/oa: Fix static checker warning about null gt

Dan Carpenter (1):
      drm/xe: Fix a NULL vs IS_ERR() bug in xe_i2c_register_adapter()

Dave Airlie (2):
      Merge tag 'amd-drm-fixes-6.17-2025-07-31' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'drm-xe-next-fixes-2025-07-31' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-next

Dillon Varone (1):
      drm/amd/display: Fix divide by zero when calculating min ODM factor

Frank Min (1):
      drm/amdgpu: add kicker fws loading for gfx12/smu14/psp14

Gang Ba (1):
      drm/amdgpu: Avoid extra evict-restore process.

Ivan Lipski (1):
      drm/amd/display: Allow DCN301 to clear update flags

Lauri Tirkkonen (1):
      drm/amd/display: fix initial backlight brightness calculation

Lukasz Laguna (2):
      drm/xe/vf: Don't register I2C devices if VF
      drm/xe/vf: Disable CSC support on VF

Mario Limonciello (3):
      drm/amd/display: Avoid configuring PSR granularity if PSR-SU not supported
      drm/amd/display: Only finalize atomic_obj if it was initialized
      drm/amd/display: Pass up errors for reset GPU that fails to init HW

Michal Wajdeczko (2):
      drm/xe/guc: Clear whole g2h_fence during initialization
      drm/xe/configfs: Fix pci_dev reference leak

Nathan Chancellor (1):
      drm/amdgpu: Initialize data to NULL in imu_v12_0_program_rlc_ram()

Peter Shkenev (1):
      drm/amdgpu: check if hubbub is NULL in debugfs/amdgpu_dm_capabilities

Raag Jadav (1):
      drm/xe: Don't fail probe on unsupported mailbox command

Roman Li (1):
      drm/amd/display: Disable dsc_power_gate for dcn314 by default

Shuicheng Lin (1):
      drm/xe/hw_engine_group: Avoid call kfree() for drmm_kzalloc()

Srinivasan Shanmugam (1):
      drm/amd/display: Fix misuse of /** to /* in 'dce_i2c_hw.c'

Yang Wang (1):
      drm/amd/amdgpu: fix missing lock for cper.ring->rptr/wptr access

Zhanjun Dong (1):
      drm/xe/uc: Fix missing unwind goto

 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c           |  8 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  6 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             | 14 ++++++---
 drivers/gpu/drm/amd/amdgpu/imu_v12_0.c             | 13 ++++++---
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c          | 34 +++++++++-------------
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c             |  2 ++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 11 ++++---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |  6 ++--
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  3 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c    |  8 ++++-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c        | 29 +++++++++---------
 .../display/dc/resource/dcn314/dcn314_resource.c   |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c     | 11 +++++--
 drivers/gpu/drm/xe/xe_configfs.c                   |  3 +-
 drivers/gpu/drm/xe/xe_device.c                     |  1 +
 drivers/gpu/drm/xe/xe_device_sysfs.c               |  7 ++++-
 drivers/gpu/drm/xe/xe_guc_ct.c                     |  6 +---
 drivers/gpu/drm/xe/xe_hw_engine_group.c            | 28 ++++--------------
 drivers/gpu/drm/xe/xe_i2c.c                        |  7 +++--
 drivers/gpu/drm/xe/xe_oa.c                         |  2 +-
 drivers/gpu/drm/xe/xe_uc.c                         |  2 +-
 25 files changed, 112 insertions(+), 95 deletions(-)


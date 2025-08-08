Return-Path: <linux-kernel+bounces-759598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC66B1DFEA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 02:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 736BE4E1080
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 00:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7929476;
	Fri,  8 Aug 2025 00:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8vdlzST"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A137FD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 00:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754612202; cv=none; b=Dbx3Jx/d6+BEo1+je5OUIE0SCj4YRif0ZagRqWxZ6S3+cAT+rlzFHEQYCro11wSskF4nFYJMvUPhg0my1ePI8Yvy47/SJk/sfkVtsxIqlWogfDUhRlfZv+gkXWEIdX3pKTPSC4bd5OqBaAJaVIOcN6Usc1UkhSrYEwsZ0hECXJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754612202; c=relaxed/simple;
	bh=wiJnSxlPA+Ee7U2fDxGRvbShACZ7rZiOfBIpjX3cBAI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WprxS/SOUm0RaefSR+IzW/vRBBh5rU6oWvwZGrhdnIw4GsErRpTykn27zG0SoJpC19mMXdxqdpYyPyjEcZ52fQca8r0NbO6FTYyr+2h4MNd0c+iEq+Miza6guK2peD5gM4rKfNSUk7kU98OfvWEkl0goh0R6qb920+ck2bN94nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8vdlzST; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61592ff5df8so2012033a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 17:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754612199; x=1755216999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xPZdVNrW41q7DAUdB/VwINcIYpzwK89g+W8F6J/ucRg=;
        b=G8vdlzSTVNG+7kILfl3vPAVwxP7E/A9zXzJpngDs1QEwDc6JeWl6jNCP5aGvOq8hml
         Tz+FLzt8IuhYULuTCabnWUkLCaepnLDKLZhxiu+qJeuMG9pVNNSqJBbLEG/096Oc7w/I
         ABASoufUjY0YnDRkmsaB2dZJuzTHC1Eoo696ths0toXl7DDIocN9lmgW3gxALYlYduGU
         oB9ceIgAprvJcDyhVoXQ9k5s1FE+WOFpVHNLl5OsvqmslQe5K+cCFlsgoUgMcT7QyNMV
         pSu/wmZ7oMwxoIPIa5OC+wSsbmSaeOQ2whxoHlm96o0IHUEOdK2Hurp9WsVDMrYsL5JJ
         88QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754612199; x=1755216999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xPZdVNrW41q7DAUdB/VwINcIYpzwK89g+W8F6J/ucRg=;
        b=Z3ckJRMi6yjFJvGOM80INkyvGFHe1L58evjg2tkk8vde0xmGlcOZ/oqj3IRUlq6K5x
         ywWLwgPpdYmpt8FtA3oi0SVNBXIIGgqJnYrMBHmRpacvTihFj4/v7UviR5Z+PQhujFda
         ALgTSj/ImX9axpkL8le18fVaHV0qwAqcvfNTgDiGfCIkTjqny0hog1mchURSMnbfZEqz
         6hF7mgWlOZDhIsipyAvl4PouzNivCjTLT/2b4qcZFdWkOlv1IM9t0p/qXKGSOrSiXL61
         y9ebtLGYRwax2cZ3Cc+yu+kJASNQFSiWHu/QGLoPROVr5GZUynHSVmDPNNWOlchbx8uy
         FcIw==
X-Forwarded-Encrypted: i=1; AJvYcCVwJv2Z+5MBOCNYtgrJPRfKnsI1iG3leDyFXCBvBmjQaYnzEPXsM0onnWZPle0CvfchnKLOVp2goMfzmfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFPb78Rr/QaTLtfpRhXPBfdYb/L5t22iNCBcVbXwVWllEnofMA
	Tt0SAf49I1JaAGhx/HhzmBAk+GYBwLQ1Sh0J7Hi4GFOvTq7DZIeR8LO10xZ8McOT3MBw1m6chHb
	PdgvnI3Q+xjDVShoakJ+aKCUq9zPdpGyGH+R1
X-Gm-Gg: ASbGncuoesYf4RVG2P53HmrpGla1Fzs9oIbcKw2+xVMqpIRfCfuJ5SvkpXpxINzJTct
	CsS2eEfiRDt8bOUdWahzEL9SwDcUfTYaUdQko4R1VV0A6/vltg4Dx+DoE4rGeCOm7VUHMhfuWDq
	Ook5KIFhU5qVHdcvh1B3NodyKIRmrEcAbA+Ehybv/dH9Qx0vexLxr9Lm7AvlS27xwXI5uuThp1P
	S9YJfE=
X-Google-Smtp-Source: AGHT+IErqhWifOxmRixsHlVmwEN0sUCALdizsuJhfaUdm/bGCaRd6+b2LkZMY91Lo/KMC85PC1FvmDekjDKHl83jpZY=
X-Received: by 2002:a17:907:2d0f:b0:ae3:75e5:ff7a with SMTP id
 a640c23a62f3a-af9c645ebe4mr74395166b.19.1754612198377; Thu, 07 Aug 2025
 17:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 8 Aug 2025 10:16:27 +1000
X-Gm-Features: Ac12FXzHyEAjfibVQ_rlFFljGomoJYSyp-4Yp7BFpHsG5N6OKVX7Q0fCwHzbdYw
Message-ID: <CAPM=9tzJAoCXiwvR6tpSv5QctkKu+JAbKZBEbM+M+z+fZOkAOw@mail.gmail.com>
Subject: [git pull] drm fixes for 6.17-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Linus,

This is the fixes that built up in the merge window, mostly amdgpu and
xe with one i915 display fix, seems like things are pretty good for
rc1.

Regards,
Dave.

drm-next-2025-08-08:
drm fixes for 6.17-rc1

i915:
- DP LPFS fixes

xe:
- SRIOV: PF fixes and removal of need of module param
- Fix driver unbind around Devcoredump
- Mark xe driver as BROKEN if kernel page size is not 4kB

amdgpu:
- GC 9.5.0 fixes
- SMU fix
- DCE 6 DC fixes
- mmhub client ID fixes
- VRR fix
- Backlight fix
- UserQ fix
- Legacy reset fix
- Misc fixes

amdkfd:
- CRIU fix
- Debugfs fix
The following changes since commit 6531a2cf07ef156956840853692755cc7e1621b7=
:

  Merge tag 'drm-xe-next-fixes-2025-07-31' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-next (2025-08-01
07:09:16 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2025-08-08

for you to fetch changes up to 64c627519474e687b876e6e50cc28ece16d10564:

  Merge tag 'amd-drm-fixes-6.17-2025-08-07' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next (2025-08-08
08:17:13 +1000)

----------------------------------------------------------------
drm fixes for 6.17-rc1

i915:
- DP LPFS fixes

xe:
- SRIOV: PF fixes and removal of need of module param
- Fix driver unbind around Devcoredump
- Mark xe driver as BROKEN if kernel page size is not 4kB

amdgpu:
- GC 9.5.0 fixes
- SMU fix
- DCE 6 DC fixes
- mmhub client ID fixes
- VRR fix
- Backlight fix
- UserQ fix
- Legacy reset fix
- Misc fixes

amdkfd:
- CRIU fix
- Debugfs fix

----------------------------------------------------------------
Alex Deucher (4):
      drm/amdgpu: update mmhub 3.0.1 client id mappings
      drm/amdgpu: update mmhub 3.3 client id mappings
      drm/amdgpu/discovery: fix fw based ip discovery
      drm/amdgpu: add missing vram lost check for LEGACY RESET

Amber Lin (1):
      drm/amdkfd: Destroy KFD debugfs after destroy KFD wq

Balasubramani Vivekanandan (1):
      drm/xe/devcoredump: Defer devcoredump initialization during probe

Dave Airlie (3):
      Merge tag 'drm-intel-next-fixes-2025-08-05' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
      Merge tag 'drm-xe-next-fixes-2025-08-06' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-next
      Merge tag 'amd-drm-fixes-6.17-2025-08-07' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next

David Yat Sin (1):
      drm/amdkfd: Fix checkpoint-restore on multi-xcc

Jesse.Zhang (1):
      drm/amdgpu: Update SDMA firmware version check for user queue support

Jouni H=C3=B6gander (4):
      drm/i915/display: Write PHY_CMN1_CONTROL only when using AUXLess ALPM
      drm/i915/display: Avoid unnecessarily calling
intel_cx0_get_owned_lane_mask
      drm/i915/display: Ensure phy is accessible on lfps configuration
      drm/i915/display: Set C10_VDR_CTRL_MSGBUS_ACCESS before phy reg read

Lijo Lazar (3):
      drm/amdgpu: Update supported modes for GC v9.5.0
      drm/amdgpu: Update external revid for GC v9.5.0
      drm/amdgpu: Add NULL check for asic_funcs

Mario Limonciello (3):
      drm/amd: Restore cached power limit during resume
      drm/amd: Restore cached manual clock settings during resume
      drm/amd/display: Revert "drm/amd/display: Fix AMDGPU_MAX_BL_LEVEL val=
ue"

Michal Wajdeczko (3):
      drm/xe/pf: Enable SR-IOV PF mode by default
      drm/xe/pf: Disable PF restart worker on device removal
      drm/xe/pf: Make sure PF is ready to configure VFs

Michel D=C3=A4nzer (1):
      drm/amd/display: Add primary plane to commits for correct VRR handlin=
g

Simon Richter (1):
      Mark xe driver as BROKEN if kernel page size is not 4kB

Siyang Liu (1):
      drm/amd/display: fix a Null pointer dereference vulnerability

Timur Krist=C3=B3f (2):
      drm/amd/display: Don't overwrite dce60_clk_mgr
      drm/amd/display: Fix DCE 6.0 and 6.4 PLL programming.

Xaver Hugl (1):
      amdgpu/amdgpu_discovery: increase timeout limit for IFWI init

YuanShang (1):
      drm/amdgpu: Retain job->vm in amdgpu_job_prepare_job

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |  76 +++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |   7 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c           |   3 +-
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c         |   5 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c          |  57 +++++-----
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c            | 121 +++++++++++++++++=
++--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   2 +
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_module.c            |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |  61 +++++++++--
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |  20 +++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   8 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |   9 ++
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c   |   1 -
 .../amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c    |   5 +
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  19 ++--
 .../amd/display/dc/resource/dce60/dce60_resource.c |  34 +++---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  16 +++
 drivers/gpu/drm/i915/display/intel_cx0_phy.c       |  21 +++-
 drivers/gpu/drm/xe/Kconfig                         |   1 +
 drivers/gpu/drm/xe/xe_device.c                     |   8 +-
 drivers/gpu/drm/xe/xe_gt_sriov_pf.c                |  57 +++++++++-
 drivers/gpu/drm/xe/xe_gt_sriov_pf.h                |   1 +
 drivers/gpu/drm/xe/xe_gt_sriov_pf_debugfs.c        |   4 +-
 drivers/gpu/drm/xe/xe_guc_capture.c                |   6 +
 drivers/gpu/drm/xe/xe_module.c                     |   8 +-
 drivers/gpu/drm/xe/xe_pci_sriov.c                  |   7 +-
 drivers/gpu/drm/xe/xe_sriov_pf.c                   |  27 +++++
 drivers/gpu/drm/xe/xe_sriov_pf.h                   |   1 +
 31 files changed, 456 insertions(+), 141 deletions(-)


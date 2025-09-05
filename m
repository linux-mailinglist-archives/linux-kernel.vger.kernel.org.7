Return-Path: <linux-kernel+bounces-801998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1C0B44CA2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8CC3AE947
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9E223BD17;
	Fri,  5 Sep 2025 04:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUsI/BmH"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CFDCA5A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 04:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757045587; cv=none; b=qxb1ysV/X3/g/pB5vty+Pg2cmTngIl0G2kuznX7CssToemkaFmkPaXy36Dpz/WYZ3qs697jofxjgD7g4t5XUztAABSm/vdxDQbHjTY1q6/+6u8Y4f4XdMovcaKnJ3tDF+Hbuj+7LhZ7VJpZ8Ofewny0LNVT9/2D1EICgoiHczC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757045587; c=relaxed/simple;
	bh=4/TRNazzJQeaVknrIIwKnUt7Fc9zO9Jji3Nrzblp9e0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cNyGhy1bNgsJRnvLZvWBnnj7KYRq9YSDdMgZ3vwHI5TCDV79DjvzEh0/0MHS+jUKrPGEkRI66jPMUnWy8WaoIVA7IgX6iNX+pAEXdi23qs68DsNSGhmF3BMz0/Pz/myxUwBbbgYHlm7i6Pp4L7ZEjV8kP3+8h9Kun2m696MrrPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUsI/BmH; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-621b8b0893bso65503a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 21:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757045584; x=1757650384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KrWnGnxa3ZyzmRkYI/9k6bgQOkZyS8I4F7Ovw9oMlQU=;
        b=lUsI/BmHuFcPW2La6P1xMgoYplpjF32vT4ePjgKQ78fp1SwPELQUrsdqBJPBC8DaSt
         duPPnvotuMjU0ZXDFkCCTwtc4xt97fA9jjULz0X/xKE4NyUlxyctUl2L4qEqaJvHe7HF
         6oAr+mbrAnRVi2JLMFbF3KT7xny310bUmO0MMXVr63S0jloZBCxS+SV7hkWT5szEmM9z
         MjhU8MGPMExUfm2j6vh+OET4fMc79ttL/ePKmWbHSHgic+4SkV1lN4XHRi5u3nWkfEoX
         0JYEj0auUlJXyeFndk6iUPcrpk0t9apzmFIJ/0IHz6LRtWuZaP1w9n7ugB8D4XpvmzBi
         hjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757045584; x=1757650384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KrWnGnxa3ZyzmRkYI/9k6bgQOkZyS8I4F7Ovw9oMlQU=;
        b=HnG17Kd1JmrlhmQ7g1Cp7S+4kdsTeBGlr9RoxYZxj2rsikepUsu6eEjHF/SIlDJcyf
         PxFW+YLuf233j/9DRJKM+rSQ1cWmJXyYpFWM8XQ0Tl/ZlWvrdbT9Y4/AqiZFZeGlXPeJ
         xrVpj2oRU9Z8mQ7h6gGoBntJjw/yeQZOZGDNSPnukSK8XVhEIb6GRHWuyk30ZJc4gfE6
         yYnm0hXw9NLTqkrGcVglJu4Mc5k21/6kxND7yL+DzNGBm3s/gvjYGkH8x+rU+CpJc7bj
         tscxzJkW93mbu/tSVOQADlgwcPB/EwWUdkpR9tX2wdwigmk3Gj4tduLEOyM2Dfv0QAFs
         8dvA==
X-Forwarded-Encrypted: i=1; AJvYcCWTpz4eWBrMJ9rZyzXKUu9lase5FlOVPgeuFQzDGnG7pULCue6fy1gtAEsY8eRxdRZ6hZvQWbdk3g2PD1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGI3xwZFIBhd2iX9/mbfPvQ7cNNL4CMMw/ScdQtEkY2n9qwxSG
	5s7u92+xAFisuPvHRY+VjZ8awdhFE3W+yAeLw/mObgOKivy2sflfwj8pBkyjl0gLmiF3MB0/NLI
	fLv4m7N5bkjME/rPUEikG/yDXUTFqd2Q=
X-Gm-Gg: ASbGncvCgjkhJdYx+W7j+rxhT7IFMX5dJc8LGSXDnXapIdA/LPWIO2X7DYr+BmwGUTg
	02A8MFOImG5HVU0+u4DJYBkKOZ1+N30QT3covaVptF7NS77mZBTUAX4JJQ/DgMnmTVqUi0RQzKX
	GOWLsJKeJ7MXChLrAz28ivjeDN1BOAZR4WI4gCWkallywKR4GSb8P8RetWdOc7B65wNvQMY2SRE
	Jp+kYXlCJO7plttNKHzmggqSUg=
X-Google-Smtp-Source: AGHT+IEGYPmHKSHEICSzF+d8fZa9yfkbd7BcogyVCTDPOqRiOrrEPpLDzglQacZqaoB1+90R1sj1QHtFClLH0IlvIec=
X-Received: by 2002:a17:907:3f13:b0:b04:830f:822d with SMTP id
 a640c23a62f3a-b04830fb950mr457621766b.63.1757045584035; Thu, 04 Sep 2025
 21:13:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 5 Sep 2025 14:12:52 +1000
X-Gm-Features: Ac12FXzUJUH7iKinFb4_on0LQunMxw-L-dNUA679WdcIPzHioIDA3Nj8jaClEvc
Message-ID: <CAPM=9txcDaRBOKZEWzAcDsdT=APUzcSicYA=-fno+52zGz0bOA@mail.gmail.com>
Subject: [git pull] drm fixes for 6.17-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Weekly drm fixes roundup, nouveau has two fixes for fence/irq racing
problems that should fix a bunch of instability in userspace.
Otherwise amdgpu along with some single fixes to bridge, xe, ivpu.
Looks about usual for this time in the release.

Regards,
Dave.

drm-fixes-2025-09-05:
drm fixes for 6.17-rc5

scheduler:
- fix race in unschedulable tracepoint

bridge:
- ti-sn65dsi86: fix REFCLK setting

xe:
- Fix incorrect migration of backed-up object to VRAM

amdgpu:
- UserQ fixes
- MES 11 fix
- eDP/LVDS fix
- Fix non-DC audio clean up
- Fix duplicate cursor issue
- Fix error path in PSP init

nouveau:
- fix nonstall interrupt handling
- fix race on fence vs irq emission
- update MAINTAINERS entry

ivpu:
- prevent recovery work during device remove
The following changes since commit b320789d6883cc00ac78ce83bccbfe7ed58afcf0=
:

  Linux 6.17-rc4 (2025-08-31 15:33:07 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-09-05

for you to fetch changes up to 8b556ddeee8da9420699ce221b6267f395e7d72b:

  Merge tag 'amd-drm-fixes-6.17-2025-09-03' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2025-09-05
08:06:34 +1000)

----------------------------------------------------------------
drm fixes for 6.17-rc5

scheduler:
- fix race in unschedulable tracepoint

bridge:
- ti-sn65dsi86: fix REFCLK setting

xe:
- Fix incorrect migration of backed-up object to VRAM

amdgpu:
- UserQ fixes
- MES 11 fix
- eDP/LVDS fix
- Fix non-DC audio clean up
- Fix duplicate cursor issue
- Fix error path in PSP init

nouveau:
- fix nonstall interrupt handling
- fix race on fence vs irq emission
- update MAINTAINERS entry

ivpu:
- prevent recovery work during device remove

----------------------------------------------------------------
Alex Deucher (2):
      drm/amdgpu/mes11: make MES_MISC_OP_CHANGE_CONFIG failure non-fatal
      drm/amdgpu: drop hw access in non-DC audio fini

Colin Ian King (1):
      drm/amd/amdgpu: Fix missing error return on kzalloc failure

Dave Airlie (4):
      nouveau: fix disabling the nonstall irq due to storm code
      Merge tag 'drm-misc-fixes-2025-09-03' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2025-09-03' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-6.17-2025-09-03' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Faith Ekstrand (1):
      nouveau: Membar before between semaphore writes and the interrupt

Ivan Lipski (1):
      drm/amd/display: Clear the CUR_ENABLE register on DCN314 w/out DPP PG

James Jones (1):
      MAINTAINERS: Update git entry for nouveau

Jesse.Zhang (1):
      drm/amdgpu/sdma: bump firmware version checks for user queue support

Karol Wachowski (1):
      accel/ivpu: Prevent recovery work from being queued during device rem=
oval

Mario Limonciello (1):
      drm/amd: Re-enable common modes for eDP and LVDS

Michael Walle (1):
      drm/bridge: ti-sn65dsi86: fix REFCLK setting

Pierre-Eric Pelloux-Prayer (1):
      drm/sched: Fix racy access to drm_sched_entity.dependency

Thomas Hellstr=C3=B6m (1):
      drm/xe: Fix incorrect migration of backed-up object to VRAM

 MAINTAINERS                                        |  2 +-
 drivers/accel/ivpu/ivpu_drv.c                      |  2 +-
 drivers/accel/ivpu/ivpu_pm.c                       |  4 +-
 drivers/accel/ivpu/ivpu_pm.h                       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |  5 --
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c             |  5 --
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |  5 --
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |  5 --
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |  5 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c             |  6 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  3 +-
 .../gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c   |  9 +++
 .../gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h   |  2 +
 .../gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c   |  1 +
 .../drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c  | 72 ++++++++++++++++++
 .../drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h  |  2 +
 .../drm/amd/display/dc/hwss/dcn314/dcn314_init.c   |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h        |  3 +
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              | 11 +++
 drivers/gpu/drm/nouveau/gv100_fence.c              |  7 +-
 .../gpu/drm/nouveau/include/nvhw/class/clc36f.h    | 85 ++++++++++++++++++=
++++
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c    |  2 +
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c   | 23 ++++--
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga102.c   |  1 +
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h    |  2 +
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fifo.c |  1 +
 drivers/gpu/drm/scheduler/sched_entity.c           | 11 ++-
 drivers/gpu/drm/xe/xe_bo.c                         |  3 +-
 29 files changed, 234 insertions(+), 48 deletions(-)


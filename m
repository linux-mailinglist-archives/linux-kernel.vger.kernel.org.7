Return-Path: <linux-kernel+bounces-813181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 827AAB541B0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E185A6481
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E601259CA0;
	Fri, 12 Sep 2025 04:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqLKHKkM"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C3D79CD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757651107; cv=none; b=Dqb2If/Jo0/Ldgs0oTrvH0lfvI83Nr1mmvezwLBi2r1o2vVYNamVnhyRXopbQOm5lul/cHiHdP9BV/YQO1fhLoqZugiOMnzcJy9DI0hGkCAxin7kCp89qeLgPG6GvUTjR5iH6b9DFQyIz2g6LpTHmrCqO5pU2bqCSMsEqOU6zfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757651107; c=relaxed/simple;
	bh=MJ+OEqw3W4T5IAGM29vemB7Sj1MEMNdfpUxr8ROwG4M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=he3BqzJQMLiVFlwe7mUdhGlVthH6UmVst1cds2UtHbPX79UJ351pXH1DvkzIlPxKMLt0QYj6+0ZGXJ6I5zWHcPlzlbb94QBNCFjZ1EeU3zZ7Azjk4HPF2QYZl1vkcQaP6aBTax6VdP298oaRyYz9+8LK9g98sosMsIYtwOrdAmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqLKHKkM; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b04770a25f2so197588166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757651104; x=1758255904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eTpfDhKZKGj4qUCT1cR1rKoQBELJN9ms9wYW6BhTZYw=;
        b=KqLKHKkMPqCKRKfPr1o2JaiQz7jrC7IKLdyou+rvaoB+kwOwVH/J1T1ftO5Omu3Is0
         g29trTw/Yu1nk8hFLzjCudbzVeYhM4cBGZgweagBSwLh0wHRc0hRiCM+/zLryDifPbms
         BKjq0n4aMEQwN0TpFg57Rk2qRS1cw85zzruUmvxJA2DE2EYRAUu9RMFrkU7m2BxOhzA2
         MqSDA5E5URz8SirsQpvpHiEkXXFOI6BHiLIgda4THAGulYY8U0jplZf6EAX61PUKS1n/
         KeldzvQE7oulSutzJL/X6PVpnu393KM66Rt9BtzOBJOq81OhzDw1ti/u+gQnCzZRLPOm
         OoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757651104; x=1758255904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eTpfDhKZKGj4qUCT1cR1rKoQBELJN9ms9wYW6BhTZYw=;
        b=CYPbQG539Y8fvzPgALhK/+VKijQz30jwuKs9t0P+JWUxkWMvwpr9SAEowN1ctWyiDg
         dOlqONOn6yQUBpzU9mK1rLDTMM2ElENyRnuT+C64VKxV1q5q/YVgU353L5Wy1E5HSung
         dkO9r2wLtR92W5fBIdT2y/WAq4OVrRDrx6GORCfbaeabYw9CWcF1T+6nUik4pbGA4n+F
         NOoVLvHN3ur+c83m7fG/z0svKQbSrZDG65VoTzEr55fF/uWDVsJybVcfy0WXo2mBHlSp
         UC64I7M/lNATkuzGgNJufW4m4aEhrtTzit+474xvklYuSoQWEyIyKt0rdNRs1r13CMFw
         h2vw==
X-Forwarded-Encrypted: i=1; AJvYcCUtCuJL4kaSlb2+yPobMHFiPlKo2BiGUE9XqHaYEL9z5x8m+hTnF+aMNItUjPXqFZwtXkiUjyGTLhcimLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL5bfdUTgWAIjlAKk2bxrs9w7WGfTHOpE7v7kwcvcOPt45l9+o
	+mgL7Knx8oe3QLdu32h6QpQv7JZybNlPk9FhlMqDkrHc29SBW5mzEwS/nBve/Rp520MKLTrmOrv
	7DmEF5yM9yqMncA6uQslbOgkpmGM+0Y+4Hp0X
X-Gm-Gg: ASbGncuWq3lpxXAgWEFigg+iUPcIhTJ46IOqhtjXnFNYTpbtYNIq04b/eKfAp2XFhRK
	43SFf+77DLQOdTnTDPQa6sXw3rC4lL5xfEZYLp0ACU22mFC/EOs1XlIuqMzKpIezImq1+JaeVPr
	3ugimWkYclvVQdLestkU+VIVY7bDx6M+SxVW6C6B9UkTfRZd+RsmCFPsbjWaEezZgM32qgiU+VY
	hZoOBI5d6MkzPZ+
X-Google-Smtp-Source: AGHT+IEXSRmeO+SUrxw7GBflD78Eg9mdvfufxQ0v5uU+9KneT3xXzPsYzNp4K9z7+TbLn+gMKd+63JZZo3o6I4PAFY8=
X-Received: by 2002:a17:907:d28:b0:afe:93e2:3984 with SMTP id
 a640c23a62f3a-b07c354e9a9mr140643366b.8.1757651103880; Thu, 11 Sep 2025
 21:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 12 Sep 2025 14:24:52 +1000
X-Gm-Features: AS18NWBUzsEWSObkvBAOENiHkso8qf9n9rBTgoeb2zFWGbzoXcbQBC4RuM1QR04
Message-ID: <CAPM=9tw1QOZSBq+QhAbpyc9UvY7KYTfA+K=JQyo+_u+nBcTdGw@mail.gmail.com>
Subject: [git pull] drm fixes for 6.17-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Weekly pull fixes for drm, mostly amdgpu and xe, with a revert for
nouveau and some maintainers updates, and misc bits, doesn't seem too
out of the normal.

Regards,
Dave.

drm-fixes-2025-09-12:
drm fixes for 6.17-rc6

MAINTAINERS:
- add rust tree to MAINTAINERS
- fix X entries for nova/nouveau

nova:
- depend on 64-bit

i915:
- Fix size for for_each_set_bit() in abox iteration

xe:
- Don't touch survivability_mode on fini
- Fixes around eviction and suspend
- Extend Wa_13011645652 to PTL-H, WCL

amdgpu:
- PSP 11.x fix
- DPCD quirk handing fix
- DCN 3.5 PG fix
- Audio suspend fix
- OEM i2c clean up fix
- Module unload memory leak fix
- DC delay fix
- ISP firmware fix
- VCN fixes

amdkfd:
- P2P topology fix
- APU mem limit calculation fix

mediatek:
- fix potential OF node use-after-free

panthor:
- out-of-bounds check

nouveau:
- revert waitqueue removal for sched teardown
The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c=
:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-09-12

for you to fetch changes up to 9a3f210737e958c3f45a4ce0d7f1ff330af3965f:

  Merge tag 'drm-xe-fixes-2025-09-11' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2025-09-12 09:44:07 +1000)

----------------------------------------------------------------
drm fixes for 6.17-rc6

MAINTAINERS:
- add rust tree to MAINTAINERS
- fix X entries for nova/nouveau

nova:
- depend on 64-bit

i915:
- Fix size for for_each_set_bit() in abox iteration

xe:
- Don't touch survivability_mode on fini
- Fixes around eviction and suspend
- Extend Wa_13011645652 to PTL-H, WCL

amdgpu:
- PSP 11.x fix
- DPCD quirk handing fix
- DCN 3.5 PG fix
- Audio suspend fix
- OEM i2c clean up fix
- Module unload memory leak fix
- DC delay fix
- ISP firmware fix
- VCN fixes

amdkfd:
- P2P topology fix
- APU mem limit calculation fix

mediatek:
- fix potential OF node use-after-free

panthor:
- out-of-bounds check

nouveau:
- revert waitqueue removal for sched teardown

----------------------------------------------------------------
Alex Deucher (2):
      drm/amdgpu: fix a memory leak in fence cleanup when unloading
      drm/amd/display: use udelay rather than fsleep

Chia-I Wu (1):
      drm/panthor: validate group queue count

Danilo Krummrich (3):
      gpu: nova-core: depend on CONFIG_64BIT
      MAINTAINERS: Add drm-rust tree for Rust DRM drivers and infrastructur=
e
      MAINTAINERS: drm-misc: fix X: entries for nova/nouveau

Dave Airlie (6):
      Merge tag 'drm-rust-fixes-2025-09-05' of
https://gitlab.freedesktop.org/drm/rust/kernel into drm-fixes
      Merge tag 'drm-intel-fixes-2025-09-10' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'amd-drm-fixes-6.17-2025-09-10' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'mediatek-drm-fixes-20250910' of
https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux
into drm-fixes
      Merge tag 'drm-misc-fixes-2025-09-11' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2025-09-11' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

David Rosca (2):
      drm/amdgpu/vcn4: Fix IB parsing with multiple engine info packages
      drm/amdgpu/vcn: Allow limiting ctx to instance 0 for AV1 at any time

Eric Huang (1):
      drm/amdkfd: fix p2p links bug in topology

Fangzhi Zuo (1):
      drm/amd/display: Disable DPCD Probe Quirk

Geoffrey McRae (1):
      drm/amd/display: remove oem i2c adapter on finish

Jani Nikula (1):
      drm/i915/power: fix size for for_each_set_bit() in abox iteration

Johan Hovold (2):
      drm/mediatek: fix potential OF node use-after-free
      drm/mediatek: clean up driver data initialisation

Julia Filipchuk (1):
      drm/xe: Extend Wa_13011645652 to PTL-H, WCL

Lijo Lazar (1):
      drm/amdgpu: Wait for bootloader after PSPv11 reset

Mario Limonciello (AMD) (1):
      drm/amd/display: Drop dm_prepare_suspend() and dm_complete()

Michal Wajdeczko (1):
      drm/xe/configfs: Don't touch survivability_mode on fini

Ovidiu Bunea (1):
      drm/amd/display: Correct sequences and delays for DCN35 PG & RCG

Philipp Stanner (1):
      Revert "drm/nouveau: Remove waitque for sched teardown"

Pratap Nirujogi (1):
      drm/amd/amdgpu: Declare isp firmware binary file

Thomas Hellstr=C3=B6m (3):
      drm/xe: Attempt to bring bos back to VRAM after eviction
      drm/xe: Allow the pm notifier to continue on failure
      drm/xe: Block exec and rebind worker while evicting for suspend
/ hibernate

Yifan Zhang (1):
      amd/amdkfd: correct mem limit calculation for small APUs

 MAINTAINERS                                        |  13 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  44 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |   2 -
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c            |   2 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |  19 +---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              |  12 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              |  60 +++++------
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |   3 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  34 +++---
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   1 +
 drivers/gpu/drm/amd/display/dc/dc.h                |   1 +
 .../gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c |  74 ++++++-------
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |   2 +-
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    | 115 ++++-------------=
----
 .../gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c |   3 -
 .../drm/amd/display/dc/hwss/dcn351/dcn351_init.c   |   3 -
 drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h    |   1 +
 .../drm/amd/display/dc/pg/dcn35/dcn35_pg_cntl.c    |  78 +++++++++-----
 drivers/gpu/drm/i915/display/intel_display_power.c |   6 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  23 ++---
 drivers/gpu/drm/nouveau/nouveau_fence.c            |  15 ---
 drivers/gpu/drm/nouveau/nouveau_fence.h            |   1 -
 drivers/gpu/drm/nouveau/nouveau_sched.c            |  35 +++----
 drivers/gpu/drm/nouveau/nouveau_sched.h            |   9 +-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c             |   8 +-
 drivers/gpu/drm/panthor/panthor_drv.c              |   2 +-
 drivers/gpu/drm/xe/tests/xe_bo.c                   |   2 +-
 drivers/gpu/drm/xe/tests/xe_dma_buf.c              |  10 +-
 drivers/gpu/drm/xe/xe_bo.c                         |  16 ++-
 drivers/gpu/drm/xe/xe_bo.h                         |   2 +-
 drivers/gpu/drm/xe/xe_device_types.h               |   6 ++
 drivers/gpu/drm/xe/xe_dma_buf.c                    |   2 +-
 drivers/gpu/drm/xe/xe_exec.c                       |   9 ++
 drivers/gpu/drm/xe/xe_pm.c                         |  42 ++++++--
 drivers/gpu/drm/xe/xe_survivability_mode.c         |   3 +-
 drivers/gpu/drm/xe/xe_vm.c                         |  42 +++++++-
 drivers/gpu/drm/xe/xe_vm.h                         |   2 +
 drivers/gpu/drm/xe/xe_vm_types.h                   |   5 +
 drivers/gpu/drm/xe/xe_wa_oob.rules                 |   3 +-
 drivers/gpu/nova-core/Kconfig                      |   1 +
 40 files changed, 364 insertions(+), 347 deletions(-)


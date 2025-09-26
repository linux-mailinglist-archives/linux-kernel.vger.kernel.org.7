Return-Path: <linux-kernel+bounces-833596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64283BA2619
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E83B4E1488
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 04:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B882080C8;
	Fri, 26 Sep 2025 04:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQMs5L8L"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E297E56A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 04:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758860549; cv=none; b=QpJzOzw+vz8OeD9/+PCPcjTfTec8acoSltc/yk8k2fV+vF4d6dhRxSfvQyBu9uDDiWdfNXClXwTRTlkp/eUixDX3pS5GzQKLOuRqydFdnwLkmY2SFOLNB/I3bNiwSbsbQRkF7g0rPIO6VReTJjpOKkHf8H335wphpZAl1nlMkFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758860549; c=relaxed/simple;
	bh=/VafJdqV7BC0/nt55SNh1umRtMHM9im+WFknv4KdTsE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jJQUJbb0V3VyoBAZU7DsM42SrNN+hPWypSeb3CWl3siBJxg9WRacDXI2EJOW3Z/6b4ggVvA8QO7BCSw5/WcALb6I4tq53p2N/b8lIIZHDciycEq1v7eQeuwlnEoVgTUACxKhf0yffeC8t4vNl4AWtEDLGeN5Yktlg+4iVLixJb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQMs5L8L; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-631787faf35so3367644a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758860546; x=1759465346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6saHKE8v7y3gcL2pFVLakX6jbgxVNkxceljx6TZ2T70=;
        b=iQMs5L8L6eHVvbVKPaHa3M+WocETq+d6XDhYzHCvJyW6E/yhCub34uIiKD6OfU0sY/
         Q9jqWo4p5OYA+EJog0Y8sel/XY9YzD6KMT548lwMidOQJdquTB5dFp3fCNFj/P6Wkc2f
         OhypA0hJHHkFMROrga8cRUHT/TYWZyRtEF8SNiJxWf2/MbfPfr0pbCie1l1wETpSXVrX
         Pimeb+fTDt7okOe3vgJphHVV3nqpIeBo/JVynO8mubB2onYt0zJRTzlffstIEXDOYXTE
         u7DkEWzzYlhKSyNZxh8maMaXj3odB4ZtBO5Q17//5AQs5dTDhnyS67hDW/60SHMjONaT
         g42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758860546; x=1759465346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6saHKE8v7y3gcL2pFVLakX6jbgxVNkxceljx6TZ2T70=;
        b=kzlpz8udv+lfJlM7JnlFq7vn9Ju5xZ70ZQ2F817QZzagwpEbW66TJ9TG7Z75CQ27ob
         O3sTdVIA5k/EORpB8F4j9ULUuc7IDNXtVcTz+C9p6cGTYvXAS5DnQdOeMPswVu7S5zzv
         P93p3fkBxztNUGgPsX5EopvtJ1LymxSaRFNONOF8JhuQS4C5V4klM5fbC8ONest33YsC
         bNC7VOH7+i0azmDrTT/jkTnmpM8PMTKWJqoKfixtcXcTSM09vU7mxtti5ovNHoREdSjS
         +njNP9VeJhJZpUKF/cJygVLZ+lH9C9ia9JgXQZ8h2wkK+u1pvxp+gHF5p4VbPVg5/MCz
         SmZw==
X-Forwarded-Encrypted: i=1; AJvYcCVl3+zENZqBcL3LGu7PkrKbcb6EWUMZ2ZmD1LN/c3LPO9Mclp2uVFOY706jXYtWHnGofGwVAFLVUU7pnBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdjN4cvAZ1TwwkIgsaUe9G2dlRTPzfJdELfd4LVA51SvlIn4dC
	pb8vRB9Lo2jcXFxU13GwivGWStZSw+OGOp4azCuUgxGHAYP1UECf32g63xkn2POr09sLt56pkEZ
	5vHQ/Wbaa+YnsmjJdFuloWtsbB5AL6PnKlKQp6NY=
X-Gm-Gg: ASbGncuwooRK6DfxTFevnP/0AZ6hMQgpBpq1lzrsGIZ32kpnIKMidYVKYxR0j0VGxeN
	D4VC+8MDikoSOWxp/qvCTpkWA38fH/DCSMj0c1gW4wUUH5Y6r2DK2l4vTZ2trZKRuE0KuyT08Ff
	Yr24pPOPvMQjjETlUm6OJi6rIa/UVzwnZGIO4de49/By3P4kdpRF80TxM5pkIpJ0HpWzUnFO9Hm
	q0olA==
X-Google-Smtp-Source: AGHT+IGZTAi6DT1z6+587DJEbV3xm9kNdP6C1CTZDGuxoUy/1fygNYaDU74eh8/YF1hzWhdbSc5971CCOlTNEukKm3k=
X-Received: by 2002:a17:906:6a07:b0:b2c:15aa:ff51 with SMTP id
 a640c23a62f3a-b34b7cd20dbmr648168666b.14.1758860546252; Thu, 25 Sep 2025
 21:22:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 26 Sep 2025 14:22:14 +1000
X-Gm-Features: AS18NWDkoDaygCPdummng72PiouEdLbrYJDxgW0DrRhuYo-0kGYuJgXPk7JeUOw
Message-ID: <CAPM=9tyfHf9jLv36vvc9=sRt0OWk-jTVq8n8uRJvu2O5a9X5bg@mail.gmail.com>
Subject: [git pull] drm fixes for 6.17-rc8/final
To: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Linus,

Weekly fixes, some fbcon font handling fixes, then amdgpu/xe/i915 with
a few, and a few misc fixes for other drivers. Seems about right for
this stage, and I don't know of anything outstanding.

Regards,
Dave.

drm-fixes-2025-09-26:
drm fixes for 6.17-rc8 (or final)

fbcon:
- fix OOB access in font allocation
- fix integer overflow in font handling

amdgpu:
- Backlight fix
- DC preblend fix
- DCN 3.5 fix
- Cleanup output_tf_change

xe:
- Don't expose sysfs attributes not applicable for VFs
- Fix build with CONFIG_MODULES=3Dn
- Don't copy pinned kernel bos twice on suspend

i915:
- Set O_LARGEFILE in __create_shmem()
- Guard reg_val against a INVALID_TRANSCODER [ddi]

ast:
- sleeps causing cpu stall fix

panthor:
- scheduler race condition fix

gma500:
- NULL ptr deref in hdmi teardown fix
The following changes since commit 07e27ad16399afcd693be20211b0dfae63e0615f=
:

  Linux 6.17-rc7 (2025-09-21 15:08:52 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-09-26

for you to fetch changes up to ec73e5984e01bfdf92234eaf5a2c3e54aa67f2aa:

  Merge tag 'drm-xe-fixes-2025-09-25' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
(2025-09-26 14:12:33 +1000)

----------------------------------------------------------------
drm fixes for 6.17-rc8 (or final)

fbcon:
- fix OOB access in font allocation
- fix integer overflow in font handling

amdgpu:
- Backlight fix
- DC preblend fix
- DCN 3.5 fix
- Cleanup output_tf_change

xe:
- Don't expose sysfs attributes not applicable for VFs
- Fix build with CONFIG_MODULES=3Dn
- Don't copy pinned kernel bos twice on suspend

i915:
- Set O_LARGEFILE in __create_shmem()
- Guard reg_val against a INVALID_TRANSCODER [ddi]

ast:
- sleeps causing cpu stall fix

panthor:
- scheduler race condition fix

gma500:
- NULL ptr deref in hdmi teardown fix

----------------------------------------------------------------
Adri=C3=A1n Larumbe (1):
      drm/panthor: Defer scheduler entitiy destruction to queue release

Alvin Lee (1):
      drm/amd/display: Use mpc.preblend flag to indicate preblend

Dave Airlie (4):
      Merge tag 'amd-drm-fixes-6.17-2025-09-24' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2025-09-25' of
https://gitlab.freedesktop.org/drm/i915/kernel into drm-fixes
      Merge tag 'drm-misc-fixes-2025-09-25' of
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes
      Merge tag 'drm-xe-fixes-2025-09-25' of
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes

Leo Li (1):
      drm/amd/display: Init DCN35 clocks from pre-os HW values

Lucas De Marchi (1):
      drm/xe: Fix build with CONFIG_MODULES=3Dn

Matthew Schwartz (1):
      drm/amd/display: Only restore backlight after amdgpu_dm_init or dm_re=
sume

Melissa Wen (1):
      drm/amd/display: remove output_tf_change flag

Michal Wajdeczko (1):
      drm/xe/vf: Don't expose sysfs attributes not applicable for VFs

Nirmoy Das (1):
      drm/ast: Use msleep instead of mdelay for edid read

Samasth Norway Ananda (1):
      fbcon: fix integer overflow in fbcon_do_set_font

Suraj Kandpal (1):
      drm/i915/ddi: Guard reg_val against a INVALID_TRANSCODER

Taotao Chen (1):
      drm/i915: set O_LARGEFILE in __create_shmem()

Thomas Hellstr=C3=B6m (1):
      drm/xe: Don't copy pinned kernel bos twice on suspend

Thomas Zimmermann (1):
      fbcon: Fix OOB access in font allocation

Zabelin Nikita (1):
      drm/gma500: Fix null dereference in hdmi teardown

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  12 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   7 ++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |   2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |   2 +-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   | 121 +++++++++++++++++=
+++-
 drivers/gpu/drm/amd/display/dc/dc.h                |   1 -
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c    |   6 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |   6 +-
 drivers/gpu/drm/ast/ast_dp.c                       |   2 +-
 drivers/gpu/drm/gma500/oaktrail_hdmi.c             |   2 +-
 drivers/gpu/drm/i915/display/intel_ddi.c           |   5 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c          |   7 ++
 drivers/gpu/drm/panthor/panthor_sched.c            |   8 +-
 drivers/gpu/drm/xe/xe_bo_evict.c                   |   4 +-
 drivers/gpu/drm/xe/xe_configfs.c                   |   2 +-
 drivers/gpu/drm/xe/xe_device_sysfs.c               |   2 +-
 drivers/video/fbdev/core/fbcon.c                   |  13 ++-
 17 files changed, 167 insertions(+), 35 deletions(-)


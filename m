Return-Path: <linux-kernel+bounces-848622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F6BBCE30A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1E3547529
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6477C2F3C1E;
	Fri, 10 Oct 2025 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvwRUBTZ"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3611A2545
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760119671; cv=none; b=SzS1/fb0G3kqLKdIYYGasZw0RU5en442bbYNiPru+P3Ej7+GN5VNxqB7j/Uqljjv5WA2Y/zEyi/uryIX9hoO5+DYo+Oifpry+xrYTo1B2GiyhV7rpVs5hhMSuPPTe7ZbTut0kRC1RRa5xSg4acd+jyTQYN4IEtHi6WdorZLxrak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760119671; c=relaxed/simple;
	bh=wqfBWxmDIQi5vwtC1MbdIcpo0h3rSX9ClNyEAV6ccYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BLcBoqF3RfpLXI4PU4SMEEzU/t8fjVkpMrk+qPB7SImWx1SGGupG5A1DyBt0xT1mxbH/PV4q4N6P8YGL3Qb5Un8GLcl9xGDJ41QXtz0V0/nRWnjpZwTQ5qZ7lNNkCsZA6KviogkyuOdLXwFq+OCSLCdlFWG3QCuxXNs81/EFau4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvwRUBTZ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62f24b7be4fso4346111a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760119668; x=1760724468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BhxK1GJK5sA7N9K5yZGCGEkUd+inQEG5jk/d8suAk4A=;
        b=BvwRUBTZeBMp0U9s0lg2I0D8mhcBltBNzBEe2M7TUtCqWM5FvKWN53YmKGt/EVPhPr
         O6fQC96uJUGoJXtJkPCQHaCjdQfcLgF8r1sWE0rMAX0Pa/C5mCSad9zzkBZ6E6BDaVGt
         VrJMjIqDCsVRdDDyJbRxb4oWFXYBI5bQ6BzVAwaw8A70/IcmAId57ga1Gs99S2SxnO3C
         OJGBHJwkJSGMivpfJvkmCz+RGIV7Y841diSh1H9CZni7bQSN4itvsEZS7fOwhbEodMED
         N7pw0F26I/WjMMRorH94yeD+/0GzhZULbKmf7eVdz2L3D00KAUZmLilVw8mAqqoh1i3D
         Et6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760119668; x=1760724468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhxK1GJK5sA7N9K5yZGCGEkUd+inQEG5jk/d8suAk4A=;
        b=J4DDab+IF4bW9LGApiHq6nMAD8xygi8HmfI1rpukUCUBJE3KIIMk8eP5mMOSyGtK+y
         fNdWTdOsTqt2/iOQUWb+5XZI67LV24I5iBqpzbep9G64LuqiX3hLTcW2dQfpZuh/LckQ
         nj04I1QQcLfmPdNn5l3xUT9iGTSJwJfi87gVfJZ8HjTpAiB8hCwd3Yd9tFD8emNgYlcI
         UkkZz4FJHJLIAdnRn+HJehVvFYlZvEh/qPXdckKVugoDiuMxZtw3L/Aj7BrqooSk5Rkz
         ZsghtlTvEiiHbgWuPkMMsLkKv9VIBhcqQFSamvpBC+lVZqgFxpmxeWtXQsyk1DEbN4Gi
         VXmg==
X-Forwarded-Encrypted: i=1; AJvYcCWiIKfYyxBHnJC8F89xFhEXgFxtZLqiu4XwZhGoKS2wWiPR/bqF9xa5Gmif2THmQg9n2fUyXVpDJ6PvEJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxDIfoU/hvFUc4NCaLtX9mpLajya0Y+k5NH/qO3cx4+HoLx88o
	Is1JWY/7De4S9Yk0i/bLuDSEDVMRncSvZcrcIaobrFTeB4D/Fdam013B9nN09A==
X-Gm-Gg: ASbGncum6DKMp8bFkgSwE7A9Mo7ObJwH6Vp6b++OU6A5qet+4b4aH3lQyKsJSEuE95l
	bUb71qGqvKB8fjD5XMDUM7UwSLCp4N4y9gOdIrqeS42pM4CtYNHRQxotXmI6s1m0EKULnpQsq8u
	Co00KqROaW6FqMuIhSIddc5KZ59IIeb4TfQDjoUqYPpVsMUfqyUQgflBaf5Wr4hpqgslrrDCSfQ
	iaXQAFNKlqacAaBrmq2PPfJwF5sX+snrlJkbXZudzIm3DnoF3DKRpULgF+ZCOalltyXoTbHDxTH
	jZzYnI+9VuzCYEUAAxUB6b+voTo+ZUp+HOENkuPJCaZkB1GJ1qIStp0/aEPQr81hF5HzvHExIfD
	tdCqCD8hT5F9Jc84NCuxq4aFhxP7s2A2PPayLyLbKAIPRPHkq9ZEBg0xqoWgFelqlle8MvxvStY
	zMvxFDSRh/
X-Google-Smtp-Source: AGHT+IFtha2OqKiOJaCe8DsE10T8YUc7pDffBcQTX15Aqoy/DyULhpRhI6gqFsXCRrzqzWJFg697+A==
X-Received: by 2002:a05:6402:354e:b0:639:fb11:994f with SMTP id 4fb4d7f45d1cf-639fb119be2mr6397865a12.4.1760119668094;
        Fri, 10 Oct 2025 11:07:48 -0700 (PDT)
Received: from localhost.localdomain (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63b7334cb4bsm87907a12.44.2025.10.10.11.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 11:07:47 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 6.18-rc1
Date: Fri, 10 Oct 2025 20:07:25 +0200
Message-ID: <20251010180728.1007863-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit e5f0a698b34ed76002dc5cff3804a61c80233a7a:

  Linux 6.17 (2025-09-28 14:39:22 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.18-rc1

for you to fetch changes up to d74d6c0e98958aa0bdb6f0a93258a856bda58b97:

  ceph: add bug tracking system info to MAINTAINERS (2025-10-09 00:15:04 +0200)

----------------------------------------------------------------
Some messenger improvements from Eric and Max, a patch to address the
issue (also affected userspace) of incorrect permissions being granted
to users who have access to multiple different CephFS instances within
the same cluster from Kotresh and a bunch of assorted CephFS fixes from
Slava.

----------------------------------------------------------------
Eric Biggers (1):
      libceph: Use HMAC-SHA256 library instead of crypto_shash

Kotresh HR (1):
      ceph: fix multifs mds auth caps issue

Max Kellermann (4):
      ceph: make ceph_start_io_*() killable
      libceph: make ceph_con_get_out_msg() return the message pointer
      libceph: pass the message pointer instead of loading con->out_msg
      libceph: add empty check to ceph_con_get_out_msg()

Viacheslav Dubeyko (9):
      ceph: add checking of wait_for_completion_killable() return value
      ceph: fix wrong sizeof argument issue in register_session()
      ceph: fix overflowed constant issue in ceph_do_objects_copy()
      ceph: fix potential race condition in ceph_ioctl_lazyio()
      ceph: refactor wake_up_bit() pattern of calling
      ceph: fix potential race condition on operations with CEPH_I_ODIRECT flag
      ceph: fix potential NULL dereference issue in ceph_fill_trace()
      ceph: cleanup in ceph_alloc_readdir_reply_buffer()
      ceph: add bug tracking system info to MAINTAINERS

 MAINTAINERS                    |   3 +
 fs/ceph/dir.c                  |   3 +-
 fs/ceph/file.c                 |  30 ++---
 fs/ceph/inode.c                |  11 ++
 fs/ceph/io.c                   | 100 ++++++++++++-----
 fs/ceph/io.h                   |   8 +-
 fs/ceph/ioctl.c                |  17 ++-
 fs/ceph/locks.c                |   5 +-
 fs/ceph/mds_client.c           |  22 +++-
 fs/ceph/mdsmap.c               |  14 ++-
 fs/ceph/super.c                |  14 ---
 fs/ceph/super.h                |  17 ++-
 include/linux/ceph/messenger.h |  10 +-
 net/ceph/Kconfig               |   3 +-
 net/ceph/messenger.c           |  12 +-
 net/ceph/messenger_v1.c        |  56 +++++-----
 net/ceph/messenger_v2.c        | 246 ++++++++++++++++++-----------------------
 17 files changed, 323 insertions(+), 248 deletions(-)


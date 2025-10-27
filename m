Return-Path: <linux-kernel+bounces-870771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28726C0BA51
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 03:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D1194E1508
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 02:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0C12C21C5;
	Mon, 27 Oct 2025 02:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="M5rop7MM"
Received: from mail-ej1-f97.google.com (mail-ej1-f97.google.com [209.85.218.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1A129E11B
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761530591; cv=none; b=Fi8tJvddKBVRLivrAOF4pa69HrLNZVMCaK2+wFjvN+f/7XVHMh4kxcSIzFQeRltTNEhHVkaNqeZ8VzPf//rg6JUQ8aNBYvlb1L41nRGcmapc0pWcu/TOLxDAGRfCkxoYh4EJAa8kaYq/g7LNeBPtIkzE8c7/cJoolr0RI1vuTgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761530591; c=relaxed/simple;
	bh=8EGXy5b1kSFodiuuzawK6wvaYbLLM08GPPPMMQ8zI7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pkIIoAAWjYfRG2Qo2dvBRXVfOUhnakYD/nHn9SVRY/GI8aR12scC+wp4opXGcI0Wx2enpHFnC9sVgghi0NJ/yFSTPzguj7cvXMWtw6LT0QGYeJIaJOFPAzWVo6qpjI9l9CwlSztbTzFlu/lQ8dNT1NtnVdWaLQWF3AaoY4VX8nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=M5rop7MM; arc=none smtp.client-ip=209.85.218.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f97.google.com with SMTP id a640c23a62f3a-b6d955816bdso28730466b.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 19:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761530587; x=1762135387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jCh4WemE9mdSnciEK2Wq3FeBaRoVhjwvxKmTI6eKr9I=;
        b=M5rop7MMq5hk2TzNK10RdeSGsBICc4P8G5UR62QY+Go8EUicxYUbV7yKF0Ewknd+3C
         VMkIwFI1srO6yQ4Ecb1XkU2abPONncSeLRtmJT8NcicRp0s6TAqVFGOmmjiI80dxMLvx
         ypX5+L0JchNz6mqkvEnQFM3y7iFrzfC6kLU8lHWge50XHc/Cx/DyHlrT0SYKY/92Crtk
         vNMwJsdtLabuDa29cKqFsQ3e7mWCg9OiYqVG9SbRUMKUp0C1qda9+m1hHKoVy+v1tJmn
         qDkL3sZXTEpf+AM9krAsrF/gZSQplLkX+52qJDh/hHFmMWJrolJMYt+tgOIqGoYwJ/Wy
         n21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761530587; x=1762135387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jCh4WemE9mdSnciEK2Wq3FeBaRoVhjwvxKmTI6eKr9I=;
        b=hnKjyptS+KiWRsvRsMjtmRr1qx1f/aETrj2e4Lj5yJedGNvUPiClKKq7/yHRx1q4vQ
         bLqyZj10vC9AntdkWejnKmbRAhpb6myXVJk96xviXwcCca3c9brlh5NSzDLAM3yjYpGM
         bhFZE1UiVsH3oT+6qUI7NumAKlbXxhSM1TJbQLOI/7UcvblNsZ7RBcgOEH4HkS7p9TNw
         wNYnOkGm4b+/VdwkY3xB7DOsYKN77psK0T5+nHf+2ruBM2I1hTd9ao1Nc31K3bZtpyqm
         gs/s4ZfOSRSiRM9XRV31QQBd6Ez+03t6E7weI5nDZWtxBrVPRIbkgyH5o1WFaB6fTCjj
         +zAA==
X-Forwarded-Encrypted: i=1; AJvYcCVEvhGr1QiDaL4zeNYFhxzRRWM4TCIPk6sC11otdcuqLq8ioBTOTM2WgONoFNQiq6AXluq7qMTlG9UsqWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6gTLDvJRaBeLQ185b+g0rHUACEW0B8eZnliHyDaCzwhLIt2iv
	Y7oV2WgeNltiVFoSAEBlgWBDXBByfpnSUz8RbNNOe2O9PKXzT/W884529SKKEnWtysxsBbk571B
	0fyZMBpiD/856dwOSjyDJSmupN3hky4ANaeCA
X-Gm-Gg: ASbGnct54EimCFvJ3a+mu+gCq2oOuP/ucgDCz7RNCoqbYbauyXs+4JLJ/GekMMIQiK9
	ZA74q48CjgQETFl0h4BmEFpJ8PIegcJtLb9G5nVI/bwWrvvVlpeJViSzSwVJjT1aQjawcW/h05c
	IS5gKxg6XcsG91wg6vQShpcISRhrdN2F3tmp1L0LVmo0dxFrjfax+0hvDU75UUOPUbRoef0x+Dl
	HtRPETAoDRPoFdX4SsCsxKeLqc2IJ1rK8WOojbDzU7t+w+mBSNtll+p37RY0vMBV/xGAF1Zcj4N
	hgQFEsZsbo270aCKeu+wdgz2xV3lLqL+eYCon++UpsIUIBzX8WsgCCi/6iSQDcL7mL/qf2jyTo4
	yHnPxwaU2ntpnf24vhugM5os6kXVYYrk=
X-Google-Smtp-Source: AGHT+IE4hiP03f6lofOOS2+HxUXFo5vKINW/jUKRpaO25HyrXJmcC0Z82zfs5/zGzfiuKTm+aQhmKlmbZdW6
X-Received: by 2002:a17:907:c24:b0:b38:7f08:8478 with SMTP id a640c23a62f3a-b6c72716445mr1473292866b.0.1761530586723;
        Sun, 26 Oct 2025 19:03:06 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b6d85418ef1sm55541366b.47.2025.10.26.19.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 19:03:06 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 46DBB3402DD;
	Sun, 26 Oct 2025 20:03:05 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 3C232E46586; Sun, 26 Oct 2025 20:03:05 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 0/4] io_uring/uring_cmd: avoid double indirect call in task work dispatch
Date: Sun, 26 Oct 2025 20:02:58 -0600
Message-ID: <20251027020302.822544-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define uring_cmd implementation callback functions to have the
io_req_tw_func_t signature to avoid the additional indirect call and
save 8 bytes in struct io_uring_cmd. Additionally avoid the
io_should_terminate_tw() computation in callbacks that don't need it.

v3:
- Hide io_kiocb from uring_cmd implementations
- Label the 8 reserved bytes in struct io_uring_cmd (Ming)

v2:
- Define the uring_cmd callbacks with the io_req_tw_func_t signature
  to avoid the macro defining a hidden wrapper function (Christoph)

Caleb Sander Mateos (4):
  io_uring: expose io_should_terminate_tw()
  io_uring/uring_cmd: call io_should_terminate_tw() when needed
  io_uring: add wrapper type for io_req_tw_func_t arg
  io_uring/uring_cmd: avoid double indirect call in task work dispatch

 block/ioctl.c                  |  4 +++-
 drivers/block/ublk_drv.c       | 15 +++++++++------
 drivers/nvme/host/ioctl.c      |  5 +++--
 fs/btrfs/ioctl.c               |  4 +++-
 fs/fuse/dev_uring.c            |  7 ++++---
 include/linux/io_uring.h       | 14 ++++++++++++++
 include/linux/io_uring/cmd.h   | 29 +++++++++++++++++++----------
 include/linux/io_uring_types.h |  7 +++++--
 io_uring/futex.c               | 16 +++++++++-------
 io_uring/io_uring.c            | 21 ++++++++++++---------
 io_uring/io_uring.h            | 17 ++---------------
 io_uring/msg_ring.c            |  3 ++-
 io_uring/notif.c               |  5 +++--
 io_uring/poll.c                | 11 ++++++-----
 io_uring/poll.h                |  2 +-
 io_uring/rw.c                  |  5 +++--
 io_uring/rw.h                  |  2 +-
 io_uring/timeout.c             | 18 +++++++++++-------
 io_uring/uring_cmd.c           | 17 ++---------------
 io_uring/waitid.c              |  7 ++++---
 20 files changed, 116 insertions(+), 93 deletions(-)

-- 
2.45.2



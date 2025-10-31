Return-Path: <linux-kernel+bounces-880933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E93C26E6C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 21:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 088454E3B86
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 20:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27BE328B7A;
	Fri, 31 Oct 2025 20:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dvQYnWoz"
Received: from mail-lf1-f100.google.com (mail-lf1-f100.google.com [209.85.167.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7EC32143A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761942881; cv=none; b=ZpIXGTzBNaW7o+xd4y1p49eA8ilcJB/KkF3afSup5vtXI3d/O0gUfx8DECU2U8gH6Z69i3eCcNF86V+b98NMUQ8nK9m5pF19xMdLJj0HPodNfdLrqg3U1cUBo9325A1CJHZU4A6nmkq/Jri63qMV+LLLHVJzmsBAugoQ9wCfEeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761942881; c=relaxed/simple;
	bh=jvDE7lWJxH3JAXZ63PoEX/oK9PZRTBG5vt6245JF66Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HHizbTXk7CtIZXHEm6KYdV9EtoAx6ZK9jB9REV9j0hzJ8O40pr3zXJ72X+X7hborRhwwPNfXsuhjHU3r5U7NdSgTKenYgLvR4pGSH+laBPNXBxR5KSC81qiCzVCeHZ2Aw2k6sJXQedQf9DN9WLIAlY2luZWtCbSvFYRH6Y5jpZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dvQYnWoz; arc=none smtp.client-ip=209.85.167.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lf1-f100.google.com with SMTP id 2adb3069b0e04-592f2f08168so251797e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761942877; x=1762547677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6JMKDvp/MIeXNCA/ceerlUqX0sUk5SPPyvwa4mIoYyc=;
        b=dvQYnWozKugEUNvqdhCr6mOWn03B72UNbtIqWXxtzXbQZh2FwocLAAA2fo4AQBP8nD
         gjuJ7hbba2arrHmEhlTtgj3pQKsPpu3BSnPyWnsK/iJ120VJETkxreb4co7cGyDFjZ1Q
         Romr/u0AGF19Syc7K43JIlSdWKtdIt1Ct4P5iyInbmy9uAp6cN0Z1/cei717ORVB3nVw
         DDaUMhf0SYo8HVPxmDmJPPtLOHXG4V63nGyRAWOsWj3w42NKDkkdBx63fvfLk7zXY9gU
         qtPQJcYjFgzu17DHVa4v45yxtBaGrPHVrXeKNpXiD88/aZ8e+7f8iLJHjYqmKVvQCbdk
         8keQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761942877; x=1762547677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JMKDvp/MIeXNCA/ceerlUqX0sUk5SPPyvwa4mIoYyc=;
        b=f6QD8skmpvvAUBHlFS2S+JHdyGhveZWDJVniruCNfnVOahR9V5ZywKChAFc0rx5rZt
         2OCo7jHkUGkwBUB1118NWG10FczQWxhIqAlAhw2GzCtbQorx8pHenypICzfx6Ue3YZZk
         5Y2kqTVrYvI/ZxlxBKlHxf7tkS7oKkjpqn3dXqzGy+WtEeI7ho6WO2wF3UJyT+xgKIWk
         NJ/tYdT/5ReRhNMoD4JVcRP39gDT6MXEV3v5iwpS3ozklzdyCnFbBnbU7WsbE7XAK4c7
         B6jHYwsxdeqo69pr5SknRxjhAiUeN63GsJc1W4Vkxj4X824iBCJbu2w/0/G+m/zFuF9U
         kuWA==
X-Forwarded-Encrypted: i=1; AJvYcCVRoRiDStjoFEotDjDvN3UETYxEHblSmXQn44OIeUJsQe5oQ8JNVFM82DFWxqFF7AYfdL1HoKJ3/nGRhq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3LnPyYBwGPgfhAu5UK0lBHsqjUu4Wcippo9ZW2snPFeDV9A3J
	Z4J30CPFKftioDHIgAy5aPT/92gKyTC0v1zKvlWuTeGWP6tz+B/+FgyThWU1QKVbwKbYuppg3Yn
	wCJhgdahDOQslTCup4A7skUj/gE48l0ctrlnF
X-Gm-Gg: ASbGncsgzFCCeFDEABUDplSgmLeya7vfkxTc9ptuEYA3Eaus2XiJUeCoFykDHrh/LZq
	APoeB1cqsQhzrvFP8pB9D8/0fJ/w/5AeLCMJ7Jm+x7+eMs7MCxAhmWFeFx+0YmXURO0U00BmdSq
	6Awoy3Webfd7qYBF3905CVN3b4K6GeZIxp0aHlOXqFJESiL962mTon4U1eY7/Th69EY149zN4Y8
	W4ioDgCTfco5iW/Fm/J0w7kWrAgjp7LqViDu5OE3RarkbExKA4T+7yLxUICu2swHBHH94zFdWTA
	wPhP/84T4CkL6ZLx/WdhCLi7KNOoOK1H3SnDL/cXWKPlE/iqcLs5vrjhpXIJrlj5/YZfqPYLOg3
	wsO/P68qJnlCmh9DRa0YH+h5RO+kFCyM=
X-Google-Smtp-Source: AGHT+IHYGUnO7bV47O6a0JaarTqAfmI/2Y9l++bnlFY3ld+pOZSgy8vCnY+sYVKLt/9KYUiwgYpMC6aTC4ND
X-Received: by 2002:ac2:4c4f:0:b0:592:f7b4:e5fb with SMTP id 2adb3069b0e04-5941d4ff894mr969734e87.3.1761942876878;
        Fri, 31 Oct 2025 13:34:36 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-5941f3a30cbsm287556e87.27.2025.10.31.13.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 13:34:36 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4EBCF3400FE;
	Fri, 31 Oct 2025 14:34:35 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 465FEE41255; Fri, 31 Oct 2025 14:34:35 -0600 (MDT)
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
Subject: [PATCH v4 0/3] io_uring/uring_cmd: avoid double indirect call in task work dispatch
Date: Fri, 31 Oct 2025 14:34:27 -0600
Message-ID: <20251031203430.3886957-1-csander@purestorage.com>
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
save 8 bytes in struct io_uring_cmd.

v4:
- Rebase on "io_uring: unify task_work cancelation checks"
- Small cleanup in io_fallback_req_func()
- Avoid intermediate variables where IO_URING_CMD_TASK_WORK_ISSUE_FLAG
  is only used once (Christoph)

v3:
- Hide io_kiocb from uring_cmd implementations
- Label the 8 reserved bytes in struct io_uring_cmd (Ming)

v2:
- Define the uring_cmd callbacks with the io_req_tw_func_t signature
  to avoid the macro defining a hidden wrapper function (Christoph)

Caleb Sander Mateos (3):
  io_uring: only call io_should_terminate_tw() once for ctx
  io_uring: add wrapper type for io_req_tw_func_t arg
  io_uring/uring_cmd: avoid double indirect call in task work dispatch

 block/ioctl.c                  |  6 ++++--
 drivers/block/ublk_drv.c       | 18 ++++++++++--------
 drivers/nvme/host/ioctl.c      |  7 ++++---
 fs/btrfs/ioctl.c               |  5 +++--
 fs/fuse/dev_uring.c            |  7 ++++---
 include/linux/io_uring/cmd.h   | 22 +++++++++++++---------
 include/linux/io_uring_types.h |  7 +++++--
 io_uring/futex.c               | 16 +++++++++-------
 io_uring/io_uring.c            | 26 ++++++++++++++------------
 io_uring/io_uring.h            |  4 ++--
 io_uring/msg_ring.c            |  3 ++-
 io_uring/notif.c               |  5 +++--
 io_uring/poll.c                | 11 ++++++-----
 io_uring/poll.h                |  2 +-
 io_uring/rw.c                  |  5 +++--
 io_uring/rw.h                  |  2 +-
 io_uring/timeout.c             | 18 +++++++++++-------
 io_uring/uring_cmd.c           | 17 ++---------------
 io_uring/waitid.c              |  7 ++++---
 19 files changed, 101 insertions(+), 87 deletions(-)

-- 
2.45.2



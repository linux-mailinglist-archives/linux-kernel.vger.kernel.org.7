Return-Path: <linux-kernel+bounces-854824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10094BDF7AF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75AF819C3B4C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D5C32A3E1;
	Wed, 15 Oct 2025 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihYGm1lo"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9042FD7DE
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760543442; cv=none; b=tbM1U9GNJlc530es/w96toMkiCixly+y1jgFMWcEzK4Y4wCGvty0elVe28FgVAcJl2EouoUVPes6IabEPMabkELxLNdGxTFDNCnFmdEHI8qaTHikc1lwsHFnV9bEwbXk20po0ch54OmSDaLTuKlPyJdJ3u59g2YH6jAlKaY+/js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760543442; c=relaxed/simple;
	bh=3MYPajuQ2QWtBRwvH2nbfeYSKwoEPh79fX4y0wqgQoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aIOSxBHnZic+u/ItsvgjLkP3RAn6Sceeq93I5bbYD9G/NjQpIk8Vohz3T96bjzJCTKsqDA5C/GXgvIAkqbkvydD+arOawX8Imif5q+Ej++VuIXXpnrOqLQ6nOaXR3FDo3rKUoc7xGBlJyVaRbziijx1yxxcaqV8ikte0eYA/SzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihYGm1lo; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-911520e43edso298127039f.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760543440; x=1761148240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FPrAKu/IWOXmM5CfcFxeiP+a3NmUz9xQBz3ZjE+QAfY=;
        b=ihYGm1lopaSk31Bv3cmGnHD0aYNZ6G30zElnfILFCEHksDHugHYLcAx/++z8hNgHlO
         InsPNWIm2x8GYKYRGCYtskU5K2F9wx3SVuvZ3x6bn4A9U9cerNlJ5SWD1o5gnw0UQk0s
         WR75E6vBTBYZNxfdwBz7j5Ojs+ZCs5X8JunVDAbCs4+s3/AbI8UmnyBTafnqSNfHIHPt
         4nlk/2U0qDKjQJNzHBc5Qd40v0I3eGun2QVavkSvBtIkDQpiijG5HQ/jK2nS9K8sP4ha
         l1iio8T4Vv9djFJVCoDQDzAqReCqX54OQ+KjO9R97pIqMvhFReCrn4n4zA1/tekwtS+i
         PZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760543440; x=1761148240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FPrAKu/IWOXmM5CfcFxeiP+a3NmUz9xQBz3ZjE+QAfY=;
        b=KVQKJiIW49r4KVYuvWo//3fdp8ztNWA4HQRm3oJUOGGyJZ3dBUVxwOcX0O4+rvrxDc
         I50KkWQKSl+fzjoKgPGOShGEL6fXrMV3JR0t57ok9hnSpJwSjNceh/bL0ri6MJksPVcI
         DjpPiPUgkQNaY0INQ31NzgmvHF9PehB3UlUXSYrMu62eHN789I7Z0OhNqRCB/L9sLUSX
         z9t4LXQ2UNYifiochf+xF1mzJYXQ9UMhQ7nXVSbBhMXUQIBMY/4i+RJtE3x68Y9NKGVX
         SOcsX3n0xrbPCZBqrpAnkjEiUiq3DpIxBIHreGzsPaGMQ9Dudapkd2YXTSeHSj50s2oE
         1Gxg==
X-Gm-Message-State: AOJu0YxnDHuH3127+NM3PbumCgrZOV7JHaKQ9+dJr3GXz2N/pGFrLxkS
	TQVMEVmr+nL6RQFbFA2TQ2AddsEVHtsAj2c+tLjYvT8xXdcPhcJqKfuPMvK+OCAS
X-Gm-Gg: ASbGncuRHbIx9Vg5TX1USPbEyPvyG0dMAlK0q0XvytlgEW8CGMHi6KvB5+LtY+FQFuD
	DQYfVzbqrzTImovUZdNW9DVRZiOywRIMoNHai1Gmzfh1RQaDwprjQsVhzG0b8b8gvL8NrvcgtlA
	7ZPXGihj39s3E54JcGC1ONemsovkN0ttXWx/9NHjum6eYn/E6Buplty6Cpcn82w3MiGzTwriDdV
	74h5flamzz/Kl26O2IExYsR0NnVLRzASGIBvN2sk26diDjAMiZh/bxOp0B+CxvR7P1kUZXkanpH
	Dn+AgWENdfb1HTnf/DOyz1Kc7sNIZyo0DWmdxgZOdF2er8+7oL9vjFCZL6rc90M3rXv6UVM9vbG
	9RqhKsv1rF+kMkbLQbFNQj5WEOpR40UEPFsL/euns8tnGrf8VE40V+NesPhIl6JuFdSZheKtcOB
	aqWXs1GwMbvj+vfjizdSlqT/qo7EWiwEl4ZnnESP3KN4G19iSjm+8=
X-Google-Smtp-Source: AGHT+IF18Fh+dNim3Y+u/hzFLdFyF918bdyCY6/WjkMfV7iZC3Up53vEzOUqWIK53pLRVcDJJ5zPxQ==
X-Received: by 2002:a05:6602:2b82:b0:927:44ad:739b with SMTP id ca18e2360f4ac-93bd1989d4dmr3828327839f.16.1760543439895;
        Wed, 15 Oct 2025 08:50:39 -0700 (PDT)
Received: from newton-fedora-MZ01GC9H (c-68-45-22-229.hsd1.in.comcast.net. [68.45.22.229])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e25a67790sm617361639f.21.2025.10.15.08.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 08:50:38 -0700 (PDT)
From: Ryan Newton <rrnewton@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: sched-ext@lists.linux.dev,
	tj@kernel.org,
	arighi@nvidia.com,
	christian.loehle@arm.com,
	rrnewton@gmail.com,
	newton@meta.com
Subject: [PATCH v5 0/2] sched_ext: lockless peek operation for DSQs
Date: Wed, 15 Oct 2025 11:50:34 -0400
Message-ID: <20251015155036.420486-1-rrnewton@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows sched_ext schedulers an inexpensive operation to peek
at the first element in a queue (DSQ), without creating an iterator 
and acquiring the lock on that queue.

Note that manual testing has thus far included a modified version of the
example qmap scheduler that exercises peek, as well as a modified
modified LAVD (from the SCX repo) that exercises peek. The attached test
passes >1000 stress tests when run in concurrent VMs, and when run
sequentially on the host kernel. Presently, tested on the below
workstation and server processors.
- AMD Ryzen Threadripper PRO 7975WX 32-Cores
- AMD EPYC 9D64 88-Core Processor

Initial experiments indicate a substantial speedup (on schbench) when
running an SCX scheduler with per-cpu DSQs and peeking each queue to
retrieve the task with the minimum vruntime across all the CPUs.

---
Changes in v5:
 - minor comment tweak requested in review
 - add Reviewed-bys christian.loehle@arm.com

Changes in v4:
 - review comments (from arighi@nvidia.com) addressed, add Reviewed-by
 - make the test much lighter weight with 4 rather than 100 workers
 - link: https://lore.kernel.org/lkml/20251015015712.3996346-1-rrnewton@gmail.com/

Changes in v3:
 - inline helpers and simplify
 - coding style tweaks
 - link: https://lore.kernel.org/lkml/20251006170403.3584204-1-rrnewton@gmail.com/

Changes in v2:
 - make peek() only work for user DSQs and error otherwise
 - added a stress test component to the selftest that performs many peeks
 - responded to review comments from tj@kernel.org and arighi@nvidia.com 
 - link: https://lore.kernel.org/lkml/20251003195408.675527-1-rrnewton@gmail.com/
 
v1 link: https://lore.kernel.org/lkml/20251002025722.3420916-1-rrnewton@gmail.com/

Ryan Newton (2):
  sched_ext: Add lockless peek operation for DSQs
  sched_ext: Add a selftest for scx_bpf_dsq_peek

 include/linux/sched/ext.h                     |   1 +
 kernel/sched/ext.c                            |  58 +++-
 tools/sched_ext/include/scx/common.bpf.h      |   1 +
 tools/sched_ext/include/scx/compat.bpf.h      |  18 ++
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/peek_dsq.bpf.c        | 251 ++++++++++++++++++
 tools/testing/selftests/sched_ext/peek_dsq.c  | 224 ++++++++++++++++
 7 files changed, 552 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.c

-- 
2.51.0



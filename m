Return-Path: <linux-kernel+bounces-839783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CC2BB2677
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 04:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2A21643B6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 02:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184C223E342;
	Thu,  2 Oct 2025 02:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6S7PhPS"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0911157493
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 02:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759373851; cv=none; b=GFB/VCJMOSnO5lY3h1l6xSGpkk5LKO/a72KypGXNGa1A6A8spX6/P9ZyzmX0ur6Ws0W+UljWPQS4kcCxh4dKbe3ZEjBnWM8xWnN1IM1TVHB4PgauvT0bC06W3ILMjsRrYrQV2LVPjMCGrBdCIvXMgDhSfnsEhP0F8PfLy9EgujE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759373851; c=relaxed/simple;
	bh=Q3hxkrvFRL59MrH/Fj9lknUTVqc36ixuUqCVVvmb+wg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ssDNNHSwHA1nYQ5AYXlFfu5k4nUqxBQmTaRA2HkxrUYzA50ymo0FYb7XfN1HSvK/LZui9SdCsqpcViZhFjaYV/b483FqlKauyLqB6k3DunL6n8OZS39xwXEZNVfa83xIKrLKYC+fiFqjFKH5avcYAUB4ZUtY5Y24gjROskAgu2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6S7PhPS; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-9032edd72c1so53916139f.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 19:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759373848; x=1759978648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pgtdvak37AGe4gfwqmTcC44T+zbRscuiK7271WqQ0fw=;
        b=H6S7PhPShhYGfLOiW2tm+3mx1nO6pIZpbu63hXb5oT/3QtAM6i4ZF48A2HkmNx3Wcn
         ZuAEkUGPaWZ+RGkbtaGjdaPIHuHMYP4vhB/l8gkZ3TMJHgLEHdvQanaX8WtHSYD6nh7f
         AlBabpD+4lTKsW20Kx5jJtwkOkrjmC6jU84OnWl8A7mQuoswaY3Pg433S9VDy+CpXek/
         eb5WiebSqzdOwBVF0Sr6vmj0UlRKLtF8NBB9kU/OYuEakDdR6QSs3Qtr8XUgQ7FcT7cW
         qQ29HFV+Qo5reaxnARsxIg3sVnUVAMAK4dwpqyu9V1AXwOoUvRlrw4RpH3x8+/g7pHj1
         xdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759373848; x=1759978648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pgtdvak37AGe4gfwqmTcC44T+zbRscuiK7271WqQ0fw=;
        b=Vpj4MVahLYJadY14RMpYr4vhXycJGEuWdZ3NTVcK7ub8cMP7pusYKYBxJLd3T5WhsH
         LFvPi4CMLxWZUEUKnVQsCKQLpNoLry1WLVHqlT32ZS8JOtaPk68zx14EDpP2Skk4b8Oy
         2aZNWaERYgcOVyiZ1PadZEFT79mY9Sz0tdkE0tBPWVWs7v0PP0LtrxscDRRXW2Al8USQ
         p0E6ww4/Iwjf1u4MkE1UNe+vmOSDnnJYfR+FWPbBw6MJ5O2XdobC003aBkYvdcb/j9+m
         C/fj07Y90viCaQWcuIjZBT1NCTLm/MO261Zou65xdNR6IGyQBJ6nPruOcjKwUlxmLR12
         w8hQ==
X-Gm-Message-State: AOJu0Yw/V6Y25X9q2crW+z2P7kZgOtTTmoTFe80JhDVVm2MoZiH6lka8
	yTDWFlhrNiuuRwwvGKvWB7ai29x7JONJ5ujW73SEY7oG9bU1rvmDsZpTy2jCq/jA
X-Gm-Gg: ASbGnctXBVnBddAGHMWe/oKafn3SKh0xMpeu2EGtqfEkpsvyoBaL1QGBpMM+jIvcSEP
	ZDkDKfeJ/JXrQMc7eyGnDi0k+MGj9wv+nE8vhcej6589uEehppso6Qh+DZnFrsNoNysb6r3TFp1
	RBD+JIUfOyhSUegIj2jBRNN8JMXioKLK5R7mzqr/JZqeApI5NdbAJExF6KNT7KYBZQX1r+sbhse
	h1LZ0Uv8Cq6E7IIWyYZfIsIfiYwpwHrg0ntXvk0OepWKCnVsUM1F1FKuozSpokP0Ig7j13Qbwp5
	hJhrlWRsPJHtYfCQ7a5gkZAJjAFgUaga9sIvWd/A9ZNp5jM/zhTp69D+ErKyPZm2xm42pyz3qqQ
	1qXD9GuCu3XRUZG3SMU2qpXO3x4LAF5ix2F8iff7Jn64o13k3CXCcP/T4wlDlgtuEfB3b2vTsQ+
	lBjVbC40JdJmlU1RWZBSw+7gDOUE5VL9rax1BP67KEHMAq1SwON5TnwRIr
X-Google-Smtp-Source: AGHT+IHI8DhlCOm1bUEpUsFtE1ICroHWPTjHyoakii6AE4Z9M7TK651KHzpbZw59r337JRP2zQoynA==
X-Received: by 2002:a05:6e02:1708:b0:424:8b1a:9326 with SMTP id e9e14a558f8ab-42d8167b65cmr73350065ab.21.1759373848173;
        Wed, 01 Oct 2025 19:57:28 -0700 (PDT)
Received: from newton-fedora-MZ01GC9H (c-68-45-22-229.hsd1.in.comcast.net. [68.45.22.229])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d8b1f4f0asm5250255ab.2.2025.10.01.19.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 19:57:26 -0700 (PDT)
From: Ryan Newton <rrnewton@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	arighi@nvidia.com,
	newton@meta.com,
	Ryan Newton <rrnewton@gmail.com>
Subject: [PATCH 0/3] sched_ext: lockless peek operation for DSQs
Date: Wed,  1 Oct 2025 22:57:18 -0400
Message-ID: <20251002025722.3420916-1-rrnewton@gmail.com>
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

Ryan Newton (3):
  sched_ext: Add lockless peek operation for DSQs
  sched_ext: optimize first_task update logic
  sched_ext: Add a selftest for scx_bpf_dsq_peek

 include/linux/sched/ext.h                     |   1 +
 kernel/sched/ext.c                            |  55 ++++-
 tools/sched_ext/include/scx/common.bpf.h      |   1 +
 tools/sched_ext/include/scx/compat.bpf.h      |  19 ++
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/peek_dsq.bpf.c        | 133 +++++++++++++
 tools/testing/selftests/sched_ext/peek_dsq.c  | 188 ++++++++++++++++++
 7 files changed, 396 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.c

-- 
2.51.0



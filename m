Return-Path: <linux-kernel+bounces-820018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E394CB7CA04
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC24317A805
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 06:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7360267B90;
	Wed, 17 Sep 2025 06:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLjj6oGE"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D801239E9B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758089369; cv=none; b=YoSTY+/KgsyRmgC8fZ8HNmeHFnI1uoNToqQxjI5VgOKgC9eVoO22XS9NGfbbfelDn5oGgPGU1ZMPS80x/YYFzdA9rXIg/n92Tdg11Vit579zUNQhx1nrnCGE/ouySr5+72xf961Rsi9YTHlo5BKlu9HcyTdtFU+ywcvb9fRH7O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758089369; c=relaxed/simple;
	bh=537NIBkFJBhNReff0J+Fy8gW6xggBG+duu5koX4j760=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S1Vs2XEymU00iAYfP0ZYyGX4eljvaANO8j54lCXEMTzoB8jV20491QniVjY7rsvilMq2TgdiWycsToH3imGlOqC490uTFf3NT/iU+T9SS5G/xHJ7RCgt3r3l/pG12iF0eQ6Udi7Z0CwhoX/RRiQBLSrOIsD4tFeUR5kkINq4Cs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLjj6oGE; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-77b0a93e067so1242124b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 23:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758089366; x=1758694166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1xAxRdoiO93y051F82K7suHB9wkzh4QlY9VZ+qgcZbE=;
        b=gLjj6oGEQW9WBYcVPtkMIUofAWs4HEnt3DLX3J6PK8OmvWRyFlULJh5nYWVjFEUlRS
         /Ls9ODwGJn3RBQ1foLdA8Jdh6ZG2D/VwQ7jyOoAVP9Pcwwi9zCh0p3OxBC7k7zzyj9cZ
         HHX3jbCcaFsqu55S2iXjgq3EHJqan328wRywxpuQpddWlDod7CyLCOwwgmu851M6NJyx
         Lgt0ZdUPm7t/xfKgYVaMqVZAAPWXDoV7gSI90F2UWMJR0Y6S+tTg+FA9rmfOyKBg6xlG
         cvObCRf97zj1GNOpO+cgug2e/lKXs8P8JCJQlP2X+t7UgBMcf3MwSFcHurnYBXj8gaXj
         x5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758089366; x=1758694166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1xAxRdoiO93y051F82K7suHB9wkzh4QlY9VZ+qgcZbE=;
        b=mm6xCXX9bwvV7AZRBQNgDnavwca3wYk0d3bpr26wccm6E5t43DcRl99XcENu8m1drc
         3KMx/aG0oN0n6W8UbVPB5OT2gVt1loWTpcW6eRgsRsNt+NmgnA9LpzO1MPxCo62yqlDh
         nA0dOJa77daT1woNYdqzukKvi+ze31x5xWVk54EpBnE7wpEEJZ6xnFWKx/zOrcB94I/+
         XA4C+Co6/hKknuURTGWpRRcS3YVS+C8eP9SZdCvvlTAsRyPAdCHaf0rWM8l3OCECbG+i
         7QCGdfIeYuAguP4m32MKBsId3LTU4agcouBTGKKxhnfFpCwCKBaYXDLjrGxqOL4Jueku
         9UBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2Cdd6toqEOmBCbVGkBBevNpwvBwcNo5YGBLBj6uSfBl3Gl7Ltgv6FpVq9knlwGDFSPRtI7BMphXYMKnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE0x3QfAw3nBWQXfjPBlseb94Tyyt72Q7jfF1ar7n+UOF12Ygk
	L4O3/DML2c8eDBo50lHNzqJ5K1li2LMx3GOhhTT2PdzKli5G0/djPQlz
X-Gm-Gg: ASbGncvhvmzdu4/Zq5CW7yip5HqyCr9U01U6iQ8HucWW/nJztj8GdJzT7PLUjRgmVqi
	YTtixZKFpGCZDbTm33reP1RIPvCmI0bUsfmkO1QmzKV9J/64TeylcXP4zkmwBjFGMEn3A9WLNKx
	0AB3W8cPqiDuVleKBrlxBqxx8i/rcAaj2bHLuSs6CA2/6QopAEY3u6fMLhIOWSBjdJDwGBqIXlV
	QXm4wWLf4EDxIZtzCINXx+4yecSC7BH6Q/gm0ZgCG0PFfNYpd0qn7v0JZGTNlqVM2sA9rqPI5JW
	a77aVxvlh5Q+Mt1RgQtq/JHWsQrGA9UPU0ve8NyJmlObAeFpHX3xmPyiCPOnSulZ1UUD+hFjB8N
	BWtIfS3JAOp0jzvC3vV4=
X-Google-Smtp-Source: AGHT+IHnf2vcgwnne5LMBr01jvI4u6V0HHloejQpirvRzUIkVjeaIv5zalCRylDHZilavjHCejOVgg==
X-Received: by 2002:a05:6a20:3d07:b0:249:d3d:a50b with SMTP id adf61e73a8af0-27ab286ee39mr1195856637.59.1758089365956;
        Tue, 16 Sep 2025 23:09:25 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a3aa1c54sm15845427a12.50.2025.09.16.23.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 23:09:25 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: peterz@infradead.org,
	ast@kernel.org
Cc: mingo@redhat.com,
	paulmck@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tzimmermann@suse.de,
	simona.vetter@ffwll.ch,
	jani.nikula@intel.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v5 0/4] sched: make migrate_enable/migrate_disable inline
Date: Wed, 17 Sep 2025 14:09:12 +0800
Message-ID: <20250917060916.462278-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In this series, we make migrate_enable/migrate_disable inline to obtain
better performance in some case.

In the first patch, we add the macro "COMPILE_OFFSETS" to all the
asm-offset.c to avoid circular dependency in the 3rd patch.

In the 2nd patch, we replace preempt.h with sched.h in
include/linux/rcupdate.h to fix potential compiling issue.

In the 3rd patch, we generate the offset of nr_pinned in "struct rq" with
rq-offsets.c, as the "struct rq" is defined internally and we need to
access the "nr_pinned" field in migrate_enable and migrate_disable. Then,
we move the definition of migrate_enable/migrate_disable from
kernel/sched/core.c to include/linux/sched.h.

In the 4th patch, we fix some typos in include/linux/preempt.h.

One of the beneficiaries of this series is BPF trampoline. Without this
series, the migrate_enable/migrate_disable is hot when we run the
benchmark for FENTRY, FEXIT, MODIFY_RETURN, etc:

  54.63% bpf_prog_2dcccf652aac1793_bench_trigger_fentry [k]
                 bpf_prog_2dcccf652aac1793_bench_trigger_fentry
  10.43% [kernel] [k] migrate_enable
  10.07% bpf_trampoline_6442517037 [k] bpf_trampoline_6442517037
  8.06% [kernel] [k] __bpf_prog_exit_recur
  4.11% libc.so.6 [.] syscall
  2.15% [kernel] [k] entry_SYSCALL_64
  1.48% [kernel] [k] memchr_inv
  1.32% [kernel] [k] fput
  1.16% [kernel] [k] _copy_to_user
  0.73% [kernel] [k] bpf_prog_test_run_raw_tp

Before this patch, the performance of BPF FENTRY is:

  fentry         :  113.030 ± 0.149M/s
  fentry         :  112.501 ± 0.187M/s
  fentry         :  112.828 ± 0.267M/s
  fentry         :  115.287 ± 0.241M/s

After this patch, the performance of BPF FENTRY increases to:

  fentry         :  143.644 ± 0.670M/s
  fentry         :  149.764 ± 0.362M/s
  fentry         :  149.642 ± 0.156M/s
  fentry         :  145.263 ± 0.221M/s

Changes since V4:
* add the 2nd patch to fix potential compiling issue
* fix the comment style problem in the 3rd patch

Changes since V3:
* some modification on the 2nd patch, as Alexei advised:
 - rename CREATE_MIGRATE_DISABLE to INSTANTIATE_EXPORTED_MIGRATE_DISABLE
 - add document for INSTANTIATE_EXPORTED_MIGRATE_DISABLE

Changes since V2:
* some modification on the 2nd patch, as Peter advised:
  - don't export runqueues, define migrate_enable and migrate_disable in
    kernel/sched/core.c and use them for kernel modules instead
  - define the macro this_rq_pinned()
  - add some comment for this_rq_raw()

Changes since V1:
* use PERCPU_PTR() for this_rq_raw() if !CONFIG_SMP in the 2nd patch

Menglong Dong (4):
  arch: add the macro COMPILE_OFFSETS to all the asm-offsets.c
  rcu: replace preempt.h with sched.h in include/linux/rcupdate.h
  sched: make migrate_enable/migrate_disable inline
  sched: fix some typos in include/linux/preempt.h

 Kbuild                               |  13 ++-
 arch/alpha/kernel/asm-offsets.c      |   1 +
 arch/arc/kernel/asm-offsets.c        |   1 +
 arch/arm/kernel/asm-offsets.c        |   2 +
 arch/arm64/kernel/asm-offsets.c      |   1 +
 arch/csky/kernel/asm-offsets.c       |   1 +
 arch/hexagon/kernel/asm-offsets.c    |   1 +
 arch/loongarch/kernel/asm-offsets.c  |   2 +
 arch/m68k/kernel/asm-offsets.c       |   1 +
 arch/microblaze/kernel/asm-offsets.c |   1 +
 arch/mips/kernel/asm-offsets.c       |   2 +
 arch/nios2/kernel/asm-offsets.c      |   1 +
 arch/openrisc/kernel/asm-offsets.c   |   1 +
 arch/parisc/kernel/asm-offsets.c     |   1 +
 arch/powerpc/kernel/asm-offsets.c    |   1 +
 arch/riscv/kernel/asm-offsets.c      |   1 +
 arch/s390/kernel/asm-offsets.c       |   1 +
 arch/sh/kernel/asm-offsets.c         |   1 +
 arch/sparc/kernel/asm-offsets.c      |   1 +
 arch/um/kernel/asm-offsets.c         |   2 +
 arch/xtensa/kernel/asm-offsets.c     |   1 +
 include/linux/preempt.h              |  11 +--
 include/linux/rcupdate.h             |   2 +-
 include/linux/sched.h                | 113 +++++++++++++++++++++++++++
 kernel/bpf/verifier.c                |   1 +
 kernel/sched/core.c                  |  63 ++++-----------
 kernel/sched/rq-offsets.c            |  12 +++
 27 files changed, 181 insertions(+), 58 deletions(-)
 create mode 100644 kernel/sched/rq-offsets.c

-- 
2.51.0



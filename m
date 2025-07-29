Return-Path: <linux-kernel+bounces-748803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD8DB14625
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 04:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62E454207B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 02:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F801FF5F9;
	Tue, 29 Jul 2025 02:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R/sZ907D"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BB520ED
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 02:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756007; cv=none; b=JcUkZIzuOWUKLFQWmHX84cTyb+TVQBO5xyb4E5oWEfKO1MPDjjd6uJFnTN5TmiIipED2RBZ32b5Dpc2cfjMLvkoRY6448iuUN7rSgEbfFI1b02KZTwuE7Xm6+kY8ziE6cHF0CffkgwHGZ0Xyqfc51vZLaQ9UQuFujPc8ZXJsFPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756007; c=relaxed/simple;
	bh=JFNJ0xY/gGJnj3Jd16Zi8loEorMlqJwViFDAB7w5AnU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=d6SoJaMPbgOWfqTNYjPugyb3Pdt5MKXRfz5Ll0qKZbykDwRvZbM6vHVpdcCPSKVjtExaAiB17VYIqj9P4ytHqTk8hyMkitKmZQgDonVUgR4pzi6F0XPoQc6ITQoV9uFwyRY7X2lrixRd5UbISto3ifF+3VuoL6bfzHYbTCtDM4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R/sZ907D; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b31bd4c3359so3115656a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 19:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753756005; x=1754360805; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NNV/MXzHp2SAdfvy4FLj9SvHj6RbtHppa2ktiqMYU9Q=;
        b=R/sZ907DIt9pvrZvmEwoYagk8yR5pBLDfL0MLq10oeJEIw4HNVJsJ3+XZ/3vHyxcI4
         /ElXB+cr2kqtGFU1mgmeVGX3kn6dErPCq80NFqklbzd3bsfib5/JkvSAArNbGHIBr6oz
         v8YIO5fQDlHp5Q19K9J1veJdIyOYotO+8mNHWQZNLCBy8LjOUx+OE6uzUC6b4dyiq8Ys
         PGW38AOPQyFeYsuRnbDANlwY1ZGsr97WOW8B/xUK0osK6kzBQ4YowEbnI9eyIV+SoQro
         ItfUOxoT3a90A3wGwLc4UI4WyRZ+FFvl/h5T3hagRZ6Kgaw9/0bkF+W32h9Y+OqpscT+
         aLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756005; x=1754360805;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NNV/MXzHp2SAdfvy4FLj9SvHj6RbtHppa2ktiqMYU9Q=;
        b=C2/IQLLI84SXCPs7e3ULr4bRSibzGHHGec2eAOVz66/hCcILnca7biXhOx93e9zC+d
         C1pdQ5En6c18pc3BFKee+cQxUSiLRND8a84TK4SVmVl67YUqS+5+Dmdw9PlzQWQdTeDS
         +oB0tWPAcB67Q9HhLC6epkTu2iiUwTPsG271ocr6134G28xMt67+Bho8s55K6tBz4MSW
         qpPnF1N7OHdpM7mPU1HnwirhirFRJbkrVMwhHf4uO+2hnCAQVZPHhdOXrapHAI1rPnhv
         duRyEga+RJEzvpKIOe/J4vaj9gEa8rF1EYuycNUvhmvT47WwP1PHGVo9JcRqe92yr2UR
         b98A==
X-Forwarded-Encrypted: i=1; AJvYcCXoMfyVD0+0evztPsF54qyj4qSWjDHIzvnelb/SC6ZYRwpREC3m2PM7kT49YjMbrz9M5x9mL1GXlkh6iIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzczBhk/bmh9sLpe4k/hZRRbHo6Rzr/ItXxhaxmx4Yh86+AmpW8
	/vMEENU8Xy4On2BL1Epl+rvfsHAoEfeF0Npnv2Jw5eGxq9dbjW3p5EN8xrtxwFJs09mL50fnaYU
	Jouj/pg==
X-Google-Smtp-Source: AGHT+IEKRFSFzLMwd8Cl8zS8v5bK04juZlQuScKDSBv7yZlW8dq70oQz+r7CxWdcnWIl9noUda0WH4TQWes=
X-Received: from pjbph7.prod.google.com ([2002:a17:90b:3bc7:b0:312:df0e:5f09])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:57c5:b0:312:ffdc:42b2
 with SMTP id 98e67ed59e1d1-31e77a20229mr16472400a91.23.1753756004947; Mon, 28
 Jul 2025 19:26:44 -0700 (PDT)
Date: Mon, 28 Jul 2025 19:26:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Message-ID: <20250729022640.3134066-1-yuzhuo@google.com>
Subject: [PATCH v1 0/7] perf bench: Add qspinlock benchmark
From: Yuzhuo Jing <yuzhuo@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Yuzhuo Jing <yzj@umich.edu>, 
	Yuzhuo Jing <yuzhuo@google.com>, Andrea Parri <parri.andrea@gmail.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Barret Rhoden <brho@google.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

As an effort to improve the perf bench subcommand, this patch series
adds benchmark for the kernel's queued spinlock implementation.

This series imports necessary kernel definitions such as atomics,
introduces userspace per-cpu adapter, and imports the qspinlock
implementation from the kernel tree to tools tree, with minimum
adaptions.

This subcommand enables convenient commands to investigate the
performance of kernel lock implementations, such as using sampling:

    perf record -- ./perf bench sync qspinlock -t5
    perf report

Yuzhuo Jing (7):
  tools: Import cmpxchg and xchg functions
  tools: Import smp_cond_load and atomic_cond_read
  tools: Partial import of prefetch.h
  tools: Implement userspace per-cpu
  perf bench: Import qspinlock from kernel
  perf bench: Add 'bench sync qspinlock' subcommand
  perf bench sync: Add latency histogram functionality

 tools/arch/x86/include/asm/atomic.h           |  14 +
 tools/arch/x86/include/asm/cmpxchg.h          | 113 +++++
 tools/include/asm-generic/atomic-gcc.h        |  47 ++
 tools/include/asm/barrier.h                   |  58 +++
 tools/include/linux/atomic.h                  |  27 ++
 tools/include/linux/compiler_types.h          |  30 ++
 tools/include/linux/percpu-simulate.h         | 128 ++++++
 tools/include/linux/prefetch.h                |  41 ++
 tools/perf/bench/Build                        |   2 +
 tools/perf/bench/bench.h                      |   1 +
 .../perf/bench/include/mcs_spinlock-private.h | 115 +++++
 tools/perf/bench/include/mcs_spinlock.h       |  19 +
 tools/perf/bench/include/qspinlock-private.h  | 204 +++++++++
 tools/perf/bench/include/qspinlock.h          | 153 +++++++
 tools/perf/bench/include/qspinlock_types.h    |  98 +++++
 tools/perf/bench/qspinlock.c                  | 411 ++++++++++++++++++
 tools/perf/bench/sync.c                       | 329 ++++++++++++++
 tools/perf/builtin-bench.c                    |   7 +
 tools/perf/check-headers.sh                   |  32 ++
 19 files changed, 1829 insertions(+)
 create mode 100644 tools/include/linux/percpu-simulate.h
 create mode 100644 tools/include/linux/prefetch.h
 create mode 100644 tools/perf/bench/include/mcs_spinlock-private.h
 create mode 100644 tools/perf/bench/include/mcs_spinlock.h
 create mode 100644 tools/perf/bench/include/qspinlock-private.h
 create mode 100644 tools/perf/bench/include/qspinlock.h
 create mode 100644 tools/perf/bench/include/qspinlock_types.h
 create mode 100644 tools/perf/bench/qspinlock.c
 create mode 100644 tools/perf/bench/sync.c

-- 
2.50.1.487.gc89ff58d15-goog



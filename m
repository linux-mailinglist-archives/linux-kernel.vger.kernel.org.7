Return-Path: <linux-kernel+bounces-627579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE75AA52F6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 19:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3BB93A56EF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 17:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6D7268688;
	Wed, 30 Apr 2025 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QsQNNvk0"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA15266EEA
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035462; cv=none; b=q3Or8FHSmNhDxhixKNUCy/DOHwDSmMpGkvGhUS4tN7o6W/jkhgdXkfpN8EmgJTr2+L0BZYTMIhWR8rXfMCR4KptdHhCDGsn/lRRzDn8w9SSNF/Q7QeXGRRYxZNFzRMYZiyqD7NSmVtYSMwLipFxPdIkUMYA8cROha8MMfHcQknQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035462; c=relaxed/simple;
	bh=/ZI8oocFmePwnPrADczmbkM9G18VX2Jck7JTxHxxN5w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=G/WXguTr2x2UGSAXzV1OTsTvZVjG2mc2LIYWqX+Y085MkUT5NzrGT8p3CnPtej7f/e0rMmLJF8qSbDBhrkGQ5jyKrQ9l3ZdoBkeL+e8Dn/8kPaNgHLNUM+UID6zGgpbwESuAVuJFFMtSQwoAddwT88iCWRWpRYcXCm4CUuI90pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QsQNNvk0; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2254e500a73so653865ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 10:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035458; x=1746640258; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x7zfLBBQ/5V3HHnUEHnPYc/DL+u9PLZZZi59FoGfXlc=;
        b=QsQNNvk0TTee0nyGSrWP0RQYQ9xyb3ZZ5cLAzzLLJyVjYKUgYvD++g+uSvqOvZh2Xc
         3NLrn7+ekbNCcqVFi9X4znSwe66unpxul8hwccgLS3Tfp+2yuvPNcq3duTjuiu+BGRap
         b/sNz1mONZaAJ4diF0xsB5wz2mCVGK2ZUs6WjIcTaHwkOqXe31U9zKmnjKnNmcKN61g1
         Nnpx7sh1LS0OoChzM8TwtBtpibYQWWKgjmp1C+xnNvrpChfiHAGBpj46hOddJeSLWKKB
         uBXBt+kOJB5+n6/AUsxEfMKNhjkB9q4BVnsfJzmuc0no972+uSuqPAkXJCZZiwogXCtV
         jbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035458; x=1746640258;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7zfLBBQ/5V3HHnUEHnPYc/DL+u9PLZZZi59FoGfXlc=;
        b=JzgIBkpq5grZwyKiI8pKEdQcL1bz3EbWge1YPSQwXxmgZr+LpC6Pj93cr1ErGhRS6k
         pRWI+Mskr6Cxx9/9nXRIRl5s+schmMP681BxIyyN3BUecfoWW4RyP12FCOhB5c7s4OoY
         SFzIBlM2QIOJjHlEdvrvlb+T6XFWWZlWlGqG5LlHWZwXyHGtluZYz1ytvz3Ua0sP+7cY
         X4nP8bBFIt48G8mFc+R1zCNVUxGcN2wx6UDJoVDdwOEHh3lOleLsj7rPQ/X4dRppEnMj
         6XDd6lYjnZ0dQUrC+oqrY2pBT255ovwwFI3peYLLAinCS+XGoaR5Y5diQQcTQ1d3XLpi
         UYoA==
X-Forwarded-Encrypted: i=1; AJvYcCXww87ryvo4aYSAdqcvV1VLCXgaCBB0nARVBT0KQgexDFJHz89dHU5YtfjVwwP906tPFcEt5LZo4Ag/QdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXvhjH7Dz90Fixh/YaCNBeLm22z1fRZDIrS1nPSErT47AYAdaS
	Pdo00/jL9N41LqCNHk+ht+ihb2sTjsFdm/Oi1AvGgt+8G3E+YYL5DPw9qUFbPuJRix3ATGYK8Zf
	PSmE9XA==
X-Google-Smtp-Source: AGHT+IH5/iEOLFNIwF//oysZn3jk7IU0R/a3fBQCiX+45FaueAvuyIUA68HgtY9PEuqB7CyUymhwX6CqKLgR
X-Received: from pgc13.prod.google.com ([2002:a05:6a02:2f8d:b0:b15:3f5d:cf8b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ecc4:b0:224:de2:7fd0
 with SMTP id d9443c01a7336-22df3509189mr60130355ad.25.1746035457973; Wed, 30
 Apr 2025 10:50:57 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:49:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-1-irogers@google.com>
Subject: [PATCH v2 00/47] Perf build support for -Wshorten-64-to-32
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Kyle Meyer <kyle.meyer@hpe.com>, 
	Ben Gainey <ben.gainey@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	Eder Zulian <ezulian@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>, He Zhe <zhe.he@windriver.com>, 
	Dirk Gouders <dirk@gouders.net>, Brian Geffon <bgeffon@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Howard Chu <howardchu95@gmail.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Jann Horn <jannh@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Yang Jihong <yangjihong@bytedance.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Hao Ge <gehao@kylinos.cn>, Tengda Wu <wutengda@huaweicloud.com>, 
	Gabriele Monaco <gmonaco@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Casey Chen <cachen@purestorage.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andrew Kreimer <algonell@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The clang warning -Wshorten-64-to-32 can be useful to catch
inadvertent truncation. In some instances this truncation can lead to
changing the sign of a result, for example, truncation to return an
int to fit a sort routine. Leo Yan found an issue here:
https://lore.kernel.org/lkml/20250331172759.115604-1-leo.yan@arm.com/
and so it is worthwhile doing a round to clean up all these warnings.

So that libbpf and bpftool aren't also cleaned up the first patch
makes these more optional within the build. The rest of the patches
try to do the right thing in silencing the warning, generally making
the implicit casts explicit. Some issues similar to Leo's were
discovered in this process.

v2: Move the truncation error fixes to patches 2 and 3 in the series
    (Leo Yan). Rebase and fix issues with the changed files. Drop the
    linux header patches that are now their own series (Yury Norov)
    and we can pick those fixes up when the kernel changes land.
    https://lore.kernel.org/lkml/20250430171534.132774-1-irogers@google.com/

Ian Rogers (47):
  perf build: Avoid building libbpf/bpftool with LIBBPF_DYNAMIC
  perf tests: Silence -Wshorten-64-to-32 warnings
  perf ui: Silence -Wshorten-64-to-32 warnings
  perf bench: Silence -Wshorten-64-to-32 warnings
  arm64: cputype: Silence -Wshorten-64-to-32 warnings
  x86/insn: Silence -Wshorten-64-to-32 warnings
  tools lib: Silence -Wshorten-64-to-32 warnings
  libperf: Silence -Wshorten-64-to-32 warnings
  tools subcmd: Silence -Wshorten-64-to-32 warnings
  perf arch x86: Silence -Wshorten-64-to-32 warnings
  perf arm-spe: Silence -Wshorten-64-to-32 warnings
  perf trace: Silence -Wshorten-64-to-32 warnings
  perf trace-event: Silence -Wshorten-64-to-32 warnings
  perf jvmti: Silence -Wshorten-64-to-32 warnings
  perf pmu: Silence -Wshorten-64-to-32 warnings
  perf annotate powerpc: Silence -Wshorten-64-to-32 warnings
  perf s390: Silence -Wshorten-64-to-32 warnings
  perf cs-etm: Silence -Wshorten-64-to-32 warnings
  perf stat: Silence -Wshorten-64-to-32 warnings
  perf dlfilter: Silence -Wshorten-64-to-32 warnings
  perf demangle: Silence -Wshorten-64-to-32 warnings
  perf annotate: Silence -Wshorten-64-to-32 warnings
  perf report: Silence -Wshorten-64-to-32 warnings
  perf help: Silence -Wshorten-64-to-32 warnings
  perf hisi-ptt: Silence -Wshorten-64-to-32 warnings
  perf probe: Silence -Wshorten-64-to-32 warnings
  perf kwork: Silence -Wshorten-64-to-32 warnings
  perf buildid: Silence -Wshorten-64-to-32 warnings
  perf lock: Silence -Wshorten-64-to-32 warnings
  perf mem: Silence -Wshorten-64-to-32 warnings
  perf script: Silence -Wshorten-64-to-32 warnings
  perf evlist: Silence -Wshorten-64-to-32 warnings
  perf bpf_counter: Silence -Wshorten-64-to-32 warnings
  perf ftrace: Silence -Wshorten-64-to-32 warnings
  perf record: Silence -Wshorten-64-to-32 warnings
  perf inject: Silence -Wshorten-64-to-32 warnings
  perf sched: Silence -Wshorten-64-to-32 warnings
  perf timechart: Silence -Wshorten-64-to-32 warnings
  perf list: Silence -Wshorten-64-to-32 warnings
  perf kvm: Silence -Wshorten-64-to-32 warnings
  perf diff: Silence -Wshorten-64-to-32 warnings
  perf daemon: Silence -Wshorten-64-to-32 warnings
  perf zlib: Silence -Wshorten-64-to-32 warnings
  perf symbol: Silence -Wshorten-64-to-32 warnings
  perf util: Silence -Wshorten-64-to-32 warnings
  perf hashmap: Silence -Wshorten-64-to-32 warnings
  perf: Silence -Wshorten-64-to-32 warnings

 tools/arch/arm64/include/asm/cputype.h        |  2 +-
 tools/arch/x86/lib/insn.c                     |  2 +-
 tools/lib/api/fs/fs.c                         |  4 +-
 tools/lib/bitmap.c                            |  2 +-
 tools/lib/perf/cpumap.c                       | 18 ++--
 tools/lib/perf/evsel.c                        | 40 +++-----
 tools/lib/perf/include/internal/cpumap.h      |  2 +-
 tools/lib/perf/include/internal/evsel.h       |  2 +-
 tools/lib/perf/include/internal/lib.h         |  2 +-
 tools/lib/perf/include/internal/mmap.h        |  4 +-
 tools/lib/perf/include/internal/threadmap.h   |  2 +-
 tools/lib/perf/include/internal/xyarray.h     |  8 +-
 tools/lib/perf/include/perf/cpumap.h          |  3 +-
 tools/lib/perf/lib.c                          |  2 +-
 tools/lib/perf/mmap.c                         | 13 ++-
 tools/lib/perf/threadmap.c                    |  4 +-
 tools/lib/perf/xyarray.c                      |  2 +-
 tools/lib/string.c                            |  6 +-
 tools/lib/subcmd/help.c                       | 28 +++---
 tools/lib/subcmd/help.h                       |  6 --
 tools/lib/subcmd/parse-options.c              | 16 +--
 tools/lib/vsprintf.c                          |  6 +-
 tools/perf/Makefile.perf                      | 13 ++-
 .../perf/arch/powerpc/annotate/instructions.c |  2 +-
 tools/perf/arch/x86/tests/bp-modify.c         |  2 +-
 tools/perf/arch/x86/util/intel-bts.c          |  4 +-
 tools/perf/arch/x86/util/intel-pt.c           | 10 +-
 tools/perf/arch/x86/util/iostat.c             |  2 +-
 tools/perf/arch/x86/util/kvm-stat.c           |  6 +-
 tools/perf/arch/x86/util/perf_regs.c          |  3 +-
 tools/perf/arch/x86/util/topdown.c            |  2 +-
 tools/perf/bench/breakpoint.c                 |  8 +-
 tools/perf/bench/epoll-wait.c                 |  3 +-
 tools/perf/bench/evlist-open-close.c          |  8 +-
 tools/perf/bench/find-bit-bench.c             |  5 +-
 tools/perf/bench/futex.h                      |  4 +-
 tools/perf/bench/inject-buildid.c             |  8 +-
 tools/perf/bench/mem-functions.c              |  2 +-
 tools/perf/bench/pmu-scan.c                   | 12 +--
 tools/perf/bench/sched-messaging.c            |  4 +-
 tools/perf/bench/sched-pipe.c                 | 15 +--
 tools/perf/bench/sched-seccomp-notify.c       |  2 +-
 tools/perf/bench/synthesize.c                 |  6 +-
 tools/perf/builtin-annotate.c                 |  4 +-
 tools/perf/builtin-bench.c                    |  2 +-
 tools/perf/builtin-buildid-cache.c            |  2 +-
 tools/perf/builtin-buildid-list.c             |  2 +-
 tools/perf/builtin-c2c.c                      | 21 ++--
 tools/perf/builtin-daemon.c                   |  5 +-
 tools/perf/builtin-diff.c                     | 10 +-
 tools/perf/builtin-evlist.c                   |  2 +-
 tools/perf/builtin-ftrace.c                   | 17 ++--
 tools/perf/builtin-help.c                     |  4 +-
 tools/perf/builtin-inject.c                   | 28 +++---
 tools/perf/builtin-kmem.c                     | 39 ++++----
 tools/perf/builtin-kvm.c                      |  8 +-
 tools/perf/builtin-kwork.c                    | 11 +--
 tools/perf/builtin-list.c                     |  4 +-
 tools/perf/builtin-lock.c                     | 16 +--
 tools/perf/builtin-mem.c                      |  2 +-
 tools/perf/builtin-record.c                   | 66 +++++++------
 tools/perf/builtin-report.c                   |  4 +-
 tools/perf/builtin-sched.c                    | 56 +++++------
 tools/perf/builtin-script.c                   | 39 ++++----
 tools/perf/builtin-stat.c                     |  6 +-
 tools/perf/builtin-timechart.c                | 60 ++++++------
 tools/perf/builtin-top.c                      |  4 +-
 tools/perf/builtin-trace.c                    | 98 ++++++++++---------
 tools/perf/dlfilters/dlfilter-test-api-v0.c   |  4 +-
 tools/perf/jvmti/jvmti_agent.c                |  6 +-
 tools/perf/perf-sys.h                         |  3 +-
 tools/perf/perf.c                             |  2 +-
 tools/perf/tests/api-io.c                     |  2 +-
 tools/perf/tests/bp_signal.c                  |  6 +-
 tools/perf/tests/bp_signal_overflow.c         |  6 +-
 tools/perf/tests/builtin-test.c               |  9 +-
 tools/perf/tests/code-reading.c               |  4 +-
 tools/perf/tests/dso-data.c                   | 10 +-
 tools/perf/tests/mmap-thread-lookup.c         |  2 +-
 tools/perf/tests/openat-syscall-tp-fields.c   |  2 +-
 tools/perf/tests/pmu-events.c                 |  2 +-
 tools/perf/tests/sigtrap.c                    |  4 +-
 tools/perf/tests/switch-tracking.c            | 11 ++-
 tools/perf/tests/vmlinux-kallsyms.c           |  4 +-
 tools/perf/tests/wp.c                         |  4 +-
 tools/perf/trace/beauty/arch_prctl.c          |  2 +-
 tools/perf/trace/beauty/eventfd.c             |  2 +-
 tools/perf/trace/beauty/fcntl.c               |  5 +-
 tools/perf/trace/beauty/flock.c               |  2 +-
 tools/perf/trace/beauty/fs_at_flags.c         |  4 +-
 tools/perf/trace/beauty/futex_op.c            |  2 +-
 tools/perf/trace/beauty/futex_val3.c          |  2 +-
 tools/perf/trace/beauty/ioctl.c               |  2 +-
 tools/perf/trace/beauty/kcmp.c                |  8 +-
 tools/perf/trace/beauty/mmap.c                |  2 +-
 tools/perf/trace/beauty/mode_t.c              |  2 +-
 tools/perf/trace/beauty/msg_flags.c           |  2 +-
 tools/perf/trace/beauty/open_flags.c          |  2 +-
 tools/perf/trace/beauty/perf_event_open.c     |  4 +-
 tools/perf/trace/beauty/pid.c                 |  2 +-
 tools/perf/trace/beauty/pkey_alloc.c          |  2 +-
 tools/perf/trace/beauty/prctl.c               | 10 +-
 tools/perf/trace/beauty/sched_policy.c        |  2 +-
 tools/perf/trace/beauty/seccomp.c             |  4 +-
 tools/perf/trace/beauty/signum.c              |  2 +-
 tools/perf/trace/beauty/socket.c              |  6 +-
 tools/perf/trace/beauty/socket_type.c         |  2 +-
 tools/perf/trace/beauty/statx.c               |  2 +-
 .../beauty/tracepoints/x86_irq_vectors.c      |  3 +-
 tools/perf/trace/beauty/tracepoints/x86_msr.c |  3 +-
 tools/perf/trace/beauty/waitid_options.c      |  2 +-
 tools/perf/ui/hist.c                          | 18 ++--
 tools/perf/ui/stdio/hist.c                    |  5 +-
 tools/perf/util/annotate.c                    | 22 ++---
 .../util/arm-spe-decoder/arm-spe-decoder.c    |  4 +-
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     |  2 +-
 tools/perf/util/arm-spe.c                     | 24 ++---
 tools/perf/util/auxtrace.c                    |  8 +-
 tools/perf/util/bpf-event.c                   |  2 +-
 tools/perf/util/bpf-filter.c                  | 20 ++--
 tools/perf/util/bpf_counter.c                 |  6 +-
 tools/perf/util/bpf_counter_cgroup.c          |  2 +-
 tools/perf/util/bpf_ftrace.c                  |  4 +-
 tools/perf/util/bpf_kwork_top.c               |  2 +-
 tools/perf/util/bpf_lock_contention.c         | 17 ++--
 tools/perf/util/bpf_off_cpu.c                 |  4 +-
 tools/perf/util/build-id.c                    |  2 +-
 tools/perf/util/cacheline.c                   |  5 +-
 tools/perf/util/callchain.c                   | 12 +--
 tools/perf/util/callchain.h                   |  2 +-
 tools/perf/util/cgroup.c                      |  4 +-
 tools/perf/util/comm.c                        |  2 +-
 tools/perf/util/config.c                      |  6 +-
 tools/perf/util/cpumap.c                      |  4 +-
 tools/perf/util/cs-etm-base.c                 |  4 +-
 tools/perf/util/debug.c                       |  7 +-
 tools/perf/util/demangle-java.c               |  4 +-
 tools/perf/util/demangle-ocaml.c              |  3 +-
 tools/perf/util/disasm.c                      | 11 ++-
 tools/perf/util/dlfilter.c                    | 10 +-
 tools/perf/util/env.c                         |  2 +-
 tools/perf/util/event.c                       |  4 +-
 tools/perf/util/evlist.c                      | 29 +++---
 tools/perf/util/evsel.c                       | 35 +++----
 tools/perf/util/genelf.c                      |  2 +-
 tools/perf/util/hashmap.c                     | 10 +-
 tools/perf/util/header.c                      | 54 +++++-----
 tools/perf/util/help-unknown-cmd.c            | 14 +--
 tools/perf/util/hisi-ptt.c                    |  8 +-
 tools/perf/util/hist.c                        |  7 +-
 tools/perf/util/hwmon_pmu.c                   |  8 +-
 tools/perf/util/intel-bts.c                   |  4 +-
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 30 +++---
 .../intel-pt-decoder/intel-pt-insn-decoder.c  |  2 +-
 .../perf/util/intel-pt-decoder/intel-pt-log.c |  2 +-
 .../intel-pt-decoder/intel-pt-pkt-decoder.c   |  2 +-
 tools/perf/util/intel-pt.c                    | 38 +++----
 tools/perf/util/jitdump.c                     | 24 ++---
 tools/perf/util/levenshtein.c                 | 18 ++--
 tools/perf/util/machine.c                     | 14 +--
 tools/perf/util/map.c                         |  4 +-
 tools/perf/util/maps.c                        |  6 +-
 tools/perf/util/mem-events.c                  | 12 +--
 tools/perf/util/mem2node.c                    |  2 +-
 tools/perf/util/memswap.c                     |  4 +-
 tools/perf/util/memswap.h                     |  4 +-
 tools/perf/util/metricgroup.c                 | 15 ++-
 tools/perf/util/mmap.c                        |  6 +-
 tools/perf/util/parse-events.c                | 16 +--
 tools/perf/util/pmu.c                         |  9 +-
 tools/perf/util/pmus.c                        | 16 +--
 tools/perf/util/print_binary.c                | 13 ++-
 tools/perf/util/probe-event.c                 | 13 +--
 tools/perf/util/probe-file.c                  | 12 ++-
 tools/perf/util/python.c                      |  4 +-
 tools/perf/util/s390-sample-raw.c             |  4 +-
 .../scripting-engines/trace-event-python.c    | 13 +--
 tools/perf/util/session.c                     | 29 +++---
 tools/perf/util/sort.c                        | 20 ++--
 tools/perf/util/srccode.c                     |  6 +-
 tools/perf/util/srcline.c                     |  2 +-
 tools/perf/util/stat-display.c                | 10 +-
 tools/perf/util/strfilter.c                   |  2 +-
 tools/perf/util/string.c                      | 11 ++-
 tools/perf/util/svghelper.c                   | 23 ++---
 tools/perf/util/symbol-elf.c                  | 33 ++++---
 tools/perf/util/symbol.c                      | 10 +-
 tools/perf/util/synthetic-events.c            | 22 ++---
 tools/perf/util/target.c                      |  2 +-
 tools/perf/util/thread-stack.c                |  2 +-
 tools/perf/util/thread.c                      |  4 +-
 tools/perf/util/thread_map.c                  |  6 +-
 tools/perf/util/time-utils.c                  |  9 +-
 tools/perf/util/tool.c                        |  2 +-
 tools/perf/util/tool_pmu.c                    |  2 +-
 tools/perf/util/trace-event-info.c            |  3 +-
 tools/perf/util/trace-event-parse.c           |  2 +-
 tools/perf/util/trace-event-read.c            | 23 +++--
 tools/perf/util/trace-event-scripting.c       |  2 +-
 tools/perf/util/util.c                        |  9 +-
 tools/perf/util/util.h                        |  2 +-
 tools/perf/util/values.c                      |  4 +-
 tools/perf/util/zlib.c                        |  2 +-
 203 files changed, 963 insertions(+), 922 deletions(-)

-- 
2.49.0.906.g1f30a19c02-goog



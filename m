Return-Path: <linux-kernel+bounces-813653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D20B548DD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372A91CC03DB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7405B2E0915;
	Fri, 12 Sep 2025 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5Iwa9UX"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EBD2DFA2F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671920; cv=none; b=tr6iaBFGhOjtktpJ2QfAbkMLFWJBjLL9YtoaH0Zk9Bqveq2O6zdbUXqcg10431OCUH4Q+chO4Vplow/KJ9X+TnAs6+N43PTcc7Y27+RPGOtDHBAhyQGmUR2rh+I+HwqEVCH044sbwaqWoeTCq0F/XCcyJ9joMgXvtH88k1HbyGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671920; c=relaxed/simple;
	bh=FHszHWwv+FXNM1rWp+0e1v1GXLl+e5k0dLTLr+1rTQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jpfMQOMXTuRu0ermf5Q9FWvvqdUWsAjhZ88CJ/qUC4RVMgDKZSCrVEj0CjWUz2KDjcUU3+45pGFWq610ki2uwCwX4diFsRsApKcwMk2XM/JrEUGKb3cEzjH0J2EJYMUIdfl258OVhuJm6LU1n1BnB7iL5O3BhbsEYp2vBIMUGa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5Iwa9UX; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso1606486b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671918; x=1758276718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a0RAur8Marng0nhbSNOQRJYXrBS2GdOE60OklyU/Dxo=;
        b=G5Iwa9UXc1yl/uSIW/S8znrgZgqBhdLNuTUOIvfmiViKq9fXt2wiKuQFQriORBCsuR
         UnjuAcV0ntSJQJTOucdNvwn8lDY+BvooTLLRq63dYlH29u1zvLxle/amW1xRZlYzOFOX
         pCghPQ3K+KWWw+RfwvTFKr8YjAJpBA2rafy3CiqAVekAayZcaWKy4azHejRFJNR5+2bU
         MQVzyDFQcgwj+G3cwpty95RCZ4CY5nj2VRdeCC2q3QS1MStCt1uQLUBOUBNiSoSsta9c
         YijI5+zjGamIvI2C4jI/lkdC3eerbL4bJej+SWjnp6fpl2+oCUKBcDKv/Qvz+iNi3XdG
         oIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671918; x=1758276718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0RAur8Marng0nhbSNOQRJYXrBS2GdOE60OklyU/Dxo=;
        b=Eg38HUFLF2rT+VVL4h+PSCqcsXQFjZqURwGJmBSZW45xOMkkL+CwT3L5E0IxUW/RJG
         sugsb6i8cNx0cBYQ8kzTAuVl9WQeSwb8RLrii3cYjizVPEBcZ1YpZAtMzyRg1gb0dkC7
         265KbsDKUS7SW8c8KpX1o/nuQZ43D4Xj0ssbxXUVsZK66rerFdMhdzC4m2DUJEI+M+7a
         PuN/1plTwoAMcrAk0oAWPifLP4oq54QEQ+wJukqPuqrxVkZWVZ7tdW1RcxX9z5Z1BNCZ
         Cv1WGb4+jL9GY42r/Zfn9tIGbrP2AGAi23mtW+dtx3I9tjbRinhkRh9APd+fNoTYM6Yc
         L9pg==
X-Forwarded-Encrypted: i=1; AJvYcCUmmCF2fhWmTjHDwjrDzX5lmBWpz88EjvG6/0MtsSvPI9VKcAUF1qZQeD2QoIy+5qG2bOYerJPlKI1etUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiXQMjvlXZEIc1J2USI3d0F2jImpUs6zgwUg42shRzm3W8wTLI
	BV5SSF3PfvJDW1vprCfftm0QfVccswng+SapGxxZBoFzf3nXpLo5Mq7H
X-Gm-Gg: ASbGnctRbjeEPt3jdfQ96tU1eXsTy0eLGFVdibZP5MtWlnvSA1ax4JCd3tJ7MkvaAFV
	jeYzNVm8FjTg4rDzhPOyBtP1Df2/XnIetSV0MdnOnxlXp8q139x/GS2Nqu8XRF12BZSUbCmyDPP
	5J9izvABe3p3Bmmq+g9d2aARhx0bCIm9vFUvAKBZn5uyqmwHGqPKz7XqCNxayDNUk1KC+LJ/WxH
	mEoSkak9sFYkCamzTvrboOM8RiSFirrMgG8Ek/dHpT5m+GgH0Xy/U7I2oR0mV/1ao/u1jIxUL4M
	KYbb/agm7CjEuOxAe80X6WvnMWLbViFEfHMZQ2SVcu/bKRDHu+IGgDXwjyekGFyDqirpyKRx4wG
	v0wmk5vfsKhlDHpm7xml91qc1sDxFKpgGpUb/uYF6Ik29oGutyQ==
X-Google-Smtp-Source: AGHT+IFPwbQYuxjB7a0ey4JvHITRQZqedavu3i0Y8Nu7EBQTFjbU8//ZN1py4iYXafr0IzmJIdbrVA==
X-Received: by 2002:a05:6a00:194b:b0:772:5271:d1ba with SMTP id d2e1a72fcca58-77612061e2emr3147992b3a.7.1757671917940;
        Fri, 12 Sep 2025 03:11:57 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b18371sm5059816b3a.49.2025.09.12.03.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:11:57 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <kees@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Rong Xu <xur@google.com>,
	Naveen N Rao <naveen@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Nam Cao <namcao@linutronix.de>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com,
	"David S. Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v4 00/21] mm/ksw: Introduce real-time KStackWatch debugging tool
Date: Fri, 12 Sep 2025 18:11:10 +0800
Message-ID: <20250912101145.465708-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series introduces KStackWatch, a lightweight kernel debugging tool
for detecting kernel stack corruption in real time.

The motivation comes from scenarios where corruption occurs silently in one function
but manifests later as a crash in another. Using other tools may not reproduce the
issue due to its heavy overhead. with no direct call trace linking the two. Such bugs
are often extremely hard to debug with existing tools.

I demonstrate this scenario in test2 (silent corruption test).

KStackWatch works by combining a hardware breakpoint with kprobe and fprobe.
It can watch a stack canary or a selected local variable and detects the moment the
corruption actually occurs. This allows developers to pinpoint the real source rather
than only observing the final crash.

Key features include:

  - Lightweight overhead with minimal impact on bug reproducibility
  - Real-time detection of stack corruption
  - Simple configuration through `/proc/kstackwatch`
  - Support for recursive depth filter

To validate the approach, the patch includes a test module and a test script.

---
Changelog

V4:
  * Solve the lockdep issues with:
    * per-task KStackWatch context to track depth
    * atomic flag to protect watched_addr
  * Use refactored version of arch_reinstall_hw_breakpoint

  Patches 1–3 of this series are also used in the wprobe work proposed by
  Masami Hiramatsu, so there may be some overlap between our patches.
  Patch 3 comes directly from Masami Hiramatsu (thanks).

V3:
  Main changes:
    * Use modify_wide_hw_breakpoint_local() (from Masami)
    * Add atomic flag to restrict /proc/kstackwatch to a single opener
    * Protect stack probe with an atomic PID flag
    * Handle CPU hotplug for watchpoints
    * Add preempt_disable/enable in ksw_watch_on_local_cpu()
    * Introduce const struct ksw_config *ksw_get_config(void) and use it
    * Switch to global watch_attr, remove struct watch_info
    * Validate local_var_len in parser()
    * Handle case when canary is not found
    * Use dump_stack() instead of show_regs() to allow module build

  Cleanups:
    * Reduce logging and comments
    * Format logs with KBUILD_MODNAME
    * Remove unused headers

  Documentation:
    * Add new document

V2:
  https://lore.kernel.org/all/20250904002126.1514566-1-wangjinchao600@gmail.com/
  * Make hardware breakpoint and stack operations architecture-independent.

V1:
  https://lore.kernel.org/all/20250828073311.1116593-1-wangjinchao600@gmail.com/
  Core Implementation
    *   Replaced kretprobe with fprobe for function exit hooking, as suggested
        by Masami Hiramatsu
    *   Introduced per-task depth logic to track recursion across scheduling
    *   Removed the use of workqueue for a more efficient corruption check
    *   Reordered patches for better logical flow
    *   Simplified and improved commit messages throughout the series
    *   Removed initial archcheck which should be improved later


  Testing and Architecture

    *   Replaced the multiple-thread test with silent corruption test
    *   Split self-tests into a separate patch to improve clarity.

  Maintenance
    *   Added a new entry for KStackWatch to the MAINTAINERS file.

RFC:
  https://lore.kernel.org/lkml/20250818122720.434981-1-wangjinchao600@gmail.com/
---

The series is structured as follows:

Jinchao Wang (20):
  x86/hw_breakpoint: Unify breakpoint install/uninstall
  x86/hw_breakpoint: Add arch_reinstall_hw_breakpoint
  mm/ksw: add build system support
  mm/ksw: add ksw_config struct and parser
  mm/ksw: add singleton /proc/kstackwatch interface
  mm/ksw: add HWBP pre-allocation
  mm/ksw: Add atomic ksw_watch_on() and ksw_watch_off()
  mm/ksw: support CPU hotplug
  sched: add per-task KStackWatch context
  mm/ksw: add probe management helpers
  mm/ksw: resolve stack watch addr and len
  mm/ksw: manage probe and HWBP lifecycle via procfs
  mm/ksw: add self-debug helpers
  mm/ksw: add test module
  mm/ksw: add stack overflow test
  mm/ksw: add silent corruption test case
  mm/ksw: add recursive stack corruption test
  tools/ksw: add test script
  docs: add KStackWatch document
  MAINTAINERS: add entry for KStackWatch

Masami Hiramatsu (Google) (1):
  HWBP: Add modify_wide_hw_breakpoint_local() API

 Documentation/dev-tools/kstackwatch.rst |  94 +++++++++
 MAINTAINERS                             |   8 +
 arch/Kconfig                            |  10 +
 arch/x86/Kconfig                        |   1 +
 arch/x86/include/asm/hw_breakpoint.h    |   8 +
 arch/x86/kernel/hw_breakpoint.c         | 148 +++++++------
 include/linux/hw_breakpoint.h           |   6 +
 include/linux/kstackwatch_types.h       |  13 ++
 include/linux/sched.h                   |   5 +
 kernel/events/hw_breakpoint.c           |  36 ++++
 mm/Kconfig.debug                        |  21 ++
 mm/Makefile                             |   1 +
 mm/kstackwatch/Makefile                 |   8 +
 mm/kstackwatch/kernel.c                 | 239 +++++++++++++++++++++
 mm/kstackwatch/kstackwatch.h            |  53 +++++
 mm/kstackwatch/stack.c                  | 194 ++++++++++++++++++
 mm/kstackwatch/test.c                   | 262 ++++++++++++++++++++++++
 mm/kstackwatch/watch.c                  | 181 ++++++++++++++++
 tools/kstackwatch/kstackwatch_test.sh   |  40 ++++
 19 files changed, 1266 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/dev-tools/kstackwatch.rst
 create mode 100644 include/linux/kstackwatch_types.h
 create mode 100644 mm/kstackwatch/Makefile
 create mode 100644 mm/kstackwatch/kernel.c
 create mode 100644 mm/kstackwatch/kstackwatch.h
 create mode 100644 mm/kstackwatch/stack.c
 create mode 100644 mm/kstackwatch/test.c
 create mode 100644 mm/kstackwatch/watch.c
 create mode 100755 tools/kstackwatch/kstackwatch_test.sh

-- 
2.43.0



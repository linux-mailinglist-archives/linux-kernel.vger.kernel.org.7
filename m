Return-Path: <linux-kernel+bounces-752029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 750DDB1709D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B683A5A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4815F230BE0;
	Thu, 31 Jul 2025 11:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CSGrwLsj"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9E835973
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753962708; cv=none; b=uFOLnNHVPiTxtOVnyOXAcnPKQf2ihJGLCT5sH4f83nKdbGi2OljIOV+7t7Isa0StIOAGCGGITCo72naDf7WKvQAESBuT8iPYH9szpuQx1fVhpkzFXW+CGMaJ6OZIRkBF3Fb4GWHCzugfUyCK+i/VAOGJ0j2vS7K8hSc3npl9Ne0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753962708; c=relaxed/simple;
	bh=Mc0K2EMSYiBfNeGrWw739MDSYoUCJWAl/dgHFzyg3No=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hF1l+zTzWzZ9FTIElBD50RdVMPMvrmvhPPpCIsO59BrYYS2Ob79yX+I1zqwFasF0ptrhC3p7J+jBfUzGcsGIb7TbREVC6uj6plLM0P9GsRtSua9ExyEOPDT25TuBJfN9q6Ht0EQWWRN25B0aWhSjAkZ+2VUURE0wmLlF/xso93A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CSGrwLsj; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b7812e887aso348505f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 04:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753962704; x=1754567504; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cckhx9CXRNcAY8FjYomyKrgfIuhjcELUGfeGvXt5wWc=;
        b=CSGrwLsjfCJ3Ajo9zspE+OuB2u4uwctg6B6SLGCZnFj4lPJadvq7eX7TlGElMPFQtj
         +p7j4zswrSmIcxbzzRcjAMv5FPtZW0BrqiUYkIMP4UMZaICtnrQ0eFYLOmeK4Eapi4GU
         /hXs1X6RS0XZBcqjx1Iz5t28FcsqG0deVs6zWbtyYY4jlmCBnd6R7P9yH4OGoqVQMtbh
         NNaBYfd2CCAFVQ+GE7gNJPCmPnaJXM2MI/cRpPTrhrVr1z/BxBw3rYZ0IXVcllGVZcTB
         zVDgm1SgfLZZ4wpepPo49Rfo6jt31a0R4ZMNd7/VKXTWBSnUtCXue1dDWEu8r4pycJ74
         mTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753962704; x=1754567504;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cckhx9CXRNcAY8FjYomyKrgfIuhjcELUGfeGvXt5wWc=;
        b=ePCHJDE8woGSuauK65Y6G+ItEFaTF92+gATvN7Thv8unXpaLlhJ2Ep86CIGz866lbS
         oOuF/ChLXB1O3lcEhbhr5cmAGCnm0NELV2PGuUGmhelb2RGCH2AqkwkMcfjipAXULhoe
         EMeqUpqHVulOjm7wKLPtYt6rSYv3YdcBiJQ/gTeNX0GtPm7kdSNZPI0Bn32/ikvxJD7L
         ZcY0GozNn27pVJaRGVPUocttItVEEneseoTNlcp3KArLwgetQF56TujfsFVXYzN+MMUr
         ClWpu0kQ7bZSy/i7nWKogz6BlHQG4SMuB7XyUqGGmq14kmmqhMFB+MrhVeiyyliaBEO4
         LY1w==
X-Forwarded-Encrypted: i=1; AJvYcCVnfpYzTdqhnBr7pjg+nXYbmHPduyEQBmWjpTnJPTpE1OWSiHWwLxpHBYUxCEXHgmsDgVZtt4cozwmiYjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJBXUl1eqltTpdurnLeAVKN0wt5ybFaw6CxXCzKMws9/nk5bwY
	exWm3URdFsb2c5JBF3Se1Be4uduQPI+F5cYPR0CbIT3e6JGG0w1X60T5nyjmPXWkvhxio9dA831
	9U1N9PA==
X-Google-Smtp-Source: AGHT+IEkhfUMq0ckCs1L0FfZ383yDnnJL1U1O2d9k8VzzzBS97lsOoXjZtHxbS5GVfECjRiXfXRl0RMiPYc=
X-Received: from wrus5.prod.google.com ([2002:a5d:6a85:0:b0:3b7:95af:cd73])
 (user=glider job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2889:b0:3b6:cf8:64b3
 with SMTP id ffacd0b85a97d-3b794ffcfcamr5188031f8f.34.1753962704086; Thu, 31
 Jul 2025 04:51:44 -0700 (PDT)
Date: Thu, 31 Jul 2025 13:51:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250731115139.3035888-1-glider@google.com>
Subject: [PATCH v4 00/10] Coverage deduplication for KCOV
From: Alexander Potapenko <glider@google.com>
To: glider@google.com
Cc: quic_jiangenj@quicinc.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Aleksandr Nogikh <nogikh@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

As mentioned by Joey Jiao in [1], the current kcov implementation may
suffer from certain syscalls overflowing the userspace coverage buffer.

According to our measurements, among 24 syzkaller instances running
upstream Linux, 5 had a coverage overflow in at least 50% of executed
programs. The median percentage of programs with overflows across those 24
instances was 8.8%.

One way to mitigate this problem is to increase the size of the kcov buffer
in the userspace application using kcov. But right now syzkaller already
uses 4Mb per each of up to 32 threads to store the coverage, and increasing
it further would result in reduction in the number of executors on a single
machine.  Replaying the same program with an increased buffer size in the
case of overflow would also lead to fewer executions being possible.

When executing a single system call, excessive coverage usually stems from
loops, which write the same PCs into the output buffer repeatedly. Although
collecting precise traces may give us some insights into e.g. the number of
loop iterations and the branches being taken, the fuzzing engine does not
take advantage of these signals, and recording only unique PCs should be
just as practical.

In [1] Joey Jiao suggested using a hash table to deduplicate the coverage
signal on the kernel side. While being universally applicable to all types
of data collected by kcov, this approach adds another layer of complexity,
requiring dynamically growing the map. Another problem is potential hash
collisions, which can as well lead to lost coverage. Hash maps are also
unavoidably sparse, which potentially requires more memory.

The approach proposed in this patch series is to assign a unique (and
almost) sequential ID to each of the coverage callbacks in the kernel. Then
we carve out a fixed-sized bitmap from the userspace trace buffer, and on
every callback invocation we:

- obtain the callback_ID;
- if bitmap[callback_ID] is set, append the PC to the trace buffer;
- set bitmap[callback_ID] to true.

LLVM's -fsanitize-coverage=trace-pc-guard replaces every coverage callback
in the kernel with a call to
__sanitizer_cov_trace_pc_guard(&guard_variable) , where guard_variable is a
4-byte global that is unique for the callsite.

This allows us to lazily allocate sequential numbers just for the callbacks
that have actually been executed, using a lock-free algorithm.

This patch series implements a new config, CONFIG_KCOV_ENABLE_GUARDS, which
utilizes the mentioned LLVM flag for coverage instrumentation. In addition
to the existing coverage collection modes, it introduces
ioctl(KCOV_UNIQUE_ENABLE), which splits the existing kcov buffer into the
bitmap and the trace part for a particular fuzzing session, and collects
only unique coverage in the trace buffer.

To reset the coverage between runs, it is now necessary to set trace[0] to
0 AND clear the entire bitmap. This is still considered feasible, based on
the experimental results below.

Alternatively, users can call ioctl(KCOV_RESET_TRACE) to reset the coverage.
This makes it possible to make the coverage buffer read-only, so that it
is harder to corrupt.

The current design does not address the deduplication of KCOV_TRACE_CMP
comparisons; however, the number of kcov overflows during the hints
collection process is insignificant compared to the overflows of
KCOV_TRACE_PC.

In addition to the mentioned changes, this patch series implements
a selftest in tools/testing/selftests/kcov/kcov_test. This will help
check the variety of different coverage collection modes.

Experimental results.

We've conducted an experiment running syz-testbed [3] on 10 syzkaller
instances for 24 hours.  Out of those 10 instances, 5 were enabling the
kcov_deduplicate flag from [4], which makes use of the KCOV_UNIQUE_ENABLE
ioctl, reserving 4096 words (262144 bits) for the bitmap and leaving 520192
words for the trace collection.

Below are the average stats from the runs.

kcov_deduplicate=false:
  corpus: 52176
  coverage: 302658
  cover overflows: 225288
  comps overflows: 491
  exec total: 1417829
  max signal: 318894

kcov_deduplicate=true:
  corpus: 52581
  coverage: 304344
  cover overflows: 986
  comps overflows: 626
  exec total: 1484841
  max signal: 322455

[1] https://lore.kernel.org/linux-arm-kernel/20250114-kcov-v1-5-004294b931a2@quicinc.com/T/
[2] https://clang.llvm.org/docs/SanitizerCoverage.html
[3] https://github.com/google/syzkaller/tree/master/tools/syz-testbed
[4] https://github.com/ramosian-glider/syzkaller/tree/kcov_dedup-new

v4:
 - fix a compilation error detected by the kernel test robot <lkp@intel.com>
 - add CONFIG_KCOV_UNIQUE=y as a prerequisite for kcov_test
 - Reviewed-by: tags

v3:
 - drop "kcov: apply clang-format to kcov code"
 - address reviewers' comments
 - merge __sancov_guards into .bss
 - proper testing of unique coverage in kcov_test
 - fix a warning detected by the kernel test robot <lkp@intel.com>
 - better comments

v2:
 - assorted cleanups (enum kcov_mode, docs)
 - address reviewers' comments
 - drop R_X86_64_REX_GOTPCRELX support
 - implement ioctl(KCOV_RESET_TRACE)
 - add a userspace selftest

Alexander Potapenko (10):
  x86: kcov: disable instrumentation of arch/x86/kernel/tsc.c
  kcov: elaborate on using the shared buffer
  kcov: factor out struct kcov_state
  mm/kasan: define __asan_before_dynamic_init, __asan_after_dynamic_init
  kcov: x86: introduce CONFIG_KCOV_UNIQUE
  kcov: add trace and trace_size to struct kcov_state
  kcov: add ioctl(KCOV_UNIQUE_ENABLE)
  kcov: add ioctl(KCOV_RESET_TRACE)
  kcov: selftests: add kcov_test
  kcov: use enum kcov_mode in kcov_mode_enabled()

 Documentation/dev-tools/kcov.rst         | 124 +++++++
 MAINTAINERS                              |   3 +
 arch/x86/Kconfig                         |   1 +
 arch/x86/kernel/Makefile                 |   2 +
 arch/x86/kernel/vmlinux.lds.S            |   1 +
 include/asm-generic/vmlinux.lds.h        |  13 +-
 include/linux/kcov.h                     |   6 +-
 include/linux/kcov_types.h               |  37 +++
 include/linux/sched.h                    |  13 +-
 include/uapi/linux/kcov.h                |   2 +
 kernel/kcov.c                            | 368 ++++++++++++++-------
 lib/Kconfig.debug                        |  26 ++
 mm/kasan/generic.c                       |  24 ++
 mm/kasan/kasan.h                         |   2 +
 scripts/Makefile.kcov                    |   7 +
 scripts/module.lds.S                     |  35 ++
 tools/objtool/check.c                    |   3 +-
 tools/testing/selftests/kcov/Makefile    |   6 +
 tools/testing/selftests/kcov/config      |   2 +
 tools/testing/selftests/kcov/kcov_test.c | 401 +++++++++++++++++++++++
 20 files changed, 949 insertions(+), 127 deletions(-)
 create mode 100644 include/linux/kcov_types.h
 create mode 100644 tools/testing/selftests/kcov/Makefile
 create mode 100644 tools/testing/selftests/kcov/config
 create mode 100644 tools/testing/selftests/kcov/kcov_test.c

-- 
2.50.1.552.g942d659e1b-goog



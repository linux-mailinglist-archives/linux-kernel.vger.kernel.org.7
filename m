Return-Path: <linux-kernel+bounces-885995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB65C34784
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B95EE4EB6EE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC8C21CC6A;
	Wed,  5 Nov 2025 08:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Kj6u27zC"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF03F28000F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331328; cv=none; b=MMuWiKLxk1VUrw0rBWKMzW7lf+8nDxD54w9UcrtGkx1M+dvYlts8hUotFS/UxOLNOyG8scXJn8eebMEvGRstr70/5+VkUn/458dUrJDoEgMEuYCAvfwN82CU03H8vdG8LK+9iFSVMzrq4YZOMrPcXYgE+NLBuw+jWNLLLdSfa6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331328; c=relaxed/simple;
	bh=qzzU/bDklvlIBuVQ/YOO7zS0oISQIlSeaAM3UkCXeY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q+wYK5w/9+zhNFi0gZ6Hl0SIkfr/gv4OTAEXBr+SgfRzD2R8fKgL0OMJpKC7tbLlP4ukKdQ+gDUfq9aEvrve/L+Uuk6IaCZvpsVFD6Nn2al/p9GI+CjgkCaAuUJIEINk6SYp475wBBUZXfM8Ko7up2L5o5out+8R33lkMJBJoDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Kj6u27zC; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b67684e2904so4558494a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 00:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1762331325; x=1762936125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EmBTXZDZAUONRv7bvu1TxvWWCFKWBjn3YLchHfiGaE0=;
        b=Kj6u27zC8+vXezKmupo7SKS/mSsfO5hUDM+aHuv6inkwZTXej3KXVwVo1J07G139ml
         3oMD3MZMzjVqjmf5xir1IH3TGoyW9uBmCZ4TF49082lRLGDDNS7hnT7YevpiaTBZPl4i
         dkuVbOvinIoIERI0PCU2ETc+LGU3p9BJZQSUE9lllXjOh06pO9GQ7TSVda2p6NpnudY4
         t82/4FnxRHBzYlVbD11+u0PKaIcJq9lBs/1mXUuCRXD3NKO4CfCFlpYLEPrQQt93jMlk
         zt2Ju7XVuSXqJehlFyJTVeGkWOAnUV0JMwXTttmweNRekBRShdgqDAYatcRhPFGhDvrO
         kEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762331325; x=1762936125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EmBTXZDZAUONRv7bvu1TxvWWCFKWBjn3YLchHfiGaE0=;
        b=xDdxZE1gh+vLz8e77ew+fhbOUuz9Jol8+KYumrphte6eKXhlf0Tn5HOsrCsAPzFu8e
         Bm0aY9MgLcnShhoHS1emNQ5SVCPHv8A51ZS/6F6LO033EOU85FZnnxtb820ERrdg17mW
         AKDjo0VySYUWdnl2SpV/dWSCmS40fDO9luEn4EVf/Xru617uGFngcAVM9FhcJKVfzGor
         lWK2HfaCtVaPI8rnhTqEBgrQ2poxzvvuVCy3IShRA/24ASZM8Fr4otMHAhhrjHEWcpaW
         IW45v/tEVg77UNJAMe0vkvYVc55+94QD6jFshhB/zmkWe0FB+/KARwdUyRY/OSuwl8hA
         HRqw==
X-Forwarded-Encrypted: i=1; AJvYcCVaLLZu7p8D+qLL2Xu6GRJhPNIHIU65W0CmB/6/E9MlBvZv/b4CIytKWQ3zdQisfOISe8W+AFQogI20heM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD/dTD0M6vZpi9ms6UgKSEUiBNojRlPbHOjhc2DDhdivT3HUbe
	pFuGvjcYkX9gwbhZxjM6FkxTQk2Wa3262UTyyMoip3aHyIPHUMtrcaJV5X/+fvuG4CE=
X-Gm-Gg: ASbGncuSE39NBacgm6CvXHhfTdaMGCDM1WhdIFT6y+vI0uTDoCRQMcgHhFaCufv/Y6B
	vIh3H5rXfy49bFC76hZg8JsvwZSZ7xZmKnE0E/0SmDUZfLZ3kOKr4vBIGM+sdLS3iMvup5lcg79
	lNfsodu/Jf86pIk8oxzR2u8+zwJ+PgM4ricvSStGLt6xZMXNOBZE0jfxg25peBx4dIPkU2uNFcm
	jkQl8hD0xv7ytmt1I/HyUibDYvV6mbyIC/Qeyh05vrqeP2A1j+kmIftfUPvxGjjmcAND2kHcN6n
	x7Qpbp9gM8jClhhvj/Tpwsa651lXzLWEq3J+BSGOIeKbQ+r0nU4rYv7XwxITvt/G/GiBf3d/wSU
	56vYX4ebvPkrMQx8X3i2HFW867jO/hG+Hj2xsBFOlHnjnYkzKPy0szgeK
X-Google-Smtp-Source: AGHT+IGlpNsdSirje6pTwpA0LOhu+sBUDNtAUUKM3zOYPx1mBTBFQyxiz58mZ3Wb4G+vpIBfR+7Tlw==
X-Received: by 2002:a17:902:d58d:b0:294:def6:5961 with SMTP id d9443c01a7336-2962ada6b42mr37732875ad.45.1762331324990;
        Wed, 05 Nov 2025 00:28:44 -0800 (PST)
Received: from cleger.eu.int ([2001:41d0:420:f300::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a741e3sm51870875ad.98.2025.11.05.00.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 00:28:44 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Xu Lu <luxu.kernel@bytedance.com>,
	Atish Patra <atishp@atishpatra.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v8 0/5] riscv: add support for SBI Supervisor Software Events
Date: Wed,  5 Nov 2025 08:26:32 +0000
Message-ID: <20251105082639.342973-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The SBI Supervisor Software Events (SSE) extensions provides a mechanism
to inject software events from an SBI implementation to supervisor
software such that it preempts all other supervisor level traps and
interrupts. This extension is introduced by the SBI v3.0 specification[1].

Various events are defined and can be send asynchronously to supervisor
software (RAS, PMU, DEBUG, Asynchronous page fault) from SBI as well
as platform specific events. Events can be either local (per-hart) or
global. Events can be nested on top of each other based on priority and
can interrupt the kernel at any time.

First patch adds the SSE definitions. Second one adds support for SSE
at arch level (entry code and stack allocations) and third one at driver
level. Finally, the last patch add support for SSE events in the SBI PMU
driver. Additional testing for that part is highly welcomed since there
are a lot of possible path that needs to be exercised.

Amongst the specific points that needs to be handle is the interruption
at any point of the kernel execution and more specifically at the
beginning of exception handling. Due to the fact that the exception entry
implementation uses the SCRATCH CSR as both the current task struct and
as the temporary register to switch the stack and save register, it is
difficult to reliably get the current task struct if we get interrupted
at this specific moment (ie, it might contain 0, the task pointer or tp).
A fixup-like mechanism is not possible due to the nested nature of SSE
which makes it really hard to obtain the original interruption site. In
order to retrieve the task in a reliable manner, add an additional
__sse_entry_task per_cpu array which stores the current task. Ideally,
we would need to modify the way we retrieve/store the current task in
exception handling so that it does not depend on the place where it's
interrupted.

Contrary to pseudo NMI [2], SSE does not modifies the way interrupts are
handled and does not adds any overhead to existing code. Moreover, it
provides "true" NMI-like interrupts which can interrupt the kernel at
any time (even in exception handling). This is particularly crucial for
RAS errors which needs to be handled as fast as possible to avoid any
fault propagation.

A test suite is available as a separate kselftest module. In order to
build it, you can use the following command:

$ KDIR=<build_dir> make O=build TARGETS="riscv/sse"-j $(($(nproc)-1)) \
  -C tools/testing/selftests

Then load the module using:

$ sh run_sse_test.sh

A KVM SBI SSE extension implementation is available at [2].

Link: https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/v3.0-rc7/riscv-sbi.pdf [1]
Link: https://github.com/rivosinc/linux/tree/dev/cleger/sse_kvm [2]

---

Changes in V8:
 - Use GPL-2.0-or-later licensing for all files
 - Use sse_get_event() in sse cpu offline path
 - Remove useless sse_reset() function.
 - Removed useless cast of stack to unsigned long
 - Replace pr_err() with pr_info() when SSE is missing
 - Remove SIE set in do_sse(), irq_queue_work() will send an IPI
   to the cpu if needed via arch_irq_work_raise() so that it will be
   treated right after reenabling interrupts in interrupted context.

Changes in v7:
 - Check return values of sse_on_each_cpu()
 - Fix typos in commit
 - Rename SBI_SSE_EVENT_SIGNAL to SBI_SSE_EVENT_INJECT
 - Rename SBI_SSE_EVENT_HART_UNMASK/MASK to SBI_SSE_HART_UNMASK/MASK
 - Add tlb flush for vmap stack to avoid taking exception during sse
   handler upon stack access. (Alex)
 - Move some assembly instruction to slow path
 - Renamed sse.c to sbi_sse.c, ditto for other files
 - Renamed RISCV_SSE to RISCV_SBI_SSE
 - Renamed sse_event_handler to sse_event_handler_fn
 - Put ifdef around sse_evt in PMU SBI driver

Changes in v6:
 - Fix comment in assembly argument
 - Check hart id to be the expected one in order to skip CPU id
   matching in sse assembly.

Changes in v5:
 - Added a SSE test module in kselftests
 - Removed an unused variable
 - Applied checkpatch.pl --strict and fix all errors
 - Use scope_guard(cpus_read_lock) instead of manual cpus_read_lock()
 - Fix wrong variable returned in sse_get_event
 - Remove useless init of events list
 - Remove useless empty for loop on cpus
 - Set sse_available as  __ro_after_init
 - Changed a few pr_debug to pr_warn
 - Fix event enabled stated updated in case of failure
 - Change no_lock to nolock
 - Rename attr_buf to attr
 - renamed sse_get_event_phys() to sse_event_get_attr_phys() and removed
   the second argument
 - Simplify return value in sse_event_attr_set_nolock()
 - Remove while loop(-EINVAL) for event cpu set call
 - Renamed interrupted_state_phys to interrupted_phys
 - Use scoped_guards/guard for sse_mutex
 - Remove useless struct forward declaration in sse.h
 - Add more explanations as to why we set SIE bit in IP
 - Unconditionnally set SIE in SIP
 - Move SSE_STACK_SIZE adjustement in sse_stack_alloc/free()
 - Replace move instructions with mv
 - Rename NR_CPUS asm symbol to ASM_NR_CPUS
 - Restore SSTATUS first in sse_entry return path so that it works for
   double trap without any modification later.
 - Implement proper per cpu revert if enable/register fails

Changes in v4:
 - Fix a bug when using per_cpu ptr for local event (Andrew)
 - Add sse_event_disable/enable_local()
 - Add pmu_disable/pmu_enable() to disable/enable SSE event
 - Update event ID description according to the latest spec
 - Fix comment about arguments in handle_sse()
 - Added Himanchu as a SSE reviewer
 - Used SYM_DATA_*() macros instead of hardcoded labels
 - Invoke softirqs only if not returning to kernel with irqs disabled
 - Remove invalid state check for write attribute function.
 - Remove useless bneq statement in sse_entry.S

Changes in v3:
 - Split arch/driver support
 - Fix potential register failure reporting
 - Set a few pr_err as pr_debug
 - Allow CONFIG_RISCV_SSE to be disabled
 - Fix build without CONFIG_RISCV_SSE
 - Remove fixup-like mechanism and use a per-cpu array
 - Fixed SSCRATCH being corrupted when interrupting the kernel in early
   exception path.
 - Split SSE assembly from entry.S
 - Add Himanchu SSE mask/unmask and runtime PM support.
 - Disable user memory access/floating point/vector in SSE handler
 - Rebased on master

v2: https://lore.kernel.org/linux-riscv/20240112111720.2975069-1-cleger@rivosinc.com/

Changes in v2:
 - Implemented specification v2
 - Fix various error handling cases
 - Added shadow stack support

v1: https://lore.kernel.org/linux-riscv/20231026143122.279437-1-cleger@rivosinc.com/

Clément Léger (5):
  riscv: add SBI SSE extension definitions
  riscv: add support for SBI Supervisor Software Events extension
  drivers: firmware: add riscv SSE support
  perf: RISC-V: add support for SSE event
  selftests/riscv: add SSE test module

 MAINTAINERS                                   |  15 +
 arch/riscv/include/asm/asm.h                  |  14 +-
 arch/riscv/include/asm/sbi.h                  |  61 ++
 arch/riscv/include/asm/scs.h                  |   7 +
 arch/riscv/include/asm/sse.h                  |  47 ++
 arch/riscv/include/asm/switch_to.h            |  14 +
 arch/riscv/include/asm/thread_info.h          |   1 +
 arch/riscv/kernel/Makefile                    |   1 +
 arch/riscv/kernel/asm-offsets.c               |  14 +
 arch/riscv/kernel/sbi_sse.c                   | 162 ++++
 arch/riscv/kernel/sbi_sse_entry.S             | 178 +++++
 drivers/firmware/Kconfig                      |   1 +
 drivers/firmware/Makefile                     |   1 +
 drivers/firmware/riscv/Kconfig                |  15 +
 drivers/firmware/riscv/Makefile               |   3 +
 drivers/firmware/riscv/riscv_sbi_sse.c        | 694 ++++++++++++++++++
 drivers/perf/Kconfig                          |  10 +
 drivers/perf/riscv_pmu.c                      |  23 +
 drivers/perf/riscv_pmu_sbi.c                  |  71 +-
 include/linux/perf/riscv_pmu.h                |   5 +
 include/linux/riscv_sbi_sse.h                 |  57 ++
 tools/testing/selftests/riscv/Makefile        |   2 +-
 tools/testing/selftests/riscv/sse/Makefile    |   5 +
 .../selftests/riscv/sse/module/Makefile       |  16 +
 .../riscv/sse/module/riscv_sse_test.c         | 511 +++++++++++++
 .../selftests/riscv/sse/run_sse_test.sh       |  44 ++
 26 files changed, 1958 insertions(+), 14 deletions(-)
 create mode 100644 arch/riscv/include/asm/sse.h
 create mode 100644 arch/riscv/kernel/sbi_sse.c
 create mode 100644 arch/riscv/kernel/sbi_sse_entry.S
 create mode 100644 drivers/firmware/riscv/Kconfig
 create mode 100644 drivers/firmware/riscv/Makefile
 create mode 100644 drivers/firmware/riscv/riscv_sbi_sse.c
 create mode 100644 include/linux/riscv_sbi_sse.h
 create mode 100644 tools/testing/selftests/riscv/sse/Makefile
 create mode 100644 tools/testing/selftests/riscv/sse/module/Makefile
 create mode 100644 tools/testing/selftests/riscv/sse/module/riscv_sse_test.c
 create mode 100644 tools/testing/selftests/riscv/sse/run_sse_test.sh

-- 
2.43.0



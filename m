Return-Path: <linux-kernel+bounces-760507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FE7B1EC41
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450431893CFC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CC22836B4;
	Fri,  8 Aug 2025 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="UlDMjU0Y"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6484280CC9
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754667560; cv=none; b=NvU3kBHWZ4ZT3myezfA65envXsaed2U9QtK6QFyjS2Q9RzRKyx6wg1izwbbyXQ8pxS21fe7vZL55wW6BfHOjOhg/poOF2sdmRaciLAQkIt4KOgxr/O8R1DqMqDbaIxl0yKMKrs3jRjumrAY6/dXd5BdAgK4NxE5g9MLcPgy6PCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754667560; c=relaxed/simple;
	bh=IpcLp/yXYa3RL6eZOaZO8ehWM4HkL1fjlIOlzX8ZBfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G1S8cOMC/VJ46qTO6yB2vcEbsUE5qAdr8TJ0Jb6XcacP0J23ya4UMBII6En864Nm0Fe/LoIUSp9PNtHCNMli1o/qO1r+OeSWC/GqIDnO7VhlPT7gccNB/9MwF7MJJnpSbGSrOaVqod1r5waHYEoN76VLITGuQd/jbr1lBqaE7w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=UlDMjU0Y; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3190fbe8536so2298461a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 08:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1754667557; x=1755272357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ID9eOa0mJbb7Csy70BEFLYaT6HI+I5SdUw7yhJbZeM=;
        b=UlDMjU0YLFo4RqNMlFmnIDS6qWMXgAt5cIT9JCUn5nGi+8m97dN4a09wqLlZb/M57A
         w96UVtfyIKw2EZ3F8MhMCf2b3+ZpPMJfhV9J6BQKuf+EULG9sEikM0RA/PRvZvFvTvuT
         sLnGND8EmDkNvghIAtI0owjPadJ/pnvqpft0hx8lmiAYPgESGtnxD+hiTxpIx0pclnZ1
         9SCeawi+xHoMZzwrx7696hrfntBydmwfvvtcgH1cOdjmMKiA2j5KOwtrm23eEuS6+NEh
         CvLvcGliBASeM06c5+yZr+MBDC7PkX/OEY60jP31p5vRZcHdXpaPOI54XvOaB7UGi7Jg
         PNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754667557; x=1755272357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ID9eOa0mJbb7Csy70BEFLYaT6HI+I5SdUw7yhJbZeM=;
        b=p196ccVUBBVmeEanyVrkvm2rFPrC1wK7xAthaBPGNpPDFHldoXEybPmlNUSabbD2DI
         /1mym7+eCba6Ws3hel/eUXzyK3WCb/uHxGtjn8rDOUgtFI8Bk9uOom4d1YLwCC/SeTYQ
         HPRLP1dNoyJthYC6f+SIuYoOnWB13Fv90zvDXW6UHgKBy7rKqzo+sJ1N5vHdLGzRcPsl
         Cmhapobvs8mn2e7shDHYpL8tqLqh/wTgMTdGnSj01yMYZcvQa5uOylcFX6POK8w5Rb5K
         BwreKZkFVAL4OQCLBTrfBmfTI85rquN6K1bMy38i2rivnOY2so0YmsPp+TWAH8FNLZVr
         Ixlg==
X-Forwarded-Encrypted: i=1; AJvYcCUH1NaB//9QOwRg2AiP2NDQ/qMc4wrgzJPWM8Nvhw21zUPz74JmvmwhNfP9x1chja13R6XACDuKkyC4CbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhmIxKqyrIGy/n3wRUDy/ZJVGRy671LOOpkKBx7IBMiFChFaUd
	i+A0adgTnl5eOE8SNGD5BtaBikrSNsc3YOywHcFtkCIRF9jm+sZksHg9l4WeVeuwkKc=
X-Gm-Gg: ASbGnctTssdHMv1nAS6bzY10tf5c3Z1fCU78U6et95rG2NtYwH27rVSeSiujGDSjQ2+
	upZTbq+SU1JSdmS1hAMNg50RBa05x4sWWubcpkM7RbONDv/zjor67SRPvIz6zhRwYj0saWVELFz
	9o6tiNLDbOGaxIKIbXxD3qEwpcqUeHGqcnpgJBAq8S4KwHb7l7k2/LTpzquFWPPvryL3d4dCyTg
	hGepBO8v5223zm3h19ZrRai0O1+AdEbyPh6nv+puedc037ETbv7eQu4ApKZRkUKmY6Hzz+jXJCA
	JJbhlo4nmoc+AxXWuGs9uKK+K2W2RzUpig1va7J+cBCwLxYihaP4JSQCwejyXXFl+gihEjRm7iX
	OlH442+b0oy7TTA==
X-Google-Smtp-Source: AGHT+IGJSBB0kKDSSdvKCfj6Lqz7T7EoQAptAhpCgVH402UyN2lZVLU9xJ7ez/W/aSW1HGcmlgK4ww==
X-Received: by 2002:a17:90b:2e45:b0:31f:1744:e7fd with SMTP id 98e67ed59e1d1-32183e7ed80mr4807127a91.31.1754667556852;
        Fri, 08 Aug 2025 08:39:16 -0700 (PDT)
Received: from cleger.eu.int ([2001:41d0:420:f300::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3218c3c2d58sm1135971a91.16.2025.08.08.08.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 08:39:16 -0700 (PDT)
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
Subject: [PATCH v6 0/5] riscv: add support for SBI Supervisor Software Events
Date: Fri,  8 Aug 2025 15:38:51 +0000
Message-ID: <20250808153901.2477005-1-cleger@rivosinc.com>
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

A KVM SBI SSE extension implementation is available at [2].

Link: https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/v3.0-rc7/riscv-sbi.pdf [1]
Link: https://github.com/rivosinc/linux/tree/dev/cleger/sse_kvm [2]

---

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
 arch/riscv/kernel/sse.c                       | 154 ++++
 arch/riscv/kernel/sse_entry.S                 | 180 +++++
 drivers/firmware/Kconfig                      |   1 +
 drivers/firmware/Makefile                     |   1 +
 drivers/firmware/riscv/Kconfig                |  15 +
 drivers/firmware/riscv/Makefile               |   3 +
 drivers/firmware/riscv/riscv_sse.c            | 694 ++++++++++++++++++
 drivers/perf/Kconfig                          |  10 +
 drivers/perf/riscv_pmu.c                      |  19 +
 drivers/perf/riscv_pmu_sbi.c                  |  71 +-
 include/linux/perf/riscv_pmu.h                |   3 +
 include/linux/riscv_sse.h                     |  56 ++
 tools/testing/selftests/riscv/Makefile        |   2 +-
 tools/testing/selftests/riscv/sse/Makefile    |   5 +
 .../selftests/riscv/sse/module/Makefile       |  16 +
 .../riscv/sse/module/riscv_sse_test.c         | 513 +++++++++++++
 .../selftests/riscv/sse/run_sse_test.sh       |  44 ++
 26 files changed, 1947 insertions(+), 14 deletions(-)
 create mode 100644 arch/riscv/include/asm/sse.h
 create mode 100644 arch/riscv/kernel/sse.c
 create mode 100644 arch/riscv/kernel/sse_entry.S
 create mode 100644 drivers/firmware/riscv/Kconfig
 create mode 100644 drivers/firmware/riscv/Makefile
 create mode 100644 drivers/firmware/riscv/riscv_sse.c
 create mode 100644 include/linux/riscv_sse.h
 create mode 100644 tools/testing/selftests/riscv/sse/Makefile
 create mode 100644 tools/testing/selftests/riscv/sse/module/Makefile
 create mode 100644 tools/testing/selftests/riscv/sse/module/riscv_sse_test.c
 create mode 100644 tools/testing/selftests/riscv/sse/run_sse_test.sh

-- 
2.43.0



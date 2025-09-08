Return-Path: <linux-kernel+bounces-806526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4177DB4981E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E860B207704
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D0613C8E8;
	Mon,  8 Sep 2025 18:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="b+tgAoy8"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B4030DD2D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355546; cv=none; b=eyKLwfMsfD2MeDyjoLRX5khBtwLBXHIJ0f4NZOzcyYeTJiU3PNxMe7dcS6YW7VdqnFoEJo2c5F0ky3rE+GBBnMU+zpMUZ8MumdN8LJ89REHc+drlOZArNyriv2ndy3sq+DxE69jHHMSLVyQx4bWjgMOH/nSr53dCPEXlu5nXoAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355546; c=relaxed/simple;
	bh=v5PyhRh/6O3NJBzdDH3C8VAeUqgpDMg5/t+bjfxiWVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t3OUDVci5TdKcQ/jAYC2aNhu3DxIqMBVW3ZxkrMptmxo6kQ0Ekl190W/uVYQ+hnLWqW2SEOep8+wYx/h9V4CA7phBco8Vnl8IF/xPq3RrUcB7zE2HamnBv2Xj8n7zrlNuXTf2pyqJKEEexNV5LDQZofER+ZRY0vNNH6/V3bQs/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=b+tgAoy8; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7728a8862ccso4081213b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 11:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1757355543; x=1757960343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2c2wQQodFjkEZTZlM+O9ycbeTny9/E1x0SNuW3SVXwE=;
        b=b+tgAoy8xjIY0U7IPE8KTl3Fd3irt15iO7Pk8xf9NSuxc+nhn1cshq85xCHUi7/5Pt
         phXuv9b8o4xAQxX17Oxygz6gd2diedxPh19tChb4kTqep9YpiNSjwnhuw84Xct/PZzry
         Pai5Z6qIZS+SCdJ/VVDP4xfPWB3RsFaVurDfORoL7SI5+2EIajbAFU8QDY2JkY8jIqln
         MmeXwIjq/6Z0tRs0JtDUD3yT8anlAkQ6Gv9ol3YwNHahQ8diE2N8uY/99gzJQXS0wYmn
         6Fb7RajotPOjXPWi9cMSZfX4/g4zZBLHLUkhVcMKcut/9eBxERDz+jwPxnpaLTl6VmGE
         TGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757355543; x=1757960343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2c2wQQodFjkEZTZlM+O9ycbeTny9/E1x0SNuW3SVXwE=;
        b=EGahiQNf1jBnqJ3PAkAaB/OANPOpfZOSHUYUxYQQY0eQlVuUEiw1WOYWzZJ2x1ta1y
         zQwa0PlYijyj2eKqkuUbFUxRqngMmEJVFfIHOTAXiZNyMbhIuDHX6pw7BzHKAABJUrzi
         FMxI1y/KZai+YDRJwm7Zd6rALyj19IaxjKCnpasxe2WBnaY2zQCZnxg4Ck4yoASda5m/
         CDq+LyFdYysBnxyJF9/fW9KW5weckVX9xYGpI1kPbJq0TGPo0qGnm2NwewoBaZWjX9x5
         zbDUrLi3DaeuWIkAnM5tZS8jam5fgnaBtZ7pBpI4CLWbvyLExxhtaX8xJFmw4seaKDeF
         +fiw==
X-Forwarded-Encrypted: i=1; AJvYcCUTnwApCOJ9jB3vNKZyZhym4kCA6fmksOWUHN+yM8/oVdqPrXzZ2lNsLSDPemeTRC/auvgf3i4ti2DipUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYUeXcxKSt4ReZnfITTYvweem1+xlha4c3lOs9JRq+tQyCGKue
	ArIgY4MWywAs6hsEItW6zgCTbO2ZbmKNDuivWtoZoO3xxQoK99SAOUQbk4iG4vb2tJ8Xfe9hLsU
	dI6Xo
X-Gm-Gg: ASbGncsLdjK6IKDK5EsCOHNygMXLsi2lGspwLzkyBGgpvrAmZ9WV2HYhcu9Dxh3qaNh
	rpmnUHf+QGJ9aYHOWx/4+F56GQGPU2FyVcLoNr3vCxmi4u/c5tSEKMbomyEyb77dVbDp9+FxTCr
	DrKysoyoC/8wfGMGVH6Klo4S1ears2Eccdp63WSIwrOr4X3CyVXakDDnlojZrtI5YWrh+P5A8ln
	euLogsIoB5W0v/G98Oaw10hY/o050+N1E3nDuVYL8GCZbUMBLunGsxtzEw2iXOA0+qEkqT4fDev
	RlhvVj3d1+FhoP49jzzIHpEI0Fw68HR1ZCZnsNv8E8sFN8G4j+tzA5sKdpj7l8d4YWbIdvweopo
	hqL88oqlv8+7y1w==
X-Google-Smtp-Source: AGHT+IGeK8xnjQMEsDvBnAQGCOTwp+zKHdddcPAw/zKXSbuv0/vgrl31tYylhn6Vgl90aigMwMS2Pg==
X-Received: by 2002:a17:902:fc4f:b0:248:aa0d:bb22 with SMTP id d9443c01a7336-2516e1be7a9mr112628205ad.0.1757355543225;
        Mon, 08 Sep 2025 11:19:03 -0700 (PDT)
Received: from cleger.eu.int ([2001:41d0:420:f300::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccd763948sm117012755ad.118.2025.09.08.11.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:19:02 -0700 (PDT)
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
Subject: [PATCH v7 0/5] riscv: add support for SBI Supervisor Software Events
Date: Mon,  8 Sep 2025 18:17:02 +0000
Message-ID: <20250908181717.1997461-1-cleger@rivosinc.com>
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

$ KDIR=<build_dir> make O=build TARGETS="riscv/sse"-j $(($(nproc)-1)) -C tools/testing/selftests

Then load the module using:

$ sh run_sse_test.sh

A KVM SBI SSE extension implementation is available at [2].

Link: https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/v3.0-rc7/riscv-sbi.pdf [1]
Link: https://github.com/rivosinc/linux/tree/dev/cleger/sse_kvm [2]

---

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
 arch/riscv/kernel/sbi_sse.c                   | 174 +++++
 arch/riscv/kernel/sbi_sse_entry.S             | 178 +++++
 drivers/firmware/Kconfig                      |   1 +
 drivers/firmware/Makefile                     |   1 +
 drivers/firmware/riscv/Kconfig                |  15 +
 drivers/firmware/riscv/Makefile               |   3 +
 drivers/firmware/riscv/riscv_sbi_sse.c        | 701 ++++++++++++++++++
 drivers/perf/Kconfig                          |  10 +
 drivers/perf/riscv_pmu.c                      |  23 +
 drivers/perf/riscv_pmu_sbi.c                  |  71 +-
 include/linux/perf/riscv_pmu.h                |   5 +
 include/linux/riscv_sbi_sse.h                 |  57 ++
 tools/testing/selftests/riscv/Makefile        |   2 +-
 tools/testing/selftests/riscv/sse/Makefile    |   5 +
 .../selftests/riscv/sse/module/Makefile       |  16 +
 .../riscv/sse/module/riscv_sse_test.c         | 513 +++++++++++++
 .../selftests/riscv/sse/run_sse_test.sh       |  44 ++
 26 files changed, 1979 insertions(+), 14 deletions(-)
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



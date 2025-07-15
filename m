Return-Path: <linux-kernel+bounces-732231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E18BB063D9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581AD1AA7067
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68F11FE455;
	Tue, 15 Jul 2025 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1EZMetzX"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80BF26281
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595395; cv=none; b=e0cPM4NxDy4eByMYWsE/8VKVQ8iMI5gFDa2ocDop6NwrlHV4GCh1sCWQ+PV6D3+fT0XvQ8muJvnjranvmNR1IpfG2y+1foHTxyREHezsdcpCtSCFmsdCJs9DcYC5CyVZx79u4XRlTV7y4XFSGF8QIFskLctaJztjAU210EyEcqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595395; c=relaxed/simple;
	bh=AiGNC/LuqMi3X+aKf1KeY0b1RG7CKAg1zPKhICCcgnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DZmOhIBTeqabBllRzcrqowqOV1ABMjpq9nd+KpHERXQ01IFXLEZofrYdtEXcuFmUggHjwifoGm6pBfcdaibBotDNEBqAHXYgJK+YrKs+TbgnI0cDDwsKpjGAw6rOeGgAhEbV8N4C7eWxIBhY0nnQ981RzlFNEvaU+73zYBllOmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1EZMetzX; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b26f5f47ba1so4609442a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1752595392; x=1753200192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kPWakNl6Nt1auqo/Co1iCdgQw/f2/7pOJv4u9JLkkOE=;
        b=1EZMetzXheSQeobPX2EKl3JoEply7oQ66WOjMld4//3XfP0r82zyVoARLFTP2EMstL
         tY3meYBufgzjsQhEVYdFYbVOxzyGvQGvbTL6D4M0JakI1TLKbyJF24YViA3E6GTqpzCr
         YmJOTfu/LOWk60nRplQRHmLEPXMUOZTlVo9NhU83++Z94i0asb+CF/0rJegn7GbyM/JB
         MaFAOys2dyppt6C9icpK8QcK9S7Mj/7ins/p6xJOAbVftim9C2VS3ouyzNu8D4bDzns5
         /4G0TqVh3VQ+SfalvilaZwWqv7WbWAzGCWXuF1XjRqU7UkWevHsai34KiQaHRYLGRJcv
         gNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752595392; x=1753200192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPWakNl6Nt1auqo/Co1iCdgQw/f2/7pOJv4u9JLkkOE=;
        b=NhkQtFI/6p5rqa8AkLOnP5u4hXbA1gEblSXlnqgX5VW7DIx1FXyI+HfYuAUdW+fz49
         7jU7CICNMuydWuXZBASgRMH9DmbL/lUwJkejAo1Wp/NWmRzVOTulpGX9Q6cmL098oy1B
         g8FFbJ8z3VWprkt775RE2u+wiYb8a5fC2mL+fe40TLltful5GZbQZ/SmhDamgVgVqpKZ
         55fy+hxqOjvnAxY6EaQLjwGYDR1OZPp+zrk8TRx2NrE5+Kqhq0t4b3jxy2aojhyJxowY
         ocNO5ALUJ+at+YkokXO3UQNIZArSEikItR9gyn+PVNu1hvrO0sQhbdjIvFflZAhaq3Ff
         hwgw==
X-Forwarded-Encrypted: i=1; AJvYcCWDBXkSQTqbvqM7rRmrc9u5WGlSQEUPTiNwwWS7yedGul6EQIEbzQs+Lh9Do7CCcCpEQbzCP8GxmlmLXyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtURHU+tSLGQAd9PW8rKX4V1tshSe4jooina1V2cj86sN6YDvc
	kNVHnfByHGETbX+d/jMav1vNg5WtUAZsiJOPiJZTCVLNBqfSyKdKRu/ITww8x0yRQyU=
X-Gm-Gg: ASbGncvPRO9+mCFHblJPf/CuEOmPMF4lauFsxT4zmauZPrTDDasvPVRXhTK1JOy/Kf7
	Qd0idVcjentFaBz6vdYlVkyo4ln1I11LwOJJHcx4aWFOY1tBk2EGC13scvBdDCSq0v8ZvrIJdv2
	sIc7mgEU2yy2yXnrKmotS9e2sEV5fSkbKwKNG9OdlNMilnA55EfwJ1OZQlulJYHKmTK2Uy+sO8Q
	sKVdkzLcN7GCVg1+ggzDeayy7mDruvF1gKIOBcvYoB6Xsvv5NwRoyL2Wnp8oGjHPDv+Wg/CVLUs
	Ohi0WRycLpTex31dkhBkskbV5HKDlwVJQjJTtRRRvsfNz7EWgF0smHZ6uCNN46QrOHgBuN1dA6T
	BhwE=
X-Google-Smtp-Source: AGHT+IERXdT/1rHxdfHQMtu0WaRW27EhlCa0642a2ZFdQn6l17jgLFMA7Hf4EhoGjKiVshHT2eI/Ug==
X-Received: by 2002:a05:6a21:a912:b0:232:7c7b:1c7b with SMTP id adf61e73a8af0-2327c7b1d5bmr16827947637.14.1752595391669;
        Tue, 15 Jul 2025 09:03:11 -0700 (PDT)
Received: from cleger.eu.int ([2001:41d0:420:f300::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f856fdsm12546532b3a.144.2025.07.15.09.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 09:03:10 -0700 (PDT)
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
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v5 0/5] riscv: add support for SBI Supervisor Software Events
Date: Tue, 15 Jul 2025 16:02:28 +0000
Message-ID: <20250715160234.454848-1-cleger@rivosinc.com>
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

Link: https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/v3.0-rc7/riscv-sbi.pdf [1]

---

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
 arch/riscv/include/asm/sse.h                  |  44 ++
 arch/riscv/include/asm/switch_to.h            |  14 +
 arch/riscv/include/asm/thread_info.h          |   1 +
 arch/riscv/kernel/Makefile                    |   1 +
 arch/riscv/kernel/asm-offsets.c               |  12 +
 arch/riscv/kernel/sse.c                       | 146 ++++
 arch/riscv/kernel/sse_entry.S                 | 169 +++++
 drivers/firmware/Kconfig                      |   1 +
 drivers/firmware/Makefile                     |   1 +
 drivers/firmware/riscv/Kconfig                |  15 +
 drivers/firmware/riscv/Makefile               |   3 +
 drivers/firmware/riscv/riscv_sse.c            | 672 ++++++++++++++++++
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
 26 files changed, 1901 insertions(+), 14 deletions(-)
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



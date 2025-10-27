Return-Path: <linux-kernel+bounces-870764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC18C0B9EB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 02:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE89D18A152B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 01:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658072BD597;
	Mon, 27 Oct 2025 01:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iKeyUzUQ"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EE318C02E
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761529683; cv=none; b=Yc0BM7XpEHLm4mf8YW3R3O0EEzde7h5o7d1MJ1ZpOPgkNRdjhFdoTnuGEWqNGVS+qjFl+LXtezbDMjxeG68n5GCUDa3cZ24ZNpgCV8kwrIPfA7/d3KW3QY1sZky/KqVnDgHzh7wbF5/dGd5XOcA4oBNkMncitIY6xiNwuzEVRRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761529683; c=relaxed/simple;
	bh=3t03Mhn+ZokIwSBILidc+9vuVePLuwDFkWSAJAzX/Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jv5DQKCj7XhPiBY2W0E9I06mA9AedZ7eYz4pUMJr+dQ6U9qIbHX0FHvk4R1IS4JkHQhj7jrV3ChL2qpSvNDgjjxuiReFLfPbbdg5qbNXTsTYBwCwjwMT+tlY6AMkVxKOo/FMK7zzT7ow797Us9Q+W1XmHAGgzcsQKu2ZjSrIMgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iKeyUzUQ; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-650317ae979so1240607eaf.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 18:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761529680; x=1762134480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLPbwj85v90l93eEK3Le8Huyt9tCmBVKSc/s7w2usfs=;
        b=iKeyUzUQ64L2pfbaYVxzLij99OkzqkOhqGtHAp/k76J0mQ318Xo+Y2mp2EZ7Ak1344
         ivmTRcVZTL41J39nhx3aMy0IUrjozNAaNaE7ZHDyLvJ9rRIs4D9lAiaO7AS9KiD7nZyK
         QAyhJ7s+x7TU5KuA0tBLEWtq9x2lBOABg5ycPfC8m7nzuMtSXR5JtVUrxu6LI0PERQWW
         6KYodh4UyhzRCIGCEVeH9head/kvy2YaaXwLHCXVn+X8mYhBNZpaUVQNXIIx/KYFsBdz
         R8Sbxrl9LqmjQMgg4mQeLxw8zlx7c+ElrmeFPfgZTboZ+KaUmGmxg3qwi+ZDI9dr44B8
         07CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761529680; x=1762134480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLPbwj85v90l93eEK3Le8Huyt9tCmBVKSc/s7w2usfs=;
        b=csF4S0kad/SBrlwys5V6aSaV0c9i345Fnm70GiLC5S8PQYz3m62HjGTJ7qqXx/W1hX
         Il8IaY9lHovtgar52dqW40YybRI448vxnXTKiW7gnlW3UWkVmex5zZi96PJ4pgZDGtlY
         SGjzh/NLJ38KcGBeVe7d1sQr65g8iymXnoWkE3RfjghOQgilva+vavBgrJt3FkAngKht
         Pxb+M8+GTH3sZVBTAh6FSZrIzZZfQGFBWuNJscaRL7F8UW7AtKDDY1BnGSkH90jEJ2DZ
         nOTvR08p7Yl2ka1qlnnTwmtxiMk5NScIxYmIa6VEoeGa2BFUkiOzzxjdLbTUn8FLGDnq
         6ruA==
X-Forwarded-Encrypted: i=1; AJvYcCWuPBxRF8KNxbLj+h6V49MYXCEXEHcjV9Efqj1Op4nZtKffTC/92+C1n8KevPyHeMoDXMxPr8YQGT0LHPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWep3iyo4r5hO1nk30KqyxFVRc9r40PVGIt1/isDNKoI9ODMGd
	4o9Quket6iveciqk8IpWlOB6eOgqYP/elnlAoiLZVKR/pEyFiU6Npe+Ve7bgh5B8/uos6XOiipu
	xi2bqY/3ixhmBOZODB3PcLwPZDWyA/OSM3ck74IkxhA==
X-Gm-Gg: ASbGncvI5TPC9dpxlKymOe20Q/A9qokYAmhpBZVPdVhPUyl88NPDwA+LYtIl1DxVQ6i
	SoZ+jcjOXJZKY3jsXWx/kMD4XV9fdreXdW+uYL12+aFCRd0X1WXxsJ553UUW7Hcjtx082XqkAGx
	+QaMXoSG3XxsXjDewKFYxtfwejqf0g5JUek4ypYT5+HzC8l6TOhD6T21BpeaMEBVxHQrvC6AGJB
	x0aY+ZjWQkvpm5dY3tTud3DyOGfBbPQEm5rUcZSZyBbpBQj1bF4RFT5Q7pHEvCzhjo=
X-Google-Smtp-Source: AGHT+IG7bxA+PHV99Aw4iB0z55T1gP3l3ESJv9wNHSuFIiEE56H1vWz5R07p7Qxhtux+BEUsHU7Fn7qQblr/M8e8DV0=
X-Received: by 2002:a05:6820:80c3:b0:654:f659:3b8a with SMTP id
 006d021491bc7-654f65953afmr1755651eaf.5.1761529679819; Sun, 26 Oct 2025
 18:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908181717.1997461-1-cleger@rivosinc.com>
In-Reply-To: <20250908181717.1997461-1-cleger@rivosinc.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 27 Oct 2025 09:47:48 +0800
X-Gm-Features: AWmQ_bnnLbizvhHaiJiQlgXoDyG0L8tIG5yzbvOD1RakpwNGIdqeb0Lk0rDxEkQ
Message-ID: <CAEEQ3w=6F-QHvvA-tEhM2CnYqumQfobLje--d7i61-EdK6uxZw@mail.gmail.com>
Subject: Re: [External] [PATCH v7 0/5] riscv: add support for SBI Supervisor
 Software Events
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Himanshu Chauhan <hchauhan@ventanamicro.com>, Anup Patel <apatel@ventanamicro.com>, 
	Xu Lu <luxu.kernel@bytedance.com>, Atish Patra <atishp@atishpatra.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cl=C3=A9ment,

On Tue, Sep 9, 2025 at 2:19=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@rivo=
sinc.com> wrote:
>
> The SBI Supervisor Software Events (SSE) extensions provides a mechanism
> to inject software events from an SBI implementation to supervisor
> software such that it preempts all other supervisor level traps and
> interrupts. This extension is introduced by the SBI v3.0 specification[1]=
.
>
> Various events are defined and can be send asynchronously to supervisor
> software (RAS, PMU, DEBUG, Asynchronous page fault) from SBI as well
> as platform specific events. Events can be either local (per-hart) or
> global. Events can be nested on top of each other based on priority and
> can interrupt the kernel at any time.
>
> First patch adds the SSE definitions. Second one adds support for SSE
> at arch level (entry code and stack allocations) and third one at driver
> level. Finally, the last patch add support for SSE events in the SBI PMU
> driver. Additional testing for that part is highly welcomed since there
> are a lot of possible path that needs to be exercised.
>
> Amongst the specific points that needs to be handle is the interruption
> at any point of the kernel execution and more specifically at the
> beginning of exception handling. Due to the fact that the exception entry
> implementation uses the SCRATCH CSR as both the current task struct and
> as the temporary register to switch the stack and save register, it is
> difficult to reliably get the current task struct if we get interrupted
> at this specific moment (ie, it might contain 0, the task pointer or tp).
> A fixup-like mechanism is not possible due to the nested nature of SSE
> which makes it really hard to obtain the original interruption site. In
> order to retrieve the task in a reliable manner, add an additional
> __sse_entry_task per_cpu array which stores the current task. Ideally,
> we would need to modify the way we retrieve/store the current task in
> exception handling so that it does not depend on the place where it's
> interrupted.
>
> Contrary to pseudo NMI [2], SSE does not modifies the way interrupts are
> handled and does not adds any overhead to existing code. Moreover, it
> provides "true" NMI-like interrupts which can interrupt the kernel at
> any time (even in exception handling). This is particularly crucial for
> RAS errors which needs to be handled as fast as possible to avoid any
> fault propagation.
>
> A test suite is available as a separate kselftest module. In order to
> build it, you can use the following command:
>
> $ KDIR=3D<build_dir> make O=3Dbuild TARGETS=3D"riscv/sse"-j $(($(nproc)-1=
)) -C tools/testing/selftests
>
> Then load the module using:
>
> $ sh run_sse_test.sh
>
> A KVM SBI SSE extension implementation is available at [2].
>
> Link: https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/v3=
.0-rc7/riscv-sbi.pdf [1]
> Link: https://github.com/rivosinc/linux/tree/dev/cleger/sse_kvm [2]
>
> ---
>
> Changes in v7:
>  - Check return values of sse_on_each_cpu()
>  - Fix typos in commit
>  - Rename SBI_SSE_EVENT_SIGNAL to SBI_SSE_EVENT_INJECT
>  - Rename SBI_SSE_EVENT_HART_UNMASK/MASK to SBI_SSE_HART_UNMASK/MASK
>  - Add tlb flush for vmap stack to avoid taking exception during sse
>    handler upon stack access. (Alex)
>  - Move some assembly instruction to slow path
>  - Renamed sse.c to sbi_sse.c, ditto for other files
>  - Renamed RISCV_SSE to RISCV_SBI_SSE
>  - Renamed sse_event_handler to sse_event_handler_fn
>  - Put ifdef around sse_evt in PMU SBI driver
>
> Changes in v6:
>  - Fix comment in assembly argument
>  - Check hart id to be the expected one in order to skip CPU id
>    matching in sse assembly.
>
> Changes in v5:
>  - Added a SSE test module in kselftests
>  - Removed an unused variable
>  - Applied checkpatch.pl --strict and fix all errors
>  - Use scope_guard(cpus_read_lock) instead of manual cpus_read_lock()
>  - Fix wrong variable returned in sse_get_event
>  - Remove useless init of events list
>  - Remove useless empty for loop on cpus
>  - Set sse_available as  __ro_after_init
>  - Changed a few pr_debug to pr_warn
>  - Fix event enabled stated updated in case of failure
>  - Change no_lock to nolock
>  - Rename attr_buf to attr
>  - renamed sse_get_event_phys() to sse_event_get_attr_phys() and removed
>    the second argument
>  - Simplify return value in sse_event_attr_set_nolock()
>  - Remove while loop(-EINVAL) for event cpu set call
>  - Renamed interrupted_state_phys to interrupted_phys
>  - Use scoped_guards/guard for sse_mutex
>  - Remove useless struct forward declaration in sse.h
>  - Add more explanations as to why we set SIE bit in IP
>  - Unconditionnally set SIE in SIP
>  - Move SSE_STACK_SIZE adjustement in sse_stack_alloc/free()
>  - Replace move instructions with mv
>  - Rename NR_CPUS asm symbol to ASM_NR_CPUS
>  - Restore SSTATUS first in sse_entry return path so that it works for
>    double trap without any modification later.
>  - Implement proper per cpu revert if enable/register fails
>
> Changes in v4:
>  - Fix a bug when using per_cpu ptr for local event (Andrew)
>  - Add sse_event_disable/enable_local()
>  - Add pmu_disable/pmu_enable() to disable/enable SSE event
>  - Update event ID description according to the latest spec
>  - Fix comment about arguments in handle_sse()
>  - Added Himanchu as a SSE reviewer
>  - Used SYM_DATA_*() macros instead of hardcoded labels
>  - Invoke softirqs only if not returning to kernel with irqs disabled
>  - Remove invalid state check for write attribute function.
>  - Remove useless bneq statement in sse_entry.S
>
> Changes in v3:
>  - Split arch/driver support
>  - Fix potential register failure reporting
>  - Set a few pr_err as pr_debug
>  - Allow CONFIG_RISCV_SSE to be disabled
>  - Fix build without CONFIG_RISCV_SSE
>  - Remove fixup-like mechanism and use a per-cpu array
>  - Fixed SSCRATCH being corrupted when interrupting the kernel in early
>    exception path.
>  - Split SSE assembly from entry.S
>  - Add Himanchu SSE mask/unmask and runtime PM support.
>  - Disable user memory access/floating point/vector in SSE handler
>  - Rebased on master
>
> v2: https://lore.kernel.org/linux-riscv/20240112111720.2975069-1-cleger@r=
ivosinc.com/
>
> Changes in v2:
>  - Implemented specification v2
>  - Fix various error handling cases
>  - Added shadow stack support
>
> v1: https://lore.kernel.org/linux-riscv/20231026143122.279437-1-cleger@ri=
vosinc.com/
>
> Cl=C3=A9ment L=C3=A9ger (5):
>   riscv: add SBI SSE extension definitions
>   riscv: add support for SBI Supervisor Software Events extension
>   drivers: firmware: add riscv SSE support
>   perf: RISC-V: add support for SSE event
>   selftests/riscv: add SSE test module
>
>  MAINTAINERS                                   |  15 +
>  arch/riscv/include/asm/asm.h                  |  14 +-
>  arch/riscv/include/asm/sbi.h                  |  61 ++
>  arch/riscv/include/asm/scs.h                  |   7 +
>  arch/riscv/include/asm/sse.h                  |  47 ++
>  arch/riscv/include/asm/switch_to.h            |  14 +
>  arch/riscv/include/asm/thread_info.h          |   1 +
>  arch/riscv/kernel/Makefile                    |   1 +
>  arch/riscv/kernel/asm-offsets.c               |  14 +
>  arch/riscv/kernel/sbi_sse.c                   | 174 +++++
>  arch/riscv/kernel/sbi_sse_entry.S             | 178 +++++
>  drivers/firmware/Kconfig                      |   1 +
>  drivers/firmware/Makefile                     |   1 +
>  drivers/firmware/riscv/Kconfig                |  15 +
>  drivers/firmware/riscv/Makefile               |   3 +
>  drivers/firmware/riscv/riscv_sbi_sse.c        | 701 ++++++++++++++++++
>  drivers/perf/Kconfig                          |  10 +
>  drivers/perf/riscv_pmu.c                      |  23 +
>  drivers/perf/riscv_pmu_sbi.c                  |  71 +-
>  include/linux/perf/riscv_pmu.h                |   5 +
>  include/linux/riscv_sbi_sse.h                 |  57 ++
>  tools/testing/selftests/riscv/Makefile        |   2 +-
>  tools/testing/selftests/riscv/sse/Makefile    |   5 +
>  .../selftests/riscv/sse/module/Makefile       |  16 +
>  .../riscv/sse/module/riscv_sse_test.c         | 513 +++++++++++++
>  .../selftests/riscv/sse/run_sse_test.sh       |  44 ++
>  26 files changed, 1979 insertions(+), 14 deletions(-)
>  create mode 100644 arch/riscv/include/asm/sse.h
>  create mode 100644 arch/riscv/kernel/sbi_sse.c
>  create mode 100644 arch/riscv/kernel/sbi_sse_entry.S
>  create mode 100644 drivers/firmware/riscv/Kconfig
>  create mode 100644 drivers/firmware/riscv/Makefile
>  create mode 100644 drivers/firmware/riscv/riscv_sbi_sse.c

These newly added files use different GPL-xxx licenses respectively:
arch/riscv/kernel/sbi_sse.c: // SPDX-License-Identifier: GPL-2.0-or-later
drivers/firmware/riscv/riscv_sbi_sse.c: // SPDX-License-Identifier: GPL-2.0=
-only
arch/riscv/include/asm/sse.h: /* SPDX-License-Identifier: GPL-2.0-only */
Should they be consistent, or is this by design?


>  create mode 100644 include/linux/riscv_sbi_sse.h
>  create mode 100644 tools/testing/selftests/riscv/sse/Makefile
>  create mode 100644 tools/testing/selftests/riscv/sse/module/Makefile
>  create mode 100644 tools/testing/selftests/riscv/sse/module/riscv_sse_te=
st.c
>  create mode 100644 tools/testing/selftests/riscv/sse/run_sse_test.sh
>
> --
> 2.43.0
>

Thanks,
Yunhui


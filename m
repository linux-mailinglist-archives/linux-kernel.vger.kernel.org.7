Return-Path: <linux-kernel+bounces-871037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E759C0C4A2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42C8E4F00D9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2562C237C;
	Mon, 27 Oct 2025 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="VDF5QpUH"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB3C199FAB
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553519; cv=none; b=PyOQMpoIYCEfnE15ivF6mmSSM/s0soSDR2aWxv5PQ8UBCMPLPCLsGf9bUN3Bic9BgKfUN9FtYHWjWpKXqorfXjPGP87MzbOgu3EE/gCi4jwdQahM9BMvyWEWKDQgNW1F03mj1MymfN//Ut94E/FTv/LYZFf+0ty6Ym6fkiuzg2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553519; c=relaxed/simple;
	bh=YEMuGajLqulzG7g1ez4ySx+ZR4yxEfovxM/N86/L6I0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eaQWo6t4a5A+9h3QvkKxlu9NxoFG3+POtsC6n96ES9v50AitpQlZiJKx+yNmV+DwQ+wX7zAAPC7++pRIuKXm/WlqkS6K9b4OJYpn1malTlhX/qgfWgtvO2WP+jKMt+bViWod3htRcXCZv498EcZtR0ejz5r+x7td/ZCuBHQzb/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=VDF5QpUH; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so4469637f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1761553514; x=1762158314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wQiwH+OvbFTBoj72eUutGsOx8rbXagJFuaPZSdZrxLI=;
        b=VDF5QpUHzRqZy/8QBLWSrr17Y2s3ow/29w7pXSxDUvEZlo7vPS9GIJkdkXq+nZ6vqt
         YRjNfavLc9TbUeWc9CVqkQbeIOhLGNgeuSs9brcAmXXuu7pLvtaSGoR9uwObyULkBYWf
         CYF/YXL2mHfY4tSy1wLd+rrpARvz6ZuVGpj9QND7v9Pmffc1UwvSTrXK0NskYcYJbfOr
         epO1gFIl7htdbrggkbv011mR1d/Kj4tzvcPUy1BGCIOExrpEtiZEPkqmkVPpSd8k4HA7
         ZNAzSFnmyl7/wklpipcgZbc8yceerOrAQ2eu5FJIxOkwi8BOj3mlUVhTA2Zcz7EzcMnQ
         9OTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761553514; x=1762158314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wQiwH+OvbFTBoj72eUutGsOx8rbXagJFuaPZSdZrxLI=;
        b=sItGM9HWGYOwUuxoEyyj+ghedc9PDJ50F/8guEQwGp6ZnSuNfKw8Q1PQyPNIku07CB
         wa0xGPfbqDhlWb/EZCV1DN1KvzjvuMJX9ZuDdo32VwOVpbwkpM9LKmVYcWx+/Uuhq+jC
         hAgu9vkW8OtX8+ttS8zuZUYBucAiYJl1cfCoV4KLUHpJWTLngj5SGBzmc+BTX1/AGPVu
         YHCeW2F2G8YStWur3cyT71AHPc+4PBJz8eP7DaGy8Q/FNMhs4dVAgI3dZWiV5fVc1Jzn
         ipKxoJJw1rAwJ6j4gv9+FNhx78WzRGWoIEdN+zOp41PpbTnHhuEEh0w7pnMkHfRet9pw
         IeOg==
X-Forwarded-Encrypted: i=1; AJvYcCXKdGqHp22FkdFfeV9e+PCtgnJVHDNg06ADkCTdMhzoIeYtVwn6/wXjn0O4E6IkVv0uc6AL0fPHEARVdOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyCy3zDUIjSF4wdeBdSa2nCGs6aGGc8qkDYvbZfoGJaNLvJ2E2
	62edXJrFHm+nM6CQoTWayToc9F8rV3WZBGctBIlieMZfQVHaFTIc99HWuCggBGebOMc=
X-Gm-Gg: ASbGncuyksB3atmI6N5sKDDAAEUMMXPXQL78orTcMV5tJBnUOwWwDXLDXMWSUzal3cV
	eo08PvC9k5gVfhgC2RN4IdoCVBIgBAt6HVHYk21QwwdhqgXsHFnqtPLOL+8D4n6sKYXdR9Ly1mi
	tdAort8Pisa+WXECa1RJplh4xfGuZPdg+68qz7jWVuSqNeXBl3oDz5I4tXVx7O85AkmcKeco/F/
	ZWU3CO23YQPcIAz4urwt3Or1j7XqSP949/WfydujR/2tPP568zVFG+qpST+RO7GjHT9JKJyuoKs
	iGvn9+FyMGAWTsRxfw8jr2qaQY1M0Az5Ag+J6fL5MXI0ojM9bKm8XtaWFQ6oe4mU1LeqZLB/SD3
	g+8OJvf3z7WjE0u/TBfVNBR9TSEHZo0qRSExdyr8AGdynWIXfpNFGCRw7XsyWARalSU1m3mJOxA
	GcKpViBSAJBUh6WwQ3sqC01uU1W6BKfk1RH6XGs2o5YIWHFw==
X-Google-Smtp-Source: AGHT+IGmEJgtOcG3TZDABRu2VDBPSubFzhWhz9sfmcicC9Qluv/yYZI9pxJD5vJuhvZHQji+iVBBlQ==
X-Received: by 2002:a05:6000:2485:b0:426:f40a:7179 with SMTP id ffacd0b85a97d-42704d8f12emr27628951f8f.26.1761553514327;
        Mon, 27 Oct 2025 01:25:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7b43sm13101111f8f.6.2025.10.27.01.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 01:25:13 -0700 (PDT)
Message-ID: <f2f95bc5-a107-481d-ad66-56db68cd143a@rivosinc.com>
Date: Mon, 27 Oct 2025 09:25:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [PATCH v7 0/5] riscv: add support for SBI Supervisor
 Software Events
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Himanshu Chauhan <hchauhan@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>, Xu Lu <luxu.kernel@bytedance.com>,
 Atish Patra <atishp@atishpatra.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>
References: <20250908181717.1997461-1-cleger@rivosinc.com>
 <CAEEQ3w=6F-QHvvA-tEhM2CnYqumQfobLje--d7i61-EdK6uxZw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CAEEQ3w=6F-QHvvA-tEhM2CnYqumQfobLje--d7i61-EdK6uxZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/27/25 02:47, yunhui cui wrote:
> Hi Clément,
> 
> On Tue, Sep 9, 2025 at 2:19 AM Clément Léger <cleger@rivosinc.com> wrote:
>>
>> The SBI Supervisor Software Events (SSE) extensions provides a mechanism
>> to inject software events from an SBI implementation to supervisor
>> software such that it preempts all other supervisor level traps and
>> interrupts. This extension is introduced by the SBI v3.0 specification[1].
>>
>> Various events are defined and can be send asynchronously to supervisor
>> software (RAS, PMU, DEBUG, Asynchronous page fault) from SBI as well
>> as platform specific events. Events can be either local (per-hart) or
>> global. Events can be nested on top of each other based on priority and
>> can interrupt the kernel at any time.
>>
>> First patch adds the SSE definitions. Second one adds support for SSE
>> at arch level (entry code and stack allocations) and third one at driver
>> level. Finally, the last patch add support for SSE events in the SBI PMU
>> driver. Additional testing for that part is highly welcomed since there
>> are a lot of possible path that needs to be exercised.
>>
>> Amongst the specific points that needs to be handle is the interruption
>> at any point of the kernel execution and more specifically at the
>> beginning of exception handling. Due to the fact that the exception entry
>> implementation uses the SCRATCH CSR as both the current task struct and
>> as the temporary register to switch the stack and save register, it is
>> difficult to reliably get the current task struct if we get interrupted
>> at this specific moment (ie, it might contain 0, the task pointer or tp).
>> A fixup-like mechanism is not possible due to the nested nature of SSE
>> which makes it really hard to obtain the original interruption site. In
>> order to retrieve the task in a reliable manner, add an additional
>> __sse_entry_task per_cpu array which stores the current task. Ideally,
>> we would need to modify the way we retrieve/store the current task in
>> exception handling so that it does not depend on the place where it's
>> interrupted.
>>
>> Contrary to pseudo NMI [2], SSE does not modifies the way interrupts are
>> handled and does not adds any overhead to existing code. Moreover, it
>> provides "true" NMI-like interrupts which can interrupt the kernel at
>> any time (even in exception handling). This is particularly crucial for
>> RAS errors which needs to be handled as fast as possible to avoid any
>> fault propagation.
>>
>> A test suite is available as a separate kselftest module. In order to
>> build it, you can use the following command:
>>
>> $ KDIR=<build_dir> make O=build TARGETS="riscv/sse"-j $(($(nproc)-1)) -C tools/testing/selftests
>>
>> Then load the module using:
>>
>> $ sh run_sse_test.sh
>>
>> A KVM SBI SSE extension implementation is available at [2].
>>
>> Link: https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/v3.0-rc7/riscv-sbi.pdf [1]
>> Link: https://github.com/rivosinc/linux/tree/dev/cleger/sse_kvm [2]
>>
>> ---
>>
>> Changes in v7:
>>  - Check return values of sse_on_each_cpu()
>>  - Fix typos in commit
>>  - Rename SBI_SSE_EVENT_SIGNAL to SBI_SSE_EVENT_INJECT
>>  - Rename SBI_SSE_EVENT_HART_UNMASK/MASK to SBI_SSE_HART_UNMASK/MASK
>>  - Add tlb flush for vmap stack to avoid taking exception during sse
>>    handler upon stack access. (Alex)
>>  - Move some assembly instruction to slow path
>>  - Renamed sse.c to sbi_sse.c, ditto for other files
>>  - Renamed RISCV_SSE to RISCV_SBI_SSE
>>  - Renamed sse_event_handler to sse_event_handler_fn
>>  - Put ifdef around sse_evt in PMU SBI driver
>>
>> Changes in v6:
>>  - Fix comment in assembly argument
>>  - Check hart id to be the expected one in order to skip CPU id
>>    matching in sse assembly.
>>
>> Changes in v5:
>>  - Added a SSE test module in kselftests
>>  - Removed an unused variable
>>  - Applied checkpatch.pl --strict and fix all errors
>>  - Use scope_guard(cpus_read_lock) instead of manual cpus_read_lock()
>>  - Fix wrong variable returned in sse_get_event
>>  - Remove useless init of events list
>>  - Remove useless empty for loop on cpus
>>  - Set sse_available as  __ro_after_init
>>  - Changed a few pr_debug to pr_warn
>>  - Fix event enabled stated updated in case of failure
>>  - Change no_lock to nolock
>>  - Rename attr_buf to attr
>>  - renamed sse_get_event_phys() to sse_event_get_attr_phys() and removed
>>    the second argument
>>  - Simplify return value in sse_event_attr_set_nolock()
>>  - Remove while loop(-EINVAL) for event cpu set call
>>  - Renamed interrupted_state_phys to interrupted_phys
>>  - Use scoped_guards/guard for sse_mutex
>>  - Remove useless struct forward declaration in sse.h
>>  - Add more explanations as to why we set SIE bit in IP
>>  - Unconditionnally set SIE in SIP
>>  - Move SSE_STACK_SIZE adjustement in sse_stack_alloc/free()
>>  - Replace move instructions with mv
>>  - Rename NR_CPUS asm symbol to ASM_NR_CPUS
>>  - Restore SSTATUS first in sse_entry return path so that it works for
>>    double trap without any modification later.
>>  - Implement proper per cpu revert if enable/register fails
>>
>> Changes in v4:
>>  - Fix a bug when using per_cpu ptr for local event (Andrew)
>>  - Add sse_event_disable/enable_local()
>>  - Add pmu_disable/pmu_enable() to disable/enable SSE event
>>  - Update event ID description according to the latest spec
>>  - Fix comment about arguments in handle_sse()
>>  - Added Himanchu as a SSE reviewer
>>  - Used SYM_DATA_*() macros instead of hardcoded labels
>>  - Invoke softirqs only if not returning to kernel with irqs disabled
>>  - Remove invalid state check for write attribute function.
>>  - Remove useless bneq statement in sse_entry.S
>>
>> Changes in v3:
>>  - Split arch/driver support
>>  - Fix potential register failure reporting
>>  - Set a few pr_err as pr_debug
>>  - Allow CONFIG_RISCV_SSE to be disabled
>>  - Fix build without CONFIG_RISCV_SSE
>>  - Remove fixup-like mechanism and use a per-cpu array
>>  - Fixed SSCRATCH being corrupted when interrupting the kernel in early
>>    exception path.
>>  - Split SSE assembly from entry.S
>>  - Add Himanchu SSE mask/unmask and runtime PM support.
>>  - Disable user memory access/floating point/vector in SSE handler
>>  - Rebased on master
>>
>> v2: https://lore.kernel.org/linux-riscv/20240112111720.2975069-1-cleger@rivosinc.com/
>>
>> Changes in v2:
>>  - Implemented specification v2
>>  - Fix various error handling cases
>>  - Added shadow stack support
>>
>> v1: https://lore.kernel.org/linux-riscv/20231026143122.279437-1-cleger@rivosinc.com/
>>
>> Clément Léger (5):
>>   riscv: add SBI SSE extension definitions
>>   riscv: add support for SBI Supervisor Software Events extension
>>   drivers: firmware: add riscv SSE support
>>   perf: RISC-V: add support for SSE event
>>   selftests/riscv: add SSE test module
>>
>>  MAINTAINERS                                   |  15 +
>>  arch/riscv/include/asm/asm.h                  |  14 +-
>>  arch/riscv/include/asm/sbi.h                  |  61 ++
>>  arch/riscv/include/asm/scs.h                  |   7 +
>>  arch/riscv/include/asm/sse.h                  |  47 ++
>>  arch/riscv/include/asm/switch_to.h            |  14 +
>>  arch/riscv/include/asm/thread_info.h          |   1 +
>>  arch/riscv/kernel/Makefile                    |   1 +
>>  arch/riscv/kernel/asm-offsets.c               |  14 +
>>  arch/riscv/kernel/sbi_sse.c                   | 174 +++++
>>  arch/riscv/kernel/sbi_sse_entry.S             | 178 +++++
>>  drivers/firmware/Kconfig                      |   1 +
>>  drivers/firmware/Makefile                     |   1 +
>>  drivers/firmware/riscv/Kconfig                |  15 +
>>  drivers/firmware/riscv/Makefile               |   3 +
>>  drivers/firmware/riscv/riscv_sbi_sse.c        | 701 ++++++++++++++++++
>>  drivers/perf/Kconfig                          |  10 +
>>  drivers/perf/riscv_pmu.c                      |  23 +
>>  drivers/perf/riscv_pmu_sbi.c                  |  71 +-
>>  include/linux/perf/riscv_pmu.h                |   5 +
>>  include/linux/riscv_sbi_sse.h                 |  57 ++
>>  tools/testing/selftests/riscv/Makefile        |   2 +-
>>  tools/testing/selftests/riscv/sse/Makefile    |   5 +
>>  .../selftests/riscv/sse/module/Makefile       |  16 +
>>  .../riscv/sse/module/riscv_sse_test.c         | 513 +++++++++++++
>>  .../selftests/riscv/sse/run_sse_test.sh       |  44 ++
>>  26 files changed, 1979 insertions(+), 14 deletions(-)
>>  create mode 100644 arch/riscv/include/asm/sse.h
>>  create mode 100644 arch/riscv/kernel/sbi_sse.c
>>  create mode 100644 arch/riscv/kernel/sbi_sse_entry.S
>>  create mode 100644 drivers/firmware/riscv/Kconfig
>>  create mode 100644 drivers/firmware/riscv/Makefile
>>  create mode 100644 drivers/firmware/riscv/riscv_sbi_sse.c
> 
> These newly added files use different GPL-xxx licenses respectively:
> arch/riscv/kernel/sbi_sse.c: // SPDX-License-Identifier: GPL-2.0-or-later
> drivers/firmware/riscv/riscv_sbi_sse.c: // SPDX-License-Identifier: GPL-2.0-only
> arch/riscv/include/asm/sse.h: /* SPDX-License-Identifier: GPL-2.0-only */
> Should they be consistent, or is this by design?

Hi Yunhui,

That is not intended, I'll fix it.

Thanks,

Clément

> 
> 
>>  create mode 100644 include/linux/riscv_sbi_sse.h
>>  create mode 100644 tools/testing/selftests/riscv/sse/Makefile
>>  create mode 100644 tools/testing/selftests/riscv/sse/module/Makefile
>>  create mode 100644 tools/testing/selftests/riscv/sse/module/riscv_sse_test.c
>>  create mode 100644 tools/testing/selftests/riscv/sse/run_sse_test.sh
>>
>> --
>> 2.43.0
>>
> 
> Thanks,
> Yunhui



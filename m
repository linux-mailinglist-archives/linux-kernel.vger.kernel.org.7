Return-Path: <linux-kernel+bounces-754845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5772DB19D75
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3AB93A6DE2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F0823D2BF;
	Mon,  4 Aug 2025 08:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="G+ZzUsbb"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A2C1A073F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 08:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754295418; cv=none; b=qNlEGyJGRQRxM2ouB+YBwmowoQLFrj0KeZYcQuONJKNcvM5buFBHHeRR0+VpXDJpT/mOPhHtw9FafWhGHczBzfvnvLuivnPgZq4dWkGEkBiLLyzOjNCgx4jM89EPJNvEnW4NwxAk2zDiIEpvzjXaiKIMJMVuk9kTVMKWUhaiMtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754295418; c=relaxed/simple;
	bh=GtdJ1w0bLgTqOThcBexpOIlzV+10ZQb04t3a8DdU4os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLgnGlQF2htovGWaB2gTREZVF4y1ha4AGEaY3m7iFl1sKHaZSQIn0uuzCkITj5svFjHhKnsQms6BOYiOOU87m8WGbw4oIIb2qumjgCSzM/V+kLlji944XYQw4OpG52ENLE71P1P5xwziDLQEdlqcdFnd93SZFp82Bd64PSlad/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=G+ZzUsbb; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b7823559a5so2410953f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 01:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1754295415; x=1754900215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OEeVCTU26A2c9mzwa89W6JCorn8Fiao7bTSPK85CQbI=;
        b=G+ZzUsbbedWBAvylvfnXcaahbaxpmbRsMYD1rLXQViwO147prJ5vhYNZhAmCvk8No4
         H3c2ncN/AemeLRE7solNN4vUnsyx0WTDbT/eW2nK0xj6zNyMCUIfuECo25c6f5jJO/hy
         3XKg0DmFNdkPBZUK7Kp+DgYUVe2gwiogK/HAW+PqN44mTeiqOkpWUx5A/ObEkqp10Abu
         EqciSWXqcrE7HcCi7uMZX8ZRZvjXkKO30T4Bulgsk6O44j1vNAUCgFFbHaj9dS9gTdPE
         EIbzsyj4X5jZRi0NUIb668/IgkzDxqNdrgKOQBsTtJnehFJDOpqFrdN8WjiNcThZgzzQ
         VpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754295415; x=1754900215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OEeVCTU26A2c9mzwa89W6JCorn8Fiao7bTSPK85CQbI=;
        b=uUbCA8KGqPTo+CIgYkFYnoOYZcAfF6UB+iWklXntHHMgfW8vPhWkeist08Ii0X4D8M
         dAMJSksLwHaJaFRHCu8h/fpljUKzP6uKr1HWJPnnaBu5bi7bt4whfkGunFzKsLJ9eEia
         h5M5r7cjFaLLf/lJ41aeQPdpN+Wtw+5cRpSm3+9ZkLngPGh8wlbsUV6RAsmTtkEQ0fj4
         RFXWc3DRIUGjk0lSPMVoKLAi0QvEdjidCVawDHee3r5zdcIvFo9INhcxd0kM6bJLLkb2
         umDqiuTedTA1xRF2lACrpr805XwIPTVEYm7ZUBbzdwJvodnmTzxI56N7DBNSYy7z5LWc
         Mc6g==
X-Forwarded-Encrypted: i=1; AJvYcCWz/SCY+o0CsFBj1flh73wiScwi2kO/YmrgQCmT2LJgzl4trQU6t88GBlVxALo8Ts50JoWCXXxc/aMhRAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznf01joYtuV8zi175HrNs3dowk92SzxkWJ05oHFqTLUWMocwrN
	B3LxVjK0ZCGPCgAdo5VIgRBlvEQobCs6qQuwQimOjUKgyoyc4LaoDICHUnQOUT6kL2E=
X-Gm-Gg: ASbGnctCovYx6bO2OyTQPGZgLRayPFkQWUO1O6ojXQUAcXWFgiZjn25RutzHzrzblQ9
	1OIu6dmkES4r1V4UAu78GLcopsZHAAjdNhxl7Nb51sq1nA8swroXfBOHtD9XV5KDApFcL2abypw
	vWsFLNIkNrsawSSlK0Nkq3C2DA0LvxPBi+LdQSms+buMJbgy6OuN1MOiahTnWf5Uirow+eJpnMr
	JS+Ixtw988ImTv/pwlIwuJ9mbHd8BmmzF6noh4d4p4uezgQGmpKFS+bAsN/vcGSxEgo7p2fURVM
	6SaQbtjIearnFCHyUYoh+LsXC+1v/SFGOjRI/JeNm354ZBoTjKT6SDqlSLgWV8esk59H+20V+7/
	fz+78LbDPUyv+87+6RrGSbzNtRlVVctWxOv88iNVYQPmlqScybdSP6bsTYVhIFpl5Sdc=
X-Google-Smtp-Source: AGHT+IEgZO9itT+bxvDLwpYlCFZ5OrvDEOn0OKR5gnR2Rd15k7AEooLseENSSAxxm1NkLlFQ8LzEcQ==
X-Received: by 2002:a05:6000:2481:b0:3b5:f93a:bcc with SMTP id ffacd0b85a97d-3b8d94c1ceamr6822762f8f.35.1754295414943;
        Mon, 04 Aug 2025 01:16:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453aeasm15083572f8f.40.2025.08.04.01.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 01:16:54 -0700 (PDT)
Message-ID: <d9a98d98-16d7-4d3d-b968-bcd34c8dd0f4@rivosinc.com>
Date: Mon, 4 Aug 2025 10:16:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/6] riscv: ptrace: Add hw breakpoint support
To: Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Oleg Nesterov <oleg@redhat.com>,
 Himanshu Chauhan <hchauhan@ventanamicro.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 Samuel Holland <samuel.holland@sifive.com>, Deepak Gupta
 <debug@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>,
 Atish Patra <atishp@rivosinc.com>, Anup Patel <apatel@ventanamicro.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Conor Dooley <conor.dooley@microchip.com>, WangYuli
 <wangyuli@uniontech.com>, Huacai Chen <chenhuacai@kernel.org>,
 Nam Cao <namcao@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>,
 Joel Granados <joel.granados@kernel.org>,
 Celeste Liu <coelacanthushex@gmail.com>, Evan Green <evan@rivosinc.com>,
 Nylon Chen <nylon.chen@sifive.com>
References: <20250722173829.984082-1-jesse@rivosinc.com>
 <20250722173829.984082-7-jesse@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250722173829.984082-7-jesse@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 22/07/2025 19:38, Jesse Taube wrote:
> Add ability to setup hw breakpoints to ptrace. Call defines a new
> structure of (ulong[3]){bp_addr, bp_len, bp_type} with
> bp_type being one of HW_BREAKPOINT_LEN_X and
> bp_len being one of HW_BREAKPOINT_X with a value of
> zero dissabling the breakpoint.
> 
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
>  arch/riscv/include/asm/processor.h   |  4 ++
>  arch/riscv/include/uapi/asm/ptrace.h |  3 +-
>  arch/riscv/kernel/hw_breakpoint.c    | 14 ++++-
>  arch/riscv/kernel/process.c          |  4 ++
>  arch/riscv/kernel/ptrace.c           | 93 ++++++++++++++++++++++++++++
>  5 files changed, 116 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index 5f56eb9d114a..488d956a951f 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -12,6 +12,7 @@
>  
>  #include <vdso/processor.h>
>  
> +#include <asm/hw_breakpoint.h>
>  #include <asm/ptrace.h>
>  
>  #define arch_get_mmap_end(addr, len, flags)			\
> @@ -108,6 +109,9 @@ struct thread_struct {
>  	struct __riscv_v_ext_state vstate;
>  	unsigned long align_ctl;
>  	struct __riscv_v_ext_state kernel_vstate;
> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> +	struct perf_event *ptrace_bps[RV_MAX_TRIGGERS];
> +#endif
>  #ifdef CONFIG_SMP
>  	/* Flush the icache on migration */
>  	bool force_icache_flush;
> diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
> index a38268b19c3d..a7998ed41913 100644
> --- a/arch/riscv/include/uapi/asm/ptrace.h
> +++ b/arch/riscv/include/uapi/asm/ptrace.h
> @@ -14,7 +14,8 @@
>  
>  #define PTRACE_GETFDPIC_EXEC	0
>  #define PTRACE_GETFDPIC_INTERP	1
> -
> +#define PTRACE_GETHBPREGS	2
> +#define PTRACE_SETHBPREGS	3
>  /*
>   * User-mode register state for core dumps, ptrace, sigcontext
>   *
> diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw_breakpoint.c
> index 437fd82b9590..c58145464539 100644
> --- a/arch/riscv/kernel/hw_breakpoint.c
> +++ b/arch/riscv/kernel/hw_breakpoint.c
> @@ -633,7 +633,19 @@ void arch_uninstall_hw_breakpoint(struct perf_event *event)
>  		pr_warn("%s: Failed to uninstall trigger %d. error: %ld\n", __func__, i, ret.error);
>  }
>  
> -void flush_ptrace_hw_breakpoint(struct task_struct *tsk) { }
> +/*
> + * Release the user breakpoints used by ptrace
> + */
> +void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
> +{
> +	int i;
> +	struct thread_struct *t = &tsk->thread;
> +
> +	for (i = 0; i < dbtr_total_num; i++) {
> +		unregister_hw_breakpoint(t->ptrace_bps[i]);
> +		t->ptrace_bps[i] = NULL;
> +	}
> +}

Hi Jesse,

You can discard my comment in the previous patch about implementing this
function ;)

Thanks,

Clément

>  
>  void hw_breakpoint_pmu_read(struct perf_event *bp) { }
>  
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 15d8f75902f8..9cf07ecfb523 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/cpu.h>
> +#include <linux/hw_breakpoint.h>
>  #include <linux/kernel.h>
>  #include <linux/sched.h>
>  #include <linux/sched/debug.h>
> @@ -164,6 +165,7 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
>  
>  void flush_thread(void)
>  {
> +	flush_ptrace_hw_breakpoint(current);
>  #ifdef CONFIG_FPU
>  	/*
>  	 * Reset FPU state and context
> @@ -218,6 +220,8 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>  		set_bit(MM_CONTEXT_LOCK_PMLEN, &p->mm->context.flags);
>  
>  	memset(&p->thread.s, 0, sizeof(p->thread.s));
> +	if (IS_ENABLED(CONFIG_HAVE_HW_BREAKPOINT))
> +		memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
>  
>  	/* p->thread holds context to be restored by __switch_to() */
>  	if (unlikely(args->fn)) {
> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> index ea67e9fb7a58..b78cfb0f1c0e 100644
> --- a/arch/riscv/kernel/ptrace.c
> +++ b/arch/riscv/kernel/ptrace.c
> @@ -9,11 +9,13 @@
>  
>  #include <asm/vector.h>
>  #include <asm/ptrace.h>
> +#include <asm/hw_breakpoint.h>
>  #include <asm/syscall.h>
>  #include <asm/thread_info.h>
>  #include <asm/switch_to.h>
>  #include <linux/audit.h>
>  #include <linux/compat.h>
> +#include <linux/hw_breakpoint.h>
>  #include <linux/ptrace.h>
>  #include <linux/elf.h>
>  #include <linux/regset.h>
> @@ -336,12 +338,103 @@ void ptrace_disable(struct task_struct *child)
>  {
>  }
>  
> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> +static void ptrace_hbptriggered(struct perf_event *bp,
> +				struct perf_sample_data *data,
> +				struct pt_regs *regs)
> +{
> +	struct arch_hw_breakpoint *bkpt = counter_arch_bp(bp);
> +	int num = 0;
> +
> +	force_sig_ptrace_errno_trap(num, (void __user *)bkpt->address);
> +}
> +
> +/*
> + * idx selects the breakpoint index.
> + * Both PTRACE_GETHBPREGS and PTRACE_SETHBPREGS transfer three 32-bit words:
> + * address (0), length (1), type (2).
> + * Instruction breakpoint length is one of HW_BREAKPOINT_LEN_X or 0. 0 will
> + * disable the breakpoint.
> + * Instruction breakpoint type is one of HW_BREAKPOINT_X.
> + */
> +
> +static long ptrace_gethbpregs(struct task_struct *child, unsigned long idx,
> +			      unsigned long __user *datap)
> +{
> +	struct perf_event *bp;
> +	unsigned long user_data[3] = {0};
> +
> +	if (idx >= RV_MAX_TRIGGERS)
> +		return -EINVAL;
> +
> +	bp = child->thread.ptrace_bps[idx];
> +
> +	if (!IS_ERR_OR_NULL(bp)) {
> +		user_data[0] = bp->attr.bp_addr;
> +		user_data[1] = bp->attr.disabled ? 0 : bp->attr.bp_len;
> +		user_data[2] = bp->attr.bp_type;
> +	}
> +
> +	if (copy_to_user(datap, user_data, sizeof(user_data)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static long ptrace_sethbpregs(struct task_struct *child, unsigned long idx,
> +			      unsigned long __user *datap)
> +{
> +	struct perf_event *bp;
> +	struct perf_event_attr attr;
> +	unsigned long user_data[3];
> +
> +	if (idx >= RV_MAX_TRIGGERS)
> +		return -EINVAL;
> +
> +	if (copy_from_user(user_data, datap, sizeof(user_data)))
> +		return -EFAULT;
> +
> +	bp = child->thread.ptrace_bps[idx];
> +	if (IS_ERR_OR_NULL(bp))
> +		attr = bp->attr;
> +	else
> +		ptrace_breakpoint_init(&attr);
> +
> +	attr.bp_addr = user_data[0];
> +	attr.bp_len = user_data[1];
> +	attr.bp_type = user_data[2];
> +	attr.disabled = !attr.bp_len;
> +
> +	if (IS_ERR_OR_NULL(bp)) {
> +		bp = register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NULL,
> +					   child);
> +		if (IS_ERR(bp))
> +			return PTR_ERR(bp);
> +
> +		child->thread.ptrace_bps[idx] = bp;
> +		return 0;
> +	} else {
> +		return modify_user_hw_breakpoint(bp, &attr);
> +	}
> +}
> +#endif
> +
>  long arch_ptrace(struct task_struct *child, long request,
>  		 unsigned long addr, unsigned long data)
>  {
>  	long ret = -EIO;
> +	unsigned long __user *datap = (unsigned long __user *) data;
>  
>  	switch (request) {
> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> +	case PTRACE_GETHBPREGS:
> +		ret = ptrace_gethbpregs(child, addr, datap);
> +		break;
> +
> +	case PTRACE_SETHBPREGS:
> +		ret = ptrace_sethbpregs(child, addr, datap);
> +		break;
> +#endif
>  	default:
>  		ret = ptrace_request(child, request, addr, data);
>  		break;



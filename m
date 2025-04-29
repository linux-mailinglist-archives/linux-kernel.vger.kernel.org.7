Return-Path: <linux-kernel+bounces-624367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 555E5AA02AE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 08:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80FE3AC5C3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 06:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E153A2749CF;
	Tue, 29 Apr 2025 06:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GAyO9M3j"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1204270ED6
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 06:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745907126; cv=none; b=mK94BVayGaDo4PEQFGsItlrwJs7jqp8FQdMRok6Xi52zGgnK01HHzf1q+6oZsDN4S9KYIAaGPCAnmSrtAB95cE/SKTa9UeOTvlMWrXHRoS8OL0ImZi0dV7CDRzxsqWTwPLoaOw6pTTIq/K16z0IjeZ16EVgxW+K8pfTm6GnswX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745907126; c=relaxed/simple;
	bh=nD80AiV4vmOQH+r2Z0ImWG8BSZmGw/VGV+Ek0aya8VU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DC0zlAOBBxr5V5qR+Th2umLYfyNdnpIkLTFQEsuRqlORX6XR5Qhj0TTcA9N9RN2v8deQKNd88hBpATiK+UHaiItzWwgLm8M7ookhrMUJpWFUwh1dHGzG83TxMNxJq9HEn3tWlGyU0u90qG2shPLgeII2KaYGDvBy+CsY7TWY55M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GAyO9M3j; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T4EYGr028677;
	Tue, 29 Apr 2025 06:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9iaowe
	cAWd93D42fDX1wd26N3pM98IU46+mLmXvjhlg=; b=GAyO9M3j07gvc82xrp+aAE
	m68sWP81Wz4sB5UO7F9gOmxYDRJOm4WS5DQW5aMkwrfG4Jk+6KDJvv0IcCRVBBJZ
	ORtcyzFWAluQkFi1r8AFrW/V0DEIa2Fj+rNdQJkOQ5sbCdtsqOOsGJtWdAH3WivE
	XyFkwyGOLrV/vKD9fcd1G8bIOwrJjOQcBNlIH3XFJb5bJQEmnODgt/RvryVPukL5
	HcMefiaHc6A8NhlA61wqG4dLFoun0ukfpRHf7ws710RPoC/jqUw1EdmigH4sCL3d
	JQK+vEYOGDLU0JfEAPwF1fjaexU7uFYv+dKYR+vmEAJ/knZxdEcHNCdL3G1bwYDw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ah8m9kda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 06:11:24 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53T6BNk8005532;
	Tue, 29 Apr 2025 06:11:23 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ah8m9kd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 06:11:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53T3atXk031677;
	Tue, 29 Apr 2025 06:11:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4699tu22qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 06:11:22 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53T6BIA656689092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 06:11:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B65772004B;
	Tue, 29 Apr 2025 06:11:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAECD20040;
	Tue, 29 Apr 2025 06:11:10 +0000 (GMT)
Received: from [9.124.218.151] (unknown [9.124.218.151])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Apr 2025 06:11:10 +0000 (GMT)
Message-ID: <85084257-a186-430c-b46d-2fca10d17b8f@linux.ibm.com>
Date: Tue, 29 Apr 2025 11:41:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 6/6] powerpc: Enable Generic Entry/Exit for syscalls.
To: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org,
        neeraj.upadhyay@kernel.org, vschneid@redhat.com, tglx@linutronix.de,
        frederic@kernel.org, ankur.a.arora@oracle.com, bigeasy@linutronix.de,
        kees@kernel.org, oleg@redhat.com, peterz@infradead.org,
        tzimmermann@suse.de, namcao@linutronix.de, kan.liang@linux.intel.com,
        mcgrof@kernel.org, rppt@kernel.org, atrajeev@linux.vnet.ibm.com,
        anjalik@linux.ibm.com, coltonlewis@google.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250428152225.66044-2-mchauras@linux.ibm.com>
 <20250428152225.66044-9-mchauras@linux.ibm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250428152225.66044-9-mchauras@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7pqXajHC3v8iNJ8jNgwXM-lj4puFscuy
X-Proofpoint-GUID: o49jqFrFopD5cMEEuniCy3FKi8qjdQMY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA0NSBTYWx0ZWRfX0xbMy6hPsOV8 RWa40kwTfUz61FtOlmOSQnFZVvpPPGLtkU8lSLbCbIXdSMU77Wuac7fkVJtgIunq8lDXORJGcdm Vf8SMD0mxybOTWKyIWmgogyNUdIaHWms7VOE+NAV7E2Qg+x7jwHWXEYtuP3n16WTcLMvppBjbKu
 HdcWx5HrdYK9NXDePua5WtALe1WWkwI/lh3inC7QuDigydI9/7S3sl0O0WXy9PJbIYTzZ9XMXCm 5Jg7sGTf6jnd2rm+H0Oddl0QqbN9Bg49sHLcOpzVNYeiD0c8S1DQ6MCYVwDdLs8NgXbvunomEUt IYvlx2Uz69J/n+NUdpiCuc3AOzGpYiKJckw7o3yyANo5U9y4kUE9I3Gbu620rSs7VUfRMFrVM3c
 9wgzmG5nRIkL4oV+OeaU/Q2mWXvaPyLwI3QBIF43Ix3bIZzqqvQ0fNDUbkB/SycUKHGHaxlA
X-Authority-Analysis: v=2.4 cv=QNRoRhLL c=1 sm=1 tr=0 ts=68106d8c cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=rOVY07Nq74tCNd9X-qYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 clxscore=1011 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290045



On 4/28/25 20:52, Mukesh Kumar Chaurasiya wrote:
> Enable the syscall entry and exit path from generic framework.
> 
> Signed-off-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>

Hi Mukesh. Thanks for working on this. Trying to go through it.

> ---
>   arch/powerpc/Kconfig                |   1 +
>   arch/powerpc/kernel/interrupt.c     |  46 +++++++----
>   arch/powerpc/kernel/ptrace/ptrace.c | 103 ------------------------
>   arch/powerpc/kernel/signal.c        |   8 +-
>   arch/powerpc/kernel/syscall.c       | 117 +---------------------------
>   5 files changed, 38 insertions(+), 237 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 6722625a406a0..45b70ccf7c89e 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -202,6 +202,7 @@ config PPC
>   	select GENERIC_CPU_AUTOPROBE
>   	select GENERIC_CPU_VULNERABILITIES	if PPC_BARRIER_NOSPEC
>   	select GENERIC_EARLY_IOREMAP
> +	select GENERIC_ENTRY

IMHO this should be enabled after irqentry_* is supported too.

>   	select GENERIC_GETTIMEOFDAY
>   	select GENERIC_IDLE_POLL_SETUP
>   	select GENERIC_IOREMAP
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> index 7f31f3fb9c1d8..8731064631de0 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   
>   #include <linux/context_tracking.h>
> +#include <linux/entry-common.h>
>   #include <linux/err.h>
>   #include <linux/compat.h>
>   #include <linux/rseq.h>
> @@ -163,15 +164,10 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
>   	unsigned long ret = 0;
>   	bool is_not_scv = !IS_ENABLED(CONFIG_PPC_BOOK3S_64) || !scv;
>   
> -	CT_WARN_ON(ct_state() == CT_STATE_USER);
> -
>   	kuap_assert_locked();
>   
>   	regs->result = r3;
>   
> -	/* Check whether the syscall is issued inside a restartable sequence */
> -	rseq_syscall(regs);
> -
>   	ti_flags = read_thread_flags();
>   
>   	if (unlikely(r3 >= (unsigned long)-MAX_ERRNO) && is_not_scv) {
> @@ -192,13 +188,27 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
>   	}
>   
>   	if (unlikely(ti_flags & _TIF_SYSCALL_DOTRACE)) {
> -		do_syscall_trace_leave(regs);
>   		ret |= _TIF_RESTOREALL;
>   	}
>   
> -	local_irq_disable();
> -	ret = interrupt_exit_user_prepare_main(ret, regs);

This loop i dont understand why.

> +again:
> +	syscall_exit_to_user_mode(regs);

exit_to_user_mode also calls user_enter_irqoff.
so below user_enter_irqoff may be a nop or wrong.

also, syscall_exit_to_user_mode disables local interrupts first.

is local_irq_enable fixing something here?

> +
> +	user_enter_irqoff();
> +	if (!prep_irq_for_enabled_exit(true)) {
> +		user_exit_irqoff();
> +		local_irq_enable();
> +		local_irq_disable();
> +		goto again;
> +	}
> +
> +	/* Restore user access locks last */
> +	kuap_user_restore(regs);
>   
> +	if (unlikely((local_paca->generic_fw_flags & GFW_RESTORE_ALL) == GFW_RESTORE_ALL)) {
> +		ret |= _TIF_RESTOREALL;
> +		local_paca->generic_fw_flags &= ~GFW_RESTORE_ALL;
> +	}
>   #ifdef CONFIG_PPC64
>   	regs->exit_result = ret;
>   #endif
> @@ -209,6 +219,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
>   #ifdef CONFIG_PPC64
>   notrace unsigned long syscall_exit_restart(unsigned long r3, struct pt_regs *regs)
>   {
> +	unsigned long ret = 0;
>   	/*
>   	 * This is called when detecting a soft-pending interrupt as well as
>   	 * an alternate-return interrupt. So we can't just have the alternate
> @@ -222,14 +233,23 @@ notrace unsigned long syscall_exit_restart(unsigned long r3, struct pt_regs *reg
>   #ifdef CONFIG_PPC_BOOK3S_64
>   	set_kuap(AMR_KUAP_BLOCKED);
>   #endif
> +again:
> +	syscall_exit_to_user_mode(regs);
>   
> -	trace_hardirqs_off();
> -	user_exit_irqoff();
> -	account_cpu_user_entry();
> +	user_enter_irqoff();
> +	if (!prep_irq_for_enabled_exit(true)) {
> +		user_exit_irqoff();
> +		local_irq_enable();
> +		local_irq_disable();
> +		goto again;
> +	}
>   
> -	BUG_ON(!user_mode(regs));
> +	if (unlikely((local_paca->generic_fw_flags & GFW_RESTORE_ALL) == GFW_RESTORE_ALL)) {
> +		ret = _TIF_RESTOREALL;
> +		local_paca->generic_fw_flags &= ~GFW_RESTORE_ALL;
> +	}
>   
> -	regs->exit_result = interrupt_exit_user_prepare_main(regs->exit_result, regs);
> +	regs->exit_result |= ret;
>   
>   	return regs->exit_result;
>   }
> diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
> index c6997df632873..2a2b0b94a3eaa 100644
> --- a/arch/powerpc/kernel/ptrace/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace/ptrace.c
> @@ -21,9 +21,6 @@
>   #include <asm/switch_to.h>
>   #include <asm/debug.h>
>   
> -#define CREATE_TRACE_POINTS
> -#include <trace/events/syscalls.h>
> -
>   #include "ptrace-decl.h"
>   
>   /*
> @@ -233,106 +230,6 @@ static int do_seccomp(struct pt_regs *regs)
>   static inline int do_seccomp(struct pt_regs *regs) { return 0; }
>   #endif /* CONFIG_SECCOMP */
>   
> -/**
> - * do_syscall_trace_enter() - Do syscall tracing on kernel entry.
> - * @regs: the pt_regs of the task to trace (current)
> - *
> - * Performs various types of tracing on syscall entry. This includes seccomp,
> - * ptrace, syscall tracepoints and audit.
> - *
> - * The pt_regs are potentially visible to userspace via ptrace, so their
> - * contents is ABI.
> - *
> - * One or more of the tracers may modify the contents of pt_regs, in particular
> - * to modify arguments or even the syscall number itself.
> - *
> - * It's also possible that a tracer can choose to reject the system call. In
> - * that case this function will return an illegal syscall number, and will put
> - * an appropriate return value in regs->r3.
> - *
> - * Return: the (possibly changed) syscall number.
> - */
> -long do_syscall_trace_enter(struct pt_regs *regs)
> -{
> -	u32 flags;
> -
> -	flags = read_thread_flags() & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE);
> -
> -	if (flags) {
> -		int rc = ptrace_report_syscall_entry(regs);
> -
> -		if (unlikely(flags & _TIF_SYSCALL_EMU)) {
> -			/*
> -			 * A nonzero return code from
> -			 * ptrace_report_syscall_entry() tells us to prevent
> -			 * the syscall execution, but we are not going to
> -			 * execute it anyway.
> -			 *
> -			 * Returning -1 will skip the syscall execution. We want
> -			 * to avoid clobbering any registers, so we don't goto
> -			 * the skip label below.
> -			 */
> -			return -1;
> -		}
> -
> -		if (rc) {
> -			/*
> -			 * The tracer decided to abort the syscall. Note that
> -			 * the tracer may also just change regs->gpr[0] to an
> -			 * invalid syscall number, that is handled below on the
> -			 * exit path.
> -			 */
> -			goto skip;
> -		}
> -	}
> -
> -	/* Run seccomp after ptrace; allow it to set gpr[3]. */
> -	if (do_seccomp(regs))
> -		return -1;
> -
> -	/* Avoid trace and audit when syscall is invalid. */
> -	if (regs->gpr[0] >= NR_syscalls)
> -		goto skip;
> -
> -	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
> -		trace_sys_enter(regs, regs->gpr[0]);
> -
> -	if (!is_32bit_task())
> -		audit_syscall_entry(regs->gpr[0], regs->gpr[3], regs->gpr[4],
> -				    regs->gpr[5], regs->gpr[6]);
> -	else
> -		audit_syscall_entry(regs->gpr[0],
> -				    regs->gpr[3] & 0xffffffff,
> -				    regs->gpr[4] & 0xffffffff,
> -				    regs->gpr[5] & 0xffffffff,
> -				    regs->gpr[6] & 0xffffffff);
> -
> -	/* Return the possibly modified but valid syscall number */
> -	return regs->gpr[0];
> -
> -skip:
> -	/*
> -	 * If we are aborting explicitly, or if the syscall number is
> -	 * now invalid, set the return value to -ENOSYS.
> -	 */
> -	regs->gpr[3] = -ENOSYS;
> -	return -1;
> -}
> -
> -void do_syscall_trace_leave(struct pt_regs *regs)
> -{
> -	int step;
> -
> -	audit_syscall_exit(regs);
> -
> -	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
> -		trace_sys_exit(regs, regs->result);
> -
> -	step = test_thread_flag(TIF_SINGLESTEP);
> -	if (step || test_thread_flag(TIF_SYSCALL_TRACE))
> -		ptrace_report_syscall_exit(regs, step);
> -}
> -
>   void __init pt_regs_check(void);
>   
>   /*
> diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
> index 719930cf4ae1f..8e1a1b26b5eae 100644
> --- a/arch/powerpc/kernel/signal.c
> +++ b/arch/powerpc/kernel/signal.c
> @@ -6,6 +6,7 @@
>    *    Extracted from signal_32.c and signal_64.c
>    */
>   
> +#include <linux/entry-common.h>
>   #include <linux/resume_user_mode.h>
>   #include <linux/signal.h>
>   #include <linux/uprobes.h>
> @@ -22,11 +23,6 @@
>   
>   #include "signal.h"
>   
> -/* This will be removed */
> -#ifdef CONFIG_GENERIC_ENTRY
> -#include <linux/entry-common.h>
> -#endif /* CONFIG_GENERIC_ENTRY */
> -
>   #ifdef CONFIG_VSX
>   unsigned long copy_fpr_to_user(void __user *to,
>   			       struct task_struct *task)
> @@ -374,11 +370,9 @@ void signal_fault(struct task_struct *tsk, struct pt_regs *regs,
>   				   task_pid_nr(tsk), where, ptr, regs->nip, regs->link);
>   }
>   
> -#ifdef CONFIG_GENERIC_ENTRY
>   void arch_do_signal_or_restart(struct pt_regs *regs)
>   {
>   	BUG_ON(regs != current->thread.regs);
>   	local_paca->generic_fw_flags |= GFW_RESTORE_ALL;
>   	do_signal(current);
>   }
> -#endif /* CONFIG_GENERIC_ENTRY */
> diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> index 9f03a6263fb41..66fd6ca4462b0 100644
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -3,6 +3,7 @@
>   #include <linux/compat.h>
>   #include <linux/context_tracking.h>
>   #include <linux/randomize_kstack.h>
> +#include <linux/entry-common.h>
>   
>   #include <asm/interrupt.h>
>   #include <asm/kup.h>
> @@ -21,121 +22,9 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
>   	kuap_lock();
>   
>   	add_random_kstack_offset();
> +	r0 = syscall_enter_from_user_mode(regs, r0);
>   
> -	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
> -		BUG_ON(irq_soft_mask_return() != IRQS_ALL_DISABLED);
> -
> -	trace_hardirqs_off(); /* finish reconciling */
> -
> -	CT_WARN_ON(ct_state() == CT_STATE_KERNEL);
> -	user_exit_irqoff();
> -
> -	BUG_ON(regs_is_unrecoverable(regs));
> -	BUG_ON(!user_mode(regs));
> -	BUG_ON(regs_irqs_disabled(regs));
> -
> -#ifdef CONFIG_PPC_PKEY
> -	if (mmu_has_feature(MMU_FTR_PKEY)) {
> -		unsigned long amr, iamr;
> -		bool flush_needed = false;
> -		/*
> -		 * When entering from userspace we mostly have the AMR/IAMR
> -		 * different from kernel default values. Hence don't compare.
> -		 */
> -		amr = mfspr(SPRN_AMR);
> -		iamr = mfspr(SPRN_IAMR);
> -		regs->amr  = amr;
> -		regs->iamr = iamr;
> -		if (mmu_has_feature(MMU_FTR_KUAP)) {
> -			mtspr(SPRN_AMR, AMR_KUAP_BLOCKED);
> -			flush_needed = true;
> -		}
> -		if (mmu_has_feature(MMU_FTR_BOOK3S_KUEP)) {
> -			mtspr(SPRN_IAMR, AMR_KUEP_BLOCKED);
> -			flush_needed = true;
> -		}
> -		if (flush_needed)
> -			isync();
> -	} else
> -#endif
> -		kuap_assert_locked();
> -
> -	booke_restore_dbcr0();
> -
> -	account_cpu_user_entry();
> -
> -	account_stolen_time();
> -
> -	/*
> -	 * This is not required for the syscall exit path, but makes the
> -	 * stack frame look nicer. If this was initialised in the first stack
> -	 * frame, or if the unwinder was taught the first stack frame always
> -	 * returns to user with IRQS_ENABLED, this store could be avoided!
> -	 */
> -	irq_soft_mask_regs_set_state(regs, IRQS_ENABLED);
> -
> -	/*
> -	 * If system call is called with TM active, set _TIF_RESTOREALL to
> -	 * prevent RFSCV being used to return to userspace, because POWER9
> -	 * TM implementation has problems with this instruction returning to
> -	 * transactional state. Final register values are not relevant because
> -	 * the transaction will be aborted upon return anyway. Or in the case
> -	 * of unsupported_scv SIGILL fault, the return state does not much
> -	 * matter because it's an edge case.
> -	 */
> -	if (IS_ENABLED(CONFIG_PPC_TRANSACTIONAL_MEM) &&
> -			unlikely(MSR_TM_TRANSACTIONAL(regs->msr)))
> -		set_bits(_TIF_RESTOREALL, &current_thread_info()->flags);
> -
> -	/*
> -	 * If the system call was made with a transaction active, doom it and
> -	 * return without performing the system call. Unless it was an
> -	 * unsupported scv vector, in which case it's treated like an illegal
> -	 * instruction.
> -	 */
> -#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> -	if (unlikely(MSR_TM_TRANSACTIONAL(regs->msr)) &&
> -	    !trap_is_unsupported_scv(regs)) {
> -		/* Enable TM in the kernel, and disable EE (for scv) */
> -		hard_irq_disable();
> -		mtmsr(mfmsr() | MSR_TM);
> -
> -		/* tabort, this dooms the transaction, nothing else */
> -		asm volatile(".long 0x7c00071d | ((%0) << 16)"
> -				:: "r"(TM_CAUSE_SYSCALL|TM_CAUSE_PERSISTENT));
> -
> -		/*
> -		 * Userspace will never see the return value. Execution will
> -		 * resume after the tbegin. of the aborted transaction with the
> -		 * checkpointed register state. A context switch could occur
> -		 * or signal delivered to the process before resuming the
> -		 * doomed transaction context, but that should all be handled
> -		 * as expected.
> -		 */
> -		return -ENOSYS;
> -	}
> -#endif // CONFIG_PPC_TRANSACTIONAL_MEM
> -
> -	local_irq_enable();
> -
> -	if (unlikely(read_thread_flags() & _TIF_SYSCALL_DOTRACE)) {
> -		if (unlikely(trap_is_unsupported_scv(regs))) {
> -			/* Unsupported scv vector */
> -			_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
> -			return regs->gpr[3];
> -		}
> -		/*
> -		 * We use the return value of do_syscall_trace_enter() as the
> -		 * syscall number. If the syscall was rejected for any reason
> -		 * do_syscall_trace_enter() returns an invalid syscall number
> -		 * and the test against NR_syscalls will fail and the return
> -		 * value to be used is in regs->gpr[3].
> -		 */
> -		r0 = do_syscall_trace_enter(regs);
> -		if (unlikely(r0 >= NR_syscalls))
> -			return regs->gpr[3];
> -
> -	} else if (unlikely(r0 >= NR_syscalls)) {
> +	if (unlikely(r0 >= NR_syscalls)) {
>   		if (unlikely(trap_is_unsupported_scv(regs))) {
>   			/* Unsupported scv vector */
>   			_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);



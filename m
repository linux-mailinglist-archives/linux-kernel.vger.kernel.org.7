Return-Path: <linux-kernel+bounces-861037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CCBBF19E8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F569189B1B4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4848F2C21F7;
	Mon, 20 Oct 2025 13:47:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6195731D750
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968021; cv=none; b=EbDK1lNuofjPKPOJXA2KT3yDY/tPaz0c+0t3wvbYPMEL2ITQSAnuLZKhy7++hdoaCsCPIUPI0igELx6G0oneuBTRH3w4MI7oUZh3tRHMgLl4NrhcSuaMuwThj/p56oO4q3IG9GlX9ihlL5SOFRNr8pKeQn6lroZkZqDZEAh7pn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968021; c=relaxed/simple;
	bh=cs1rJY31wiXgSBZ/nNZXT88feNRLR2NlxYEBuLZ9n/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qMSOfK+g0nG/p6mnrNIslCcO4DrThyt3BX2dCR4RAhcHNqlnocrclg/BqvZ5zDePtiYyDnvzsUr+gq8QOjnYwIWhI52ecftAesU52u48vQ5M9oWSZRLEuvMN+Hfb44dFYdbNRpm5cQX08dxK6O0Bnv9QfEFdRZUIiMfcx04jdyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 953D81063;
	Mon, 20 Oct 2025 06:46:50 -0700 (PDT)
Received: from [10.57.65.147] (unknown [10.57.65.147])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6384B3F66E;
	Mon, 20 Oct 2025 06:46:55 -0700 (PDT)
Message-ID: <8079f564-cec0-45e4-857b-74b2e630a9d5@arm.com>
Date: Mon, 20 Oct 2025 15:46:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] rseq: Make rseq work with protection keys
To: Dmitry Vyukov <dvyukov@google.com>, mathieu.desnoyers@efficios.com,
 peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 aruna.ramakrishna@oracle.com, elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Florian Weimer <fweimer@redhat.com>
References: <cover.1747817128.git.dvyukov@google.com>
 <138c29bd5f5a0a22270c9384ecc721c40b7d8fbd.1747817128.git.dvyukov@google.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <138c29bd5f5a0a22270c9384ecc721c40b7d8fbd.1747817128.git.dvyukov@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+Florian Weimer

On 21/05/2025 10:47, Dmitry Vyukov wrote:
> If an application registers rseq, and ever switches to another pkey
> protection (such that the rseq becomes inaccessible), then any
> context switch will cause failure in __rseq_handle_notify_resume()
> attempting to read/write struct rseq and/or rseq_cs. Since context
> switches are asynchronous and are outside of the application control
> (not part of the restricted code scope), temporarily switch to
> pkey value that allows access to the 0 (default) PKEY.
>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")
>
> ---
> Changes in v7:
>  - Added Mathieu's Reviewed-by
>
> Changes in v6:
>  - Added a comment to struct rseq with MPK rules
>
> Changes in v4:
>  - Added Fixes tag
>
> Changes in v3:
>  - simplify control flow to always enable access to 0 pkey
>
> Changes in v2:
>  - fixed typos and reworded the comment
> ---
>  include/uapi/linux/rseq.h |  4 ++++
>  kernel/rseq.c             | 11 +++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
> index c233aae5eac90..019fd248cf749 100644
> --- a/include/uapi/linux/rseq.h
> +++ b/include/uapi/linux/rseq.h
> @@ -58,6 +58,10 @@ struct rseq_cs {
>   * contained within a single cache-line.
>   *
>   * A single struct rseq per thread is allowed.
> + *
> + * If struct rseq or struct rseq_cs is used with Memory Protection Keys,
> + * then the assigned pkey should either be accessible whenever these structs
> + * are registered/installed, or they should be protected with pkey 0.

I think it's worth pointing out that every case of async uaccess seems
to be handled differently w.r.t. pkeys. Some interesting cases:

* During signal delivery, the pkey register is reset to permissive
before writing to the signal stack (this is the logic that patch 2
touches in fact). This is handled in the same way on x86 [1] and arm64 [2].

* AFAICT io_uring worker threads inherit the user thread's pkey register
on x86, since they are forked without setting PF_KTHREAD. OTOH on arm64
the pkey register is reset to the init value (RW access to pkey 0 only)
for all non-user threads [3].

* Now with this patch accesses to struct rseq are made with whatever the
pkey register is set to when the thread is interrupted + RW access for
pkey 0.

This is clearly a difficult problem, since no approach will satisfy all
users. I believe a new API would be desirable to allow users to
configure this; see the thread at [4] regarding signal handlers.

In any case, it seems best to ignore the value of the pkey register at
the point where the thread is interrupted, because userspace has no
control on that value and it could lead to spurious faults (depending on
when the interruption happens). For rseq, maybe the most logical option
would be to set the pkey register to permissive in
__rseq_handle_notify_resume(), because there is nothing sensible to
check at that point. Checking could be done at the point of registration
instead.

- Kevin

[1]
https://lore.kernel.org/lkml/20240802061318.2140081-1-aruna.ramakrishna@oracle.com/
[2]
https://lore.kernel.org/all/20241023150511.3923558-1-kevin.brodsky@arm.com/
[3] https://lore.kernel.org/all/20241001133618.1547996-2-joey.gouly@arm.com/
[4]
https://inbox.sourceware.org/libc-alpha/87jza5pxmx.fsf@oldenburg.str.redhat.com/

>   */
>  struct rseq {
>  	/*
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index b7a1ec327e811..88fc8cb789b3b 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/sched.h>
>  #include <linux/uaccess.h>
> +#include <linux/pkeys.h>
>  #include <linux/syscalls.h>
>  #include <linux/rseq.h>
>  #include <linux/types.h>
> @@ -424,11 +425,19 @@ static int rseq_ip_fixup(struct pt_regs *regs)
>  void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>  {
>  	struct task_struct *t = current;
> +	pkey_reg_t saved_pkey;
>  	int ret, sig;
>  
>  	if (unlikely(t->flags & PF_EXITING))
>  		return;
>  
> +	/*
> +	 * Enable access to the default (0) pkey in case the thread has
> +	 * currently disabled access to it and struct rseq/rseq_cs has
> +	 * 0 pkey assigned (the only supported value for now).
> +	 */
> +	saved_pkey = enable_zero_pkey_val();
> +
>  	/*
>  	 * regs is NULL if and only if the caller is in a syscall path.  Skip
>  	 * fixup and leave rseq_cs as is so that rseq_sycall() will detect and
> @@ -441,9 +450,11 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>  	}
>  	if (unlikely(rseq_update_cpu_node_id(t)))
>  		goto error;
> +	write_pkey_val(saved_pkey);
>  	return;
>  
>  error:
> +	write_pkey_val(saved_pkey);
>  	sig = ksig ? ksig->sig : 0;
>  	force_sigsegv(sig);
>  }


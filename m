Return-Path: <linux-kernel+bounces-873131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1334C132F7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15C1562F7C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E9D2BE047;
	Tue, 28 Oct 2025 06:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="k6LzNzlV"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9FD2BE033
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761633492; cv=none; b=VSsDcSxrPUE6JI5yM1WITMIILgjqjknUFbPhZHvpIuWkxzIAeuxuYLBAtlIiME38zxgaX1QAIQ68nXdUTqH83kCeKVVfZP0CGLbaffiVFt5CntIqbBzH4L3/KfMWkz2qWbS5IkLf2TvB9p6HKKrtkB4XZGWq43mS15bO9nSbaa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761633492; c=relaxed/simple;
	bh=MrJTQTtaJJ/C6NroKYM2cPnVIj4v47TwhZmWoG4dI2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cyY/PBrKlNC2qSSpGpsqlrkk1W3RE1nI/vgZCDWT+tcVuGt7lW7xGQGnK545DEMF0DR1kJyeDqj1IwJfdp3TTUN1J8aVP35RyIELVbSCjGjeVcu7XtfS6uIqMk074dBSzcTh2WzVxFoyXs/OjzTMVRzXMLrbAAVYU1C/fbVXX5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=k6LzNzlV; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761633481; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5+5/oH3gRtkklMreCNra6WAMe32tNr7/MSdCNrsy5tc=;
	b=k6LzNzlV4G6bPWh0IsdlAwTv7jM986/Ghfna9WeaUZtK1tUkEoYQBFKpK1zMsb/jn+Y3Z9eNS0s42Ob5kq3ZRfaYcVhm8h4zfA5vHEG0T0mEFbaxPbxCZkj4R5C1O96aOGYbU65S1X3vJTuwrnh9t/xyh6W2uT3Wbb1jtW33LFc=
Received: from 30.221.132.149(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WrAvdmY_1761633480 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 28 Oct 2025 14:38:00 +0800
Message-ID: <bfa92ecd-aef6-4712-b611-32caaf0ed993@linux.alibaba.com>
Date: Tue, 28 Oct 2025 14:37:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: mm: Add proper handling for HWPOISON faults
To: xueshuai@linux.alibaba.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250930082927.18971-1-tianruidong@linux.alibaba.com>
From: Ruidong Tian <tianruidong@linux.alibaba.com>
In-Reply-To: <20250930082927.18971-1-tianruidong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Gentle reminder on this patch. Thanks.

> From: winterddd <tianruidong@linux.alibaba.com>
>
> Currently, the RISC-V fault handler treats memory poisoning faults
> (VM_FAULT_HWPOISON and VM_FAULT_HWPOISON_LARGE) as a generic bus error
> (BUS_ADRERR). This is incorrect as it loses crucial information about
> the nature of the error.
>
> As for describe in [0], A SIGBUS is sent with the correct machine check
> error code (BUS_MCEERR_AR) and populates `si_addr_lsb`(log2 of the
> corruption page size) in siginfo while there is page fault with poison
> page.
>
> The logic is based on the existing arm64 implementation for handling
> HWPOISON.
>
> Testing
> --------------
> ras-tools[0] is used to test.
>
> ./einj_mem_uc -j -k single &
>
> echo 0x107943b400 > /sys/devices/system/memory/hard_offline_page
>
> echo trigger > ./trigger_start
>
> before apply this patch:
> 	signal 7 code 2 addr 0x7fff95bdc400
> after apply this patch:
> 	signal 7 code 4 addr 0x7fff95bdc400
>
> [0]: https://www.man7.org/linux/man-pages/man2/sigaction.2.html
> [1]: https://kernel.googlesource.com/pub/scm/linux/kernel/git/aegl/ras-tools/
>
> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
> ---
>   arch/riscv/include/asm/bug.h |  1 +
>   arch/riscv/kernel/traps.c    | 32 ++++++++++++++++++++++----------
>   arch/riscv/mm/fault.c        | 12 +++++++++++-
>   3 files changed, 34 insertions(+), 11 deletions(-)
>
> diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
> index 4c03e20ad11f..23711f2ffae3 100644
> --- a/arch/riscv/include/asm/bug.h
> +++ b/arch/riscv/include/asm/bug.h
> @@ -95,5 +95,6 @@ struct task_struct;
>   void __show_regs(struct pt_regs *regs);
>   void die(struct pt_regs *regs, const char *str);
>   void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr);
> +void riscv_force_sig_mceerr(int code, unsigned long addr, short lsb);
>   
>   #endif /* _ASM_RISCV_BUG_H */
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index d46347482509..17dad6f8d678 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -113,20 +113,32 @@ void die(struct pt_regs *regs, const char *str)
>   		make_task_dead(SIGSEGV);
>   }
>   
> -void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
> +static void riscv_show_signal(int signo, int code, unsigned long addr)
>   {
>   	struct task_struct *tsk = current;
> +	struct pt_regs *regs = task_pt_regs(tsk);
>   
> -	if (show_unhandled_signals && unhandled_signal(tsk, signo)
> -	    && printk_ratelimit()) {
> -		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x" REG_FMT,
> -			tsk->comm, task_pid_nr(tsk), signo, code, addr);
> -		print_vma_addr(KERN_CONT " in ", instruction_pointer(regs));
> -		pr_cont("\n");
> -		__show_regs(regs);
> -		dump_instr(KERN_INFO, regs);
> -	}
> +	if (!show_unhandled_signals || !unhandled_signal(tsk, signo)
> +	    || !printk_ratelimit())
> +		return;
> +
> +	pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x" REG_FMT,
> +		tsk->comm, task_pid_nr(tsk), signo, code, addr);
> +	print_vma_addr(KERN_CONT " in ", instruction_pointer(regs));
> +	pr_cont("\n");
> +	__show_regs(regs);
> +	dump_instr(KERN_INFO, regs);
> +}
>   
> +void riscv_force_sig_mceerr(int code, unsigned long addr, short lsb)
> +{
> +	riscv_show_signal(SIGBUS, code, addr);
> +	force_sig_mceerr(code, (void __user *)addr, lsb);
> +}
> +
> +void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
> +{
> +	riscv_show_signal(signo, code, addr);
>   	force_sig_fault(signo, code, (void __user *)addr);
>   }
>   
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 04ed6f8acae4..a6ccc4ab3a75 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -16,6 +16,7 @@
>   #include <linux/kprobes.h>
>   #include <linux/kfence.h>
>   #include <linux/entry-common.h>
> +#include <linux/hugetlb.h>
>   
>   #include <asm/ptrace.h>
>   #include <asm/tlbflush.h>
> @@ -128,10 +129,19 @@ static inline void mm_fault_error(struct pt_regs *regs, unsigned long addr, vm_f
>   		 */
>   		pagefault_out_of_memory();
>   		return;
> -	} else if (fault & (VM_FAULT_SIGBUS | VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE)) {
> +	} else if (fault & VM_FAULT_SIGBUS) {
>   		/* Kernel mode? Handle exceptions or die */
>   		do_trap(regs, SIGBUS, BUS_ADRERR, addr);
>   		return;
> +	} else if (fault & (VM_FAULT_HWPOISON_LARGE | VM_FAULT_HWPOISON)) {
> +		unsigned int lsb;
> +
> +		lsb = PAGE_SHIFT;
> +		if (fault & VM_FAULT_HWPOISON_LARGE)
> +			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
> +
> +		riscv_force_sig_mceerr(BUS_MCEERR_AR, addr, lsb);
> +		return;
>   	} else if (fault & VM_FAULT_SIGSEGV) {
>   		do_trap(regs, SIGSEGV, SEGV_MAPERR, addr);
>   		return;


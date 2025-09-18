Return-Path: <linux-kernel+bounces-815496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E12B56759
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 11:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724CE1896D69
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 09:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79E222D4E9;
	Sun, 14 Sep 2025 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rp4P//8W"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574D635968
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757840617; cv=none; b=Wz0RT6ierdVOTH1eHLvxrSgmmHhL7z9OU58ZuURa82ykOGVIh5KFLU3RD+/VoksOsUsufqNRnD2Q7Mx7ZmUPra9TvXtyOfgIiymM+LLK8NnSqDgeve3nZWEKOhhUHeQSrMyr2fpvHqvoZTtC6NW34sXJlcsH4uqdZ9roX93Ldgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757840617; c=relaxed/simple;
	bh=wVQ3COszV53GHFneXe2fUTE9D/Y9JQsXsjZ9Vy0t7sQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=DlVd1pXTIj7PrQU5vO/pXSAjXExHdmrRUgVy9H/J6ehxqwNkYiI0TTOM7gK8eauZlO83LRna9W9rhmnigcZZyS4GyDpYHX1okt8R09pjFZwP7LuRWKlydMPsJBS8YbnfXtKXhRsYjtcs5x7Hlqb5LMCVynyAmE7U/+Qem06fmqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rp4P//8W; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58E703Fo013144;
	Sun, 14 Sep 2025 09:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FcbN24
	5cf2PHg1U9jA4JXjqihqRuIVDI5eszvfiebNc=; b=Rp4P//8W8b1ZUUuHx3uMxU
	YpCrgNp0vVIyM7MzM0WcCHQSpSOMn9jwR8mOO82c4w4B0pyvnvPBcKidQuHaFi7P
	QJ1hpGo3Zs7cueu5/IEwJcUJB2SD1n7xHV5cyHRF4a34F8Bs80JnKAOYrcd5z+Dm
	dVtHDuGEYkWPEfh7Xira7Cr7TKhgmYZPKWyMhhyN53Uio9WVV/wbNfPEpQNrq8Gj
	BvMssgkE0otiDNCm5Kj7rXLZN6Yc0EI8hFM2jRbnN2fa0szDERFiN00NL3BGnaU8
	ioIkzWLBM981O8yFUmYiUssNe03yOV89u2yZRe6BrospxtzRXK+zYnXHJEDe/uIw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49504avkn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Sep 2025 09:02:37 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58E92anr005634;
	Sun, 14 Sep 2025 09:02:36 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49504avkmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Sep 2025 09:02:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58E8bqAs009367;
	Sun, 14 Sep 2025 09:02:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 495nn30x82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Sep 2025 09:02:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58E92VAP35127824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Sep 2025 09:02:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B43D20043;
	Sun, 14 Sep 2025 09:02:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6593620040;
	Sun, 14 Sep 2025 09:02:18 +0000 (GMT)
Received: from [9.61.95.215] (unknown [9.61.95.215])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 14 Sep 2025 09:02:17 +0000 (GMT)
Message-ID: <188f79ef-6ad4-4144-b73b-9e1090f4fc95@linux.ibm.com>
Date: Sun, 14 Sep 2025 14:32:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2 3/8] powerpc: introduce arch_enter_from_user_mode
To: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
References: <20250908210235.137300-2-mchauras@linux.ibm.com>
 <20250908210235.137300-5-mchauras@linux.ibm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, oleg@redhat.com, kees@kernel.org,
        luto@amacapital.net, wad@chromium.org, deller@gmx.de, ldv@strace.io,
        macro@orcam.me.uk, charlie@rivosinc.com, akpm@linux-foundation.org,
        bigeasy@linutronix.de, ankur.a.arora@oracle.com, naveen@kernel.org,
        thomas.weissschuh@linutronix.de, Jason@zx2c4.com, peterz@infradead.org,
        tglx@linutronix.de, namcao@linutronix.de, kan.liang@linux.intel.com,
        mingo@kernel.org, oliver.upton@linux.dev, mark.barnett@arm.com,
        atrajeev@linux.vnet.ibm.com, rppt@kernel.org, coltonlewis@google.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250908210235.137300-5-mchauras@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyMCBTYWx0ZWRfXydJfEtyOMTaR
 skO8TUcN423tHXlR0ByIjODRe5WErlqrZehFA3U4QIhD9rez7d/7UDOzQiCo3xmTPGnxQD/GiiS
 G5R9NEcQ9sTsSK6EM9fbdhANmad1K2f3lkkTOiW48irkZNXiKKOR7APpWbpn9SQfL+W6C5n1ebb
 xnMhHTJrDa4emUa7yPYxNOY/HDtEKzxLzqz07pqqK0EKV9cpDEbqAxGMSLovuvIH3qzffzg4qEU
 EAKCAARMeGb5knG6ajkBBRFFfsCVhgkvvHC8rS//z3nuRIfsWL5c96RfsFQ30uCDgP8geTD2mpb
 wcGupMVPh5DqgnfroO0PcU5lVrG6Vu8DUfvA2zQZZntJ878doQ7x+DaeuU1rm9SQ6tbcu9C9XM0
 bpr+N20x
X-Proofpoint-ORIG-GUID: rYR5iObNo_pb8F-yGfVXSaHmOtLJUpaB
X-Authority-Analysis: v=2.4 cv=dt/bC0g4 c=1 sm=1 tr=0 ts=68c684ad cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=lQVaECI8AZnJP4KHH_4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wtcnjzJoUQ4SEcnHk3MA937O09RA2Hid
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_03,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130020



On 9/9/25 2:32 AM, Mukesh Kumar Chaurasiya wrote:
> - Implement the hook arch_enter_from_user_mode for syscall entry.

nit: for generic syscall infra.

> - Move booke_load_dbcr0 from interrupt.c to interrupt.h
> 
> No functional change intended.
>
> Signed-off-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/entry-common.h | 96 +++++++++++++++++++++++++
>   arch/powerpc/include/asm/interrupt.h    | 23 ++++++
>   arch/powerpc/kernel/interrupt.c         | 22 ------
>   3 files changed, 119 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
> index 3af16d821d07e..49607292bf5a5 100644
> --- a/arch/powerpc/include/asm/entry-common.h
> +++ b/arch/powerpc/include/asm/entry-common.h
> @@ -5,7 +5,103 @@
>   
>   #ifdef CONFIG_GENERIC_IRQ_ENTRY
>   
> +#include <asm/cputime.h>
> +#include <asm/interrupt.h>
>   #include <asm/stacktrace.h>
> +#include <asm/tm.h>
> +
> +static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs)
> +{
> +	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
> +		BUG_ON(irq_soft_mask_return() != IRQS_ALL_DISABLED);
> +
> +	BUG_ON(regs_is_unrecoverable(regs));
> +	BUG_ON(!user_mode(regs));
> +	BUG_ON(regs_irqs_disabled(regs));
> +
> +#ifdef CONFIG_PPC_PKEY
> +	if (mmu_has_feature(MMU_FTR_PKEY)) {
> +		unsigned long amr, iamr;
> +		bool flush_needed = false;
> +		/*
> +		 * When entering from userspace we mostly have the AMR/IAMR
> +		 * different from kernel default values. Hence don't compare.
> +		 */
> +		amr = mfspr(SPRN_AMR);
> +		iamr = mfspr(SPRN_IAMR);
> +		regs->amr  = amr;
> +		regs->iamr = iamr;
> +		if (mmu_has_feature(MMU_FTR_KUAP)) {
> +			mtspr(SPRN_AMR, AMR_KUAP_BLOCKED);
> +			flush_needed = true;
> +		}
> +		if (mmu_has_feature(MMU_FTR_BOOK3S_KUEP)) {
> +			mtspr(SPRN_IAMR, AMR_KUEP_BLOCKED);
> +			flush_needed = true;
> +		}
> +		if (flush_needed)
> +			isync();
> +	} else
> +#endif
> +		kuap_assert_locked();
> +
> +	booke_restore_dbcr0();
> +
> +	account_cpu_user_entry();
> +
> +	account_stolen_time();
> +
> +	/*
> +	 * This is not required for the syscall exit path, but makes the
> +	 * stack frame look nicer. If this was initialised in the first stack
> +	 * frame, or if the unwinder was taught the first stack frame always
> +	 * returns to user with IRQS_ENABLED, this store could be avoided!
> +	 */
> +	irq_soft_mask_regs_set_state(regs, IRQS_ENABLED);
> +
> +	/*
> +	 * If system call is called with TM active, set _TIF_RESTOREALL to
> +	 * prevent RFSCV being used to return to userspace, because POWER9
> +	 * TM implementation has problems with this instruction returning to
> +	 * transactional state. Final register values are not relevant because
> +	 * the transaction will be aborted upon return anyway. Or in the case
> +	 * of unsupported_scv SIGILL fault, the return state does not much
> +	 * matter because it's an edge case.
> +	 */
> +	if (IS_ENABLED(CONFIG_PPC_TRANSACTIONAL_MEM) &&
> +			unlikely(MSR_TM_TRANSACTIONAL(regs->msr)))
> +		set_bits(_TIF_RESTOREALL, &current_thread_info()->flags);
> +
> +	/*
> +	 * If the system call was made with a transaction active, doom it and
> +	 * return without performing the system call. Unless it was an
> +	 * unsupported scv vector, in which case it's treated like an illegal
> +	 * instruction.
> +	 */
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +	if (unlikely(MSR_TM_TRANSACTIONAL(regs->msr)) &&
> +	    !trap_is_unsupported_scv(regs)) {
> +		/* Enable TM in the kernel, and disable EE (for scv) */
> +		hard_irq_disable();
> +		mtmsr(mfmsr() | MSR_TM);
> +
> +		/* tabort, this dooms the transaction, nothing else */
> +		asm volatile(".long 0x7c00071d | ((%0) << 16)"
> +				:: "r"(TM_CAUSE_SYSCALL|TM_CAUSE_PERSISTENT));
> +
> +		/*
> +		 * Userspace will never see the return value. Execution will
> +		 * resume after the tbegin. of the aborted transaction with the
> +		 * checkpointed register state. A context switch could occur
> +		 * or signal delivered to the process before resuming the
> +		 * doomed transaction context, but that should all be handled
> +		 * as expected.
> +		 */
> +		return;
> +	}
> +#endif // CONFIG_PPC_TRANSACTIONAL_MEM

nit: Better to follow standard comment practices.
		/* CONFIG_PPC_TRANSACTIONAL_MEM */

> +}
> +#define arch_enter_from_user_mode arch_enter_from_user_mode
>   
>   #endif /* CONFIG_GENERIC_IRQ_ENTRY */
>   #endif /* _ASM_PPC_ENTRY_COMMON_H */
> diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
> index 56bc8113b8cde..6edf064a0fea2 100644
> --- a/arch/powerpc/include/asm/interrupt.h
> +++ b/arch/powerpc/include/asm/interrupt.h
> @@ -138,6 +138,29 @@ static inline void nap_adjust_return(struct pt_regs *regs)
>   #endif
>   }
>   
> +static inline void booke_load_dbcr0(void)
> +{
> +#ifdef CONFIG_PPC_ADV_DEBUG_REGS
> +       unsigned long dbcr0 = current->thread.debug.dbcr0;
> +
> +       if (likely(!(dbcr0 & DBCR0_IDM)))
> +               return;
> +
> +       /*
> +        * Check to see if the dbcr0 register is set up to debug.
> +        * Use the internal debug mode bit to do this.
> +        */
> +       mtmsr(mfmsr() & ~MSR_DE);
> +       if (IS_ENABLED(CONFIG_PPC32)) {
> +               isync();
> +               global_dbcr0[smp_processor_id()] = mfspr(SPRN_DBCR0);
> +       }
> +       mtspr(SPRN_DBCR0, dbcr0);
> +       mtspr(SPRN_DBSR, -1);
> +#endif
> +}
> +

Please run checkpatch.pl --strict on the series and fix the simple
ones such as need to using tabs, spaces and alignments, extra lines etc.

> +
>   static inline void booke_restore_dbcr0(void)
>   {
>   #ifdef CONFIG_PPC_ADV_DEBUG_REGS
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> index 0d8fd47049a19..2a09ac5dabd62 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -78,28 +78,6 @@ static notrace __always_inline bool prep_irq_for_enabled_exit(bool restartable)
>   	return true;
>   }
>   
> -static notrace void booke_load_dbcr0(void)
> -{
> -#ifdef CONFIG_PPC_ADV_DEBUG_REGS
> -	unsigned long dbcr0 = current->thread.debug.dbcr0;
> -
> -	if (likely(!(dbcr0 & DBCR0_IDM)))
> -		return;
> -
> -	/*
> -	 * Check to see if the dbcr0 register is set up to debug.
> -	 * Use the internal debug mode bit to do this.
> -	 */
> -	mtmsr(mfmsr() & ~MSR_DE);
> -	if (IS_ENABLED(CONFIG_PPC32)) {
> -		isync();
> -		global_dbcr0[smp_processor_id()] = mfspr(SPRN_DBCR0);
> -	}
> -	mtspr(SPRN_DBCR0, dbcr0);
> -	mtspr(SPRN_DBSR, -1);
> -#endif
> -}
> -
>   static notrace void check_return_regs_valid(struct pt_regs *regs)
>   {
>   #ifdef CONFIG_PPC_BOOK3S_64



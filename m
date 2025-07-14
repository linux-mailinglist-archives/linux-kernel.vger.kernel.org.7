Return-Path: <linux-kernel+bounces-729299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ED6B0348F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 04:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FDC97A31CC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 02:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759691DE2DC;
	Mon, 14 Jul 2025 02:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TRNqCX/F"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C88156C40
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 02:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752460786; cv=none; b=NQrUStWOKgFvESsD8z8lJ1W7xgmS48RRIpH/fPORuFOWCAQjgdA9L341MFCiWSqHFaGVJJGi9+SBPVtxTZ1uO21/6fv4ZyHYP/S2jlMwdEk7NJ/uUosOfEMUe4K5075VKdaNQX4m55JAb7Kh90I5QZbnf8MCmZC3zLjTOYsodEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752460786; c=relaxed/simple;
	bh=m2dXi4yrfF6X94X2t/jx3/f47YwHusujEq4oLXi2g4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUbbYnOwST2iwTF6sTYGHROL8ThkLJ+6SAiCpdgpeAra4p2yKyA9E9d6RVlFhrvH7K9QcL9LIXxXP2kI2pekTzcnmTcSldD60pqVm03lPG8bM+9REv7s7wBaz5lmuEaDPX92A0NoZoCNEzDF8hXBHzJpL8lhK0g1OofkojrpF8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TRNqCX/F; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DAkgep001869;
	Mon, 14 Jul 2025 02:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Bf5S40
	48FcWc3B1FqRM2/R+3RGsbaTnBh6RLy9sZTSQ=; b=TRNqCX/FZWYJZxmUavldIZ
	mEQ/6StlwurHB26t9LR/6dGaWGtGBg4FCMWvxLN68J11QDNEVJx1CEmr0EMjbONN
	o/211JcJ2sMH12jEoBEg8sygCQNozTZUxEnrNW3hJnGCXz+aioyR3k9dOAJZkPN9
	0RrAFKnC4rJtdySytQL5/q238bBmiLnZfrE9YxM7pQNZthgGY4LARl560KQayGNv
	HA8xDH+KRTuLhFuMZkWbBzdKVUkNyOW8S01k4CxjK6+MMGIzcTvKw0b8PEBOWw0/
	Rv/b8hJKjEBNMM1H552Wn5hUUP6rTIMDRFsCBIjp/CR11pNUqwSzJQT9pLzQQflA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vamtje7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 02:39:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56E06sQW008957;
	Mon, 14 Jul 2025 02:39:21 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v3hmbw6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 02:39:21 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56E2dKSO32834240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 02:39:20 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A3E25805B;
	Mon, 14 Jul 2025 02:39:20 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 175095804B;
	Mon, 14 Jul 2025 02:39:15 +0000 (GMT)
Received: from [9.39.29.80] (unknown [9.39.29.80])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Jul 2025 02:39:14 +0000 (GMT)
Message-ID: <4e1d5259-ac93-4e22-8f3b-4683333e7928@linux.ibm.com>
Date: Mon, 14 Jul 2025 08:09:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] sched: preempt: Move dynamic keys into kernel/sched
To: Shrikanth Hegde <sshegde@linux.ibm.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc: tglx@linutronix.de, bigeasy@linutronix.de, vschneid@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com
References: <20250610075344.1379597-1-sshegde@linux.ibm.com>
 <20250610075344.1379597-2-sshegde@linux.ibm.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20250610075344.1379597-2-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fg443fqEHyJ7fvCV7VAhRgbFCw3LLA3H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAxMCBTYWx0ZWRfX+TeXTkJS6gxs vl8BNYc2HFs1bgGPKgEJog0BxqpnIF3QdIyMzdRZttnVKy4V3dNv+YHP74+d+5+akTrvNpOPGJl 0ISD7T1ezzZTLcI0GTGAYit5UBdRlUhQwyeru+buUZFymZ57K2iChFqhd1NtPW4MR0/JAtThAqf
 9dRuzI8lAatMqnN5iQHDrSHocwHxpl2E21fx9kXe9iXx9nZBFSfEUVuXQ3fOpQMEN67PFTT8chF gyvxZ+M+YkGxmHrRBTmAEv4kARUMHZFverZkLjA9NAG0tNWe/DEIPIWhQq0yhMu/TCQ/eYPZzs1 /XRqxf64PYUJ6QbExn7xsxdJj71n3YPNbC/cjAdodg/2/vWeyaFKnTi2/xEpSRV+4PijoLQ9Djt
 W3tXHMezCnUci97e3CG3rdjTAzrUaUfb5du1G1mS6AI0KqBVVjM/L6OuIXxhl97OxmOuW8ay
X-Proofpoint-ORIG-GUID: fg443fqEHyJ7fvCV7VAhRgbFCw3LLA3H
X-Authority-Analysis: v=2.4 cv=dNSmmPZb c=1 sm=1 tr=0 ts=68746dd9 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=zBvrq1Qxmeus1JvfWqgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1011 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140010



On 6/10/25 1:23 PM, Shrikanth Hegde wrote:
> Dynamic preemption can be static key or static call based.
> Static key is used to check kernel preemption depending on
> the current preemption model. i.e enable for lazy, full. 
> 
> Code is spread currently across entry/common.c, arm64 and latest being
> powerpc. There is little arch specific to it. For example, arm64,
> powerpc does the same thing. It is better to move it into kernel/sched 
> since preemption is more closely associated with scheduler.  
> 
> Plus, Any new arch that wants dynamic preemption enabled need to have 
> only HAVE_PREEMPT_DYNAMIC_KEY. 
> 
> This is more of code movement. No functional change. 
> 

For powerpc changes
Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>


> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  arch/arm64/include/asm/preempt.h   |  1 -
>  arch/arm64/kernel/entry-common.c   |  8 --------
>  arch/powerpc/include/asm/preempt.h | 16 ----------------
>  arch/powerpc/kernel/interrupt.c    |  4 ----
>  include/linux/entry-common.h       |  1 -
>  include/linux/sched.h              |  8 ++++++++
>  kernel/entry/common.c              |  1 -
>  kernel/sched/core.c                |  4 ++++
>  8 files changed, 12 insertions(+), 31 deletions(-)
>  delete mode 100644 arch/powerpc/include/asm/preempt.h
> 
> diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
> index 0159b625cc7f..a9348e65d75e 100644
> --- a/arch/arm64/include/asm/preempt.h
> +++ b/arch/arm64/include/asm/preempt.h
> @@ -87,7 +87,6 @@ void preempt_schedule_notrace(void);
>  
>  #ifdef CONFIG_PREEMPT_DYNAMIC
>  
> -DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
>  void dynamic_preempt_schedule(void);
>  #define __preempt_schedule()		dynamic_preempt_schedule()
>  void dynamic_preempt_schedule_notrace(void);
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index b260ddc4d3e9..b1c854fb4884 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -259,14 +259,6 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
>  		lockdep_hardirqs_on(CALLER_ADDR0);
>  }
>  
> -#ifdef CONFIG_PREEMPT_DYNAMIC
> -DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
> -#define need_irq_preemption() \
> -	(static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
> -#else
> -#define need_irq_preemption()	(IS_ENABLED(CONFIG_PREEMPTION))
> -#endif
> -
>  static void __sched arm64_preempt_schedule_irq(void)
>  {
>  	if (!need_irq_preemption())
> diff --git a/arch/powerpc/include/asm/preempt.h b/arch/powerpc/include/asm/preempt.h
> deleted file mode 100644
> index 000e2b9681f3..000000000000
> --- a/arch/powerpc/include/asm/preempt.h
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __ASM_POWERPC_PREEMPT_H
> -#define __ASM_POWERPC_PREEMPT_H
> -
> -#include <asm-generic/preempt.h>
> -
> -#if defined(CONFIG_PREEMPT_DYNAMIC)
> -#include <linux/jump_label.h>
> -DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
> -#define need_irq_preemption() \
> -	(static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
> -#else
> -#define need_irq_preemption()   (IS_ENABLED(CONFIG_PREEMPTION))
> -#endif
> -
> -#endif /* __ASM_POWERPC_PREEMPT_H */
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> index e0c681d0b076..4d62d785ad26 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -25,10 +25,6 @@
>  unsigned long global_dbcr0[NR_CPUS];
>  #endif
>  
> -#if defined(CONFIG_PREEMPT_DYNAMIC)
> -DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
> -#endif
> -
>  #ifdef CONFIG_PPC_BOOK3S_64
>  DEFINE_STATIC_KEY_FALSE(interrupt_exit_not_reentrant);
>  static inline bool exit_must_hard_disable(void)
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index f94f3fdf15fc..8624faa1f8b9 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -549,7 +549,6 @@ void raw_irqentry_exit_cond_resched(void);
>  DECLARE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
>  #define irqentry_exit_cond_resched()	static_call(irqentry_exit_cond_resched)()
>  #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
> -DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
>  void dynamic_irqentry_exit_cond_resched(void);
>  #define irqentry_exit_cond_resched()	dynamic_irqentry_exit_cond_resched()
>  #endif
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 45e5953b8f32..ebd230382027 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2115,6 +2115,14 @@ static inline int _cond_resched(void)
>  
>  #endif /* !CONFIG_PREEMPTION || CONFIG_PREEMPT_DYNAMIC */
>  
> +#if defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
> +DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
> +#define need_irq_preemption() \
> +	(static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
> +#else
> +#define need_irq_preemption()   (IS_ENABLED(CONFIG_PREEMPTION))
> +#endif
> +
>  #define cond_resched() ({			\
>  	__might_resched(__FILE__, __LINE__, 0);	\
>  	_cond_resched();			\
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index a8dd1f27417c..b8ffd7127338 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -268,7 +268,6 @@ void raw_irqentry_exit_cond_resched(void)
>  #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
>  DEFINE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
>  #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
> -DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
>  void dynamic_irqentry_exit_cond_resched(void)
>  {
>  	if (!static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 62b3416f5e43..6af2bab187cb 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7083,6 +7083,10 @@ EXPORT_SYMBOL(dynamic_preempt_schedule_notrace);
>  
>  #endif /* CONFIG_PREEMPTION */
>  
> +#if defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
> +DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
> +#endif
> +
>  /*
>   * This is the entry point to schedule() from kernel preemption
>   * off of IRQ context.



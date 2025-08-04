Return-Path: <linux-kernel+bounces-754759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B47B19BE7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF5563AF4DD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 07:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A724232386;
	Mon,  4 Aug 2025 07:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D7lRoiFZ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3A71E1E1B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 07:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754291239; cv=none; b=of8MXY9RaJyoJh8OmUDfMGtlxo/BQ7YYowegII2wqpTOUxkX2RG/pIE19NSZ2nbwMzAbFiUALBppJc5/OE2cx190X0HnMYT5yw81qU4Kxi+rv0S73ggGat/s+PvmeWo8t3pajiSKOVA9YsEi+CkGzxDXE4a+Hl0NRoRgkThBacI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754291239; c=relaxed/simple;
	bh=9BUw3mV36c9E7LBVBWZNxe3FYeTlJmbJveOmwI6G6E8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Oo2GTpNs+djEASNRIvu9c+abzuIztln0jj4e+CKGz+c7ww2+xsVdWbVT+oi81QOuIslaEJN3SxpkkqfHC2rABlmLACR+FjDArGdNfx+HPVm9yfaPTpyBDBcOyD3PDSlgVF3o2JSZf+J5Mn+4XVT+tQYHFqy7vPOeEd59gKSBHHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D7lRoiFZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573KZ4Go014258;
	Mon, 4 Aug 2025 07:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hbx5cm
	0roqXtquYBVZ+e0DsbPst/VZYgFQqU/B+J1Ko=; b=D7lRoiFZVHi659VgAm7R6T
	nfEKEOm93ZZMGAkR/K+rbq8ff0shV3V6AQoxULNfa8GC4x6ryeqFzDuC8F8H/aiW
	us/4ash6bNELW49+elPILwF0N77NTlsFoCHBAI0w6W6YoPSTkOeVm0hJMO+NG3Yz
	KKgm9adPvydH8sV9Y+5OvH7Dn1ZbzkjzYV9KoJ+gCkUh1ocyxY/Ef6fjdDqmBFv4
	ePUspPFPYhuTyW/QZH6BY69fof/pF92k0850ZrWQqqbctZyEdQwnxp/9rfoK53Ct
	BJ2Ha2L7PNAgkMK+LGbMSHcnDKZlfTGt6qKt3F8qdpoClxgL2NgTSy0wiSneMXQQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489a6d7dd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 07:06:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5742kC8q004453;
	Mon, 4 Aug 2025 07:06:35 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 489yq2c9vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 07:06:35 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57476XdJ25821798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Aug 2025 07:06:33 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C4C258052;
	Mon,  4 Aug 2025 07:06:33 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BCC85805D;
	Mon,  4 Aug 2025 07:06:30 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.249.29])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  4 Aug 2025 07:06:30 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v2 1/1] sched: preempt: Move dynamic keys into
 kernel/sched
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <20250716094745.2232041-2-sshegde@linux.ibm.com>
Date: Mon, 4 Aug 2025 12:36:17 +0530
Cc: mingo@redhat.com, Peter Zijlstra <peterz@infradead.org>,
        tglx@linutronix.de, maddy@linux.ibm.com, will@kernel.org,
        mark.rutland@arm.com, bigeasy@linutronix.de,
        LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6A55B96B-C9B6-46CE-A17F-1E580DFF8300@linux.ibm.com>
References: <20250716094745.2232041-1-sshegde@linux.ibm.com>
 <20250716094745.2232041-2-sshegde@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAzNSBTYWx0ZWRfX3IRmwP5KFR+/
 4e7WFzYF71NXQyTNuOi2ul9hoJxrJxAU3eUMvsBCRNx7RouoqK6jImMGa+bTMt3ghwG/10U+wKP
 Il78SftoJUN51615ykQVfSWR8gfceiSj6ELO53UPtLfeqNvdIMoVAHSJ5683eTuz6b5brQNKy4s
 zBY0Bqx551/awElS5sUts+5m0K0CdDLrzK3GIEA7lBJBaUfLZRyaUuWTwob2HJHY4mphzwtwwXU
 W9sTBM6j3hwRXtfDAxFTwpdQGBs5zcrea1OF36bESSbpE+nfJtv3y8RnFHc3mJDSrRs1d0Bj+0p
 j7P0vcy+h8p58SULkEZhEt/5oWR4B1SY4d/i4CLoC0+bITtNs008tGLcOHVL4umGzrB8grSn7YJ
 YSnK7TXGjFpWWc3wqrDRhDdt0+Dthh12bmIHBDBqdIbdTmLDEr/iNuY/7oww8TrgabnyW2vw
X-Authority-Analysis: v=2.4 cv=Qp9e3Uyd c=1 sm=1 tr=0 ts=68905bfc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8
 a=VwQbUJbxAAAA:8 a=M5oXtrbImnzHQzFBRoEA:9 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: GnowiQeBevoYFVwPh9nJAdbpsxrvdkfB
X-Proofpoint-GUID: GnowiQeBevoYFVwPh9nJAdbpsxrvdkfB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040035



> On 16 Jul 2025, at 3:17=E2=80=AFPM, Shrikanth Hegde =
<sshegde@linux.ibm.com> wrote:
>=20
> Dynamic preemption can be static key or static call based.
> Static key is used to check kernel preemption depending on
> the current preemption model. i.e enable for lazy, full.=20
>=20
> Code is currently spread across entry/common.c, arm64 and latest being
> powerpc. There is little arch specific to it. arm64, powerpc have the
> same code. It is better to move it into kernel/sched since preemption=20=

> is more closely associated with scheduler. =20
>=20
> Plus, Any new arch that wants dynamic preemption enabled need to have=20=

> only HAVE_PREEMPT_DYNAMIC_KEY.=20
>=20
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Will Deacon <will@kernel.org>
> Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> ---
> arch/arm64/include/asm/preempt.h   |  1 -
> arch/arm64/kernel/entry-common.c   |  8 --------
> arch/powerpc/include/asm/preempt.h | 16 ----------------
> arch/powerpc/kernel/interrupt.c    |  4 ----
> include/linux/irq-entry-common.h   |  1 -
> include/linux/sched.h              |  8 ++++++++
> kernel/entry/common.c              |  1 -
> kernel/sched/core.c                |  4 ++++
> 8 files changed, 12 insertions(+), 31 deletions(-)
> delete mode 100644 arch/powerpc/include/asm/preempt.h
>=20
> diff --git a/arch/arm64/include/asm/preempt.h =
b/arch/arm64/include/asm/preempt.h
> index 0159b625cc7f..a9348e65d75e 100644
> --- a/arch/arm64/include/asm/preempt.h
> +++ b/arch/arm64/include/asm/preempt.h
> @@ -87,7 +87,6 @@ void preempt_schedule_notrace(void);
>=20
> #ifdef CONFIG_PREEMPT_DYNAMIC
>=20
> -DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
> void dynamic_preempt_schedule(void);
> #define __preempt_schedule() dynamic_preempt_schedule()
> void dynamic_preempt_schedule_notrace(void);
> diff --git a/arch/arm64/kernel/entry-common.c =
b/arch/arm64/kernel/entry-common.c
> index 7c1970b341b8..f4985ae4d8a9 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -259,14 +259,6 @@ static void noinstr arm64_exit_el1_dbg(struct =
pt_regs *regs)
> lockdep_hardirqs_on(CALLER_ADDR0);
> }
>=20
> -#ifdef CONFIG_PREEMPT_DYNAMIC
> -DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
> -#define need_irq_preemption() \
> - (static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
> -#else
> -#define need_irq_preemption() (IS_ENABLED(CONFIG_PREEMPTION))
> -#endif
> -
> static void __sched arm64_preempt_schedule_irq(void)
> {
> if (!need_irq_preemption())
> diff --git a/arch/powerpc/include/asm/preempt.h =
b/arch/powerpc/include/asm/preempt.h
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
> - (static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
> -#else
> -#define need_irq_preemption()   (IS_ENABLED(CONFIG_PREEMPTION))
> -#endif
> -
> -#endif /* __ASM_POWERPC_PREEMPT_H */
> diff --git a/arch/powerpc/kernel/interrupt.c =
b/arch/powerpc/kernel/interrupt.c
> index e0c681d0b076..4d62d785ad26 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -25,10 +25,6 @@
> unsigned long global_dbcr0[NR_CPUS];
> #endif
>=20
> -#if defined(CONFIG_PREEMPT_DYNAMIC)
> -DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
> -#endif
> -
> #ifdef CONFIG_PPC_BOOK3S_64
> DEFINE_STATIC_KEY_FALSE(interrupt_exit_not_reentrant);
> static inline bool exit_must_hard_disable(void)
> diff --git a/include/linux/irq-entry-common.h =
b/include/linux/irq-entry-common.h
> index 8af374331900..5bb752f0a69c 100644
> --- a/include/linux/irq-entry-common.h
> +++ b/include/linux/irq-entry-common.h
> @@ -343,7 +343,6 @@ void raw_irqentry_exit_cond_resched(void);
> DECLARE_STATIC_CALL(irqentry_exit_cond_resched, =
raw_irqentry_exit_cond_resched);
> #define irqentry_exit_cond_resched() =
static_call(irqentry_exit_cond_resched)()
> #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
> -DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
> void dynamic_irqentry_exit_cond_resched(void);
> #define irqentry_exit_cond_resched() =
dynamic_irqentry_exit_cond_resched()
> #endif
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 54a91261e99b..df9a87de0f83 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2076,6 +2076,14 @@ static inline int _cond_resched(void)
>=20
> #endif /* !CONFIG_PREEMPTION || CONFIG_PREEMPT_DYNAMIC */
>=20
> +#if defined(CONFIG_PREEMPT_DYNAMIC) && =
defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
> +DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
> +#define need_irq_preemption() \
> + (static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
> +#else
> +#define need_irq_preemption()   (IS_ENABLED(CONFIG_PREEMPTION))
> +#endif
> +
> #define cond_resched() ({ \
> __might_resched(__FILE__, __LINE__, 0); \
> _cond_resched(); \
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index b82032777310..0ffe3d5a6c44 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -157,7 +157,6 @@ void raw_irqentry_exit_cond_resched(void)
> #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
> DEFINE_STATIC_CALL(irqentry_exit_cond_resched, =
raw_irqentry_exit_cond_resched);
> #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
> -DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
> void dynamic_irqentry_exit_cond_resched(void)
> {
> if (!static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c73c9ca6ca01..8425008c99f1 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6999,6 +6999,10 @@ =
EXPORT_SYMBOL(dynamic_preempt_schedule_notrace);
>=20
> #endif /* CONFIG_PREEMPTION */
>=20
> +#if defined(CONFIG_PREEMPT_DYNAMIC) && =
defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
> +DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
> +#endif
> +
> /*
>  * This is the entry point to schedule() from kernel preemption
>  * off of IRQ context.
> --=20
> 2.43.0
>=20



<Resending to the right thread>


Tested this patch, by applying on top of mainline kernel.=20

Dynamically changed the preemption modes, and its working as expected. =
Hence,

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Regards,
Venkat.



Return-Path: <linux-kernel+bounces-752807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 156EDB17B2A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 04:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42CE625D00
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABE94D8D1;
	Fri,  1 Aug 2025 02:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QnfJwc5c"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E2A23A6
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 02:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754014740; cv=none; b=EsY6dINNmu7elX+4mz+zCQaigtmPwE67TVrDKAXNiENa+dY/5S5TUXniaolf4CYNHR5NW73FoXE7EKwCKGhWXYQRescsWZ/k8m6CK4gAuUYPqScffNYJgsuMrJv2Ke7khH16zLec0jub17Xqf3BqyJZyXCU2yBLYTNPINZzddAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754014740; c=relaxed/simple;
	bh=9CAIk4YynhTdKbQQO/4QN+Aq2C8QWiyb7onjY4q+YXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oaJp+lDqcqkcBJiXyc/4l9n8lXla+D4KGlnmSd/yDaYvsfbGbUdxX9iXIKVBlrDBJoM2Pu0WAFrfqJ0CoCgc3vyP0JdXc/dTYb5DEGU/J3CZMxly2Plpa0kZIdgA/NhBs0ZqtGVabvLPzPbMea9n4yBVLYTAySUOXw7do+8b5zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QnfJwc5c; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VJP4Kt027335;
	Fri, 1 Aug 2025 02:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=e2lja3
	zJV3u1pc8NuocQtD2F1vBjJxDFrQxZRN/ifSg=; b=QnfJwc5cWVp2sM05u32KCe
	pY6PEFgBPrBvb7fR32PNtLF/YhHzv5XfYJAuHMTIt2sbMAh/AEGayWv3d5vtCDGa
	I07cG2SwTqMTP43ohbWpHTvB69N73QGwz6tKkBGjibhb6YN0QqxaPb6TEvKgdzNj
	CRK6YGpyWu7kuOi5eQmHkddWVSkZh3B1uHBpvnmdV0mD1LK1mtXxMhaxPF0i6/gD
	7TXHAQF3VCmfNdOlu2GKTDI9kqBBjTvAZ5jDB4FA5WM1hIqn+ubDj1Qo4anCJoMp
	b5CnL2/k+3yoydmADRJ1Dh5N2otl6GIZXukAeagMwFwNdxnRmFnDNmNbR1oGI7mg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 487bu0bq94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 02:18:41 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5712IfEw024622;
	Fri, 1 Aug 2025 02:18:41 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 487bu0bq91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 02:18:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5711tPop028748;
	Fri, 1 Aug 2025 02:18:40 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 485c22y45k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 02:18:40 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5712IcLN31850790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Aug 2025 02:18:38 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96CEF58052;
	Fri,  1 Aug 2025 02:18:38 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD06758056;
	Fri,  1 Aug 2025 02:18:35 +0000 (GMT)
Received: from [9.39.19.108] (unknown [9.39.19.108])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Aug 2025 02:18:35 +0000 (GMT)
Message-ID: <a4063a20-7d82-4013-b7cb-b3fd059cc8ba@linux.ibm.com>
Date: Fri, 1 Aug 2025 07:48:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/mm: Switch MMU context on hash MMU if SLB preload
 cache is aged
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Vishal Chourasia
 <vishalc@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
References: <20250731161027.966196-1-donettom@linux.ibm.com>
 <87y0s4qlj4.fsf@gmail.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <87y0s4qlj4.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZNPXmW7b c=1 sm=1 tr=0 ts=688c2402 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=ut2G4UNdmwT7rfPp6ikA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xBrv8MRvzwLSYLuPSrBDSA4GC-oPwwe6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDAxNyBTYWx0ZWRfXyY0U+SgR+qPy
 T9Zu/CpnPk7PGZtdGiZjKU5cUFJXwXSOr5DXw6eR1P+fDl4KiJ/0QU73OydN+FwFWoGxAY9MbMZ
 cf6yF+uudYEbrTgvbCLL3W1WXCeXxWDrr1RGrzE9sroAuh9/VXpYeNwQ3rawE18Zrh6i7sPIrKh
 B6j+81IgrYY0jGWx2z0cFBnk1MYMOV7uPlBQjdqizIDY8kRWwRrN7IXJgIjmMbC8QLnI6qo6CAt
 LMCgcTfFuN0lfhTx/LfFtI7ingMwqDe1G2zAgPT3IQ4uabczG7lHbKCsQEqsFnR8Wz7SLV0UCss
 19FwMbUYnxTa3+p9KnUhwAyyenjHe4ofCgIyskjzjB62CGBRIFCU94/P4hi7WXZ+1KjvzUU5jGm
 v1p5gDTAn7Kj/gdFp+eckP7291RnYcSzezJcDGfzbhe3hiDhhFcLKve4n5URcFZhTw0yKmu1
X-Proofpoint-GUID: eZEJzFeF5ue7800Ow0s0Wbo9yPshit33
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_04,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010017

Hi Ritesh

On 7/31/25 11:40 PM, Ritesh Harjani (IBM) wrote:
> Donet Tom <donettom@linux.ibm.com> writes:
>
>> On systems using the hash MMU, there is a software SLB preload cache that
>> mirrors the entries loaded into the hardware SLB buffer. This preload
>> cache is subject to periodic eviction — typically after every 256 context
>> switches — to remove old entry.
>>
>> Currently, the kernel skips the MMU context switch in switch_mm_irqs_off()
>> if the prev and next mm_struct are the same, as an optimization. However,
>> this behavior can lead to problems on hash MMU systems.
>>
> Let's also add detailed flow of events, as this was not really an easy
> problem to catch.
>
> CPU 0                                   CPU 1
>
> Process P
> exec                                    swapper/1
>   load_elf_binary
>    begin_new_exc
>      activate_mm
>       switch_mm_irqs_off
>        switch_mmu_context
>         switch_slb
>         /*
>          * This invalidates all the
>          * entries in the HW and setup
>          * the new HW SLB entries as per
>          * the preload cache.
>          */
> switch_switch
> sched_migrate_task migrates process P to cpu-1
>
> Process swapper/0                       context switch (to process P)
> (uses mm_struct of Process P)           switch_mm_irqs_off()
>                                           switch_slb
>                                             load_slb++
>                                              /*
>                                              * load_slb becomes 0 here
>                                              * and we evict an entry from
>                                              * the preload cache with
>                                              * preload_age(). We still
>                                              * keep HW SLB and preload
>                                              * cache in sync, that is
>                                              * because all HW SLB entries
>                                              * anyways gets evicted in
>                                              * switch_slb during SLBIA.
>                                              * We then only add those
>                                              * entries back in HW SLB,
>                                              * which are currently
>                                              * present in preload_cache
>                                              * (after eviction).
>                                              */
>                                          load_elf_binary continues...
>                                           setup_new_exec()
>                                            slb_setup_new_exec()
>
>                                          sched_switch event
>                                          sched_migrate_task migrates
>                                          process P to cpu-0
>
> context_switch from swapper/0 to Process P
>   switch_mm_irqs_off()
>    /*
>     * Since both prev and next mm struct are same we don't call
>     * switch_mmu_context(). This will cause the HW SLB and SW preload
>     * cache to go out of sync in preload_new_slb_context. Because there
>     * was an SLB entry which was evicted from both HW and preload cache
>     * on cpu-1. Now later in preload_new_slb_context(), when we will try
>     * to add the same preload entry again, we will add this to the SW
>     * preload cache and then will add it to the HW SLB. Since on cpu-0
>     * this entry was never invalidated, hence adding this entry to the HW
>     * SLB will cause a SLB multi-hit error.
>     */
> load_elf_binary continues...
>   START_THREAD
>    start_thread
>     preload_new_slb_context
>     /*
>      * This tries to add a new EA to preload cache which was earlier
>      * evicted from both cpu-1 HW SLB and preload cache. This caused the
>      * HW SLB of cpu-0 to go out of sync with the SW preload cache. The
>      * reason for this was, that when we context switched back on CPU-0,
>      * we should have ideally called switch_mmu_context() which will
>      * bring bring the HW SLB entries on CPU-0 in sync with SW preload cache
>      * entries by setting up the mmu context properly. But we didn't do
>      * that since the prev mm_struct running on cpu-0 was same as the
>      * next mm_struct (which is true for swapper / kernel threads). So
>      * now when we try to add this new entry into the HW SLB of cpu-0,
>      * we hit a SLB multi-hit error.
>      */
>
> WARNING: CPU: 0 PID: 1810970 at arch/powerpc/mm/book3s64/slb.c:62 assert_slb_presence+0x2c/0x50(48 results) 02:47:29 [20157/42149]
> Modules linked in:
> CPU: 0 UID: 0 PID: 1810970 Comm: dd Not tainted 6.16.0-rc3-dirty #12 VOLUNTARY
> Hardware name: IBM pSeries (emulated by qemu) POWER8 (architected) 0x4d0200 0xf000004 of:SLOF,HEAD hv:linux,kvm pSeries
> NIP:  c00000000015426c LR: c0000000001543b4 CTR: 0000000000000000
> REGS: c0000000497c77e0 TRAP: 0700   Not tainted  (6.16.0-rc3-dirty)
> MSR:  8000000002823033 <SF,VEC,VSX,FP,ME,IR,DR,RI,LE>  CR: 28888482  XER: 00000000
> CFAR: c0000000001543b0 IRQMASK: 3
> <...>
> NIP [c00000000015426c] assert_slb_presence+0x2c/0x50
> LR [c0000000001543b4] slb_insert_entry+0x124/0x390
> Call Trace:
>    0x7fffceb5ffff (unreliable)
>    preload_new_slb_context+0x100/0x1a0
>    start_thread+0x26c/0x420
>    load_elf_binary+0x1b04/0x1c40
>    bprm_execve+0x358/0x680
>    do_execveat_common+0x1f8/0x240
>    sys_execve+0x58/0x70
>    system_call_exception+0x114/0x300
>    system_call_common+0x160/0x2c4
>
>
>> Consider the following scenario: a process is running on CPU A and gets
>> context-switched to CPU B. During this time, one of its SLB preload cache
>> entries is evicted. Later, the process is rescheduled on CPU A, which was
>> running swapper in the meantime, using the same mm_struct. Because
>> prev == next, the kernel skips the MMU context switch. As a result, the
>> hardware SLB buffer still contains the entry, but the software preload
>> cache does not.
>>
>> The absence of the entry in the preload cache causes it to attempt to
>> reload the SLB. However, since the entry is already present in the hardware
>> SLB, this leads to a SLB multi-hit error.
>>
> Can we use the detailed commit msg from above instead of above two paragraphs.
> It is easier to visualize and document if we have it that way.


Yes, that makes sense — I’ll add this and send V2


>
>
>> To fix this issue, we add a code change to always switch the MMU context on
>> hash MMU if the SLB preload cache has aged. With this change, the
>> SLB multi-hit error no longer occurs.
>>
>> Fixes: 5434ae74629a ("powerpc/64s/hash: Add a SLB preload cache")
> CC: stable@vger.kernel.org
>
> Otherwise LGTM.


Thank you.


>
>> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> ---
>>   arch/powerpc/mm/book3s64/slb.c | 2 +-
>>   arch/powerpc/mm/mmu_context.c  | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/book3s64/slb.c b/arch/powerpc/mm/book3s64/slb.c
>> index 6b783552403c..08daac3f978c 100644
>> --- a/arch/powerpc/mm/book3s64/slb.c
>> +++ b/arch/powerpc/mm/book3s64/slb.c
>> @@ -509,7 +509,7 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
>>   	 * SLB preload cache.
>>   	 */
>>   	tsk->thread.load_slb++;
>> -	if (!tsk->thread.load_slb) {
>> +	if (tsk->thread.load_slb == U8_MAX) {
>>   		unsigned long pc = KSTK_EIP(tsk);
>>   
>>   		preload_age(ti);
>> diff --git a/arch/powerpc/mm/mmu_context.c b/arch/powerpc/mm/mmu_context.c
>> index 3e3af29b4523..d7b9ac8c9971 100644
>> --- a/arch/powerpc/mm/mmu_context.c
>> +++ b/arch/powerpc/mm/mmu_context.c
>> @@ -84,7 +84,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>>   	switch_mm_pgdir(tsk, next);
>>   
>>   	/* Nothing else to do if we aren't actually switching */
>> -	if (prev == next)
>> +	if ((prev == next) && (tsk->thread.load_slb != U8_MAX))
>>   		return;
>>   
>>   	/*
>> -- 
>> 2.50.1


Return-Path: <linux-kernel+bounces-822176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E8CB8339A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742552A6125
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C092DECA3;
	Thu, 18 Sep 2025 06:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jqFLCJum"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1CA208A7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178617; cv=none; b=G/abZB5JZJWG6n2zfJCHI9E3B1SaaLQ0Vu/CoGaicIclZvGP/qap77w8Wg2xrsN781YpkxeU7qB9IHUf8H5e/xQNyLLlckcuG8HpqsTyfOaCf8LFa9eT7YJ948ha2GCUFAEZ+/xUmj0MCZvtci2LCSX+dmuOI5msHr4CG71fPkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178617; c=relaxed/simple;
	bh=AUnggU8SIwRLVQWpvVp5rs+tK6mEbR8WSnsx2HPE3yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ICeo4E72D0OYtZkS2J64xA2I+Nl+aUFxMKcq3qRIh1kRC8ZQKNBPgJxuPZk9UXYpSWzH66nbchNKGw/CwXM58eicYEuAZAiPwZy3S1If43pPNh78iBtIpWUNFR3Hm5Q21pI/gEPxB1m77oPDhTJJj+FnwNibadDrdfQQcS1NwfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jqFLCJum; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I5vad7012241;
	Thu, 18 Sep 2025 06:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DchfFO
	ibIA/BQXU5pOmwyka3D2iVlhZ/ewgmfO7fqmQ=; b=jqFLCJumqFYQwXRKysMlUD
	WWS9B2Ht4KlSsQ7yRmuaxpmltQKg2I9lZJJ3wstXFwoMUfa3nefVFAn5OhqhsAWB
	DfV3AnWg7W7sTgdXSA6xwmnPIOxNWyUTg0S5YFxy01/oKn427RPashdWjV/KUItp
	yzOI8mc+WYfu0Tzy4YYjz678sd8bdbvm4m4p52JZ7ZKxt/LfXtMkf525mbLUG0ED
	Xvcw3jfys1IR+wj2holSKEbYw/ob9R0W1tnRhwaXURdbFS+FY8gWV4f07anBmYle
	R7qYSm6TBgCLCIHUJaInz6stfnKyIgLICRVLFBnVBgOkilGXU9roQG3KBWaobJyg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4j8jhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 06:56:11 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58I6uAWV022879;
	Thu, 18 Sep 2025 06:56:10 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4j8jhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 06:56:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58I4lFpc005963;
	Thu, 18 Sep 2025 06:56:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 495jxudjhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 06:56:09 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58I6u5xD51052894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 06:56:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BA8A20043;
	Thu, 18 Sep 2025 06:56:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12DBD20040;
	Thu, 18 Sep 2025 06:55:57 +0000 (GMT)
Received: from [9.109.209.61] (unknown [9.109.209.61])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Sep 2025 06:55:56 +0000 (GMT)
Message-ID: <6a6de5ca-d105-466b-b44a-8bf084f2a924@linux.ibm.com>
Date: Thu, 18 Sep 2025 12:25:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2 7/8] powerpc: Enable IRQ generic entry/exit path.
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
        Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc: oleg@redhat.com, kees@kernel.org, luto@amacapital.net, wad@chromium.org,
        deller@gmx.de, ldv@strace.io, macro@orcam.me.uk, charlie@rivosinc.com,
        akpm@linux-foundation.org, bigeasy@linutronix.de,
        ankur.a.arora@oracle.com, naveen@kernel.org,
        thomas.weissschuh@linutronix.de, Jason@zx2c4.com, peterz@infradead.org,
        tglx@linutronix.de, namcao@linutronix.de, kan.liang@linux.intel.com,
        mingo@kernel.org, oliver.upton@linux.dev, mark.barnett@arm.com,
        atrajeev@linux.vnet.ibm.com, rppt@kernel.org, coltonlewis@google.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250908210235.137300-2-mchauras@linux.ibm.com>
 <20250908210235.137300-10-mchauras@linux.ibm.com>
 <589f259e-1db9-4ec2-accc-b27966d09a3e@linux.ibm.com>
Content-Language: en-US, en-IN, en-GB
From: Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
In-Reply-To: <589f259e-1db9-4ec2-accc-b27966d09a3e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Qf5mvtbv c=1 sm=1 tr=0 ts=68cbad0b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=q5CvZCToSJJqjgns3BoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: IUAX_AP3EfalgYdLro8ulS_vbTnlZPn5
X-Proofpoint-GUID: 2Okb0Q0M4TVWHetba6bcmpHlWN1t0k3g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfXw1g9te6O2pOb
 rUM9pLlvWVxarW8Kehn6rEjCE98eFiQWC/Mg3Vome2eofKa2DNEX3xl+RXdBkxV/eO6Q4/nfSky
 bNHePQZHKxL/BtVKXhLUi5d7tFQUwqW3RM9kcwQKPb9ggqOjMG2qqfjyWLDku0TWQucfkIx23WI
 jwMjgSfVGKiB3C3loyQgGvhJSQ5Rj2ciHnnNMpc3KDzJXOAyCdO72sCIl0s0ViZRK8ro0Nyhm80
 /vq5Ju3iNzD/FRc/jv1ETdat/B82Jw1ZlJ6Agt5/+AGoowuBgaMHq7iIXcp+D91DVjQ7y8GgFAq
 qgBg8CJQsImg7vSi8NRt4Kue11lkH6xSR2XMs/I4JRZncQGIeEU+FGEmadjcoUoVlVUAP3Ok2qf
 EK9YCzrc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204


On 9/16/25 9:46 AM, Shrikanth Hegde wrote:
>
>
> On 9/9/25 2:32 AM, Mukesh Kumar Chaurasiya wrote:
>> Enable generic entry/exit path for ppc irq.
>>
>> Signed-off-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
>> ---
>>   arch/powerpc/Kconfig                    |   1 +
>>   arch/powerpc/include/asm/entry-common.h |  93 ++---
>>   arch/powerpc/include/asm/interrupt.h    | 492 +++---------------------
>>   arch/powerpc/kernel/interrupt.c         |   9 +-
>>   arch/powerpc/kernel/interrupt_64.S      |   2 -
>>   5 files changed, 92 insertions(+), 505 deletions(-)
>>
>                                 \
>> diff --git a/arch/powerpc/kernel/interrupt.c 
>> b/arch/powerpc/kernel/interrupt.c
>> index f53d432f60870..7bb8a31b24ea7 100644
>> --- a/arch/powerpc/kernel/interrupt.c
>> +++ b/arch/powerpc/kernel/interrupt.c
>> @@ -297,13 +297,8 @@ notrace unsigned long 
>> interrupt_exit_kernel_prepare(struct pt_regs *regs)
>>           /* Returning to a kernel context with local irqs enabled. */
>>           WARN_ON_ONCE(!(regs->msr & MSR_EE));
>>   again:
>> -        if (need_irq_preemption()) {
>> -            /* Return to preemptible kernel context */
>> -            if (unlikely(read_thread_flags() & _TIF_NEED_RESCHED)) {
>> -                if (preempt_count() == 0)
>> -                    preempt_schedule_irq();
>> -            }
>> -        }
>> +        if (need_irq_preemption())
>> +            irqentry_exit_cond_resched();
>
> irqentry_exit_cond_resched is also called in irqentry_exit. It would 
> be better if we can find ways to avoid calling it again.
>
> I see a loop here. But comment says it is not enabling irq again. so 
> the loop is bounded. So might be okay to remove cond_resched here. do run
> preemptirq, irq tracers to ensure that is case.
>
Sure.
> Also, what is this "soft_interrupts"?

You mean soft masked interrupts?
It's a mechanism to buffer interrupts without disabling the ee bit so 
that we can replay those interrupts later.

>>             check_return_regs_valid(regs);
>>   diff --git a/arch/powerpc/kernel/interrupt_64.S 
>> b/arch/powerpc/kernel/interrupt_64.S
>> index 1ad059a9e2fef..6aa88fe91fb6a 100644
>> --- a/arch/powerpc/kernel/interrupt_64.S
>> +++ b/arch/powerpc/kernel/interrupt_64.S
>> @@ -418,8 +418,6 @@ _ASM_NOKPROBE_SYMBOL(interrupt_return_\srr\())
>>       beq    interrupt_return_\srr\()_kernel
>>   interrupt_return_\srr\()_user: /* make backtraces match the _kernel 
>> variant */
>>   _ASM_NOKPROBE_SYMBOL(interrupt_return_\srr\()_user)
>> -    addi    r3,r1,STACK_INT_FRAME_REGS
>> -    bl    CFUNC(interrupt_exit_user_prepare)
>>   #ifndef CONFIG_INTERRUPT_SANITIZE_REGISTERS
>>       cmpdi    r3,0
>>       bne-    .Lrestore_nvgprs_\srr
>


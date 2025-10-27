Return-Path: <linux-kernel+bounces-870857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FDAC0BD9E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D10594E5EFC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 05:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7749E258EF3;
	Mon, 27 Oct 2025 05:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sTN+bFHC"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A808200BAE
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761543986; cv=none; b=pcIP1XoONSc4cC1Rz0/boOUGsd0/QubHuqWrPYTBM++604jclyejrTTz16eHQ2B4C352MF+1OnzNZprHwu1baE8H5YAeOWJ8BZ1LDyl1s7qg1u47VEoQGcBYoKSp1jAr9eraFgKXEqwj2rtbmemjGhPAnRnZ9bPhCdXcttvzPjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761543986; c=relaxed/simple;
	bh=KSDTo+SpsgR0aqUCafmnWpWWNzdUuqpwO6xad3JovZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvD/tcVcWtqm/n91zqP5uuW2/IvVQz0TZCkIK5Dwk1KT7n4cWZ0Lo9u6M3VRhA/E40dj5NcZGUG2ToX4G1YNY5MJEk9bOIL7QH4dmNOZQD0yirbR8GDXClPO5cLSQupBemnL6TCTQpMd8UMb5pfNN4poZDRes7jXCTkp8CdEPsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sTN+bFHC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59QLHF8q022264;
	Mon, 27 Oct 2025 05:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=d0p1aV
	ypKBYFgcnq6YIhYp1sH0UHGKhoATT8LoIZJwo=; b=sTN+bFHCNnTklOW8z3A25y
	7+qF7UoRWgLNvi5m8ccJWZfSUGpj7WQXDbXT63J7l2eB1aCJfsrl8YeDpmWz57Us
	eb8jhgreCKOioEmrzHYMR8p/94nvs+V7lWJWPA34EfOBMXLCyAz1DkuSzkrc1h8g
	trl+508VvcoEld3SkVxApRoMXdx5SWa6nbx+lWEozIe4osb3HFY3PYUBa2XQdD4A
	40dq4dvIYHHfvLQUU4md2j+mG3In3RuEC0OPcU4qel7O/oO2SSiPWk00BeiorA8m
	nM0wB6CbJwjZi3cZL6yPzRtl24aqXfQOUvB5ln2rvmbIlrNAhxxNZpbP33ooEphQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p81n72d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 05:45:48 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59R5e6IT007685;
	Mon, 27 Oct 2025 05:45:47 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p81n72b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 05:45:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59R2A2CQ023418;
	Mon, 27 Oct 2025 05:45:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a198xc46v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 05:45:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59R5jiRB40763716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 05:45:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 368052004E;
	Mon, 27 Oct 2025 05:45:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2A6B20040;
	Mon, 27 Oct 2025 05:45:41 +0000 (GMT)
Received: from [9.109.215.252] (unknown [9.109.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Oct 2025 05:45:41 +0000 (GMT)
Message-ID: <6f7b0688-6c92-4901-ab18-d348e667703e@linux.ibm.com>
Date: Mon, 27 Oct 2025 11:15:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 10/20] sched/mmcid: Convert mm CID mask to a bitmap
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Gabriele Monaco <gmonaco@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
        Yury Norov <yury.norov@gmail.com>
References: <20251022104005.907410538@linutronix.de>
 <20251022110556.029862568@linutronix.de>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20251022110556.029862568@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fIQ0HJae c=1 sm=1 tr=0 ts=68ff070c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=TL4G1yhqxUJCxPvYYi8A:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: m-pbacdc9QTzPys0p8l30qa-K_5Qo01j
X-Proofpoint-GUID: YydS-xM-Oh8-FNbgIYfQlfuB6ueBIoAa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAyNCBTYWx0ZWRfX8CwU/rkFIupb
 8b/mTZrN4qHlQVUV6U/2UlmBTqqfFGpNl77PPLiWhXMg7glteQ+SJxMO1YB0oiT26QSzpsY65lD
 klXXlBJWCJky4bHsZ4ea8015v4tMqrvPNxJBT81cwbgWc9Q7cUZKknxOmJoKd9W9NjX4HGLpU31
 8Q5feJ8tMoK8X3/Hg9O0HtjP540rLCP+P9Z5lVsLOrxI3FudmbCySF5wKjw4rL2F3Y5lGDMRKX2
 k/oexUIUaL/AJffGTxxg1G/NblDri9q6BnSlBseWehVTcDRn8iFdODUYzEc+v3jki2chcNizvPA
 WSoljYkkQZNL16VJkF8OWXiPbNym8YJpJDKIIOkGDJdlyGguoEtKOolbPgpYY4NwkyvLTrgeysz
 RVxne42FqpBghPbqoSqw/gq/667Kvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250024



On 10/22/25 6:25 PM, Thomas Gleixner wrote:
> This is truly a bitmap and just conveniently uses a cpumask because the
> maximum size of the bitmap is nr_cpu_ids.
> 
> But that prevents to do searches for a zero bit in a limited range, which
> is helpful to provide an efficient mechanism to consolidate the CID space
> when the number of users decreases.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   include/linux/mm_types.h |    6 +++---
>   kernel/sched/core.c      |    2 +-
>   kernel/sched/sched.h     |    6 +++---
>   3 files changed, 7 insertions(+), 7 deletions(-)
> 
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1342,13 +1342,13 @@ static inline cpumask_t *mm_cpus_allowed
>   }
>   
>   /* Accessor for struct mm_struct's cidmask. */
> -static inline cpumask_t *mm_cidmask(struct mm_struct *mm)
> +static inline unsigned long *mm_cidmask(struct mm_struct *mm)
>   {
>   	unsigned long cid_bitmap = (unsigned long)mm_cpus_allowed(mm);
>   
>   	/* Skip mm_cpus_allowed */
>   	cid_bitmap += cpumask_size();
> -	return (struct cpumask *)cid_bitmap;
> +	return (unsigned long *)cid_bitmap;
>   }
>   
>   static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p)
> @@ -1363,7 +1363,7 @@ static inline void mm_init_cid(struct mm
>   	mm->mm_cid.nr_cpus_allowed = p->nr_cpus_allowed;
>   	raw_spin_lock_init(&mm->mm_cid.lock);
>   	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
> -	cpumask_clear(mm_cidmask(mm));
> +	bitmap_zero(mm_cidmask(mm), cpumask_size());

Could use num_possible_cpus() here? CID are bound to be less than it no?

>   }
>   
>   static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *p)
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10399,7 +10399,7 @@ void sched_mm_cid_exit_signals(struct ta
>   	guard(preempt)();
>   	t->mm_cid.active = 0;
>   	if (t->mm_cid.cid != MM_CID_UNSET) {
> -		cpumask_clear_cpu(t->mm_cid.cid, mm_cidmask(mm));
> +		clear_bit(t->mm_cid.cid, mm_cidmask(mm));
>   		t->mm_cid.cid = MM_CID_UNSET;
>   	}
>   }
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3558,7 +3558,7 @@ static inline bool __mm_cid_get(struct t
>   
>   	if (cid >= max_cids)
>   		return false;
> -	if (cpumask_test_and_set_cpu(cid, mm_cidmask(mm)))
> +	if (test_and_set_bit(cid, mm_cidmask(mm)))
>   		return false;
>   	t->mm_cid.cid = t->mm_cid.last_cid = cid;
>   	__this_cpu_write(mm->mm_cid.pcpu->cid, cid);
> @@ -3581,7 +3581,7 @@ static inline bool mm_cid_get(struct tas
>   		return true;
>   
>   	/* Try the first zero bit in the cidmask. */
> -	return __mm_cid_get(t, cpumask_first_zero(mm_cidmask(mm)), max_cids);
> +	return __mm_cid_get(t, find_first_zero_bit(mm_cidmask(mm), num_possible_cpus()), max_cids);
>   }
>   
>   static inline void mm_cid_select(struct task_struct *t)
> @@ -3602,7 +3602,7 @@ static inline void switch_mm_cid(struct
>   {
>   	if (prev->mm_cid.active) {
>   		if (prev->mm_cid.cid != MM_CID_UNSET)
> -			cpumask_clear_cpu(prev->mm_cid.cid, mm_cidmask(prev->mm));
> +			clear_bit(prev->mm_cid.cid, mm_cidmask(prev->mm));
>   		prev->mm_cid.cid = MM_CID_UNSET;
>   	}
>   
> 



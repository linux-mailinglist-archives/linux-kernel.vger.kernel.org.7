Return-Path: <linux-kernel+bounces-897571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB39C5325B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B67D535A042
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A8533E354;
	Wed, 12 Nov 2025 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K/nqaxmh"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195752882D3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961361; cv=none; b=U1V4zpRp6taSPA4+KZMmYRhansgUDFIa5VETAJBx/XCi/QrfP88qedRCa3CIXBSFW9oANu0MEVnRTX6/WiQSYJvtHlPrmVGn+VKSCZniQA25FqaicR6cPsPMiD+3TyEtkkJkyq1aXEdhEF+ZGdml+YfTRJJVeqGGHo8GbXYC99c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961361; c=relaxed/simple;
	bh=VlJF84qCp1Uyg620SIsOKU74gKm4VBZZnvZQ9+f0L20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rdo49pNA8edvmEjqdWLfLg8gATEed/YL+Fcc5WMUACK3yp2e4AulxHG73gCXGJiapvnB4pts03/+bjFvUIyn1aoZ8j1ebaAs5UFaBvaPAC89AsX9hZzHxR88k/HpZXzDXkBScGb/TKdP/NMhdjhoPsOy8DoRwrTdOaHhSFBuJ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K/nqaxmh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC5w6du002505;
	Wed, 12 Nov 2025 15:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Lyrv2L
	F21jqf+yWamAUy/LYlJYIIFIMhy7BdaLH2d1g=; b=K/nqaxmh5O7asegHsMWaB1
	uUBN+Govmi5gsGUMftawK6c6UkNctn9CADRW7j3nfPRI4/QZHglRJ6vMajF6t9RR
	XSbvHaH59QrPQDiwqIv0JdE0raBAlRvvth2cl9d+yuJ5YQLYOdw0dxAY7TffAcAx
	SXSo7JPUZbR9LQKB/7JFsSvGaZ0I1B+LHuo8ZCBHhng+vD63OAJ1jLL4YnLa2kDx
	XXvKLrg1FtUkqT/DE39hQ5QY4AGdGvWc1COblUaiVUt9TkiWMk76VftQxwR7/c/4
	f7AJfifqnMZXa++niUd46NKgJOp9bfMdXdIMo+cEhiSSdFeqp3CGfX3Mpa1GhulA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cja1xe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:28:32 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ACF3Md5000535;
	Wed, 12 Nov 2025 15:28:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cja1x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:28:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACDCOs0014841;
	Wed, 12 Nov 2025 15:28:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aahpk8vqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:28:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACFSRPf12583258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 15:28:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEF7B20043;
	Wed, 12 Nov 2025 15:28:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F32820040;
	Wed, 12 Nov 2025 15:28:24 +0000 (GMT)
Received: from [9.124.217.11] (unknown [9.124.217.11])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 15:28:24 +0000 (GMT)
Message-ID: <01dcb63e-9ebd-42ca-9418-a822bf081bfc@linux.ibm.com>
Date: Wed, 12 Nov 2025 20:58:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] sched/fair: Small cleanup to sched_balance_newidle()
To: Peter Zijlstra <peterz@infradead.org>, vincent.guittot@linaro.org
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        Chris Mason
 <clm@meta.com>,
        Joseph Salisbury <joseph.salisbury@oracle.com>,
        Adam Li <adamli@os.amperecomputing.com>,
        Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
        Josh Don <joshdon@google.com>
References: <20251107160645.929564468@infradead.org>
 <20251107161739.525916173@infradead.org>
 <2acd7c1d-e2b4-40a0-85de-55f9b2635dad@linux.ibm.com>
 <20251112144241.GP278048@noisy.programming.kicks-ass.net>
 <20251112150818.GG4068168@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20251112150818.GG4068168@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Ss+dKfO0 c=1 sm=1 tr=0 ts=6914a7a0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Rhmd8u9pI6_gtBkjpRgA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5NSBTYWx0ZWRfX2e3TSrofYT5n
 ROC3EAng5guQbBQ8yba+nCUzx/3kiTh2tQ9xueAxNL/Pkt//Q6ND/crsR1EJbTF79cz8YcBHP6s
 9taZYt9Kk7kL5PW8qnrFBSDGy6p9q1eqYIuv5nAU2UjyXEWJZcZcequXiVcqwp0DgZaB2waO7Iz
 QlmsFBbun22KHML4BU1Xzb9Q+gZ7ap9eiQJz4U5VzImlwwVZJfyKwgaZ0bGAuiZojv3qUWxzANN
 9XikDaiS1TCYUFF8tH38uAdFtiE5ZtHjhJs3Ky0P1JnGnpMJLTyvfXXL/NeaRpik2zmVIFTAWZe
 b3RzesblZIyrCIkRxRFPKo0gx70ZLLWXpnJp+ZpzR9P7Qt/FGT0aUofsZDDnNJKXW6W6qzzGBb/
 erI0hrov9Ya+UZRV4nhGWarIOA4GDQ==
X-Proofpoint-GUID: SA1OuiGgw6YsiqJ7lgLW20NC0vbggzM-
X-Proofpoint-ORIG-GUID: bTTCZ27tsKr0u8G2q56EcvfkfT31HRht
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080095



On 11/12/25 8:38 PM, Peter Zijlstra wrote:
> On Wed, Nov 12, 2025 at 03:42:41PM +0100, Peter Zijlstra wrote:
> 
>>> if sd is null, i think we are skipping these compared to earlier.
>>>
>>>          t0 = sched_clock_cpu(this_cpu);
>>>          sched_balance_update_blocked_averages(this_cpu);
>>
>> let me pull that sched_balance_update_blocked_averages() thing up a few
>> lines.
> 
> Something like so..
> 
> ---
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9946,15 +9946,11 @@ static unsigned long task_h_load(struct
>   }
>   #endif /* !CONFIG_FAIR_GROUP_SCHED */
>   
> -static void sched_balance_update_blocked_averages(int cpu)
> +static void __sched_balance_update_blocked_averages(struct rq *rq)
>   {
>   	bool decayed = false, done = true;
> -	struct rq *rq = cpu_rq(cpu);
> -	struct rq_flags rf;
>   
> -	rq_lock_irqsave(rq, &rf);
>   	update_blocked_load_tick(rq);
> -	update_rq_clock(rq);
>   
>   	decayed |= __update_blocked_others(rq, &done);
>   	decayed |= __update_blocked_fair(rq, &done);
> @@ -9962,7 +9958,15 @@ static void sched_balance_update_blocked
>   	update_blocked_load_status(rq, !done);
>   	if (decayed)
>   		cpufreq_update_util(rq, 0);
> -	rq_unlock_irqrestore(rq, &rf);
> +}
> +
> +static void sched_balance_update_blocked_averages(int cpu)
> +{
> +	struct rq *rq = cpu_rq(cpu);
> +
> +	guard(rq_lock_irqsave)(rq);
> +	update_rq_clock(rq);
> +	__sched_balance_update_blocked_averages(rq);
>   }
>   
>   /********** Helpers for sched_balance_find_src_group ************************/
> @@ -12865,6 +12869,8 @@ static int sched_balance_newidle(struct
>   	if (!cpu_active(this_cpu))
>   		return 0;
>   
> +	__sched_balance_update_blocked_averages(this_rq);
> +

is this done only when sd == null ?

>   	/*
>   	 * This is OK, because current is on_cpu, which avoids it being picked
>   	 * for load-balance and preemption/IRQs are still disabled avoiding
> @@ -12891,7 +12897,6 @@ static int sched_balance_newidle(struct
>   	raw_spin_rq_unlock(this_rq);
>   
>   	t0 = sched_clock_cpu(this_cpu);
> -	sched_balance_update_blocked_averages(this_cpu);
>   
>   	rcu_read_lock();
>   	for_each_domain(this_cpu, sd) {

Referring to commit,
9d783c8dd112a (sched/fair: Skip update_blocked_averages if we are defering load balance)
I think vincent added the max_newidle_lb_cost check since sched_balance_update_blocked_averages is costly.



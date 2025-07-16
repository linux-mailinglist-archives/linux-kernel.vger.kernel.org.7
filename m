Return-Path: <linux-kernel+bounces-734073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A188AB07CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2FBEA440C9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD8129A9C3;
	Wed, 16 Jul 2025 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fklqh2ub"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17EE29A301
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752690131; cv=none; b=HiRJ4RX+XKTjWGnP4MHdqF8/jVpFg3KVdDxSqrexAleQPD9heooQGnWvPAeVqYuqn7v3GNl7Nvi+4oe+qonlU3t+/yg/Udsu5N5WcMnGCYOprDKJ9wniDsIdrfqoiG+SpuReIy8w/bl/UMzOX5pwhpNiqc+PKHL9RJQanTDd/BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752690131; c=relaxed/simple;
	bh=yc4UuYATMqnuleNOyzmLXvlRcA0a6+6sMpQx8FHd4Gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bqMR5ImJ2cfyTq/uGkPuYz7MyDAen1VGp2zsbud/ioDhSP9QFkse5/ywS6SR/8nBZYBCiOTdUmbLuPhZ5Pn+80qrZakERFYYw6vgh9lodTwBJp/qTLmtiA8NCS3SEMfb4b8X5GPt5wwIw3E9b5bsAVwjrwBIZdDFsv9pQKax3RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fklqh2ub; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GA66Fb032485;
	Wed, 16 Jul 2025 18:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=w24skl
	GwKpxZboeQ1PNNjgyHcoOFjVfdTs5ANU/pt4E=; b=Fklqh2ubgR8UIqund/b+MG
	CaynAX1dCaUw76AyszGroKm0GJCzTnQQwy2ojvNq+qEXxMlMsc3gIqYLKwFr9mUw
	4ugt2+qyIRr1rtgyzuXTTN7fLd6T6Btm79xSQn0v2oi27LUpwpoedj2618/Cuw+P
	JfrbJx5zbGse56Y4Ug87yTjrA6OmSy6r/QjMkLTZ5H+Ir2SccDHaeoqn1E8ybGFX
	psYWFG3O2nVfabIMY5TXtHEiDnycwrtEKHqM0uNWSI1LW8VL2HGpqwy/nMheHhc5
	XIQxCxjYVj89hBg0dwn6HC69sJ7I6AAbBvFW7Jk0Ag/O3QwHNsk/TVbC6Fn6//Bg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vamu25ne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 18:21:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56GFVk7u008951;
	Wed, 16 Jul 2025 18:21:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v3hmrm94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 18:21:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56GILnHm50069866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 18:21:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD56420043;
	Wed, 16 Jul 2025 18:21:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83D2920040;
	Wed, 16 Jul 2025 18:21:47 +0000 (GMT)
Received: from [9.124.218.236] (unknown [9.124.218.236])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Jul 2025 18:21:47 +0000 (GMT)
Message-ID: <ae8c6fd5-cc9c-44f3-a489-0346873f4be5@linux.ibm.com>
Date: Wed, 16 Jul 2025 23:51:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] futex: Use RCU-based per-CPU reference counting
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Valentin Schneider <vschneid@redhat.com>,
        Waiman Long <longman@redhat.com>
References: <20250710110011.384614-1-bigeasy@linutronix.de>
 <e0f58203-22ef-44c0-9f7b-b15c6007249b@linux.ibm.com>
 <20250715163134.pM1J2XO9@linutronix.de>
 <88edcfdf-2253-4563-a895-6e8bb1625800@linux.ibm.com>
 <20250716142946.GD905792@noisy.programming.kicks-ass.net>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250716142946.GD905792@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T2AwZ0QFCjinDQWgdCRkYAykNc2DfPZj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE2NSBTYWx0ZWRfXx238qieBafcT jLSqfGjaMC7RCZUVmZ6wgcZQM3dfGe+U9PDmtSqwV2O1JLPbQsYQjR+xG4vGX+bL3eA9vMGDfqy aSZhAsfRJoRJerUgYkmoDZ+LXbVoHacwOHATheGBaaJYtRdrlIWmG8AAtF2/5cmqPcu0/qOVvdP
 2u9yCEhVK1YtChqw982yOv5XO+mECWAl9nrWfWM6ZDYEry63GJoYfSZp4QVhQc4NJ9XYlyB178J mXX0pdRSomh+HAROg0lUYod1/6lTEDgmZbmRAAraAocgbxByoy/dY2RSdm9oR099mT9TZDrGFxb Ucv39zcboUnFVDPDK7GBHP935ESm6cvuvowFPQ8Byujv+LMB2lwzvqtUSAzI8bCQDimdx9Lh9Ln
 nHwLCEfq0BHMWMDZV3WEKf9EvqGQymeHKcZauyVAHrV5UaMknD+DhknUCODnaH2GJLkzpwoa
X-Proofpoint-ORIG-GUID: T2AwZ0QFCjinDQWgdCRkYAykNc2DfPZj
X-Authority-Analysis: v=2.4 cv=dNSmmPZb c=1 sm=1 tr=0 ts=6877edc0 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=hLBtojj1w5sSJmacFvYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_03,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160165



On 7/16/25 19:59, Peter Zijlstra wrote:
> On Tue, Jul 15, 2025 at 10:34:24PM +0530, Shrikanth Hegde wrote:
> 
>> I did try again by going to baseline, removed BROKEN and ran below. Which gives us immutable numbers.
>> ./perf bench futex hash -Ib512
>> Averaged 1536035 operations/sec (+- 0.11%), total secs = 10
>> Futex hashing: 512 hash buckets (immutable)
>>
>> So, with -b 512 option, it is around 8-10% less compared to immutable.
> 
> Urgh, can you run perf on that and tell me if this is due to
> this_cpu_{inc,dec}() doing local_irq_disable() or the smp_load_acquire()
> doing LWSYNC ?

It seems like due to rcu and irq enable.
Both perf records are collected with -b512.


base_futex_immutable_b512 - perf record collected with baseline + remove BROKEN + ./perf bench futex hash -Ib512
per_cpu_futex_hash_b_512 - baseline + series + ./perf bench futex hash -b512


perf diff base_futex_immutable_b512 per_cpu_futex_hash_b_512
# Event 'cycles'
#
# Baseline  Delta Abs  Shared Object               Symbol
# ........  .........  ..........................  ....................................................
#
     21.62%     -2.26%  [kernel.vmlinux]            [k] futex_get_value_locked
      0.16%     +2.01%  [kernel.vmlinux]            [k] __rcu_read_unlock
      1.35%     +1.63%  [kernel.vmlinux]            [k] arch_local_irq_restore.part.0
                +1.48%  [kernel.vmlinux]            [k] futex_private_hash_put
                +1.16%  [kernel.vmlinux]            [k] futex_ref_get
     10.41%     -0.78%  [kernel.vmlinux]            [k] system_call_vectored_common
      1.24%     +0.72%  perf                        [.] workerfn
      5.32%     -0.66%  [kernel.vmlinux]            [k] futex_q_lock
      2.48%     -0.43%  [kernel.vmlinux]            [k] futex_wait
      2.47%     -0.40%  [kernel.vmlinux]            [k] _raw_spin_lock
      2.98%     -0.35%  [kernel.vmlinux]            [k] futex_q_unlock
      2.42%     -0.34%  [kernel.vmlinux]            [k] __futex_wait
      5.47%     -0.32%  libc.so.6                   [.] syscall
      4.03%     -0.32%  [kernel.vmlinux]            [k] memcpy_power7
      0.16%     +0.22%  [kernel.vmlinux]            [k] arch_local_irq_restore
      5.93%     -0.18%  [kernel.vmlinux]            [k] futex_hash
      1.72%     -0.17%  [kernel.vmlinux]            [k] sys_futex


> 
> Anyway, I think we can improve both. Does the below help?
> 
> 
> ---
> diff --git a/kernel/futex/core.c b/kernel/futex/core.c
> index d9bb5567af0c..8c41d050bd1f 100644
> --- a/kernel/futex/core.c
> +++ b/kernel/futex/core.c
> @@ -1680,10 +1680,10 @@ static bool futex_ref_get(struct futex_private_hash *fph)
>   {
>   	struct mm_struct *mm = fph->mm;
>   
> -	guard(rcu)();
> +	guard(preempt)();
>   
> -	if (smp_load_acquire(&fph->state) == FR_PERCPU) {
> -		this_cpu_inc(*mm->futex_ref);
> +	if (READ_ONCE(fph->state) == FR_PERCPU) {
> +		__this_cpu_inc(*mm->futex_ref);
>   		return true;
>   	}
>   
> @@ -1694,10 +1694,10 @@ static bool futex_ref_put(struct futex_private_hash *fph)
>   {
>   	struct mm_struct *mm = fph->mm;
>   
> -	guard(rcu)();
> +	guard(preempt)();
>   
> -	if (smp_load_acquire(&fph->state) == FR_PERCPU) {
> -		this_cpu_dec(*mm->futex_ref);
> +	if (READ_ONCE(fph->state) == FR_PERCPU) {
> +		__this_cpu_dec(*mm->futex_ref);
>   		return false;
>   	}
>   

Yes. It helps. It improves "-b 512" numbers by at-least 5%.

baseline + series:
Averaged 1412543 operations/sec (+- 0.14%), total secs = 10
Futex hashing: 512 hash buckets


baseline + series+ above_patch:
Averaged 1482733 operations/sec (+- 0.26%), total secs = 10   <<< 5% improvement
Futex hashing: 512 hash buckets


Now we are closer baseline/immutable by 4-5%.
baseline:
commit 8784fb5fa2e0042fe3b1632d4876e1037b695f56 (HEAD)

./perf bench futex hash
Averaged 1559643 operations/sec (+- 0.09%), total secs = 10
Futex hashing: global hash
  


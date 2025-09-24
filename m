Return-Path: <linux-kernel+bounces-831215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 512EEB9BEA0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A546A188E7A1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EDE328565;
	Wed, 24 Sep 2025 20:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tZ4Zh3mr"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96069242938
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758745599; cv=none; b=rurCBLc0XIrMXNC8fZ9ZFa+587KcSAzKDQ1jY3eghiNaQM/wmK209ISl1M2Y7uIBKLlmMohzdtn5GpUEqYQjGD24ohr1RoUILeezrvuk/Kww7Xbmbj7pRhe245BSk9uvbIZPLQk7seiGuxqM3BytegLDdEZWkkZsDx/UUEG358A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758745599; c=relaxed/simple;
	bh=c/wppCWoCykYza98XE0R7mb4b4/obB2EvPce43fnMuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLz0xL6vAjdIOqn1eAiwe71b03A5JH8DnJuRopNKH1LmuRNbWfJwgyzjd4q0OKFRJVNfSIXcEQUj6s8aaHPT/HyiKGt0U2qEW0UyxxCu8i78Hxa4h/TKB8btoybn8Ux7/91iozxPzf6yg83bIuzdscqUzL+TjKm/7pA2wDeyzA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tZ4Zh3mr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OI8QB2011419;
	Wed, 24 Sep 2025 20:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qnKAPR
	s+VPg3wNkZoc/sU4tRgABH4YX50fwnXW8GwZ0=; b=tZ4Zh3mrr037vDc5K+d1D+
	IUU1oPO3/zH2o0k2TTofWWGDwCpUuVlEoboqOgp8m9i27l9tiTuPO1VWMoaveLkJ
	mrBmX8+NGHR92CoYH0abWKFOIoBnyG/0t6CODdN/ARky7vByBCLyVQVnC6gsp9TI
	/2od2VYSpD3d41MbPiiQ+SJV3Dreat4yYHtdoQk/I8Fa8RhNcsI8ohqRZubYUUh5
	Tntv+xVoqFZ0TusBITdg68ZUyAxFLHXV6b0cWEAq3IgdBwXoNhspUmJtvJLJDMwr
	KK//bU5aHx57wY4AIgs5wJU7YuzR9cQ3Tp4N3ZjfUsQ/R6p3cugo2Z36iT1zClIg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ky69wb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 20:26:14 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58OKPDpV017548;
	Wed, 24 Sep 2025 20:26:14 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ky69wb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 20:26:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58OHkcjx013599;
	Wed, 24 Sep 2025 20:26:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a8tjj9h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 20:26:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58OKQBI150725240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 20:26:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64DD220040;
	Wed, 24 Sep 2025 20:26:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53FCD2004B;
	Wed, 24 Sep 2025 20:26:04 +0000 (GMT)
Received: from [9.61.52.22] (unknown [9.61.52.22])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Sep 2025 20:26:03 +0000 (GMT)
Message-ID: <98aa5e37-258e-4efe-8e09-b8cfc5f78f0d@linux.ibm.com>
Date: Thu, 25 Sep 2025 01:56:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/19] sched/fair: Simplify set_cpu_sd_state_*() with
 guards
To: K Prateek Nayak <kprateek.nayak@amd.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Swapnil Sapkal <swapnil.sapkal@amd.com>,
        Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <20250904041516.3046-1-kprateek.nayak@amd.com>
 <20250904041516.3046-2-kprateek.nayak@amd.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250904041516.3046-2-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WEBgESyanmAGKw8wuT_O1ApQt4MJxw5n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfX3dyFASGeRs7E
 GwlL4VcO90sKqMBcqcIbKgQWUjG/On3okQbMRgAG2wheyauw94UldH9c+rrFU03EFYi/m+bG3z5
 Ctq8CaRZkuaxFi3CZqdGmE6BpAsrqVYyBxj+g6I9Jlp21kwOFFrbIG0WTLeFoVZlXliwZO1C96k
 SYbO+NdGpGvu/D/lAwlqI48N56Xd2ej2joMVID7wi8kVDpdA2z40jJwwW0IaHInqJLpaelkx52p
 waRyZxQ48OtVCLCSva1s880wSbYrqZVoas3prDxioNRDeUD7NxLFJQ1YeT06lu2xTfgB5SJY20K
 N8igt0qVobhQirB7cuXYnjlbDR8iBiQ7InCc9MOQBDZaB2U/h/xmqAdjdEk0ic1Dd3aEWQNvG76
 KELOlM6b
X-Authority-Analysis: v=2.4 cv=XYGJzJ55 c=1 sm=1 tr=0 ts=68d453e6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=zd2uoN0lAAAA:8 a=VnNF1IyMAAAA:8
 a=fHjAQ3KN5lqxBgJHjdkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: T9IdPYAM-u8zPTZAlIVniIouUK16mcwx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_06,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020



On 9/4/25 9:44 AM, K Prateek Nayak wrote:
> Simplify set_cpu_sd_state_{busy,idle}() using guard(rcu).
> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>   kernel/sched/fair.c | 20 ++++++++------------
>   1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index df8dc389af8e..61b59fd75ced 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12449,16 +12449,14 @@ static void set_cpu_sd_state_busy(int cpu)
>   {
>   	struct sched_domain *sd;
>   
> -	rcu_read_lock();
> -	sd = rcu_dereference(per_cpu(sd_llc, cpu));
> +	guard(rcu)();
>   
> +	sd = rcu_dereference(per_cpu(sd_llc, cpu));
>   	if (!sd || !sd->nohz_idle)
> -		goto unlock;
> -	sd->nohz_idle = 0;
> +		return;
>   
> +	sd->nohz_idle = 0;
>   	atomic_inc(&sd->shared->nr_busy_cpus);
> -unlock:
> -	rcu_read_unlock();
>   }
>   
>   void nohz_balance_exit_idle(struct rq *rq)
> @@ -12479,16 +12477,14 @@ static void set_cpu_sd_state_idle(int cpu)
>   {
>   	struct sched_domain *sd;
>   
> -	rcu_read_lock();
> -	sd = rcu_dereference(per_cpu(sd_llc, cpu));
> +	guard(rcu)();
>   
> +	sd = rcu_dereference(per_cpu(sd_llc, cpu));
>   	if (!sd || sd->nohz_idle)
> -		goto unlock;
> -	sd->nohz_idle = 1;
> +		return;
>   
> +	sd->nohz_idle = 1;
>   	atomic_dec(&sd->shared->nr_busy_cpus);
> -unlock:
> -	rcu_read_unlock();
>   }
>   
>   /*

This looks good.
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

---

we have both sd_llc->shared and sd_llc_shared usage spread
across the code, is it possible to remove sd_llc_shared and use sd_llc->shared
instead?

Likely sd_llc is cache hot and access to shared should be fast too.
In turn this could free up some per cpu area.

Any thoughts?


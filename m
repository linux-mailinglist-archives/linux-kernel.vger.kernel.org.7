Return-Path: <linux-kernel+bounces-875114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3F9C183C7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5943AD01C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066B72F5A31;
	Wed, 29 Oct 2025 04:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GdMVrAqF"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966CD253F39
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761712685; cv=none; b=OjByCVhoBPXcBcadWaJZ77T/ppkQq6z72AAI/34i0gTkcrF8LgQSKX9l/y3h3CRCFxHi1w8ofciAdhV7Z2+TnBUi48/NcNkUW1HjoWO5jKszRIU+q8/9I3nYKthCxlywZQ/ei0ATtpeYfOAfO63z3rTsg5N8G9NHGNSUIdUwrHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761712685; c=relaxed/simple;
	bh=1y+dvF0mJKVpwNAqPCRI6IGgb9XPztVXyx4RnWTigJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vER2VzKfFGeeMHHZcB7xm/vvOpfWepA6sYk+CYddspqMXDhUbYaGbr9rvGKDdXd/ieTxD1+tsy73k9W44nlEOhOIapV+fnM6kQriiw+S2gn1et1vX3FofadvkGJ72lfrtXF6Lkg6uCdSIAlXGPcTPzmXvssEYXX9JDprTpWzUMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GdMVrAqF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SJm7Mo025639;
	Wed, 29 Oct 2025 04:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IQ+PBt
	1HPDXk6+FoTDDUwsMk/WS2ysR7IAu0Pywpy7c=; b=GdMVrAqFSr/RmL9ymCWySm
	ZiF4jiSldECgwONzAS1O9aztmY4F53OxrI0HL9eHHbpkd5sq2ph15qbv+JBHwUgl
	V9PuSGPfJob1NwL1kd+sET3sE/qWh0fYk6GABTXJOpC9KhBFf2CY2Afg71GSiaAb
	JbB1VBctxNfygDpfJW8KrhqzP+7V7B81mZ3JX8virDMVjToqUnEPHaS+RFQ7DJWp
	wcCfMDAiKkWTHIkD+CHlVzbQq6wB7ldn6FNtSkaxNehD6g0+9k+t9T26/SZtZHmD
	xIE3/y8w0d9qmILAYfN7zWyn3hBWYEZFUWJQVU7se2I3/zT2SF9cjmGLMNa0uOkA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34achg7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 04:37:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59T07tRM018748;
	Wed, 29 Oct 2025 04:37:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xw9mnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 04:37:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59T4biGq26935848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 04:37:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F9A220040;
	Wed, 29 Oct 2025 04:37:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD2F820043;
	Wed, 29 Oct 2025 04:37:42 +0000 (GMT)
Received: from [9.124.209.124] (unknown [9.124.209.124])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Oct 2025 04:37:42 +0000 (GMT)
Message-ID: <ae3250fb-245b-446c-ab80-1684150d239a@linux.ibm.com>
Date: Wed, 29 Oct 2025 10:07:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: Skip sched_balance_running cmpxchg when
 balance is not due
To: Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Chen Yu <yu.c.chen@intel.com>,
        Doug Nelson <doug.nelson@intel.com>,
        Mohini Narkhede <mohini.narkhede@intel.com>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>
References: <248b775fc9030989c829d4061f6f85ae33dabe45.1761682932.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <248b775fc9030989c829d4061f6f85ae33dabe45.1761682932.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XbuEDY55 c=1 sm=1 tr=0 ts=69019a1b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8
 a=uWl6ZvDGiZMprcYggBMA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: MIdniwLlN6Q5Nar3PkateCfoDimS_Kp9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX/NRSR2coJ3w/
 SHujXfYl9xtBhzwe24kfaZz67tLt0h2bR5uUIQw429bmMh+gIhqW2M56lDgbI/28IJ96hFvEI7p
 m6GWxgjTz0o9GkdlY4WsDx44tiXV6UlA4Rd65aLtUeGNB3lqPfgvJm8EjhLxnzk3gihBiT6HcL9
 904/UviPlZrmUU9V9zndp8ru9J2MZxfWcXlvoq/eBPzTThvgAQRhnGcr1Qd2ColZxWf/Fffs+U0
 7w/K0aJgJP6OIfE1043p8WKmrZMsTb/D6ihWD6fkJ48MswR5NYQg7/rv4rpJ0NFhsLsvxp0/G8a
 UEFxPPPjWP5ZmWI66i7aXCxhC3aDC+CGg79NpHtjTkSO/Hx06b+swQ17CHomnxHbqGwrevHuqB4
 iEJxK7r0nVZ4nPSG/L+5vETjMjxNGA==
X-Proofpoint-GUID: MIdniwLlN6Q5Nar3PkateCfoDimS_Kp9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166



On 10/29/25 1:53 AM, Tim Chen wrote:
> The NUMA sched domain sets the SD_SERIALIZE flag by default, allowing
> only one NUMA load balancing operation to run system-wide at a time.
> 
> Currently, each MC group leader in a NUMA domain attempts to acquire

Could be MC or PKG, depending on topology.

> the global sched_balance_running flag via cmpxchg() before checking
> whether load balancing is due or whether it is the designated leader for
> that NUMA domain. On systems with a large number of cores, this causes
> significant cache contention on the shared sched_balance_running flag.
> 
> This patch reduces unnecessary cmpxchg() operations by first checking
> whether the balance interval has expired. If load balancing is not due,
> the attempt to acquire sched_balance_running is skipped entirely.
> 
> On a 2-socket Granite Rapids system with sub-NUMA clustering enabled,
> running an OLTP workload, 7.8% of total CPU cycles were previously spent
> in sched_balance_domain() contending on sched_balance_running before
> this change.
> 
>           : 104              static __always_inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
>           : 105              {
>           : 106              return arch_cmpxchg(&v->counter, old, new);
>      0.00 :   ffffffff81326e6c:       xor    %eax,%eax
>      0.00 :   ffffffff81326e6e:       mov    $0x1,%ecx
>      0.00 :   ffffffff81326e73:       lock cmpxchg %ecx,0x2394195(%rip)        # ffffffff836bb010 <sched_balance_running>
>           : 110              sched_balance_domains():
>           : 12234            if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
>     99.39 :   ffffffff81326e7b:       test   %eax,%eax
>      0.00 :   ffffffff81326e7d:       jne    ffffffff81326e99 <sched_balance_domains+0x209>
>           : 12238            if (time_after_eq(jiffies, sd->last_balance + interval)) {
>      0.00 :   ffffffff81326e7f:       mov    0x14e2b3a(%rip),%rax        # ffffffff828099c0 <jiffies_64>
>      0.00 :   ffffffff81326e86:       sub    0x48(%r14),%rax
>      0.00 :   ffffffff81326e8a:       cmp    %rdx,%rax
> 
> After applying this fix, sched_balance_domain() is gone from
> the profile and there is a 8% throughput improvement.
> 
> v2:
> 1. Rearrange the patch to get rid of an indent level per Peter's
>     suggestion.
> 2. Updated the data from new run by OLTP team.
> 
> link to v1: https://lore.kernel.org/lkml/e27d5dcb724fe46acc24ff44670bc4bb5be21d98.1759445926.git.tim.c.chen@linux.intel.com/
> 
> Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Tested-by: Mohini Narkhede <mohini.narkhede@intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>   kernel/sched/fair.c | 25 +++++++++++++------------
>   1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 25970dbbb279..a10c95e11ea5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12226,6 +12226,8 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
>   		}
>   
>   		interval = get_sd_balance_interval(sd, busy);
> +		if (time_before(jiffies, sd->last_balance + interval))
> +			goto out;
>   
>   		need_serialize = sd->flags & SD_SERIALIZE;
>   		if (need_serialize) {
> @@ -12233,19 +12235,18 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
>   				goto out;
>   		}
>   
> -		if (time_after_eq(jiffies, sd->last_balance + interval)) {
> -			if (sched_balance_rq(cpu, rq, sd, idle, &continue_balancing)) {
> -				/*
> -				 * The LBF_DST_PINNED logic could have changed
> -				 * env->dst_cpu, so we can't know our idle
> -				 * state even if we migrated tasks. Update it.
> -				 */
> -				idle = idle_cpu(cpu);
> -				busy = !idle && !sched_idle_cpu(cpu);
> -			}
> -			sd->last_balance = jiffies;
> -			interval = get_sd_balance_interval(sd, busy);
> +		if (sched_balance_rq(cpu, rq, sd, idle, &continue_balancing)) {
> +			/*
> +			 * The LBF_DST_PINNED logic could have changed
> +			 * env->dst_cpu, so we can't know our idle
> +			 * state even if we migrated tasks. Update it.
> +			 */
> +			idle = idle_cpu(cpu);
> +			busy = !idle && !sched_idle_cpu(cpu);
>   		}
> +		sd->last_balance = jiffies;
> +		interval = get_sd_balance_interval(sd, busy);
> +
>   		if (need_serialize)
>   			atomic_set_release(&sched_balance_running, 0);
>   out:

Hi Tim,

I still prefer the method where we move this check after should_we_balance.
https://lore.kernel.org/all/a5d5ce5e-9f98-4c0d-a4ed-5e4a8a6f7b86@linux.ibm.com/


The reason being:

1. cpu aquires sched_balance_running but wont do balancing since swb says no.
    While a legit CPU which was supposed to do balance goes out since it couldn't
    aquire it.

2. Newidle balance doesn't care about serialize as of now and that too will come
    under the same checks. Iterating through NUMA domains rq's is costly. That could
    help avoid un-necessary bus traffic.


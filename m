Return-Path: <linux-kernel+bounces-874021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E0EC1556E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15CBA1887EC4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7533B3054DF;
	Tue, 28 Oct 2025 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fI/iAufa"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9A82765F5
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663959; cv=none; b=os8bteLy30y6vppQhh9jwqpffBN88uX5GBq/R+SKXE1CuoW270CZwNniynicgK5HLfsOqGXxUlRa9qhqiHMtIHkhD+2aON1Oiknn/ILW0O3YJlu1gLtkwkpOtOTE6PiZ14WEWWvASKBCFoRJtWMr3grG311ElqEV1i7dUVREdhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663959; c=relaxed/simple;
	bh=v4SnWvb2db1Ftf8g2Tg7gcN/1hjpETQCzi8NkBJaJBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PehTNLYKB5+PSRT4Xiest2vMHqGuslLakqJMLHhmzpRUKrwYvAA1aX76u32ApwycdruujHfmZNs3Xx40aRptdlAvmJVYQXPokPclXjAt99mUdXJRvBnPaY/APUYdQR8HbdQWeqTMDih6CjDNohJJfRubSujPgY2Zioe5ogSh4PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fI/iAufa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SEHYfl032463;
	Tue, 28 Oct 2025 15:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wMURJE
	ro5dyeW8ifKn+S4LrAc8oRb1oAD2iyQc7YaEw=; b=fI/iAufa75RD2Lar+G+f9f
	p69zjcDG9pWEDhWR8SqLa/TXPX/PPGPNGBKmJmVMOuUfiQCe2rjdrDUyoU+P0BBX
	P4yQR3gAV65bpyP56vCJqXuM1xME+MuQnhnjh3eecGWIcAWgq0rqpjJ+T8Io1XdS
	LLrsZ0OPCFovH2nXQ+4mgLRPd5jRaWduHcAyZfuSkzPYb7ZvYwkQqkWWLu64hIOr
	8/YfCwYIcAq83R3HWCeFVbZzkCBTV0lySdrlwgILc4MFZjJ6qmqsZR07hvYp3Eox
	SvzpJdMQXwBQjz6lA1bIjA0nnf0YI9qFEfbeQtDPE1zSAgll4TCuBMq6cch2bJDA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p724n6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 15:05:18 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59SF2TFw004917;
	Tue, 28 Oct 2025 15:05:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p724n65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 15:05:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59SEeVJt022864;
	Tue, 28 Oct 2025 15:05:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a198xkgrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 15:05:17 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59SF5Dqk29098268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 15:05:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 722A920043;
	Tue, 28 Oct 2025 15:05:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D63520040;
	Tue, 28 Oct 2025 15:05:08 +0000 (GMT)
Received: from [9.39.28.25] (unknown [9.39.28.25])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Oct 2025 15:05:07 +0000 (GMT)
Message-ID: <8ec843b6-ac7d-4cef-a0b1-12b85470fde8@linux.ibm.com>
Date: Tue, 28 Oct 2025 20:35:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched: Feature to decide if steal should update CPU
 capacity
To: Srikar Dronamraju <srikar@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Ben Segall <bsegall@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20251028104255.1892485-1-srikar@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20251028104255.1892485-1-srikar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CmVIPKjkXUofxXYgmejIGKb39pFhDDN7
X-Proofpoint-ORIG-GUID: 7RpQIg72nuRKE48qinGNLywFwWVXq0_k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAyNCBTYWx0ZWRfX6+42+Cye5Uxw
 jp6LQcPxTh7BpfVwc0rp7CE0Ioe4cqTtF7Y/ZsPtBiLB/P18ZZGyk26KLTmgr19AYMo1R2d4nIX
 1PR/cUWNEBY2errE4405ywr5+savZOztwEwlANuvSdQQhCcpVm4lPL420ekgjrTL/A+XIgzMrjp
 K5AVLJFquuXYoqXHvY1ic5nmGspOGXHLse3F0+epZRxUSU4QB4JU382Au1Bl1aQ/MzogNMJ1dof
 Uz2kK2cJ7ZjUXli+AiEC2XQK8juv/i7JiAT646mlDwaY57jgCggzxYFWrt29r3kjf/sMtAdlPTe
 MvMm9OkFfqXy9fNLwnDAzy+9jlvaDa1aevBMWO7m2bcj7vpSzT2ZyTNgc+5MM/0UiwjuJXHJSE6
 wA7GAYQv73ouqXMhpE6JyDRx5iUCDw==
X-Authority-Analysis: v=2.4 cv=G/gR0tk5 c=1 sm=1 tr=0 ts=6900dbae cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=FM1kV94TdvI3X7O_qz4A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250024



On 10/28/25 4:12 PM, Srikar Dronamraju wrote:
> At present, scheduler scales CPU capacity for fair tasks based on time
> spent on irq and steal time. If a CPU sees irq or steal time, its
> capacity for fair tasks decreases causing tasks to migrate to other CPU
> that are not affected by irq and steal time. All of this is gated by
> NONTASK_CAPACITY.
> 
> In virtualized setups, a CPU that reports steal time (time taken by the
> hypervisor) can cause tasks to migrate unnecessarily to sibling CPUs that
> appear to be less busy, only for the situation to reverse shortly.
> 
> To mitigate this ping-pong behaviour, this change introduces a new
> scheduler feature flag: ACCT_STEAL which will control whether steal time
> contributes to non-task capacity adjustments (used for fair scheduling).
> 
> Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
> ---
>   include/linux/sched.h   | 1 +
>   kernel/sched/core.c     | 7 +++++--
>   kernel/sched/debug.c    | 8 ++++++++
>   kernel/sched/features.h | 1 +
>   4 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index aa9c5be7a632..451931cce5bf 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2272,5 +2272,6 @@ static __always_inline void alloc_tag_restore(struct alloc_tag *tag, struct allo
>   #define alloc_tag_save(_tag)			NULL
>   #define alloc_tag_restore(_tag, _old)		do {} while (0)
>   #endif
> +extern void steal_updates_cpu_capacity(bool enable);
>   
>   #endif
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 81c6df746df1..3a7c4e307371 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -792,8 +792,11 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
>   	rq->clock_task += delta;
>   
>   #ifdef CONFIG_HAVE_SCHED_AVG_IRQ

Curious to know if there are users/distro which have CONFIG_HAVE_SCHED_AVG_IRQ=n

> -	if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
> -		update_irq_load_avg(rq, irq_delta + steal);
> +	if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY)) {
> +		if (steal && sched_feat(ACCT_STEAL))
> +			irq_delta += steal;
> +		update_irq_load_avg(rq, irq_delta);
> +	}
>   #endif
>   	update_rq_clock_pelt(rq, delta);
>   }
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 557246880a7e..a0393dd43bb2 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -1307,3 +1307,11 @@ void resched_latency_warn(int cpu, u64 latency)
>   	       cpu, latency, cpu_rq(cpu)->ticks_without_resched);
>   	dump_stack();
>   }
> +
> +void steal_updates_cpu_capacity(bool enable)
> +{
> +	if (enable)
> +		sched_feat_set("ACCT_STEAL");
> +	else
> +		sched_feat_set("NO_ACCT_STEAL");
> +}
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 3c12d9f93331..82d7806ea515 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -121,3 +121,4 @@ SCHED_FEAT(WA_BIAS, true)
>   SCHED_FEAT(UTIL_EST, true)
>   
>   SCHED_FEAT(LATENCY_WARN, false)
> +SCHED_FEAT(ACCT_STEAL, true)



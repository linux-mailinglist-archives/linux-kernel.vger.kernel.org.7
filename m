Return-Path: <linux-kernel+bounces-846289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8CABC77A8
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 08:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 22F3634C48C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 06:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28EB29346F;
	Thu,  9 Oct 2025 06:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O2f0QHiP"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A040824BD
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 06:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989733; cv=none; b=qRv6buLYO9MhhShJABiu2nxkHNy2BEQ5TPxoO1Sv8DZo0EQS12nvxpqoQARGaYzlXmu3mFY6f2L26my4It34I3OTZDl6SeWuarE7I0sIj/J+Hzq2csBXlS+sVD6TDAvPoRwz40p5wfu9nRArC7b+azTk47X5MgRb8ziaAt3poTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989733; c=relaxed/simple;
	bh=vDS89Esz5bk/8w/qsC/3FYMUCAH44LK673Z8DqwkJ/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svoj6qut89QXMF7pISnvgSZALKvZwLgIBl4FA1fE8QyztQHE/nmOTTHCLpSDT9ouwmOBCeTi7lBwifI4LTN10/lAR1/kPrKTVfXVSOZj9mx43jYl1PC72UBKLG9TVQ5lJk+xGnruoR9BvkZGL9Q7bGDHN9Kuqaa489+WxkkeQq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O2f0QHiP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598HILZ2014547;
	Thu, 9 Oct 2025 06:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fmhtBp
	BEdri0wWMpFIl9jWeisTtflMshFZ5RAy4/kIo=; b=O2f0QHiPgzf6FnOQCJ2iF5
	zXZGvSF2bwLIAr9iLpFcZfp3yYItyIDGZM4jr2qAPc7IIZUud/IxBMqD+qrjibmD
	o/3hVKdjEVrGmO195hxhjJUrBaXhejMDBm3t7Ggd6w+AO+WNA7bebsgyhUn33/Rb
	ezBsx+jGspczIE5+Jmz1vk0mGRHHl3jaCT+9ErKqNX3dHJbK+ct7jvl5GVlDjMLj
	3q0NfDv5ocWgpHBgzWEY5NAA+YEoOLwscrVRb0jJnibkMMnLGAggQhbx0BsPSI95
	cL2s+drl5JHXfPxVmpboW07GLNo+wc3RS4Jc07UyB0ljCvQVCTaOmqkwltfCishg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv84jqhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 06:01:55 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59961sRm022488;
	Thu, 9 Oct 2025 06:01:54 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv84jqhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 06:01:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59961ZsH008347;
	Thu, 9 Oct 2025 06:01:54 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49nvantp3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 06:01:54 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59961rkW12911116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Oct 2025 06:01:53 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3053C58062;
	Thu,  9 Oct 2025 06:01:53 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 542A05805A;
	Thu,  9 Oct 2025 06:01:49 +0000 (GMT)
Received: from [9.98.110.226] (unknown [9.98.110.226])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Oct 2025 06:01:49 +0000 (GMT)
Message-ID: <41283b3e-cf11-4faf-879d-0078bb24e6a0@linux.ibm.com>
Date: Thu, 9 Oct 2025 11:31:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched: Fix some spelling mistakes in the scheduler
 module
To: Jianyun Gao <jianyungao89@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20251009024657.151767-1-jianyungao89@gmail.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20251009024657.151767-1-jianyungao89@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HKPO14tv c=1 sm=1 tr=0 ts=68e74fd3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=czgnhYvoGhU4DqSdWBYA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: Z27mxRO6YyEW8cQUeefCgeMX74n7QN1w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX7h3J3jwSScoW
 O/nZ3uIpdgyIipfmInN8bkjgIzSAk4Gm5fz7LvJF7plJqtGLvFbggQ78SRh28z1nVonw9jCtMpJ
 GzEpudLD/rzs4kGPsH3EpFLaVqzZeZy0rH7g89Oem4EVNLyeVZSOVgQrBtDDPKgF/uz5xRgftGo
 novY/NW2JbOvlFo7QdkxzyJ525SsgkOqDTVN9itbfwwPxbzyUiZZnxt75E2Ii2kdJTo07oYD4Ug
 OSe/sLFzt6CYnzq5b0XjcGykT159G8RlnN7YKEdEufJ5gZ05E5Ks40v21cpRYd86qEb7LQDkhxr
 AA/iwrF831oNbLCNZAhrKEObFlQlKV1wJS9787tyedvwvFAgg3dAZp8KPyre7MsnAEA24RISfdD
 Ll6nuPbQapT9yGbq3RLq5pIhNEopwQ==
X-Proofpoint-ORIG-GUID: 422LbAiJjp1NHAKs0lwh0ukGRQRL_i69
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

Hi Jianyun,

On 09/10/25 08:16, Jianyun Gao wrote:
> From: "jianyun.gao" <jianyungao89@gmail.com>
> 
> The following are some spelling mistakes existing in the scheduler
> module. Just fix it!
> 
>   slection -> selection
>   achitectures -> architectures
>   excempt -> exempt
>   incorectly -> incorrectly
>   litle -> little
>   faireness -> fairness
>   condtion -> condition
> 
> Signed-off-by: jianyun.gao <jianyungao89@gmail.com>
> ---
> v3:
> Change "except" to "exempt" in v2.

It should be "excempt" to "exempt"

> The previous version is here:
> 
> https://lore.kernel.org/lkml/20250929061213.1659258-1-jianyungao89@gmail.com/
> 
>  kernel/sched/core.c     | 2 +-
>  kernel/sched/cputime.c  | 2 +-
>  kernel/sched/fair.c     | 8 ++++----
>  kernel/sched/wait_bit.c | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7f1e5cb94c53..af5076e40567 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6858,7 +6858,7 @@ static void __sched notrace __schedule(int sched_mode)
>  		/*
>  		 * We pass task_is_blocked() as the should_block arg
>  		 * in order to keep mutex-blocked tasks on the runqueue
> -		 * for slection with proxy-exec (without proxy-exec
> +		 * for selection with proxy-exec (without proxy-exec
>  		 * task_is_blocked() will always be false).
>  		 */
>  		try_to_block_task(rq, prev, &prev_state,
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index 7097de2c8cda..2429be5a5e40 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -585,7 +585,7 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
>  	stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
>  	/*
>  	 * Because mul_u64_u64_div_u64() can approximate on some
> -	 * achitectures; enforce the constraint that: a*b/(b+c) <= a.
> +	 * architectures; enforce the constraint that: a*b/(b+c) <= a.
>  	 */
>  	if (unlikely(stime > rtime))
>  		stime = rtime;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 18a30ae35441..b1c335719f49 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5381,7 +5381,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  		bool delay = sleep;
>  		/*
>  		 * DELAY_DEQUEUE relies on spurious wakeups, special task
> -		 * states must not suffer spurious wakeups, excempt them.
> +		 * states must not suffer spurious wakeups, exempt them.
>  		 */
>  		if (flags & (DEQUEUE_SPECIAL | DEQUEUE_THROTTLE))
>  			delay = false;
> @@ -5842,7 +5842,7 @@ static bool enqueue_throttled_task(struct task_struct *p)
>  	 * target cfs_rq's limbo list.
>  	 *
>  	 * Do not do that when @p is current because the following race can
> -	 * cause @p's group_node to be incorectly re-insterted in its rq's
> +	 * cause @p's group_node to be incorrectly re-insterted in its rq's

s/re-insterted/re-inserted/

Thanks,
Madadi Vineeth Reddy

>  	 * cfs_tasks list, despite being throttled:
>  	 *
>  	 *     cpuX                       cpuY
> @@ -12161,7 +12161,7 @@ static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
>  		 * sched_balance_newidle() bumps the cost whenever newidle
>  		 * balance fails, and we don't want things to grow out of
>  		 * control.  Use the sysctl_sched_migration_cost as the upper
> -		 * limit, plus a litle extra to avoid off by ones.
> +		 * limit, plus a little extra to avoid off by ones.
>  		 */
>  		sd->max_newidle_lb_cost =
>  			min(cost, sysctl_sched_migration_cost + 200);
> @@ -13176,7 +13176,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
>  	 * If a task gets attached to this cfs_rq and before being queued,
>  	 * it gets migrated to another CPU due to reasons like affinity
>  	 * change, make sure this cfs_rq stays on leaf cfs_rq list to have
> -	 * that removed load decayed or it can cause faireness problem.
> +	 * that removed load decayed or it can cause fairness problem.
>  	 */
>  	if (!cfs_rq_pelt_clock_throttled(cfs_rq))
>  		list_add_leaf_cfs_rq(cfs_rq);
> diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
> index 1088d3b7012c..47ab3bcd2ebc 100644
> --- a/kernel/sched/wait_bit.c
> +++ b/kernel/sched/wait_bit.c
> @@ -207,7 +207,7 @@ EXPORT_SYMBOL(init_wait_var_entry);
>   * given variable to change.  wait_var_event() can be waiting for an
>   * arbitrary condition to be true and associates that condition with an
>   * address.  Calling wake_up_var() suggests that the condition has been
> - * made true, but does not strictly require the condtion to use the
> + * made true, but does not strictly require the condition to use the
>   * address given.
>   *
>   * The wake-up is sent to tasks in a waitqueue selected by hash from a



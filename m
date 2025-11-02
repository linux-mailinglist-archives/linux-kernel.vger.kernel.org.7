Return-Path: <linux-kernel+bounces-881649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7DEC28A36
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 08:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1229E3AD5EE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 07:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1B121FF45;
	Sun,  2 Nov 2025 07:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KbpJn5++"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A942192F9
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 07:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762067642; cv=none; b=IBU+lSvwePb79UFNywyIvRPI8vsYEn6/dwTTzmY3XuUaSRdpDKH0ACIIkpbfzA2FabiqLVAsRCYtdXWQ/hQ1VJaG7goz98kwT/XJDJhvkSWnqcewZ4vkfvV6nEbDxRDAdVFVLB5HCcqjMjYUcZPpyYVMP22t+lyilLgq3JeivI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762067642; c=relaxed/simple;
	bh=ZTGGVntVLyI7AoKSgQULzMU0xo3xHM2fRLteBtTkqac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7BZ/pmqz6a2p1CCM+hypyytBMyhJIXXunNdf4+ejKxy04xNkpJ7ai/G9mgojZkNe4Q3+zfpcRehRib+JdcPU/0cAuoP0a1NMPy/LmLVYDxD4Mnkd/YU/82rltxeqPZw4otH7AaCSQXL8MOEWI7h8Y3H0glZLXES8metDuyxU9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KbpJn5++; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1602rt018326;
	Sun, 2 Nov 2025 07:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FvM76M
	ter8lSXFhyTHq9cHVd6JE5gCQczefG5yJkH/A=; b=KbpJn5++9vwp+ahQt4QbIE
	eK7P/4sTSJvWhFXLYQZROPwUK36SBhthbVrP0rnKL82uHHdtGIH8OZ01aDTaBVUC
	N3UTaD/QWNZ6dRJDA0NvkfzdpixxRZvI+U9d60r/vq4fYEvIcqLZBjNKBcDwZ4i1
	Pa3S1bdv3jZqxxk/LowwE4WtZpas3t08cT35NrFw8OmPQQtq8XoFYOTBY0jlbRX1
	wgEN90tGNNlQfcbXhMCcF/nMYl2Q+SqjccWjBxL3hc/rTgQQhb277iB/7ccLPOoY
	6KG4x4qMQYyy78SM00fbo4Ml+nS7kIoDlACPa5j2NfrpnmU6sZWbMa7vrn5IB15A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59vu2wb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Nov 2025 07:12:30 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A27CTEo007709;
	Sun, 2 Nov 2025 07:12:29 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59vu2wb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Nov 2025 07:12:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A271g4I027464;
	Sun, 2 Nov 2025 07:12:28 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5vwy0vbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Nov 2025 07:12:28 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A27CRCj27460224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 2 Nov 2025 07:12:27 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70A4958060;
	Sun,  2 Nov 2025 07:12:27 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62F2B58056;
	Sun,  2 Nov 2025 07:12:20 +0000 (GMT)
Received: from [9.43.108.135] (unknown [9.43.108.135])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  2 Nov 2025 07:12:19 +0000 (GMT)
Message-ID: <42541486-45ef-484a-a409-779dcb8f7b29@linux.ibm.com>
Date: Sun, 2 Nov 2025 12:42:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: Prefer cache locality for EAS wakeup
To: Shubhang Kaushik <shubhang@os.amperecomputing.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Shubhang Kaushik <sh@gentwo.org>,
        Shijie Huang <Shijie.Huang@amperecomputing.com>,
        Frank Wang <zwang@amperecomputing.com>,
        Christopher Lameter <cl@gentwo.org>,
        Adam Li <adam.li@amperecomputing.com>, linux-kernel@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20251030-b4-follow-up-v2-1-19a23c83b837@os.amperecomputing.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20251030-b4-follow-up-v2-1-19a23c83b837@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7aXy-A3cuKJQdRxI9C0qPCE1-lE-ORs3
X-Proofpoint-GUID: 9DWFgudUm5O2ZYNNMk8Yf52OTnPtVIgz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX4VR2BEmxzx8+
 BdHbg721VejtgbU/3zoJCv2Vlj3JY/bFbmSDloh6ikxwEBY9pqtoeX+1Q+o683UmKOtICMjcivX
 rf9q+o+/kaut/XoeIM38rszRIxhxDY9DXkw6uhn4NarTT0//Qbekwb9+08+AhXcXmfC4VfkJrNW
 9m8ZJJTvRYZFJHo0xr1efvjF9h8TytPEFRVtag8GtIU3OKMVbS7xRr5qrupI+cgKfflgVxUZsKn
 /m510/4zIvAjMcf+2tutO3MoHHsK61x5BDPQr0OPxuFTjuYDh1ip+KkJvHPyTCtgsLbv8wzJI/Z
 Q3IZlUNzAEkjahLMzhnCOP+jy1tM7GHqexJ106Gc6NZqBQFOZashxc462mPp5fAPq/nxRWH21GG
 1lsi97aHswKxMzYuDbibkw8A9pvtew==
X-Authority-Analysis: v=2.4 cv=U6qfzOru c=1 sm=1 tr=0 ts=6907045e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=vzhER2c_AAAA:8 a=GMmcQ8BEhZfpoHoJ1HUA:9 a=QEXdDO2ut3YA:10
 a=0YTRHmU2iG2pZC6F1fw2:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511010021

Hi Shubhang,

On 31/10/25 00:49, Shubhang Kaushik wrote:
> When Energy Aware Scheduling (EAS) is enabled, a task waking up on a
> sibling CPU might migrate away from its previous CPU even if that CPU
> is not overutilized. This sacrifices cache locality and introduces
> unnecessary migration overhead.
> 
> This patch refines the wakeup heuristic in `select_idle_sibling()`. If
> EAS is active and the task's previous CPU (`prev`) is not overutilized,
> the scheduler will prioritize waking the task on `prev`, avoiding an
> unneeded migration and preserving cache-hotness.
> 
> ---
> v2:
> - Addressed reviewer comments to handle this special condition
>   within the selection logic, prioritizing the
>   previous CPU if not overutilized for EAS.
> - Link to v1: https://lore.kernel.org/all/20251017-b4-sched-cfs-refactor-propagate-v1-1-1eb0dc5b19b3@os.amperecomputing.com/
> 
> Signed-off-by: Shubhang Kaushik <shubhang@os.amperecomputing.com>
> ---
>  kernel/sched/fair.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 25970dbbb27959bc130d288d5f80677f75f8db8b..ac94463627778f09522fb5420f67b903a694ad4d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7847,9 +7847,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	    asym_fits_cpu(task_util, util_min, util_max, target))
>  		return target;
>  
> -	/*
> -	 * If the previous CPU is cache affine and idle, don't be stupid:
> -	 */
> +	/* Reschedule on an idle, cache-sharing sibling to preserve affinity: */
>  	if (prev != target && cpus_share_cache(prev, target) &&
>  	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
>  	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
> @@ -7861,6 +7859,14 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  		prev_aff = prev;
>  	}
>  
> +	/*
> +	 * If the previous CPU is not overutilized, prefer it for cache locality.
> +	 * This prevents migration away from a cache-hot CPU that can still
> +	 * handle the task without causing an overload.
> +	 */
> +	if (sched_energy_enabled() && !cpu_overutilized(prev))
> +		return prev;
> +

The above !cpu_overutilized(prev) is placed before recent_used_cpu idle check.
This means if prev is busy (but not overutilized) and recent_used_cpu is completely
idle, the task returns to prev and misses the idle opportunity.

Is cache locality prioritized even over idle CPU availability?
Are there measurements showing this trade-off is worthwhile for real workloads?

Thank you,
Madadi Vineeth Reddy

>  	/*
>  	 * Allow a per-cpu kthread to stack with the wakee if the
>  	 * kworker thread and the tasks previous CPUs are the same.
> 
> ---
> base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
> change-id: 20251030-b4-follow-up-ff03b4533a2d
> 
> Best regards,



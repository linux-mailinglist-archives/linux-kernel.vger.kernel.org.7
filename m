Return-Path: <linux-kernel+bounces-758672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515A8B1D270
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE935614F7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 06:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D047D218858;
	Thu,  7 Aug 2025 06:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tFBl3cCo"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847DC1537A7
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 06:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754547766; cv=none; b=AcdJ+ariMHq0UCKe2kV93JB8lCp8/F6OLM7KxWpKnXTHK+2oh6fvCRq0Z3tKy1EgcPej+3LlE/7ZR+wZblnbUrABb4W20x8VPVhsb18X9UNpL/Og3h9qtZAipjETGW4oFfqik6XxLvkvy/TU6ycke/YG9mUk/S1N0KzLQvtUPA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754547766; c=relaxed/simple;
	bh=jNkuopI+OkDjIMPsvMFlMBZKgvL/BtT/XE0AQAfew6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=InXpUq3A6UfbJ06N9UXvu+V/PCv+Q61RDn3oHyDNd0HmBh7zaaoRKckLt51jQDCO+a6UcjLnfSoq4Lumb2ZsWRNnMyS8jDTrlsD2NHaj8rcvdH3qIIuA1LWU6/2NdF2fV8YtaOtK9SX+rise3jbhgcNiSNTN5JqLEZKNIjXWd6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tFBl3cCo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5773tdgU012305;
	Thu, 7 Aug 2025 06:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FvvRU5
	cMSaVqleMEnCbx9ht6rVemaJrjHuU3dpp/4TU=; b=tFBl3cCojPBc6XYdYEnL/4
	vBam5opZYOFTdx5Ce741RqF4D2af00PUSaYBWvDFVWomb2P+dVHR9eoSD4ciDhUM
	KE8+iM9pdRMFlzA7QLS31njUn/HcGns9fvP+xs6Uco0gLJAmT5PiSvVPlkvxHwRw
	/LKZPRlSbDNBGvo+YnTMHK2+QVi7VUabZ/TEzkaXmIiFmmKkr47mA0/RDZK91Fj1
	hY9mGXukfYPNnrxK1fFSTNH7ZzO8kqV7TGqFLVj7UvqLkRE16xIFpbo35x/oMmnc
	8jEbV7muV3cTlZXoZMEP1IvOKtEo5NZyG4WHqv5CkbuuQurErauk4AYoCbA1oFvQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63rb6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 06:22:03 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5776M338011303;
	Thu, 7 Aug 2025 06:22:03 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63rb6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 06:22:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5775YHBa031314;
	Thu, 7 Aug 2025 06:22:02 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwnf834-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 06:22:02 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5776M2Yw33292700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Aug 2025 06:22:02 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3797158445;
	Thu,  7 Aug 2025 06:22:02 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A1BB58440;
	Thu,  7 Aug 2025 06:21:57 +0000 (GMT)
Received: from [9.67.88.77] (unknown [9.67.88.77])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Aug 2025 06:21:56 +0000 (GMT)
Message-ID: <22e5bd44-1bba-4cc4-be21-04bbd9702da8@linux.ibm.com>
Date: Thu, 7 Aug 2025 11:51:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Update stale comments referencing last/skip
 buddy
To: Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, Adam Li <adamli@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org
References: <20250805122316.1097085-1-quic_zhonhan@quicinc.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20250805122316.1097085-1-quic_zhonhan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA0NyBTYWx0ZWRfX01d3TWcoC8ok
 HpZ6n4yO1nwRPZe5G3x8yWDW23gG6Dq5JyP+o6Q9KZG/ebQtXY2P7yKhANcgsqk600O31WT9da3
 BzUTB6WJpg24JstBuFIkcJS9l1vXD7YU3wVXehrmE9fGj9cK8+zgevxJKUsiB5ae4Bi+wZJlsGr
 t76/bn6X8Wqqwwt4a6YBajWB+64CP+xNBH0Bb+6PQ+uF0iT2b5yWWQRa6sJJzeOzJvcsxqFTBzx
 5qq6K9qLASccwlQQsABGAsGe/jPSEstYluRW+hPfp9jPa9cWy09ifwBqnrzNqu4UzzGWxh2u0u7
 hpam1zHJAI69yIK9LqOB9lHXFLDHueUwEz0m+m8OwZ2xiUF4PrYXUqP5epYZfcfJkjhsD3/Lkbe
 RAFCoSsRHAnuRBA90bPIFdKJBAdMHJpJMoSvkQIy4SMQqbdmQrahsPYOHySNauAJBol1OaRN
X-Proofpoint-ORIG-GUID: 0RpAP8Jhp4VEUdXhf8xYx5GuvcNA5Bo4
X-Authority-Analysis: v=2.4 cv=LreSymdc c=1 sm=1 tr=0 ts=6894460b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=COk6AnOGAAAA:8 a=QltLfnY_znEH1c5NIH8A:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: qLxO6T_c4yGcgzhreef38K8fCbts9MCI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508070047

Hi Zhongqiu,

On 05/08/25 17:53, Zhongqiu Han wrote:
> Since the integration of EEVDF, the last/skip buddy scheduling features
> have been removed. This patch updates outdated comments that still
> reference these legacy behaviors to avoid inconsistencies.
> 
> Fixes: 5e963f2bd465 ("sched/fair: Commit to EEVDF")
> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
> ---
>  kernel/sched/fair.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b173a059315c..b3618aa075ec 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5500,11 +5500,11 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags);
>  
>  /*
> - * Pick the next process, keeping these things in mind, in this order:
> - * 1) keep things fair between processes/task groups
> - * 2) pick the "next" process, since someone really wants that to run
> - * 3) pick the "last" process, for cache locality
> - * 4) do not run the "skip" process, if something else is available
> + * Pick the next sched_entity to run from cfs_rq.
> + *
> + * Prefer ->next buddy if sched_feat(PICK_BUDDY) is enabled and it's eligible,
> + * to improve cache locality.
> + * Otherwise, pick the entity via EEVDF for fairness and latency control.
>   */
>  static struct sched_entity *
>  pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
> @@ -8673,9 +8673,9 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	 *
>  	 * Note: this also catches the edge-case of curr being in a throttled
>  	 * group (e.g. via set_curr_task), since update_curr() (in the
> -	 * enqueue of curr) will have resulted in resched being set.  This
> -	 * prevents us from potentially nominating it as a false LAST_BUDDY
> -	 * below.
> +	 * enqueue of curr) will have resulted in resched being set. This
> +	 * prevents further preemption handling, including checks and potential
> +	 * reschedule triggering.
>  	 */
>  	if (test_tsk_need_resched(rq->curr))
>  		return;

Sent similar patch here https://lore.kernel.org/lkml/20250314090128.25141-1-vineethr@linux.ibm.com/
[PATCH] sched/fair: Remove stale references to LAST_BUDDY and SKIP_BUDDY

Thanks,
Madadi Vineeth Reddy


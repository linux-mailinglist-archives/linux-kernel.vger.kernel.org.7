Return-Path: <linux-kernel+bounces-725058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE012AFFA4B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C173E1898978
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CDD21B195;
	Thu, 10 Jul 2025 07:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F2aU0Bdk"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F4CFC1D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752130836; cv=none; b=HXnVGXc0Rtq92Z3mtrjmKQak/x8M3soEseiQv3nRfrapPkPU84gUpWuH4wSYA+GxLPfbn462K5VVNQ/+EaCRX8yNOVEVhTSQJseYRm2XKlqjETuomd/7wbAQn8J+VOba7MAvzzHpI84IC02MwBTX8Uk5aXuHGXf2jjWsZrOsQUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752130836; c=relaxed/simple;
	bh=7DyRwtuwkoUNFy1D5GpM7rEGKQatWVWgDaWpqNddLGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=nPjA1y/gHWO1qE8tO5+r1NAAYUsuEvR3CgyTdn0e7+6iupFaquVvmWNdltcqni6hD5PmfSKYi9LLBgrBKz2hdymoTdrMhoWXs0iWkrX0NhkSCSjHhgs5hViIipR0omeAVLnH1u6vqvdhDCL7tgeljSpRUUOrJwCgwaHwDXhCZJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F2aU0Bdk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569LUB5x026476;
	Thu, 10 Jul 2025 07:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uapv11
	hwBntzMJYhyMmsBdexJ/CxCBe/wW0On8OtbWI=; b=F2aU0BdkN7lR9S+qMsgF+K
	oJuVSHXvCRoKwJ6QGmZWu9/vxj5Y12yPqaFJwdWjNY4FQc4xWSHT3vO7e5yPQhCc
	68oGlWryMlMl+h38oDztgmBC/8XuCgpWLljrE5vkSDDQzkDQHlQnBzjFp8+lewWe
	tBXrlPGcAtsgU1ESmEdrXQEJEWq4zEVRBRJAEliYktENJt4rq2bVfOyvgyq61Lvt
	Dy/Gm0Kkdbm1WZ5HXw5SWkrX3CdY/0zHnsMLLu+NSTSaXpnvsp1y2CYLkpERo0zN
	u/cr5iDfs3z53R+tO/Mtz00r6AZLJhdwfSqljU+rZ4Fdsz2LD7yb1o2K9/End+TA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47pussb915-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 07:00:07 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56A6oBVA001934;
	Thu, 10 Jul 2025 07:00:06 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47pussb912-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 07:00:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56A5wvuj010790;
	Thu, 10 Jul 2025 07:00:05 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qes0chwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 07:00:05 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56A705cj41026104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 07:00:05 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE22758063;
	Thu, 10 Jul 2025 07:00:04 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF3E158065;
	Thu, 10 Jul 2025 07:00:00 +0000 (GMT)
Received: from [9.204.206.228] (unknown [9.204.206.228])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 07:00:00 +0000 (GMT)
Message-ID: <5bbe61ee-d384-47b9-b6f2-c9f607f00156@linux.ibm.com>
Date: Thu, 10 Jul 2025 12:29:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] sched/fair: Limit run to parity to the min slice
 of enqueued entities
To: Vincent Guittot <vincent.guittot@linaro.org>
References: <20250708165630.1948751-1-vincent.guittot@linaro.org>
 <20250708165630.1948751-5-vincent.guittot@linaro.org>
Content-Language: en-US
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, dhaval@gianis.ca,
        linux-kernel@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20250708165630.1948751-5-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Vaj3PEp9 c=1 sm=1 tr=0 ts=686f64f7 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=LmcLtsNzV1WpfnEq:21 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=1loupnIqrAf6m2OXCqwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: zZiTaS5GVENVCgO-xJjZXdyk3sbIGTHc
X-Proofpoint-ORIG-GUID: pHZtI4CCz5R1n7RiMGMvIcJo6aaybHqe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA1NyBTYWx0ZWRfX4fPGG41OJ0Xl dyrGCwxmzfBFFSFTzm4a1Dz5Yw/3LNxomUI9JGDz4x5IP9EXrFl+6YYruTzbc8JyVz3r2bSc9Qk blxcVJ8VjhNef9aoegS7YBGVvVN72a5p0MD7NXoFTWlxiG9HPppwfdOkWV+2PMI6znjlfVCTZn0
 +D6ClAbq0qUIUCRAdLzMufLGWnsuA7WV2dHtsd8g8x8bi/czNEkX6F2VBf9V3Yga4FsQYFPqSBj uUy/EWiO3Wz9ZQ/VhmJQk3Zv4aDWexz4Z6enwOHpgif6nPu5rYGwnHYBrMtG9pYAIX6SU0K/Q0Y HV1lEgIaxEYULUfjERlRQhCR+4WxUANbUfZ5sm1VrX0mCPnN+5a6zYz8fgL/LzW6zerSiTG/de7
 x2FRMs8v5NoNyOJZlDQXiGwWtH8SlU6pDjIHCzI7rPYo+tAPaV8lw9rJbpmaKV3OY1g2vXCL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100057

Hi Vincent,

On 08/07/25 22:26, Vincent Guittot wrote:
> Run to parity ensures that current will get a chance to run its full
> slice in one go but this can create large latency and/or lag for
> entities with shorter slice that have exhausted their previous slice
> and wait to run their next slice.
> 
> Clamp the run to parity to the shortest slice of all enqueued entities.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7e82b357763a..85238f2e026a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -884,16 +884,20 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
>  /*
>   * Set the vruntime up to which an entity can run before looking
>   * for another entity to pick.
> - * In case of run to parity, we protect the entity up to its deadline.
> + * In case of run to parity, we use the shortest slice of the enqueued
> + * entities to set the protected period.
>   * When run to parity is disabled, we give a minimum quantum to the running
>   * entity to ensure progress.
>   */

If I set my task’s custom slice to a larger value but another task has a smaller slice,
this change will cap my protected window to the smaller slice. Does that mean my custom
slice is no longer honored?

Thanks,
Madadi Vineeth Reddy

>  static inline void set_protect_slice(struct sched_entity *se)
>  {
> -	u64 quantum = se->slice;
> +	u64 quantum;
>  
> -	if (!sched_feat(RUN_TO_PARITY))
> -		quantum = min(quantum, normalized_sysctl_sched_base_slice);
> +	if (sched_feat(RUN_TO_PARITY))
> +		quantum = cfs_rq_min_slice(cfs_rq_of(se));
> +	else
> +		quantum = normalized_sysctl_sched_base_slice;
> +	quantum = min(quantum, se->slice);
>  
>  	if (quantum != se->slice)
>  		se->vprot = min_vruntime(se->deadline, se->vruntime + calc_delta_fair(quantum, se));



Return-Path: <linux-kernel+bounces-758682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B071B1D28D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528091AA2048
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 06:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E833221704;
	Thu,  7 Aug 2025 06:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sGWQU9Ge"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50C01D516F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 06:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754548702; cv=none; b=tpweo1foFE/h7/t1il+io7Zvyo1KlzJWjft0u3iPT6KD5wVRI2+W0Wp4TL2yUaBE9eLvBtLZaY79ey3pW/Tah/KV6EjrMnVR1uXR6eCO0qZaAQoWbFIVn7cjHLBt5hJzmgTELNbaiGsktpZJr5PdY1mWgTzDMcY3mN52yNzgw8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754548702; c=relaxed/simple;
	bh=NaHeBeboawkQZN7VuEvlphwxCwIvNRoU9hVoqOnhAcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mB71anEZZJRXGFDc/o/vq9nDehQ0mf1l4USRqz6xZMsQMpdlAx2k9pkCawV5Sn9VIT6x3uyKARRHGI/6m3BAbFS7r6V33g8MiF3xx5ZaRc5K1hdA6Beo3IuVDsx3VOmdMXaiU0LvEZyXHoXOyw+NYKNIltQC4e1mfj/w0iojiEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sGWQU9Ge; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576IJgH4021584;
	Thu, 7 Aug 2025 06:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IzNx+T
	s4Sj8KTSFzoPL/V2RPpf7rbjSgqMLYZqc30z4=; b=sGWQU9Geqz0qhR/+T3tX+y
	S0J3M50WeDYZI9tFIKRefYqMmD2xvPW+pkZrhFWzdV/7/h9MGHjCz0io7M2JIpsv
	K3iScxplXsEQBcbKCRxHEECGUb402jnFhyS+TeQLDcJV3bseR9wgewpfgaoc6n7A
	VOqUR254QZ4EedKbGmElo2UhqMMiCfd1SOHcxJEmXzqIDirczbouDyhchLxm9eiX
	uewHZEtybXFF0mvA6QvXmv9vqPuEDemFBdgk8vt1s3xDk9pQ7Xtt8dVJ73Q1i8hZ
	RQoGXT+Yc7U7IxU6AAchxvQp73J6sv3fto8tRD86tv9jtdn2c/r/ha4kY/mUbrtw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq620eg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 06:37:39 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5776bcVV003309;
	Thu, 7 Aug 2025 06:37:38 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq620efx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 06:37:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5775Z3e2022687;
	Thu, 7 Aug 2025 06:37:37 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwqf9yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 06:37:37 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5776bZxx27132422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Aug 2025 06:37:35 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A31D581AE;
	Thu,  7 Aug 2025 06:37:35 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD192581A3;
	Thu,  7 Aug 2025 06:37:29 +0000 (GMT)
Received: from [9.67.88.77] (unknown [9.67.88.77])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Aug 2025 06:37:29 +0000 (GMT)
Message-ID: <13be1ce2-85b5-46e2-aab8-94aa7f8a0cfe@linux.ibm.com>
Date: Thu, 7 Aug 2025 12:07:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Remove stale references to LAST_BUDDY and
 SKIP_BUDDY
To: 20250314090128.25141-1-vineethr@linux.ibm.com,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Adam Li
 <adamli@os.amperecomputing.com>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20250314090128.25141-1-vineethr@linux.ibm.com>
 <4da6d43b-59f6-48e4-b58c-2f0792035851@linux.ibm.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <4da6d43b-59f6-48e4-b58c-2f0792035851@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA0NyBTYWx0ZWRfXzAQLRr5g8YcB
 azDlxagUzvgY2/ilgJPpjcajBlw0McGT0qkUwUArAb0ymKpuxXzVdNdDNbQO4DfoTuMzJVmC69y
 Sf1e/2NmbiHjS3VdQCzZDjum5G79MHucUJCGxhb5+DKhCP9iyPhpGKJ1AfFZIUld8VMpDRPWTYT
 9Tu6z7yisXSfLnvAf0McxDLZkhXvt3it8XC7KtSar1BJOiDFGbVR+OajBiZ+w7Ci/Fi0fhgRpws
 DQE8B2CRQdryl8k8mis/7Y0fjlf0bhGAlsufcv0P98n1J2H5XlyIaWk3v4ak1gbpU8tkf6m6UBL
 PeF17eslyQLVB9O02eLfhNqhroWAPub1DLbAY/J+qzTp6Javf33io+SxgOVj/ap2Idyvr92CJ1i
 w1nXnaUnTE5Sv97VV/bX4FiM6By8NvDlHXzjzDSet9KMjwCCoRyfw5+DvF75n0fxMzEanUUw
X-Proofpoint-GUID: UMOkaenvapBH4qSNnJPOd9d07qYQJNv2
X-Authority-Analysis: v=2.4 cv=BIuzrEQG c=1 sm=1 tr=0 ts=689449b3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=vzhER2c_AAAA:8 a=VnNF1IyMAAAA:8
 a=ITTc_KzUxks3pkYUosUA:9 a=QEXdDO2ut3YA:10 a=0YTRHmU2iG2pZC6F1fw2:22
X-Proofpoint-ORIG-GUID: yCfuYDoR0q0r-vLeIjOIP1qTe7m4M3Ax
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 malwarescore=0 phishscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508070047

On 13/04/25 09:40, Madadi Vineeth Reddy wrote:
> Hi Peter, Ingo,
> 
> Ping.
> 
> Any thoughts on this? Can it be picked up?
> 
> Thanks,
> Madadi Vineeth Reddy

Hi Peter, Ingo,

This still applies cleanly on top of tip/sched/core.

Could this be considered for merging?

Thank you,
Madadi Vineeth Reddy

> 
> On 14/03/25 14:31, Madadi Vineeth Reddy wrote:
>> Commit 5e963f2bd465 ("sched/fair: Commit to EEVDF") removed the
>> functionality associated with LAST_BUDDY and SKIP_BUDDY. However,
>> some outdated references remained in the comments for pick_next_entity
>> and check_preempt_wakeup_fair. This commit cleans up those comments
>> to maintain clarity and correctness.
>>
>> No functional change intended.
>>
>> Co-developed-by: Adam Li <adamli@os.amperecomputing.com>
>> Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
>> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
>> ---
>>  kernel/sched/fair.c | 6 +-----
>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 9dafb374d76d..379dbcbb24e9 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5578,8 +5578,6 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags);
>>   * Pick the next process, keeping these things in mind, in this order:
>>   * 1) keep things fair between processes/task groups
>>   * 2) pick the "next" process, since someone really wants that to run
>> - * 3) pick the "last" process, for cache locality
>> - * 4) do not run the "skip" process, if something else is available
>>   */
>>  static struct sched_entity *
>>  pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
>> @@ -8780,9 +8778,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>>  	 *
>>  	 * Note: this also catches the edge-case of curr being in a throttled
>>  	 * group (e.g. via set_curr_task), since update_curr() (in the
>> -	 * enqueue of curr) will have resulted in resched being set.  This
>> -	 * prevents us from potentially nominating it as a false LAST_BUDDY
>> -	 * below.
>> +	 * enqueue of curr) will have resulted in resched being set.
>>  	 */
>>  	if (test_tsk_need_resched(rq->curr))
>>  		return;
> 



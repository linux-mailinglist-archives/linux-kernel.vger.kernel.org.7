Return-Path: <linux-kernel+bounces-766143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8989B242CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EDA0166103
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AAF2D5C9F;
	Wed, 13 Aug 2025 07:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cK1niy61"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDD32C3248
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755070254; cv=none; b=X+x+OMKgkmiGYwlrXQNuES30sYT+WtZPHM2Sblrd7TIdB79zL/pEq7RaCvYH5coPSSnmMHrh1qo4beI9BpubhbsrvU8fvlF18v58/ayeMBChxMPPcMFP/ZQw408/52teBNK3ZL3IETsytPbUAhcuJ89Qoj5LrvhwTq5l1TZ+jXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755070254; c=relaxed/simple;
	bh=Krs/1EOnnSDk8SYhKTWe0TtedIiWccyCLriWdmm4g60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKwgF/zicYTLm/oreIzQbQfucCSgiKW6QUFp3m8exKcQIF+pSByzSpb+cXuASreIbcGN6MeQ54UyqulYxCzdzjqLArDOJqjLtrpuFUTybUihAf+5MsoOhHxMoUURBaBnKr8Tsq3wLvQQDZ0N+cuzI22D3TsibNx5a1BdgyyqmKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cK1niy61; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CNQKXR008652;
	Wed, 13 Aug 2025 07:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vKoM3A
	RpLg//NBYrYR5Q/HBPv28+6Hp3kWSaS7QESiE=; b=cK1niy61QNWe2lFpphHU73
	s/b2lKpBRNpeeIPMAgLfeEuou3EZrf0QQaW59sl6Nu7IZza+zF7mMHHWWckeZJ2T
	qDjIdG0VuyObYr9YKwoQGj2Dz9KoeNa+8jXkMy/Xlso11L2glRHrjYpvONahf9c1
	lIF7uRW8n+jEPRYPVB9TRF/JCCeaNK3Xutl3m3MLTMekDX1XA4brDloGNm3T8JiJ
	aAPlyE8Qb1wpkC7L/mNauYqbH/tRTe3H6nxoKusXV40iZzRji4nNIgKuUAqaRhf2
	1UhQnbLZGyBPshOtnTxYuy+9CFOq+w2lyN5h5+K/mHCvYEwJJQvqgmYb1Wpdsv3Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48durub4dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 07:30:38 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57D7JWGe024621;
	Wed, 13 Aug 2025 07:30:37 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48durub4d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 07:30:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57D398eK028658;
	Wed, 13 Aug 2025 07:30:37 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ej5n64v2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 07:30:37 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57D7UaCA33489502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 07:30:36 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67A8058059;
	Wed, 13 Aug 2025 07:30:36 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DB7E58061;
	Wed, 13 Aug 2025 07:30:32 +0000 (GMT)
Received: from [9.43.45.243] (unknown [9.43.45.243])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Aug 2025 07:30:31 +0000 (GMT)
Message-ID: <affdc6b1-9980-44d1-89db-d90730c1e384@linux.ibm.com>
Date: Wed, 13 Aug 2025 13:00:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Reorder some fields in struct rq.
To: Blake Jones <blakejones@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc: Josh Don <joshdon@google.com>,
        Dietmar Eggemann
 <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20250730205644.2595052-1-blakejones@google.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20250730205644.2595052-1-blakejones@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0_Y0BHuQjeSgVHDflaUloukmNvgML8Wa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX7hJ+9bfPbeZM
 ucBkBMzXkVFg0dtna8VkXBW9iqsuu5eneQAm3BhoO/WJ2X9ZXV97+Mw2itwSGoT+2c8DbxT9CpJ
 4NWrrcdrgX8vYSmoJ4XOTwC8E1EmPbdruor+Xt4VXri+jvFBTx7vWhIIk0QjL2BDl2nQpDorJzr
 cEcpPSHDCTlSa5/h9Nb9tXDCzFOGqHB0BEqrEAE69dt3vSK5vsdENsPUMU6RkdMYqpYcNLr0xaz
 au65pl/52gvJGD+swi+skWZoB8ZUetkEPwlpMTDLA9QELkHGWhRQNBl2lcIzQRcE/69gcLAMJwr
 ktrNgs64OJV9+pfJaCoThF/CwJlUEwEV4BwRcAGDt9+ZVRXe0nCq5TvOwOdikonPJfsUUlhQldb
 N0nFLaUq
X-Authority-Analysis: v=2.4 cv=QtNe3Uyd c=1 sm=1 tr=0 ts=689c3f1e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=y3VEHs0CwlllnRbVHRsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: zNad-4G03UJwIQ7OQ2nbR2S6EkHu0-BZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0
 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224

Hi Blake,

On 31/07/25 02:26, Blake Jones wrote:
> This colocates some hot fields in "struct rq" to be on the same cache line
> as others that are often accessed at the same time or in similar ways.
> 

[..snip..]

> 
> This patch does not change the size of "struct rq" on machines with 64-byte
> cache lines. The additional "____cacheline_aligned" to put the runqueue
> lock on the next cache line will add an additional 64 bytes of padding on
> machines with 128-byte cache lines; although this is unfortunate, it seemed
> more likely to lead to stably good performance than e.g. by just putting
> the runqueue lock somewhere in the middle of the structure and hoping it
> wasn't on an otherwise busy cache line.

This change introduced an 88 byte hole due to having __lock in a different
cache line on Power11 which is 128 byte architecture which led to one cacheline
more than before.

Tested with your custom test case (thanks for sharing) and observed around
~5% decrease in the number of cycles, along with a slight increase in user
time — both are positive indicators.

Also ran ebizzy, which doesn’t seem to be impacted. I think it would be good
to run a set of standard benchmarks like schbench, ebizzy, hackbench, and
stress-ng, along with a real-life workload, to ensure there’s no negative
impact. I saw that hackbench was tried, but including those numbers would
be helpful.

Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Thanks,
Madadi Vineeth Reddy

> 
> I ran "hackbench" to test this change, but it didn't show very conclusive
> results.  Looking at a profile of the hackbench run, it was spending 95% of
> its cycles inside __alloc_skb(), __kfree_skb(), or kmem_cache_free() -
> almost all of which was spent updating memcg counters or contending on the
> list_lock in kmem_cache_node. In contrast, it spent less than 0.5% of its
> cycles inside either schedule() or try_to_wake_up(). So it's not surprising
> that it didn't show useful results here.
> 

[..snip..]

> @@ -1182,8 +1199,6 @@ struct rq {
>  	struct root_domain		*rd;
>  	struct sched_domain __rcu	*sd;
>  
> -	unsigned long		cpu_capacity;
> -
>  	struct balance_callback *balance_callback;
>  
>  	unsigned char		nohz_idle_balance;



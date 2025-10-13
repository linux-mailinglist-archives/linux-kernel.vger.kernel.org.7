Return-Path: <linux-kernel+bounces-851034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27E8BD5617
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4FAE403ECA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EF1296BBC;
	Mon, 13 Oct 2025 16:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hwb2GOTv"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ED12C21D9
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760373687; cv=none; b=UBb6WSKFBLXMBAdjbUoxPtf1iv68/emQEA8pwtovNXDvQstTv81dB3COGngP34QvYoYtFdVrmapmbFNY2bjpgVLIfgC3i49T8VQsbXXO3ft14S9C+noz1/ig/QOaT53zitQOEXc6dcAhRCL89MqZ4KncPS+6ovRYgH/2xYt6ACo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760373687; c=relaxed/simple;
	bh=WPzi6r2qVvabEkimRUZFOxt9F2ZQWquwd2NrZTUXhmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YiM0S2MxuI3T/EMDN1xFra9L4tQwKg13zvNHQIp2LTaCkVytdesenBWnoecU7QKZsAzKCMCMEUUkJD0tNLryFTMzuFrPsezG9fDviM+aANBO25rNoioRfElRjTf1vsCHGJaOwYELk971x0QJmDRAMloMEq7ZQ50VHUJ7xj740Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hwb2GOTv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DBmqLB016900;
	Mon, 13 Oct 2025 16:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=s6zXXE
	Tg6weOdUZ+i5Uep1lXgDbqfEnhCvMg8i/XkAA=; b=hwb2GOTvTj0BOKKX9XnyX5
	g820o4l5JIeznhXKPjGBBa/MWr3YkWTqhLKd8zH1uYfv/OxqzbbcOG++3h9OoX4B
	qqw0qWrGsBrWLzlXu6+I7/pKm6l3Bt/PCrU1+EozCl9WUR4HRiPD5r7WSGUAVPw2
	/bcp6waKP4jiZcQnZzE4EdnjRVhfqNgismqq8lDcMKkAh4Nrda6OMI+hRtBA9+9e
	CfEOFJoaS2O6ew0Tz3pj6FOiP3RPniwd8s9TandONmoaBjlquCjGi1zrGxwXsDPn
	tOIwl+CzQaxR6eD3fNtW69dFUT3Lsd6mqkq1q1dhl1WTp1MVZRuBk/VDU1pkwE6A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnr26mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 16:41:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59DF4ZPV018397;
	Mon, 13 Oct 2025 16:41:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49s3rf0eh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 16:41:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59DGf8NE44171692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 16:41:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE16220043;
	Mon, 13 Oct 2025 16:41:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8EEE20040;
	Mon, 13 Oct 2025 16:41:06 +0000 (GMT)
Received: from [9.124.217.163] (unknown [9.124.217.163])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Oct 2025 16:41:06 +0000 (GMT)
Message-ID: <e09fb1c2-cf74-47ff-af6c-671fe23c2e90@linux.ibm.com>
Date: Mon, 13 Oct 2025 22:11:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] sched/fair: Skip sched_balance_running cmpxchg
 when balance is not due
To: "Chen, Yu C" <yu.c.chen@intel.com>, Peter Zijlstra
 <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Doug Nelson <doug.nelson@intel.com>,
        Mohini Narkhede <mohini.narkhede@intel.com>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>
References: <e27d5dcb724fe46acc24ff44670bc4bb5be21d98.1759445926.git.tim.c.chen@linux.intel.com>
 <20251013142638.GM3245006@noisy.programming.kicks-ass.net>
 <49dba7ff-8be6-40cf-9aa7-b0a5cb2f77c3@intel.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <49dba7ff-8be6-40cf-9aa7-b0a5cb2f77c3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5ZA6iws c=1 sm=1 tr=0 ts=68ed2ba7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=gHXSL_-MfW6troZJZr4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: VL-2fvfIKtx6TwUilS-AER6KNY-tWY_v
X-Proofpoint-ORIG-GUID: VL-2fvfIKtx6TwUilS-AER6KNY-tWY_v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDE0MCBTYWx0ZWRfXxH8ZLznmo6E7
 vhYlqRHdvdx+RfMFqiFBWPkOyEyeklob4DzOTzt6jHAuFEeu7SPDQCtnsmUWWrBXp9XO3eJX+Q+
 Rhn0NMHEhgRRyd+lIrPhgMgl5LiUOReoiJ3cE/lP8nxEyhBYC+Hcg0xn4P9PFsoqGsU5exipGLK
 Nr7MfluVJIB+1baHcj8GrZMzEXSrq2IFDOXR6woala5k/xheOfJ8GtZ0R/CLuxjG/FvBFOW7ykA
 AwZKurPnFOUitTgMI6Pu/jm7gWdcOhXL5+RZjHwlZImTH9fM6WCVKD/4qG8yRenes+oJv5tE/aG
 wPSqeIpZpVJWx6CBuBjJ75iXi2JPWcoqCZ309eUZ07QaOE7ST2d2BspoM+0Sv11qQXCxJNeyhQx
 xWMy+sFlGOhlD2IZOI4rge3hiXWhww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510100140



On 10/13/25 10:02 PM, Chen, Yu C wrote:
> On 10/13/2025 10:26 PM, Peter Zijlstra wrote:
>> On Thu, Oct 02, 2025 at 04:00:12PM -0700, Tim Chen wrote:
>>
>>> During load balancing, balancing at the LLC level and above must be
>>> serialized.
>>
>> I would argue the wording here, there is no *must*, they *are*. Per the
>> current rules SD_NUMA and up get SD_SERIALIZE.
>>
>> This is a *very* old thing, done by Christoph Lameter back when he was
>> at SGI. I'm not sure this default is still valid or not. Someone would
>> have to investigate. An alternative would be moving it into
>> node_reclaim_distance or somesuch.
>>
> 
> Do you mean the following:
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 444bdfdab731..436c899d8da2 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1697,11 +1697,16 @@ sd_init(struct sched_domain_topology_level *tl,
>                  sd->cache_nice_tries = 2;
> 
>                  sd->flags &= ~SD_PREFER_SIBLING;
> -               sd->flags |= SD_SERIALIZE;
>                  if (sched_domains_numa_distance[tl->numa_level] > 
> node_reclaim_distance) {
>                          sd->flags &= ~(SD_BALANCE_EXEC |
>                                         SD_BALANCE_FORK |
>                                         SD_WAKE_AFFINE);
> +                       /*
> +                        * Nodes that are far away need to be serialized to
> +                        * reduce the overhead of long-distance task 
> migration
> +                        * caused by load balancing.
> +                        */
> +                       sd->flags |= SD_SERIALIZE;
>                  }
> 
> We can launch some tests to see if removing SD_SERIALIZE would
> bring any impact.
> 
>>> On a 2-socket Granite Rapids system with sub-NUMA clustering enabled
>>> and running OLTP workloads, 7.6% of CPU cycles were spent on cmpxchg
>>> operations for `sched_balance_running`. In most cases, the attempt
>>> aborts immediately after acquisition because the load balance time is
>>> not yet due.
>>
>> So I'm not sure I understand the situation, @continue_balancing should
>> limit this concurrency to however many groups are on this domain -- your
>> granite thing with SNC on would have something like 6 groups?
>>
> 
> My understanding is that, continue_balancing is set to false after
> atomic_cmpxhg(sched_balance_running), so if sched_balance_domains()
> is invoked by many CPUs in parallel, the atomic operation still compete?
> 

 From what i could remember,

This mostly always happens at SMT after which continue_balancing = 0.
Since multiple CPUs end up calling it (specially on busy system)
it causes a lot cacheline bouncing. and ends up showing in perf profile.



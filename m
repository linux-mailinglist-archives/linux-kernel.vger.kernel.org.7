Return-Path: <linux-kernel+bounces-865637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E40D8BFDA71
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CC061A60985
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD81025E824;
	Wed, 22 Oct 2025 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KSx2SPeI"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC7F26ED44
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154972; cv=none; b=AnLS/Yx05L4aa8oSVBmp1gPpm+nKZQxz7m5rJpsxWR9TpAxAozgjUyvCxL7F6v6RdYZwhPrQRug33ZTYmqt1+W9cHw85443HVB5qBpvSdSSg9uqD790YC2pr0fZL0R/kUZqduO6XwhSmjJP5vM85TL86W+425FtLqoo5IHzgDnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154972; c=relaxed/simple;
	bh=vP/qi393QX6kgyFzYS/28jkebO12Gb7AVzVQu9i9AoQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jesDsotrkb/0DjXk3evhyEz8C6Tl0qdVKCFm3FhFc6MSbndrASM3NrKFRchecBABcEOBRWfBwLjCUuDfaSRR9IrkWOLyzwgthV+OycRkeibl+8tAxOXC8fOvKkXqIvGTwKmHK+6T13mvuzeR9Cv986jVdtz/KCN7aLAnk0+DhJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KSx2SPeI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MGvKUc004731;
	Wed, 22 Oct 2025 17:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=S3YwDy
	7Uuin/KFeuj+7Q0bntEJ/y5PcudWQ7eN+NjlU=; b=KSx2SPeIDwwc2cdyMwhv2F
	dF+1EpEaXv/DJigDATRAZP/V2woGNTq1nL8TU3E+gdHQNge8C9TWDT11lEhMFaSn
	1NlH535Cu6kc16moLfpRvk7slxUbTBN0jyB8BjWCW1z9xzRThf9mYFPPntPmXA3J
	FXyRv2Y2qNHcPNidX9HEHdcXXZDo8TM9Se1I+cYxWBfG9W68hUBBTWun7b563uUW
	hTa+yLCmkMSYi/aLUChj/pE1GOwusnHh0CJM3JaEtUHWSRt/e9pgIqDg0YpmXbLz
	x09TOM7fEKEJCgJTgSgjH9zenNFo6hn6CNv8JN7LqQspXvMRMmZwBK4WeRX9CDKw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326x5cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 17:42:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MHTxh8032092;
	Wed, 22 Oct 2025 17:42:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7n1mjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 17:42:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MHgbZJ46858570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 17:42:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2A5520043;
	Wed, 22 Oct 2025 17:42:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE34A20040;
	Wed, 22 Oct 2025 17:42:35 +0000 (GMT)
Received: from [9.39.25.222] (unknown [9.39.25.222])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 17:42:35 +0000 (GMT)
Message-ID: <a176acab-caf9-400a-8894-e7c88d684208@linux.ibm.com>
Date: Wed, 22 Oct 2025 23:12:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] sched/fair: Skip sched_balance_running cmpxchg
 when balance is not due
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Chen Yu <yu.c.chen@intel.com>,
        Doug Nelson <doug.nelson@intel.com>,
        Mohini Narkhede <mohini.narkhede@intel.com>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>
References: <e27d5dcb724fe46acc24ff44670bc4bb5be21d98.1759445926.git.tim.c.chen@linux.intel.com>
 <20251013142638.GM3245006@noisy.programming.kicks-ass.net>
 <aa3d20e6d451e0d0b812fe16e9d403c1033feeaa.camel@linux.intel.com>
 <20251014092436.GK4067720@noisy.programming.kicks-ass.net>
 <e84de5a9-b498-4152-846a-c72e1ac66109@linux.ibm.com>
 <20251014094259.GR3245006@noisy.programming.kicks-ass.net>
 <a5d5ce5e-9f98-4c0d-a4ed-5e4a8a6f7b86@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <a5d5ce5e-9f98-4c0d-a4ed-5e4a8a6f7b86@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68f91791 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=CviSjgRic15PywDmuwwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXzJirS98xQmwK
 f8of/ry+Cc/eOLTE/wOHkNPFRc/E/gFHcinjqkc+vTE1t62K7c9sd4PjO/HBBpPOppG7YSp8RqA
 y6SifiWVfIxpNKZyzYONSm1oE9s7L6y07YUCbbDv4os82Ph4bIkGyCfSo7w50SyJFOc7DbzfngF
 PbWcGNwO4KY3AyHE5Sdsar5VQOpkhDVkXFovzLcXa5BddfVlsLCbGhFBYvbY58WTYKwnvSxaKbz
 kY6pkpVsMQKMmzzaa50gDRnjYdZn6tevIeP9Oq2k7cGsdWniGBRB/o8w6GnXRs9Ul/Jtzn3H28v
 auIThNJJKZKYYQvYOq9cMYadGq5iuFReRkhoIu5mph5g2x708PVDgQvak8ZOmLCzfIrWQ82rfjY
 6H6pHgvOGhmaf17uOj1CLrwOmHcPIg==
X-Proofpoint-GUID: TH4CJPMjnc-U-b4n-iX8YnAfxxSrAxzF
X-Proofpoint-ORIG-GUID: TH4CJPMjnc-U-b4n-iX8YnAfxxSrAxzF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022



On 10/16/25 7:33 PM, Shrikanth Hegde wrote:
> 
> 
> On 10/14/25 3:12 PM, Peter Zijlstra wrote:
>> On Tue, Oct 14, 2025 at 03:03:41PM +0530, Shrikanth Hegde wrote:
>>
>>>> @@ -11758,6 +11775,12 @@ static int sched_balance_rq(int this_cpu, 
>>>> struct rq *this_rq,
>>>>            goto out_balanced;
>>>>        }
>>>> +    if (idle != CPU_NEWLY_IDLE && (sd->flags & SD_SERIALIZE)) {
>>>> +        if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
>>>> +            goto out_balanced;
>>>
>>> Maybe goto out instead of out_balanced ?
>>
>> That would be inconsistent with the !should_we_balance() goto
>> out_balanced right above this, no?
>>
> Hi Peter.
> 
> Did similar probe points numbers compared to this. Even the patch is 
> quite similar to what
> was suggested there a while ago.
> https://lore.kernel.org/all/41e11090-a100-48a7-a0dd- 
> c989772822d7@linux.ibm.com/
> 
> 480 CPUs system with 6 NUMA nodes. (different system than last time)
> 

Hi Peter, Tim.

How are we proceeding here? Should i send the below patch with changelog or
is it being worked out by either of you.

It is really beneficial for large systems to avoid un-neccessary cache bouncing.

> tl;dr
> 
> - Number of time sched_balance_running is taken is way less after the 
> swb check. (which is great)
> - Number of time it fails to set is very low after swb. (So out_balanced 
> vs out may not make a
> significant difference.)
> - Patch is at the end. It is this patch + redo stuff + 
> (ref_variable_stuff(ignore))
> 
>


Return-Path: <linux-kernel+bounces-788729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59518B3894E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B534625FB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE4E2D77EF;
	Wed, 27 Aug 2025 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ruGTJgx7"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FBE2D73A7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756318176; cv=none; b=YQK7uf9yHtWpM/4UhYknCuZdqRHsN+3m6nY+PIcfrc1k1LZAXIQr6SaaN7bEB04ksoHOXMFc2DaztxcSWT/xlmBcCTZFoZl5AQvrEF3aRtOoTjDMntYamDbmE82O9X5+R9Dl5n+2SHGEX/sY0S+hSktURJPhkPHxWkw6kFd8eFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756318176; c=relaxed/simple;
	bh=G54h9i/+zjlrtR1T4zEW4KrreOz3RuhA0Y4mYJJEGvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EDJqBm2XeoG3GxGEEnKJ3sGc16TY3d+nfdG/nvJFPf0gRkJSC5eFc+OXrLCpEUDHVqqiI+N19K5QkflIQLe0+29CLqeq/rANNMBL72HdAkDIf90JxifW5PInQE4E8JEY+tyKTEpeWpg+w+9XP+dEvumwrv4n+Uc6PC6tS8W4J9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ruGTJgx7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RBVVGj001647;
	Wed, 27 Aug 2025 18:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Henezf
	0j+nTZDVoAa0az5i1UqTqYlYmxIli7NXVRxFA=; b=ruGTJgx7WGavQoeJYMlNor
	XMzhWKSZblz1JTDwZMzRjTwsDT8AobIt38400xI5YMn2eaxjOFhE7Ll/0DTsJl65
	L3o4V0qjvzhdNHDScwz/ZyZMMxUwipV7mm1CN3Ju+fER6qkHtG/eqfccWUh4jQeo
	vxWuVeBBaAd/kLIqeNKZOYu/7xl43Lv4iCYCZzLy0oMmjP95UjMiUXdun+tq7hNs
	gCit0cV+ZCZVDlzWAkK+AljMNZrGnUG3vvwI6k/zb7YcH9ic+RMFpECmxfR7Rqmr
	JxCHyqDlirH19vV6G//9KLKTcEHB37pon9YR6wliIf3kDM5qNo5xdEX0Cx+bv/QQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5585p0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 18:09:20 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57RHuHtp008453;
	Wed, 27 Aug 2025 18:09:20 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5585p0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 18:09:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57RGUB41002473;
	Wed, 27 Aug 2025 18:09:19 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qt6mh1d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 18:09:19 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57RI9IEw31130128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 18:09:18 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9277958055;
	Wed, 27 Aug 2025 18:09:18 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49F8758043;
	Wed, 27 Aug 2025 18:09:15 +0000 (GMT)
Received: from [9.124.214.234] (unknown [9.124.214.234])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Aug 2025 18:09:14 +0000 (GMT)
Message-ID: <b451b318-133b-45f6-87b3-3dc3fa1f75a8@linux.ibm.com>
Date: Wed, 27 Aug 2025 23:39:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/ksm: Reset KSM counters in mm_struct during fork
To: David Hildenbrand <david@redhat.com>,
        Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: aboorvad@linux.ibm.com, akpm@linux-foundation.org,
        chengming.zhou@linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, richard.weiyang@gmail.com, ritesh.list@gmail.com,
        xu.xin16@zte.com.cn
References: <2e662107e01417bf9af23bc7f52863cd538419be.1756211338.git.donettom@linux.ibm.com>
 <512764a4-611c-42d4-8b4a-2aaca4e519a4@gmail.com>
 <53a7bf3d-843d-4e19-b0a3-cc6852fe72c1@redhat.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <53a7bf3d-843d-4e19-b0a3-cc6852fe72c1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mS-jT1OluJPLxq8noMhODUtObNItOHqs
X-Proofpoint-ORIG-GUID: W_QujhfOUYSUVaoozQfOXykh24azsJoS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfX+NdWAw+hGmuK
 bVsLNdGQeZLHk3q4tmYipIsA/dlu0JGkf7ViJ3+k15NZckt954S2qyhu5FV6DI1hteHgrsUdG73
 BUINunicVcSn0LEKstYS0y8JuDsY+up/ZaxD4jtUVSJQbW6+DhVHvyst+6F1izjdYzs5qk60lpa
 xDlpQ6BZymTbXdJlfzAFDuK/Bb/7Yxpssfb1cG+6KBFh7G8jSVJ+ItrsLT/Q52VXWLyZc/zxkxV
 Eqq++paV8dIaMF/DIQ7f0jdpg+9Ju++YHuX2fHLzNpNX4zwdYISUlsfwAYJFF5iHY4BCEil7M3J
 MyYG7p6LVAWUfo6/Q31YJChJliIfgXamffu058dZVaKCdWs2OwfQAKvzmf5wKoJpaa+1UAaZyrT
 YuIXP/AX
X-Authority-Analysis: v=2.4 cv=A8ZsP7WG c=1 sm=1 tr=0 ts=68af49d1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=nXaOtthc6F8xOgzlwIkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230021


On 8/26/25 7:39 PM, David Hildenbrand wrote:
> On 26.08.25 15:47, Giorgi Tchankvetadze wrote:
>> What if we only allocate KSM stats when a process actually uses KSM?
>>
>> struct ksm_mm_stats {
>>     atomic_long_t merging_pages;
>>     atomic_long_t rmap_items;
>>     atomic_long_t zero_pages;
>> };
>> struct ksm_mm_stats *mm->ksm_stats; // NULL until first enter
>>
>> static inline struct ksm_mm_stats *mm_get_ksm_stats(struct mm_struct 
>> *mm)
>> {
>>     if (likely(mm->ksm_stats))
>>         return mm->ksm_stats;
>>     return ksm_alloc_stats_if_needed(mm); // Slow path
>> }
>
> The fork'ed child uses KSM. It just doesn't have any stable rmap entries.
>
> We have to copy the zero_pages counter such that 
> ksm_might_unmap_zero_page() will do the right thing.
>
> But you're comment made me realize that there is likely another bug:
>
> When copying zero_pages during fork(), we have to increment 
> &ksm_zero_pages as well. Otherwise we will get an underflow later.


Yes, David, you are right. I added a test to check this scenario, and I 
am seeing ksm_zero_pages go negative.

# cat /sys/kernel/mm/ksm/ksm_zero_pages
-128
#


>
> @Donet, can you look into that as well?


Sure, I will add a fix for this issue in the next version.




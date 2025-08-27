Return-Path: <linux-kernel+bounces-788720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1268B3893B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4B83BEFEE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D31278E7C;
	Wed, 27 Aug 2025 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J7BOgCDj"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27C213E41A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756317812; cv=none; b=B4p89levlBThJYAOZnTM+vOJY7XUvB0PaiEidE5gB99emjr0z6Ss+N3PncnRrxTLBs1TT10qLdEQqMwsu1WHyV/OPxVsTtpYJplCweiHJwq+WPth6z6Q7QtPz1VT3WLM90LkVZJ62stcenIeirpZoequLAJNeM3m552vcyDXVEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756317812; c=relaxed/simple;
	bh=G/8xyeOOjrcA3QF8GVNshjtfH7X9xnvqURjmZmR67XI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZESIIJxH619hRBfsXBf/s43S+K9Hx5E7R3pXksiwbemLF7d1FXK37lhFSkW2d/gYBTzTiuKI2t+mXbsPi9VsCWJmWspQ8HNJUjjIHTMwd/YrBRhgnO1tdp4FKuHwnAVdjxpoDj1fvbIfPkY+zCDvLVBY+UXFimYabD4rh1ubrLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J7BOgCDj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RHF5Ce023477;
	Wed, 27 Aug 2025 18:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1J0MvS
	sUJQ2pO/UpEiL7JA+uW/madGANFHbtRodsiak=; b=J7BOgCDjhuv02yZt+7zzfD
	NcbwZPEhBNgCdjBg6obTXSw6vSon3UKM6RkgY4+LhlFOsC11r/KOLjm7rDzIGO2O
	oII9xCB2VwOwYTe5r4hN6XpE1/Ttn+jkaZFGiAKyiPvRAa3AUMHECpRV0jrSVdbe
	nZ1a9FpXYowgjBnjNs2/4xtTiI+ffOaUmCL238W5gGuuQ9TWoQasNtLy99hoRyGU
	bdJUIynGj368gNUES/utSDmQm3HA0tPP6QAe28uMV3g3NSbMgjZR37+89eZLnM7/
	OyG2I+Ll/zoXP0Gd51WgBEuMkDlELbfX8zEMkqrWO5qEaXYwLgr0/VQmJ25buPEg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5avnj5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 18:03:12 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57RI1wM8010440;
	Wed, 27 Aug 2025 18:03:12 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5avnj55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 18:03:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57RHNVnR017989;
	Wed, 27 Aug 2025 18:03:11 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qtp3gvxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 18:03:10 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57RI3AsD11796752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 18:03:10 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E28EB5805D;
	Wed, 27 Aug 2025 18:03:09 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E545658043;
	Wed, 27 Aug 2025 18:03:06 +0000 (GMT)
Received: from [9.124.214.234] (unknown [9.124.214.234])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Aug 2025 18:03:06 +0000 (GMT)
Message-ID: <f850ea7f-d2dc-4cc9-83ba-871d19311fa8@linux.ibm.com>
Date: Wed, 27 Aug 2025 23:33:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/ksm: Reset KSM counters in mm_struct during fork
To: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Wei Yang <richard.weiyang@gmail.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <2e662107e01417bf9af23bc7f52863cd538419be.1756211338.git.donettom@linux.ibm.com>
 <59fef25c-6559-4fb3-8810-c2a7dd36b95a@redhat.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <59fef25c-6559-4fb3-8810-c2a7dd36b95a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8Fa1NHI_Oki9TJYL05TZ0jLzTna4d_S5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfX1oh/PFuI1Lqq
 pZQ3mrxntSRXmSLKA7TeHRFQ2N6v0l4pvmouXrf1QyhmmorclGj+8hZ3JcoqC3FGuU9bSxcKePW
 fYwuGN57JIq0MIlVVemLGs9HTjeCIGClRXBZ3gP3+qUFME7RXmDh82Ci94xGZ/aDuHQO5d/1XJK
 nOWvG83Ehyt5Os2IF2l5tRew+UJINdx/5rHiIvxi5U3QkrndMcLy42IewIk9x7nAUXAEwwJdESy
 VKTDf44WukR34h8CUfAfaQ/JR1UynsVKaZBU7LcEuU7shOy9fA2QSB5IT0FN6vddj+oAdAk8ToZ
 UJbaIR/fzVsG2QPhMF8ahXfU3V/h8hQbShWhzLXY1wIKkSst72xQgy1rCRt/HS8IHalFFur2OOc
 iIGXRj7N
X-Proofpoint-ORIG-GUID: iUe8y2EGS-BpnmODYpNQsowK0dTTA5XC
X-Authority-Analysis: v=2.4 cv=SNNCVPvH c=1 sm=1 tr=0 ts=68af4860 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=RZE5Jt-HtoTff_lTyEUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230021


On 8/26/25 6:49 PM, David Hildenbrand wrote:
> On 26.08.25 14:49, Donet Tom wrote:
>> Currently, the KSM-related counters in `mm_struct` such as
>> `ksm_merging_pages`, `ksm_rmap_items`, and `ksm_zero_pages` are
>> inherited by the child process during fork. This results in
>> incorrect accounting, since the child has not performed any
>> KSM page merging.
>
> So, the situation is that our child process maps these pages, but it 
> does not have any stable rmap items corresponding to these pages.


Yes


>
> rmap_walk_ksm() spells that case out.
>
> Can you clarify that in the description here, and how both stats 
> correspond to rmap items?


Sure I will add it in next version.


>
> What is the effective result of this misacounting? I assume only a 
> higher number than expected.
>

Yes the number will be higher than expected.


>
>
>>
>> To fix this, reset these counters to 0 in the newly created
>> `mm_struct` during fork. This ensures that KSM statistics
>> remain accurate and only reflect the activity of each process.
>>
>
> Fixes? CC stable?


I will add it in next version.


>
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> ---
>>   include/linux/ksm.h | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
>> index 22e67ca7cba3..61b8892c632b 100644
>> --- a/include/linux/ksm.h
>> +++ b/include/linux/ksm.h
>> @@ -56,8 +56,12 @@ static inline long mm_ksm_zero_pages(struct 
>> mm_struct *mm)
>>   static inline void ksm_fork(struct mm_struct *mm, struct mm_struct 
>> *oldmm)
>>   {
>>       /* Adding mm to ksm is best effort on fork. */
>> -    if (mm_flags_test(MMF_VM_MERGEABLE, oldmm))
>> +    if (mm_flags_test(MMF_VM_MERGEABLE, oldmm)) {
>> +        mm->ksm_merging_pages = 0;
>> +        mm->ksm_rmap_items = 0;
>> +        atomic_long_set(&mm->ksm_zero_pages, 0);
>>           __ksm_enter(mm);
>> +    }
>>   }
>>     static inline int ksm_execve(struct mm_struct *mm)
>
>


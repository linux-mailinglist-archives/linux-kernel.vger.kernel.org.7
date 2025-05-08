Return-Path: <linux-kernel+bounces-639121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA5FAAF330
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 07:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19A0160683
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 05:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AEE215F42;
	Thu,  8 May 2025 05:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sJrT1JAA"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0866586323
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 05:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746683631; cv=none; b=BiqosWLR3XKwfv4ICgQiAqBnvYqHPpKesYPjfpmmz7/Ofn8QsFDry9KRHtYods3uZVK7AA54z+kZXZGAJ7AS2SDN7j2mp5V2wI/1ycIxMDubvvxIkgzRJjkwO4LgwuQHHDq6R6ZmESWk09ZzboGmDj6mn8d7nb/Na+nu7Jemsfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746683631; c=relaxed/simple;
	bh=Y9IrZw+hAate+R1OWXSHWDvaHRheAYit6DeC3Y7/qTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oalKJyY+CogGXmWype8cxW+t9SCv0kHzhG+WuqKiVnC7ujdXqJYiVHU/rb1D9xqGUy8CusTb0MwqRbIqE7ozJ9qevr5Ph0R2uJGDfXnEA47iYEGOboqwUqF1x5YBsa4jab90isf89VKew73D+EUw7SFvyT89bLUYLNlMuWkO1TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sJrT1JAA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547JIIjY031302;
	Thu, 8 May 2025 05:53:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7zMb80
	iggO3C2EaJdy9g6Wm4rfx3tnukTUGJzuGoc5M=; b=sJrT1JAAqELHGo8tyrpwqT
	HMYrSbHej4rHWwMXBmKsWCeLVRqOjblp3HVmcEIaR3olXZ2A8UnyKP6G9p7E9994
	w3X8l2rvIZRrrkjC2IGCFjlcyHwMGadD10I9IFOVyT8WS43Hmj7pnAK9s8+b13CG
	qkZBrQNZbUbB028COevU2+jWrJHJu/jatTR6nCnDKBu9+t7hNvC2jxLuiE5GEeCS
	9qdPk4BJrOmuDizq0Bt2EeFsJQBqYQZWhuOX6cc+Awi+Ye+1TulBk32sOHFP62wV
	a7DmGuVSml6RjeNm6fqilYhD+w/v4fIuO++PcxRcpQhb268FmNd82dfe4YU79Okw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46g5yrvu28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 05:53:29 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5485rSi8026677;
	Thu, 8 May 2025 05:53:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46g5yrvu25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 05:53:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 548452s2025813;
	Thu, 8 May 2025 05:53:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dwv04gub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 05:53:27 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5485rOCY29754098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 May 2025 05:53:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17BF22004B;
	Thu,  8 May 2025 05:53:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1134D20043;
	Thu,  8 May 2025 05:53:19 +0000 (GMT)
Received: from [9.69.67.220] (unknown [9.69.67.220])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 May 2025 05:53:18 +0000 (GMT)
Message-ID: <9f18e699-4819-4d2f-a932-fc5e399e8abd@linux.ibm.com>
Date: Thu, 8 May 2025 11:23:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] powerpc: fadump: use lock guard for mutex
To: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu, mpe@ellerman.id.au,
        peterz@infradead.org, ajd@linux.ibm.com, mahesh@linux.ibm.com,
        hbathini@linux.ibm.com, linux-kernel@vger.kernel.org,
        Srikar Dronamraju <srikar@linux.ibm.com>
References: <20250505075333.184463-1-sshegde@linux.ibm.com>
 <20250505075333.184463-4-sshegde@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20250505075333.184463-4-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=cuybk04i c=1 sm=1 tr=0 ts=681c46d9 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=Twlkf-z8AAAA:8 a=VnNF1IyMAAAA:8
 a=HZL76PFKmj4eiTq98P8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=yTjAz9eSMYQA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=-74SuR6ZdpOK_LpdRCUo:22
X-Proofpoint-GUID: uXt-oUKY5saiTp1o946lqeuW4-3NzcVh
X-Proofpoint-ORIG-GUID: 2bButgZKUdTCI3QXyC3aa1ZzNg_Iwl7i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDA0NiBTYWx0ZWRfXyRcr/XYF0ivA lGIOdDlqvJOhjWi95ALFgx39bzalFBizvE9nFt53/cgi3o8v3IE81PmXGpF7EvBbCOgpYj4aP08 QTcYP5jG8dULOhIiR/6ZoYkG24mfDBuvsteRy8gVSAB/MPiICgWUz9beMLhHJts9MaVOOZEOqq+
 cnPrKFcZZAQO0+KCAiYKsK5hzHyNnLqJiWSlujgrPVNSx+lsK8VW6WZTIO6AC8BQU1uK3zwrS9g +tsd5Wv+kLMn+yFF0bPVndmyRv6/rpOP8OPlzvuO/kFs9jyRGLCCJfzMWRmWDMCu/RZL7YYMIqB C2XDel7x0qnDgHxQYroOAiC3CjiZXGtdZmYplwhWp3psCkN/MGNS7umWthW+KCW6zeViD6cmLiK
 vfedHpMgTg5rZoupbHkUw4Ab67FKcu5qJ4BsQ2TmH+9CGVaOHWQKiviaN8TEEXrd25O6JocB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_01,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=809
 suspectscore=0 adultscore=0 spamscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080046



On 05/05/25 13:23, Shrikanth Hegde wrote:
> use scoped_guard for scope based resource management of mutex.
> This would make the code simpler and easier to maintain.
>
> More details on lock guards can be found at
> https://lore.kernel.org/all/20230612093537.614161713@infradead.org/T/#u
>
> Reviewed-by: Srikar Dronamraju <srikar@linux.ibm.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>   arch/powerpc/kernel/fadump.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index df16c7f547ab..b8c7993c5bb1 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -1375,15 +1375,12 @@ static void fadump_free_elfcorehdr_buf(void)
>   
>   static void fadump_invalidate_release_mem(void)
>   {
> -	mutex_lock(&fadump_mutex);
> -	if (!fw_dump.dump_active) {
> -		mutex_unlock(&fadump_mutex);
> -		return;
> +	scoped_guard(mutex, &fadump_mutex) {
> +		if (!fw_dump.dump_active)
> +			return;
> +		fadump_cleanup();
>   	}
>   
> -	fadump_cleanup();
> -	mutex_unlock(&fadump_mutex);
> -
>   	fadump_free_elfcorehdr_buf();
>   	fadump_release_memory(fw_dump.boot_mem_top, memblock_end_of_DRAM());
>   	fadump_free_cpu_notes_buf();

I tried to understand how scoped_guard gets unwrapped and what changes
it brings to the assembly of the update function. However, with GCC version
11.5.0 20240719 (Red Hat 11.5.0-5), identical assembly was generated for the
fadump_invalidate_release_mem function with or without this patch.

Which was a surprise to me because there are lot macros and compiler
magic involved here to call destructor ( for example 
https://clang.llvm.org/docs/AttributeReference.html#cleanup)
when a variable goes out of scope.

c000000000053978 <fadump_invalidate_release_mem.part.0>:
c000000000053978:       ae 01 4c 3c     addis   r2,r12,430
c00000000005397c:       88 47 42 38     addi    r2,r2,18312
c000000000053980:       a6 02 08 7c     mflr    r0
c000000000053984:       11 57 02 48     bl      c000000000079094 <_mcount>
c000000000053988:       a6 02 08 7c     mflr    r0
c00000000005398c:       f8 ff e1 fb     std     r31,-8(r1)
c000000000053990:       f0 ff c1 fb     std     r30,-16(r1)
c000000000053994:       1f 01 e2 3f     addis   r31,r2,287
c000000000053998:       30 ea ff 3b     addi    r31,r31,-5584
c00000000005399c:       10 00 01 f8     std     r0,16(r1)
c0000000000539a0:       81 ff 21 f8     stdu    r1,-128(r1)
c0000000000539a4:       18 00 41 f8     std     r2,24(r1)
c0000000000539a8:       ad fe ff 4b     bl      c000000000053854 
<fadump_cleanup+0x8>
c0000000000539ac:       c2 00 62 3c     addis   r3,r2,194
c0000000000539b0:       98 c3 63 38     addi    r3,r3,-15464
c0000000000539b4:       c9 1d 06 49     bl      c0000000010b577c 
<mutex_unlock+0x8>
c0000000000539b8:       00 00 00 60     nop
c0000000000539bc:       1f 01 22 3d     addis   r9,r2,287
snip...


Also, fadump_invalidate_release_mem() is only called in the fadump 
kernel in two scenarios
to release the reserved memory:

1. After dump collection
2. When fadump fails to process the dump

So even if the compiler messes up something here, there is no impact on 
dump collection as such.

So changes looks good to me:
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>


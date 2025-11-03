Return-Path: <linux-kernel+bounces-882264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CDBC2A04B
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 05:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A497A348255
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 04:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4126C23D7DA;
	Mon,  3 Nov 2025 04:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aNROTIB6"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED85A86334
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 04:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762142931; cv=none; b=sCsWQW7P/YkRm9O1YABJfPKC+ARzUdboucVaQ7fQEvj7mjZkayafi0UDTxJ1vB/L/mNVvuMA4uUjOixg1UvS04hfJzMA+FOFqKlavLcIsO8gExr9GlzNYW7hG9vcLq1uL8cADgmFOxuYkrE87KntBw0iMj4aE+zNtvkxRDH9SwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762142931; c=relaxed/simple;
	bh=iSoW8AX+b1ZZV1qtpWkQbQARw0Gl+99e93a3ggzA6hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNQEZAmuDaONXNt3wU4MlCiCPzbEle+zvTFEojEOWL7gV/l4EWe8LZVsNuFOvRjCg0cf+SgoqVVd/+1KpT88WH7MkjzAPKhsYkPDlsxa6SgX2uJuY/lhsTXtixOeAWEEWMMvp+v5Z/8QFh/SuZt9f6bOIC+c7qUgLUQ+YnBlEw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aNROTIB6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A2NkVTI017503;
	Mon, 3 Nov 2025 04:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZNBPxM
	kzJdcPZ6SepGjzAyT8BlUO5pQGT90ChoxdWXA=; b=aNROTIB6px6nbRNpGJSebF
	K7A5a/9SBxqqusBUjyV2lt6mRMdW1SaTi8PvphvGctaldf+BXwJ8Xqsk0TDt22lx
	F3dhYmaTtXlu4eGFV97jV08Mb4ZJ5RD2ifwjXl3ZP/g2f1JxpIuWILgE2xbhwTZN
	dAGRE4viECZAtq/dUwWXoLPJqyHob+7pMnG1NfP7VS2RIfu6V4tGGHy5LR0eekwv
	hKPg0C7db7Na+jqmYFkO6Ok0Y7AM+IdVWTQ+8BNxzjTf/2cHOnIflqO3y3bIX5g+
	xpFaCP4eQ5XNNIhIFWrtiPfsGjj0okjMMAtzi3UtxozQtt6g6f6ElmwEXKLvUXSw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59v1msvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 04:08:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A31SDj6025582;
	Mon, 3 Nov 2025 04:08:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5vhsbwf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 04:08:31 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A348T1w29164242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Nov 2025 04:08:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6D2B20043;
	Mon,  3 Nov 2025 04:08:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DE0220040;
	Mon,  3 Nov 2025 04:08:28 +0000 (GMT)
Received: from [9.109.204.116] (unknown [9.109.204.116])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Nov 2025 04:08:28 +0000 (GMT)
Message-ID: <01045c4c-a37a-4a31-8787-6483c7b78dad@linux.ibm.com>
Date: Mon, 3 Nov 2025 09:38:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crash: fix crashkernel resource shrink
To: Baoquan He <bhe@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Zhen Lei <thunder.leizhen@huawei.com>,
        kexec@lists.infradead.org
References: <20251101193741.289252-1-sourabhjain@linux.ibm.com>
 <aQgZekkvdC6Ekq8V@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <aQgZekkvdC6Ekq8V@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: j7_qIb3WQBhRLN09Hp03kgr71H6BNM3d
X-Proofpoint-ORIG-GUID: j7_qIb3WQBhRLN09Hp03kgr71H6BNM3d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX9LpHsbKoChLO
 5+ONM7XtYP3EJBArimzGmzVbjHhjbuiK2WFslK6wr//QblruRZbLjqiHSI2Xjl05c8tJqts7Axq
 H2fmj/TH/llUhmHZQ/JTxSaf/lZIA5TiZS0SpCa8RQzaxyzDyMZxIub4MZT23fCERw+4EfFDpMj
 imng+Wel1VK/kL8S/w/DMFedCB3Yla8EI0N7VsKdz9usdqAApvD4CWbNMa9e0KKcm3bxdQ4Km9t
 OdsJgLhfQSjBkRaITl2QjZ/J6f3ZlC5TvPr2V3W/577+Cl8bKfJnghyb1Nod2KzKogXYlsvlvLl
 ao5leGC73uujqnTh7CDBI0anNCFAXK0ugRA95N96cDktBusv8RuhC00Dr5vr310FWy8eNHSkqTK
 IUbgqy9w3h+unEqe4hMiKXryKcr0fQ==
X-Authority-Analysis: v=2.4 cv=H8HWAuYi c=1 sm=1 tr=0 ts=69082ac0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8 a=i0EeH86SAAAA:8 a=JfrnYn6hAAAA:8
 a=VnNF1IyMAAAA:8 a=AF3erdo4s1WuFiYT4_sA:9 a=QEXdDO2ut3YA:10
 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010021



On 03/11/25 08:24, Baoquan He wrote:
> On 11/02/25 at 01:07am, Sourabh Jain wrote:
>> When crashkernel is configured with a high reservation, shrinking its
>> value below the low crashkernel reservation causes two issues:
>>
>> 1. Invalid crashkernel resource objects
>> 2. Kernel crash if crashkernel shrinking is done twice
>>
>> For example, with crashkernel=200M,high, the kernel reserves 200MB of
>> high memory and some default low memory (say 256MB). The reservation
>> appears as:
>>
>> cat /proc/iomem | grep -i crash
>> af000000-beffffff : Crash kernel
>> 433000000-43f7fffff : Crash kernel
>>
>> If crashkernel is then shrunk to 50MB (echo 52428800 >
>> /sys/kernel/kexec_crash_size), /proc/iomem still shows 256MB reserved:
>> af000000-beffffff : Crash kernel
>>
>> Instead, it should show 50MB:
>> af000000-b21fffff : Crash kernel
>>
>> Further shrinking crashkernel to 40MB causes a kernel crash with the
>> following trace (x86):
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000038
>> PGD 0 P4D 0
>> Oops: 0000 [#1] PREEMPT SMP NOPTI
>> <snip...>
>> Call Trace: <TASK>
>> ? __die_body.cold+0x19/0x27
>> ? page_fault_oops+0x15a/0x2f0
>> ? search_module_extables+0x19/0x60
>> ? search_bpf_extables+0x5f/0x80
>> ? exc_page_fault+0x7e/0x180
>> ? asm_exc_page_fault+0x26/0x30
>> ? __release_resource+0xd/0xb0
>> release_resource+0x26/0x40
>> __crash_shrink_memory+0xe5/0x110
>> crash_shrink_memory+0x12a/0x190
>> kexec_crash_size_store+0x41/0x80
>> kernfs_fop_write_iter+0x141/0x1f0
>> vfs_write+0x294/0x460
>> ksys_write+0x6d/0xf0
>> <snip...>
>>
>> This happens because __crash_shrink_memory()/kernel/crash_core.c
>> incorrectly updates the crashk_res resource object even when
>> crashk_low_res should be updated.
>>
>> Fix this by ensuring the correct crashkernel resource object is updated
>> when shrinking crashkernel memory.
>>
>> Fixes: 16c6006af4d4 ("kexec: enable kexec_crash_size to support two crash kernel regions")
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Zhen Lei <thunder.leizhen@huawei.com>
>> Cc: kexec@lists.infradead.org
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   kernel/crash_core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 3b1c43382eec..99dac1aa972a 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -373,7 +373,7 @@ static int __crash_shrink_memory(struct resource *old_res,
>>   		old_res->start = 0;
>>   		old_res->end   = 0;
>>   	} else {
>> -		crashk_res.end = ram_res->start - 1;
>> +		old_res->end = ram_res->start - 1;
> It's a code bug, nice catch, thanks.
>
> Acked-by: Baoquan He <bhe@redhat.com>

Thanks for the ack, Baoquan.

- Sourabh Jain


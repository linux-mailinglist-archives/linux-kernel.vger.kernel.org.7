Return-Path: <linux-kernel+bounces-894675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA62C4B92E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D43188FBD5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 05:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D96275B1A;
	Tue, 11 Nov 2025 05:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eGJ7w+Zt"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF450218AB0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 05:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762840397; cv=none; b=tNJOyYBOPdrmMFH24Uzn9jnljVhix8DwfRF0H47HQlVk5FK4oShwtQkD1e+puZOycc7hiZpuGBfiFuAVBSljyZAPM3B7WsDcP0gVfT0IdblTMcnt8HwdIZcvNzEVmE80Fmk8Qnldh6O9bfNr6Ax3UXSAHpa5RVBRDsP6otcNylI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762840397; c=relaxed/simple;
	bh=AJ/k8m6pthG8Gcg3my/vKvpdE5aV6yzPlE/491Qkzak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rdc1yVUlpgsyKusOfhL84xmt/bekNwkxK1b/nH1JMuPY+Y5YN1gptfhJtSl6m8CClPv+WUWFKYL8eJROHz2Xky9fSiPxMoDCUAqZK2QM2ozmv36TRcuw/3EaSO9Z3otlWDWAdekgXwmljJ5B/btgPPbF+7sgqOkZ8f9PEMxboSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eGJ7w+Zt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB28NCG020676;
	Tue, 11 Nov 2025 05:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jR9xBv
	mP62HE1b+hpq22XRoqsFbon38apNqfhG0YOxs=; b=eGJ7w+Zt94YGKkfBOkp8LX
	uhYTeuU+TJHmRadTajBDk59vxDK3Yia/lUo/qehN8NQh0KtOHcvlmjNnk5UD1UmX
	jXNUbkO2IHK8QWk4ZwPZOp+z+x+1NJHxtUpuKbdLdc7MqX7YbN1K1dF2V4YqZ7uI
	UPS+8JArTMD4ALRgQf3rZLVb7S5XPVuLlNDy2c5t2qsoxYpPcoZgM+TVlTAMjaTs
	sRLlsaNMmSK/39ZNdwkaccrb50UdvTcDEYS8jFztDUnjiE6G711O2OZutOiMUzbR
	MnaL3xNynXmfsCr9EHnOPa8iMP71QkQfacaANgoEG3yldZ0M4JTWbGmMZdo33Rrw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk83jf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 05:53:03 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AB5r3xY020166;
	Tue, 11 Nov 2025 05:53:03 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk83jf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 05:53:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB5X6q2011562;
	Tue, 11 Nov 2025 05:53:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajw18yyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 05:53:01 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AB5qwNb16318788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 05:52:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 101C720043;
	Tue, 11 Nov 2025 05:52:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B146020040;
	Tue, 11 Nov 2025 05:52:54 +0000 (GMT)
Received: from [9.39.20.64] (unknown [9.39.20.64])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Nov 2025 05:52:54 +0000 (GMT)
Message-ID: <56abcc3f-ddd4-49c3-a985-a16d616e4210@linux.ibm.com>
Date: Tue, 11 Nov 2025 11:22:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] crash: export crashkernel CMA reservation to
 userspace
To: Baoquan he <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, Aditya Gupta <adityag@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>,
        Jiri Bohac <jbohac@suse.cz>, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Pingfan Liu <piliu@redhat.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        kexec@lists.infradead.org
References: <20251110043143.484408-1-sourabhjain@linux.ibm.com>
 <20251110043143.484408-6-sourabhjain@linux.ibm.com>
 <aRGPee9izxWPRHj5@MiWiFi-R3L-srv>
 <09c4c181-eb4b-43ea-a439-04b83f4c20ba@linux.ibm.com>
 <aRKOK7ZQ5mOUBzvK@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <aRKOK7ZQ5mOUBzvK@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX8i49R0Z12Rdx
 Yz5xjsGu8ywLiD6Lm5XSYF9qwzfmzce+8AhhmQQmCRfwY+HrGaDm3W0t9zk5lg1aOmqk9AasOvU
 Dvl5hQg95U9XSS8xgV4Q7Zv3IPDTTIJ+GkInNjJTdGY4K8NmCmHdWAUg5c8ZHHbExINMdxo9c2P
 fKgHmiblDCnhiMQpYxYySVD8DF69m5qKPXFvx+YIReM1DvQfX8I9ODSnwNePnTdNYflen8jftmp
 24N1JkGV2GeWGjduQ3wxCRKjYNtjzygbk04BdpOKgLszh/5SC78joTXA2wCU8qpIvnL8qoMTsZk
 ljv/mL1lzDDDBDuKIAYid0kLlh4oavpePMgvb6Wv3MTqo284c5oFmLaTtwVCaT2SXSubCL4rXRA
 4EZZD97hBsq8EdSlyWdjQfd06uzstg==
X-Authority-Analysis: v=2.4 cv=ZK3aWH7b c=1 sm=1 tr=0 ts=6912cf3f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8
 a=pGLkceISAAAA:8 a=voM4FWlXAAAA:8 a=JfrnYn6hAAAA:8 a=bLF1B-K238BkpyBZBwwA:9
 a=QEXdDO2ut3YA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=IC2XNlieTeVoXbcui8wp:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: yL03va81FbIa21mHmbrKh4zId853n8kF
X-Proofpoint-GUID: jfvOgROHoePxzclwIbTyIQfbKiNzvFHM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022



On 11/11/25 06:45, Baoquan he wrote:
> On 11/10/25 at 02:09pm, Sourabh Jain wrote:
>>
>> On 10/11/25 12:38, Baoquan he wrote:
>>> On 11/10/25 at 10:01am, Sourabh Jain wrote:
>>>> Add a sysfs entry /sys/kernel/kexec/crash_cma_ranges to expose all
>>>> CMA crashkernel ranges.
>>> I am not against this way. While wondering if it's more appropriate to
>>> export them into iomem_resource just like crashk_res and crashk_low_res
>>> doing.
>> Handling conflict is challenging. Hence we don't export crashk_res and
>> crashk_low_res to iomem on powerpc. Checkout [1]
>>
>> And I think conflicts can occur regardless of the order in which System RAM
>> and
>> Crash CMA ranges are added to iomem.
>>
>> [1] https://lore.kernel.org/all/20251016142831.144515-1-sourabhjain@linux.ibm.com/
> Then I would suggest you add this reason and the link into patch log
> to keep a record. One day people may post patch to 'optimize' this.


Yeah, I will include it in v3. Thanks for the review.

- Sourabh Jain


>
>>>> This allows userspace tools configuring kdump to determine how much
>>>> memory is reserved for crashkernel. If CMA is used, tools can warn
>>>> users when attempting to capture user pages with CMA reservation.
>>>>
>>>> The new sysfs hold the CMA ranges in below format:
>>>>
>>>> cat /sys/kernel/kexec/crash_cma_ranges
>>>> 100000000-10c7fffff
>>>>
>>>> Cc: Aditya Gupta <adityag@linux.ibm.com>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: Baoquan he <bhe@redhat.com>
>>>> Cc: Dave Young <dyoung@redhat.com>
>>>> Cc: Hari Bathini <hbathini@linux.ibm.com>
>>>> Cc: Jiri Bohac <jbohac@suse.cz>
>>>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>>>> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
>>>> Cc: Pingfan Liu <piliu@redhat.com>
>>>> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>>> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
>>>> Cc: Vivek Goyal <vgoyal@redhat.com>
>>>> Cc: linuxppc-dev@lists.ozlabs.org
>>>> Cc: kexec@lists.infradead.org
>>>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>>> ---
>>>> Changelog:
>>>>    - Add the missing hunk to export crash_cma_ranges sysfs
>>>>
>>>> ---
>>>>    .../ABI/testing/sysfs-kernel-kexec-kdump        | 10 ++++++++++
>>>>    kernel/kexec_core.c                             | 17 +++++++++++++++++
>>>>    2 files changed, 27 insertions(+)
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-kernel-kexec-kdump b/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
>>>> index 00c00f380fea..f59051b5d96d 100644
>>>> --- a/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
>>>> +++ b/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
>>>> @@ -49,3 +49,13 @@ Description:	read only
>>>>    		is used by the user space utility kexec to support updating the
>>>>    		in-kernel kdump image during hotplug operations.
>>>>    User:		Kexec tools
>>>> +
>>>> +What:		/sys/kernel/kexec/crash_cma_ranges
>>>> +Date:		Nov 2025
>>>> +Contact:	kexec@lists.infradead.org
>>>> +Description:	read only
>>>> +		Provides information about the memory ranges reserved from
>>>> +		the Contiguous Memory Allocator (CMA) area that are allocated
>>>> +		to the crash (kdump) kernel. It lists the start and end physical
>>>> +		addresses of CMA regions assigned for crashkernel use.
>>>> +User:		kdump service
>>>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>>>> index 7476a46de5d6..da6ff72b4669 100644
>>>> --- a/kernel/kexec_core.c
>>>> +++ b/kernel/kexec_core.c
>>>> @@ -1271,6 +1271,22 @@ static ssize_t crash_size_store(struct kobject *kobj,
>>>>    }
>>>>    static struct kobj_attribute crash_size_attr = __ATTR_RW(crash_size);
>>>> +static ssize_t crash_cma_ranges_show(struct kobject *kobj,
>>>> +				     struct kobj_attribute *attr, char *buf)
>>>> +{
>>>> +
>>>> +	ssize_t len = 0;
>>>> +	int i;
>>>> +
>>>> +	for (i = 0; i < crashk_cma_cnt; ++i) {
>>>> +		len += sysfs_emit_at(buf, len, "%08llx-%08llx\n",
>>>> +				     crashk_cma_ranges[i].start,
>>>> +				     crashk_cma_ranges[i].end);
>>>> +	}
>>>> +	return len;
>>>> +}
>>>> +static struct kobj_attribute crash_cma_ranges_attr = __ATTR_RO(crash_cma_ranges);
>>>> +
>>>>    #ifdef CONFIG_CRASH_HOTPLUG
>>>>    static ssize_t crash_elfcorehdr_size_show(struct kobject *kobj,
>>>>    			       struct kobj_attribute *attr, char *buf)
>>>> @@ -1289,6 +1305,7 @@ static struct attribute *kexec_attrs[] = {
>>>>    #ifdef CONFIG_CRASH_DUMP
>>>>    	&crash_loaded_attr.attr,
>>>>    	&crash_size_attr.attr,
>>>> +	&crash_cma_ranges_attr.attr,
>>>>    #ifdef CONFIG_CRASH_HOTPLUG
>>>>    	&crash_elfcorehdr_size_attr.attr,
>>>>    #endif
>>>> -- 
>>>> 2.51.1
>>>>



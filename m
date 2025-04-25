Return-Path: <linux-kernel+bounces-620504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58137A9CBA1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 16:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803BC9A5634
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 14:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA1A248879;
	Fri, 25 Apr 2025 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ad4C0oXI"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7581723F296
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745591118; cv=none; b=XNM83Y4qaEN6w8JXmJ9c/eDrSAWjE+hSL2uUl+IoOTbJpeyC3eYpAYqEC85DI5dg4BzMNh9fVdwQV/twWxLRXdLSOhyfLdD1byQckPlkKF8R6u5I/N9Wt20ikjSfDt2FX4Ofa3ITZw6G8cC15yLR+64gG5o0zAVZGogrpTeX5gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745591118; c=relaxed/simple;
	bh=jsvGr5lyrNZG3MWRApas4EV01rBlJrT00hjDV9ka9xI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHOb3s+kwyNEO1lEPAE0Wz0K5FhEyM4Fq8IVefU10CegMtp4M0KCJS8OrcLJF/a5x1KFuJYWuy4pQwQZqJ2xK79sZxMD9K8Qqo+zU3GeOD9pUqA3webUaY9nwLUaNMRTfmXHQfq4tUgt5cjtp0JJdsLBAMSha1fF91JgGTrbuEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ad4C0oXI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PAesRC023207;
	Fri, 25 Apr 2025 14:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zuxQaR
	vQdM2HJYeSLwgpF2CuLVYZKJbfytej8xx9CoE=; b=ad4C0oXIrT+fFdMTXc+StL
	VDb74ArttNPPQAOsLRwPxRJaBpxNJZ4DE1vU8nJhyJAhQFZniL3tltHYhDFZELQY
	VLsWjLk0hyEhYS3cj5kTMBOvLwL6HWD6y8oueemhaOUzvZiGnu/+lnHQo22s2XLH
	g3NTZ5cM+eQwoYAdNvapwAXd7IpZ1BNIB9FDBXrNd4PbuLdyF5XnhcKG9tBOhjFU
	bAPevAfgZuisYU0PXxphV+AAUM67AwU6TBco3w7UlLngHhr8X8NCb0roX3ZXTfke
	XZF5GcGSQYa/+vNTi9lsvUzk9VJOGYiqLy5QQficlzw+hFrtyhT6pIwCzktQmDrw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4688usgyq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 14:25:04 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53PE76HO015663;
	Fri, 25 Apr 2025 14:25:03 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4688usgypy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 14:25:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53PCe7SJ004097;
	Fri, 25 Apr 2025 14:25:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jg05kjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 14:25:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53PEOxWt37028330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 14:24:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C3D220043;
	Fri, 25 Apr 2025 14:24:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7338220040;
	Fri, 25 Apr 2025 14:24:57 +0000 (GMT)
Received: from [9.124.216.146] (unknown [9.124.216.146])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Apr 2025 14:24:57 +0000 (GMT)
Message-ID: <5cc88718-13ff-4220-a8f6-c988a919aa65@linux.ibm.com>
Date: Fri, 25 Apr 2025 19:54:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] powerpc: kvm: use generic transfer to guest mode work
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: npiggin@gmail.com, vaibhav@linux.ibm.com, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
        gautam@linux.ibm.com, linux-kernel@vger.kernel.org
References: <20250421102837.78515-1-sshegde@linux.ibm.com>
 <20250421102837.78515-2-sshegde@linux.ibm.com>
 <20250424144215._ooDjDz9@linutronix.de>
 <365ba747-9311-45ab-b798-80ba4e578796@linux.ibm.com>
 <20250424183811.7_MLThpt@linutronix.de>
 <2891b989-6249-4e84-969e-f11af3f92b0b@linux.ibm.com>
 <20250425133131.DTvWJE29@linutronix.de>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250425133131.DTvWJE29@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dbeA3WXe c=1 sm=1 tr=0 ts=680b9b40 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=eUDsRD9QmrZOUdxpPkMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEwMCBTYWx0ZWRfX0Kcud2JAHLHA RME5rjHSZYWSDNjUeIOUHdAqm3QFscvfQeqOfr/9xrN13Tm/x9aW0b0igR15+gN9qmhZI7CLrTK zUddcHSuPSZOqyoFgrqckrEh8dYJXbwLq6vDDJxryVu591hdlLkzOrgWKizbrNHB6kvO39lBrUt
 1p4GHDZMr0j6tqt5eYzUG9tk/50V1B6rOhb7v1dnu5xExi7/cesmfPax+UimpytBmkBn3pY4Luo LUnxf7N26CNM0JYg0rRZ7WLWMz9BYk0SoNBH+uz5MUOlztLCynvH7Hq+eGMd965izoiVV8TMt9J vBDUFE7sYFajOz3fX56+2pUZ5WkXxxETcOhUqjgf71Ygw+xB4h5IZpFlx8iUpC3/v9cewnLrBsi
 KYla6ZmE8MdC6BqcUfEeAMiITqm8G963QnAO5p2e7o75T/+h87KHteIYHQStDhTeYyBh0AKx
X-Proofpoint-ORIG-GUID: 1GpJgedZ5Fw8Lf480XK3pPbd5qFhHuJM
X-Proofpoint-GUID: 5ODJ5PeDCuNiajrjpCIHuiss4C0Qkxwt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250100



On 4/25/25 19:01, Sebastian Andrzej Siewior wrote:
> On 2025-04-25 16:49:19 [+0530], Shrikanth Hegde wrote:
>> On 4/25/25 00:08, Sebastian Andrzej Siewior wrote:
>>> On 2025-04-24 21:27:59 [+0530], Shrikanth Hegde wrote:
>>>>>> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
>>>>>> index 19f4d298d..123539642 100644
>>>>>> --- a/arch/powerpc/kvm/book3s_hv.c
>>>>>> +++ b/arch/powerpc/kvm/book3s_hv.c
>>>>>> @@ -4901,7 +4901,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
>>>>>>     	}
>>>>>>     	if (need_resched())
>>>>>> -		cond_resched();
>>>>>> +		schedule();
>>>>>
>>>>
>>>>
>>>>> This looks unrelated and odd. I don't why but this should be a
>>>>> cond_resched() so it can be optimized away on PREEMPT kernels.
>>>>
>>>> This is needed, otherwise KVM on powerVM setup gets stuck on preempt=full/lazy.
>>>
>>> But this makes no sense. On preempt=full the cond_resched() gets patched
>>> out while schedule() doesn't. Okay, this explains the stuck.
>>
>> cond_resched works. What you said is right about schedule and preemption models.
>> Initially I had some other code changes and they were causing it get stuck. i retested it.
> 
> so it is unrelated then ;)
> 
>> But looking at the semantics of usage of xfer_to_guest_mode_work
>> I think using schedule is probably right over here.
>> Correct me if i got it all wrong.
> 
> No, if you do xfer_to_guest_mode_work() then it will invoke schedule()
> when appropriate. It just the thing in kvmhv_run_single_vcpu() looks odd
> and might have been duct tape or an accident and could probably be
> removed.
>

I was wondering xfer_to_guest_mode_work could also call cond_resched
instead of schedule since for preempt=full/lazy is preemptible
as early as possible right?

  
>> on x86:
>> kvm_arch_vcpu_ioctl_run
>> 	vcpu_run
>> 		for () {
>> 			.. run guest..
>> 			xfer_to_guest_mode_handle_work
>> 				schedule
>> 		}
>>
>>
>> on Powerpc:  ( taking book3s_hv flavour):
>> kvm_arch_vcpu_ioctl_run
>> kvmppc_vcpu_run_hv  *1
>> 	do while() {
>> 		kvmhv_run_single_vcpu or kvmppc_run_vcpu
>> 			-- checking for need_resched and signals and bails out *2
>> 	}
>>
>>
>> *1 - checks for need resched and signals before entering guest
> I don't see the need_resched() check here.
> 

right, i think *2 is critical since it is in a loop.
*1 is probably an optimization to skip a few cycles.

>> *2 - checks for need resched and signals while running the guest
>>
>>
>> This patch is addressing only *1 but it needs to address *2 as well using generic framework.
>> I think it is doable for books3s_hv atleast. (though might need rewrite)
>>
>> __kvmppc_vcpu_run is a block box to me yet. I think it first makes sense
>> to move it C and then try use the xfer_to_guest_mode_handle_work.
>> nick, vaibhav, any idea on __kvmppc_vcpu_run on how is it handling signal pending, and need_resched.
>>
>>
>> So this is going to need more work specially on *2 and doing that is also key for preempt=lazy/full to work
>> for kvm on powepc. will try to figure out.
> 
> Okay.
>


  
> Sebastian



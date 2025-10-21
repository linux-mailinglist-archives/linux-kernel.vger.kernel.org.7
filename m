Return-Path: <linux-kernel+bounces-862208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C78BBF4AF3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 84BF934FE01
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 06:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F11231A3B;
	Tue, 21 Oct 2025 06:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ba6xewtL"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9488C24C676
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761027083; cv=none; b=TWek6FA2/dQkAAftqggAq+wTWSq/nLXpR8jk/n7d509D8XOsafVpyZndPcgjBCqT5L+wTpH4S9iIwyiZGSVfzGv7gSrcnXc4S5tUymhanCzmLA63IMSLt9cElo3fC/QnojKTQPCHLqnXIfdCKPDocGalF8LLyUZN6BJSvP9td2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761027083; c=relaxed/simple;
	bh=JTSB7cO7GOQlyHxOjyql2s9R7Q6/KvR+ELfB/aWGkkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIVHJBgahwMj1Bix5ZA3TxNmmfzDzouibdIUNugy7Dz3Wsgwc944ooIZ0JY2oRsF4smPH8xcQR346v+6Y83aBlmCXP1scl46R+pBdb7UDffEVj2ByFARzJrdvxx650hU4H5yLlnj7sCJPGXViX2s3ZUJ87vhNy0qhG00JgTphHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ba6xewtL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KLt77t002342;
	Tue, 21 Oct 2025 06:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BRrNnw
	GsErz8NOpxpI9TLUfmIONJJwUnb9ikB/eW6pU=; b=ba6xewtLAHFQZg0QFGLODK
	7Jp6+dabOppZ0qmcT5o96glKB6QukRqlGe3X3PFlLftHPqKRdcJsu+aVHWbx/3Oi
	CjxmWpp8vwIemBRCgs8TmHkvNxmnqDZCj49gvyXYswhoXUGpgPSu8MSGm/4AcovD
	jk+y0WgPgs8ODwSf5lPeZuQ2Km/kux0VJ4uB5YrddzSTbN6R1J01OIyRsschBdtD
	3p6UUbeTS6HUvdvj0Mtglx/Mh2WuIH/dpxSgQtniXKcSPYn5Zoo+sjsRXSO8RW9m
	BVbZoMZFOxaedr+AYbR/NmsbhF27K4D2hdnRnz1achQrKqVoWXkTFnEhgVQp8j7g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31c45m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 06:10:34 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59L6AX3g024634;
	Tue, 21 Oct 2025 06:10:33 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31c45m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 06:10:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59L3RxbX024987;
	Tue, 21 Oct 2025 06:10:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqjs93u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 06:10:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59L6ASb917170902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 06:10:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C37D520043;
	Tue, 21 Oct 2025 06:10:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD38420040;
	Tue, 21 Oct 2025 06:10:24 +0000 (GMT)
Received: from [9.39.24.46] (unknown [9.39.24.46])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Oct 2025 06:10:24 +0000 (GMT)
Message-ID: <48d66446-40be-4a4e-a5af-c19e0b8d9182@linux.ibm.com>
Date: Tue, 21 Oct 2025 11:40:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/10] paravirt CPUs and push task for less vCPU
 preemption
To: Sean Christopherson <seanjc@google.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tglx@linutronix.de, yury.norov@gmail.com,
        maddy@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, gregkh@linuxfoundation.org,
        vschneid@redhat.com, iii@linux.ibm.com, huschle@linux.ibm.com,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, vineeth@bitbyteword.org,
        jgross@suse.com, pbonzini@redhat.com
References: <20250910174210.1969750-1-sshegde@linux.ibm.com>
 <aPZIGCFk-Rnlc1yT@google.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <aPZIGCFk-Rnlc1yT@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uLQ51IFpXI-f1S0LN91L1JGQj03LN-Sg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX1vk1lybGQ6Fe
 wO892m8feMqe7cN4KGIZQNS2bOag+qb40ma1aglc7UqiZzq2R+kk9pR6Ym52l1ox/Q7wyTC8r2s
 GxXaAa0SwH9+0gJiMvvqSBgiSdKQZYMn5CYV22glnCEJwUEq0NmIz7ntbKEz2sNCW7p0MMZAzPA
 5TkQt6DxhVxe+e0dueRTNRPNxxlN9hIuObebTkNX4wHOROEf9tjXo83WxDFG7SVBS+jXaoZwjoT
 42jm9MmYdmV0hhL9bjoVZIHgNZYBmrc2xgiZ3m64UT7QJVAZDruGkL6Swa5XIJ2rc5WHNdSZhC5
 rp9iitqoHj0LyFe/PjVrUSDaBVGjia5b6bNgj5UtYtLZv/q4dJwTY1B9vpOzh99savfLTeG57MF
 Ldc/9L0AmkY92YPyprUGBWam765ufA==
X-Proofpoint-GUID: KQZh0LX1hRX94Ps7gicwC7mMjSADpojX
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68f723da cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=5Jhpb4gTAAAA:8 a=1XWaLZrsAAAA:8
 a=z21BhYytv6bLj3cK0hUA:9 a=QEXdDO2ut3YA:10 a=mZPqAYP_hWW8blobX25d:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022


Hi Sean.
Thanks for taking time and going through the series.

On 10/20/25 8:02 PM, Sean Christopherson wrote:
> On Wed, Sep 10, 2025, Shrikanth Hegde wrote:
>> tl;dr
>>
>> This is follow up of [1] with few fixes and addressing review comments.
>> Upgraded it to RFC PATCH from RFC.
>> Please review.
>>
>> [1]: v2 - https://lore.kernel.org/all/20250625191108.1646208-1-sshegde@linux.ibm.com/
>>
>> v2 -> v3:
>> - Renamed to paravirt CPUs
> 
> There are myriad uses of "paravirt" throughout Linux and related environments,
> and none of them mean "oversubscribed" or "contended".  I assume Hillf's comments
> triggered the rename from "avoid CPUs", but IMO "avoid" is at least somewhat
> accurate; "paravirt" is wildly misleading.

Name has been tricky. We want to have a positive sounding name while conveying
that these CPUs are not be used for now due to contention,
they may be used again when the contention has gone.


> 
>> - Folded the changes under CONFIG_PARAVIRT.
>> - Fixed the crash due work_buf corruption while using
>>    stop_one_cpu_nowait.
>> - Added sysfs documentation.
>> - Copy most of __balance_push_cpu_stop to new one, this helps it move
>>    the code out of CONFIG_HOTPLUG_CPU.
>> - Some of the code movement suggested.
>>
>> -----------------
>> ::Detailed info::
>> -----------------
>> Problem statement
>>
>> vCPU - Virtual CPUs - CPU in VM world.
>> pCPU - Physical CPUs - CPU in baremetal world.
>>
>> A hypervisor does scheduling of vCPUs on a pCPUs. It has to give each
>> vCPU some cycles and be fair. When there are more vCPU requests than
>> the pCPUs, hypervsior has to preempt some vCPUs in order to run others.
>> This is called as vCPU preemption.
>>
>> If we take two VM's, When hypervisor preempts vCPU from VM1 to run vCPU from
>> VM2, it has to do save/restore VM context.Instead if VM's can co-ordinate among
>> each other and request for limited  vCPUs, it avoids the above overhead and
>> there is context switching within vCPU(less expensive). Even if hypervisor
>> is preempting one vCPU to run another within the same VM, it is still more
>> expensive than the task preemption within the vCPU. So basic aim to avoid
>> vCPU preemption.
>>
>> So to achieve this, introduce "Paravirt CPU" concept, where it is better if
>> workload avoids these vCPUs at this moment. (vCPUs stays online, don't want
>> the overhead of sched domain rebuild and hotplug takes a lot of time too).
>>
>> When there is contention, don't use paravirt CPUs.
>> When there is no contention, use all vCPUs.
> 
> ...
> 
>> ------------
>> Open issues:
>>
>> - Derivation of hint from steal time is still a challenge. Some work is
>>    underway to address it.
>>
>> - Consider kvm and other hypervsiors and how they could derive the hint.
>>    Need inputs from community.
> 
> Bluntly, this series is never going to land, at least not in a form that's remotely
> close to what is proposed here.  This is an incredibly simplistic way of handling
> overcommit, and AFAICT there's no line of sight to supporting more complex scenarios.
> 

Could you describe these complex scenarios?

Current usecase has been on two archs. powerpc and s390.
IIUC, both have an non-linux hypervisor running on host and linux guests.

Currently the s390 Hypervsior has a way of marking vCPU has Vertical High,
vertical Medium, Vertical Low. So when there is steal time, arch could easily
mark vertical Lows as "paravirt" CPUs.

> I.e. I don't see a path to resolving all these "todos" in the changelog from the
> last patch:
> 
>   : Ideal would be get the hint from hypervisor. It would be more accurate
>   : since it has knowledge of all SPLPARs deployed in the system.
>   :
>   : Till the hint from underlying hypervisor arrives, another idea is to
>   : approximate the hint from steal time. There are some works ongoing, but
>   : not there yet due to challenges revolving around limits and
>   : convergence.
>   :
>   : Till that happens, there is a need for debugfs file which could be used to
>   : set/unset the hint. The interface currently is number starting from which
>   : CPUs will marked as paravirt. It could be changed to one the takes a
>   : cpumask(list of CPUs) in future.
> 
> I see Vineeth and Steven are on the Cc.  Argh, and you even commented on their
> first RFC[1], where it was made quite clear that sprinkling one-off "hints"
> throughoug the kernel wasn't a viable approach.

IIRC, it was in other direction. guest was asking the host to mark some vCPU has
RT task to have it boosted in host.

> 
> I don't know the current status of the ChromeOS work, but there was agreement in
> principle that the bulk of paravirt scheduling should not need to touch the kernel
> (host or guest)[2].
> 

Based on some event if all the tasks on a CPU have to move out, then scheduler needs to
be there no? to move the task out, and not schedule anything new on it.

The current mechanisms such as cpu hotplug, isolated partitions all break the task affinity.
So need a new mechanism.

Note: Host is not running linux kernel. We are requesting host to provide this info through
HCALL or VPA area.

> [1] https://lore.kernel.org/all/20231214024727.3503870-1-vineeth@bitbyteword.org
> [2] https://lore.kernel.org/all/ZjJf27yn-vkdB32X@google.com

Vineeth,
whats the latest on vcpu_boosted framework? AFAIR both guest/host were running linux there.


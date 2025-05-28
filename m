Return-Path: <linux-kernel+bounces-664904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8492FAC6210
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 08:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7340D1BC24ED
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 06:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E5E242D93;
	Wed, 28 May 2025 06:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oE3gosTj"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5276A201017
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 06:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748414276; cv=none; b=IhjuANuNT9KPVjtWiLNQ6Bg73PcvbbZhbUgSA3o4fBB5EuJK85y/KeL7+OKBkJV9OVofFfLFcgLasfppv6CgoULZ0NYBTb+MLqVCn6Frc8xbtdLl9PqU03D0tmeKS/rBXlX2bPDtbvl/MlIntIowBO5sCuqrCh+6q5/vAZ8xvtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748414276; c=relaxed/simple;
	bh=QdxSdB5O8arLPaXhqNSnuOn1D24TwdojBlnVIDeFlm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OlKEQXW+dkp0GBrB4Oc88QTt/5XDDvDa63sgSgeeWytiwOAOtq6AGlHSlbGI53z6uZp5Ff2XByHu4AXnIEcqpwB6OHAYG2lRW8azKp+XSwnMFtC9uDqwtlOoSfV2XSOAHTfpwYBIqcJ+lKgOl1P5N2wPWy/jtlX+bwbcRjnK+zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oE3gosTj; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748414264; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3ocuD1ul3n57xfwsiRwmLlmf/dVIDY83H6yZAAtxHOU=;
	b=oE3gosTjbS2I3la7hQZNjP6D8WE7631ODD7rGM83iIPWB+kA214SAq3yk3euXE67r9goOHX8DMa9ZtznG2UuGNfsPaI0fS0hcGkYKOGury41I6jIRsj02MOw2kDoRSvPVNhZSB/S8vu5F9qnO9VPHl64nhdG8tWreRovo3EtAJM=
Received: from 30.178.82.30(mailfrom:qinyuntan@linux.alibaba.com fp:SMTPD_---0WcCHyMf_1748414263 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 May 2025 14:37:44 +0800
Message-ID: <37f6345f-7536-45a3-8c85-6b2bfdba2fe6@linux.alibaba.com>
Date: Wed, 28 May 2025 14:37:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] x86/resctrl: Remove unnecessary references to cacheinfo
 in the resctrl subsystem.
To: Reinette Chatre <reinette.chatre@intel.com>,
 Tony Luck <tony.luck@intel.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <20250526073744.62520-1-qinyuntan@linux.alibaba.com>
 <c4382156-a51e-4d07-9ccb-e6db2ca9d719@intel.com>
 <b67949b8-7eac-47b4-a667-6343837226f7@linux.alibaba.com>
 <5b446254-a2c8-4f01-93bf-3a348d474820@intel.com>
From: qinyuntan <qinyuntan@linux.alibaba.com>
In-Reply-To: <5b446254-a2c8-4f01-93bf-3a348d474820@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Reinette Chatre,

On 5/28/25 12:49 PM, Reinette Chatre wrote:
> Hi Qinyun Tan,
> 
> On 5/27/25 8:32 PM, qinyuntan wrote:
>> On 5/28/25 7:36 AM, Reinette Chatre wrote:
>>> On 5/26/25 12:37 AM, Qinyun Tan wrote:
> 
> 
>>>> first online CPU of a NUMA node. If this CPU later goes offline, the
>>>> shared_cpu_map (managed by the cache subsystem) is cleared, leading to
>>>
>>> "is cleared" sounds like the shared_cpu_map is empty. Looking at
>>> cache_shared_cpu_map_remove() it seems that the worst case is when the
>>> CPU goes offline the shared_cpu_map only contains the offline CPU itself.
>>> If there remains a reference to that shared_cpu_map then it will thus be
>>> to a cpumask with an offline CPU. Are you seeing other scenarios?
>>>
>> Yes, you are right. Once this CPU goes offline, its shared_cpu_map
>> will only include itself. If we then try to call this offline CPU
>> using smp_call_on_cpu, it will result in a failure.
> 
> Thank you for confirming. Could you please update this changelog to reflect
> this detail? Doing so will remove confusion and make the change easier to
> consume by making it obvious to reader what the problem is.
Thank you for your patient review, I will update this changelog in the 
next patch.

>   
>>>> incorrect or undefined behavior when accessed via rdt_mon_domain.
>>>
>>> Could you please elaborate what "incorrect and undefined behavior" you
>>> encountered?
>>> It looks like reading the top level event would not be able to read
>>> an event from one (or more?) of the online domains since the shared_cpu_map
>>> will contain an offline CPU causing smp_call_on_cpu() to return with a failure
>>> that is not caught ... the symptom may this be that there are no errors but
>>> data is wrong?
>>
>> Yes, there won't be any errors here, but when reading the top-level events, it may not retrieve any values.
>>
>> For example, in the SNC-3 mode, suppose cpus 0, 40, and 80 are the
>> firtst online cpus on node0, node1, and node2 respectively. If cpus
>> 0, 40, and 80 are all offline, At this point, reading "the top level
>> event" will result in a zero.
> 
> This is SNC-3 mode with a single socket example where CPU 0 cannot
> go offline. I thus do not see this happening for the reason you provide below.
> 
> I *can* see how this happens on a second socket when the first online CPU
> of the first node of that (the second) socket goes offline.
>   

>> Why hasn’t this issue been discovered earlier? The reason is that CPU0 is always the first online CPU on node0. The cacheinfo stored in the first rdt_mon_domain corresponds to CPU0. When rdtgroup_mondata_show reads the top-level event, it iterates through all rdt_mon_domain entries, using if (d->ci->id == domid) to find the first rdt_mon_domain that shares the resource. It then selects a CPU from the corresponding cacheinfo to perform the monitoring group data read operation. In a single-socket environment, all CPUs typically share the L3 Cache, which means this traversal action will usually lead directly to CPU0's cacheinfo. Additionally, since the mainline kernel no longer supports taking CPU0 offline, that cacheinfo remains valid indefinitely.
>>
>>>
>>>>
>>>> 2. Lifecycle dependency: The cacheinfo structure's lifecycle is managed
>>>> by the cache subsystem, making it unsafe for resctrl to hold
>>>> long-term references.
>>>
>>> This is not obvious to me. Could you please elaborate how resctrl could
>>> have a reference to a removed structure?
>> As mentioned above, although the cacheinfo of each CPU is not freed
>> in the latest mainline, the shared_cpu_map within the cacheinfo will
>> be modified as CPUs go online or offline. Each rdt_mon_domain
>> directly references the cacheinfo of the first online CPU in the
>> node, and the shared_cpu_map is used in various processes. This
>> situation is bound to lead to some problems.
> 
> Claiming that it is unsafe for resctrl to hold a reference implies that
> resctrl uses an invalid pointer. This is not the case here. The pointer
> is valid, but the data pointed to by it does not support resctrl's usage. I
> thus do not believe that this "lifecycle dependency" point is a valid
> motivation for this change.My description is indeed inaccurate. I will adjust it in the next patch. 
Thanks.

>   
>>>
>>>>
>>>> To resolve these issues and align with design principles:
>>>>
>>>> 1. Replace direct cacheinfo references in struct rdt_mon_domain and struct
>>>> rmid_read with the cacheinfo ID (a unique identifier for the L3 cache).
>>>>
>>>> 2. Use hdr.cpu_mask (already maintained by resctrl) to replace
>>>> shared_cpu_map logic for determining valid CPUs for RMID counter reads
>>>> via the MSR interface.
>>>
>>> I think it will help to explain why it is ok now to use hdr.cpu_mask instead
>>> of the shared_cpu_map. In support of this you could mention that the original
>>> solution aimed to read the counters on any CPU associated with the L3 cache
>>> that the sub-numa domain forms part of, but this solution uses the
>>> cpumask of one of the sub-numa domains that is known to be associated with
>>> the L3 cache. This is a reduced set of CPUs from previously intended but
>>> known to be accurate. Alternative may be to build a local cpumask from the
>>> all the sub-numa domains but it is not clear to me how much this will
>>> improve things.
>>>
>>> Considering this I do not think the references are "unnecessary" as the
>>> subject claims since the solution does not replace the original cpumask with
>>> an identical one.
>>
>> Thanks a lot, you are correct. hdr.cpu_mask is a subset of
>> shared_cpu_map, and we can almost use hdr.cpu_mask to replace the
>> functionality of shared_cpu_map.
>>
>> In fact, in resctrl, the only purpose of using cpu_mask is to select
>> a CPU that shares the cache resource for performing monitoring group
>> data reads. Therefore, I think there is no need to build a local
>> cpumask from all the sub-NUMA domains in this context.
> 
> One issue I can think of here is when there is a usage where the user does
> task isolation on the numa node boundary. Let's consider the SNC-3 example
> again with node3, node4, and node5 on the second socket, "L3 cache ID 1".
> If all CPUs on node3 are in tick_nohz_full_mask while none of the node4 and
> node5 CPUs are in tick_nohz_full_mask then one of node3's CPUs will get
> an unnecessary IPI.
> 
You are right, how about this? First, obtain any cpu in hdr.cpu_mask, 
and then use the cacheinfo shared_cpu_map of this cpu:

diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 9337787461d2d..d43f438465ad0 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -596,7 +596,8 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
         struct rdtgroup *rdtgrp;
         struct rdt_resource *r;
         struct mon_data *md;
-       int domid, ret = 0;
+       struct cacheinfo *ci;
+       int domid, cpu, ret = 0;

         rdtgrp = rdtgroup_kn_lock_live(of->kn);
         if (!rdtgrp) {
@@ -625,8 +626,12 @@ int rdtgroup_mondata_show(struct seq_file *m, void 
*arg)
                 list_for_each_entry(d, &r->mon_domains, hdr.list) {
                         if (d->ci_id == domid) {
                                 rr.ci_id = d->ci_id;
+                               cpu = cpumask_any(&d->hdr.cpu_mask)
+                               ci = get_cpu_cacheinfo_level(cpu, 
RESCTRL_L3_CACHE);
+                               if (!ci)
+                                       continue;
                                 mon_event_read(&rr, r, NULL, rdtgrp,
-                                              &d->hdr.cpu_mask, evtid, 
false);
+                                              &ci->shared_cpu_map, 
evtid, false);
                                 goto checkresult;
                         }
                 }

>>
>> I will provide a more detailed description in my commit log moving
>> forward.
> 
> Thank you very much.
> 
> Reinette

Thanks
Qinyun Tan



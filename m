Return-Path: <linux-kernel+bounces-668650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D99AC958C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 20:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7DB1BA2A60
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 18:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1982027703D;
	Fri, 30 May 2025 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CYwyBCsU"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954A5221277
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 18:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748629016; cv=none; b=MF6R1EerYjrldSX+siOMctr2I7LipUCGKoCUFcS6mAjKG7rE9tOXH+d4o0xE6+BGqCNxTufPaDuuFeQZz27TBs8YZXzZInUa+JD780tcT+PNgh7KN6SnXrQsNkSHO2Vj2Iky84O9Xb8dF4TRdaIFkFHdXeyS3nQNp6BNVR6daCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748629016; c=relaxed/simple;
	bh=cldhVd4QjNXQSFQTU5AZ0Ly/mbvtSTPNLtfMhnakxi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sX/IrC0kIluLZOQO3XgthotssgvDbs7cR8e0HKqwL9C57HASrZeRf1K1LUiHL9+pKB3DB1uz12ul1qDycRiVQCldDMVpZq5IcopHZxaxwZIJl1ki98pG1SLQ8P8rQOxxzqrlFnOmE5umv/L8cm3rWPSBo99aROcCVSxAGPJm6Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CYwyBCsU; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748629004; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JUieF79h06bGRU9Sfl5FOpTGBiBykRpNs9e0+n3qH7Q=;
	b=CYwyBCsU1Eou8+8Y/E8FJtxYd3cuvs3GTsm2KzwLsRz7seCmG8zdlg2Ciig984g8S6pnVxWcn2neX6GbhGr3eAXl8S+JcvNPwxQlFiAsWl5UOINoZHHCfQ5QNLDXTSf5849u+irJinwykl6jKS+zXz9cjpa13PZtoY+oHAFk/iY=
Received: from 30.178.175.31(mailfrom:qinyuntan@linux.alibaba.com fp:SMTPD_---0WcMAymr_1748629003 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 31 May 2025 02:16:44 +0800
Message-ID: <e37d46f1-9b60-4809-b929-79244ff98189@linux.alibaba.com>
Date: Sat, 31 May 2025 02:16:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH V4 1/1] x86/resctrl: Remove unappropriate references to
 cacheinfo in the resctrl subsystem.
To: "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
 Tony Luck <tony.luck@intel.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, Reinette Chatre <reinette.chatre@intel.com>
References: <20250530175027.30140-1-qinyuntan@linux.alibaba.com>
 <20250530175027.30140-2-qinyuntan@linux.alibaba.com>
 <7bfbc2b0-d4a2-4c2c-908f-6d3eb98ae1f5@intel.com>
From: qinyuntan <qinyuntan@linux.alibaba.com>
In-Reply-To: <7bfbc2b0-d4a2-4c2c-908f-6d3eb98ae1f5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Keshavamurthy, Anil S:

Ok, This suggestion is very reasonable. A few seconds before receiving 
your email, I have sent the Patch of version 5, so just let me send the 
Patch of version 6 again :).

On 5/31/25 2:11 AM, Keshavamurthy, Anil S wrote:
> Hi Qinyun,
> 
> Ever since this resctrl subsystem has been refactored to support other 
> architectures by moving common files related to filesystem handling into 
> fs/resctrl/*, I have seen folks started to tag the subject line with 
> "x86,fs/resctrl:" when patch touches files under fs/resctrl. Since your 
> patches touches files under both arch/x86 and fs/resctrl/*, can you 
> please accommodate this subject tag -> "x86,fs/resctrl:" so we are 
> consistent.
> 
> /Anil
> 
> On 5/30/2025 10:50 AM, Qinyun Tan wrote:
>> In the resctrl subsystem's Sub-NUMA Cluster (SNC) mode, the 
>> rdt_mon_domain
>> structure representing a NUMA node relies on the cacheinfo interface
>> (rdt_mon_domain::ci) to store L3 cache information (e.g., shared_cpu_map)
>> for monitoring. The L3 cache information of a SNC NUMA node determines
>> which domains are summed for the "top level" L3-scoped events.
>>
>> rdt_mon_domain::ci is initialized using the first online CPU of a NUMA
>> node. When this CPU goes offline, its shared_cpu_map is cleared to 
>> contain
>> only the offline CPU itself. Subsequently, attempting to read counters
>> via smp_call_on_cpu(offline_cpu) fails (and error ignored), returning
>> zero values for "top-level events" without any error indication. Replace
>> the cacheinfo references in struct rdt_mon_domain and struct rmid_read
>> with the cacheinfo ID (a unique identifier for the L3 cache).
>>
>> rdt_domain_hdr::cpu_mask contains the online CPUs associated with that
>> domain. When reading "top-level events", select a CPU from
>> rdt_domain_hdr::cpu_mask and utilize its L3 shared_cpu_map to determine
>> valid CPUs for reading RMID counter via the MSR interface.
>>
>> Considering all CPUs associated with the L3 cache improves the chances
>> of picking a housekeeping CPU on which the counter reading work can be
>> queued, avoiding an unnecessary IPI.
>>
>> Fixes: 328ea68874642 ("x86/resctrl: Prepare for new Sub-NUMA Cluster 
>> (SNC) monitor files")
>> Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
>> Tested-by: Tony Luck <tony.luck@intel.com>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---
>>   arch/x86/kernel/cpu/resctrl/core.c |  6 ++++--
>>   fs/resctrl/ctrlmondata.c           | 13 +++++++++----
>>   fs/resctrl/internal.h              |  4 ++--
>>   fs/resctrl/monitor.c               |  6 ++++--
>>   fs/resctrl/rdtgroup.c              |  6 +++---
>>   include/linux/resctrl.h            |  4 ++--
>>   6 files changed, 24 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/ 
>> resctrl/core.c
>> index 7109cbfcad4fd..187d527ef73b6 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -498,6 +498,7 @@ static void domain_add_cpu_mon(int cpu, struct 
>> rdt_resource *r)
>>       struct rdt_hw_mon_domain *hw_dom;
>>       struct rdt_domain_hdr *hdr;
>>       struct rdt_mon_domain *d;
>> +    struct cacheinfo *ci;
>>       int err;
>>       lockdep_assert_held(&domain_list_lock);
>> @@ -525,12 +526,13 @@ static void domain_add_cpu_mon(int cpu, struct 
>> rdt_resource *r)
>>       d = &hw_dom->d_resctrl;
>>       d->hdr.id = id;
>>       d->hdr.type = RESCTRL_MON_DOMAIN;
>> -    d->ci = get_cpu_cacheinfo_level(cpu, RESCTRL_L3_CACHE);
>> -    if (!d->ci) {
>> +    ci = get_cpu_cacheinfo_level(cpu, RESCTRL_L3_CACHE);
>> +    if (!ci) {
>>           pr_warn_once("Can't find L3 cache for CPU:%d resource %s\n", 
>> cpu, r->name);
>>           mon_domain_free(hw_dom);
>>           return;
>>       }
>> +    d->ci_id = ci->id;
>>       cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
>>       arch_mon_domain_online(r, d);
>> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
>> index 6ed2dfd4dbbd9..d98e0d2de09fd 100644
>> --- a/fs/resctrl/ctrlmondata.c
>> +++ b/fs/resctrl/ctrlmondata.c
>> @@ -594,9 +594,10 @@ int rdtgroup_mondata_show(struct seq_file *m, 
>> void *arg)
>>       struct rmid_read rr = {0};
>>       struct rdt_mon_domain *d;
>>       struct rdtgroup *rdtgrp;
>> +    int domid, cpu, ret = 0;
>>       struct rdt_resource *r;
>> +    struct cacheinfo *ci;
>>       struct mon_data *md;
>> -    int domid, ret = 0;
>>       rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>       if (!rdtgrp) {
>> @@ -623,10 +624,14 @@ int rdtgroup_mondata_show(struct seq_file *m, 
>> void *arg)
>>            * one that matches this cache id.
>>            */
>>           list_for_each_entry(d, &r->mon_domains, hdr.list) {
>> -            if (d->ci->id == domid) {
>> -                rr.ci = d->ci;
>> +            if (d->ci_id == domid) {
>> +                rr.ci_id = d->ci_id;
>> +                cpu = cpumask_any(&d->hdr.cpu_mask);
>> +                ci = get_cpu_cacheinfo_level(cpu, RESCTRL_L3_CACHE);
>> +                if (!ci)
>> +                    continue;
>>                   mon_event_read(&rr, r, NULL, rdtgrp,
>> -                           &d->ci->shared_cpu_map, evtid, false);
>> +                           &ci->shared_cpu_map, evtid, false);
>>                   goto checkresult;
>>               }
>>           }
>> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
>> index 9a8cf6f11151d..0a1eedba2b03a 100644
>> --- a/fs/resctrl/internal.h
>> +++ b/fs/resctrl/internal.h
>> @@ -98,7 +98,7 @@ struct mon_data {
>>    *       domains in @r sharing L3 @ci.id
>>    * @evtid: Which monitor event to read.
>>    * @first: Initialize MBM counter when true.
>> - * @ci:    Cacheinfo for L3. Only set when @d is NULL. Used when 
>> summing domains.
>> + * @ci_id: Cacheinfo id for L3. Only set when @d is NULL. Used when 
>> summing domains.
>>    * @err:   Error encountered when reading counter.
>>    * @val:   Returned value of event counter. If @rgrp is a parent 
>> resource group,
>>    *       @val includes the sum of event counts from its child 
>> resource groups.
>> @@ -112,7 +112,7 @@ struct rmid_read {
>>       struct rdt_mon_domain    *d;
>>       enum resctrl_event_id    evtid;
>>       bool            first;
>> -    struct cacheinfo    *ci;
>> +    unsigned int        ci_id;
>>       int            err;
>>       u64            val;
>>       void            *arch_mon_ctx;
>> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
>> index bde2801289d35..f5637855c3aca 100644
>> --- a/fs/resctrl/monitor.c
>> +++ b/fs/resctrl/monitor.c
>> @@ -361,6 +361,7 @@ static int __mon_event_count(u32 closid, u32 rmid, 
>> struct rmid_read *rr)
>>   {
>>       int cpu = smp_processor_id();
>>       struct rdt_mon_domain *d;
>> +    struct cacheinfo *ci;
>>       struct mbm_state *m;
>>       int err, ret;
>>       u64 tval = 0;
>> @@ -388,7 +389,8 @@ static int __mon_event_count(u32 closid, u32 rmid, 
>> struct rmid_read *rr)
>>       }
>>       /* Summing domains that share a cache, must be on a CPU for that 
>> cache. */
>> -    if (!cpumask_test_cpu(cpu, &rr->ci->shared_cpu_map))
>> +    ci = get_cpu_cacheinfo_level(cpu, RESCTRL_L3_CACHE);
>> +    if (!ci || ci->id != rr->ci_id)
>>           return -EINVAL;
>>       /*
>> @@ -400,7 +402,7 @@ static int __mon_event_count(u32 closid, u32 rmid, 
>> struct rmid_read *rr)
>>        */
>>       ret = -EINVAL;
>>       list_for_each_entry(d, &rr->r->mon_domains, hdr.list) {
>> -        if (d->ci->id != rr->ci->id)
>> +        if (d->ci_id != rr->ci_id)
>>               continue;
>>           err = resctrl_arch_rmid_read(rr->r, d, closid, rmid,
>>                            rr->evtid, &tval, rr->arch_mon_ctx);
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index cc37f58b47dd7..74b25bbb9872c 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
>> @@ -3034,7 +3034,7 @@ static void 
>> rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
>>       char name[32];
>>       snc_mode = r->mon_scope == RESCTRL_L3_NODE;
>> -    sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci->id : d- 
>> >hdr.id);
>> +    sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci_id : d- 
>> >hdr.id);
>>       if (snc_mode)
>>           sprintf(subname, "mon_sub_%s_%02d", r->name, d->hdr.id);
>> @@ -3059,7 +3059,7 @@ static int mon_add_all_files(struct kernfs_node 
>> *kn, struct rdt_mon_domain *d,
>>           return -EPERM;
>>       list_for_each_entry(mevt, &r->evt_list, list) {
>> -        domid = do_sum ? d->ci->id : d->hdr.id;
>> +        domid = do_sum ? d->ci_id : d->hdr.id;
>>           priv = mon_get_kn_priv(r->rid, domid, mevt, do_sum);
>>           if (WARN_ON_ONCE(!priv))
>>               return -EINVAL;
>> @@ -3087,7 +3087,7 @@ static int mkdir_mondata_subdir(struct 
>> kernfs_node *parent_kn,
>>       lockdep_assert_held(&rdtgroup_mutex);
>>       snc_mode = r->mon_scope == RESCTRL_L3_NODE;
>> -    sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci->id : d- 
>> >hdr.id);
>> +    sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci_id : d- 
>> >hdr.id);
>>       kn = kernfs_find_and_get(parent_kn, name);
>>       if (kn) {
>>           /*
>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index 9ba771f2ddead..6fb4894b8cfd1 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -159,7 +159,7 @@ struct rdt_ctrl_domain {
>>   /**
>>    * struct rdt_mon_domain - group of CPUs sharing a resctrl monitor 
>> resource
>>    * @hdr:        common header for different domain types
>> - * @ci:            cache info for this domain
>> + * @ci_id:        cache info id for this domain
>>    * @rmid_busy_llc:    bitmap of which limbo RMIDs are above threshold
>>    * @mbm_total:        saved state for MBM total bandwidth
>>    * @mbm_local:        saved state for MBM local bandwidth
>> @@ -170,7 +170,7 @@ struct rdt_ctrl_domain {
>>    */
>>   struct rdt_mon_domain {
>>       struct rdt_domain_hdr        hdr;
>> -    struct cacheinfo        *ci;
>> +    unsigned int            ci_id;
>>       unsigned long            *rmid_busy_llc;
>>       struct mbm_state        *mbm_total;
>>       struct mbm_state        *mbm_local;



Return-Path: <linux-kernel+bounces-841256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B732BB6A6C
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 14:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA5F4289BC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 12:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A11B2F5339;
	Fri,  3 Oct 2025 12:19:35 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD582F5315
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 12:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759493975; cv=none; b=cevRDzHlS5hkwn+ee9gMyf0c824M0RaqsdHOrID3nX3mCRob3ogvoy4Z0DMexSQBLRS+Lxllfnn5P0bibmTlT+HkSjpvIk+iIOiu9nWS0/5iq6lMPjaxJQdLl14ikqVBe+Cao9OpAHpGQeg+T288tf5xjyJB/Ht+7byeysCZBjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759493975; c=relaxed/simple;
	bh=0A9xfTRi9hgkqNMR2Zi8PjhviZEdCv7P77TE3GzvpsQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUAwK6sBf+63Go/aO1MqNd5ym7/vAa76xc7SS9Nkp2rU6Npgfzj3tgtpArfwQXk8W+LO4C9Czecod7AP/aTT7rBT7PC5Y1SVFmTcmeDzfLaP7OtVMV6JbNeOzBL61IbHQzZnIzGRoozFlo9gAgX9a1w/jb7563r0j8GBTBaMMBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cdSLp26Jcz6K8tQ;
	Fri,  3 Oct 2025 20:16:18 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A5E7140278;
	Fri,  3 Oct 2025 20:19:29 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 3 Oct
 2025 13:19:28 +0100
Date: Fri, 3 Oct 2025 13:19:26 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Bharata B Rao <bharata@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<dave.hansen@intel.com>, <gourry@gourry.net>, <hannes@cmpxchg.org>,
	<mgorman@techsingularity.net>, <mingo@redhat.com>, <peterz@infradead.org>,
	<raghavendra.kt@amd.com>, <riel@surriel.com>, <rientjes@google.com>,
	<sj@kernel.org>, <weixugc@google.com>, <willy@infradead.org>,
	<ying.huang@linux.alibaba.com>, <ziy@nvidia.com>, <dave@stgolabs.net>,
	<nifan.cxl@gmail.com>, <xuezhengchu@huawei.com>, <yiannis@zptcorp.com>,
	<akpm@linux-foundation.org>, <david@redhat.com>, <byungchul@sk.com>,
	<kinseyho@google.com>, <joshua.hahnjy@gmail.com>, <yuanchu@google.com>,
	<balbirs@nvidia.com>, <alok.rathore@samsung.com>
Subject: Re: [RFC PATCH v2 4/8] x86: ibs: In-kernel IBS driver for memory
 access profiling
Message-ID: <20251003131926.0000363f@huawei.com>
In-Reply-To: <20250910144653.212066-5-bharata@amd.com>
References: <20250910144653.212066-1-bharata@amd.com>
	<20250910144653.212066-5-bharata@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 10 Sep 2025 20:16:49 +0530
Bharata B Rao <bharata@amd.com> wrote:

> Use IBS (Instruction Based Sampling) feature present
> in AMD processors for memory access tracking. The access
> information obtained from IBS via NMI is fed to kpromoted
> daemon for futher action.
> 
> In addition to many other information related to the memory
> access, IBS provides physical (and virtual) address of the access
> and indicates if the access came from slower tier. Only memory
> accesses originating from slower tiers are further acted upon
> by this driver.
> 
> The samples are initially accumulated in percpu buffers which
> are flushed to pghot hot page tracking mechanism using irq_work.
> 
> TODO: Many counters are added to vmstat just as debugging aid
> for now.
> 
> About IBS
> ---------
> IBS can be programmed to provide data about instruction
> execution periodically. This is done by programming a desired
> sample count (number of ops) in a control register. When the
> programmed number of ops are dispatched, a micro-op gets tagged,
> various information about the tagged micro-op's execution is
> populated in IBS execution MSRs and an interrupt is raised.
> While IBS provides a lot of data for each sample, for the
> purpose of  memory access profiling, we are interested in
> linear and physical address of the memory access that reached
> DRAM. Recent AMD processors provide further filtering where
> it is possible to limit the sampling to those ops that had
> an L3 miss which greately reduces the non-useful samples.
> 
> While IBS provides capability to sample instruction fetch
> and execution, only IBS execution sampling is used here
> to collect data about memory accesses that occur during
> the instruction execution.
> 
> More information about IBS is available in Sec 13.3 of
> AMD64 Architecture Programmer's Manual, Volume 2:System
> Programming which is present at:
> https://bugzilla.kernel.org/attachment.cgi?id=288923
> 
> Information about MSRs used for programming IBS can be
> found in Sec 2.1.14.4 of PPR Vol 1 for AMD Family 19h
> Model 11h B1 which is currently present at:
> https://www.amd.com/system/files/TechDocs/55901_0.25.zip
> 
> Signed-off-by: Bharata B Rao <bharata@amd.com>
> ---
>  arch/x86/events/amd/ibs.c        |  11 ++
>  arch/x86/include/asm/ibs.h       |   7 +
>  arch/x86/include/asm/msr-index.h |  16 ++
>  arch/x86/mm/Makefile             |   3 +-
>  arch/x86/mm/ibs.c                | 311 +++++++++++++++++++++++++++++++
>  include/linux/vm_event_item.h    |  17 ++
>  mm/vmstat.c                      |  17 ++
>  7 files changed, 381 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/include/asm/ibs.h
>  create mode 100644 arch/x86/mm/ibs.c
> 
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 112f43b23ebf..1498dc9caeb2 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -13,9 +13,11 @@
>  #include <linux/ptrace.h>
>  #include <linux/syscore_ops.h>
>  #include <linux/sched/clock.h>
> +#include <linux/pghot.h>
>  
>  #include <asm/apic.h>
>  #include <asm/msr.h>
> +#include <asm/ibs.h>
>  
>  #include "../perf_event.h"
>  
> @@ -1756,6 +1758,15 @@ static __init int amd_ibs_init(void)
>  {
>  	u32 caps;
>  
> +	/*
> +	 * TODO: Find a clean way to disable perf IBS so that IBS
> +	 * can be used for memory access profiling.

Agreed on this being a key thing.  This applies to quite a few
other sources of data so finding a generally acceptable solution to this
would be great.  Davidlohr mentioned on the CXL sync that he has
something tackling this for the CHMU driver around this.


> +	 */
> +	if (arch_hw_access_profiling) {
> +		pr_info("IBS isn't available for perf use\n");
> +		return 0;
> +	}
> +
>  	caps = __get_ibs_caps();
>  	if (!caps)
>  		return -ENODEV;	/* ibs not supported by the cpu */

> diff --git a/arch/x86/mm/ibs.c b/arch/x86/mm/ibs.c
> new file mode 100644
> index 000000000000..6669710dd35b
> --- /dev/null
> +++ b/arch/x86/mm/ibs.c
> @@ -0,0 +1,311 @@

...

> +
> +static int ibs_pop_sample(struct ibs_sample *s)
> +{
> +	struct ibs_sample_pcpu *ibs_pcpu = raw_cpu_ptr(ibs_s);
> +
> +	int next = ibs_pcpu->tail + 1;
> +
> +	if (ibs_pcpu->head == ibs_pcpu->tail)
> +		return 0;
> +
> +	if (next >= IBS_NR_SAMPLES)

== seems more appropriate to me.  If it's > then something went wrong
and we lost data.

> +		next = 0;
> +
> +	*s = ibs_pcpu->samples[ibs_pcpu->tail];
> +	ibs_pcpu->tail = next;
> +	return 1;
> +}


> +static void setup_APIC_ibs(void)
> +{
> +	int offset;
> +
> +	offset = get_ibs_lvt_offset();
> +	if (offset < 0)
> +		goto failed;
> +
> +	if (!setup_APIC_eilvt(offset, 0, APIC_EILVT_MSG_NMI, 0))
> +		return;
> +failed:
> +	pr_warn("IBS APIC setup failed on cpu #%d\n",
> +		smp_processor_id());

Unless this is going to get more complex, move that up to the if () block
above and return directly there.

> +}

> +static int __init ibs_access_profiling_init(void)
> +{
> +	if (!boot_cpu_has(X86_FEATURE_IBS)) {
> +		pr_info("IBS capability is unavailable for access profiling\n");
> +		return 0;
> +	}
> +
> +	ibs_s = alloc_percpu_gfp(struct ibs_sample_pcpu, GFP_KERNEL | __GFP_ZERO);

sizeof(*ibs_s).
Same as in other cases. It's nice to avoid having to check types when reviewing code.

> +	if (!ibs_s)
> +		return 0;
> +
> +	INIT_WORK(&ibs_work, ibs_work_handler);
> +	init_irq_work(&ibs_irq_work, ibs_irq_handler);
> +
> +	/* Uses IBS Op sampling */
> +	ibs_config = IBS_OP_CNT_CTL | IBS_OP_ENABLE;
> +	ibs_caps = cpuid_eax(IBS_CPUID_FEATURES);
> +	if (ibs_caps & IBS_CAPS_ZEN4)
> +		ibs_config |= IBS_OP_L3MISSONLY;
ibs_config seems to only be used locally so the global seems unnecessary.
You'll need to pass it in to the one user in the next patch though.


> +
> +	register_nmi_handler(NMI_LOCAL, ibs_overflow_handler, 0, "ibs");
> +
> +	cpuhp_setup_state(CPUHP_AP_PERF_X86_AMD_IBS_STARTING,
> +			  "x86/amd/ibs_access_profile:starting",
> +			  x86_amd_ibs_access_profile_startup,
> +			  x86_amd_ibs_access_profile_teardown);
> +
> +	pr_info("IBS setup for memory access profiling\n");
> +	return 0;
> +}
> +
> +arch_initcall(ibs_access_profiling_init);




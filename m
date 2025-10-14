Return-Path: <linux-kernel+bounces-853252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9477BBDB053
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE06619A11EF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4692BEFEF;
	Tue, 14 Oct 2025 19:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OBCeQctA"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D4623D7D9
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760469232; cv=none; b=rSdZi12nyvyv8ANOmiXaLhLX2H2ZFQ4XoW7uceRrG+IlPgE4mJ4QmnkX20klilLA/y1L4MoyoAPE+bQ8MN3kzYk2nT92YsPoPwZeDBvyyB5pqDctgtNFdcPXgXTRcULkyyMHvXqO4l9o1NbDUXhRl47H2gKh+6sKhnYcohti6rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760469232; c=relaxed/simple;
	bh=U1k12o9oAy8BR+kbpEN6LmCvdHZe9D0DTNd/RppePz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJMrxV5HPQU9w/R+rTcHZ6gjf92bcVxxbphtspaspPzRSf/BMFhoIknzUPEPSZV6LdjMBad2GSY/aFl9chPSNRwMexSgv9Fpk+ZiJSfCDzpxR84HblPEjoJ7248y1PxWD/IDqm/BvdDRu8B8JXBxOMGU0H6ucaCnCng0Mx0H9ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OBCeQctA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EInLCr007549;
	Tue, 14 Oct 2025 19:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qVsO63
	f/z2K6PSaLKSoo7ZqbdcSDriXAYRXy0IdOOC4=; b=OBCeQctAmBn7mAjGb3d7q2
	m6wAPZ7RBkZaMSKNcQiCRQeZD6xJ2sOh2NNam9QJi5Lh8fLGUxxgiCuMIzQehq1R
	KpcgT+cVjjKOg66G9SvivmKfZ81nUQdMkPyLMpPlInt1neNeCYHQQQxRmqmNJE5P
	f3Weu9IHKyiO5g6RUOwNck0ji/z2Gz4Sj0LM98Sj0khEtc3Add8D5ENMlA+AOi/L
	lv1IM7+givy93YPYW2aXQSbXUVi0q8XCSDaOewEiAIsAtYcEpJ2qyChDXCSeYWAl
	efcycewD/PN0o3FDoUiTNixdDGiyTCWjAOA6ZEw7JPUVIsr/h8vkKq8hOqbYVvGg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey8rma7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 19:13:13 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59EJDDB9015952;
	Tue, 14 Oct 2025 19:13:13 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey8rma4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 19:13:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59EIZmHC016745;
	Tue, 14 Oct 2025 19:13:11 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32jvha7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 19:13:11 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59EJDArr31916692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 19:13:10 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2290B58059;
	Tue, 14 Oct 2025 19:13:10 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 599D758043;
	Tue, 14 Oct 2025 19:12:51 +0000 (GMT)
Received: from [9.43.109.181] (unknown [9.43.109.181])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Oct 2025 19:12:50 +0000 (GMT)
Message-ID: <22750d4a-fdd6-48ad-a2ca-aa0c12af329c@linux.ibm.com>
Date: Wed, 15 Oct 2025 00:42:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/19] sched/fair: Add infrastructure for cache-aware load
 balancing
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Jianyong Wu <jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>,
        Tingyin Duan <tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>,
        Len Brown <len.brown@intel.com>, Aubrey Li <aubrey.li@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
        Chen Yu <yu.c.chen@intel.com>, Libo Chen <libo.chen@oracle.com>,
        Adam Li <adamli@os.amperecomputing.com>,
        Tim Chen <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <865b852e3fdef6561c9e0a5be9a94aec8a68cdea.1760206683.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <865b852e3fdef6561c9e0a5be9a94aec8a68cdea.1760206683.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vy9cthBCznmPrJbYVL_pNFU9irnF0Atk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfX8BEDgc/Q/u8Z
 SpOlBHoff4ZZ3zR2zVUEBg2dzkZiWmpR0wpzdKW3mjSztytujBrnC+AAUCdrCh+SQt0Nz/Bokaw
 FGsrr35Ty7gmv96X8nfAx7WXxkJbQuXqz2SMgn0lflpTQkSlRdVLu2jT0gW1b1xtwcmz9Yw79rb
 TA9gY4cnf4SO5DyYVt14e9a0qCq2QRKSceKfYl4uzxRIVNExfrcyfJgY+4W8Tk0roO+pWkMgDuP
 1mOfFjNB9MhVi6dnHUsyf4ecGv0r5sC4/LFLlwH3wMaI/6cIdOqQHxqPYeQ2CyRJwLxAIs74QP6
 bnoRh7MyJcXrR15kt0EeRbuXf1hIWeMOQHZb+LL4Ms/OgjySL/VWQbnIfv37coASbIMJuAatZLY
 ZmEkVsNyMKXwwsZpPWlDyPc+JsNRjA==
X-Proofpoint-GUID: mCfeGsdFB55jvQuCWdFi2tWli0ksHE08
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68eea0c9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JfrnYn6hAAAA:8 a=HSgpx3vWwCVBdPJoDrAA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011

On 11/10/25 23:54, Tim Chen wrote:
> From: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> 
> Cache-aware load balancing aims to aggregate tasks with potential
> shared resources into the same cache domain. This approach enhances
> cache locality, thereby optimizing system performance by reducing
> cache misses and improving data access efficiency.
> 

[snip]

> +static void get_scan_cpumasks(cpumask_var_t cpus, int cache_cpu,
> +			      int pref_nid, int curr_cpu)
> +{
> +#ifdef CONFIG_NUMA_BALANCING
> +	/* First honor the task's preferred node. */
> +	if (pref_nid != NUMA_NO_NODE)
> +		cpumask_or(cpus, cpus, cpumask_of_node(pref_nid));
> +#endif
> +
> +	/* Next honor the task's cache CPU if it is not included. */
> +	if (cache_cpu != -1 && !cpumask_test_cpu(cache_cpu, cpus))
> +		cpumask_or(cpus, cpus,
> +			   cpumask_of_node(cpu_to_node(cache_cpu)));
> +
> +	/*
> +	 * Lastly make sure that the task's current running node is
> +	 * considered.
> +	 */
> +	if (!cpumask_test_cpu(curr_cpu, cpus))
> +		cpumask_or(cpus, cpus, cpumask_of_node(cpu_to_node(curr_cpu)));
> +}
> +
> +static void __no_profile task_cache_work(struct callback_head *work)
> +{
> +	struct task_struct *p = current;
> +	struct mm_struct *mm = p->mm;
> +	unsigned long m_a_occ = 0;
> +	unsigned long curr_m_a_occ = 0;
> +	int cpu, m_a_cpu = -1, cache_cpu,
> +	    pref_nid = NUMA_NO_NODE, curr_cpu;
> +	cpumask_var_t cpus;
> +
> +	WARN_ON_ONCE(work != &p->cache_work);
> +
> +	work->next = work;
> +
> +	if (p->flags & PF_EXITING)
> +		return;
> +
> +	if (!zalloc_cpumask_var(&cpus, GFP_KERNEL))
> +		return;
> +
> +	curr_cpu = task_cpu(p);
> +	cache_cpu = mm->mm_sched_cpu;
> +#ifdef CONFIG_NUMA_BALANCING
> +	if (static_branch_likely(&sched_numa_balancing))
> +		pref_nid = p->numa_preferred_nid;
> +#endif
> +
> +	scoped_guard (cpus_read_lock) {
> +		get_scan_cpumasks(cpus, cache_cpu,
> +				  pref_nid, curr_cpu);
> +

IIUC, `get_scan_cpumasks` ORs together the preferred NUMA node, cache CPU's node,
and current CPU's node. This could result in scanning multiple nodes, not preferring
the NUMA preferred node.

> +		for_each_cpu(cpu, cpus) {
> +			/* XXX sched_cluster_active */
> +			struct sched_domain *sd = per_cpu(sd_llc, cpu);
> +			unsigned long occ, m_occ = 0, a_occ = 0;
> +			int m_cpu = -1, i;
> +
> +			if (!sd)
> +				continue;
> +
> +			for_each_cpu(i, sched_domain_span(sd)) {
> +				occ = fraction_mm_sched(cpu_rq(i),
> +							per_cpu_ptr(mm->pcpu_sched, i));
> +				a_occ += occ;
> +				if (occ > m_occ) {
> +					m_occ = occ;
> +					m_cpu = i;
> +				}
> +			}
> +
> +			/*
> +			 * Compare the accumulated occupancy of each LLC. The
> +			 * reason for using accumulated occupancy rather than average
> +			 * per CPU occupancy is that it works better in asymmetric LLC
> +			 * scenarios.
> +			 * For example, if there are 2 threads in a 4CPU LLC and 3
> +			 * threads in an 8CPU LLC, it might be better to choose the one
> +			 * with 3 threads. However, this would not be the case if the
> +			 * occupancy is divided by the number of CPUs in an LLC (i.e.,
> +			 * if average per CPU occupancy is used).
> +			 * Besides, NUMA balancing fault statistics behave similarly:
> +			 * the total number of faults per node is compared rather than
> +			 * the average number of faults per CPU. This strategy is also
> +			 * followed here.
> +			 */
> +			if (a_occ > m_a_occ) {
> +				m_a_occ = a_occ;
> +				m_a_cpu = m_cpu;
> +			}
> +
> +			if (llc_id(cpu) == llc_id(mm->mm_sched_cpu))
> +				curr_m_a_occ = a_occ;
> +
> +			cpumask_andnot(cpus, cpus, sched_domain_span(sd));
> +		}

This means NUMA preference has no effect on the selection, except in the
unlikely case of exactly equal occupancy across LLCs on different nodes
(where iteration order determines the winner).

How does it handle when cache locality and memory locality conflict?
Shouldn't numa preferred node get preference? Also scanning multiple
nodes add overhead, so can restricting it to numa preferred node be
better and scan others only when there is no numa preferred node?

Let me know if I am missing anything.

Thanks,
Madadi Vineeth Reddy


> +	}
> +
> +	if (m_a_occ > (2 * curr_m_a_occ)) {
> +		/*
> +		 * Avoid switching mm_sched_cpu too fast.
> +		 * The reason to choose 2X is because:
> +		 * 1. It is better to keep the preferred LLC stable,
> +		 *    rather than changing it frequently and cause migrations
> +		 * 2. 2X means the new preferred LLC has at least 1 more
> +		 *    busy CPU than the old one(200% vs 100%, eg)
> +		 * 3. 2X is chosen based on test results, as it delivers
> +		 *    the optimal performance gain so far.
> +		 */
> +		mm->mm_sched_cpu = m_a_cpu;
> +	}
> +
> +	free_cpumask_var(cpus);
> +}
> +
> +void init_sched_mm(struct task_struct *p)
> +{
> +	struct callback_head *work = &p->cache_work;
> +
> +	init_task_work(work, task_cache_work);
> +	work->next = work;
> +}
> +
> +#else
> +
> +static inline void account_mm_sched(struct rq *rq, struct task_struct *p,
> +				    s64 delta_exec) { }
> +
> +void init_sched_mm(struct task_struct *p) { }
> +
> +static void task_tick_cache(struct rq *rq, struct task_struct *p) { }
> +
> +#endif
> +
>  /*
>   * Used by other classes to account runtime.
>   */
> @@ -13031,6 +13317,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>  	if (static_branch_unlikely(&sched_numa_balancing))
>  		task_tick_numa(rq, curr);
>  
> +	task_tick_cache(rq, curr);
> +
>  	update_misfit_status(curr, rq);
>  	check_update_overutilized_status(task_rq(curr));
>  
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 3c12d9f93331..d2af7bfd36bf 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -87,6 +87,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
>   */
>  SCHED_FEAT(SIS_UTIL, true)
>  
> +SCHED_FEAT(SCHED_CACHE, true)
>  /*
>   * Issue a WARN when we do multiple update_rq_clock() calls
>   * in a single rq->lock section. Default disabled because the
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index be9745d104f7..2ded8d3d0ecc 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1166,6 +1166,12 @@ struct rq {
>  	u64			clock_pelt_idle_copy;
>  	u64			clock_idle_copy;
>  #endif
> +#ifdef CONFIG_SCHED_CACHE
> +	raw_spinlock_t		cpu_epoch_lock ____cacheline_aligned;
> +	u64			cpu_runtime;
> +	unsigned long		cpu_epoch;
> +	unsigned long		cpu_epoch_next;
> +#endif
>  
>  	atomic_t		nr_iowait;
>  
> @@ -3790,6 +3796,8 @@ static inline void task_tick_mm_cid(struct rq *rq, struct task_struct *curr) { }
>  static inline void init_sched_mm_cid(struct task_struct *t) { }
>  #endif /* !CONFIG_SCHED_MM_CID */
>  
> +extern void init_sched_mm(struct task_struct *p);
> +
>  extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
>  extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
>  static inline



Return-Path: <linux-kernel+bounces-855170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 845F7BE073E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0A3E50693B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2AD3064B3;
	Wed, 15 Oct 2025 19:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KR+ZiXLW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1253E2FE05A
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556764; cv=none; b=f11I4d9aYUu1v5qm27oHG3H59LczatyZNIKinxLd0McBMxJZPTt8fZlMQY5hWDTmQXzytV1T38VV2T+RYkrvqICAWavYCxsUaoAmnPiqbA3rFF9QnXMJ2biySaDkcA4gmbzNXJxN8Pm0mhHeZ6CVDmecXhLQ5orf6egY9KQZaRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556764; c=relaxed/simple;
	bh=RAbhx1G9hMj+mMqkJUbkwMwgxrjAPXv8V69RTxNlIm8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gy+cNRJPjotkyncgjdTR3hJ6u+DPLF7S1Hbt8Z0C+MjvuiqVUIm3jxefVmZbMpyRAO7GnupQY3HZnqtJb3cEHBeb2iNLbbSn97xODUFD5hDGtXyGKm+Q+802W4UOusyHCvQcOy3q+Ie4VLGKiwMAd/eiBPEGeoXYujqTz57W1Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KR+ZiXLW; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760556762; x=1792092762;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RAbhx1G9hMj+mMqkJUbkwMwgxrjAPXv8V69RTxNlIm8=;
  b=KR+ZiXLWjKWfOUwHW2KcchzJyBgOOOri7cuC3dsxQETTozecD8+JBMcd
   rdQGb2JCiwJ95uWFMvgYXdx9EwIWzBOJ7YUWixcrNtXtvJYEZbjxYz+gA
   H5+HJ8tee9n4NuPYjVTUpvhI2HWbmjYv8xPsndyR8a4/cwhkqcIgByJ26
   kXcuMTTZU4Z7LK5xFDCxvIwmd8KVF3ta0/ugnVQ1OPsh0c2ykdJnmy8RS
   Gtf6KlLjEsUzZE+5EVSOskXTtuJO4fLtONCqEGUl6yiR7yBoiij+S1UEa
   Iy6ns7ShddallnJYMZ+bHI0qG4N8PJW6ujVXMkO9a1U4Pf4EpCUbvlQIv
   g==;
X-CSE-ConnectionGUID: q1mazoQkRSOFPI9TTSizJQ==
X-CSE-MsgGUID: x6IuEZGCQXaheK3QsO0jhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="50309712"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="50309712"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:32:41 -0700
X-CSE-ConnectionGUID: FF91wQCfQveGmc68kXXveA==
X-CSE-MsgGUID: AIN+gglHROS7oa8UpTvDlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="182665512"
Received: from unknown (HELO [10.241.242.248]) ([10.241.242.248])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:32:40 -0700
Message-ID: <da4d350862807bcf18626009b6fae248475acb1e.camel@linux.intel.com>
Subject: Re: [PATCH 01/19] sched/fair: Add infrastructure for cache-aware
 load balancing
From: Tim Chen <tim.c.chen@linux.intel.com>
To: "Chen, Yu C" <yu.c.chen@intel.com>, Madadi Vineeth Reddy
	 <vineethr@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, K
 Prateek Nayak <kprateek.nayak@amd.com>, "Gautham R . Shenoy"
 <gautham.shenoy@amd.com>, Vincent Guittot	 <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall	 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider	 <vschneid@redhat.com>, Hillf Danton <hdanton@sina.com>,
 Shrikanth Hegde	 <sshegde@linux.ibm.com>, Jianyong Wu
 <jianyong.wu@outlook.com>, Yangyu Chen	 <cyy@cyyself.name>, Tingyin Duan
 <tingyin.duan@gmail.com>, Vern Hao	 <vernhao@tencent.com>, Len Brown
 <len.brown@intel.com>, Aubrey Li	 <aubrey.li@intel.com>, Zhao Liu
 <zhao1.liu@intel.com>, Chen Yu	 <yu.chen.surf@gmail.com>, Adam Li
 <adamli@os.amperecomputing.com>, Tim Chen	 <tim.c.chen@intel.com>,
 linux-kernel@vger.kernel.org, haoxing990@gmail.com
Date: Wed, 15 Oct 2025 12:32:40 -0700
In-Reply-To: <5f140e59-23f9-46dd-bf5e-7bef0d897cd0@intel.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
	 <865b852e3fdef6561c9e0a5be9a94aec8a68cdea.1760206683.git.tim.c.chen@linux.intel.com>
	 <22750d4a-fdd6-48ad-a2ca-aa0c12af329c@linux.ibm.com>
	 <5f140e59-23f9-46dd-bf5e-7bef0d897cd0@intel.com>
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual;
 keydata=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
 uQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-15 at 12:54 +0800, Chen, Yu C wrote:
> On 10/15/2025 3:12 AM, Madadi Vineeth Reddy wrote:
> > On 11/10/25 23:54, Tim Chen wrote:
> > > From: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > >=20
> > > Cache-aware load balancing aims to aggregate tasks with potential
> > > shared resources into the same cache domain. This approach enhances
> > > cache locality, thereby optimizing system performance by reducing
> > > cache misses and improving data access efficiency.
> > >=20
>=20
> [snip]
>=20
> > > +static void __no_profile task_cache_work(struct callback_head *work)
> > > +{
> > > +	struct task_struct *p =3D current;
> > > +	struct mm_struct *mm =3D p->mm;
> > > +	unsigned long m_a_occ =3D 0;
> > > +	unsigned long curr_m_a_occ =3D 0;
> > > +	int cpu, m_a_cpu =3D -1, cache_cpu,
> > > +	    pref_nid =3D NUMA_NO_NODE, curr_cpu;
> > > +	cpumask_var_t cpus;
> > > +
> > > +	WARN_ON_ONCE(work !=3D &p->cache_work);
> > > +
> > > +	work->next =3D work;
> > > +
> > > +	if (p->flags & PF_EXITING)
> > > +		return;
> > > +
> > > +	if (!zalloc_cpumask_var(&cpus, GFP_KERNEL))
> > > +		return;
> > > +
> > > +	curr_cpu =3D task_cpu(p);
> > > +	cache_cpu =3D mm->mm_sched_cpu;
> > > +#ifdef CONFIG_NUMA_BALANCING
> > > +	if (static_branch_likely(&sched_numa_balancing))
> > > +		pref_nid =3D p->numa_preferred_nid;
> > > +#endif
> > > +
> > > +	scoped_guard (cpus_read_lock) {
> > > +		get_scan_cpumasks(cpus, cache_cpu,
> > > +				  pref_nid, curr_cpu);
> > > +
> >=20
> > IIUC, `get_scan_cpumasks` ORs together the preferred NUMA node, cache C=
PU's node,
> > and current CPU's node. This could result in scanning multiple nodes, n=
ot preferring
> > the NUMA preferred node.
> >=20
>=20
> Yes, it is possible, please see comments below.
>=20
> > > +		for_each_cpu(cpu, cpus) {
> > > +			/* XXX sched_cluster_active */
> > > +			struct sched_domain *sd =3D per_cpu(sd_llc, cpu);
> > > +			unsigned long occ, m_occ =3D 0, a_occ =3D 0;
> > > +			int m_cpu =3D -1, i;
> > > +
> > > +			if (!sd)
> > > +				continue;
> > > +
> > > +			for_each_cpu(i, sched_domain_span(sd)) {
> > > +				occ =3D fraction_mm_sched(cpu_rq(i),
> > > +							per_cpu_ptr(mm->pcpu_sched, i));
> > > +				a_occ +=3D occ;
> > > +				if (occ > m_occ) {
> > > +					m_occ =3D occ;
> > > +					m_cpu =3D i;
> > > +				}
> > > +			}
> > > +
> > > +			/*
> > > +			 * Compare the accumulated occupancy of each LLC. The
> > > +			 * reason for using accumulated occupancy rather than average
> > > +			 * per CPU occupancy is that it works better in asymmetric LLC
> > > +			 * scenarios.
> > > +			 * For example, if there are 2 threads in a 4CPU LLC and 3
> > > +			 * threads in an 8CPU LLC, it might be better to choose the one
> > > +			 * with 3 threads. However, this would not be the case if the
> > > +			 * occupancy is divided by the number of CPUs in an LLC (i.e.,
> > > +			 * if average per CPU occupancy is used).
> > > +			 * Besides, NUMA balancing fault statistics behave similarly:
> > > +			 * the total number of faults per node is compared rather than
> > > +			 * the average number of faults per CPU. This strategy is also
> > > +			 * followed here.
> > > +			 */
> > > +			if (a_occ > m_a_occ) {
> > > +				m_a_occ =3D a_occ;
> > > +				m_a_cpu =3D m_cpu;
> > > +			}
> > > +
> > > +			if (llc_id(cpu) =3D=3D llc_id(mm->mm_sched_cpu))
> > > +				curr_m_a_occ =3D a_occ;
> > > +
> > > +			cpumask_andnot(cpus, cpus, sched_domain_span(sd));
> > > +		}
> >=20
> > This means NUMA preference has no effect on the selection, except in th=
e
> > unlikely case of exactly equal occupancy across LLCs on different nodes
> > (where iteration order determines the winner).
> >=20
> > How does it handle when cache locality and memory locality conflict?
> > Shouldn't numa preferred node get preference? Also scanning multiple
> > nodes add overhead, so can restricting it to numa preferred node be
> > better and scan others only when there is no numa preferred node?
> >=20
>=20
> Basically, yes, you're right. Ideally, we should prioritize the NUMA
> preferred node as the top priority. There's one case I find hard to
> handle: the NUMA preferred node is per task rather than per process.
> It's possible that different threads of the same process have different
> preferred nodes; as a result, the process-wide preferred LLC could bounce
> between different nodes, which might cause costly task migrations across
> nodes. As a workaround, we tried to keep the scan CPU mask covering the
> process's current preferred LLC to ensure the old preferred LLC is includ=
ed
> in the candidates. After all, we have a 2X threshold for switching the
> preferred LLC.

If tasks in a process had different preferred nodes, they would
belong to different numa_groups, and majority of their data would
be from different NUMA nodes.

To resolve such conflict, we'll need to change the aggregation of tasks by
process, to aggregation of tasks by numa_group when NUMA balancing is
enabled.  This probably makes more sense as tasks in a numa_group
have more shared data and would benefit from co-locating in the
same cache.

Thanks.

Tim




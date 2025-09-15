Return-Path: <linux-kernel+bounces-817517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF0AB5832A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ECB43AA541
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71852E0905;
	Mon, 15 Sep 2025 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ge7e0fof"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9512D2DC328
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956423; cv=none; b=cVMBSj5VMd92meCo9Oj/jqTpZ2Kst2wrrH4oFjHtQ0+Ge8tYI2i9bxqhuJn9po0Y9ITQPIXC03jXPleiRxetyCIjZHym3081FEStS2INUExbiVVtfcSXNhXCkPrlNXGRsIRIBwWTJuyv/I3MfbBLl/lph36znPwozFBJvwaHJUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956423; c=relaxed/simple;
	bh=DDuy9HZLdQvsSEu4nFddk7xQL77xFielK2OHX4lUaQk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IGbVB4b+tRXBvjbVwq6DCQ2rfdj3CbysH0Bczg1z0tfaFgrurvp+V//1s+7yvmRk8Gcx2k/GW6tw/mhwfQJZjafztYjhu4PnFQulQ140J1TsqGzV0i822VkicBO8zcqtrl4WIjiV3F2tpDt8Gwdt7146fXrzxD9mGPWyco6fB3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ge7e0fof; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757956421; x=1789492421;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=DDuy9HZLdQvsSEu4nFddk7xQL77xFielK2OHX4lUaQk=;
  b=ge7e0fof+WoO2PfP0XczBXYQCIj4VQx+5yIkSY+cT2+2ykS3OU51taEE
   gndEduDpLVmPO6Y2rVD61I8LgtS9ULSXavc6j8b04ks7jBjk5aP3yKekw
   CM4Ak/M3TZ0SJVAKfTMRdXo9WoIgOjSNoYI27rfyljAGPgapY0GBF4Eyi
   JgrojUKrCZDGK3jl2UV1JXCpJKvTtdmdNn4XyvuLuTd6n5BFT7ioBJZBn
   t2Zr6vwdkpoo/8Mj3WVXpJ2sBZT2bh3Es+I3nSn68JyHk6FOvjcnhVN22
   Uy6jwHq/hfyFHMp1uK6wo7scAmjJ3EUEwpNQRShbL6vvTfuXG48Lh5riy
   A==;
X-CSE-ConnectionGUID: zdaV8pWISFWmMTfFah4MVA==
X-CSE-MsgGUID: P634hyGBTYaQylZk4M7krQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="60086368"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="60086368"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 10:13:41 -0700
X-CSE-ConnectionGUID: u4iQVm5sSdKKapvMWHBifw==
X-CSE-MsgGUID: a7DKS2G/S5uYGuz4sstAXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="174520537"
Received: from schen9-mobl4.jf.intel.com (HELO [10.54.74.4]) ([10.54.74.4])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 10:13:41 -0700
Message-ID: <01702016805ce31c5e109c9d01a428f4f2e9eaf6.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/2] sched: Create architecture specific sched domain
 distances
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,  Valentin Schneider	
 <vschneid@redhat.com>, Tim Chen <tim.c.chen@intel.com>, Vincent Guittot	
 <vincent.guittot@linaro.org>, Libo Chen <libo.chen@oracle.com>, Abel Wu	
 <wuyun.abel@bytedance.com>, Len Brown <len.brown@intel.com>, 
	linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>, K Prateek
 Nayak	 <kprateek.nayak@amd.com>, "Gautham R . Shenoy"
 <gautham.shenoy@amd.com>,  Zhao Liu <zhao1.liu@intel.com>, Vinicius Costa
 Gomes <vinicius.gomes@intel.com>, Arjan Van De Ven	
 <arjan.van.de.ven@intel.com>
Date: Mon, 15 Sep 2025 10:13:40 -0700
In-Reply-To: <20250915123738.GD3245006@noisy.programming.kicks-ass.net>
References: <cover.1757614784.git.tim.c.chen@linux.intel.com>
	 <1aa0ae94e95c45c8f3353f12e6494907df339632.1757614784.git.tim.c.chen@linux.intel.com>
	 <20250915123738.GD3245006@noisy.programming.kicks-ass.net>
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

On Mon, 2025-09-15 at 14:37 +0200, Peter Zijlstra wrote:
> On Thu, Sep 11, 2025 at 11:30:56AM -0700, Tim Chen wrote:
> > Allow architecture specific sched domain NUMA distances that can be
> > modified from NUMA node distances for the purpose of building NUMA
> > sched domains.
> >=20
> > The actual NUMA distances are kept separately.  This allows for NUMA
> > domain levels modification when building sched domains for specific
> > architectures.
> >=20
> > Consolidate the recording of unique NUMA distances in an array to
> > sched_record_numa_dist() so the function can be reused to record NUMA
> > distances when the NUMA distance metric is changed.
> >=20
> > No functional change if there's no arch specific NUMA distances
> > are being defined.
>=20
> Keeping both metrics side-by-side is confusing -- and not very well
> justified by the above.
>=20
> Is there any appreciable benefit to mixing the two like this?

We can set sched_numa_node_distance to point to the same array as
sched_numa_node_distance if no arch specific NUMA distances
are defined.  It would add some additional wrinkles to
the record logic and deallocation logic to detect
whether we have kept them the same.  I've opted to always
have two metrics to keep the code logic simpler.

Let me know if you prefer otherwise.

 =20
>=20
> >=20
> > Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> > ---
> >  include/linux/sched/topology.h |   2 +
> >  kernel/sched/topology.c        | 114 ++++++++++++++++++++++++++++-----
> >  2 files changed, 99 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/include/linux/sched/topology.h b/include/linux/sched/topol=
ogy.h
> > index 5263746b63e8..4f58e78ca52e 100644
> > --- a/include/linux/sched/topology.h
> > +++ b/include/linux/sched/topology.h
> > @@ -59,6 +59,8 @@ static inline int cpu_numa_flags(void)
> >  #endif
> > =20
> >  extern int arch_asym_cpu_priority(int cpu);
> > +extern int arch_sched_node_distance(int from, int to);
> > +extern int sched_avg_remote_numa_distance;
> > =20
> >  struct sched_domain_attr {
> >  	int relax_domain_level;
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 977e133bb8a4..6c0ff62322cb 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -1591,10 +1591,13 @@ static void claim_allocations(int cpu, struct s=
ched_domain *sd)
> >  enum numa_topology_type sched_numa_topology_type;
> > =20
> >  static int			sched_domains_numa_levels;
> > +static int			sched_numa_node_levels;
> >  static int			sched_domains_curr_level;
> > =20
> >  int				sched_max_numa_distance;
> > +int				sched_avg_remote_numa_distance;
> >  static int			*sched_domains_numa_distance;
> > +static int			*sched_numa_node_distance;
> >  static struct cpumask		***sched_domains_numa_masks;
> >  #endif /* CONFIG_NUMA */
> > =20
> > @@ -1808,10 +1811,10 @@ bool find_numa_distance(int distance)
> >  		return true;
> > =20
> >  	rcu_read_lock();
> > -	distances =3D rcu_dereference(sched_domains_numa_distance);
> > +	distances =3D rcu_dereference(sched_numa_node_distance);
> >  	if (!distances)
> >  		goto unlock;
> > -	for (i =3D 0; i < sched_domains_numa_levels; i++) {
> > +	for (i =3D 0; i < sched_numa_node_levels; i++) {
> >  		if (distances[i] =3D=3D distance) {
> >  			found =3D true;
> >  			break;
>=20
> I'm assuming (because its not actually stated anywhere) that
> sched_numa_$FOO is based on the SLIT table, while sched_domain_$FOO is
> the modified thing.
>=20
> And you're saying it makes a significant difference to
> preferred_group_nid()?
>=20
> > +static int sched_record_numa_dist(int offline_node, int (*n_dist)(int,=
 int),
> > +		int **dist, int *levels)
> > +
>=20
> That's a coding style fail; use cino=3D(0:0.
>=20
> >  {
> > -	struct sched_domain_topology_level *tl;
> >  	unsigned long *distance_map;
> >  	int nr_levels =3D 0;
> >  	int i, j;
> >  	int *distances;
> > -	struct cpumask ***masks;
> > =20
> >  	/*
> >  	 * O(nr_nodes^2) de-duplicating selection sort -- in order to find th=
e
> > @@ -1902,17 +1923,17 @@ void sched_init_numa(int offline_node)
> >  	 */
> >  	distance_map =3D bitmap_alloc(NR_DISTANCE_VALUES, GFP_KERNEL);
> >  	if (!distance_map)
> > -		return;
> > +		return -ENOMEM;
> > =20
> >  	bitmap_zero(distance_map, NR_DISTANCE_VALUES);
> >  	for_each_cpu_node_but(i, offline_node) {
> >  		for_each_cpu_node_but(j, offline_node) {
> > -			int distance =3D node_distance(i, j);
> > +			int distance =3D n_dist(i, j);
> > =20
> >  			if (distance < LOCAL_DISTANCE || distance >=3D NR_DISTANCE_VALUES) =
{
> >  				sched_numa_warn("Invalid distance value range");
> >  				bitmap_free(distance_map);
> > -				return;
> > +				return -EINVAL;
> >  			}
> > =20
> >  			bitmap_set(distance_map, distance, 1);
> > @@ -1927,17 +1948,66 @@ void sched_init_numa(int offline_node)
> >  	distances =3D kcalloc(nr_levels, sizeof(int), GFP_KERNEL);
> >  	if (!distances) {
> >  		bitmap_free(distance_map);
> > -		return;
> > +		return -ENOMEM;
> >  	}
> > -
> >  	for (i =3D 0, j =3D 0; i < nr_levels; i++, j++) {
> >  		j =3D find_next_bit(distance_map, NR_DISTANCE_VALUES, j);
> >  		distances[i] =3D j;
> >  	}
> > -	rcu_assign_pointer(sched_domains_numa_distance, distances);
> > +	*dist =3D distances;
> > +	*levels =3D nr_levels;
> > =20
> >  	bitmap_free(distance_map);
> > =20
> > +	return 0;
> > +}
> > +
> > +static int avg_remote_numa_distance(int offline_node)
> > +{
> > +	int i, j;
> > +	int distance, nr_remote =3D 0, total_distance =3D 0;
> > +
> > +	for_each_cpu_node_but(i, offline_node) {
> > +		for_each_cpu_node_but(j, offline_node) {
> > +			distance =3D node_distance(i, j);
> > +
> > +			if (distance >=3D REMOTE_DISTANCE) {
> > +				nr_remote++;
> > +				total_distance +=3D distance;
> > +			}
> > +		}
> > +	}
> > +	if (nr_remote)
> > +		return total_distance / nr_remote;
> > +	else
> > +		return REMOTE_DISTANCE;
> > +}
> > +
> > +void sched_init_numa(int offline_node)
> > +{
> > +	struct sched_domain_topology_level *tl;
> > +	int nr_levels, nr_node_levels;
> > +	int i, j;
> > +	int *distances, *domain_distances;
> > +	struct cpumask ***masks;
> > +
> > +	if (sched_record_numa_dist(offline_node, numa_node_dist, &distances,
> > +				   &nr_node_levels))
> > +		return;
> > +
> > +	WRITE_ONCE(sched_avg_remote_numa_distance,
> > +		   avg_remote_numa_distance(offline_node));
>=20
> What is the point of all this? sched_avg_remote_numa_distance isn't
> actually used anywhere. I'm thinking it doesn't want to be in this patch
> at the very least.

sched_avg_remote_numa_distance actually could change when we offline/online=
 a
node.  I think arch_sched_node_distance(i, j) needs to be changed to
arch_sched_node_distance(i, j, offline_node) so it knows not to include
offline_node in its avg distance computation.  I will do that then.

Thanks for reviewing the code.

Tim


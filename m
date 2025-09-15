Return-Path: <linux-kernel+bounces-816954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1063B57B41
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B324B7AB3D6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E37B1E49F;
	Mon, 15 Sep 2025 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TxL2EUNb"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EB930B514
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939873; cv=none; b=l7afdB0w8tG1w7MBDNeV5Hr29yyed9DNZhTOWW3QrDKoCqU+CjEYrVZ+Pdqni+SXxhKQTzYRuSu/urQJlIvrHtYO4F7r5cdPsbfvNrM3pJ1wDmkk2HgaXg/N/OXKHexqm/ENHX9cIRWcTY40PuOWrPAhcGb0S8twyIa2KHV8T9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939873; c=relaxed/simple;
	bh=tTEzCWLIimxgpcUenvZITV0OItOSdYUuQEpo1moxINY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2EzrSCloqbV+QaE9nIixXFC1l1Q67uidX91rgKjyl9XfnhAtVRPWn0xY50vCG6XUwsz+0PrU4sLn55l5HgoGalHHZIEAlWoD/m4wygIM3J7fzD+ymrgzwIOF1MtY/pSGG2gzZez/J5CQd9+/EXxl7ByO61zX2Dk/kd71cmAuBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TxL2EUNb; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C9UG+ND0qdwpUJMFuE1ENNV9nSd8/OFwwYlHuOrWUx4=; b=TxL2EUNb13x1RpXRhH14quQ2Z4
	bG6Ht45NBWk4N/V+ooXABJAZPxtv9ncsnNnMkIyE5b2RuN5s1ZHJuXo6iOThBM02aqVWdto1cysoo
	chELotPtbu7S1hUFLuYNLTELdJ3xCSEIINrf1bGFIBGkcwVC8N1zlWfC22Jlk/X9q8FeYxLkLLABS
	2NgL5iyG63e3R8qt2G1QmBrgKyGyFV4O4gw9ALBo9MD7ao9CWBCwbz+vo3019ElG3N4pyz3vAqqTF
	RG3uuGBMOx+6b+1vc0X70+bH0C6hRRCABCyl7WyLJpjiFGSLCCPxlovrn8jTtl+IKDWJ+dFZdacPw
	mXBYPQTg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy8Sh-00000006zah-0ZZZ;
	Mon, 15 Sep 2025 12:37:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2D59F302E34; Mon, 15 Sep 2025 14:37:38 +0200 (CEST)
Date: Mon, 15 Sep 2025 14:37:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tim Chen <tim.c.chen@intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Libo Chen <libo.chen@oracle.com>,
	Abel Wu <wuyun.abel@bytedance.com>, Len Brown <len.brown@intel.com>,
	linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: Re: [PATCH v3 1/2] sched: Create architecture specific sched domain
 distances
Message-ID: <20250915123738.GD3245006@noisy.programming.kicks-ass.net>
References: <cover.1757614784.git.tim.c.chen@linux.intel.com>
 <1aa0ae94e95c45c8f3353f12e6494907df339632.1757614784.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aa0ae94e95c45c8f3353f12e6494907df339632.1757614784.git.tim.c.chen@linux.intel.com>

On Thu, Sep 11, 2025 at 11:30:56AM -0700, Tim Chen wrote:
> Allow architecture specific sched domain NUMA distances that can be
> modified from NUMA node distances for the purpose of building NUMA
> sched domains.
> 
> The actual NUMA distances are kept separately.  This allows for NUMA
> domain levels modification when building sched domains for specific
> architectures.
> 
> Consolidate the recording of unique NUMA distances in an array to
> sched_record_numa_dist() so the function can be reused to record NUMA
> distances when the NUMA distance metric is changed.
> 
> No functional change if there's no arch specific NUMA distances
> are being defined.

Keeping both metrics side-by-side is confusing -- and not very well
justified by the above.

Is there any appreciable benefit to mixing the two like this?

> 
> Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  include/linux/sched/topology.h |   2 +
>  kernel/sched/topology.c        | 114 ++++++++++++++++++++++++++++-----
>  2 files changed, 99 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 5263746b63e8..4f58e78ca52e 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -59,6 +59,8 @@ static inline int cpu_numa_flags(void)
>  #endif
>  
>  extern int arch_asym_cpu_priority(int cpu);
> +extern int arch_sched_node_distance(int from, int to);
> +extern int sched_avg_remote_numa_distance;
>  
>  struct sched_domain_attr {
>  	int relax_domain_level;
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 977e133bb8a4..6c0ff62322cb 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1591,10 +1591,13 @@ static void claim_allocations(int cpu, struct sched_domain *sd)
>  enum numa_topology_type sched_numa_topology_type;
>  
>  static int			sched_domains_numa_levels;
> +static int			sched_numa_node_levels;
>  static int			sched_domains_curr_level;
>  
>  int				sched_max_numa_distance;
> +int				sched_avg_remote_numa_distance;
>  static int			*sched_domains_numa_distance;
> +static int			*sched_numa_node_distance;
>  static struct cpumask		***sched_domains_numa_masks;
>  #endif /* CONFIG_NUMA */
>  
> @@ -1808,10 +1811,10 @@ bool find_numa_distance(int distance)
>  		return true;
>  
>  	rcu_read_lock();
> -	distances = rcu_dereference(sched_domains_numa_distance);
> +	distances = rcu_dereference(sched_numa_node_distance);
>  	if (!distances)
>  		goto unlock;
> -	for (i = 0; i < sched_domains_numa_levels; i++) {
> +	for (i = 0; i < sched_numa_node_levels; i++) {
>  		if (distances[i] == distance) {
>  			found = true;
>  			break;

I'm assuming (because its not actually stated anywhere) that
sched_numa_$FOO is based on the SLIT table, while sched_domain_$FOO is
the modified thing.

And you're saying it makes a significant difference to
preferred_group_nid()?

> +static int sched_record_numa_dist(int offline_node, int (*n_dist)(int, int),
> +		int **dist, int *levels)
> +

That's a coding style fail; use cino=(0:0.

>  {
> -	struct sched_domain_topology_level *tl;
>  	unsigned long *distance_map;
>  	int nr_levels = 0;
>  	int i, j;
>  	int *distances;
> -	struct cpumask ***masks;
>  
>  	/*
>  	 * O(nr_nodes^2) de-duplicating selection sort -- in order to find the
> @@ -1902,17 +1923,17 @@ void sched_init_numa(int offline_node)
>  	 */
>  	distance_map = bitmap_alloc(NR_DISTANCE_VALUES, GFP_KERNEL);
>  	if (!distance_map)
> -		return;
> +		return -ENOMEM;
>  
>  	bitmap_zero(distance_map, NR_DISTANCE_VALUES);
>  	for_each_cpu_node_but(i, offline_node) {
>  		for_each_cpu_node_but(j, offline_node) {
> -			int distance = node_distance(i, j);
> +			int distance = n_dist(i, j);
>  
>  			if (distance < LOCAL_DISTANCE || distance >= NR_DISTANCE_VALUES) {
>  				sched_numa_warn("Invalid distance value range");
>  				bitmap_free(distance_map);
> -				return;
> +				return -EINVAL;
>  			}
>  
>  			bitmap_set(distance_map, distance, 1);
> @@ -1927,17 +1948,66 @@ void sched_init_numa(int offline_node)
>  	distances = kcalloc(nr_levels, sizeof(int), GFP_KERNEL);
>  	if (!distances) {
>  		bitmap_free(distance_map);
> -		return;
> +		return -ENOMEM;
>  	}
> -
>  	for (i = 0, j = 0; i < nr_levels; i++, j++) {
>  		j = find_next_bit(distance_map, NR_DISTANCE_VALUES, j);
>  		distances[i] = j;
>  	}
> -	rcu_assign_pointer(sched_domains_numa_distance, distances);
> +	*dist = distances;
> +	*levels = nr_levels;
>  
>  	bitmap_free(distance_map);
>  
> +	return 0;
> +}
> +
> +static int avg_remote_numa_distance(int offline_node)
> +{
> +	int i, j;
> +	int distance, nr_remote = 0, total_distance = 0;
> +
> +	for_each_cpu_node_but(i, offline_node) {
> +		for_each_cpu_node_but(j, offline_node) {
> +			distance = node_distance(i, j);
> +
> +			if (distance >= REMOTE_DISTANCE) {
> +				nr_remote++;
> +				total_distance += distance;
> +			}
> +		}
> +	}
> +	if (nr_remote)
> +		return total_distance / nr_remote;
> +	else
> +		return REMOTE_DISTANCE;
> +}
> +
> +void sched_init_numa(int offline_node)
> +{
> +	struct sched_domain_topology_level *tl;
> +	int nr_levels, nr_node_levels;
> +	int i, j;
> +	int *distances, *domain_distances;
> +	struct cpumask ***masks;
> +
> +	if (sched_record_numa_dist(offline_node, numa_node_dist, &distances,
> +				   &nr_node_levels))
> +		return;
> +
> +	WRITE_ONCE(sched_avg_remote_numa_distance,
> +		   avg_remote_numa_distance(offline_node));

What is the point of all this? sched_avg_remote_numa_distance isn't
actually used anywhere. I'm thinking it doesn't want to be in this patch
at the very least.


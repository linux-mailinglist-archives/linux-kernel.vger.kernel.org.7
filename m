Return-Path: <linux-kernel+bounces-785485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DBAB34B70
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA30D241A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18AB284684;
	Mon, 25 Aug 2025 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JWW8/Hlw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622C0233D85
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152339; cv=none; b=F21/WYRJoL3C4jsdDV8PVGoQ8XTpMiPHTXqlvv3ek8SDMvP/maRnUslwT9j12QEMNO5I+ICfc7hRDQHs1RLyXeIrOCZC9wP7plJIGW4JmBZFtEFzFN5WdX1ly3zFdMeKOdaA0l27TOA3LgEmpQVWFV7OiboeU0JnjRzbH1g64QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152339; c=relaxed/simple;
	bh=e63rtq3Vak350Pe7hUI9WWzvrdPb0VBZ/lCTZxcvibY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=acRWW2hRHMXQHTbBvVctwriikMumS1l4c7Frosk5DWuVcdjCjJoAuzRbMZxDxFaxy/KeKldC0szuTtaKqTNLXT3+BMJSjOLr3OE9k6S5H/fN2X5AcF5jY85F2Fy9D7S+RY71ku8rSiuk3wFKu3SEg4VLrNrAMvT6R0i1KTbWCvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JWW8/Hlw; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756152338; x=1787688338;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=e63rtq3Vak350Pe7hUI9WWzvrdPb0VBZ/lCTZxcvibY=;
  b=JWW8/Hlw401L3ogAx1otcr9JBomViUK89wDNwAvkegC8GgfQiw/+is7G
   9RQix41azLAA9rPC/XR89gn78o4fNS0kl//IjXET2CrgnquQNRREqner7
   cvJ972Kut4mn7vNTod087XICL4wE3WSLfMCtpG0A8XQmBil+6MEFJHd+t
   dlQp+wm4N2HsRcklXPAudiGnMU49fq5C2yqw5Ybxu0cK6M+nJDXM67VC+
   y+ltqGG7oct9/Q5JEvcLIvBYARjyas5QHwWKO0wMj2Qk+M4vktO9J3O6D
   JCEfVM9BbqdVGRBMU9CqE+PDGbZ42DnJMilXpEQae5FFRc8a9CPI2W32A
   A==;
X-CSE-ConnectionGUID: KCFMidfzRVmReX7aloC23w==
X-CSE-MsgGUID: 1XupH4USR3Gxuo9LL6gUwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="69749409"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69749409"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 13:05:36 -0700
X-CSE-ConnectionGUID: +qKbfTVJRSymNOrFJvznVA==
X-CSE-MsgGUID: iJzKVmYUQ+G92lXYGrWbgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="206545523"
Received: from schen9-mobl2.jf.intel.com (HELO [10.98.24.137]) ([10.98.24.137])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 13:05:36 -0700
Message-ID: <4d9f64ea691b8a2f7571671156d511407aeee1c8.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] sched: Fix sched domain build error for GNR-X,
 CWF-X in SNC-3 mode
From: Tim Chen <tim.c.chen@linux.intel.com>
To: "Chen, Yu C" <yu.c.chen@intel.com>, Peter Zijlstra
 <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Tim Chen
 <tim.c.chen@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Libo
 Chen <libo.chen@oracle.com>, Abel Wu <wuyun.abel@bytedance.com>, Len Brown
 <len.brown@intel.com>, linux-kernel@vger.kernel.org, K Prateek Nayak
 <kprateek.nayak@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, Chen Yu <yu.chen.surf@foxmail.com>
Date: Mon, 25 Aug 2025 13:05:35 -0700
In-Reply-To: <c03c0137-931f-4dc9-b2c6-d01d4eb60010@intel.com>
References: <cover.1755893468.git.tim.c.chen@linux.intel.com>
	 <86ddfe75510497829a84e696b29bfdd7a4940009.1755893468.git.tim.c.chen@linux.intel.com>
	 <c03c0137-931f-4dc9-b2c6-d01d4eb60010@intel.com>
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-25 at 13:08 +0800, Chen, Yu C wrote:
> On 8/23/2025 4:14 AM, Tim Chen wrote:
> >=20
... snip...
> >=20
> > Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> > Tested-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >   arch/x86/kernel/smpboot.c      | 28 ++++++++++++++++++++++++++++
> >   include/linux/sched/topology.h |  1 +
> >   kernel/sched/topology.c        | 25 +++++++++++++++++++------
> >   3 files changed, 48 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> > index 33e166f6ab12..c425e84c88b5 100644
> > --- a/arch/x86/kernel/smpboot.c
> > +++ b/arch/x86/kernel/smpboot.c
> > @@ -515,6 +515,34 @@ static void __init build_sched_topology(void)
> >   	set_sched_topology(topology);
> >   }
> >  =20
> > +int sched_node_distance(int from, int to)
> > +{
> > +	int d =3D node_distance(from, to);
> > +
> > +	if (!x86_has_numa_in_package)
> > +		return d;
> > +
> > +	switch (boot_cpu_data.x86_vfm) {
> > +	case INTEL_GRANITERAPIDS_X:
> > +	case INTEL_ATOM_DARKMONT_X:
> > +		if (d < REMOTE_DISTANCE)
> > +			return d;
> > +
> > +		/*
> > +		 * Trim finer distance tuning for nodes in remote package
> > +		 * for the purpose of building sched domains.
> > +		 * Put NUMA nodes in each remote package in a single sched group.
> > +		 * Simplify NUMA domains and avoid extra NUMA levels including diffe=
rent
> > +		 * NUMA nodes in remote packages.
> > +		 *
> > +		 * GNR-x and CWF-X has GLUELESS-MESH topology with SNC
> > +		 * turned on.
> > +		 */
> > +		d =3D (d / 10) * 10;
>=20
> Does the '10' here mean that, the distance of the hierarchy socket
> is 10 from SLIT table?=C2=A0
>=20

Yes.

> For example, from a socket0 point of view,
> the distance of socket1 to socket0 is within [20, 29), the distance
> of socket2 to socket0 is [30,39), and so on. If this is the case,
> maybe add a comment above for future reference.
>=20

We don't expect to have more than 2 sockets for GNR and CWF.
So the case of 2 hops like [30,39) should not happen.

> > +	}
> > +	return d;
> > +}
> > +
> >   void set_cpu_sibling_map(int cpu)
> >   {
> >   	bool has_smt =3D __max_threads_per_core > 1;
> > diff --git a/include/linux/sched/topology.h b/include/linux/sched/topol=
ogy.h
> > index 5263746b63e8..3b62226394af 100644
> > --- a/include/linux/sched/topology.h
> > +++ b/include/linux/sched/topology.h
> > @@ -59,6 +59,7 @@ static inline int cpu_numa_flags(void)
> >   #endif
> >  =20
> >   extern int arch_asym_cpu_priority(int cpu);
> > +extern int sched_node_distance(int from, int to);
> >  =20
> >   struct sched_domain_attr {
> >   	int relax_domain_level;
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 9a7ac67e3d63..3f485da994a7 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -1804,7 +1804,7 @@ bool find_numa_distance(int distance)
> >   	bool found =3D false;
> >   	int i, *distances;
> >  =20
> > -	if (distance =3D=3D node_distance(0, 0))
> > +	if (distance =3D=3D sched_node_distance(0, 0))
> >   		return true;
> >=20
>=20
> If I understand correct, this patch is trying to fix the sched
> domain issue during load balancing, and NUMA balance logic
> should not be changed because NUMA balancing is not based on
> sched domain?
>=20
> That is to say, since the find_numa_distance() is only used by
> NUMA balance, should we keep find_numa_distance() to still use
> node_distance()?

The procedure here is using the distance matrix that's initialized
using sched_node_distance(). Hence the change.

Otherwise we could keep a separate sched_distance matrix and uses
only node_distance here.  Did not do that to minimize the change.

Tim

>=20
> >   	rcu_read_lock();
> > @@ -1887,6 +1887,15 @@ static void init_numa_topology_type(int offline_=
node)
> >  =20
> >   #define NR_DISTANCE_VALUES (1 << DISTANCE_BITS)
> >  =20
> > +/*
> > + * Architecture could simplify NUMA distance, to avoid
> > + * creating too many NUMA levels when SNC is turned on.
> > + */
> > +int __weak sched_node_distance(int from, int to)
> > +{
> > +	return node_distance(from, to);
> > +}
> > +
> >   void sched_init_numa(int offline_node)
> >   {
> >   	struct sched_domain_topology_level *tl;
> > @@ -1894,6 +1903,7 @@ void sched_init_numa(int offline_node)
> >   	int nr_levels =3D 0;
> >   	int i, j;
> >   	int *distances;
> > +	int max_dist =3D 0;
> >   	struct cpumask ***masks;
> >  =20
> >   	/*
> > @@ -1907,7 +1917,10 @@ void sched_init_numa(int offline_node)
> >   	bitmap_zero(distance_map, NR_DISTANCE_VALUES);
> >   	for_each_cpu_node_but(i, offline_node) {
> >   		for_each_cpu_node_but(j, offline_node) {
> > -			int distance =3D node_distance(i, j);
> > +			int distance =3D sched_node_distance(i, j);
> > +
> > +			if (node_distance(i,j) > max_dist)
> > +				max_dist =3D node_distance(i,j);
> >  =20
> >   			if (distance < LOCAL_DISTANCE || distance >=3D NR_DISTANCE_VALUES)=
 {
> >   				sched_numa_warn("Invalid distance value range");
> > @@ -1979,10 +1992,10 @@ void sched_init_numa(int offline_node)
> >   			masks[i][j] =3D mask;
> >  =20
> >   			for_each_cpu_node_but(k, offline_node) {
> > -				if (sched_debug() && (node_distance(j, k) !=3D node_distance(k, j)=
))
> > +				if (sched_debug() && (sched_node_distance(j, k) !=3D sched_node_di=
stance(k, j)))
> >   					sched_numa_warn("Node-distance not symmetric");
> >  =20
> > -				if (node_distance(j, k) > sched_domains_numa_distance[i])
> > +				if (sched_node_distance(j, k) > sched_domains_numa_distance[i])
> >   					continue;
> >  =20
> >   				cpumask_or(mask, mask, cpumask_of_node(k));
> > @@ -2022,7 +2035,7 @@ void sched_init_numa(int offline_node)
> >   	sched_domain_topology =3D tl;
> >  =20
> >   	sched_domains_numa_levels =3D nr_levels;
> > -	WRITE_ONCE(sched_max_numa_distance, sched_domains_numa_distance[nr_le=
vels - 1]);
> > +	WRITE_ONCE(sched_max_numa_distance, max_dist);
>=20
> Above change is to use the original node_distance() rather than
> sched_node_distance() for sched_max_numa_distance, and
> sched_max_numa_distance is only used by NUMA balance to figure out
> the NUMA topology type as well as scaling the NUMA fault statistics
> for remote Nodes.
>=20
> So I think we might want to keep it align by using node_distance()
> in find_numa_distance().
>=20
> thanks,
> Chenyu
> >  =20
> >   	init_numa_topology_type(offline_node);
> >   }
> > @@ -2092,7 +2105,7 @@ void sched_domains_numa_masks_set(unsigned int cp=
u)
> >   				continue;
> >  =20
> >   			/* Set ourselves in the remote node's masks */
> > -			if (node_distance(j, node) <=3D sched_domains_numa_distance[i])
> > +			if (sched_node_distance(j, node) <=3D sched_domains_numa_distance[i=
])
> >   				cpumask_set_cpu(cpu, sched_domains_numa_masks[i][j]);
> >   		}
> >   	}



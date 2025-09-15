Return-Path: <linux-kernel+bounces-817449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C55B5825D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C85727A7035
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8095D27B50F;
	Mon, 15 Sep 2025 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ckVW2Azm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5A12777F3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954693; cv=none; b=gABaQSJXUhvJ1luMvIIbRLkrXTSFx8PhuV1bWEtLqeGP+iXrGXfPRjt6wtmhS3xOpCj61dx7pTM/t77FVIY7lZ982EVU39ZMHDFdk/ASKGOfJfFSKfdB+fuVySQfTdDLCQLIQ7+gUSGNRgutVnO/pbYmA+U5F8I1ptkTtpd+PgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954693; c=relaxed/simple;
	bh=eUAkt20CMQ8n72tZCadKbRUCOETJVS9TbHdT604CUeQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kpMXWhmv42WSBd4knKBGnu4L9bx4423/n9kpLuX/uruXSEqEBnCdkKZ64otd4uxD327Lf+FegHkFrDdJc7GEGg+gvN1nGpiq+Lryfhvzt/HHCnNIRoJgW2Ghte77Z3rbrjpuHirmeTYofxuk2GGFeThhNHKiAQz1l9rF2iKbhwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ckVW2Azm; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757954692; x=1789490692;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=eUAkt20CMQ8n72tZCadKbRUCOETJVS9TbHdT604CUeQ=;
  b=ckVW2Azm6IYG9gFznHDVbEK1Z8V+TPlaP9IOYcj1PfTW8UziILhIqzav
   kJWqeqkCls4p6I++Uhi4ZgMQEHhHdOfGa8xci6ROpGKIvkLDDCOgGGtNV
   a6S2L8qxi4JlYjhyVw3+6yxYEWLIlkyvEluPIMstmoszLsIW8wbsMogWl
   ZQTtL02Th0SK2f0qmCHWCAsiTlxIx3ZY6E69t6yrLUjR8M32RJpUID5xF
   wSY1jkdyA0Rqn/7c6qyb6eq/5Z+AoLP5oodx2G3g2oOF3ruVnaf0T+QHB
   xNSuIrb5o4HBo3WHU92UcGwLE1vE9EzkjHdHhBwvLznEk2NGGpg5lF6n5
   A==;
X-CSE-ConnectionGUID: gI/pnXrfT+ifzFksbsdzMg==
X-CSE-MsgGUID: uM1MuejoTeO30DE8YafSSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="71643956"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="71643956"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 09:44:51 -0700
X-CSE-ConnectionGUID: 6vJ9h0iKRgqjL35I7O6PUw==
X-CSE-MsgGUID: bjHatK4vQDa9bSvjoSgZBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="174238521"
Received: from unknown (HELO [10.54.74.4]) ([10.54.74.4])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 09:44:51 -0700
Message-ID: <1bccae2c1830daab13cf892ecb1ae7c05edd98f2.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/2] sched: Create architecture specific sched domain
 distances
From: Tim Chen <tim.c.chen@linux.intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra
	 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann	
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman	
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Tim Chen	
 <tim.c.chen@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Libo
 Chen	 <libo.chen@oracle.com>, Abel Wu <wuyun.abel@bytedance.com>, Len Brown
	 <len.brown@intel.com>, linux-kernel@vger.kernel.org, Chen Yu
 <yu.c.chen@intel.com>,  "Gautham R . Shenoy" <gautham.shenoy@amd.com>, Zhao
 Liu <zhao1.liu@intel.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>,
  Arjan Van De Ven <arjan.van.de.ven@intel.com>
Date: Mon, 15 Sep 2025 09:44:50 -0700
In-Reply-To: <e11163c7-9e23-4556-9a3a-962222978686@amd.com>
References: <cover.1757614784.git.tim.c.chen@linux.intel.com>
	 <1aa0ae94e95c45c8f3353f12e6494907df339632.1757614784.git.tim.c.chen@linux.intel.com>
	 <e11163c7-9e23-4556-9a3a-962222978686@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-12 at 08:53 +0530, K Prateek Nayak wrote:
> Hello Tim,
>=20
> On 9/12/2025 12:00 AM, Tim Chen wrote:
> > +static int sched_record_numa_dist(int offline_node, int (*n_dist)(int,=
 int),
> > +		int **dist, int *levels)
> > +
>=20
> nit. Is the blank line above intentional?
>=20
> Also personally I prefer breaking the two lines above as:
>=20
> static int
> sched_record_numa_dist(int offline_node, int (*n_dist)(int, int), int **d=
ist, int *levels)

That would exceed 80 characters.  So we would still need to move some param=
eters to a different
line to keep within the limit.

> {
> 	...
> }
>=20
> >  {
> > -	struct sched_domain_topology_level *tl;
> >  	unsigned long *distance_map;
>=20
> Since we are breaking this out and adding return values, can we also
> cleanup that bitmap_free() before every return with __free(bitmap) like:
>=20
> (Only build tested)

Yes, __kfree will be better here.

>=20
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 6c0ff62322cb..baa79e79ced8 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1910,9 +1910,8 @@ static int numa_node_dist(int i, int j)
> =20
>  static int sched_record_numa_dist(int offline_node, int (*n_dist)(int, i=
nt),
>  		int **dist, int *levels)
> -
>  {
> -	unsigned long *distance_map;
> +	unsigned long *distance_map __free(bitmap) =3D NULL;
>  	int nr_levels =3D 0;
>  	int i, j;
>  	int *distances;
> @@ -1932,7 +1931,6 @@ static int sched_record_numa_dist(int offline_node,=
 int (*n_dist)(int, int),
> =20
>  			if (distance < LOCAL_DISTANCE || distance >=3D NR_DISTANCE_VALUES) {
>  				sched_numa_warn("Invalid distance value range");
> -				bitmap_free(distance_map);
>  				return -EINVAL;
>  			}
> =20
> @@ -1946,19 +1944,17 @@ static int sched_record_numa_dist(int offline_nod=
e, int (*n_dist)(int, int),
>  	nr_levels =3D bitmap_weight(distance_map, NR_DISTANCE_VALUES);
> =20
>  	distances =3D kcalloc(nr_levels, sizeof(int), GFP_KERNEL);
> -	if (!distances) {
> -		bitmap_free(distance_map);
> +	if (!distances)
>  		return -ENOMEM;
> -	}
> +
>  	for (i =3D 0, j =3D 0; i < nr_levels; i++, j++) {
>  		j =3D find_next_bit(distance_map, NR_DISTANCE_VALUES, j);
>  		distances[i] =3D j;
>  	}
> +
>  	*dist =3D distances;
>  	*levels =3D nr_levels;
> =20
> -	bitmap_free(distance_map);
> -
>  	return 0;
>  }
> =20
> ---
>=20
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
> nit.
>=20
> Can add a small comment here saying arch_sched_node_distance() may
> depend on sched_avg_remote_numa_distance and requires it to be
> initialized correctly before computing domain_distances.

Sure.

Thanks for the review.

Tim

>=20
> Apart from those nitpicks, the changes look good to me. Please feel free
> to include:
>=20
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>


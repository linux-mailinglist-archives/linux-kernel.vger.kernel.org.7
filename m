Return-Path: <linux-kernel+bounces-817466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B98ABB5828C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6345A3BDFC7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AED121423C;
	Mon, 15 Sep 2025 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OjC8jrRj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A276C1B0F23
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954982; cv=none; b=pSNJvD1LorE6qV+Dv71vylSGoxh4x3IiKCKN7I3tBQYCwTCEnwXeo7dTi3WwRMZKcap3GKoJaEXr6AMQoaHyFTBuSCXWxDJUACDYxWiM11PMgSzuwlBQSPIfr4+fv4zL5XdAX+EAzpdfMevBamEbLu+gFWs+2YQ7KG1QYRlXi/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954982; c=relaxed/simple;
	bh=15jYDy5tTR6Fclkhhxv3icxIsUyCJvZ5gCySly5JyFw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aZlI3wRm1i9z6NwVQKLonksipw45bZ8TN1sTvaEsbwZLVFO6wbFo+BghVqKv/ROmPmLf1iiaNNGgOYG/1K2F3fCytzsmi1H4ZfcFQ8AJv39554wqkbio1HNA+meWBm9SBQlKQE1zmDMl6MN5wTQgcRlEGZIFVw3XRLkOdCfdGpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OjC8jrRj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757954981; x=1789490981;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=15jYDy5tTR6Fclkhhxv3icxIsUyCJvZ5gCySly5JyFw=;
  b=OjC8jrRjQIe1s2ElrI2pOwoLcJjnRkjIEutbUKf2LAlOm6IqLSeAvkE9
   zE1bwMV1xpm61FuanhgDNBMMSVJqGAAX0Iqu/yC4l3XvhB71jEvX4YMs1
   ujxp6CgggLbE1HSU7+Zf8t26CYEVHSCKd06QNRBmrkaGydAOzN5iGUgRs
   WKcTH9eNQyobvXfGK/USzrC5MVJPA/pBR8wJh9SCuOJxZd2yZzhnvDScV
   8dhaHeP1WqwbnqX2QFifAW9xU7VvMUwe9F6BuNfGPPBCg6utaFNlv0S47
   TaVNkUdW6csWN0w0iidCiCgafGTadRTO5xdVGBcflnIQqwTk2YhiKPIrh
   w==;
X-CSE-ConnectionGUID: CuldZrSpTBqgSXofRkD8NQ==
X-CSE-MsgGUID: Upg/QAU0TJq9rlEFYJfnzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="70901188"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="70901188"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 09:49:40 -0700
X-CSE-ConnectionGUID: D5c0t1zsRQ+HIhg14hRZgQ==
X-CSE-MsgGUID: Q+4Dk3kzQBqPW6/9rG/NUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="174768940"
Received: from unknown (HELO [10.54.74.4]) ([10.54.74.4])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 09:49:40 -0700
Message-ID: <131ea54e7eb41d9d63d7aa4304aadf7719990892.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/2] sched: Create architecture specific sched domain
 distances
From: Tim Chen <tim.c.chen@linux.intel.com>
To: "Chen, Yu C" <yu.c.chen@intel.com>, Peter Zijlstra
 <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann	
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman	
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Tim Chen	
 <tim.c.chen@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Libo
 Chen	 <libo.chen@oracle.com>, Abel Wu <wuyun.abel@bytedance.com>, Len Brown
	 <len.brown@intel.com>, linux-kernel@vger.kernel.org, K Prateek Nayak	
 <kprateek.nayak@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, Arjan Van De Ven	 <arjan.van.de.ven@intel.com>
Date: Mon, 15 Sep 2025 09:49:39 -0700
In-Reply-To: <857e86a9-9007-4942-b005-1574c919ad6b@intel.com>
References: <cover.1757614784.git.tim.c.chen@linux.intel.com>
	 <1aa0ae94e95c45c8f3353f12e6494907df339632.1757614784.git.tim.c.chen@linux.intel.com>
	 <857e86a9-9007-4942-b005-1574c919ad6b@intel.com>
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

On Fri, 2025-09-12 at 13:24 +0800, Chen, Yu C wrote:
> On 9/12/2025 2:30 AM, Tim Chen wrote:
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
> >=20
>=20
> [snip]
>=20
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
> > +
> > +	if (sched_record_numa_dist(offline_node,
> > +				   arch_sched_node_distance, &domain_distances,
> > +				   &nr_levels)) {
> > +		kfree(distances);
> > +		return;
> > +	}
> > +	rcu_assign_pointer(sched_numa_node_distance, distances);
> > +	WRITE_ONCE(sched_max_numa_distance, distances[nr_node_levels - 1]);
>=20
> [snip]
>=20
> > @@ -2022,7 +2097,6 @@ void sched_init_numa(int offline_node)
> >   	sched_domain_topology =3D tl;
> >  =20
> >   	sched_domains_numa_levels =3D nr_levels;
> > -	WRITE_ONCE(sched_max_numa_distance, sched_domains_numa_distance[nr_le=
vels - 1]);
> >  =20
>=20
> Before this patch, sched_max_numa_distance is assigned a valid
> value at the end of sched_init_numa(), after sched_domains_numa_masks
>   and sched_domain_topology_level are successfully created or appended
> , the kzalloc() call should succeed.
>=20
> Now we assign sched_max_numa_distance earlier, without considering
> the status of NUMA sched domains. I think this is intended, because
>   sched domains are only for generic load balancing, while
>   sched_max_numa_distance is for NUMA load balancing; in theory, they
> use different metrics in their strategies. Thus, this change should
> not cause any issues.

Yes, now sched_max_numa_distance is used in conjunction with
sched_numa_node_distance.  So putting them together is okay.

>=20
>  From my understanding,
>=20
> Reviewed-by: Chen Yu <yu.c.chen@intel.com>

Thanks.

Tim

>=20
> thanks,
> Chenyu


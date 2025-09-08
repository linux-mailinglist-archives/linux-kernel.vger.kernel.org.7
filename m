Return-Path: <linux-kernel+bounces-806538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82920B49830
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C953B233F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA45B3148D6;
	Mon,  8 Sep 2025 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQh33uag"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948C731A066
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 18:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355790; cv=none; b=WrWbva9F9YoJ50z1dlvqFYGyeHwBvDTiPi9k0jDRd4+3mMjnQE9y7clAUJyKjPsV33m0J8dgquqbUlUxJ9hWzB3jfp/hMIhbdvjelVAI/j/ryzYwslHbn5atPdP9If/gWUzT3h3BypjttZn7rJTCOMfg94s2ZyvNWmi0Bw+YuVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355790; c=relaxed/simple;
	bh=eGjCIEhGObFrwBzHInIwmy7KWnFV0rmYpE0jazJqel8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gmYUtdYyXYVWrcM2gJPCMOKkYU3C/VPXoXeLQTVCeulzIEz/BTu2m432CiTSHaNMIkSHanQmDm+b3Vzdkobl26h0buAMKczAJrzOzrTo/ASGXSLK2PuxXMitmPkUcEVYjXvyXe/ZHc9vg19HiySDtqKlmXfMHN3KtMClXjXryLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BQh33uag; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757355787; x=1788891787;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=eGjCIEhGObFrwBzHInIwmy7KWnFV0rmYpE0jazJqel8=;
  b=BQh33uagMtr2INBqCEiL7E7FCqbIIqNYXDV8hTdvxSJ/nOjXALeJ8y1L
   /1tKSvs+vorzBLX2PNJwmwye55iUSZuISORejR9VFF7Ewtbmc0oAqqfhe
   Bmil2Uxg36VTQcqsteVMApjT2D9zhDw10lGbzh6nCDFEieL3fN7IhOCFh
   lMr+++nHYzrQQy8joynZzBie2HteIuCt3vzOZq9b6AcJB9Rb8hGxBX2Cn
   DN+7BI5kQDM4GuFJxJj1iaOfH56VnOfwto31bPeY1+QtzWupmShdFZeGa
   Nl2UrW8QHbkniH4PYopfHeKyAGwL61XRR806UcyOkKEqke16/RoMubzir
   A==;
X-CSE-ConnectionGUID: FgeYpT4bQru4DsXmjbZAJw==
X-CSE-MsgGUID: Wr0W+H53T9mgWFf9IuTBqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59690397"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59690397"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 11:23:03 -0700
X-CSE-ConnectionGUID: EmPvFgnVSH+ZFwFGuvPREg==
X-CSE-MsgGUID: rqEO8tY1Q+afst/STGzuLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="172791951"
Received: from schen9-mobl2.jf.intel.com (HELO [10.54.74.7]) ([10.54.74.7])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 11:23:02 -0700
Message-ID: <616f43d534c7c043220d032700ce72e4a7c740aa.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/2] sched: Create architecture specific sched domain
 distances
From: Tim Chen <tim.c.chen@linux.intel.com>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Tim Chen
 <tim.c.chen@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Libo
 Chen <libo.chen@oracle.com>, Abel Wu <wuyun.abel@bytedance.com>, Len Brown
 <len.brown@intel.com>, linux-kernel@vger.kernel.org, K Prateek Nayak
 <kprateek.nayak@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, Arjan Van De Ven <arjan.van.de.ven@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Date: Mon, 08 Sep 2025 11:23:01 -0700
In-Reply-To: <07938684-0010-4510-9350-0f6d9a83461b@intel.com>
References: <cover.1757097030.git.tim.c.chen@linux.intel.com>
	 <61a6adbb845c148361101e16737307c8aa7ee362.1757097030.git.tim.c.chen@linux.intel.com>
	 <07938684-0010-4510-9350-0f6d9a83461b@intel.com>
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

On Mon, 2025-09-08 at 00:28 +0800, Chen, Yu C wrote:
> On 9/6/2025 2:36 AM, Tim Chen wrote:

... snip ...
> > -void sched_init_numa(int offline_node)
> > +/*
> > + * Architecture could simplify NUMA distance, to avoid
> > + * creating too many NUMA levels.
> > + */
> > +int __weak arch_sched_node_distance(int from, int to)
> > +{
> > +	return node_distance(from, to);
> > +}
> > +
> > +static int numa_node_dist(int i, int j)
> > +{
> > +	return node_distance(i, j);
> > +}
> > +
>=20
> numa_node_dist() seems to be used only once by
> sched_record_numa_dist(), would it be possible to
> use node_distance() directly
> sched_record_numa_dist(offline_node, node_distance, &distances,
> 				   &max_dist, &nr_node_levels))?

Otherwise I will need to pass a flag to sched_record_numa_dist to
choose which distance to use.  I am okay either way. Choosing
the current method so it makes sched_record_numa_dist() simpler.


>=20
> > +static int sched_record_numa_dist(int offline_node, int (*n_dist)(int,=
 int),
> > +		int **dist, int *maximum_dist, int *levels)
> > +
> >   {
> > -	struct sched_domain_topology_level *tl;
> >   	unsigned long *distance_map;
> >   	int nr_levels =3D 0;
> >   	int i, j;
> >   	int *distances;
> > -	struct cpumask ***masks;
> > +	int max_dist =3D 0;
> >  =20
> >=20
... snip ...

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
> > +	int max_dist;
> > +	struct cpumask ***masks;
> > +
> > +	if (sched_record_numa_dist(offline_node, numa_node_dist, &distances,
> > +				   &max_dist, &nr_node_levels))
> > +		return;
> > +
> > +	WRITE_ONCE(sched_avg_remote_numa_distance,
> > +		   avg_remote_numa_distance(offline_node));
> > +
> > +	if (sched_record_numa_dist(offline_node,
> > +				   arch_sched_node_distance, &domain_distances,
> > +				   NULL, &nr_levels)) {
> > +		kfree(distances);
> > +		return;
> > +	}
> > +	rcu_assign_pointer(sched_numa_node_distance, distances);
> > +	WRITE_ONCE(sched_numa_node_levels, nr_node_levels);
> > +
> >   	/*
> >   	 * 'nr_levels' contains the number of unique distances
> >   	 *
> > @@ -1954,6 +2028,8 @@ void sched_init_numa(int offline_node)
> >   	 *
> >   	 * We reset it to 'nr_levels' at the end of this function.
> >   	 */
> > +	rcu_assign_pointer(sched_domains_numa_distance, domain_distances);
> > +
> >   	sched_domains_numa_levels =3D 0;
> >  =20
> >   	masks =3D kzalloc(sizeof(void *) * nr_levels, GFP_KERNEL);
> > @@ -1979,10 +2055,13 @@ void sched_init_numa(int offline_node)
> >   			masks[i][j] =3D mask;
> >  =20
> >   			for_each_cpu_node_but(k, offline_node) {
> > -				if (sched_debug() && (node_distance(j, k) !=3D node_distance(k, j)=
))
> > +				if (sched_debug() &&
> > +				    (arch_sched_node_distance(j, k) !=3D
> > +				     arch_sched_node_distance(k, j)))
> >   					sched_numa_warn("Node-distance not symmetric");
> >  =20
> > -				if (node_distance(j, k) > sched_domains_numa_distance[i])
> > +				if (arch_sched_node_distance(j, k) >
> > +					sched_domains_numa_distance[i])
> >   					continue;
> >  =20
> >   				cpumask_or(mask, mask, cpumask_of_node(k));
> > @@ -2022,7 +2101,7 @@ void sched_init_numa(int offline_node)
> >   	sched_domain_topology =3D tl;
> >  =20
> >   	sched_domains_numa_levels =3D nr_levels;
> > -	WRITE_ONCE(sched_max_numa_distance, sched_domains_numa_distance[nr_le=
vels - 1]);
> > +	WRITE_ONCE(sched_max_numa_distance, max_dist);
> >  =20
>=20
> Would it be possible to use
> WRITE_ONCE(sched_max_numa_distance, distance[nr_node_levels - 1]);
> so we can simplify the code by removing the introduced 'max_dist'
> both in sched_record_numa_dist() and sched_init_numa().

Sure, I think that simplifies sched_record_numa_dist().


Tim


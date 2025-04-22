Return-Path: <linux-kernel+bounces-613251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8F3A95A11
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 02:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42973AF60E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 00:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4B81862A;
	Tue, 22 Apr 2025 00:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kDrQwENU"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8260EEA8
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 00:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745280670; cv=none; b=ki0Lb83mrtcytHcMfZu33+X0pWAx50Gf7QA8Xaj3MZ0qdEbKCeXprm+Ie1mXF5x8spknC+uEbJA4U5KkfESabja40QULqQekot3EXOSvAcTxejDs2NU1nZJF2l2Sq2DTaUeGd0oLxWWIOBBB/ECIDtSdHRcvHp+MORxZY+ckyNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745280670; c=relaxed/simple;
	bh=7ZWISoAfWu4pRegnrLitN+ifDJrn2JPwJgKwqIh8TRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8i9DTL8XohxuJyT7R0rA+L2oo4vLmirKLzyE/ojYf/FNVlZRWG4otdTUa6XOru8RYigrUgitZTmsSimH80olS/e3d4wopuoRlSmAymphcbmggewgeYzVddRyZzfWz73LFvx+l855EhL3D1p01Lm66aKT8E80NQ7dgX8shzSjBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kDrQwENU; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 21 Apr 2025 17:10:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745280656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tSVWDHT0xos997v/DoBsyL/obzA1nApmFBxJIGTJC7c=;
	b=kDrQwENUlU5559ZA6brIszgMe9GRoXmpOt47HDH/T2bqO86qqN80Q50Sq7qcCDpA6e0rB6
	8YoUaOJgd2/+MvbcQ/3Uxk+OAUFiD5vRZ7eQD2qq9122HAi8v1nZaahQJDxaZvfsMbVa6+
	ciAmkHe9mVWyGNTq1WcFY5CeKNfAm+8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Gregory Price <gourry@gourry.net>
Cc: Waiman Long <llong@redhat.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, tj@kernel.org, mkoutny@suse.com, akpm@linux-foundation.org
Subject: Re: [PATCH v3 2/2] vmscan,cgroup: apply mems_effective to reclaim
Message-ID: <i42lfs6xwncozzn7ruhpx7kuplqkpbnvniib7s6t52yytfhpaj@fc3a7mgkeilj>
References: <20250419053824.1601470-1-gourry@gourry.net>
 <20250419053824.1601470-3-gourry@gourry.net>
 <ro3uqeyri65voutamqttzipfk7yiya4zv5kdiudcmhacrm6tej@br7ebk2kanf4>
 <babdca88-1461-4d47-989a-c7a011ddc2bd@redhat.com>
 <7dtp6v5evpz5sdevwrexhwcdtl5enczssvuepkib2oiaexk3oo@ranij7pskrhe>
 <aAbNyJoi_H5koD-O@gourry-fedora-PF4VCD3F>
 <ekug3nktxwyppavk6tfrp6uxfk3djhqb36xfkb5cltjriqpq5l@qtuszfrnfvu6>
 <aAbbtNhnuleBZdPK@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAbbtNhnuleBZdPK@gourry-fedora-PF4VCD3F>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 21, 2025 at 07:58:44PM -0400, Gregory Price wrote:
> On Mon, Apr 21, 2025 at 04:15:49PM -0700, Shakeel Butt wrote:
> > On Mon, Apr 21, 2025 at 06:59:20PM -0400, Gregory Price wrote:
> > > On Mon, Apr 21, 2025 at 10:39:58AM -0700, Shakeel Butt wrote:
> > > > On Sat, Apr 19, 2025 at 08:14:29PM -0400, Waiman Long wrote:
> > > > > 
> > > > > On 4/19/25 2:48 PM, Shakeel Butt wrote:
> > > > > > On Sat, Apr 19, 2025 at 01:38:24AM -0400, Gregory Price wrote:
> > > > > > > +bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> > > > > > > +{
> > > > > > > +	struct cgroup_subsys_state *css;
> > > > > > > +	unsigned long flags;
> > > > > > > +	struct cpuset *cs;
> > > > > > > +	bool allowed;
> > > > > > > +
> > > > > > > +	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
> > > > > > > +	if (!css)
> > > > > > > +		return true;
> > > > > > > +
> > > > > > > +	cs = container_of(css, struct cpuset, css);
> > > > > > > +	spin_lock_irqsave(&callback_lock, flags);
> > > > > > Do we really need callback_lock here? We are not modifying and I am
> > > > > > wondering if simple rcu read lock is enough here (similar to
> > > > > > update_nodemasks_hier() where parent's effective_mems is accessed within
> > > > > > rcu read lock).
> > > > > 
> > > > > The callback_lock is required to ensure the stability of the effective_mems
> > > > > which may be in the process of being changed if not taken.
> > > > 
> > > > Stability in what sense? effective_mems will not get freed under us
> > > > here or is there a chance for corrupted read here? node_isset() and
> > > > nodes_empty() seems atomic. What's the worst that can happen without
> > > > callback_lock?
> > > 
> > > Fairly sure nodes_empty is not atomic, it's a bitmap search.
> > 
> > For bitmaps smaller than 64 bits, it seems atomic and MAX_NUMNODES seems
> > smaller than 64 in all the archs.
> 
> Unfortunately, it's config-defined on (NODES_SHIFT) and the max is 1024.
> 
> Is there an argument here for ignoring v1 and just doing the bit-check
> without the lock?  Is there an easy ifdef way for us to just return true
> if it's v1?
> 

It is !(cgroup_subsys_on_dfl(cpuset_cgrp_subsys)) and I see cpuset_v2()
and is_in_v2_mode() in kernel/cgroup/cpuset.c.


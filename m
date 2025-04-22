Return-Path: <linux-kernel+bounces-613220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC5DA959B9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 01:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390F11896DD1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 23:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD7D22AE49;
	Mon, 21 Apr 2025 23:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="faZh5Iol"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D177C2ED
	for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 23:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745277374; cv=none; b=ZQ1TwWtkzcaDoxZLYLzoGQxT32MkCyoZN0okFl/anxl36+3+4hdIu0YZiDmYOn9987UmSnW2JP75AXAE6ELY3FsTN1CR9+uT1lDihbRhxZxRfu9Ab3K2440WBHw/6YLzVTJ5WpoxA1X+20ujwnzwvpJRaWPsHK9BBOu79OFG0+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745277374; c=relaxed/simple;
	bh=VToYAGPOGouyG1b07AS5zP+PZ7akrPkUFzgJ+fTWD88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlVVrMK3QnBgB0CuWhEWiVt0dN13L+yWnzrGp4p4fUGp8Tp7sLL9EyLUoUlzCYsBuTTbScL69xouSFt+Suqn+vmkLEzyIYM7ovVeKcm5oc5+MKK0njDjKhpdpkRG4a0p2krAdVcGsvwKHozy1tMUq3/yEu0aa36wmvbResT9FEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=faZh5Iol; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 21 Apr 2025 16:15:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745277359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bZwUUkF9o+QsLYIOwSMNxz5A0VLDrjRSGdE39s7vzJs=;
	b=faZh5IollC7WTz0K2Utiy4sK/V1yin7lw2JUPdXA3eD9q6Esv4XEmub7Ovecxt4jev6Ncr
	vxsvkchhi2Dwk5H9AjN1G3FKRMnWkde9fyjHDEe4UJe0jyNq0ZtpkkUctnWAO2HK7yARGq
	qLps1/bltMjndAo4aj9IbBII/fXbwRI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Gregory Price <gourry@gourry.net>
Cc: Waiman Long <llong@redhat.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, tj@kernel.org, mkoutny@suse.com, akpm@linux-foundation.org
Subject: Re: [PATCH v3 2/2] vmscan,cgroup: apply mems_effective to reclaim
Message-ID: <ekug3nktxwyppavk6tfrp6uxfk3djhqb36xfkb5cltjriqpq5l@qtuszfrnfvu6>
References: <20250419053824.1601470-1-gourry@gourry.net>
 <20250419053824.1601470-3-gourry@gourry.net>
 <ro3uqeyri65voutamqttzipfk7yiya4zv5kdiudcmhacrm6tej@br7ebk2kanf4>
 <babdca88-1461-4d47-989a-c7a011ddc2bd@redhat.com>
 <7dtp6v5evpz5sdevwrexhwcdtl5enczssvuepkib2oiaexk3oo@ranij7pskrhe>
 <aAbNyJoi_H5koD-O@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAbNyJoi_H5koD-O@gourry-fedora-PF4VCD3F>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 21, 2025 at 06:59:20PM -0400, Gregory Price wrote:
> On Mon, Apr 21, 2025 at 10:39:58AM -0700, Shakeel Butt wrote:
> > On Sat, Apr 19, 2025 at 08:14:29PM -0400, Waiman Long wrote:
> > > 
> > > On 4/19/25 2:48 PM, Shakeel Butt wrote:
> > > > On Sat, Apr 19, 2025 at 01:38:24AM -0400, Gregory Price wrote:
> > > > > +bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> > > > > +{
> > > > > +	struct cgroup_subsys_state *css;
> > > > > +	unsigned long flags;
> > > > > +	struct cpuset *cs;
> > > > > +	bool allowed;
> > > > > +
> > > > > +	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
> > > > > +	if (!css)
> > > > > +		return true;
> > > > > +
> > > > > +	cs = container_of(css, struct cpuset, css);
> > > > > +	spin_lock_irqsave(&callback_lock, flags);
> > > > Do we really need callback_lock here? We are not modifying and I am
> > > > wondering if simple rcu read lock is enough here (similar to
> > > > update_nodemasks_hier() where parent's effective_mems is accessed within
> > > > rcu read lock).
> > > 
> > > The callback_lock is required to ensure the stability of the effective_mems
> > > which may be in the process of being changed if not taken.
> > 
> > Stability in what sense? effective_mems will not get freed under us
> > here or is there a chance for corrupted read here? node_isset() and
> > nodes_empty() seems atomic. What's the worst that can happen without
> > callback_lock?
> 
> Fairly sure nodes_empty is not atomic, it's a bitmap search.

For bitmaps smaller than 64 bits, it seems atomic and MAX_NUMNODES seems
smaller than 64 in all the archs.

Anyways I am hoping that we can avoid taking a global lock in reclaim
path which will become a source of contention for memory pressure
situations.


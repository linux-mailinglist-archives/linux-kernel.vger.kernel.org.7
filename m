Return-Path: <linux-kernel+bounces-828001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE26B93A7F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C767F19052B2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95112FC877;
	Mon, 22 Sep 2025 23:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ecme15aA"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65DC255F28
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758585486; cv=none; b=kZ9gamQdW1FrL8wk0Kv2cVBnjypCfbitxEFnTjZDDxyNAVRoDOh0luge4NmxgSbBys2E6vWqpB6EM9XMnTJxyYBOYebvlNzvGy3RMD+Q3Y+LlBeF87egZpXdcYWxCK6QY6Me25ckbD9UjFvPDUPuXAsIKHbTCGxXtTs2+Lp7JPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758585486; c=relaxed/simple;
	bh=bJHlo7zGt+IxLRFAtYHsExnZ7mBkxzhaVr6W9q2rV8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZ4XudjfSuLK2pvOB37BjcdhgDAOU7OY9NsAmdMd22Q59UIG1dTBPlFqtakv3XpCVvVFFkqX4aUGPGxUdEhPi1Wy45XYVnO0NPIwcN1hHsbfHbxP5LFVBJD/AYIhDOuUVzg8DMLMFEjm1TuJH9yI3nOgmSlHS5/xBUXTeFRPBrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ecme15aA; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 22 Sep 2025 16:57:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758585481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I249uCXjcrnPHCtWWPGaeLfw8fIgOsN3T+f7nWAqPeA=;
	b=ecme15aA9EoMkti0fX8W5xi+YQF2qPW/Auxv/JqzE9bRN62asdRJojQPfo1ExGUkQXFQKW
	okzJ+30kHtIAkUNEOe4AsMdnTZWlnKrHcd3ZzlGHSvXqtp5bFW42IhOCXiCm2gnk+6Djdt
	z/HlYwYH8IdAegegKwcli+pIIkFqTQU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Peilin Ye <yepeilin@google.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2] memcg: skip cgroup_file_notify if spinning is not
 allowed
Message-ID: <uvm7vru6ulfakmy4qb5slq2ee7dgiuis2aei3vdyu4nk4pyubh@noc2gep35huh>
References: <20250922220203.261714-1-shakeel.butt@linux.dev>
 <20250922160308.524be6ba4d418886095ab223@linux-foundation.org>
 <nzr2ztya3duztwfnpcnl2azzcdg74hjbwzzs3nxax67nsu6ffq@leycq6l5d5y2>
 <20250922164328.0d766c95f9c15330e99514bd@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922164328.0d766c95f9c15330e99514bd@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 22, 2025 at 04:43:28PM -0700, Andrew Morton wrote:
> On Mon, 22 Sep 2025 16:22:57 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> > > 
> > > > --- a/mm/memcontrol.c
> > > > +++ b/mm/memcontrol.c
> > > > @@ -2307,12 +2307,13 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
> > > >  	bool drained = false;
> > > >  	bool raised_max_event = false;
> > > >  	unsigned long pflags;
> > > > +	bool allow_spinning = gfpflags_allow_spinning(gfp_mask);
> > > >  
> > > 
> > > Does this affect only the problematic call chain which you have
> > > identified, or might other callers be undesirably affected?
> > 
> > It will only affect the call chain which can not spin due to possibly
> > NMI context and at the moment only bpf programs can cause that.
> 
> "possibly" NMI context? 

NMI is one source which can cause recursive context but bpf programs
attached to specific call chains can also cause this recursion. For
example in [1], a bpf program related to sched_ext was called with
scheduler locks held and then that program made a memcg charged
allocation which can potentially call cgroup_file_notify(). The
notification call chain again tries to grab scheduler locks and
potentially causing deadlocks.

[1] https://lore.kernel.org/all/20250905061919.439648-1-yepeilin@google.com/

> Is it possible that a bpf caller which could
> have taken locks will now skip the notifications?  Or do the gfp_flags
> get propagated all the way through?

The bpf programs which might be called/triggerd in a context where
spinning on a lock might not be safe, will skip the notifications. The
gfp_flags are plugged through. Basically we have kmalloc_nolock()
interfaces coming up which will make sure the correct gfp flags are
passed through.


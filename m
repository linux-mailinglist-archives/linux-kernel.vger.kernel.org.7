Return-Path: <linux-kernel+bounces-827974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 392DEB93904
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F33C1896A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925132F0C6E;
	Mon, 22 Sep 2025 23:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EgOGLDog"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7232C15A9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758583390; cv=none; b=VMPAFqLtNtwrhYT+lZMBiNgvtyC8wM8akfFbiljiouINookfkrVrgccxYsEz2wWPeLbO1GjEqnlYIMtjzFw2DPDucsg0FROS5+8szt7DYN+Bu+FppNWfD9HY8Q0xrSHyCMSzi8gkXdXAhtWi0i11sgeEO2Qw2IhEIpkg9K2gGUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758583390; c=relaxed/simple;
	bh=IH6lVtuTOZRoU62tM1LYTwRC00+znLLpyoSzT0D1sxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sk5IrvVT3lDEjxkCiiwK0dF/IG02A0t8++GImw0/qS45b1eO5rcAt5Bpy1diSqXJhi7XKHokZlbxGzoBg8BCkLnZ+oo7CNdfM50RLQO5X8h8BtqeBfvG2CokzDPje7p1m3P3JXupo72rK+w0dy1wk9rvUz1DXdaEp5Uo6gRpB8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EgOGLDog; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 22 Sep 2025 16:22:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758583384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=syOw9Ju7maSQMJoOZeW4RQ04N8SC8w7XMJeEdKsYZk8=;
	b=EgOGLDogBBbcncEgiOkyC5L1FYT3AhDoDy0JRhVXAGqQ3EWGB2LAy171sGBEWgtks9KSnq
	zaD0gpqYWWkg3EohVh4C4q/myGGSBRdIMY2JrnjG0m8UO40KgkM/sZWCzjREh5bjCSSeuO
	btqG8R88PtOb53qbqw3ccmGraMa+gSo=
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
Message-ID: <nzr2ztya3duztwfnpcnl2azzcdg74hjbwzzs3nxax67nsu6ffq@leycq6l5d5y2>
References: <20250922220203.261714-1-shakeel.butt@linux.dev>
 <20250922160308.524be6ba4d418886095ab223@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922160308.524be6ba4d418886095ab223@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 22, 2025 at 04:03:08PM -0700, Andrew Morton wrote:
> On Mon, 22 Sep 2025 15:02:03 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> > Generally memcg charging is allowed from all the contexts including NMI
> > where even spinning on spinlock can cause locking issues. However one
> > call chain was missed during the addition of memcg charging from any
> > context support. That is try_charge_memcg() -> memcg_memory_event() ->
> > cgroup_file_notify().
> > 
> > The possible function call tree under cgroup_file_notify() can acquire
> > many different spin locks in spinning mode. Some of them are
> > cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
> > just skip cgroup_file_notify() from memcg charging if the context does
> > not allow spinning.
> > 
> > Alternative approach was also explored where instead of skipping
> > cgroup_file_notify(), we defer the memcg event processing to irq_work
> > [1]. However it adds complexity and it was decided to keep things simple
> > until we need more memcg events with !allow_spinning requirement.
> 
> What are the downsides here?  Inaccurate charging obviously, but how
> might this affect users?

Charging will still be accurate. The only thing we will miss is the
possible notifications to the userspace for memory.events[.local] files.

> 
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2307,12 +2307,13 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >  	bool drained = false;
> >  	bool raised_max_event = false;
> >  	unsigned long pflags;
> > +	bool allow_spinning = gfpflags_allow_spinning(gfp_mask);
> >  
> 
> Does this affect only the problematic call chain which you have
> identified, or might other callers be undesirably affected?

It will only affect the call chain which can not spin due to possibly
NMI context and at the moment only bpf programs can cause that.


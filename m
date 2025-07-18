Return-Path: <linux-kernel+bounces-736100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B40DB098D8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE773B3C89
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 00:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771E1BA36;
	Fri, 18 Jul 2025 00:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D1ljpPBF"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A825D29B0
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752797842; cv=none; b=mrgikaZYvb2xgqNETfG7B8mrQYl4xfR+BRccUTxHuI3Kxqv6UK9ZMOkC7m7AWTaIKb9+tMttpfmDoqTawba5LLazGgeWDFiwEc9SjvPCD0Pv1MhR8LIiGASeVUFscKwmEGpNdBLa6W5GFmDOvsH77GKh4gVUET5sMAl29Ii06cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752797842; c=relaxed/simple;
	bh=MulHt93po9KU9ptIhTSP6zEBJFinv7DKZJo9vM6F87M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oyp7OEYWpzqz0oQh2EUEWdxOO5NuHEvJvCQKcVRVRN/fsMmyu2Np2jjWNNy6r9dVldVkGqH6SdOJ21dpTd2wCVHjw+8xFjTDkS7R9JomLj1aEN75x+GnYaPciHdDQxtDkXv6vNPR8Tl6gXhWj7eDpQzzYqe9AODyRpHPAKH8qJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D1ljpPBF; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 17 Jul 2025 17:17:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752797838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HPThvsGTU9AmYUXc5iZse47Q32vjXDXF/k19b8GxfmQ=;
	b=D1ljpPBFzcIGTjSTyt78lBLe1cFIZB5a1PZkFZRbxnIm0M4yAK1vRgGaZxZaCOy2N1AvOt
	ML+DGmr6+9XCZR3IMaPtO/DmSACXf76xsBXvxAM4lxGe148xSysG9iLtEaqc2L+YSFmHxO
	ARz7pho++7j0USrX5UupFOMTG41s8+g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, mhocko@kernel.org, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, yosryahmed@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm/memcg: make memory.reclaim interface generic
Message-ID: <kmf75c5gibjaf6ezziksqegko53bxf2ju5hfir364frt4rxhda@brojj36vx5cf>
References: <20250623185851.830632-1-dave@stgolabs.net>
 <20250623185851.830632-3-dave@stgolabs.net>
 <ggavn7jgnti6uhdwlbgmuz4miplyh5zzixgmlye53qmaoh7tkp@3srwgtxrhtld>
 <20250717155246.1f2a90c76d71b401255f11b9@linux-foundation.org>
 <20250717235604.2atyx2aobwowpge3@offworld>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717235604.2atyx2aobwowpge3@offworld>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 17, 2025 at 04:56:04PM -0700, Davidlohr Bueso wrote:
> On Thu, 17 Jul 2025, Andrew Morton wrote:
> 
> > On Thu, 17 Jul 2025 15:17:09 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > 
> > > On Mon, Jun 23, 2025 at 11:58:49AM -0700, Davidlohr Bueso wrote:
> > > > +
> > > > +int user_proactive_reclaim(char *buf, struct mem_cgroup *memcg, pg_data_t *pgdat)
> > > > +{
> > > > +	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
> > > > +	unsigned long nr_to_reclaim, nr_reclaimed = 0;
> > > > +	int swappiness = -1;
> > > > +	char *old_buf, *start;
> > > > +	substring_t args[MAX_OPT_ARGS];
> > > > +
> > > > +	if (!buf || (!memcg && !pgdat))
> > > 
> > > I don't think this series is adding a use-case where both memcg and
> > > pgdat are non-NULL, so let's error out on that as well.
> > 
> > As a followup, please.  This has been in -next for four weeks and I'd
> > prefer not to have to route around it (again).
> > 
> 
> From: Davidlohr Bueso <dave@stgolabs.net>
> Date: Thu, 17 Jul 2025 16:53:24 -0700
> Subject: [PATCH] mm-introduce-per-node-proactive-reclaim-interface-fix
> 
> Both memcg and node is also a bogus case, per Shakeel.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

With this, I think we are good. We can always refactor and move code
around to our taste but interface and functionality wise this is fine.

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>



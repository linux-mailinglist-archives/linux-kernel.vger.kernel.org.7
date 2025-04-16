Return-Path: <linux-kernel+bounces-603645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA02BA88A6B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 19:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A85D18992E3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 17:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF52C274FD8;
	Mon, 14 Apr 2025 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g9WWJcrG"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A48D1A3144
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744653152; cv=none; b=svpjEbYWfY0fawmSnL/kdzYY7m4XSoyK7QagHF/cnorBRQYooBraqs1eOuehrfznixzAlaGnf11+StAQrr0f4uvM2gfsip59/A1LOWVRrQFGUXd9b5pNarwZbvq8vuKPIqJp2lynGPNBxliYDWViVnf3u6hexzR9Ijl5bKMoagA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744653152; c=relaxed/simple;
	bh=/aPR+YUw+zlRGMujxpVHDk1l/K2U3+U+DrTMLtSmwQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2QxYR6I6Lpv4MLnIwpv7tLInXsXMlL206lmmwjVWovsClH32Ybu1L4sf1bhoF1XjqxOujGAwEXRf53z2S/65Jx+7b0BxJ+3wJ9i9KqWipFVonuEoH6dIHv/xXvWS7q4xJIhJFiYNKBL1AbegKu7av+ajZMPn6mzm2FLfDFNQeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g9WWJcrG; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 14 Apr 2025 10:52:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744653147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vRe+MVQPZViiLA1Y9m/i86MGRkDnhLyhpBrzwZ9S78=;
	b=g9WWJcrGGa6VfsOyy66ejvsC8a9ns51UGLMfC7TehddsWRPhsAYhu5+yrVx8AMEV9Vl2HO
	BmUhiw4ujHxWXEPdWzIbQhMJZ5My6t5GVvuCZ9PAp4huYwFfKq9senhQxgiKXojuyajV4M
	ZGMx3yO1XdiEP5RGtAemrdUkIMDGvYs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Waiman Long <llong@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: decouple memcg_hotplug_cpu_dead from stock_lock
Message-ID: <atnweqyv7rnyzei3at2dm4xxca4ctvuod2w7brejg4b5zydgdm@xobzurjmjhy5>
References: <20250410210623.1016767-1-shakeel.butt@linux.dev>
 <20250410220618.405d00875ca61043c4ffa6e1@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410220618.405d00875ca61043c4ffa6e1@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

(I was trying to reply last week but my email stopped working, so trying
again)

On Thu, Apr 10, 2025 at 10:06:18PM -0700, Andrew Morton wrote:
> On Thu, 10 Apr 2025 14:06:23 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> > The function memcg_hotplug_cpu_dead works on the stock of a remote dead
> > CPU and drain_obj_stock works on the given stock instead of local stock,
> > so there is no need to take local stock_lock anymore.
> > 
> > @@ -1964,10 +1964,10 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
> >  
> >  	stock = &per_cpu(memcg_stock, cpu);
> >  
> > -	/* drain_obj_stock requires stock_lock */
> > -	local_lock_irqsave(&memcg_stock.stock_lock, flags);
> > -	drain_obj_stock(stock);
> > -	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> > +	local_irq_save(flag);
> > +	/* stock of a remote dead cpu, no need for stock_lock. */
> > +	__drain_obj_stock(stock);
> > +	local_irq_restore(flag);
> >  
> 
> s/flag/flags/
> 
> Obviously what-i-got isn't what-you-tested.  Please check what happened
> here,

Sorry about that. I tested the previous version where I had
drain_obj_stock() as a separate function but after seeing that there is
just one caller, I manually inlined it but forgot to test before
sending.


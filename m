Return-Path: <linux-kernel+bounces-655787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CE5ABDD1E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 16:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7EBB7B446E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 14:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C82242D93;
	Tue, 20 May 2025 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ifq71GuU"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7045C242D92
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747751089; cv=none; b=jTbEjOrUaw5ZG8VlRmrcudfKKgMK9CU0ADazeCUciwHxhxl2dDznCKLmL6eDkECg4JwFOWQTDW0bEO3qMGHn0TqQLVVegV6a6m6MKHRaF41SmGoEyOuHOV3t5uMf9zf/2nqQUR2WQPgk2zxcRtkaeLj1BLXkysoTe9S7tuxKY9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747751089; c=relaxed/simple;
	bh=Yvxx6Bu2YYTpjWbmu0Eo4W+cis8fHaGJTUi5npOCmyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzLB3PiP0HzTFbuFuRJDPrgBqz49V9FkQaDUXtkyRSDB9uaH+9+c7G05CljQssK1JWXfosOJMorYkbmeBhOLlRNdsSRXmokpL1qN6njaQm6sDco2yjFL/mOsMWqvPj7dBG56ZAHKpUxF0CTTE/iq0fVgpJ0Dqh1iMuSDIQPbkj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ifq71GuU; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 May 2025 07:24:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747751085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C9ImqvqQLUX0kdsxLhKUAbg/uyYeCd3CXJPyocJ5Gfw=;
	b=Ifq71GuUaygpKgGDTzad7K32V5dz5GZMkG2WGSFMZ25+2hMaPMiz3dujQ+9TvfHyxv7R4X
	FDXSa9PdaUuZP1QNEt8DyUcpZPdldi2SDLNjHe4zuNQGII99bGbS764tfYohY3hEzYJ3mb
	gcpzW7HM51sMnwBo0A2o4MKT28QZrVg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Usama Arif <usamaarif642@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, surenb@google.com, hannes@cmpxchg.org, vlad.wing@gmail.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 1/2] mm: slub: allocate slab object extensions
 non-contiguously
Message-ID: <ewn4u5ssskqzad4sjerg6zkxjhvuik6cs4st4jarpizztq4fca@p4wwfavollhm>
References: <20250520122547.1317050-1-usamaarif642@gmail.com>
 <3divtzm4iapcxwbzxlmfmg3gus75n3rqh43vkjnog456jm2k34@f3rpzvcfk3p6>
 <6d015d91-e74c-48b3-8bc3-480980a74f9b@gmail.com>
 <22oihuvcrh5sg3urocw6wbop2v5yni7zinuhywbz7glsee4yoa@gzi5v5fcggdl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22oihuvcrh5sg3urocw6wbop2v5yni7zinuhywbz7glsee4yoa@gzi5v5fcggdl>
X-Migadu-Flow: FLOW_OUT

On Tue, May 20, 2025 at 10:01:27AM -0400, Kent Overstreet wrote:
> On Tue, May 20, 2025 at 02:46:14PM +0100, Usama Arif wrote:
> > 
> > 
> > On 20/05/2025 14:44, Kent Overstreet wrote:
> > > On Tue, May 20, 2025 at 01:25:46PM +0100, Usama Arif wrote:
> > >> When memory allocation profiling is running on memory bound services,
> > >> allocations greater than order 0 for slab object extensions can fail,
> > >> for e.g. zs_handle zswap slab which will be 512 objsperslab x 16 bytes
> > >> per slabobj_ext (order 1 allocation). Use kvcalloc to improve chances
> > >> of the allocation being successful.
> > >>
> > >> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> > >> Reported-by: Vlad Poenaru <vlad.wing@gmail.com>
> > >> Closes: https://lore.kernel.org/all/17fab2d6-5a74-4573-bcc3-b75951508f0a@gmail.com/
> > >> ---
> > >>  mm/slub.c | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/mm/slub.c b/mm/slub.c
> > >> index dc9e729e1d26..bf43c403ead2 100644
> > >> --- a/mm/slub.c
> > >> +++ b/mm/slub.c
> > >> @@ -1989,7 +1989,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> > >>  	gfp &= ~OBJCGS_CLEAR_MASK;
> > >>  	/* Prevent recursive extension vector allocation */
> > >>  	gfp |= __GFP_NO_OBJ_EXT;
> > >> -	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
> > >> +	vec = kvcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
> > >>  			   slab_nid(slab));
> > > 
> > > And what's the latency going to be on a vmalloc() allocation when we're
> > > low on memory?
> > 
> > Would it not be better to get the allocation slighly slower than to not get
> > it at all?
> 
> Our behaviour when thrashing sucks, we don't want to do anything to make
> that worse.
> 
> There's also the fact that vmalloc doesn't correctly respect gfp flags,
> so until that gets fixed this doesn't work at all.

Which gfp flags vmalloc is not respecting today?


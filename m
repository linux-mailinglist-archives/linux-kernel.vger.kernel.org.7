Return-Path: <linux-kernel+bounces-789544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F271B39714
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4021C26CA2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EB12DF6F4;
	Thu, 28 Aug 2025 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6fdzElg"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E01B30CD9D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370059; cv=none; b=A5YzWBI5T4BRu+CmODyhM9l/CExsvSLvFgFz8zI1utIjiypHGj1lnzrg0Se/TWyITOJTGy9Bses6U1d/J/eB6oEVm4wpRQJ1vKeQ6XbRNfIagqI4oWDymONeGHRfdaAT0WCX8lwfQvGz9+9EJgknqP5C4218rr7EsQvKYhMr1Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370059; c=relaxed/simple;
	bh=xL2mVALlo4XbtEG9WiWSmTlNLalMxUOpSTnTqHlQazc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvXsL1FUZOFvjmPQwsfVr9fn63v+5ub9zST9EvA1NH/1vrEoMGQ7mTetZCIMXassD3ZA7EdsRTKsYE/nOSBBGc4XM/27aOAVn5LTcrHGgRXOvCu8XidEhcsqF+SxuS97Zie/OBSbxaHG8d6fPt/chbKZHqMK229PRld+lc3K2x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6fdzElg; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b0c82eeso5355995e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 01:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756370056; x=1756974856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oaxt8xPDHaX5/SStMCV3uDYTkxCNq1ZcKZPr2oUXvcU=;
        b=O6fdzElgzuksZ1C2vQuFm1sw73scvvJ/lYptnjg+HWdxKiJ0BNyEJkU+6QRxTolHw3
         BBS+CuyMLSpGl0zGI96/nmhdp8eK7i78/Jlf/UKe5I/HGfJheV3PDC6WuE5HkZ/blkVF
         nQLLl916zTUwOe4iexvGA4du4p3TPZ0t2wJwJ1kwRnXH4rcKRmPYrIDPmftImkdGHLFf
         3gWQOlSvppHdSPhc9jmNQ3RXvSCCs/x5oB75MGRAT+H6XXFmyigs/tyHIHn93T8Cqq5o
         ibSFr30CjG5WsEzCp5PTZ7UATXkk7Ew4QBfnHi8wHg8rLiH6g8eUeLBxF8o3V7T8mBZQ
         8klw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756370056; x=1756974856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaxt8xPDHaX5/SStMCV3uDYTkxCNq1ZcKZPr2oUXvcU=;
        b=cNBJvt5khylgdl5QApzQK5X/c1bRTluI+2M/Z3jo+tmmDhkvVR8V9udcx04Q+Sz8wE
         v+eJcifmUdCMQAeaQE0H71jOoO9c3TsOKFX37ysOPqeo/6Z9zS2Vy3xMsYDnvlCKe4dl
         qSlcVDfAgJ6rkCPG/wdT0bzUj1PNjm1l8UGoo8THt954deHps+XQ23FIO6xZroO7zeKD
         dQiyvb6uF95cShLu37aZeoIKC3Gj4dMDQlpgv3ITfjcYHUo6H5b9sJ2BVjoHJ61++Dh0
         143MpEjmbdt4rc69AT6nAHNRSubF8QHubsBZIPp5Sq5l3b86sMwA5CFWWm4PPquTsEcJ
         PjRg==
X-Forwarded-Encrypted: i=1; AJvYcCWRr3BMQc3cq9EWD2K+J8Ph+oO9PdUtwCKwb6/y0qPxaznw9+LEXypktUKSztowuGGvJZUxrtUcCJrVeG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX2/gIlvUDN6mSNnlbVC/rj1m3NgJzHUz9MnmEteu3VMBqBIId
	Tu26wk3cI2XAZ+LqJ3wgHZYGGbAVabJmOe5a46LzKIh4zeVLo3PRzFIf
X-Gm-Gg: ASbGncuacdscjZaFDxhLiUJOYRjkS+KmOCla532bRYpOUADuOAtmsLEXFWOikvg1zye
	CFzx7SjCSiIEcUWDlC5QwL2p491Dr24e+8Ydcm6yJC9nVHHGXX78pMLntsExCIbcozn5KmEs45r
	Whl096MZixRQyDurGG2blPuJFaprEZmpKHxm4epT0/6NCtSRDDv4qr3O2eRNNB/zBazLrdsWsnc
	1LOwZwq5ot3dvyOZJneO/cKPTTCF6GXpr51w0lTH9bBcn1W3G7/BUlB74e5VB4N/I5yBnkKG9YC
	2blePm5YiJ8rSC3YUuAGpTDStDmqxzb8rRYq5966bnSA+Q1RjpIPuwZMbey7z/AQp4Yglc/Oh7e
	RDflkbAUC8uzkplTWMV6PY+VOTXdYwJnnh6xC67A=
X-Google-Smtp-Source: AGHT+IE8QcGUDVFs6NWKw2kIqg9iEDJihZMckPcyK8Pf8fgxG94pUXuPZd5F+LMY9SACdjfkiZje1Q==
X-Received: by 2002:a05:600c:35c9:b0:459:d821:a45b with SMTP id 5b1f17b1804b1-45b5179e76dmr193622635e9.9.1756370056080;
        Thu, 28 Aug 2025 01:34:16 -0700 (PDT)
Received: from devbig569.cln6.facebook.com ([2a03:2880:31ff:48::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7bfb13a0sm10975985e9.9.2025.08.28.01.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 01:34:15 -0700 (PDT)
Date: Thu, 28 Aug 2025 01:34:13 -0700
From: Yueyang Pan <pyyjason@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org,
	kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mm/show_mem: Add trylock while printing alloc info
Message-ID: <aLAUhXeRVWzLCNNd@devbig569.cln6.facebook.com>
References: <cover.1756318426.git.pyyjason@gmail.com>
 <7e2bc96faab1a338829e549246189ad96e6c866b.1756318426.git.pyyjason@gmail.com>
 <20250827150619.4e468e68988f224f9f9bea6f@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827150619.4e468e68988f224f9f9bea6f@linux-foundation.org>

On Wed, Aug 27, 2025 at 03:06:19PM -0700, Andrew Morton wrote:
> On Wed, 27 Aug 2025 11:34:23 -0700 Yueyang Pan <pyyjason@gmail.com> wrote:
> 
> > In production, show_mem() can be called concurrently from two
> > different entities, for example one from oom_kill_process()
> > another from __alloc_pages_slowpath from another kthread. This
> > patch adds a mutex and invokes trylock before printing out the
> > kernel alloc info in show_mem(). This way two alloc info won't
> > interleave with each other, which then makes parsing easier.
> > 
> 
> Fair enough, I guess.
> 
> > --- a/mm/show_mem.c
> > +++ b/mm/show_mem.c
> > @@ -23,6 +23,8 @@ EXPORT_SYMBOL(_totalram_pages);
> >  unsigned long totalreserve_pages __read_mostly;
> >  unsigned long totalcma_pages __read_mostly;
> >  
> > +static DEFINE_MUTEX(mem_alloc_profiling_mutex);
> 
> It would be a bit neater to make this local to __show_mem() - it didn't
> need file scope.

Thanks for your feedback, Andrew. I will move it the next version.

> 
> Also, mutex_unlock() isn't to be used from interrupt context, so
> problem.
> 
> Something like atomic cmpxchg or test_and_set_bit could be used and
> wouldn't involve mutex_unlock()'s wakeup logic, which isn't needed
> here.

I was not aware of interrupt context before. I will change to test-and-set 
lock in the next version.

> 
> >  static inline void show_node(struct zone *zone)
> >  {
> >  	if (IS_ENABLED(CONFIG_NUMA))
> > @@ -419,7 +421,7 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
> >  	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
> >  #endif
> >  #ifdef CONFIG_MEM_ALLOC_PROFILING
> > -	if (mem_alloc_profiling_enabled()) {
> > +	if (mem_alloc_profiling_enabled() && mutex_trylock(&mem_alloc_profiling_mutex)) {
> >  		struct codetag_bytes tags[10];
> >  		size_t i, nr;
> >  
> > @@ -445,6 +447,7 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
> >  						  ct->lineno, ct->function);
> >  			}
> >  		}
> > +		mutex_unlock(&mem_alloc_profiling_mutex);
> >  	}
> 
> If we're going to suppress the usual output then how about we let
> people know this happened, rather than silently dropping it?
> 
> pr_notice("memory allocation output suppressed due to show_mem() contention\n")
> 
> or something like that?

For this point, I am sort of on Shakeel's side. Probably I won't call 
it suppressed as two concurrent printers is actually sharing this 
global information.

Thanks,
Pan


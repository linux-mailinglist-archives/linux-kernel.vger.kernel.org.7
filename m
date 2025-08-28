Return-Path: <linux-kernel+bounces-789547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A316B3971B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7AD21B22A53
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC442E1F04;
	Thu, 28 Aug 2025 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQlWlhsB"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C7A1E47C5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370183; cv=none; b=G9WDNC37UOV+fkvQ8m2CieskCCxeBiLqedtB53GPBqJAxJlGiKHKpplkNj8czCcAs2Fztt9xkZBKiKrOc22z2i2TRomPczX63JNG33bzLvVjbQB0gKyvUGQdmC4Q789zWyz6JReNILTVRdZdAMNROjMxojBgN3ofPBdh/2a4xVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370183; c=relaxed/simple;
	bh=g2fwZ/7N/tRdXtNsPHdWgoN4PtE84j8m4gVEdBJEwX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpNXzgj6EqcAjnW84nDfiYs/fd11pbRSqFHRUrilkIQaR0+Z0nEMUAulX3SE2A65E8EJUl4Zz63QKqTVGF3nTOdG6NsP+cza6mW0gXnVPpVBQmt/Vfe4hikdmIPx2Tyj3DXwWPNoTkT0bfTIjJc7bBmuSULsIk7jWALjFeLM15Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQlWlhsB; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3c6743a10e3so317696f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 01:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756370180; x=1756974980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0JaUseZ6CWu1EJ1U3qBAV9Lj7Z4bwfj9ev3APaGuRbI=;
        b=nQlWlhsBTD5XW+FOLM676Un+HGJYnaFTc5A5ZeSy39EyAPplPeAdyHYr8OfchAZm3k
         uC/hG7W0jwoEUDjGskdY6VC47ihy4sATsB2piIsXFm1qCy/qK6dsXPIZTMISdiOWvj7k
         N2rsXaMObuW41NwknTHj6HVkNakWJOt0hHNTV3G1GF02keokW/7UOzU/aGLDpYQEsUHz
         uhhQR8jdPZ77x+4RIre0w8pzBdNrNsbANX/dxR2ucv+x+29I6ZjM0LbGdh/mKafNsCAR
         Qq9CdD/QcdT01oIMjw3A3e/RiusjH8ffefsa1ctwCDw8TIiNqF22c/dqQQWSfq6qmTbb
         nPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756370180; x=1756974980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JaUseZ6CWu1EJ1U3qBAV9Lj7Z4bwfj9ev3APaGuRbI=;
        b=S3pjN2kVoN4LzwTbNTzvJo7bEufM4VWKr6oKTGkeD/07GYtQtwCWzLWdVCMsOs8mNX
         XEniA96zheVbE2SGkoo4ocp2yk7gquHpS0s/rGED8QIJ7PviO/I5kmovkpMjNIXREECC
         f31KNJ0okBF2ZPdY1tq+TdprEEEtCcBkxyvba30LA2bKU3KP2tLyt/tpvRO5jK3Rbe6D
         WlqBGLrztOaWOkBqCfqlXFdEMVAYyh9rXZl+hZWxXzXzEt+m2wyYVqY6rCqO31GA96oA
         eOmyS7YmZ9/VrBNpbI9yr3FHP87pvl/JKk1Z/g/GBQuXGQvTWId++7KU+Yq0xMnhDQLB
         aWgg==
X-Forwarded-Encrypted: i=1; AJvYcCWr4XyI9JNhLrGwJ0JXMsYndkvqf6j4qYFQs+5AENfPwmgEgAJ6+ox/h/I0MRP4LJIUxI2/fKkO2kPY9rU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz12aUHOCU0hefWhcz6T/CB1lBC7zrPyiRtxb2+RDrHbsF5LNXa
	LLr3FGPJP91ceKo0Gl7fxFL6O8gtsaFyl3CXScIv5aIMgaH//yywOBZJ
X-Gm-Gg: ASbGncvJohZQqxHrG232KrQVmpW+KfbUEXNdJtiZLAg6dNRSkqcTPji7I0aA/dA2HMn
	2IUZbngiUvMnqKogpwsq3r8pJDiVFfcyUtBEc732Ss1Aiz2NTNQbOHvvuqaydtdfNJcX6PlPVzJ
	lutz7AMSonYJcRAdUZSUHtVnIlsi2MA9myn3bpQxCSPJIT8X5vGzdl0rUwj9eJFj48pec8EnfkG
	BEmbXbcxP+Rec3NhIVoZSIXMx3C3gEJ1ou5Oix0/Vin4ZHpq1p1o51FhYdjttZ8fb0gNsbe+3Az
	xktC0n1NsiMwnHDpWPIuPF3+3GWvQ8vkUjEQwMqmP0LqTZSDU17zBYlBhJJNi/7L/0UoB5AleN+
	sisfeSRulWw+zhqkw/Vn4arNtiTb7Cfcg3KcBpDs7VybQEPNiuA==
X-Google-Smtp-Source: AGHT+IEnj8J0hKFzOYm2Zneg64WLFXqCWW8vLEJTC0ZvD0mC2gMD3pC9v85qzqJuH1pUr23Byo29aw==
X-Received: by 2002:a5d:5f55:0:b0:3c8:2667:4e3c with SMTP id ffacd0b85a97d-3c8266757d8mr13284619f8f.44.1756370180366;
        Thu, 28 Aug 2025 01:36:20 -0700 (PDT)
Received: from devbig569.cln6.facebook.com ([2a03:2880:31ff:58::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4ba44fsm23655189f8f.5.2025.08.28.01.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 01:36:19 -0700 (PDT)
Date: Thu, 28 Aug 2025 01:36:17 -0700
From: Yueyang Pan <pyyjason@gmail.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org,
	kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mm/show_mem: Add trylock while printing alloc info
Message-ID: <aLAVAZMKwYueL+5I@devbig569.cln6.facebook.com>
References: <cover.1756318426.git.pyyjason@gmail.com>
 <7e2bc96faab1a338829e549246189ad96e6c866b.1756318426.git.pyyjason@gmail.com>
 <20250827150619.4e468e68988f224f9f9bea6f@linux-foundation.org>
 <aouiudhvbuwegvkdqwtkp7bk6gvrsxkqe7us5uj6ylg3pivjin@nl4ri6fbh2zd>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aouiudhvbuwegvkdqwtkp7bk6gvrsxkqe7us5uj6ylg3pivjin@nl4ri6fbh2zd>

On Wed, Aug 27, 2025 at 03:28:41PM -0700, Shakeel Butt wrote:
> On Wed, Aug 27, 2025 at 03:06:19PM -0700, Andrew Morton wrote:
> > On Wed, 27 Aug 2025 11:34:23 -0700 Yueyang Pan <pyyjason@gmail.com> wrote:
> > 
> > > In production, show_mem() can be called concurrently from two
> > > different entities, for example one from oom_kill_process()
> > > another from __alloc_pages_slowpath from another kthread. This
> > > patch adds a mutex and invokes trylock before printing out the
> > > kernel alloc info in show_mem(). This way two alloc info won't
> > > interleave with each other, which then makes parsing easier.
> > > 
> > 
> > Fair enough, I guess.
> > 
> > > --- a/mm/show_mem.c
> > > +++ b/mm/show_mem.c
> > > @@ -23,6 +23,8 @@ EXPORT_SYMBOL(_totalram_pages);
> > >  unsigned long totalreserve_pages __read_mostly;
> > >  unsigned long totalcma_pages __read_mostly;
> > >  
> > > +static DEFINE_MUTEX(mem_alloc_profiling_mutex);
> > 
> > It would be a bit neater to make this local to __show_mem() - it didn't
> > need file scope.
> 
> +1, something static to __show_mem().

Thanks for your feedback, Shakeel. See my reply to Andrew for this.

> 
> > 
> > Also, mutex_unlock() isn't to be used from interrupt context, so
> > problem.
> > 
> > Something like atomic cmpxchg or test_and_set_bit could be used and
> > wouldn't involve mutex_unlock()'s wakeup logic, which isn't needed
> > here.
> 
> +1

Again, see my reply to Andrew.

> 
> > 
> > >  static inline void show_node(struct zone *zone)
> > >  {
> > >  	if (IS_ENABLED(CONFIG_NUMA))
> > > @@ -419,7 +421,7 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
> > >  	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
> > >  #endif
> > >  #ifdef CONFIG_MEM_ALLOC_PROFILING
> > > -	if (mem_alloc_profiling_enabled()) {
> > > +	if (mem_alloc_profiling_enabled() && mutex_trylock(&mem_alloc_profiling_mutex)) {
> > >  		struct codetag_bytes tags[10];
> > >  		size_t i, nr;
> > >  
> > > @@ -445,6 +447,7 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
> > >  						  ct->lineno, ct->function);
> > >  			}
> > >  		}
> > > +		mutex_unlock(&mem_alloc_profiling_mutex);
> > >  	}
> > 
> > If we're going to suppress the usual output then how about we let
> > people know this happened, rather than silently dropping it?
> > 
> > pr_notice("memory allocation output suppressed due to show_mem() contention\n")
> > 
> > or something like that?
> 
> Personally I think this is not needed as this patch is suppressing only
> the memory allocation profiling output which is global, will be same
> for all the consumers and context does not matter. All consumers will
> get the memory allocation profiling data eventually.

For this point, I sort of agree with you. Wait for others' opinions?

Thanks
Pan


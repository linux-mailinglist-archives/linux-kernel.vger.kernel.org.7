Return-Path: <linux-kernel+bounces-856383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A25BE402C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86DA04FB88D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5723431F6;
	Thu, 16 Oct 2025 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d0mYgGm0"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F3F3469F7
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626208; cv=none; b=NoOzUVKMUfJnn4Na/MxP8J+HP5BV0CbSZRMXRusQMpimPnFpip4A9+L0BM7WcV5dfVVrQ1ztQ/oDl8U4lWto2to7hK6TQzBb0lZhs7xiRJMHvjYr5GZFpZJIULedDUiV3L5HcHUfhLjmMYQ+sAnWVpbqM4VtysC3QHIEnpYNIhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626208; c=relaxed/simple;
	bh=ceE35F0eeLyXyX75I3zz7X0OUIsSe1yIknedUv+jJk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgJQN0fK/dMcscEkbwE7XDHG1f4Vz6rn6X21hDMWa6Lb9p53DAVf7XZsJ5qypowq+CWKVkNICdCMI6i1grs2NF5mRiJWDfU9vWJnN9bw0tSorazGEDRhitZiaZsjy7kUHaLLHsIUNAmozq8d7FvGgiO70zEoSkxO9Nt8dM7a/tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d0mYgGm0; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4256866958bso569466f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760626193; x=1761230993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W6F4mIwBhj9doOK9z7k7FEumR2hjJ0tw1xmmCLD9hKA=;
        b=d0mYgGm0jeLBY6XkH009SFT5IoCGQ4f/ho1kYxw+2mSsG+rkGwXJ1EOCjP0WVyxddF
         x6yRI2EGOBsPNZ29kT0HPGlL9jTOopAIyG8ndIQr/71652VDFpnAccsqXvSu8regb2Bn
         tCG2owwRU4j05AdQ2HYQRj7oYdNn3jCtM38gcBLmMNLlbf8f7LCSXZiiTJRgfDciGsAT
         pp1s8IftBcGQ6LACwym9fYNUm6pMD70uwnfPzBP8z0oSoooKLL4r7mkU7BOowZG1AEI/
         JLjmD1kCdiQH22f2yNpKyLsUR4yguqvA5sdSmDtbDlbsXpsB8CFOBDDJAAbgSPs3HkA6
         B92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626193; x=1761230993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6F4mIwBhj9doOK9z7k7FEumR2hjJ0tw1xmmCLD9hKA=;
        b=qQqh5U/zmbT7mqg+K38f1/PC4gP+CDUzdL/l/qAwnygdv5RBYC9Tv8+uPaehAwMOzr
         YGUwuNKRQyncPQvCIhsw5W4gXZpoh4yvEY3LJDduIcX4u6XdB2XLJfFElHwrNMpyAYlk
         3p/8TMAKlZ63hNXzhBRSyySUjhQOzNPyCdvOvzRIc+/gjUMACdNr6a+5WQtQcRiGD4yF
         pmWFrmmvBxo7hecJosBloFtlcK4daJ92rcDjfbZq26uChN4MKOQWoZ5iFihYEW//wl7p
         fQ53OoTor9tKK0GQQTWXOQU3WJL8EhJEUdXFQ3j8mR03XD8hoC0UDtUVZ3v9AT+QhggO
         lRtw==
X-Forwarded-Encrypted: i=1; AJvYcCXv/vxRU/zYlA4GcyDYzQQkgIELMMm7mbzLGDc0DQfW7XvfZRvxCPkQNTyikeh1bJxowXmMUrtOYrhGs+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVUD2mKI23SCfdYkzB1iMk9gy+MvgSBQiufzQLebxktl3kpmMQ
	Bl6F2XanxxYhKUOIy772jyO1VMk6HEJ4T9Hvh1ZnnniIKhVH2OTW4Dc05cUVsMhOWLg=
X-Gm-Gg: ASbGncuQSWW7qf/Fx3lnWw9V+fg5ki1g3uJ6vYvweXOE6Lwv9RHr5KjqIfOTskLUoXi
	MrahT3wNT7p2i1SLYVQu8d5Y5Sd3y9Fkmne7l6ucUKZVETdO031q1k2RJcI7cLHq7VXBxA9RgvD
	izzznmJadcUKHLIpQ2rc8GBYEHpiN0EOdiexw9n4ohhKyesb0Ln8YJVYBbnQw2Q81Kw4w6POENm
	J8qH4WSqclfXcCcPPqfiAUojlytDnJrZyU8/NsqD/AJY3BM4/DC30Al+XmmhDFOy3ZXJm7M7o74
	bI0/3aV2PrA1h6YZ2W4LR8GWYTXgXMkJXw2d9iZ5lKcNBYLM+ZrtjXo63NmBIPVbp5LrWk7ehuX
	dBzGHDUVU62b74SKQZgQyUye0Y4I6mzszz5Y9Qco+cDACuoRjDLddOpYFJ0ikOfdrxhSzz7MdJL
	1NMbaqbOVH6Uh5cpC10ZCauw==
X-Google-Smtp-Source: AGHT+IGar8v0iDTZx8UCaPIvELr3VKoaD/nSBrLLGFgIXeQYGbPyAEaN93A5aaeOEz6VqjytwYSZcw==
X-Received: by 2002:a5d:5885:0:b0:3f0:4365:1d36 with SMTP id ffacd0b85a97d-42704d8cde9mr319882f8f.16.1760626192708;
        Thu, 16 Oct 2025 07:49:52 -0700 (PDT)
Received: from localhost (109-81-16-57.rct.o2.cz. [109.81.16.57])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-426ce5e0a03sm35522625f8f.37.2025.10.16.07.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 07:49:52 -0700 (PDT)
Date: Thu, 16 Oct 2025 16:49:51 +0200
From: Michal Hocko <mhocko@suse.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@redhat.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/vmscan: Add retry logic for cgroups with
 memory.low in kswapd
Message-ID: <aPEGDwiA_LhuLZmX@tiehlicka>
References: <20251014081850.65379-1-jiayuan.chen@linux.dev>
 <aO4Y35l12Cav-xr4@tiehlicka>
 <a6cd4eb712f3b9f8898e9a2e511b397e8dc397fc@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6cd4eb712f3b9f8898e9a2e511b397e8dc397fc@linux.dev>

On Tue 14-10-25 12:56:06, Jiayuan Chen wrote:
> October 14, 2025 at 17:33, "Michal Hocko" <mhocko@suse.com mailto:mhocko@suse.com?to=%22Michal%20Hocko%22%20%3Cmhocko%40suse.com%3E > wrote:
> 
> 
> > 
> > On Tue 14-10-25 16:18:49, Jiayuan Chen wrote:
> > 
> > > 
> > > We can set memory.low for cgroups as a soft protection limit. When the
> > >  kernel cannot reclaim any pages from other cgroups, it retries reclaim
> > >  while ignoring the memory.low protection of the skipped cgroups.
> > >  
> > >  Currently, this retry logic only works in direct reclaim path, but is
> > >  missing in the kswapd asynchronous reclaim. Typically, a cgroup may
> > >  contain some cold pages that could be reclaimed even when memory.low is
> > >  set.
> > >  
> > >  This change adds retry logic to kswapd: if the first reclaim attempt fails
> > >  to reclaim any pages and some cgroups were skipped due to memory.low
> > >  protection, kswapd will perform a second reclaim pass ignoring memory.low
> > >  restrictions.
> > >  
> > >  This ensures more consistent reclaim behavior between direct reclaim and
> > >  kswapd. By allowing kswapd to reclaim more proactively from protected
> > >  cgroups under global memory pressure, this optimization can help reduce
> > >  the occurrence of direct reclaim, which is more disruptive to application
> > >  performance.
> > > 
> > Could you describe the problem you are trying to address in more details
> > please? Because your patch is significantly changing the behavior of the
> > low limit. I would even go as far as say it breaks its expecations
> > because low limit should provide a certain level of protection and
> > your patch would allow kswapd to reclaim from those cgroups much sooner
> > now. If this is really needed then we need much more detailed
> > justification and also evaluation how that influences existing users.
> > 
> 
> 
> Thanks Michal, let me explain the issue I encountered:
> 
> 1. When kswapd is triggered and there's no reclaimable memory (sc.nr_reclaimed == 0),
> this causes kswapd_failures counter to continuously accumulate until it reaches
> MAX_RECLAIM_RETRIES. This makes the kswapd thread stop running until a direct memory
> reclaim is triggered.

While the definition of low limit is rather vague:
        Best-effort memory protection.  If the memory usage of a
        cgroup is within its effective low boundary, the cgroup's
        memory won't be reclaimed unless there is no reclaimable
        memory available in unprotected cgroups.
        Above the effective low boundary (or
        effective min boundary if it is higher), pages are reclaimed
        proportionally to the overage, reducing reclaim pressure for
        smaller overages.
which doesn't explicitly rule out reclaim from the kswapd context but
historically we relied on the direct reclaim to detect the "no
reclaimable memory" situation as it is much easier to achieve in that
context. Also you do not really explain why backing off kswapd when all
the reclaimable memory is low limit protected is bad.

> 2. We observed a phenomenon where kswapd is triggered by watermark_boost rather
> than by actual memory watermarks being insufficient. For boost-triggered
> reclamation, the maximum priority can only be DEF_PRIORITY - 2, making memory
> reclamation more difficult compared to when priority is 1.

Do I get it right that you would like to break low limits on
watermark_boost reclaim? I am not sure I follow your priority argument.

-- 
Michal Hocko
SUSE Labs


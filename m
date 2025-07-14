Return-Path: <linux-kernel+bounces-730373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCFCB043E0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9A61898C7A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC4D25D53C;
	Mon, 14 Jul 2025 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="nOjTn/XD"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B656259CA0
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506577; cv=none; b=iiXQiQJQ5ElvOWAIzwh3RIdG4bKu0f/KGLNz+0CtHPRfX0WHTdB/41HbRz2xXVAoZFOXOrWgm1eSGU5QZ+8QBzURouJD4Q0a8rtWRdzOK8ywJLjJUJAR4EFRytO81FwpDP2yNCmb5Ofeezcj8UIwj0QdO/vMHc/UDqJAr+HXWjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506577; c=relaxed/simple;
	bh=wzXnxsruWIb9hLaTkzMUxZr05vnVFD0CzNuePzKJm2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/jjHijJa1cwP+ecrio/9r9kvLUONYrKtzSJ9QwXAeJIXCE1uTPwXVGYvAqKJ1FWwOg5WjJB37IVF7dtkD753dnpmcYMCZug3gr7pmMlxcUirBGJeM/4IFFDUuZC463ImxpdvCQrxfEk7Q833mm94EtuONF6eFDQ/e7vEf6hYG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=nOjTn/XD; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6fafd3cc8f9so63947806d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1752506573; x=1753111373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nmGx1FYo90dL2WOETAZNdmhMseM83XofBrzEl0Cu6l8=;
        b=nOjTn/XDajgD2a6nErLb8T0Tbo03t2A2ftmYayveXub6Kp5KGhkJcVpj7japqvJxaF
         5dk4aU37gUvyyl+eUsTcJ7QwH5DzoyfbMM/Uf3/P6kC8qqVATQwMMKuqc5XAYGdnqJw8
         k7cvavqWyMOtk5IInLKj/UuT37DYVTLah2V9W2swtaNVfjddFRucUrjfHP1S1vbV7jyL
         vK7B4MDOvQxqX5GuYiPX20eqzOC7D7GTd4On2fp0AP9o5hbwWbRc5YCxzmSWGPH3ZtuX
         CPMu9KhTbX8O87nyCyKhaEm48uhaf3nT0wdRyew7CBGuXaV/RuYOnXjEABm9mRqY69oE
         AafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752506573; x=1753111373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmGx1FYo90dL2WOETAZNdmhMseM83XofBrzEl0Cu6l8=;
        b=XxG085giV5Q9g3goT1Ma/CTTGeKFmLPf7gsND5KKt2RqZgj9PRySPJ08Fjd/gOaqZ1
         r2/Bg3m4SOmPdOJZPkIExOJfL6+i8n6ic7j6y57mbggbJtPHlPjS0OUeHMz3h1Bqs7yu
         ZU7rexK45yk428qaCDLKdqepPpgndGc1LnzcKvrIE03abhyXV/bQnjCS1d7e1Nn7/Hce
         4yUYRHGr3myR5lEfOm030nGqkGC9KChU5bXxRHvacYvT4dfp8kh28QA5yWgQADbtXnUx
         vWu2lPjKoZmt6NKw7JxuetmhFwK1p5Bat09s3O0GV1JCe5pM8EdU/ZWmkDn03PD7tR27
         301w==
X-Forwarded-Encrypted: i=1; AJvYcCUzCYMzhOzT4nuZ+gKMzjV+LqvWpdmq5DRx4oyJajH6StKxsUz0hPzWGtnRpAaZW4CnoWbpg7VH/FxkWH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTzewE3piUEGpETFruCC846ZitiAbggrIGafzN7GQcWnM8Vqbj
	yXQ2ano+PJmGuiQe/sjHcESVNAQvZ1TVB2os6V+qmCKQc3HUGTqDsYShpwmyBSl+2wzNyxw5DA+
	xhf9M
X-Gm-Gg: ASbGnctpYP68Wv64DTpiClS6fZSkMS40SoDCPM0b6vqEbUPafByEJbR9IMPI71yFnPY
	Cfpb1FLvYTGX+F7f2rdpP2pKIi7/gNFAgCrEoLX1XxI/OzJwz89rAsw8Rzye/cIz0w0hlvrAxyW
	//bRvUGbCIdZ1AYANHbMGOEzrWjrfgdAZeQwYpaM3IWFsZRZTO1JQvVxosbnow5/AC7FUvnb6bY
	yb6644xphHCBrsxpHHhRuMVvFMu4vikWfF0IGW31GqpVTD8pYzvsIm7mcA2HFj4f1ZWtmqMY/NM
	yuO5LTThPqMygYjjpdlLZNAYQ1DQLtmLf21H/gBjaSZmhc3KyS+b0hpwEHUTb8xwa2MmhXphTp7
	t6ChCXH6NNdRDU0bL+Iu5lA==
X-Google-Smtp-Source: AGHT+IHDkILrpmq53HezSNzRRgdawyDIV7RK9otTY/uYj4XO1FTpqK75CEn4qcP3vC5c0pHVKLLWzg==
X-Received: by 2002:a05:6214:2e83:b0:704:a757:979 with SMTP id 6a1803df08f44-704a75709bcmr110052856d6.1.1752506572954;
        Mon, 14 Jul 2025 08:22:52 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70497db175dsm48395536d6.103.2025.07.14.08.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 08:22:52 -0700 (PDT)
Date: Mon, 14 Jul 2025 11:22:47 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@kernel.org>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: skip lru_note_cost() when scanning only file or anon
Message-ID: <20250714152247.GB991@cmpxchg.org>
References: <20250711155044.137652-1-roman.gushchin@linux.dev>
 <20250711172028.GA991@cmpxchg.org>
 <8734b2vcgr.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734b2vcgr.fsf@linux.dev>

On Fri, Jul 11, 2025 at 10:55:48AM -0700, Roman Gushchin wrote:
> Johannes Weiner <hannes@cmpxchg.org> writes:
> > The caveat with this patch is that, aside from the static noswap
> > scenario, modes can switch back and forth abruptly or even overlap.
> >
> > So if you leave a pressure scenario and go back to cache trimming, you
> > will no longer age the cost information anymore. The next spike could
> > be starting out with potentially quite stale information.
> >
> > Or say proactive reclaim recently already targeted anon, and there
> > were rotations and pageouts; that would be useful data for a reactive
> > reclaimer doing work at around the same time, or shortly thereafter.
> 
> Agree, but at the same time it's possible to come up with the scenario
> when it's not good.
>   A
>  / \
> B  C  memory.max=X
>   / \
>  D   E
> 
> Let's say we have a cgroup structure like this, we apply a lot
> of proactive anon pressure on E, then the pressure from on D from
> C's limit will be biased towards file without a good reason.

No, this is on purpose. D and E are not independent. They're in the
same memory domain, C. So if you want to reclaim C, and a subset of
its anon has already been pressured to resistance, then a larger part
of the reclaim candidates in C will need to come from file.

> Or as in my case, if a cgroup has memory.memsw.limit set and is
> thrashing, does it makes sense to bias the rest of the system
> into anon reclaim? The recorded cost can really large.
> 
> >
> > So for everything but the static noswap case, the patch makes me
> > nervous. And I'm not sure it actually helps in the cases where it
> > would matter the most.
> 
> I understand, but do you think it's acceptable with some additional
> conditions: e.g. narrow it down to only very high scanning priorities?
> Or !sc.may_swap case?
> 
> In the end, we have the following code in get_scan_count(), so at
> least on priority 0 we ignore all costs anyway.
>         if (!sc->priority && swappiness) {
>                 scan_balance = SCAN_EQUAL;
>                 goto out;
>         }
> 
> Wdyt?

I think relitigating a proven aging mechanism after half a decade in
production is going to be tough and require extensive testing.

If your primary problem is the cost of the locking, I'd focus on that.

> > It might make more sense to look into the cost (ha) of the cost
> > recording itself. Can we turn it into a vmstat item? That would make
> > it lockless, would get rstat batching up the cgroup tree etc. This
> > doesn't need to be 100% precise and race free after all.
> 
> Idk, maybe yes, but rstat flushing was a source of the issues as well
> and now it's mostly ratelimited, so I'm concerned that because of that
> we'll have sudden changes in the reclaim behavior every 2 seconds.

That's not a new hazard, though. prepare_scan_control() decisions are
already subject to this, as is the lru cost aging itself.


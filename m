Return-Path: <linux-kernel+bounces-760361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9F8B1EA26
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54FB189FC8D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0BB27702B;
	Fri,  8 Aug 2025 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a7+RFbUH"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC465F4F1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662569; cv=none; b=kCqlwKPflsWK2Gake5EcL/v6v0NGIV2NDuCucnwo0OeDuxiAKcnQj9rZaljD08KKBU6+I3tsiz3T/3gZIzOr0oaxOZ/8PXqdb2fhEdxQsd24kToTMOZZfpfbLhwoQm15Ld88CmchSoYYT3pxVnJf353E7pH2dUbodJFXr0Pr6Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662569; c=relaxed/simple;
	bh=nPpEcB3xoXpP57VpCWV2eN+0HZ0OObRrYVCQt8Igcp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5Sng/4r3b0tfmqJeS3UJQMeRHoK0L2nj/rioYGUC8/yukwJgWcxHkfq+/9yIrj/1yA22DoLFpTPAhl18BUmsiq9c67yb3CYoJW8aKpXpx0j1ej2nBv0l29IW1/V9WYrACwlJgOGnHqvxFWe26NW0ZNGQl/1DGgypH+mqZx4iMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a7+RFbUH; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b78d13bf10so2208200f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 07:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754662566; x=1755267366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VG/jc3uK17nl75KdjjSPz9XyI79UN0Loip6e0tTXadc=;
        b=a7+RFbUHA2HuAb6HUHSZsA6JBCT5xeSlSZFxalfPAJU52Sat0qciFfwfIhb3r4V/dW
         EAPo+tgBTEzPzzW9fAc3uNKnMsGWjfTjZqLK6IziXq7BHeVE3B3I70zdibOm3XBiNzBp
         35Bmu2smVpBCsvQEYuqsqDeOo9w3YjpkwvJtro4EEacKgpT2uUBQCCSOYsTn8Ab4FhJI
         4+NHQo+IzpYhNN3JIzSDr0We/e8hiTl0W+zUWTufkPYv6+75YyDGLkjNvhyWvW4ygLTh
         6vMOzYKhXHmQ5cYVMq/dm1jRqNhb4vWOiU5rCliu/L+eS8vofy2bSfbRs365pXqvIBBL
         sZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754662566; x=1755267366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VG/jc3uK17nl75KdjjSPz9XyI79UN0Loip6e0tTXadc=;
        b=amXQbyqg044+lMRjk8gi5zTm32a+cdAXXZYeznPf1oOaEz+I7aRoVsoNVqMBr0enf2
         IDcwOpLZrWNXXXB03ZZmFPH0W6HB0tQgH7jEuM+b4KNyutuRMHxVX0hVSKtX9zxZLvwL
         bqbYOnp4rzO2b+yLRG/bqok8Nkq6EFuYkOcigGrRrNI4mgQ+viqluK5b76kcKhycTkuN
         sVDgPtU4YkNKQVxAEgpvkDwvmmrJcLqN4CWnFWl94JUrDfsYYbmF3Y6/d9vM3fcgGZHk
         6BvkameWG2Jkby5x+L9iXKZnuKBrRUtZ1S7klEguxqaNWhgyoJ8n9OV5pKTl7AQJI7s4
         HUWA==
X-Forwarded-Encrypted: i=1; AJvYcCXFJoo6d41hTvlmKq53tWei+eRLBXG+1YfxIApMhupld/fvwWUnCxtPirfNO9AHnV+LRk6a/G7T7LRaxf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyerAK8RotzYHeD8+zciX4RnEQw5yhLNRSFrgoibQykeCb4QBIW
	JrEARKROyBxKpQa5H87S7vu3NSjzWFFfkBnt5+VYEgMzxaKcVJopiAaMPOwu6ROkGPY=
X-Gm-Gg: ASbGnctC5//JLxAZXUL4CqeHCPwbbr9qg9qPexRXmzo7W5B5+hueiyzanjCiZKyiuyH
	NKoMyxqL7Ifqm2qwFvpn9RgQ5DdcPYOSJfxeNokMXmHsf8qhT/UaAG+765rx8D3Vl1r9yKG+HlP
	44Wk07qeC7L4RfW9b1PWG7Ynj9+6f4dz6xG1eNqyU6BZS4F4URgb6zsiYwjhTtnzhix5PaJU6oB
	GIAOrRJ5aPS/KcIT/IifBkgn2Xv4X8l2b6yMBpNuOuOkrhtElpkLkydfNKYmTy+KOT7Ot7YkljA
	yECuPWKz6Dj7VIWNRj6sJLPHE2h9Nib3M7FJ1ajgGPMnnY/ozUDyLZKJUucF7pMnF3zNVRFNHML
	Ob5RiYZUNfZhI6Q2jL88rKHRboHR9+pMGzDg=
X-Google-Smtp-Source: AGHT+IGxfeBVNh4/aUszACoEq3XC4D6RxS7RyhP9MWdnuW1tiNhead0J00S+ncEYW0u2MGjwZKQcBQ==
X-Received: by 2002:a05:6000:188e:b0:3b8:d271:cdc5 with SMTP id ffacd0b85a97d-3b900b72d90mr2675104f8f.34.1754662565959;
        Fri, 08 Aug 2025 07:16:05 -0700 (PDT)
Received: from localhost (109-81-80-221.rct.o2.cz. [109.81.80.221])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3ad803sm30258751f8f.6.2025.08.08.07.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:16:05 -0700 (PDT)
Date: Fri, 8 Aug 2025 16:16:04 +0200
From: Michal Hocko <mhocko@suse.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/8] mm: Drop __GFP_DIRECT_RECLAIM flag if PF_MEMALLOC is
 set
Message-ID: <aJYGpPoaZwYZZ3Ze@tiehlicka>
References: <20250807075810.358714-1-urezki@gmail.com>
 <20250807075810.358714-9-urezki@gmail.com>
 <aJSU3O-pUnTnl_wP@tiehlicka>
 <aJX3zbr8QsIs1LOw@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJX3zbr8QsIs1LOw@pc636>

On Fri 08-08-25 15:12:45, Uladzislau Rezki wrote:
> On Thu, Aug 07, 2025 at 01:58:20PM +0200, Michal Hocko wrote:
> > On Thu 07-08-25 09:58:10, Uladzislau Rezki wrote:
> > > The memory allocator already avoids reclaim when PF_MEMALLOC is set.
> > > Clear __GFP_DIRECT_RECLAIM explicitly to suppress might_alloc() warnings
> > > to make more correct behavior.
> > 
> > Rather than chaning the gfp mask would it make more sense to update
> > might_alloc instead?
> > 
> Hm.. I was thinking about it but decided to drop the __GFP_DIRECT_RECLAIM
> instead just to guarantee a no-reclaim behaviour, as it is written now to
> the flag.
> 
> >From the other hand after this patch we would have some unneeded/dead
> checks(if i do not missing anything). For example:
> 
> [1]
>     WARN_ON_ONCE(!can_direct_reclaim);
>     /*
>      * PF_MEMALLOC request from this context is rather bizarre
>      * because we cannot reclaim anything and only can loop waiting
>      * for somebody to do a work for us.
>      */
>     WARN_ON_ONCE(current->flags & PF_MEMALLOC);
> [2]
>     /* no reclaim without waiting on it */
>     if (!(gfp_mask & __GFP_DIRECT_RECLAIM))
>         return false;
> 
>     /* this guy won't enter reclaim */
>     if (current->flags & PF_MEMALLOC)
>         return false;
> 
> [3]
>     /* Caller is not willing to reclaim, we can't balance anything */
>     if (!can_direct_reclaim)
>         goto nopage;
> 
>     /* Avoid recursion of direct reclaim */
>     if (current->flags & PF_MEMALLOC)
>         goto nopage;
> etc.
> 
> But, yes, might_alloc() can be modified also.

I do not have a _strong_ preference but my slight preference would be to
deal with this in might_alloc. Not sure what other think.

-- 
Michal Hocko
SUSE Labs


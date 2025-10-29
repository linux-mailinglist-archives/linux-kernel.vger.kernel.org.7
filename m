Return-Path: <linux-kernel+bounces-876593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D190FC1C201
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38990587EBE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF47B34B1A1;
	Wed, 29 Oct 2025 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZjqMVHQJ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C0C33CE95
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753048; cv=none; b=YZeHYZ3aPxSXhty0NOV5Hdt53cXovLO2ankbzMG+ezhzzHOvZ11zuS2Snn3l3hDvWpQNlXYnHIXw0p9mHHHjf0ZlccUfbNj+kFsSycqaMMTQA2q0G8fAPUKzyVW8y0cHDoIjgP8z7RjATRGAUP8m6gwGyuZXyqVw6n/rP/xcOzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753048; c=relaxed/simple;
	bh=ncyOs1TIMWDEMQ93v3fXnyW45bIYqohnPx9bW18lEgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQxa2WQX38rI8Xk7KJuP5eU25BNYwHhITlWO6jOViR1Z3gFNrvxqHRJ9R2bjfg08WHuQzMUhCgc8Wcl3uZjAUbvqA4QlEZmNKNYAhRhMLS/G1KFrzPuX8OHzefez+bddWtbvIjmloe1RmCA4a2BnZQZ+6SkIlvxnmG8LwjRWmns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZjqMVHQJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27eeafd4882so252325ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761753046; x=1762357846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XLSSejf9Ov/rf2h/EN+lGG7qdblHRyA6VuFB4BW8g0E=;
        b=ZjqMVHQJSLoxOFWz5cWBA5ZuWAIJ1g5Bbn+r1UNk0F8NvU+FIv8a3XV1xElXwQkfOY
         NIbkhIP3jE9t7qvw50Rr1BLwhBzETXgW1iIAM/P7TYDqPvai4in0E5RDnJNaFxp2ZXtB
         cwQvIbMcuby03uKtuxhu+Eo1hLOJj5yN7Gb4vlSj7zbhKR+3XXmVUkUMr2Iu4niseIdG
         dfPO+E7ItHE6ZxRRMoLwpsDBM5E3pQ0dYR4QTwUVCmQ/TsWJa+ovMkW8lxCDcCRUYbPk
         xOZSHCbsTstpg7fE0yrT7zdTH4MTHhKWlcgySC10/KKWGwNbSnsL/Pj8Z94J7YC0eJdi
         GMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753046; x=1762357846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLSSejf9Ov/rf2h/EN+lGG7qdblHRyA6VuFB4BW8g0E=;
        b=g3exrbvQIzHe6D6oshfXWuTrc8KO7rf/SE1C5FjSGhk6soKlkDFshAfzd1SaiDM/bE
         zMpgAAhr4p5+bzqyJQJy+jx0VmrGr/WTAiBcuVANpVm1zpyoPG8emn6aMiixPLLIS1l/
         OWBOgt/iLHSZCyveOY7xCPW8AFXlSnF8l5HJhaDci76+Ezglj81PU5A/PflkWiCHtbbh
         7u0C6Tn6iatAzh5H/UtDgAf0CA5C23jbLsuoSx7VAuB2O2px0rx729D9b/prJ0tHLMsq
         TirzUyGwQdTkSConxaLqhDZ+F6LKv7BWIYhpaqlGPiWr48zUwYtc7jTL1kGOo7KNK4/i
         O9OQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3TNT7oiHt/Y+szMVBy7Zel2X1D9EO5cwmZB5FaT0YxpCUMEO9+7d+ilpFTNUTmUg6hEkUJ1wKdQAj1OM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy64WkD44yrMGUu8qWROwqEivFaOyZIj6uxvknLkZwgXIwEk32H
	qMcfI1LMxrNglxJJr0EUguJxrNmGIgCe+8WmsjjF1lNP2KFiX1Tk+kuqn7sdmb8CZQ==
X-Gm-Gg: ASbGncs0Veh6pdL37anxO4SqyU/UmZ2403aGEre1pTkI7p5JfnDltnnjWEo6tyzGtKK
	Ft0J2h7XZSQEBG9I05I1VbxDLCXBJX5oMJHIez40U6EM3W5mNFduWrOvDBl4iWPTU50Icxeai0J
	jJFjsFHM5/jePazN6hNixYBqtN6V3CCTlmWfyIsAGf2YiYCoz8VRTgbu6PmSmFFdsQxZzxaICfL
	dBUbqiPcD558KyEvb8+UfsyvWEqBsA1ZYpt/jTXWmZtZ91+Jpg2hX+rlinJJEnLN9VWu4jRzuYx
	gUo5C6CY2gtg3/Fny8AEZvdIsnEPzHKqD28O/V92HPFMa082gTiKh0g4GQIt+/y/dDkDgYfLgUa
	1KRm04QaIkN0qYLsMqJMC2HlrT8sUu4HqNzg80k/c/T0sqZ/bL+IrBNT3ktMdbYRytUG2H+Qi/t
	rrrXtP5VztNF5xswobBaf+gD7HAd0ri5BY23ZufpzuuBWgnDXcvJSf
X-Google-Smtp-Source: AGHT+IGKPx3RLfl6Sze4h/1XGsrW5jd0bsQlcCb4PLueO0OQww5kd42KAzAHDNBGaMp7vPiY2Mr9QA==
X-Received: by 2002:a17:902:e783:b0:294:e585:1f39 with SMTP id d9443c01a7336-294e5852cfdmr2782045ad.14.1761753045254;
        Wed, 29 Oct 2025 08:50:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:2e51:8:9ab7:9682:d77a:f311])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41403fa75sm15654178b3a.28.2025.10.29.08.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:50:44 -0700 (PDT)
Date: Wed, 29 Oct 2025 08:50:39 -0700
From: Isaac Manjarres <isaacmanjarres@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
	kernel-team@android.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/mm_init: Fix hash table order logging in
 alloc_large_system_hash()
Message-ID: <aQI3z0x0gZ3T1fij@google.com>
References: <20251028191020.413002-1-isaacmanjarres@google.com>
 <dcceca48-bbdc-4318-8c07-94bb7c2f75ff@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcceca48-bbdc-4318-8c07-94bb7c2f75ff@redhat.com>

On Wed, Oct 29, 2025 at 11:03:18AM +0100, David Hildenbrand wrote:
> On 28.10.25 20:10, Isaac J. Manjarres wrote:
> > When emitting the order of the allocation for a hash table,
> > alloc_large_system_hash() unconditionally subtracts PAGE_SHIFT from
> > log base 2 of the allocation size. This is not correct if the
> > allocation size is smaller than a page, and yields a negative value
> > for the order as seen below:
> > 
> > TCP established hash table entries: 32 (order: -4, 256 bytes, linear)
> > TCP bind hash table entries: 32 (order: -2, 1024 bytes, linear)
> > 
> > Use get_order() to compute the order when emitting the hash table
> > information to correctly handle cases where the allocation size is
> > smaller than a page:
> > 
> > TCP established hash table entries: 32 (order: 0, 256 bytes, linear)
> > TCP bind hash table entries: 32 (order: 0, 1024 bytes, linear)
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org # v5.4+
> 
> This is a pr_info(), why do you think this is stable material? Just curious,
> intuitively I'd have said that it's not that critical.
> 

Hi David,

Thank you for taking the time to review this patch! I was just under the
impression that any bug--even those for informational logging--should be
sent to stable as well.

> > Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> > ---
> >   mm/mm_init.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index 3db2dea7db4c..7712d887b696 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -2469,7 +2469,7 @@ void *__init alloc_large_system_hash(const char *tablename,
> >   		panic("Failed to allocate %s hash table\n", tablename);
> >   	pr_info("%s hash table entries: %ld (order: %d, %lu bytes, %s)\n",
> > -		tablename, 1UL << log2qty, ilog2(size) - PAGE_SHIFT, size,
> > +		tablename, 1UL << log2qty, get_order(size), size,
> 
> So in case it's smaller than a page we now correctly return "0".

Correct.

> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> -- 
> Cheers
> 
> David / dhildenb

Thanks!
Isaac


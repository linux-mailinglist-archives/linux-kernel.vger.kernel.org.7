Return-Path: <linux-kernel+bounces-791218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55401B3B38E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 856897B94FB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742DD257826;
	Fri, 29 Aug 2025 06:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OgosZh56"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF13256C7E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 06:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756449681; cv=none; b=oyR91TLYwJZ9zViX4tdsJQu4rkeMWg7KhDTbsyhGgGM4AAWoej8f5V09z4iSiFgiURB30l/LuSbuFAHU31zrB7eVAyR11vpIK4PtCC/jpwQD9GI32t+28E0aqu9QUNWTUzTdUTo2VZtcZIaFIj7WULgKbeCK67bpTo7vkVoLwr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756449681; c=relaxed/simple;
	bh=bVBwqE+tWpLL3gtk4pcNTZ4t51SIxeiaUf1nZbx9ERg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rl2I2max8QuptLozzn/+pmMxq5dQC0e/Z6Lv2WPxUscigaqerEVHRrHay+lbLp+foPxx4fVyt3YfEGIGValYQZThAKrckXdHyw0Pjvskz0zjO4UKKhyRzJD2M1b4Al0JV9gBAahFuWtQPWic+1dWtfzdJMt1iOnymCJi6QCVZiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OgosZh56; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b05a59fso12147815e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 23:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756449677; x=1757054477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XtxEKMLsj3BJjqsAEZBWzNWvadtCwMY5ynf5Rrf8/UU=;
        b=OgosZh56AWBnGaiIJHrqhKQ+254zvnmH/ms3p4wjI5FO71s1zn9p8jQdLpm0FtheE0
         PdvKPwPpaXdztkQRLxJkjUfh+dklFzPnCG/8/m7Np2vvxMNsfdczkAEh02nphMe1nk6f
         eDpKwszrXFi3PtP1kHb6Qzy0ITmw7Jc12yRd+zKaL6qki4RQJZbz8CjMAulQ3gSaezPr
         MCSdIvqRMI2xJ6jS9JU2lP1GhLACQX1XIprXRAiqKVaQMwxk425w+1QWBaLo8mAJYHGh
         LFR/+sizy36tK9r81iXEsKgZFJZ2jOYFWVzY8uEt+76cN74a7vteh/JWvBJAFVVASHo0
         BJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756449677; x=1757054477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtxEKMLsj3BJjqsAEZBWzNWvadtCwMY5ynf5Rrf8/UU=;
        b=bKrqukCjO2uE7HrQv+uEjO5uIq4B4yjiIaX7OZyFfrnytAOMECljoS86O1lEw2OsCt
         xldASnJ4NXo9N9GZM4O/8TkZ9tfsY8RbK1wAuYsl5WGAXVpfTqDjgvTnUZMfZi5CnMOs
         qSRzBe0PuwGCxz+GCeg2n3PtwesVGimMn3/BY97VzK199QhuFRWahd+RUhYC92NVYArk
         SM6oqlvf3UozoO7q6WYIEUrMAeL+1cVtRQ+KUuleuor0BZ9KI+noErhhQTlw5NCwiakT
         ATRxYJHBSBUQc6voAlxFFrk6275+vTIecpRtoRII2Cl5hDur7nZdu0JvFbAwH9fpPr7Q
         wCJA==
X-Gm-Message-State: AOJu0YxiCTTStAWZBWbzrCxtAXGJFQ+JEx8C6yICujvJ31XjLVNTPJUt
	cFQ51489Hf/AJXDK8sbM5P2kRhMTbB3r5Dl1+UXohuq9pfDdIgDsPglfW1oQ/2CgRWmOB4jYC3t
	xIltz
X-Gm-Gg: ASbGncvBJh/sbwstwz23EraHAHjeMSAIH9yr+0fdrWlpZEL0qvT0CaCdFWSkNBO5xoo
	z+mfD7O+X6DSSsmYxQrgZR7zlGpn0cOihQQFBV4Wm8ydIwuzvZeqV+mUoe50AREZY0ZpcHfVfJS
	YWcD4tSwyWZJR0wOy/8OFuqayBMlmrJfR3y3X/QIG+e1UmDPfVC8rMJ/Q3WDUs1m9rg8Zyiv0CE
	t8DauwSecZqjiWxlcO4kqo8xrZn1naolbbhpuu34o7pfjsukAy4X+yXFHSdI6v4yghP9HbmflMF
	r8ny+IKo4zJaTK4Vy7cyTW/4Opu1i9SvUeMzYf+B8ZyEn1vkVVQVWSmbWJH2mH07G3Ei9pOvX/n
	Sm2or4U6cqvWc1gYd/cRa3c44hvpFemh7XbU=
X-Google-Smtp-Source: AGHT+IE0hHze9wkthqzJK2uktPvYHUKC/p/KFjdPRhXF7UeVVigicm5+RRf0+8vpXcyjUnGU8Of9lA==
X-Received: by 2002:a05:600c:4fc8:b0:45b:7be1:be1f with SMTP id 5b1f17b1804b1-45b7be1bfcemr30585535e9.32.1756449677281;
        Thu, 28 Aug 2025 23:41:17 -0700 (PDT)
Received: from localhost (109-81-86-254.rct.o2.cz. [109.81.86.254])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b7e8966acsm25768415e9.17.2025.08.28.23.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 23:41:16 -0700 (PDT)
Date: Fri, 29 Aug 2025 08:41:15 +0200
From: Michal Hocko <mhocko@suse.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Mel Gorman <mgorman@techsingularity.net>, kernel-dev@igalia.com,
	Helen Koike <koike@igalia.com>,
	Matthew Wilcox <willy@infradead.org>, NeilBrown <neilb@suse.de>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] mm/page_alloc: only set ALLOC_HIGHATOMIC for __GPF_HIGH
 allocations
Message-ID: <aLFLi4B5smIMY4u8@tiehlicka>
References: <20250814172245.1259625-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814172245.1259625-1-cascardo@igalia.com>

On Thu 14-08-25 14:22:45, Thadeu Lima de Souza Cascardo wrote:
> Commit 524c48072e56 ("mm/page_alloc: rename ALLOC_HIGH to
> ALLOC_MIN_RESERVE") is the start of a series that explains how __GFP_HIGH,
> which implies ALLOC_MIN_RESERVE, is going to be used instead of
> __GFP_ATOMIC for high atomic reserves.
> 
> Commit eb2e2b425c69 ("mm/page_alloc: explicitly record high-order atomic
> allocations in alloc_flags") introduced ALLOC_HIGHATOMIC for such
> allocations of order higher than 0. It still used __GFP_ATOMIC, though.
> 
> Then, commit 1ebbb21811b7 ("mm/page_alloc: explicitly define how __GFP_HIGH
> non-blocking allocations accesses reserves") just turned that check for
> !__GFP_DIRECT_RECLAIM, ignoring that high atomic reserves were expected to
> test for __GFP_HIGH.
> 
> This leads to high atomic reserves being added for high-order GFP_NOWAIT
> allocations and others that clear __GFP_DIRECT_RECLAIM, which is
> unexpected. Later, those reserves lead to 0-order allocations going to the
> slow path and starting reclaim.
> 
> >From /proc/pagetypeinfo, without the patch:
> 
> Node    0, zone      DMA, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
> Node    0, zone    DMA32, type   HighAtomic      1      8     10      9      7      3      0      0      0      0      0
> Node    0, zone   Normal, type   HighAtomic     64     20     12      5      0      0      0      0      0      0      0
> 
> With the patch:
> 
> Node    0, zone      DMA, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
> Node    0, zone    DMA32, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
> Node    0, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
> 
> Fixes: 1ebbb21811b7 ("mm/page_alloc: explicitly define how __GFP_HIGH non-blocking allocations accesses reserves")
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> Tested-by: Helen Koike <koike@igalia.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>

Yes, this makes a lot of sense to me. GFP_NOWAIT allocations should be
opportunistic and quick to fail rather than dipping into memory
reserves. We must have overlooked that during the review.
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2ef3c07266b3..bf52e3bef626 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4219,7 +4219,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
>  		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
>  			alloc_flags |= ALLOC_NON_BLOCK;
>  
> -			if (order > 0)
> +			if (order > 0 && (alloc_flags & ALLOC_MIN_RESERVE))
>  				alloc_flags |= ALLOC_HIGHATOMIC;
>  		}
>  
> -- 
> 2.47.2

-- 
Michal Hocko
SUSE Labs


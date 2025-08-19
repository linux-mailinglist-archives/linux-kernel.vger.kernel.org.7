Return-Path: <linux-kernel+bounces-774628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C71B2B536
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 02:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3671963EA7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D16D2FF;
	Tue, 19 Aug 2025 00:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EZIufOcn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F102110
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755562422; cv=none; b=aXo4Vp/NxefhbJYqn5oZAY29vP21M8CI8/hyZWiNojm4xbvjdZHN68oIGOO5q4X3cYBCidYJMUpNQd/maE/IQ9NMfLdfXFR7kkXjJWbLsQ7zCEXNEnYaobDWLI2hCsy/MEMc6DYTEjoTt1agn/EmarEk+WBJMEKzbCMxC0Llqvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755562422; c=relaxed/simple;
	bh=GBanHK/LR/pCa+c9vWGF20U2DJFnrBk8djjY08eqQnI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZNAwCpjYmgouYkocNwj7XnYTorvKbJJnVcc4YXWfJz3fX/yyYaeJrBp7N03WlLYPLqfjH5JryFMFWOUA/AWqbWdxtftRyMwKFVvsZrKbgTtTTdfiqVyTjJ/jxWnXJeWtrmcx5cQTKtxuD6gXvinzuaXv8qaVpCL1gDrCTPhNtpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EZIufOcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7BDC4CEEB;
	Tue, 19 Aug 2025 00:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755562421;
	bh=GBanHK/LR/pCa+c9vWGF20U2DJFnrBk8djjY08eqQnI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EZIufOcnq3zWlRpA9rbGk9p/f1cZCEKsXyvKj1S+SVM+4GuekTaYnAQeUabIkSBFl
	 p2ErIcETq0LI3Sm8ulCEAYOuI0sg+jYbSF83JwcVjHQjlfy36QDSW6S1Ls4+Soq0lK
	 Qjm0I4kbptksi3V8jY59h3Ip/yTyvcszwGZTBA+w=
Date: Mon, 18 Aug 2025 17:13:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Chris Mason <clm@fb.com>,
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@gogle.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, Zi
 Yan <ziy@nvidia.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH] mm/page_alloc: Occasionally relinquish zone lock in
 batch freeing
Message-Id: <20250818171340.2f4ce3356f1cda59acecab57@linux-foundation.org>
In-Reply-To: <20250818185804.21044-1-joshua.hahnjy@gmail.com>
References: <20250818185804.21044-1-joshua.hahnjy@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 11:58:03 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> While testing workloads with high sustained memory pressure on large machines
> (1TB memory, 316 CPUs), we saw an unexpectedly high number of softlockups.
> Further investigation showed that the lock in free_pcppages_bulk was being held
> for a long time, even being held while 2k+ pages were being freed.
> 
> Instead of holding the lock for the entirety of the freeing, check to see if
> the zone lock is contended every pcp->batch pages. If there is contention,
> relinquish the lock so that other processors have a change to grab the lock
> and perform critical work.
> 
> In our fleet,

who is "our"?

> we have seen that performing batched lock freeing has led to
> significantly lower rates of softlockups, while incurring relatively small
> regressions (relative to the workload and relative to the variation).
> 
> The following are a few synthetic benchmarks:
> 
> Test 1: Small machine (30G RAM, 36 CPUs)
> 
> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
>
> ...
>
> @@ -1267,12 +1270,22 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  
>  			/* must delete to avoid corrupting pcp list */
>  			list_del(&page->pcp_list);
> +			batch -= nr_pages;
>  			count -= nr_pages;
>  			pcp->count -= nr_pages;
>  
>  			__free_one_page(page, pfn, zone, order, mt, FPI_NONE);
>  			trace_mm_page_pcpu_drain(page, order, mt);
> -		} while (count > 0 && !list_empty(list));
> +		} while (batch > 0 && !list_empty(list));
> +
> +		/*
> +		 * Prevent starving the lock for other users; every pcp->batch
> +		 * pages freed, relinquish the zone lock if it is contended.
> +		 */
> +		if (count && spin_is_contended(&zone->lock)) {
> +			spin_unlock_irqrestore(&zone->lock, flags);
> +			spin_lock_irqsave(&zone->lock, flags);
> +		}
>  	}

Pretty this isn't.

Sigh, we do so much stuff here and in __free_one_page().

What sort of guarantee do we have that the contending task will be able
to get in and grab the spinlock in that tiny time window?


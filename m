Return-Path: <linux-kernel+bounces-767423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E4AB2540B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500925A5EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A3B23D7E3;
	Wed, 13 Aug 2025 19:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eRlFm3R1"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F41D1DF725
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755114164; cv=none; b=CU+ZMh98csrUCGENwx8m8eED+T7vgq2sxdnQQaNzwB+8pdYRsWPWwcxIfxnXe41w0hKLH+FBLBoyoAhkd3lfWCvp/btRGj3OSWnEhb7/baAoahco1mYLsUlUJ9ybYHlJWYlq9jBN7FX4qEcEbFT6CefI004ShVZg4PMgKl3byn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755114164; c=relaxed/simple;
	bh=EMxQwjXxrN6fg9iPamssqHdnRiH2atD/IaM52smEcLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjhKSHFLH6QRgeBGgHGWRcDjEJojv8CMCy9Yb7VODeDZvCw+lRP9YVFKael5cgtFR0WNZqdFDfxC5ecFxe1oaBAQ2iGHcA+GJ3hknWqL2yazaXrOsNpK7lu+IE83QEz7Z7thpNliNk8rxfoAUX7r/Q5Q24vrlZl6+A3rHgO3RhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eRlFm3R1; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 13 Aug 2025 12:42:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755114159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Z/eePXC2A5sEVuC0Nhf78dOfoyN48EYXcyjIyPQBt0=;
	b=eRlFm3R1unVIbzm+JsRV1NWkTEIXwIeM0Zc3P05QaNBPq2PVN7sYzS7L+exAbXrcYE1WZ8
	tbIzMGYajQrZ5tybXZXGtDKXqDNKdBLb2GOzPw/foPtP0LZeRuP1TLDswwWut+dyvw/tvE
	Ck9wdne5LqpkOPHDz6ydt1dRWAGZw9Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Chris Li <chrisl@kernel.org>
Cc: SeongJae Park <sj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Takero Funaki <flintglass@gmail.com>, 
	Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page
 as-is
Message-ID: <uo6vtumoy4txklyqy4njitf5ex4eanudncicbbzknmuowopd7v@jm4ao4qapiza>
References: <20250812170046.56468-1-sj@kernel.org>
 <CAF8kJuN1BH0rqC6czj9govNOugd_5K9ijYcxbWYpEpUdQKn0-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF8kJuN1BH0rqC6czj9govNOugd_5K9ijYcxbWYpEpUdQKn0-A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 13, 2025 at 10:07:18AM -0700, Chris Li wrote:
> 
> If you store uncompressed data in the zpool, zpool has metadata
> overhead, e.g. allocating the entry->handle for uncompressed pages.
> If the page is not compressed, another idea is just skip the zpool,
> store it as a page in the zswap entry as page. We can make a union of
> entry->handle and entry->incompressble_page. If entry->length ==
> PAGE_SIZE, use entry->incompressable_page as a page.

The main problem being solved here is to avoid the scenario where the
incompressible pages are being rotated in LRUs and zswapped multiple
times and wasting CPU on compressing incompressible pages. SJ's approach
solves the issue but with some memory overhead (zswap entry). With your
suggestion and to solve the mentioned issue, we will need to change some
core parts of reclaim (__remove_mapping()), LRU handling (swap cache
pages not in LRUs) and refault (putting such pages back in LRU and
should it handle read and write faults differently). So, the cons of
that approach is more complex code.

Personally I would prefer a simple solution with some overhead over a
more complicated and error prone solution without overhead. Or maybe you
have a more simplied approach instead?



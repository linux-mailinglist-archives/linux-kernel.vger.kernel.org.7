Return-Path: <linux-kernel+bounces-790402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D91B3A691
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC62D16475C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A968E33470A;
	Thu, 28 Aug 2025 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tZaXxXp3"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E481D322C89
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398948; cv=none; b=N77MqZddZY6D3OxXB/DEKQT8xuEs6ZeeIIl6B2pT/6oF91vcjvaJ25PMzVcOE3rgM70Y/P15+gbQ1zP8HBUtMnGITvqPBt5+61QfLl14F2sgaA7VprQ0ifoTZlgyLdFO5Oh8tE0GIiEdq2if8NW/NO0oMXNVgbX8UPVqa93pjg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398948; c=relaxed/simple;
	bh=ZuwnH5d6bjO34E6L2d8hLdT0uh9GBCJTl8RJceRWO0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnV2KoXmMYYMvACwLXtzdr/uJ3c9VlT9h/AgaKGLYSlGcFnkghOjwUhVAPWL8EtzDRPjWnf+pt8y+BVsDLV0t0QrETUz+VNwAqDMfm2YhGQn7eCNJs1Rl0/VQBrp088sTzlr1x3qh/xbIlawYbJGPyZBcN/Zrcf6ek/nCxrav7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tZaXxXp3; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 28 Aug 2025 09:35:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756398944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nXD1aqPsvjZ+PHO/PDPe12byUVxVGd8Wfqus3NDP+MY=;
	b=tZaXxXp3ewliIwnr1Cp7mjd2qr/VuHiqSZ3fsUVyIIOFfNTTbqbrrOtdu2fqFEMPM8xSHM
	b3eho+0W1JIA8Q4G6pil6v2kaegZhDWatrx/LDEyar9I0GX07lgvRZ5x2U67GxM9f9UHI9
	Fh25B0/HcDnT1E0suij4FQLjHzd5lP8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Yueyang Pan <pyyjason@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Usama Arif <usamaarif642@gmail.com>, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mm/show_mem: Add trylock while printing alloc info
Message-ID: <5ce6yn4iml5tk5zpf73gbxk6z244bkchwuxfpvuervyh2zlqlc@7sanekvjpglm>
References: <cover.1756318426.git.pyyjason@gmail.com>
 <7e2bc96faab1a338829e549246189ad96e6c866b.1756318426.git.pyyjason@gmail.com>
 <20250827150619.4e468e68988f224f9f9bea6f@linux-foundation.org>
 <aLAUhXeRVWzLCNNd@devbig569.cln6.facebook.com>
 <c8db3486-4f13-4922-a270-1fbf61e2d782@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8db3486-4f13-4922-a270-1fbf61e2d782@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 28, 2025 at 10:41:23AM +0200, Vlastimil Babka wrote:
> > 
> > I was not aware of interrupt context before. I will change to test-and-set 
> > lock in the next version.
> 
> Perhaps simply spinlock_t with spin_trylock()?
> 

Will lockdep complain that this spinlock is taken in non-irq and irq
context without disabling irqs?


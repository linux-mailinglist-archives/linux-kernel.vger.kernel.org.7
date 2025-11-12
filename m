Return-Path: <linux-kernel+bounces-897588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCCCC532DE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F02AF34FEAA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EE4303A07;
	Wed, 12 Nov 2025 15:39:04 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45423288D2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961944; cv=none; b=hSqK/o4DMG5rmdSrz70sT54fZaCADYsaUy5+B50EtVDBMy/DDKPC1/wpAy9kE2O5ffWxmZKGYWtzMi2C8g17QOw8ys5zuPR9LsLq4+XT8kw9/jCwb6fqqL1ziHVr0iqBw5p+GzjbJZXrg7pFT0nhsrXB2G2aaUcQcyrt1BHhZvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961944; c=relaxed/simple;
	bh=3onvqlSsuWuni/WGkXh7GDnMT+2dKmG7QsmuDLLgxgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q28ksd6WSa1tVYvWcSj/XTvulwX9pUBjcE4J5bEmpw11IcddFClYQVeRGyR4s9TRYOUOZsAV+HSgVNUW9CLzvrjFkdAO+wFqx4bfxwplWX8UvVQXWDw6ufFpQz/6dP5CgTlThBPGtHpIClPEpJXO3duXHlCGtI9LR97/VwVyDy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 07E206732A; Wed, 12 Nov 2025 16:38:56 +0100 (CET)
Date: Wed, 12 Nov 2025 16:38:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Eric Biggers <ebiggers@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] mempool: fix a wakeup race when sleeping for
 elements
Message-ID: <20251112153855.GA7209@lst.de>
References: <20251111135300.752962-1-hch@lst.de> <20251111135300.752962-7-hch@lst.de> <dec19492-bc23-49a0-a2b0-1cd8b5c7726e@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dec19492-bc23-49a0-a2b0-1cd8b5c7726e@suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 12, 2025 at 11:53:39AM +0100, Vlastimil Babka wrote:
> > +alloc:
> >  	element = remove_element(pool);
> >  	spin_unlock_irqrestore(&pool->lock, flags);
> >  
> > @@ -406,13 +407,17 @@ static void *mempool_alloc_from_pool(struct mempool *pool, gfp_t gfp_mask)
> >  		DEFINE_WAIT(wait);
> >  
> >  		prepare_to_wait(&pool->wait, &wait, TASK_UNINTERRUPTIBLE);
> > +		if (pool->curr_nr) {
> > +			finish_wait(&pool->wait, &wait);
> > +			goto alloc;
> > +		}
> >  		spin_unlock_irqrestore(&pool->lock, flags);
> I think the race already cannot exist, thanks to the pool->lock being
> unlocked after prepare_to_wait()?
> The freeing path can't bump pool->curr_nr without the lock, so the condition
> you added can't even be true, no?

You're right, I'll drop this again.



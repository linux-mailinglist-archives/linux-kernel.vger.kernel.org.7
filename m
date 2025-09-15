Return-Path: <linux-kernel+bounces-817681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAEAB5854D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01251B220C5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA70218AA0;
	Mon, 15 Sep 2025 19:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H2T0lmJ0"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93008320F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757964799; cv=none; b=VJDT/mzttBS1zG62Fp/J8+yCBT8NEHVYslYVYZmIQKWJn6q2Dg6c1IjXMUL96V3dr5/ODeCgrUy9dY9NyfmLfH9bTLhrohRpT2iCN3h62ySC0wLyQDQrZUiS5H4hxHDVaL0hCEEU1uf81ifD/5p7Wq0DkghEoJuxr6dOxTSdTr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757964799; c=relaxed/simple;
	bh=VaeojEuJd5bJmzU1Yq3QuZM+3aR2f2ZrpUcvGqH1okk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nlo+BoTEJK8Nb67qEbu9iDq8xl9/MFwUZGNd6W1Kemj6X7fC/rDysxcel95uBEGQFRVe4OONjJlis35LywpSUN1eOPKn0JLvpREJ1/0eL3MIGnhzPpp9z2Pw0uLEGPj0WlBet+518iynSb2RRW9H4SP6aUlyVqEh2DbBohvC3n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H2T0lmJ0; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 15 Sep 2025 19:33:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757964793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UVv4w1jtg4ojHbR2lrrdyh2MgDQjPgMUDgj4NVC4Ao8=;
	b=H2T0lmJ0fQrfvBo5DS9iOk5zIjLls+m1jXijYlY+VEb+TQfas+wpUQiArrjWuFrjcnxTFP
	+wS/uAp1LZ/LCVEw6gphTx8jOZgd8JmpL6ADyUAUHqZMViz14TRa/+J2rm8YEfXsOpruWK
	wtHFI4O8MruNWckyp0Jq1xOBw+R2eDo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: zswap: interact directly with zsmalloc
Message-ID: <pduxj3r37ufwsbe2jxtx262dikjbbnwmzkagwfot5j4tajxmaf@4z3slwpmdsl4>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <20250829162212.208258-2-hannes@cmpxchg.org>
 <r3dzlbqyvhaho5zuac7eba6pxz47zy3cz4lopxza3ls3ibadlh@6evm5aryyuxp>
 <20250909150156.GB1474@cmpxchg.org>
 <46xtfjznexpdlemxjwykin5k74oqomedb2fyli5jrb4xnquuke@ztcmxhmhlkx7>
 <20250910134240.GA1111@cmpxchg.org>
 <f5hn4awbmkelckl6khlaosw3tbfrwzvf5l7kn6mnqpbastsdnh@77mqvfjzyfys>
 <20250915153640.GA828739@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915153640.GA828739@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 15, 2025 at 11:36:40AM -0400, Johannes Weiner wrote:
> On Thu, Sep 11, 2025 at 02:30:31PM +0000, Yosry Ahmed wrote:
> > On Wed, Sep 10, 2025 at 09:42:40AM -0400, Johannes Weiner wrote:
> > > @@ -314,6 +314,10 @@ static struct zswap_pool *__zswap_pool_create_fallback(void)
> > >  		}
> > >  	}
> > >  
> > > +	/* Kconfig bug? */
> > > +	if (WARN_ON(!crypto_has_acomp(zswap_compressor, 0, 0)))
> > > +		return NULL;
> > > +
> > >  	return zswap_pool_create(zswap_compressor);
> > >  }
> > 
> > Sure, looks good, although I think it's clearer (and smaller diff) to
> > preserve the old structure instead, up to you:
> > 
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index c88ad61b232cf..bbfc087792648 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -300,18 +300,21 @@ static struct zswap_pool *zswap_pool_create(char *compressor)
> > 
> >  static struct zswap_pool *__zswap_pool_create_fallback(void)
> >  {
> > -       if (!crypto_has_acomp(zswap_compressor, 0, 0) &&
> > +       bool has_comp = crypto_has_acomp(zswap_compressor, 0, 0);
> > +
> > +       if (!has_comp &&
> >             strcmp(zswap_compressor, CONFIG_ZSWAP_COMPRESSOR_DEFAULT)) {
> >                 pr_err("compressor %s not available, using default %s\n",
> >                        zswap_compressor, CONFIG_ZSWAP_COMPRESSOR_DEFAULT);
> >                 param_free_charp(&zswap_compressor);
> >                 zswap_compressor = CONFIG_ZSWAP_COMPRESSOR_DEFAULT;
> > -               if (!crypto_has_acomp(zswap_compressor, 0, 0)) {
> > -                       pr_err("default compressor %s not available\n",
> > -                              zswap_compressor);
> > -                       zswap_compressor = ZSWAP_PARAM_UNSET;
> > -                       return NULL;
> > -               }
> > +               has_comp = crypto_has_acomp(zswap_compressor, 0, 0);
> > +       }
> > +       if (!has_comp) {
> > +               pr_err("default compressor %s not available\n",
> > +                      zswap_compressor);
> > +               zswap_compressor = ZSWAP_PARAM_UNSET;
> > +               return NULL;
> >         }
> 
> No objection to moving the branch instead of adding another one. I'd
> just like to retain the warning, since it shouldn't happen. And ditch
> the bool, IMO it pointlessly splits the test from the consequences.
> 
> If you're fine with this Yosry, Andrew can you please fold it?

LGTM, with this folded:
Acked-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Thanks!

> 
> ---
> 
> From b8fa4c7edd4f3c84853665b47acec8cebb4f4899 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Mon, 15 Sep 2025 10:56:15 -0400
> Subject: [PATCH] mm: zswap: interact directly with zsmalloc fix
> 
> Yosry points out that the default compressor check only applies when
> something else is configured and we fall back, but not if it was
> configured out of the box but isn't available. Move the test. Kconfig
> should not permit this, so replace the pr_err() with a WARN.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/zswap.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index cba7077fda40..c1af782e54ec 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -309,12 +309,12 @@ static struct zswap_pool *__zswap_pool_create_fallback(void)
>  		       zswap_compressor, CONFIG_ZSWAP_COMPRESSOR_DEFAULT);
>  		param_free_charp(&zswap_compressor);
>  		zswap_compressor = CONFIG_ZSWAP_COMPRESSOR_DEFAULT;
> -		if (!crypto_has_acomp(zswap_compressor, 0, 0)) {
> -			pr_err("default compressor %s not available\n",
> -			       zswap_compressor);
> -			zswap_compressor = ZSWAP_PARAM_UNSET;
> -			return NULL;
> -		}
> +	}
> +
> +	/* Default compressor should be available. Kconfig bug? */
> +	if (WARN_ON_ONCE(!crypto_has_acomp(zswap_compressor, 0, 0))) {
> +		zswap_compressor = ZSWAP_PARAM_UNSET;
> +		return NULL;
>  	}
>  
>  	return zswap_pool_create(zswap_compressor);
> -- 
> 2.51.0
> 


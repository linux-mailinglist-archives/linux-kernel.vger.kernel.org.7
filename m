Return-Path: <linux-kernel+bounces-812274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84600B53554
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEAA17ABD02
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B0C33CE8F;
	Thu, 11 Sep 2025 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Af4pJ3d4"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092DE136351
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601041; cv=none; b=rBQ8Mb5JODJHKMgj06P4wWgzu2x6+veREraja72t6kgQCQkY6keR4cjd0tCCQq0XWesy7GH/aSuyi4ZzY0yrtiMcoyeXFsxVEH0hlakIy2PfHOu9xgWYrjp9GaKBUF/vwS/vPyau9OqN2C0T+IHyvv0pguBBpEq/KRwle1Bz0/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601041; c=relaxed/simple;
	bh=pqyfwB94mn5F08T72bRZ17AuLDDDWAbJHDGZr/i2Xqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAoNhVj0qlc2rnN7KnDTIGlxuUzj7boriM+BoW9rFe6PRf1d6yUBab5WIdirlBCoZE65sO9sfTmOWtWdOVtB/4j+09zib5JDIwWlDXWcWq1XhWfdgCSnXwxRpScy39QvKvv6E5CcrXkigkxa/uPE2aL3BplbguU8PqxIskpyK0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Af4pJ3d4; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 11 Sep 2025 14:30:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757601035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ggZBAjhYjIflaDH1RktcBl45HG8nhXAZG/qjhNo9vw=;
	b=Af4pJ3d4AxqymMzi7MWDMC/qm2UPqpLWI0/cF/PpxmZJf7yE05u1WNdLdZ/wIdEECzISNb
	BnvqOi6giWGl8XkKWZK2NZRqleJDA8D5eZi5Ii65UFHVdvXJwrQTC7WXEu+bUNFqLXyfgR
	oPiPfo1gBKEoAQ0lNb1zkpt7wyaqU/E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: zswap: interact directly with zsmalloc
Message-ID: <f5hn4awbmkelckl6khlaosw3tbfrwzvf5l7kn6mnqpbastsdnh@77mqvfjzyfys>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <20250829162212.208258-2-hannes@cmpxchg.org>
 <r3dzlbqyvhaho5zuac7eba6pxz47zy3cz4lopxza3ls3ibadlh@6evm5aryyuxp>
 <20250909150156.GB1474@cmpxchg.org>
 <46xtfjznexpdlemxjwykin5k74oqomedb2fyli5jrb4xnquuke@ztcmxhmhlkx7>
 <20250910134240.GA1111@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910134240.GA1111@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 10, 2025 at 09:42:40AM -0400, Johannes Weiner wrote:
> On Tue, Sep 09, 2025 at 08:10:43PM +0000, Yosry Ahmed wrote:
> > On Tue, Sep 09, 2025 at 04:01:56PM +0100, Johannes Weiner wrote:
> > > On Fri, Sep 05, 2025 at 06:53:15PM +0000, Yosry Ahmed wrote:
> > > > On Fri, Aug 29, 2025 at 05:15:26PM +0100, Johannes Weiner wrote:
> > > > > zswap goes through the zpool layer to enable runtime-switching of
> > > > > allocator backends for compressed data. However, since zbud and z3fold
> > > > > were removed in 6.15, zsmalloc has been the only option available.
> > > > > 
> > > > > As such, the zpool indirection is unnecessary. Make zswap deal with
> > > > > zsmalloc directly. This is comparable to zram, which also directly
> > > > > interacts with zsmalloc and has never supported a different backend.
> > > > > 
> > > > > Note that this does not preclude future improvements and experiments
> > > > > with different allocation strategies. Should it become necessary, it's
> > > > > possible to provide an alternate implementation for the zsmalloc API,
> > > > > selectable at compile time. However, zsmalloc is also rather mature
> > > > > and feature rich, with years of widespread production exposure; it's
> > > > > encouraged to make incremental improvements rather than fork it.
> > > > > 
> > > > > In any case, the complexity of runtime pluggability seems excessive
> > > > > and unjustified at this time. Switch zswap to zsmalloc to remove the
> > > > > last user of the zpool API.
> > > > > 
> > > > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > > ---
> > > > [..]
> > > > > @@ -315,52 +292,29 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
> > > > >  error:
> > > > >  	if (pool->acomp_ctx)
> > > > >  		free_percpu(pool->acomp_ctx);
> > > > > -	if (pool->zpool)
> > > > > -		zpool_destroy_pool(pool->zpool);
> > > > > +	if (pool->zs_pool)
> > > > > +		zs_destroy_pool(pool->zs_pool);
> > > > >  	kfree(pool);
> > > > >  	return NULL;
> > > > >  }
> > > > >  
> > > > >  static struct zswap_pool *__zswap_pool_create_fallback(void)
> > > > >  {
> > > > > -	bool has_comp, has_zpool;
> > > > > -
> > > > > -	has_comp = crypto_has_acomp(zswap_compressor, 0, 0);
> > > > > -	if (!has_comp && strcmp(zswap_compressor,
> > > > > -				CONFIG_ZSWAP_COMPRESSOR_DEFAULT)) {
> > > > > +	if (!crypto_has_acomp(zswap_compressor, 0, 0) &&
> > > > > +	    strcmp(zswap_compressor, CONFIG_ZSWAP_COMPRESSOR_DEFAULT)) {
> > > > >  		pr_err("compressor %s not available, using default %s\n",
> > > > >  		       zswap_compressor, CONFIG_ZSWAP_COMPRESSOR_DEFAULT);
> > > > >  		param_free_charp(&zswap_compressor);
> > > > >  		zswap_compressor = CONFIG_ZSWAP_COMPRESSOR_DEFAULT;
> > > > > -		has_comp = crypto_has_acomp(zswap_compressor, 0, 0);
> > > > > -	}
> > > > > -	if (!has_comp) {
> > > > > -		pr_err("default compressor %s not available\n",
> > > > > -		       zswap_compressor);
> > > > > -		param_free_charp(&zswap_compressor);
> > > > > -		zswap_compressor = ZSWAP_PARAM_UNSET;
> > > > > -	}
> > > > > -
> > > > > -	has_zpool = zpool_has_pool(zswap_zpool_type);
> > > > > -	if (!has_zpool && strcmp(zswap_zpool_type,
> > > > > -				 CONFIG_ZSWAP_ZPOOL_DEFAULT)) {
> > > > > -		pr_err("zpool %s not available, using default %s\n",
> > > > > -		       zswap_zpool_type, CONFIG_ZSWAP_ZPOOL_DEFAULT);
> > > > > -		param_free_charp(&zswap_zpool_type);
> > > > > -		zswap_zpool_type = CONFIG_ZSWAP_ZPOOL_DEFAULT;
> > > > > -		has_zpool = zpool_has_pool(zswap_zpool_type);
> > > > > -	}
> > > > > -	if (!has_zpool) {
> > > > > -		pr_err("default zpool %s not available\n",
> > > > > -		       zswap_zpool_type);
> > > > > -		param_free_charp(&zswap_zpool_type);
> > > > > -		zswap_zpool_type = ZSWAP_PARAM_UNSET;
> > > > > +		if (!crypto_has_acomp(zswap_compressor, 0, 0)) {
> > > > > +			pr_err("default compressor %s not available\n",
> > > > > +			       zswap_compressor);
> > > > > +			zswap_compressor = ZSWAP_PARAM_UNSET;
> > > > > +			return NULL;
> > > > > +		}
> > > > 
> > > > Hmm it seems like there may be a change of behavior here. If
> > > > zswap_compressor == CONFIG_ZSWAP_COMPRESSOR_DEFAULT at the beginning and
> > > > crypto_has_acomp() returns false, the old code will go into the second
> > > > if (!has_comp) block, printing an error, freeing the string, and setting
> > > > zswap_compressor to ZSWAP_PARAM_UNSET, then we eventually return NULL.
> > > > 
> > > > It seems like the new code will just call zswap_pool_create() anyway.
> > > > 
> > > > Am I missing something here?
> > > 
> > > I don't think that scenario is possible, due to the way the Kconfig
> > > works. Whatever backend I select for CONFIG_ZSWAP_COMPRESSOR_DEFAULT
> > > pulls in the crypto module as built-in/=y. It should always be there.
> > 
> > What if none of the CONFIG_ZSWAP_COMPRESSOR_DEFAULT_* options are
> > selected (i.e. empty string)? Also, can CONFIG_ZSWAP_COMPRESSOR_DEFAULT
> > be set directly to an arbitrary string?
> 
> No, that isn't possible. It's a multiple choice symbol that forces one
> of the options and has a valid default value. I tried to made it an
> empty string in .config by hand, but oldconfig restored it; if I
> remove the DEFAULT_* line entirely, oldconfig reprompts.

Good to know, I honestly never really know how kconfig handles these
things.

> 
> > I would prefer if the code behavior did not change to rely on the config
> > possibilities.
> 
> How about this on top?
> 
> From f842e1338594c4b78456f878731a261a074d5277 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Wed, 10 Sep 2025 09:00:01 -0400
> Subject: [PATCH] yosry
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/zswap.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index c88ad61b232c..991fe380c61e 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -314,6 +314,10 @@ static struct zswap_pool *__zswap_pool_create_fallback(void)
>  		}
>  	}
>  
> +	/* Kconfig bug? */
> +	if (WARN_ON(!crypto_has_acomp(zswap_compressor, 0, 0)))
> +		return NULL;
> +
>  	return zswap_pool_create(zswap_compressor);
>  }

Sure, looks good, although I think it's clearer (and smaller diff) to
preserve the old structure instead, up to you:

diff --git a/mm/zswap.c b/mm/zswap.c
index c88ad61b232cf..bbfc087792648 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -300,18 +300,21 @@ static struct zswap_pool *zswap_pool_create(char *compressor)

 static struct zswap_pool *__zswap_pool_create_fallback(void)
 {
-       if (!crypto_has_acomp(zswap_compressor, 0, 0) &&
+       bool has_comp = crypto_has_acomp(zswap_compressor, 0, 0);
+
+       if (!has_comp &&
            strcmp(zswap_compressor, CONFIG_ZSWAP_COMPRESSOR_DEFAULT)) {
                pr_err("compressor %s not available, using default %s\n",
                       zswap_compressor, CONFIG_ZSWAP_COMPRESSOR_DEFAULT);
                param_free_charp(&zswap_compressor);
                zswap_compressor = CONFIG_ZSWAP_COMPRESSOR_DEFAULT;
-               if (!crypto_has_acomp(zswap_compressor, 0, 0)) {
-                       pr_err("default compressor %s not available\n",
-                              zswap_compressor);
-                       zswap_compressor = ZSWAP_PARAM_UNSET;
-                       return NULL;
-               }
+               has_comp = crypto_has_acomp(zswap_compressor, 0, 0);
+       }
+       if (!has_comp) {
+               pr_err("default compressor %s not available\n",
+                      zswap_compressor);
+               zswap_compressor = ZSWAP_PARAM_UNSET;
+               return NULL;
        }

        return zswap_pool_create(zswap_compressor);
>  
> -- 
> 2.51.0
> 


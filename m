Return-Path: <linux-kernel+bounces-803603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0F5B462E5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49427189C4F9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD9029D297;
	Fri,  5 Sep 2025 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rWJfsIBe"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8282798E3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098406; cv=none; b=YeDNLMOCtxIQRVIRUQyzZ808ws4VTAK2vLT2Ug5ITGnagF4t6XlClwfoYKLAVGiEy8ok/hPxugelWj+NvauSvArBBB+7tYLI0VijN5K4CPJE8h0Zgh4fsy3VWTkMlk2wliYJjvn25GCUipskRGicwbJXcTTJjmAAxqQ5c/clso4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098406; c=relaxed/simple;
	bh=oPb2TPYHfeo8cqmRDO9/low/vym6O0VnZi1tHBBZWrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JodS2SJwH7FfyNkt/tuuB7Z/CSYKzjbHDFJQ2/TxLYSAMfA5R+c9CmHzBIFkC0/P2eqqxLxjqs5RP/U86YCvwIMrH4IexV5PyykhDL8X8DFQ2MBqcJoZJZM+H3S7f+ilJ0zGCaByKeDhNF305fU6o06yvBd19mccoj0KDOhMJoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rWJfsIBe; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 5 Sep 2025 18:53:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757098399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GFrZHAdnL5vuRC8mNJl86GVBWYQcUC0CUwEWAjwZ5Os=;
	b=rWJfsIBelsOcCsUfbSOTUwgGLrFU8FzW4E9TiZ9L/wgQQu/tUmCpA8DJ0fflwpGj8HHmDz
	maqoRNr1+3dC7Ps/M2hGAZKsoUVvDsQxnHa9tApDxg36f84fDG3H/yatr8TuAx9EJ9xjjn
	c8kxqnXdPY2O/abRQ0N3FGMkKPudomg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: zswap: interact directly with zsmalloc
Message-ID: <r3dzlbqyvhaho5zuac7eba6pxz47zy3cz4lopxza3ls3ibadlh@6evm5aryyuxp>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <20250829162212.208258-2-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829162212.208258-2-hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 29, 2025 at 05:15:26PM +0100, Johannes Weiner wrote:
> zswap goes through the zpool layer to enable runtime-switching of
> allocator backends for compressed data. However, since zbud and z3fold
> were removed in 6.15, zsmalloc has been the only option available.
> 
> As such, the zpool indirection is unnecessary. Make zswap deal with
> zsmalloc directly. This is comparable to zram, which also directly
> interacts with zsmalloc and has never supported a different backend.
> 
> Note that this does not preclude future improvements and experiments
> with different allocation strategies. Should it become necessary, it's
> possible to provide an alternate implementation for the zsmalloc API,
> selectable at compile time. However, zsmalloc is also rather mature
> and feature rich, with years of widespread production exposure; it's
> encouraged to make incremental improvements rather than fork it.
> 
> In any case, the complexity of runtime pluggability seems excessive
> and unjustified at this time. Switch zswap to zsmalloc to remove the
> last user of the zpool API.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
[..]
> @@ -315,52 +292,29 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>  error:
>  	if (pool->acomp_ctx)
>  		free_percpu(pool->acomp_ctx);
> -	if (pool->zpool)
> -		zpool_destroy_pool(pool->zpool);
> +	if (pool->zs_pool)
> +		zs_destroy_pool(pool->zs_pool);
>  	kfree(pool);
>  	return NULL;
>  }
>  
>  static struct zswap_pool *__zswap_pool_create_fallback(void)
>  {
> -	bool has_comp, has_zpool;
> -
> -	has_comp = crypto_has_acomp(zswap_compressor, 0, 0);
> -	if (!has_comp && strcmp(zswap_compressor,
> -				CONFIG_ZSWAP_COMPRESSOR_DEFAULT)) {
> +	if (!crypto_has_acomp(zswap_compressor, 0, 0) &&
> +	    strcmp(zswap_compressor, CONFIG_ZSWAP_COMPRESSOR_DEFAULT)) {
>  		pr_err("compressor %s not available, using default %s\n",
>  		       zswap_compressor, CONFIG_ZSWAP_COMPRESSOR_DEFAULT);
>  		param_free_charp(&zswap_compressor);
>  		zswap_compressor = CONFIG_ZSWAP_COMPRESSOR_DEFAULT;
> -		has_comp = crypto_has_acomp(zswap_compressor, 0, 0);
> -	}
> -	if (!has_comp) {
> -		pr_err("default compressor %s not available\n",
> -		       zswap_compressor);
> -		param_free_charp(&zswap_compressor);
> -		zswap_compressor = ZSWAP_PARAM_UNSET;
> -	}
> -
> -	has_zpool = zpool_has_pool(zswap_zpool_type);
> -	if (!has_zpool && strcmp(zswap_zpool_type,
> -				 CONFIG_ZSWAP_ZPOOL_DEFAULT)) {
> -		pr_err("zpool %s not available, using default %s\n",
> -		       zswap_zpool_type, CONFIG_ZSWAP_ZPOOL_DEFAULT);
> -		param_free_charp(&zswap_zpool_type);
> -		zswap_zpool_type = CONFIG_ZSWAP_ZPOOL_DEFAULT;
> -		has_zpool = zpool_has_pool(zswap_zpool_type);
> -	}
> -	if (!has_zpool) {
> -		pr_err("default zpool %s not available\n",
> -		       zswap_zpool_type);
> -		param_free_charp(&zswap_zpool_type);
> -		zswap_zpool_type = ZSWAP_PARAM_UNSET;
> +		if (!crypto_has_acomp(zswap_compressor, 0, 0)) {
> +			pr_err("default compressor %s not available\n",
> +			       zswap_compressor);
> +			zswap_compressor = ZSWAP_PARAM_UNSET;
> +			return NULL;
> +		}

Hmm it seems like there may be a change of behavior here. If
zswap_compressor == CONFIG_ZSWAP_COMPRESSOR_DEFAULT at the beginning and
crypto_has_acomp() returns false, the old code will go into the second
if (!has_comp) block, printing an error, freeing the string, and setting
zswap_compressor to ZSWAP_PARAM_UNSET, then we eventually return NULL.

It seems like the new code will just call zswap_pool_create() anyway.

Am I missing something here?


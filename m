Return-Path: <linux-kernel+bounces-803610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7E1B46303
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 016CAB63B7D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA68C315D3C;
	Fri,  5 Sep 2025 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CmAZIflN"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4F9315D39
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098738; cv=none; b=IB/O0EA+3uCWdKpGmOdskFdP+3bTDkwvVBcO0/7szyaVdjJEpoIs79EcEcTFn5HtV6oYevTI4jm0gE1MZ3tlxN4VtzZpluIEf0a0x1DnpPLSRrKd51wVQFBiu/uS2oqct8isJo/zx32yPyMyIWuh0EpE5exilKlVrpaxLpQ//mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098738; c=relaxed/simple;
	bh=otNFEZBWe2AgByZ1q3B9AW1czbc4FyoEFiaeeMVxwOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nkc7+OO8eb5OrBhrJP6x1qyg4aDsM3Ckt7+hkhtUImBDyERvQ/uMe7yoGI9F26HUgjSfLBNn34dMsaGwCoznfgct7k9lu7NvYaXyeDKZPATuD7cPvb9zszbQpHvv38lEXyT7EyH3jLSLZSrrVI4BVUaeOFoDgvfvTWSncPubp8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CmAZIflN; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 5 Sep 2025 18:58:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757098733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KQ3ZV2rIcZqWrNTn60s3bJyix3OLwt0qzQmfA3uB8V4=;
	b=CmAZIflNjkLkw8GZc13r30pIOLfga26PwOImCr/jXxTkHxN5K9+ItoBAnh5K8hTnZw3gCT
	M/7Q1nSxa1W06D88NF46oILU0E0aED6r5aCX7+hIHyFoIqfGP/ndUaB9DWFvYvkCwwHmdZ
	oUGkBV/heXKDqzgHCK9MuDUhZ6813Cw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: remove unused zpool layer
Message-ID: <rcxmemdxbxuvtag2qv4sjxoh7ho4z3bz3od6i76rc5yholx2rc@vncn6iuuee7b>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <20250829162212.208258-3-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829162212.208258-3-hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 29, 2025 at 05:15:27PM +0100, Johannes Weiner wrote:
> With zswap using zsmalloc directly, there are no more in-tree users of
> this code. Remove it.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
[..]
> @@ -125,45 +122,18 @@ config ZSWAP_COMPRESSOR_DEFAULT
>         default "zstd" if ZSWAP_COMPRESSOR_DEFAULT_ZSTD
>         default ""
>  
> -choice
> -	prompt "Default allocator"
> -	depends on ZSWAP
> -	default ZSWAP_ZPOOL_DEFAULT_ZSMALLOC if MMU
> -	help
> -	  Selects the default allocator for the compressed cache for
> -	  swap pages.
> -	  The default is 'zbud' for compatibility, however please do
> -	  read the description of each of the allocators below before
> -	  making a right choice.
> -
> -	  The selection made here can be overridden by using the kernel
> -	  command line 'zswap.zpool=' option.
> +config ZSMALLOC
> +	tristate
>  
> -config ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
> -	bool "zsmalloc"
> -	select ZSMALLOC
> -	help
> -	  Use the zsmalloc allocator as the default allocator.
> -endchoice
> +if ZSMALLOC
>  
> -config ZSWAP_ZPOOL_DEFAULT
> -       string
> -       depends on ZSWAP
> -       default "zsmalloc" if ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
> -       default ""
> +menu "Zsmalloc allocator options"
> +	depends on ZSMALLOC
>  
> -config ZSMALLOC
> -	tristate
> -	prompt "N:1 compression allocator (zsmalloc)" if (ZSWAP || ZRAM)
> -	depends on MMU
> -	help
> -	  zsmalloc is a slab-based memory allocator designed to store
> -	  pages of various compression levels efficiently. It achieves
> -	  the highest storage density with the least amount of fragmentation.

Why remove the prompt and help text here?

> +comment "Zsmalloc is a common backend allocator for zswap & zram"
>  
>  config ZSMALLOC_STAT
>  	bool "Export zsmalloc statistics"
> -	depends on ZSMALLOC
>  	select DEBUG_FS
>  	help
>  	  This option enables code in the zsmalloc to collect various
[..]


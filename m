Return-Path: <linux-kernel+bounces-808940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B886EB506BA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D9454E14E1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B73303A3D;
	Tue,  9 Sep 2025 20:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gioA9rPF"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7D71D799D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757448571; cv=none; b=FpQawIcMScfWKajjjHnL248VdP9VBaXWbj9reJTqwNVKTZZqHfBdKajDzi1Y8yQxlpe1EsGIulkxwPDBM8tgNhxrUv/rlBTMY1neSaw1Y9XWClsUwXvtPTexLyelTXBVN15B+NFb3MADOnCRkoc270gPQeDi0HEMgCLGnaybLZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757448571; c=relaxed/simple;
	bh=D62D6rssFtVrWZdpLOe/ToSoaUNE3oy2ZmsQjL42oHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJQcpPU/fa9SjWN0zrsNxjiToBwndWPBbXSKjfFGESYbcifPCxtDvD1wZfIJCnk0IfjabainTuVUW3SiE7sczJhWYk3AzLbjL9NpPsBaJ7A+XqJGoxPugrWilEqYAOXsEBmDYNPnTWikA3Hcu8AjO9bUF1vx5P7wIY+//2PVErQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gioA9rPF; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 9 Sep 2025 20:09:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757448566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RIavL6Q3Ip2q2nE3QhJWaekN9zisbFp9u0xqsk2O2kg=;
	b=gioA9rPFWSH+UvL5/HKK3p882rmySyZ73qJxY4LAfrVtdm+uLI4RtfrBdAlAk7vmV3Gc0S
	odZGM7JFeGt80eex4fZHx8JfEL8lcq7TPkBRvcBcD9Vrl/9SHoDBMu554+u+7iGwmw8C+Q
	m0VN4ynzZi3IqVJ6VpHzseIWk5dkHhQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: remove unused zpool layer
Message-ID: <3dmy2gxowbmq5wmpjtsb26d25k5fjev2geykik3du2ltmhrj7z@nfkwjjhndet5>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <20250829162212.208258-3-hannes@cmpxchg.org>
 <rcxmemdxbxuvtag2qv4sjxoh7ho4z3bz3od6i76rc5yholx2rc@vncn6iuuee7b>
 <20250909151639.GF1474@cmpxchg.org>
 <pmpmejmw4swnconhf3u5uzzhwtki2fdnwvt73vf7lzkigrhwmb@sarxlksng7nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pmpmejmw4swnconhf3u5uzzhwtki2fdnwvt73vf7lzkigrhwmb@sarxlksng7nb>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 09, 2025 at 08:08:12PM +0000, Yosry Ahmed wrote:
> On Tue, Sep 09, 2025 at 04:16:39PM +0100, Johannes Weiner wrote:
> > On Fri, Sep 05, 2025 at 06:58:47PM +0000, Yosry Ahmed wrote:
> > > On Fri, Aug 29, 2025 at 05:15:27PM +0100, Johannes Weiner wrote:
> > > > With zswap using zsmalloc directly, there are no more in-tree users of
> > > > this code. Remove it.
> > > > 
> > > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > ---
> > > [..]
> > > > @@ -125,45 +122,18 @@ config ZSWAP_COMPRESSOR_DEFAULT
> > > >         default "zstd" if ZSWAP_COMPRESSOR_DEFAULT_ZSTD
> > > >         default ""
> > > >  
> > > > -choice
> > > > -	prompt "Default allocator"
> > > > -	depends on ZSWAP
> > > > -	default ZSWAP_ZPOOL_DEFAULT_ZSMALLOC if MMU
> > > > -	help
> > > > -	  Selects the default allocator for the compressed cache for
> > > > -	  swap pages.
> > > > -	  The default is 'zbud' for compatibility, however please do
> > > > -	  read the description of each of the allocators below before
> > > > -	  making a right choice.
> > > > -
> > > > -	  The selection made here can be overridden by using the kernel
> > > > -	  command line 'zswap.zpool=' option.
> > > > +config ZSMALLOC
> > > > +	tristate
> > > >  
> > > > -config ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
> > > > -	bool "zsmalloc"
> > > > -	select ZSMALLOC
> > > > -	help
> > > > -	  Use the zsmalloc allocator as the default allocator.
> > > > -endchoice
> > > > +if ZSMALLOC
> > > >  
> > > > -config ZSWAP_ZPOOL_DEFAULT
> > > > -       string
> > > > -       depends on ZSWAP
> > > > -       default "zsmalloc" if ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
> > > > -       default ""
> > > > +menu "Zsmalloc allocator options"
> > > > +	depends on ZSMALLOC
> > > >  
> > > > -config ZSMALLOC
> > > > -	tristate
> > > > -	prompt "N:1 compression allocator (zsmalloc)" if (ZSWAP || ZRAM)
> > > > -	depends on MMU
> > > > -	help
> > > > -	  zsmalloc is a slab-based memory allocator designed to store
> > > > -	  pages of various compression levels efficiently. It achieves
> > > > -	  the highest storage density with the least amount of fragmentation.
> > > 
> > > Why remove the prompt and help text here?
> > 
> > We shouldn't ask users unnecessary questions. Zswap and zram are the
> > user-visible kernel options; if one of them is selected, they should
> > just quietly pull in the zsmalloc code.
> 
> That's fair, although ideally we should call it out in the commit log :P

With the commit log amended:

Acked-by: Yosry Ahmed <yosry.ahmed@linux.dev> 


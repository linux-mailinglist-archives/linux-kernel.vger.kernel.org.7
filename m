Return-Path: <linux-kernel+bounces-808938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E437DB506B8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4DC43AA282
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD97B304BBA;
	Tue,  9 Sep 2025 20:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PnsaUOQK"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82B51D799D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757448499; cv=none; b=Pz8IVl8nP8ax3BOT/Py7H6j30BSIC/O4Dt2FmGqt1SCt9n2wvckL2hq22p2dp3ExPMsa66Wdy/jGjpyV5VdNliHMYRs15luHZH2pqvz5aqQecipMpKqN18NlwVn0JDGzLwiCWKxWM172UZQOQE23+CxpxfTFWWNDHhKUYPn1trM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757448499; c=relaxed/simple;
	bh=d3UGzOy/G/8j+lns7mj8ipnVCDMpOSkbE3Mvj6HG6yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsXMXEjudeOfxUelgSj3L7PC0pZJD7Vt94RxDlN+v/6TD/ptjecLCEED+81Xct/FaO5d2m5pUiW3B6aQ0rzt7BOrUUjkDUCQQqMYLSj4K5SrC16BXd6Qr6pj2mLt20f8LiTKHVdOEg4XCreBI/0S1Po40tfnIDxyrHXKiT+jQ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PnsaUOQK; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 9 Sep 2025 20:08:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757448492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nHiAt8SZC9VGc5jH6Z1uTisOoAikme/EPt+RV5cfjq0=;
	b=PnsaUOQK/8KazG0GY3kaADlGBLkrZLA4mVczpKQWH1EleIquSvWRrZTWltHxRPPKi67TwY
	7g9Nz4Vo+TOaVn6BxcHIOjQT7htlPNNKGSeM5xH7t1v3oyYYq0UETW1Ye9i6PgEnfOHahT
	QM9TNHbgKMeOc/3Xs7bmemvxjVzU4WA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: remove unused zpool layer
Message-ID: <pmpmejmw4swnconhf3u5uzzhwtki2fdnwvt73vf7lzkigrhwmb@sarxlksng7nb>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <20250829162212.208258-3-hannes@cmpxchg.org>
 <rcxmemdxbxuvtag2qv4sjxoh7ho4z3bz3od6i76rc5yholx2rc@vncn6iuuee7b>
 <20250909151639.GF1474@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909151639.GF1474@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 09, 2025 at 04:16:39PM +0100, Johannes Weiner wrote:
> On Fri, Sep 05, 2025 at 06:58:47PM +0000, Yosry Ahmed wrote:
> > On Fri, Aug 29, 2025 at 05:15:27PM +0100, Johannes Weiner wrote:
> > > With zswap using zsmalloc directly, there are no more in-tree users of
> > > this code. Remove it.
> > > 
> > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > ---
> > [..]
> > > @@ -125,45 +122,18 @@ config ZSWAP_COMPRESSOR_DEFAULT
> > >         default "zstd" if ZSWAP_COMPRESSOR_DEFAULT_ZSTD
> > >         default ""
> > >  
> > > -choice
> > > -	prompt "Default allocator"
> > > -	depends on ZSWAP
> > > -	default ZSWAP_ZPOOL_DEFAULT_ZSMALLOC if MMU
> > > -	help
> > > -	  Selects the default allocator for the compressed cache for
> > > -	  swap pages.
> > > -	  The default is 'zbud' for compatibility, however please do
> > > -	  read the description of each of the allocators below before
> > > -	  making a right choice.
> > > -
> > > -	  The selection made here can be overridden by using the kernel
> > > -	  command line 'zswap.zpool=' option.
> > > +config ZSMALLOC
> > > +	tristate
> > >  
> > > -config ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
> > > -	bool "zsmalloc"
> > > -	select ZSMALLOC
> > > -	help
> > > -	  Use the zsmalloc allocator as the default allocator.
> > > -endchoice
> > > +if ZSMALLOC
> > >  
> > > -config ZSWAP_ZPOOL_DEFAULT
> > > -       string
> > > -       depends on ZSWAP
> > > -       default "zsmalloc" if ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
> > > -       default ""
> > > +menu "Zsmalloc allocator options"
> > > +	depends on ZSMALLOC
> > >  
> > > -config ZSMALLOC
> > > -	tristate
> > > -	prompt "N:1 compression allocator (zsmalloc)" if (ZSWAP || ZRAM)
> > > -	depends on MMU
> > > -	help
> > > -	  zsmalloc is a slab-based memory allocator designed to store
> > > -	  pages of various compression levels efficiently. It achieves
> > > -	  the highest storage density with the least amount of fragmentation.
> > 
> > Why remove the prompt and help text here?
> 
> We shouldn't ask users unnecessary questions. Zswap and zram are the
> user-visible kernel options; if one of them is selected, they should
> just quietly pull in the zsmalloc code.

That's fair, although ideally we should call it out in the commit log :P


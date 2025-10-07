Return-Path: <linux-kernel+bounces-844873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D1ABC2FA4
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 01:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E32084EDA19
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 23:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F2C264628;
	Tue,  7 Oct 2025 23:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BlAiRmbo"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB7A25F994
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 23:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759880532; cv=none; b=i5JGCyMWw/bn2BX03uBI/I32roaVR6cfUfsqNQXgKE2Qgw6WvvERzMbWfED90zBqnnAd5ShgLUukSLe44TI5msUY5co9d6JV/+WZZ2QB+cB+DcGK3djVNpjxd06ewbBQI68gYMcMANe87xaKTOsAF4ctaP/ICvfGXBbDEHQyLuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759880532; c=relaxed/simple;
	bh=7XB3xd67udOzpVRY0snHzHj1y68oWyc6y21sgYjtJdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0lIsbaFuVTT24S7PKJ/YuoPAlypcRy1UCGaqqtPRdIZi1nSU2O4VxGU6mGZRE5swX1apWS0CZXtGxqWiRuy30uyJAlAdLqUTm/GROhRFD/rNcw2mttek6RVC6+sqCdmykO9bQ6pgDND3Ofezvdlda/pKfzZLt2mhoEHWRfycnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BlAiRmbo; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 7 Oct 2025 23:42:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759880528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=69vstxN5iaeMoAXTOwPIMnQcC6rAdKt4sbd5u04ANzU=;
	b=BlAiRmboDCZPs7XL7X0mEv7qifobtDsgXHjmE+NVxUfqnUHgwNKlg1RYUpAdu8Mmv2mLET
	7gyRyD6jDILB8Ig4aahNRrnYtIfkoUlZZKqjml5b2JsK/crvXZsZgbDvWfPIn1fVX1/8BJ
	DHc/JefufH9NeS0RxKebXuEDXbhdqFA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 4/4] Docs/admin-guide/mm/zswap: s/red-black tree/xarray/
Message-ID: <4mziyxqm3nide6fh7xlbwqkuex4yf2tn6yzkwhzmy4mamazbxk@53an3oyd7amv>
References: <20251003203851.43128-1-sj@kernel.org>
 <20251003203851.43128-5-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003203851.43128-5-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 03, 2025 at 01:38:51PM -0700, SeongJae Park wrote:
> The change from commit 796c2c23e14e ("zswap: replace RB tree with
> xarray") is not reflected on the document.  Update the document.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>

Acked-by: Yosry Ahmed <yosry.ahmed@linux.dev>

> ---
>  Documentation/admin-guide/mm/zswap.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
> index 283d77217c6f..2464425c783d 100644
> --- a/Documentation/admin-guide/mm/zswap.rst
> +++ b/Documentation/admin-guide/mm/zswap.rst
> @@ -59,11 +59,11 @@ returned by the allocation routine and that handle must be mapped before being
>  accessed.  The compressed memory pool grows on demand and shrinks as compressed
>  pages are freed.  The pool is not preallocated.
>  
> -When a swap page is passed from swapout to zswap, zswap maintains a mapping
> -of the swap entry, a combination of the swap type and swap offset, to the
> -zsmalloc handle that references that compressed swap page.  This mapping is
> -achieved with a red-black tree per swap type.  The swap offset is the search
> -key for the tree nodes.
> +When a swap page is passed from swapout to zswap, zswap maintains a mapping of
> +the swap entry, a combination of the swap type and swap offset, to the zsmalloc
> +handle that references that compressed swap page.  This mapping is achieved
> +with an xarray per swap type.  The swap offset is the search key for the xarray
> +nodes.
>  
>  During a page fault on a PTE that is a swap entry, the swapin code calls the
>  zswap load function to decompress the page into the page allocated by the page
> -- 
> 2.39.5


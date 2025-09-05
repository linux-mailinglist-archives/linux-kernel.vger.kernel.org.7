Return-Path: <linux-kernel+bounces-803625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD01AB4631D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8236E5617BF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22C71DA60F;
	Fri,  5 Sep 2025 19:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HyiAhuxG"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812CD315D5C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099131; cv=none; b=NPL6BjiRqDTn9N5qaT3C4rpZXLJtsBU4n2BCApJaRo6Z6LmwZPrkpKasfgorHTv9MGaMS2TxR1HstKjxu0E/a06vSTzTPFZltbzl9VC8EzDbCuKqO8oZLI2a3BVfHst1Wadkj1b0GxkdWwPpb8/JWrDE9YVkCZcZQHumOHtVZSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099131; c=relaxed/simple;
	bh=bD8UqoHrwGHuOKFQj14804H9nbOhxwVehQa+C3kR39I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3mcZeh14438WE3mLAcu1G43q3nW1eCS9nA0x9smHHHT/dbmdSBPufrrzdutOzhd5yUnVhMrYEACvtkchJfUmZOkIki47TY8vJI8F63eWW7j+JyjmA+b2bNZKMGcVFME0A1OsAkNL73pTvRJpJ23lMkGoiUC/ecpLbgkceMj9fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HyiAhuxG; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 5 Sep 2025 19:05:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757099127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TBdBbd9rF6CefLoKkHIThKZGfWxDEedn2PW+zbsTzWM=;
	b=HyiAhuxG9cVVBHaUEZSJ7rZK1hcY2Uy3HKrlUrLe0shw+fKFuKb1XSxfJnMvDYeuWoMvG9
	VGindFQfzCodCmnBuFl+nX1P+fto2XrtWqcd/xrBx65FbFT0RCGIzXoVNJ8kcbixk0kAjy
	80eMNrAO3zECB8hXBEUHgdUIGuyOkHw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: zpdesc: minor naming and comment corrections
Message-ID: <mgt4ejjyz64ehnyskv24nzjllxxie4jvxb6i2dzlq43yev5dtu@sfltngevykts>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <20250829162212.208258-4-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829162212.208258-4-hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 29, 2025 at 05:15:28PM +0100, Johannes Weiner wrote:
> zpdesc is the page descriptor used by the zsmalloc backend allocator,
> which in turn is used by zswap and zram. The zpool layer is gone.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---

Why not rename zpdesc to zsdesc or zdesc while we're at it? It's a lot
of noise but it's just this file and zsmalloc.c IIUC. Up to you.

If it's just the comment changes I would squash it into the second
patch, but not a big deal. Either way:

Acked-by: Yosry Ahmed <yosry.ahmed@linux.dev>

>  mm/zpdesc.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/zpdesc.h b/mm/zpdesc.h
> index 25bf5ea0beb8..b8258dc78548 100644
> --- a/mm/zpdesc.h
> +++ b/mm/zpdesc.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/* zpdesc.h: zswap.zpool memory descriptor
> +/* zpdesc.h: zsmalloc pool memory descriptor
>   *
>   * Written by Alex Shi <alexs@kernel.org>
>   *	      Hyeonggon Yoo <42.hyeyoo@gmail.com>
> @@ -11,14 +11,14 @@
>  #include <linux/pagemap.h>
>  
>  /*
> - * struct zpdesc -	Memory descriptor for zpool memory.
> + * struct zpdesc -	Memory descriptor for zsmalloc pool memory.
>   * @flags:		Page flags, mostly unused by zsmalloc.
>   * @lru:		Indirectly used by page migration.
>   * @movable_ops:	Used by page migration.
> - * @next:		Next zpdesc in a zspage in zsmalloc zpool.
> - * @handle:		For huge zspage in zsmalloc zpool.
> + * @next:		Next zpdesc in a zspage in zsmalloc pool.
> + * @handle:		For huge zspage in zsmalloc pool.
>   * @zspage:		Points to the zspage this zpdesc is a part of.
> - * @first_obj_offset:	First object offset in zsmalloc zpool.
> + * @first_obj_offset:	First object offset in zsmalloc pool.
>   * @_refcount:		The number of references to this zpdesc.
>   *
>   * This struct overlays struct page for now. Do not modify without a good
> @@ -79,8 +79,8 @@ static_assert(sizeof(struct zpdesc) <= sizeof(struct page));
>   * zpdesc_folio - The folio allocated for a zpdesc
>   * @zp: The zpdesc.
>   *
> - * Zpdescs are descriptors for zpool memory. The zpool memory itself is
> - * allocated as folios that contain the zpool objects, and zpdesc uses specific
> + * Zpdescs are descriptors for zsmalloc memory. The memory itself is allocated
> + * as folios that contain the zsmalloc objects, and zpdesc uses specific
>   * fields in the first struct page of the folio - those fields are now accessed
>   * by struct zpdesc.
>   *
> -- 
> 2.51.0
> 


Return-Path: <linux-kernel+bounces-817688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92808B58566
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331234848FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F62280330;
	Mon, 15 Sep 2025 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hdxpg6HJ"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32221A9FB0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965028; cv=none; b=a7pD/+qgSPVzdLwnP2adVTEAgsIoPb8adWkCFlCNUfDK7UFX5gjMTZURH8EG8ARgRH84fMxPF8CesNEhiD2Xnwzp7VCZHBhj7LMwY5tQB+eejw5bOlx/+2v89AxrqUn92QHqCMO4Nl4BXkAeqiuvaVWKHD4w4PrI2AvSX5clTcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965028; c=relaxed/simple;
	bh=8pxDgeDhs6ZL4QexQ1Rgt1ozb77UDa3hCT8pfEmTsGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o471qz6xFUQnHOPELebyal5jseKKeknTV0ggy+u5Yjz3tdbu9pgu+tE7bITkcgi1yvflTF54Ba4BmwqpUrGiI3W/K12+YTZMyx+7jpNSx3ILxCipOddMUk41JNx0GCacNmSJdeV4kwWD+DQAmXAm+Goej+U2pw4tI2d/nEjw+tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hdxpg6HJ; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 15 Sep 2025 19:37:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757965024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GXeOMSLnAh+Y5BeziIMqNMvsY4xASMxyysnTBr1a6P8=;
	b=hdxpg6HJbWKd4pRTY2Hd5oB70cnSFLXa36br3d7dKMYl72300kdFaP5zfRq7Q6q4nlRaEA
	4DOx7PlgtzfHi2setFqia0My7+dt9YTX2+tk1l0wIUwOL50fBEgDJmx2i7rzH5wy+Nk5e/
	cnTCzEoFO7YEnZjk+RxhybjIQYLYQA8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Vlastimil Babka <vbabka@suse.cz>, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/3] mm: remove zpool
Message-ID: <fui4gqm6pealaxooz3xv3dnnqxscefyvhw5bhntedwh4tgjvdq@ootmbuoc3dpa>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <20250904093325.2768507-1-vitaly.wool@konsulko.se>
 <7b1ca42d-1b89-44f4-bffb-e6b09f86fdc5@suse.cz>
 <1d42c513-cc83-4f08-a10c-cbd6206070f4@konsulko.se>
 <girukcvvzgbtkxt4aftfz3lw3glvf2qsof4mx6wf5perolck5n@vaxlrtaeuzw7>
 <dh74mr7bjtpzk7frviv6iqqno2u2b27p7jiagp2dtnsz2wrfhr@wlb5vqg4majs>
 <tbvushbdn7nzitey3uy6humdndd6247r4544ngqkds3cr447e6@prnla4edwxmk>
 <f3ufcsjvvxhi5gzw2wglkpedgyyi6tiaje7em3tbxkzhklphvh@sv3dbo4yba5p>
 <98B3AFB0-EBD5-4779-A5DB-FFA6717E83C3@konsulko.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98B3AFB0-EBD5-4779-A5DB-FFA6717E83C3@konsulko.se>
X-Migadu-Flow: FLOW_OUT

On Sat, Sep 13, 2025 at 03:55:16PM +0200, Vitaly Wool wrote:
> 
> 
> > On Sep 9, 2025, at 10:12 PM, Yosry Ahmed <yosry.ahmed@linux.dev> wrote:
> > 
> > On Mon, Sep 08, 2025 at 09:18:01PM +0900, Sergey Senozhatsky wrote:
> >> On (25/09/06 14:25), Sergey Senozhatsky wrote:
> >>> On (25/09/05 19:57), Yosry Ahmed wrote:
> >>>> I think Android uses zram+zsmalloc with 16K pages. Perhaps Sergey could
> >>>> confirm.
> >>> 
> >>> I'm not working on android directly,
> >>> 
> >>> I can confirm that android uses zram+zsmalloc.  As of 16K pages, there
> >>> was a way to toggle 16k pages on android (via system settings), I don't
> >>> know if this is the default now.
> >> 
> >> While I don't know what zsmalloc struggles Vitaly is referring to in
> >> particular, off the top of my head, zsmalloc does memcpy()'s for objects
> >> that span multiple pages, when zsmalloc kmap()'s both physical pages and
> >> memcpy()'s chunks of the object into a provided buffer. With 16K pages
> >> we can have rather larger compressed objects, so those memcpy() are likely
> >> more visible.  Attacking this would be a good idea, I guess.
> > 
> > Yeah I personally think attacking whatever problems zsmalloc has with
> > 16K pages is the way to go.
> 
> Well, there is a way out for 16+K pages, that being:
> * restricting zsmalloc to not have objects spanning across 2 pages
> * reworking size_classes based allocation to have uneven steps
> * as a result of the above, organising binary search for the right size object
> 
> This will effectively turn zsmalloc into zblock, with some extra cruft that makes it far less comprehensible.

I think the way to go would be this, identifying problems with 16K on
zsmalloc, and addressing them one by one in a data-driven way.

I don't believe there will be opposition to this, or even adding more
tunables / config options to alter zsmalloc's behavior based on the
environment. If there's indeed extra cruft, we can either clean it up or
hide it behind config/tunabels so that it's only enabled when needed.

> 
> Another option would be to leave zsmalloc do its job on 4K pages and use zblock for bigger pages. But it is not possible at the moment because zpool api has been removed. Thats’s why I NACK’ed the zpool removal, at least until we have a replacement for it ready.

I think having a separate allocator that's better for each page size is
not a good option tbh.


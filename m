Return-Path: <linux-kernel+bounces-771549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4AEB288A9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 01:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D588AA4B3B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1693E261581;
	Fri, 15 Aug 2025 23:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T0CNXYot"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBF420B800
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 23:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755299595; cv=none; b=cx6RbHtthrYF0oGhkBcCoSogR6CpTSuM8H7Kvb4B+OCiZhvMIjHaP/HoOaDrcSnyZU0nHSQ6yndNRJsRWkUkNZPCXsBs44hfq1iaKWauEuneot8QQFdPPolmvFiWFcGTkjmvVVpcVdXOdR6D8bs1lT85QHnVi5OHry7m2ADf93Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755299595; c=relaxed/simple;
	bh=Bv2mT6y6eipGmMPrkdcDjuhqZ6EWUt74KE/ntV3qnDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzDp6TrMnZsvH7WFNB9SywxR05LD0iT1gre67g5uMDGYtHwCmmrO3MSnhkboNeAxQsprNNMVGtOd9RqiRWrdL68KPfoP81shOmQZgtXsNTj38yngYcVkoSiFqs/dOTvN3aRymD+5ucg7sy8NvlAh+RH1W7LtJpR00Q9D8y2bs20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T0CNXYot; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 15 Aug 2025 16:13:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755299589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BxM4nv7eHd9SuH5ros1aBkbmXIdblLOqlo44TIn88VI=;
	b=T0CNXYoth9mLqTfFPM/Rn13mKGw2USAyatawX6LT3DYDqjfVxRg7exGcvzKhNTH0lOq9Vn
	+aamORjVx3GYUlKkfhq/FZ2okstmDVIDDb/X7QH6YmrRGOejvRByAehLmO/SjOGFBULwco
	0onk0x04unL9ucdTRJp0qNiZiPGLYmM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: mark MGLRU as maintained
Message-ID: <7a46f7jwlwgkbdjvbxjaalrrdamgtxkptmytllhkr2qv4ovbge@nbugfzavwh5w>
References: <20250815215914.3671925-1-axelrasmussen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815215914.3671925-1-axelrasmussen@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 15, 2025 at 02:59:14PM -0700, Axel Rasmussen wrote:
> The three folks being added here are actively working on MGLRU within
> Google, so we can review patches for this feature and plan to contribute
> some improvements / extensions to it on an ongoing basis.
> 
> With three of us we may have some hope filling Yu Zhao's shoes, since he
> has moved on to other projects these days.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  MAINTAINERS | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index daf520a13bdf..8e987f2668cd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16058,6 +16058,23 @@ F:	mm/mempolicy.c
>  F:	mm/migrate.c
>  F:	mm/migrate_device.c
>  
> +MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU)

Why not just add yourselves (and the missing files) to the existing
reclaim section? Eventually we want a single reclaim solution, so why
not start with single reviewer section?

> +M:	Andrew Morton <akpm@linux-foundation.org>
> +M:	Axel Rasmussen <axelrasmussen@google.com>
> +M:	Yuanchu Xie <yuanchu@google.com>
> +R:	Wei Xu <weixugc@google.com>
> +L:	linux-mm@kvack.org
> +S:	Maintained
> +W:	http://www.linux-mm.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> +F:	Documentation/admin-guide/mm/multigen_lru.rst
> +F:	Documentation/mm/multigen_lru.rst
> +F:	include/linux/mm_inline.h
> +F:	include/linux/mmzone.h
> +F:	mm/swap.c
> +F:	mm/vmscan.c
> +F:	mm/workingset.c
> +
>  MEMORY MANAGEMENT - MISC
>  M:	Andrew Morton <akpm@linux-foundation.org>
>  M:	David Hildenbrand <david@redhat.com>
> -- 
> 2.51.0.rc1.163.g2494970778-goog
> 


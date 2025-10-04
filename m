Return-Path: <linux-kernel+bounces-841946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AA9BB8997
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 06:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395854A76CA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 04:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E04219A7D;
	Sat,  4 Oct 2025 04:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TeDOSUoF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C555F1917F1
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 04:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759552644; cv=none; b=UUNbcRC9XB81eRy3IfwZ5Fhnoas8Ir0l5JHZ6jqL0BcufJFdGeGsufC7VDukSI4XwkQQh2GxYl7ZFPQivww/DbMBdR/CQ5/Kiof/N6AbK/BINFQFU04/vp6jEveI4cUQJFUC+LVxDWoQceRGbTl5XRZblM3lENTnjceHopGNhBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759552644; c=relaxed/simple;
	bh=woKr4oi+9bEtbAbqJeCgWZr6+QUnWP9LlV8F4UWMOB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u626gJ9b+9S7OHq7gWCtMiykjqDQOnuMY6WrEyBrbPZSng0ut5L0O9BHt+kHDQYggkJEYZoO3eudpK0phJXquTWTkZMdRWD1N6QHp87htDbLm9bqqjANQf0cGYokVJgMYsDVhUWmaJupb87uSdKFO/rot+fl+j6jsLKBsBu+WXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TeDOSUoF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759552641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u0XiqxfOq9vlqMHc1NeoH/5IygmQCzOyK8BHyyYUppI=;
	b=TeDOSUoFti5IJ4KVLgvicpMLCA/3ohpEXWxuBwIXa8rKR3dQO56/b/ShfwQnoFjDiP9q0+
	oEJ5++Sx413nc7oSOhT3NXz+awA4QMoqkNi+ZeYkbsB8ZVBX9fnJQ6r/HBSmzsppk1aP29
	9jsPMrwuABP4Vyb20MXCdz2InzkcG18=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-MPe9zfsJM5KkIdarp91mbw-1; Sat,
 04 Oct 2025 00:37:13 -0400
X-MC-Unique: MPe9zfsJM5KkIdarp91mbw-1
X-Mimecast-MFC-AGG-ID: MPe9zfsJM5KkIdarp91mbw_1759552632
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A3D51800452;
	Sat,  4 Oct 2025 04:37:12 +0000 (UTC)
Received: from localhost (unknown [10.72.112.27])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E62A19560AB;
	Sat,  4 Oct 2025 04:37:11 +0000 (UTC)
Date: Sat, 4 Oct 2025 12:37:07 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 10/10] mm: kvmalloc: Add non-blocking support for
 vmalloc
Message-ID: <aOCkc27YVRVa8PBW@MiWiFi-R3L-srv>
References: <20251001192647.195204-1-urezki@gmail.com>
 <20251001192647.195204-11-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001192647.195204-11-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 10/01/25 at 09:26pm, Uladzislau Rezki (Sony) wrote:
> Extend __kvmalloc_node_noprof() to handle non-blocking GFP flags
> (GFP_NOWAIT and GFP_ATOMIC). Previously such flags were rejected,
> returning NULL. With this change:
> 
> - kvmalloc() can fall back to vmalloc() if non-blocking contexts;
> - for non-blocking allocations the VM_ALLOW_HUGE_VMAP option is
>   disabled, since the huge mapping path still contains might_sleep();
> - documentation update to reflect that GFP_NOWAIT and GFP_ATOMIC
>   are now supported.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/slub.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 584a5ff1828b..3de0719e24e9 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -7018,7 +7018,7 @@ static gfp_t kmalloc_gfp_adjust(gfp_t flags, size_t size)
>   * Uses kmalloc to get the memory but if the allocation fails then falls back
>   * to the vmalloc allocator. Use kvfree for freeing the memory.
>   *
> - * GFP_NOWAIT and GFP_ATOMIC are not supported, neither is the __GFP_NORETRY modifier.
> + * GFP_NOWAIT and GFP_ATOMIC are supported, the __GFP_NORETRY modifier is not.
>   * __GFP_RETRY_MAYFAIL is supported, and it should be used only if kmalloc is
>   * preferable to the vmalloc fallback, due to visible performance drawbacks.
>   *
> @@ -7027,6 +7027,7 @@ static gfp_t kmalloc_gfp_adjust(gfp_t flags, size_t size)
>  void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), unsigned long align,
>  			     gfp_t flags, int node)
>  {
> +	bool allow_block;
>  	void *ret;
>  
>  	/*
> @@ -7039,16 +7040,22 @@ void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), unsigned long align,
>  	if (ret || size <= PAGE_SIZE)
>  		return ret;
>  
> -	/* non-sleeping allocations are not supported by vmalloc */
> -	if (!gfpflags_allow_blocking(flags))
> -		return NULL;
> -
>  	/* Don't even allow crazy sizes */
>  	if (unlikely(size > INT_MAX)) {
>  		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
>  		return NULL;
>  	}
>  
> +	/*
> +	 * For non-blocking the VM_ALLOW_HUGE_VMAP is not used
> +	 * because the huge-mapping path in vmalloc contains at
> +	 * least one might_sleep() call.
> +	 *
> +	 * TODO: Revise huge-mapping path to support non-blocking
> +	 * flags.
> +	 */
> +	allow_block = gfpflags_allow_blocking(flags);
> +
>  	/*
>  	 * kvmalloc() can always use VM_ALLOW_HUGE_VMAP,
>  	 * since the callers already cannot assume anything
> @@ -7056,7 +7063,7 @@ void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), unsigned long align,
>  	 * protection games.
>  	 */
>  	return __vmalloc_node_range_noprof(size, align, VMALLOC_START, VMALLOC_END,
> -			flags, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
> +			flags, PAGE_KERNEL, allow_block ? VM_ALLOW_HUGE_VMAP:0,
>  			node, __builtin_return_address(0));
>  }
>  EXPORT_SYMBOL(__kvmalloc_node_noprof);
> -- 
> 2.47.3
> 



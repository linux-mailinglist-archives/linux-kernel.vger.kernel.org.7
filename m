Return-Path: <linux-kernel+bounces-772724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 776FEB296D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA4D2022F8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 02:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A36247297;
	Mon, 18 Aug 2025 02:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNDlHBXi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91804246789
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755483270; cv=none; b=YODjZKRrJcbwgVEFzktWYfgTIYoQvISgpKxSUG7h1ai+9MXEU5eUjc8ykIgfeFTGIQ3cs2hrQC69gRssPPg6fH6EcokcJ9+k1Ohv7WTT0qb7piZRDuxQinCYX3f3BQlYfEoV7ubMgWrQgcPK8xBol3k27gA4w9RPcNjtRF3a/Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755483270; c=relaxed/simple;
	bh=bLwuNkuk0hxZCC+QBQKvvB4osdgWI3fDP4yZWk8FQQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WT2STHaZleSY4VD/u2M1K0ytwxvYv5zEzqXHUXd6x/CVtPTWqxARnOuJtT0SMQ7wqB03CVH1UIQ61DOoUJWfVU2z0gt7wwk45gltJzowh1lWDEsODZScBvSznvAdKay9PuDiC+qlfzIijGTvEmyU/axQAy0vPPfaPb3srsaka8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aNDlHBXi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755483267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TIWBQ1PDibIT9To10rXi6vD/QpbzoLVnyobWk+6cFEk=;
	b=aNDlHBXiwPMsBce+EZ5NFJnFWyQpUVRyT0WxitcGV9Xsw5fE0S47G8lac0Y4hpCslmPszO
	KIt+Y6j/FSBtXUTUKJTvfVUELOALfF5j15+jOBs5asFsEaI0xvGuzVcu2JrOgQVybaUg+S
	wrhMcmtXFFDQbtPQXs+9MK76GfYxgSI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-6PSUH_DAPLOJOOlSyHh6Rg-1; Sun,
 17 Aug 2025 22:14:24 -0400
X-MC-Unique: 6PSUH_DAPLOJOOlSyHh6Rg-1
X-Mimecast-MFC-AGG-ID: 6PSUH_DAPLOJOOlSyHh6Rg_1755483263
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C537C1800345;
	Mon, 18 Aug 2025 02:14:22 +0000 (UTC)
Received: from localhost (unknown [10.72.112.210])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95339180028D;
	Mon, 18 Aug 2025 02:14:21 +0000 (UTC)
Date: Mon, 18 Aug 2025 10:14:17 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] mm/vmalloc: Remove cond_resched() in
 vm_area_alloc_pages()
Message-ID: <aKKMeUdnr/0WuQh6@MiWiFi-R3L-srv>
References: <20250807075810.358714-1-urezki@gmail.com>
 <20250807075810.358714-5-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807075810.358714-5-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 08/07/25 at 09:58am, Uladzislau Rezki (Sony) wrote:
> The vm_area_alloc_pages() function uses cond_resched() to yield the
> CPU during potentially long-running loops. However, these loops are
> not considered long-running under normal conditions. In non-blocking
> contexts, calling cond_resched() is inappropriate also.
> 
> Remove these calls to ensure correctness for blocking/non-blocking
> contexts. This also simplifies the code path. In fact, a slow path
> of page allocator already includes reschedule points to mitigate
> latency.
> 
> This patch was tested for !CONFIG_PREEMPT kernel and with large
> allocation chunks(~1GB), without triggering any "BUG: soft lockup"
> warnings.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 81b6d3bde719..b0255e0c74b3 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3633,7 +3633,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  							pages + nr_allocated);
>  
>  			nr_allocated += nr;
> -			cond_resched();
>  
>  			/*
>  			 * If zero or pages were obtained partly,
> @@ -3675,7 +3674,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  		for (i = 0; i < (1U << order); i++)
>  			pages[nr_allocated + i] = page + i;
>  
> -		cond_resched();
>  		nr_allocated += 1U << order;
>  	}
>  
> -- 
> 2.39.5
> 



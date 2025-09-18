Return-Path: <linux-kernel+bounces-821962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3FDB82B39
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C7BE7B83F0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961CF216E23;
	Thu, 18 Sep 2025 03:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbnY58KU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E1A3D984
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758164563; cv=none; b=rToGzAPWkjsxdsfxUc4DvxfQpWhNLcN6FPdtA42o2QrTEY3fxCD8HhcYj5emB8gCzrorVooiUc8j9kjNUoW72bcMEViYSURx6ocgZHjyblVhgvwe9K6zJhf72knyQvDZzbUxeBO5KbqzgKabB1jvi2VSa1uqZ+wnB/INyVWw+Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758164563; c=relaxed/simple;
	bh=DHi0S2eJ0je7mazsSL4kTZCHevzOILvp64+xJ2TUcf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQnbeIs1tAh/81nedYOlNpylTVnJSWomQLCy8PUCY2UVL1E0FSXrNZb8bdW+U9I+tgQt8Y0a2Gh34kUsL69KBDUSpUfa0qWu1gh00sRsj1s2bv8dQrFADd4JJ8e7epDcjWcSN3t4XaIT9a3pNdqmh/+nZ0FOOPsIEYo2Ic8Ga4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RbnY58KU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758164560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ww0rkAHR/bKD96qA8T50xR51LFz53rc6QLvDaZ08jOs=;
	b=RbnY58KUtW6eFO2/ivzSl2BYVVNpxLdf8kaWgWVunQzv1VKAsO0ok3e+2sTuKU4fvg9795
	qW8nLHCLNmlp5VZ72eitHYKXhWB1SA16kep/GTMzbVVrXkTfYL9e37k+qQZfVaoLxlzIlR
	iWFWcmm3xem6CmG2EsNd0jKaHqtnDHA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-eE1y5t-ePTaXnppfXDorKA-1; Wed,
 17 Sep 2025 23:02:35 -0400
X-MC-Unique: eE1y5t-ePTaXnppfXDorKA-1
X-Mimecast-MFC-AGG-ID: eE1y5t-ePTaXnppfXDorKA_1758164553
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FC3C19560B7;
	Thu, 18 Sep 2025 03:02:33 +0000 (UTC)
Received: from localhost (unknown [10.72.112.180])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73BB719560B1;
	Thu, 18 Sep 2025 03:02:32 +0000 (UTC)
Date: Thu, 18 Sep 2025 11:02:28 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v2 07/10] mm/kasan: Support non-blocking GFP in
 kasan_populate_vmalloc()
Message-ID: <aMt2RBzoKB9iodtR@MiWiFi-R3L-srv>
References: <20250915134041.151462-1-urezki@gmail.com>
 <20250915134041.151462-8-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915134041.151462-8-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/15/25 at 03:40pm, Uladzislau Rezki (Sony) wrote:
> A "gfp_mask" is already passed to kasan_populate_vmalloc() as
> an argument to respect GFPs from callers and KASAN uses it for
> its internal allocations.
> 
> But apply_to_page_range() function ignores GFP flags due to a
> hard-coded mask.
> 
> Wrap the call with memalloc_apply_gfp_scope()/memalloc_restore_scope()
> so that non-blocking GFP flags(GFP_ATOMIC, GFP_NOWAIT) are respected.
> 
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/kasan/shadow.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 11d472a5c4e8..c6643a72d9f6 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -377,18 +377,10 @@ static int __kasan_populate_vmalloc(unsigned long start, unsigned long end, gfp_
>  		 * page tables allocations ignore external gfp mask, enforce it
>  		 * by the scope API
>  		 */
> -		if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
> -			flags = memalloc_nofs_save();
> -		else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
> -			flags = memalloc_noio_save();
> -
> +		flags = memalloc_apply_gfp_scope(gfp_mask);
>  		ret = apply_to_page_range(&init_mm, start, nr_pages * PAGE_SIZE,
>  					  kasan_populate_vmalloc_pte, &data);
> -
> -		if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
> -			memalloc_nofs_restore(flags);
> -		else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
> -			memalloc_noio_restore(flags);
> +		memalloc_restore_scope(flags);
>  
>  		___free_pages_bulk(data.pages, nr_pages);
>  		if (ret)
> -- 
> 2.47.3
> 



Return-Path: <linux-kernel+bounces-821958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8736BB82B18
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410D6626502
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E7A23BD13;
	Thu, 18 Sep 2025 02:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUbT7Qvp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A15225416
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758164254; cv=none; b=bW8g0E+SUFxYNkS/xCRxy9GM4ArejedPM2MUotb0VI6+HhIefgbqpcHzzByvJT+0tF6GuI//TRUGukB/SHMHYf9lerSV6ocA5T3IvnigIAw6nINUeBtUzgC2M2HhSyPymU7cPDnty1ZtGT1XnsHL9rCXZgZZqKF/xFRZysIYGS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758164254; c=relaxed/simple;
	bh=GHrAO4rxlTCB6V5iE1qifQqowG7sj9ZMrhlYc278nYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJY30WjBhk8no+i53lmc2qSR3Wr7mPtL44edPCXH6jqJeLF+LZiF3cKBxNkHzvQYeEBWnUCaLfFyO3+hdb0Zk85FlxaUjOBhbiDqvfWmd2sbqSfXVUwWOstGtC5o1Bh8r7wjvKT04l45lANPBZzS2lqvw8Yy2LGPTAtjWPANdR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aUbT7Qvp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758164251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Q759OacMcRF/860MmGQo6bLHEi1R2UR4+GXvy2W91Y=;
	b=aUbT7QvpXC1yqMdbm0gqu4nCrfbtTLssqk5L4MRN0PbZnPV2LHq2bcyTN4QFmP4w25rXKv
	bUu0tR9uwr+iPGGF3DtMViHuaiN2M0QFo9o8eRrlB2eyD8DGk7rk+O9Jd60D0ACNeqYdea
	a5WZcfoF9NJho9DH6KXw586lRe3DDg4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-ya0XvetYMf-oj4j9ylFM-Q-1; Wed,
 17 Sep 2025 22:57:28 -0400
X-MC-Unique: ya0XvetYMf-oj4j9ylFM-Q-1
X-Mimecast-MFC-AGG-ID: ya0XvetYMf-oj4j9ylFM-Q_1758164247
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1AB4F180045C;
	Thu, 18 Sep 2025 02:57:27 +0000 (UTC)
Received: from localhost (unknown [10.72.112.180])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F38A119560B1;
	Thu, 18 Sep 2025 02:57:25 +0000 (UTC)
Date: Thu, 18 Sep 2025 10:57:22 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 04/10] mm/vmalloc: Avoid cond_resched() when blocking
 is not permitted
Message-ID: <aMt1Eo9G8uS2UNwX@MiWiFi-R3L-srv>
References: <20250915134041.151462-1-urezki@gmail.com>
 <20250915134041.151462-5-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915134041.151462-5-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/15/25 at 03:40pm, Uladzislau Rezki (Sony) wrote:
> vm_area_alloc_pages() contains the only voluntary reschedule points
> along vmalloc() allocation path. They are needed to ensure forward
> progress on PREEMPT_NONE kernels under contention for vmap metadata
> (e.g. alloc_vmap_area()).
> 
> However, yielding should only be done if the given GFP flags allow
> blocking. This patch avoids calling cond_resched() when allocation
> context is non-blocking(GFP_ATOMIC, GFP_NOWAIT).
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 49a0f81930a8..b77e8be75f10 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3633,7 +3633,9 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  							pages + nr_allocated);
>  
>  			nr_allocated += nr;
> -			cond_resched();
> +
> +			if (gfpflags_allow_blocking(gfp))
> +				cond_resched();
>  
>  			/*
>  			 * If zero or pages were obtained partly,
> @@ -3675,7 +3677,9 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  		for (i = 0; i < (1U << order); i++)
>  			pages[nr_allocated + i] = page + i;
>  
> -		cond_resched();
> +		if (gfpflags_allow_blocking(gfp))
> +			cond_resched();
> +
>  		nr_allocated += 1U << order;
>  	}
>  
> -- 
> 2.47.3
> 



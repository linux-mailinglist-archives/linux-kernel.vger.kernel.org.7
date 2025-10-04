Return-Path: <linux-kernel+bounces-841938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C003BB894E
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 06:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8E124E1E59
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 04:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B53215F42;
	Sat,  4 Oct 2025 04:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvKvIDbK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FF323CB
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 04:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759551130; cv=none; b=cK1l3Xgj76zXuPOczE0CUP+RK37pmN9t71EqriZ0kBJLqnA9luPZjAJ/n3g/Pgv7kwILoD23B/muweQ+Xz88zEMZ6spdG6cpT5TTKXFGiO3E4eI+3wR+U80qpBbkvW7MLecyEqixkIUimjAmhQjilVkUqpDJmxyLOhPY1KFW9FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759551130; c=relaxed/simple;
	bh=Qo7TVx+zfj3Bg1+Sj3suyAIZEdpJ0+OU+sj2ev+/yiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RljsZw55W2pfc60Lo9HOS1tOKFuzAA32vP215FsFnExkFoCIGRtKxpga23CqRLI21kfA2Umb9ssJX8Qvcb8v8RAb22VdmKJYc5uxOJ13DqfDPR6LPfAN2qXWtKWDq9+D6z5+STWPClg71Mm4jmeA83J5s7X3cQc39u3Ho/uandg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bvKvIDbK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759551127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G1FMci1EMwWYl4LzKrGkXp3JLbCopyApeUNyqyTFkQU=;
	b=bvKvIDbKVVI8drkeJ0KsPzamYTKGUXhxD+cHW0XWK9dlEL03Qf+YzJLztPf8deFRkUoatM
	YHMNo5pG2icbAy4B9sygm/NOYm9Ngq08OW/0h2JQYi3ZuS/w7ciemhLaike17/lwyAg6YK
	8o/97GY2zNXhA1PyRt35/woAjyVBScI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-sb34xGJwPW-Pi7P9XxP_Qg-1; Sat,
 04 Oct 2025 00:12:04 -0400
X-MC-Unique: sb34xGJwPW-Pi7P9XxP_Qg-1
X-Mimecast-MFC-AGG-ID: sb34xGJwPW-Pi7P9XxP_Qg_1759551123
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D70E51800452;
	Sat,  4 Oct 2025 04:12:02 +0000 (UTC)
Received: from localhost (unknown [10.72.112.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A818B300018D;
	Sat,  4 Oct 2025 04:12:01 +0000 (UTC)
Date: Sat, 4 Oct 2025 12:11:57 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3 09/10] mm/vmalloc: Update __vmalloc_node_range()
 documentation
Message-ID: <aOCejd0aghFS8iSO@MiWiFi-R3L-srv>
References: <20251001192647.195204-1-urezki@gmail.com>
 <20251001192647.195204-10-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001192647.195204-10-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 10/01/25 at 09:26pm, Uladzislau Rezki (Sony) wrote:
> __vmalloc() function now supports non-blocking flags such as
> GFP_ATOMIC and GFP_NOWAIT. Update the documentation accordingly.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d7e7049e01f8..2b45cd4ce119 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3881,19 +3881,20 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>   * @caller:		  caller's return address
>   *
>   * Allocate enough pages to cover @size from the page level
> - * allocator with @gfp_mask flags. Please note that the full set of gfp
> - * flags are not supported. GFP_KERNEL, GFP_NOFS and GFP_NOIO are all
> - * supported.
> - * Zone modifiers are not supported. From the reclaim modifiers
> - * __GFP_DIRECT_RECLAIM is required (aka GFP_NOWAIT is not supported)
> - * and only __GFP_NOFAIL is supported (i.e. __GFP_NORETRY and
> - * __GFP_RETRY_MAYFAIL are not supported).
> + * allocator with @gfp_mask flags and map them into contiguous
> + * virtual range with protection @prot.
>   *
> - * __GFP_NOWARN can be used to suppress failures messages.
> + * Supported GFP classes: %GFP_KERNEL, %GFP_ATOMIC, %GFP_NOWAIT,
> + * %GFP_NOFS and %GFP_NOIO. Zone modifiers are not supported.
> + * Please note %GFP_ATOMIC and %GFP_NOWAIT are supported only
> + * by __vmalloc().
> +
> + * Retry modifiers: only %__GFP_NOFAIL is supported; %__GFP_NORETRY
> + * and %__GFP_RETRY_MAYFAIL are not supported.

Do we need to update the documentation of __vmalloc_node_noprof()
accordingly? I see it has below description about "Retry modifiers"
where gfp_mask is passed down to __vmalloc_node_range_noprof() directly
but have different description. Not sure if I missed anything.

===
 * Retry modifiers: only %__GFP_NOFAIL is supported; %__GFP_NORETRY
 * and %__GFP_RETRY_MAYFAIL are not supported.
===

>   *
> - * Map them into contiguous kernel virtual space, using a pagetable
> - * protection of @prot.
> + * %__GFP_NOWARN can be used to suppress failure messages.
>   *
> + * Can not be called from interrupt nor NMI contexts.
>   * Return: the address of the area or %NULL on failure
>   */
>  void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
> -- 
> 2.47.3
> 



Return-Path: <linux-kernel+bounces-852376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCAFBD8CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFCFA18A12F1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9172FB0B7;
	Tue, 14 Oct 2025 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QElc9laJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EAF2FABF5
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760438979; cv=none; b=U4AQbkZTW1Wbbf8kn/wLG14dr7C3mF21nSFawOScjbZaQakwtpqMKT4mu+BTPayxOQN9IHceLBo/C0qib0Z7X56/qOi85Km4vwaBJIa4+id2WD3IDCZi5+ExQZeRkq0fYIN1laPtOFnlcmpX/7CiH70dA1pCSzOPdlauFUfndrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760438979; c=relaxed/simple;
	bh=hk3VbXAGPXm/u8anqdEtFV/+w0PdLx7mmvJFPincWIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvf1r0KXMbLDjab1M7x7pkaJtwcDHU+F/LmbLBLRmMC7jwoRUWolb4+589W0TuOiGDlUWTwxGHQoZF6sUOlQBJrvUFRIxTwuLmvGHwgVHZIAjpDoUnn1vcp6P7cePDHL+4F2tmVBwG2wXkiW36QIqEvBrSWhhE3sRj4ejNCqHrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QElc9laJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760438976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l72lVU6du75JvK+9reLQWVCcrvoZ1EJITOrS1vD5KTI=;
	b=QElc9laJ0svpzDz24ksyapGA5f/gdJrE5oenSbVJAFUNXxaH3oegp1DShCzIQebSSw5IzP
	6KvvpbQ0FaPeuPPTSYAZrwUxiKo/9T/CD5vRWIUgb4ebc8IqpFluS7iou+/lUwxacuDAc7
	GapKPkTjHdbiFxwbIAVTxramfRT8hQk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-dJEVaODDNPu-uqFti9Cx2Q-1; Tue,
 14 Oct 2025 06:49:31 -0400
X-MC-Unique: dJEVaODDNPu-uqFti9Cx2Q-1
X-Mimecast-MFC-AGG-ID: dJEVaODDNPu-uqFti9Cx2Q_1760438970
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 594091800562;
	Tue, 14 Oct 2025 10:49:30 +0000 (UTC)
Received: from localhost (unknown [10.72.112.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28B9319560B8;
	Tue, 14 Oct 2025 10:49:28 +0000 (UTC)
Date: Tue, 14 Oct 2025 18:49:24 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vmalloc: Update __vmalloc_node_noprof() documentation
Message-ID: <aO4qtMe8iMdcs0EV@MiWiFi-R3L-srv>
References: <20251013174222.90123-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013174222.90123-1-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 10/13/25 at 07:42pm, Uladzislau Rezki (Sony) wrote:
> The kernel-doc for the __vmalloc_node_noprof() incorrectly states
> that __GFP_NOFAIL reclaim modifier is not supported. In fact it has
> been supported since commit 9376130c390a ("mm/vmalloc: add support
> for __GFP_NOFAIL").
> 
> To avoid duplication and future drift, point this helper's doc to
> __vmalloc_node_range_noprof() for details and the full description.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 9a63c91c6150..c31fa69cc530 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4027,11 +4027,8 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>   * Allocate enough pages to cover @size from the page level allocator with
>   * @gfp_mask flags.  Map them into contiguous kernel virtual space.
>   *
> - * Reclaim modifiers in @gfp_mask - __GFP_NORETRY, __GFP_RETRY_MAYFAIL
> - * and __GFP_NOFAIL are not supported
> - *
> - * Any use of gfp flags outside of GFP_KERNEL should be consulted
> - * with mm people.
> + * Semantics of @gfp_mask(including reclaim/retry modifiers such as
> + * __GFP_NOFAIL) are the same as in __vmalloc_node_range_noprof().
>   *
>   * Return: pointer to the allocated memory or %NULL on error
>   */
> -- 
> 2.47.3
> 



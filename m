Return-Path: <linux-kernel+bounces-821961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C07B82B33
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 063757B5289
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10616209F5A;
	Thu, 18 Sep 2025 03:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gcys4znh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FC01A5B8A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758164511; cv=none; b=ECqFPcJal35Aii+GO+4Tm0D3a8IE5OXaOg99pPZo30Y15+RMbmlcQJieSqR5H4+Rytk2eNdfB89osazepuUDRiFlEgFJ8+kigF6ux8HUH//mjU37124hFDMFJB0p16/08cg+ouBwEVUOqEuA/mJvHN0ID0YF5vKY0OmpzbvNkvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758164511; c=relaxed/simple;
	bh=PYxlHM58wqXpkO7LiyjrFeZFsY+h4gHRvT9pQSMdceo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6nUz/pNTghmdfAeAC6mFjHBQHXqggtuZzTkZAnU0LW9Vp5o6V62IS3xXdDw/NmP7KRWqg3wFG+9uPWfWsLKyehpCdxzVO8vqZi553rYFjolHEb0ehykmZlcFo1nvHX90Tf2dXMEAWV6aZnGmyxInFA7EjYvwZwTAd4q+eqdeDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gcys4znh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758164508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0UstZYnDTYubWSPv257SpAM28nLgTIajqfeOeGwdEyA=;
	b=Gcys4znhiW+zukwr4P5S4JvUXONaXs/5SGxHykY0qzKXUHeyaAEK1betKA0wc559rbk4yM
	d6f8JSOB8eEZltjNqeYElQQdAk63CIal0h1cqylA3MXCWcfqw0cNm9s2UAgG/7Q8Yj6kjk
	n7CcbW8BU6GDYNoZxYsr3NJIN6kwlF4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-KwOoJ9HdPXWb_jhpI_xUnw-1; Wed,
 17 Sep 2025 23:01:43 -0400
X-MC-Unique: KwOoJ9HdPXWb_jhpI_xUnw-1
X-Mimecast-MFC-AGG-ID: KwOoJ9HdPXWb_jhpI_xUnw_1758164502
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A40601800576;
	Thu, 18 Sep 2025 03:01:42 +0000 (UTC)
Received: from localhost (unknown [10.72.112.180])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8892B1955F21;
	Thu, 18 Sep 2025 03:01:41 +0000 (UTC)
Date: Thu, 18 Sep 2025 11:01:37 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 06/10] mm/vmalloc: Handle non-blocking GFP in
 __vmalloc_area_node()
Message-ID: <aMt2EUYD75Wqz1p6@MiWiFi-R3L-srv>
References: <20250915134041.151462-1-urezki@gmail.com>
 <20250915134041.151462-7-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915134041.151462-7-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 09/15/25 at 03:40pm, Uladzislau Rezki (Sony) wrote:
> Make __vmalloc_area_node() respect non-blocking GFP masks such
> as GFP_ATOMIC and GFP_NOWAIT.
> 
> - Add memalloc_apply_gfp_scope()/memalloc_restore_scope()
>   helpers to apply a proper scope.
> - Apply memalloc_apply_gfp_scope()/memalloc_restore_scope()
>   around vmap_pages_range() for page table setup.
> - Set "nofail" to false if a non-blocking mask is used, as
>   they are mutually exclusive.
> 
> This is particularly important for page table allocations that
> internally use GFP_PGTABLE_KERNEL, which may sleep unless such
> scope restrictions are applied. For example:
> 
> <snip>
> __pte_alloc_kernel()
>   pte_alloc_one_kernel(&init_mm);
>     pagetable_alloc_noprof(GFP_PGTABLE_KERNEL & ~__GFP_HIGHMEM, 0);
> <snip>
> 
> Note: in most cases, PTE entries are established only up to the
> level required by current vmap space usage, meaning the page tables
> are typically fully populated during the mapping process.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  include/linux/vmalloc.h |  2 ++
>  mm/vmalloc.c            | 52 +++++++++++++++++++++++++++++++++--------
>  2 files changed, 44 insertions(+), 10 deletions(-)

Reviewed-by: Baoquan He <bhe@redhat.com>



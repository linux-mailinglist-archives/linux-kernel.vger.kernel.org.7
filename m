Return-Path: <linux-kernel+bounces-831337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E335DB9C643
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A3D4A05B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0566D28488A;
	Wed, 24 Sep 2025 22:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="JCkCMpg9"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85CE25FA1D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758754321; cv=none; b=WxVllYLvurHjxYmzh3azd+sT+Qho+MeGAP03j9kFwxp7iHnfM7kY+sYgM2faomj/lj3qZ6RmtwoAkG68xFDPRLwaZ4sYgbXdBFlzZ0qvb8/Lf1EqZh2pU7ykdhpFOCJLkKE9feaeWfqdZ29o34QAiAp5MIhx9xNAZNgjl8F89Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758754321; c=relaxed/simple;
	bh=IYb7VmkC8waq1uiEkTNs1ha+Uf22LW177xDsSZHKOyE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Gv0PfYqWSmAYbppFcOrKZYr/XfClO8usJDHz3bWXKQmKbv1aOnVLjx2mTTESMUpMF4IqDCctoINkrTMCF7s67kaufwhzJXIjX96cU9b30L1PWxLeScJsgxHlsaJ1vOTsjc9pvt3NtkvSlolayRfD8jg+g3aPgVHWMkKWM3VS7b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=JCkCMpg9; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1758754318;
	bh=IYb7VmkC8waq1uiEkTNs1ha+Uf22LW177xDsSZHKOyE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=JCkCMpg9pMvCG5sdzhc/l9xavadn3mVYqBUWq+pWTTDU3r7/d4AWUZCljoC1cWS7U
	 fDA1Fm21fmLvxNdElU/Dn4buonvrfMmPZXnnToA2MLYjgrOTPbTvs+y8CedNIYA0B8
	 M/12NGGm6Z3KqTxAS5c4AWa+axj2Mkbgz0UcfNwM=
Received: by gentwo.org (Postfix, from userid 1003)
	id D4A7940293; Wed, 24 Sep 2025 15:51:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id D29D74028E;
	Wed, 24 Sep 2025 15:51:58 -0700 (PDT)
Date: Wed, 24 Sep 2025 15:51:58 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Johannes Weiner <hannes@cmpxchg.org>, Chris Mason <clm@fb.com>, 
    Kiryl Shutsemau <kirill@shutemov.name>, 
    "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
    Brendan Jackman <jackmanb@google.com>, 
    David Hildenbrand <david@redhat.com>, 
    Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
    Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
    Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    kernel-team@meta.com
Subject: Re: [PATCH v2 1/4] mm/page_alloc/vmstat: Simplify refresh_cpu_vm_stats
 change detection
In-Reply-To: <20250924204409.1706524-2-joshua.hahnjy@gmail.com>
Message-ID: <fdb56260-8235-eb20-05cd-491fd512cec0@gentwo.org>
References: <20250924204409.1706524-1-joshua.hahnjy@gmail.com> <20250924204409.1706524-2-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 24 Sep 2025, Joshua Hahn wrote:

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d1d037f97c5f..77e7d9a5f149 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2561,10 +2561,10 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>   * Called from the vmstat counter updater to decay the PCP high.
>   * Return whether there are addition works to do.
>   */
> -int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
> +bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
>  {
>  	int high_min, to_drain, batch;
> -	int todo = 0;
> +	bool todo;

	todo = false

is needed here.



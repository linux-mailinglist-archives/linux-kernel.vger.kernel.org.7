Return-Path: <linux-kernel+bounces-823011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B58B854C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15155171F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595262F2609;
	Thu, 18 Sep 2025 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="h9zX28Pi"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D4C223702
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206319; cv=none; b=H1REmTpwFfEFRUSL+wymhDqA/cTVXffwsQbASTgR/Fds021elPD4e4Lik2a3g+dC0/CvekwhX3rMpAO6e0j52/vj9ARREBZSb55sOOUnR7dQPGM0wFO7SjImKmPOyEU2yk6Gw/iZaCUFq01nMqzDPeaykUIUzMAhMCmo2GFxbYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206319; c=relaxed/simple;
	bh=bHqHm7e3ng/1D/OVJNSHq2E8VDX9XAxCFPk8cVA9vn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLqb/jw+iKBhQTAbvfQ4xF7IIff8KFwlu9f1LUgR94g5sImCOKixlbkEDO5xu+61CXSUUepiBTrrqMkWge7zgNLK7pde/kt56XZGzMPNk5XKOCj6EiAkDM4Eqt7TZrgdaHjZVfvo0u+x4hfYFHWWmjUhAhoKNCrHVgDmdpH+ORs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=h9zX28Pi; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-79390b83c7dso8262506d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1758206316; x=1758811116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OXo7Z6a2sgLXno3+k/FlpZhS1UzmF3Oswcd7rfRRafg=;
        b=h9zX28Pifk3T5S3yRidsG+qV2MfUP5R0sI3FTREJVRDtMMwiJS9+/zoVHDmlHTGcRo
         GC2ifuk8eRP9pOsVy8ZwZ8U5UJBZKCEbxcBX1p2vwP/0qPZksy6fluBPH+SO9z6P54Tw
         KGY87xmJBXG93zPu4LENNIBd2yeXfPfyjPMV25Gsj3UMNRxzI6p9ZVIvnNX7sHfNi3/H
         KWhPeVjvPjBRzm6f3fQ4Ab9JAdatbQa934L8MKOuQYuQo4z/+bUnUXMlBLu7kOR9qlqg
         qZh4nX78RbRRU4Z2Ff069w2L7+x7sn5ILI9r3UVoyfx7J1FFKk7KLcrTinN38KxYscNI
         drxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758206316; x=1758811116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXo7Z6a2sgLXno3+k/FlpZhS1UzmF3Oswcd7rfRRafg=;
        b=SS1ovkaj/+AKAuBWtHhlAbtHpVXEJyV79Fx8ZDMjtBIRBBfgq4AIM4Lh3TdIVMtbm0
         FAC2X4T4ilcEl6UvpCUuKfDSP8yBBT0kxLgrALS2xfXdd6kGHGw+A+jMz5+1Nn2DLOZU
         godO12IM5rhP4HsE0L5HuNECqTABcfTRRcmx/9yud7syxddi3CeUBEu8Jn0EGSKsBU3Z
         FQZu1Z//NkGTlJhy0alt4kTn3ynUD9SW2oGt3fvsk/k6iU0GW+7LX74vikTNkCvEM4D/
         Ob68Ahb2FuQvZO4QfjkWU7VDwzHTycnIjOna0/CkSWrlK2kmz5bT0PQCfdL3MLn1OFhv
         GXXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQVzBG1tu7CmcKrPvDSC3GA3/+qMlSjltRNwP4JtZ1oevBJKvkAJ0sBmUKYGWtfIhpL7PLGNRYdveXd44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx21Gz4kDVZ+R2KZnnci1H3YualrKx/Ul7My5WbYi0LtiwV5RD/
	7MaQOr8u2w2FGHL32PuVJ+a6wrU0fdZk6AnN1belIxxpApJTMgbF+aHr904w31qwBtU=
X-Gm-Gg: ASbGncvAlXHVWOv7ajZJ46WmMlB8oS62uGSduwqZNOBDnOsQZFZxhcglX9ZHsCbA4Qd
	C6fCAAK7N3iOsZqU6uQrvYVoU1CWUTyU9d8BgNexrQBalIpyDrUpc3T2uJ4/LgzIXeWt5tnd94S
	O9SdB6Uo1rxgVMigpQO3EnnI1u+OobC/eIA9NrrVpMm6HB+vbYxJ9TH0sn8CPcYywjJcqMV4ZrM
	vBtLGka1oH90X2/h5N+MdqI2UAF0xZF6AswcpSDEweB6OuZyYLPUfnLXqCa3OA/ZV+sgy0wRQFn
	ugs1awU+kQmaQdzVuIdEz+ym3VV3VS8q7ItEOYaI60MJb4yplYokGd/Uq9s91UPXPMzamiRGL79
	LXETgr5imOPyg0aHTcBoH6DBKpkQ+IiVSuoXCe+vx
X-Google-Smtp-Source: AGHT+IGfoackJcqv2FUQjy7cqufVkoDvxBHVcVbjZdSQNUMCoEqd8Yh5cnnk7r3+CbXlF520+mJIdQ==
X-Received: by 2002:ad4:5e8a:0:b0:78e:49a0:2ba4 with SMTP id 6a1803df08f44-78ecf111245mr63140536d6.58.1758206316038;
        Thu, 18 Sep 2025 07:38:36 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-793548c6e02sm13732616d6.60.2025.09.18.07.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:38:35 -0700 (PDT)
Date: Thu, 18 Sep 2025 10:38:33 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: kirill@shutemov.name
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH 2/2] mm/rmap: Improve mlock tracking for large folios
Message-ID: <20250918143833.GD828739@cmpxchg.org>
References: <20250918112157.410172-1-kirill@shutemov.name>
 <20250918112157.410172-3-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918112157.410172-3-kirill@shutemov.name>

On Thu, Sep 18, 2025 at 12:21:57PM +0100, kirill@shutemov.name wrote:
> From: Kiryl Shutsemau <kas@kernel.org>
> 
> The kernel currently does not mlock large folios when adding them to
> rmap, stating that it is difficult to confirm that the folio is fully
> mapped and safe to mlock it. However, nowadays the caller passes a
> number of pages of the folio that are getting mapped, making it easy to
> check if the entire folio is mapped to the VMA.
> 
> mlock the folio on rmap if it is fully mapped to the VMA.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

> ---
>  mm/rmap.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 568198e9efc2..ca8d4ef42c2d 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1478,13 +1478,8 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
>  				 PageAnonExclusive(cur_page), folio);
>  	}
>  
> -	/*
> -	 * For large folio, only mlock it if it's fully mapped to VMA. It's
> -	 * not easy to check whether the large folio is fully mapped to VMA
> -	 * here. Only mlock normal 4K folio and leave page reclaim to handle
> -	 * large folio.
> -	 */
> -	if (!folio_test_large(folio))
> +	/* Only mlock it if the folio is fully mapped to the VMA */
> +	if (folio_nr_pages(folio) == nr_pages)
>  		mlock_vma_folio(folio, vma);

Minor nit, but it might be useful to still mention in the comment that
partially mapped folios are punted to reclaim.


Return-Path: <linux-kernel+bounces-861341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31315BF278D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72EB118C1C25
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15D226B955;
	Mon, 20 Oct 2025 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="HVyW9qzN"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D2C19F115
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978131; cv=none; b=B3N0rwSiYRcAAlL5kGwdrTLn7v4Q41224h2mik/svc6FRP2M4omnA0Hekcl0EYF4COqjNdfiScIgXt+2WB/8BNhmsBb9ezswRWHDd8J9K1NcvLFG5QALkKul9S71IGOAM1rDGDvGiCuLIfPGHSp+NQYazb+jJHKhEVdD4Agw9x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978131; c=relaxed/simple;
	bh=Ggl4GURIKN0o4pra5emg8y/1hbzWm6LY8VHCYb4NIP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OImp/s6nV3XX5E6turWmNEUgmX9yk7LrMFky2/KDMZG+0oPteJEUg9GjgyfPK4FsgbiyiMmTQILMEgvskcXgoghXBv/9xdNcslul/sQ1hrXkcds7adzYKkEbJ9bhdrjVKSuQM/CWQDfjkrQ/IXx6qRVEU5t42bF2sENRkzvQsQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HVyW9qzN; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-87c148fb575so72948726d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760978128; x=1761582928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m6jVHb7ezLC5hsANkudCILXiAJL70RDGwYPCifMHsG4=;
        b=HVyW9qzN3r7JyDdOhkzVNVMRjKfXShlEXghBy0iVYI+i4F1J/q3coVFXeXHhmeKCaW
         2F/c7WYqrCrGenP9z9zJVqW8AZG0PBZENZdyzckNaHxYqDbGULE4tImwssTJ1IEDLc5P
         d+HA0vbUtS2cNsA9DXx439ztAPdZjeOxBgFjJ6J8aftkNE+xHpjtrM83mQiOczTeZosM
         74rl5tWn+bQd0Jh2+3zOuoYEoM+4U/sHGS71auVtUhTQl7YH5ltAurDzE5OW76oNJbtU
         ZWLtscjfCarnmuSJUMcXhD80xl5QNOzqhf3se66BQ9ucmPzDDC6MVXI29fiqHPjODSZN
         lGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760978128; x=1761582928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6jVHb7ezLC5hsANkudCILXiAJL70RDGwYPCifMHsG4=;
        b=RCxVeaLrt3wrgRbSOsi+Wugznl7E9i/RS/SgklaPReYO5mWf4TzUmHiSJna4GdYftG
         fxBEGGppGxOevvaNcAurtjXe35uHTZjVGbW879CH7RTSscIwNe/cWQ5jQAQUtMtzkZCS
         DXDL7abhdB9BOXxSeaHHQplggRnJ4qqYCqOq3VYFoj2z4A5836XUpmQHjcGheaRIC4yZ
         74kqhwac6B+11n5DZB9XJGjzGp1QUhFld03DaZuTe5XkE/Xl67vgyCaRE2YWWUoiCdJl
         B3asviGprtLSL/dHGJNdN4QtYEdgFMa8X2BiCO0GpRxPIQOVGcTjpUOTspToN4A142d6
         VshA==
X-Forwarded-Encrypted: i=1; AJvYcCUSL/EP2i5j8cvFgFoI0daTilotHEwbB8sjTGx0rbsf3sAqocd9TDPBSZv/pkTKvbbo6N5x7EiEEHKv7lU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQBc0+tx9HyiM7Pwsdh1WNsmo0tL283VApaZmBfbj8mpXkvOEu
	Pi70EiiqTN9u2UfkUY3kPedE/+5k/x4UGJqr2pMsT3l710kNjgcZZCpOCazHze9yyvI=
X-Gm-Gg: ASbGncs0hOIrM8nGLUGMgfigzp4St2hetMu/4sNwgUl1U7+n6GzGIiE2+nVE/NvGZnF
	Ah5B97CstuXl56LOTmdJJghkeSgGfeW8WC6JzCSiICtddEGIfIoHnLbSxmvJBC9bdn8eM9u+HKJ
	0YCrRgpv/DMvr5BZ7vJPH2whrhhbB9GudkTSjwGzCk3eWco8x+FD/YiG1rcalc+odnTDGDPECYc
	t8B19lvdIxqBuQZWISLfldDW9GOW4WxhnSCVeQ8Df45VxpsM0TnbFqV7MieZOXUJz3XbQWlOfvC
	s9uCLRcHEoPN9Ggl6aTxUZCmSj6I4YSVv7ZZbvBR0DSaUsKPGEkJh+uBrC9dp5dHYUd/a0V1N4Z
	OyzvOQ6k0tAlJL/XlGjerbXjEnNFuNDoIEKZ39JLqWzidrs40ZPP1I2MZDG3+h8Okky+cZi8Iqy
	bxYQYFdxcXpQmsydGk9h46vgOhH72nDfgZTQRb6iB/5HDghovOup6ySEt0QE0=
X-Google-Smtp-Source: AGHT+IGyom00LhOrlga+gwQAQ7ZtNc5cObbKCtXH8k1bXmEvQN3xISJWYitE42OrQ56dVinEXqIIkA==
X-Received: by 2002:a05:6214:4e83:b0:87c:2213:ee81 with SMTP id 6a1803df08f44-87c2213f473mr139696046d6.33.1760978127833;
        Mon, 20 Oct 2025 09:35:27 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028b4316sm53736976d6.53.2025.10.20.09.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:35:27 -0700 (PDT)
Date: Mon, 20 Oct 2025 12:35:25 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, osalvador@suse.de, corbet@lwn.net,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	hannes@cmpxchg.org, laoar.shao@gmail.com, mclapinski@google.com,
	joel.granados@kernel.org, jack@suse.cz, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@suse.com>,
	Alexandru Moise <00moses.alexander00@gmail.com>,
	David Rientjes <rientjes@google.com>
Subject: Re: [RFC PATCH] mm, hugetlb: implement movable_gigantic_pages sysctl
Message-ID: <aPZkzY6cGfdKo8K8@gourry-fedora-PF4VCD3F>
References: <20251009161515.422292-1-gourry@gourry.net>
 <6fe3562d-49b2-4975-aa86-e139c535ad00@redhat.com>
 <aPZd1dAIzAw7Ii8E@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPZd1dAIzAw7Ii8E@gourry-fedora-PF4VCD3F>

On Mon, Oct 20, 2025 at 12:05:41PM -0400, Gregory Price wrote:
> On Mon, Oct 20, 2025 at 04:17:06PM +0200, David Hildenbrand wrote:
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 5549b32cdd31..5def2c53092e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6922,8 +6922,12 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
>                 if (PageReserved(page))
>                         return false;
> 
> -               if (PageHuge(page))
> -                       return false;
> +               if (PageHuge(page)) {
> +                       /* Don't consider moving same size/larger pages */
> +                       if (!CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION ||
> +                           ((1 << compound_order(page)) >= nr_pages))
> +                               return false;
> +               }
>         }
>         return true;
>  }

Quick spot-check of the compaction code suggests this is handled
essentially the same way - and in fact compaction expects
alloc_contig to be sending compaction requests w/ hugepages.

So I'll go ahead and submit this separately for discussion.

~Gregory

---

->isolate_migratepages_range()
->isolate_migratepages_block()
{
...
	if (PageHuge(page)) {
		const unsigned int order = compound_order(page);
		/*
		 * skip hugetlbfs if we are not compacting for pages
		 * bigger than its order. THPs and other compound pages
		 * are handled below.
		 */
		 ...
		/* for alloc_contig case */
		if (locked) {
			unlock_page_lruvec_irqrestore(locked, flags);
			locked = NULL;
		}

	 }
...
	/*
	 * Regardless of being on LRU, compound pages such as THP
	 * (hugetlbfs is handled above) are not to be compacted unless
	 * we are attempting an allocation larger than the compound
	 * page size. We can potentially save a lot of iterations if we
	 * skip them at once. The check is racy, but we can consider
	 * only valid values and the only danger is skipping too much.
	 */
	if (PageCompound(page) && !cc->alloc_contig) {
		const unsigned int order = compound_order(page);

		/* Skip based on page order and compaction target order. */
		if (skip_isolation_on_order(order, cc->order)) {
			if (order <= MAX_PAGE_ORDER) {
				low_pfn += (1UL << order) - 1;
				nr_scanned += (1UL << order) - 1;
			}
			goto isolate_fail;
		}
	}
}


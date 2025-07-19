Return-Path: <linux-kernel+bounces-737465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F2CB0AD16
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 02:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577BE5A3409
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 00:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1549D7260A;
	Sat, 19 Jul 2025 00:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SrrsQzE/"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B1936D
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 00:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752886290; cv=none; b=IyMO6fbGiY2T/R1LDXFMIQMfRZUCDzCdq8pYlgQkM6rm2dGSr8nTQVtrmEeYJVpuX27cu1oo0FZA4uUHjT+T2E/KeDTaVOOxPPBQZyI/80lTkwYZDNVqQDsvlKzINYzbvh8k0MX3G/RtGItYBdZ1SUH4QQ6udXLV0xeugRqK9JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752886290; c=relaxed/simple;
	bh=LPZ6l9YFFRRJK9zF47wttA4pWhfV9T45TbPtI10ONJM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DMjH19Kk4d12Kf0I+MGwO942X2UHKa6obP4l52+BG8F0SHApfJreEN1K22i4c6k5ttDNEubwDyjhuudJI5N84lL0ybwXvZa8nxup99m+Y5TzB5JDEanOUJxCqFT0Dm81m0wcC2J9KhtZovqmJuiS4w1XbSp4NZYxwI2x8LHN8x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SrrsQzE/; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e8d707b9bc2so1908408276.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752886288; x=1753491088; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VLA2HjCsJilgmCjXGe+HwENBmUw8Mc0GyNWvAB/59Z4=;
        b=SrrsQzE/CfoDIYH2eGI2bCMG8x2SifF/jWoODCzdoD3+GZfXas5u49nv2fm2tTQs83
         07LoGpap78BcnHyeqJnWnsDx6k9MZ3h3J2owkIohLvcM5ZOfZp61NXS3RzvmY8Hrib5f
         JvBdPH3xpbFNBxSo7cnnBk4T93dcb23XI4//zaUb/+JFPB7+OLvmzpc4sn4Wog57O1CB
         ztxSbakf9kPZVmUPmL3TCvHyCXL1f2A7ldGfdfmMWlNysGuAnlkfHo/OOW0PKQ0fYPLq
         yg3j9vTQdDhU8if2eoTTD51u9NWBxrVZ0My4Z0X09y4eqHQwFbdmlH6ajESDVmnRF5dD
         YRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752886288; x=1753491088;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLA2HjCsJilgmCjXGe+HwENBmUw8Mc0GyNWvAB/59Z4=;
        b=WPgPIJt7UhWvWBJKqCaJY3aSU1omu8Eoy7qSO0Ex+jxiXY238D3KBYtNz4dWAWNird
         iRnoO2y2R9199xZpoVXIIAxrSTBlMKq7UnGb5dtth79rifJnjaXGKcEZl5z68pqmTjqR
         M8l81DgYuHFImwhYYopLIzBoWxQZsdVHt4dOqA7Wr2kjm24Kgtr5dIAEdy4lEKMDykre
         m3/c9hkkJIphYTPk0Ymyi6w7NeEvjP8bYlsASTD6+vkoc4DYm4vsdbFTwFNvZor+46PE
         3zis+zvIRKx1N1gbeZfp5sS11OpZ0+OM0Mg4AKmwUoi1OW7vwiuOa7dNv6qaU2v/3ywk
         FQAw==
X-Forwarded-Encrypted: i=1; AJvYcCWHJsmyAUqpF/CA/EQS67ObodLUdssQX/2HcZyDp3ZsP6tebkAAUWUZv8I/QE1VsaKqIP/DrH5q6gkzp/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBgGbCceB2++vlRXBnPQKGI4eWJ7139aouSlpXMXU7XxiD464c
	48bRgvntky8M80UjxXilGkNeBlwMMhm5Kr+5Moo1HQqS5JiYnThupi6q/cCej/NxBw==
X-Gm-Gg: ASbGncvAgxi2yojzpXHIlgM2L5seXGMxMGrnG4E7Rd7eOpXceP8Ouo3jehGYRiL7P2b
	xVtlX+Md2ssJFAAZLeR6Hu8tO+DysD0xZeJ/Wrfeo9XDxRTa3ZOPGYDn6JfK5aQJ5m7wlOeOunZ
	6+cXx5LZ3gf+Hvh0P9/TVQJHxHMZAs2LFnv0Jq6M3ZxbXI67JSV23XqqxycthxHlT5fJYVb7NR7
	LcbO8F2roJsbLV/pelSJO8Bcl6sIwBvOquvpjMd3JvMmW0XlubGdwjsLlsk2KEeO2jH5WrOCtjO
	c6aXOXKPpuCX7rnd3dCyBw7ja9An/rBYy+zYpZcSuqFlrXniJgi35zbEFmLRIEEEdwKzm/Ni0AW
	1cXxJV/96hAOKO92bdKHVxpwlqEPs+6C6BW1mfTwYqUprKNKsBGyLkJjnNPf59q9mJjWhYI477o
	wZ+BvvBwc=
X-Google-Smtp-Source: AGHT+IGg9f4qdm3LH8bGi05lrhAzWO5XxarVsdy/66jmvAkbANg8MgTxs9g+ar65cvjQTEFW7sWjEw==
X-Received: by 2002:a05:690c:311:b0:718:38bd:bb44 with SMTP id 00721157ae682-71838bdd008mr160685557b3.39.1752886287517;
        Fri, 18 Jul 2025 17:51:27 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7195335c284sm5931557b3.106.2025.07.18.17.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 17:51:25 -0700 (PDT)
Date: Fri, 18 Jul 2025 17:51:16 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Baoquan He <bhe@redhat.com>, Barry Song <21cnbao@gmail.com>, 
    Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
    Kairui Song <ryncsn@gmail.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
    Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: Re: [PATCH mm-new 2/2] mm/shmem: writeout free swap if swap_writeout()
 reactivates
In-Reply-To: <853a5211-cdab-4bdf-b0c4-8092dd943ff5@linux.alibaba.com>
Message-ID: <a6f83e63-c5af-cd27-5379-0e8fcb347e18@google.com>
References: <87beaec6-a3b0-ce7a-c892-1e1e5bd57aa3@google.com> <5c911f7a-af7a-5029-1dd4-2e00b66d565c@google.com> <853a5211-cdab-4bdf-b0c4-8092dd943ff5@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 17 Jul 2025, Baolin Wang wrote:

> Hi Hugh,
> 
> On 2025/7/16 16:08, Hugh Dickins wrote:
> > If swap_writeout() returns AOP_WRITEPAGE_ACTIVATE (for example, because
> > zswap cannot compress and memcg disables writeback), there is no virtue
> > in keeping that folio in swap cache and holding the swap allocation:
> > shmem_writeout() switch it back to shmem page cache before returning.
> > 
> > Folio lock is held, and folio->memcg_data remains set throughout, so
> > there is no need to get into any memcg or memsw charge complications:
> > swap_free_nr() and delete_from_swap_cache() do as much as is needed (but
> > beware the race with shmem_free_swap() when inode truncated or evicted).
> > 
> > Doing the same for an anonymous folio is harder, since it will usually
> > have been unmapped, with references to the swap left in the page tables.
> > Adding a function to remap the folio would be fun, but not worthwhile
> > unless it has other uses, or an urgent bug with anon is demonstrated.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> >   mm/shmem.c | 33 ++++++++++++++++++++++++++++++++-
> >   1 file changed, 32 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 33675361031b..5a7ce4c8bad6 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1655,6 +1655,7 @@ int shmem_writeout(struct folio *folio, struct
> > swap_iocb **plug,
> >   
> >    if (!folio_alloc_swap(folio, __GFP_HIGH | __GFP_NOMEMALLOC |
> >    __GFP_NOWARN)) {
> >   		bool first_swapped = shmem_recalc_inode(inode, 0, nr_pages);
> > +		int error;
> >   
> >     /*
> >   		 * Add inode to shmem_unuse()'s list of swapped-out inodes,
> > @@ -1675,7 +1676,37 @@ int shmem_writeout(struct folio *folio, struct
> > swap_iocb **plug,
> >     shmem_delete_from_page_cache(folio, swp_to_radix_entry(folio->swap));
> >   
> >   		BUG_ON(folio_mapped(folio));
> > -		return swap_writeout(folio, plug);
> > +		error = swap_writeout(folio, plug);
> > +		if (error != AOP_WRITEPAGE_ACTIVATE) {
> > +			/* folio has been unlocked */
> > +			return error;
> > +		}
> > +
> > +		/*
> > +		 * The intention here is to avoid holding on to the swap when
> > +		 * zswap was unable to compress and unable to writeback; but
> > +		 * it will be appropriate if other reactivate cases are added.
> > +		 */
> > +		error = shmem_add_to_page_cache(folio, mapping, index,
> > +				swp_to_radix_entry(folio->swap),
> > +				__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN);
> > +		/* Swap entry might be erased by racing shmem_free_swap() */
> > +		if (!error) {
> > +			spin_lock(&info->lock);
> > +			info->swapped -= nr_pages;
> > +			spin_unlock(&info->lock);
> 
> Using the helper 'shmem_recalc_inode(inode, 0, -nr_pages)' seems more
> readable?

Yes, that's better, thanks: I don't know if I'd say "more readable",
but it is much more in the spirit of shmem_recalc_inode(), bringing
the counts into balance sooner rather than later.

I'll follow up with a "fix" patch to Andrew.

> 
> > +			swap_free_nr(folio->swap, nr_pages);
> > +		}
> > +
> > +		/*
> > +		 * The delete_from_swap_cache() below could be left for
> > +		 * shrink_folio_list()'s folio_free_swap() to dispose of;
> > +		 * but I'm a little nervous about letting this folio out of
> > +		 * shmem_writeout() in a hybrid half-tmpfs-half-swap state
> > +		 * e.g. folio_mapping(folio) might give an unexpected answer.
> > +		 */
> > +		delete_from_swap_cache(folio);
> 
> IIUC, Should the delete_from_swap_cache() also be moved into the 'if (!error)'
> branch? Since if shmem_free_swap() has freed the swap entry, it would also
> reclaim the swap cache, no?

No, but it was a good point to raise, and led into more research than
I had anticipated.

No: because shmem_free_swap->free_swap_and_cache_nr->__try_to_reclaim_swap
has to return after doing nothing if its folio_trylock fails: it cannot do
the delete_from_swap_cache() part of the job, which we do here - on this
AOP_WRITEPAGE_ACTIVATE path, we hold the folio_lock throughout.

But it led into more research, because I wanted to point you to the
equivalent coding in shmem_swapin_folio(): but, to my initial alarm,
the equivalent is not there; but used to be.

See 5.8 commit 14235ab36019 ("mm: shmem: remove rare optimization when
swapin races with hole punching").  There (in the deleted lines) you can
see the helpful comment on this case, with its delete_from_swap_cache()
when shmem_add_to_page_cache() fails.  But for memcg-charging reasons,
5.8 found it simpler to drop that, and just let shrink_page_list()
clear up the debris later.

Here in shmem_writeout(), holding folio_lock throughout, we have no
memcg complications, and can go ahead with delete_from_swap_cache(),
both when successfully added back to page cache, and when that fails.

Thanks for checking!
Hugh


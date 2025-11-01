Return-Path: <linux-kernel+bounces-881178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A73C27A60
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 09:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C371A2676B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 09:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC6929E113;
	Sat,  1 Nov 2025 08:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RddyooWm"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5C43D76
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761987586; cv=none; b=rznQTdDsUo12TV+LebLShUObkG65IWbYn5tgixyj0GjJnPcXOOktBMu8QJR6W2e7EsPzGeRV1hwgoYn9vTz0UDgyiKlTrELlMDXwwORi657BgnmoH4SMI8csqHWBoPI2I3jYThd/piwK6oRkHD67Nb0nfRKcq37CMWpocFsvN4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761987586; c=relaxed/simple;
	bh=x7GPnj2XcxD7M5+Xe/blcltL0abnPj3KuSePddy7wUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivU1lo8cvGj9xEFg+NvJ9kPx8IHyHiurS/tdrg1ZbyeslFIIdDw0Ve1RP0i5QP1SYfHhnQ/fKuBKh8uyY13HSAEokaxaEcfrECc1rpElJCJRLV+j7Qj7dH3Rf/sMFD5akPiirKvOtDlg3sVp8bQvKyWbj8ndj1OEEPnilRQZ+qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RddyooWm; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63e0cec110eso5375035a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 01:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761987583; x=1762592383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pR8Ekz6erdqjHJx6BchTSxJ/OmeWD1sA0olQ5hB+/A=;
        b=RddyooWmUJUhUaSnKZxeGYlzosNSfY1o1D60No4FDqMNmbqUXbeocvMPVyHiJTOZyK
         swD1NdZSZuL3qfnUr8WSLhmw2A9OuWT+gqw38b99nYN8ZxPHZ87sw3S/kf3rzQliPdMg
         /1XEMdles2HtdQvXGfbPn5RABy7uLgGzQiNvZcKYhf1jyPAFDk+ZJTH+17otnS6PQyjn
         b7d2QIqX3PgqbTEHvHJeuWwLfATGsGUBP+G7I7WOQaRWaMcDSvXp/rF+xWOscaq/EbyV
         Waya6XZasG97iToOTmbnmYZHr5ZpfkFVJdMuVHb27daL5g4esGIVhIFEq+plLmsfs+cF
         wb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761987583; x=1762592383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1pR8Ekz6erdqjHJx6BchTSxJ/OmeWD1sA0olQ5hB+/A=;
        b=Hu9Re+gVV98F6zwy7BQJ5DzSOl7j7wROYYHLfMa53IKEK9NmGbWssvCT4E55aYIo6X
         2r7Kp36t6mRT8Mr4ke0qP4D9z9WC0b9ok1RlNmgVBxaACy27SdGQMIr4+zHrsE276b5t
         4+lWkkPyvyGbu6KbeZ4knd14s7Z+sNKT5TO45626eC75Ha2EdCANKZ42bGI1th7g2cvl
         W8wMC9C43NAPTEN7dOrTo0+lzpPCNrFDPTtJzVUrUrv7IFYPS2H86sAmOVrFBuqprJ0z
         AP13IhaxnFTHPtHl6LTw03uq6RDLfcMVBrYIG9YwLjl3ISXp6C/FuxDPXiUxTURdwd8q
         tM0A==
X-Forwarded-Encrypted: i=1; AJvYcCUwwUo9KGA/yM5bJeAfowJ2Ah+JqM7/KhU6S4qS4wPTyZbjXaglRJb9hv0nvyfyzrPs9kPSNhDRFnDyoRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG/awihrpfJrE6+BQSiT99ZVAcIC63ix2yi8yq9vTvahIS8Hyg
	PPLozoftBDAgecyc4poD5UKtymXsABYNamlxvTwg6NdHI71I+CG7xYkTMDI0AD6kRu7koosiExi
	KoMMCdvq5NXxlJvrxPmPLwzNIlX+FpMw=
X-Gm-Gg: ASbGncsAVWzrIWvhTeFCNGI12dloffHr6yCOMRFMwjg6wBzRXL7Ls+UAOBJu1U2/IRb
	JwlSoTJasOKNfzezscP5NdygaEA6O1dXLXGd3jRD8HHcMLxXq2PrKNKYIQ67a/QNcNKKjrWg+mB
	TKnvTvoOgGRaZEnLsrmGBMkYMyDc/1lgZmR5/B5sQ1hs7wHVpyrJkNe3TlzSnrEuwM6csdQ/ZaE
	/XK/+RbR2ZV37UxrU4BUV63iHEi7kzKaQQFkz7RTykehrExthLtyUi9Rpx0
X-Google-Smtp-Source: AGHT+IE31nMuSrKicWOYIZlFDzMUvDlYlzlW9D6irYkq3pMBpvPm1LUOFv2OM9SELcI/pEdEGJLs2UXmY+rsOiWN9mQ=
X-Received: by 2002:a05:6402:35cb:b0:640:80cc:f0f4 with SMTP id
 4fb4d7f45d1cf-64080ccfb90mr3634783a12.29.1761987582568; Sat, 01 Nov 2025
 01:59:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
 <20251029-swap-table-p2-v1-14-3d43f3b6ec32@tencent.com> <aQWR3fK/GtTkx0kX@yjaykim-PowerEdge-T330>
In-Reply-To: <aQWR3fK/GtTkx0kX@yjaykim-PowerEdge-T330>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 1 Nov 2025 16:59:05 +0800
X-Gm-Features: AWmQ_bm4zbd4WMYvcZZe-6woFHP9CTVY8mskA0CTMQ0lCP368NaFqz6cpzv47FA
Message-ID: <CAMgjq7DtP4j4kQp-bM+jrVSkCh26+8U-TkENxUmPkmEJyZg9YA@mail.gmail.com>
Subject: Re: [PATCH 14/19] mm, swap: sanitize swap entry management workflow
To: YoungJun Park <youngjun.park@lge.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 12:51=E2=80=AFPM YoungJun Park <youngjun.park@lge.co=
m> wrote:
>
> On Wed, Oct 29, 2025 at 11:58:40PM +0800, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
>
> Hello Kairui!
>
> > The current swap entry allocation/freeing workflow has never had a clea=
r
> > definition. This makes it hard to debug or add new optimizations.
> >
> > This commit introduces a proper definition of how swap entries would be
> > allocated and freed. Now, most operations are folio based, so they will
> > never exceed one swap cluster, and we now have a cleaner border between
> > swap and the rest of mm, making it much easier to follow and debug,
> > especially with new added sanity checks. Also making more optimization
> > possible.
> >
> > Swap entry will be mostly allocated and free with a folio bound.
> > The folio lock will be useful for resolving many swap ralated races.
> >
> > Now swap allocation (except hibernation) always starts with a folio in
> > the swap cache, and gets duped/freed protected by the folio lock:
> >
> > - folio_alloc_swap() - The only allocation entry point now.
> >   Context: The folio must be locked.
> >   This allocates one or a set of continuous swap slots for a folio and
> >   binds them to the folio by adding the folio to the swap cache. The
> >   swap slots' swap count start with zero value.
> >
> > - folio_dup_swap() - Increase the swap count of one or more entries.
> >   Context: The folio must be locked and in the swap cache. For now, the
> >   caller still has to lock the new swap entry owner (e.g., PTL).
> >   This increases the ref count of swap entries allocated to a folio.
> >   Newly allocated swap slots' count has to be increased by this helper
> >   as the folio got unmapped (and swap entries got installed).
> >
> > - folio_put_swap() - Decrease the swap count of one or more entries.
> >   Context: The folio must be locked and in the swap cache. For now, the
> >   caller still has to lock the new swap entry owner (e.g., PTL).
> >   This decreases the ref count of swap entries allocated to a folio.
> >   Typically, swapin will decrease the swap count as the folio got
> >   installed back and the swap entry got uninstalled
> >
> >   This won't remove the folio from the swap cache and free the
> >   slot. Lazy freeing of swap cache is helpful for reducing IO.
> >   There is already a folio_free_swap() for immediate cache reclaim.
> >   This part could be further optimized later.
> >
> > The above locking constraints could be further relaxed when the swap
> > table if fully implemented. Currently dup still needs the caller
> > to lock the swap entry container (e.g. PTL), or a concurrent zap
> > may underflow the swap count.
> >
> > Some swap users need to interact with swap count without involving foli=
o
> > (e.g. forking/zapping the page table or mapping truncate without swapin=
).
> > In such cases, the caller has to ensure there is no race condition on
> > whatever owns the swap count and use the below helpers:
> >
> > - swap_put_entries_direct() - Decrease the swap count directly.
> >   Context: The caller must lock whatever is referencing the slots to
> >   avoid a race.
> >
> >   Typically the page table zapping or shmem mapping truncate will need
> >   to free swap slots directly. If a slot is cached (has a folio bound),
> >   this will also try to release the swap cache.
> >
> > - swap_dup_entry_direct() - Increase the swap count directly.
> >   Context: The caller must lock whatever is referencing the entries to
> >   avoid race, and the entries must already have a swap count > 1.
> >
> >   Typically, forking will need to copy the page table and hence needs t=
o
> >   increase the swap count of the entries in the table. The page table i=
s
> >   locked while referencing the swap entries, so the entries all have a
> >   swap count > 1 and can't be freed.
> >
> > Hibernation subsystem is a bit different, so two special wrappers are h=
ere:
> >
> > - swap_alloc_hibernation_slot() - Allocate one entry from one device.
> > - swap_free_hibernation_slot() - Free one entry allocated by the above
> > helper.
>
> During the code review, I found something to be verified.
> It is not directly releavant your patch,
> I send the email for checking it right and possible fix on this patch.
>
> on the swap_alloc_hibernation_slot function
> nr_swap_pages is decreased. but as I think it is decreased on swap_range_=
alloc.
>
> The nr_swap_pages are decremented as the callflow as like the below.
>
> cluster_alloc_swap_entry -> alloc_swap_scan_cluster
> -> closter_alloc_range -> swap_range_alloc
>
> Introduced on
> 4f78252da887ee7e9d1875dd6e07d9baa936c04f
> mm: swap: move nr_swap_pages counter decrement  from folio_alloc_swap() t=
o swap_range_alloc()
>

Yeah, you are right, that's a bug introduced by 4f78252da887, will you
send a patch to fix that ? Or I can send one, just remove the
atomic_long_dec(&nr_swap_pages) in get_swap_page_of_type then we are
fine.


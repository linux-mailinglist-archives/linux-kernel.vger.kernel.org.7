Return-Path: <linux-kernel+bounces-806219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34130B493C2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA143BAC5B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F8B30F7E6;
	Mon,  8 Sep 2025 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yhq3mmEL"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4957C30DED8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345966; cv=none; b=Ps1SpZ9q+6oR6NjkJVpJTt0ZDnJlsqqF2JsIKkq616SaGvq4zg7/3n0dklaq/ciWpF/Sff5cUeoMF6LFCOlblFnTF+sXlDMEON6H08k4QyMEknu1gRQbxTnoiypGt+EoslMGJE2fpIzFRbW3LI1OezaFLShGZAxWSig9iwi5UIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345966; c=relaxed/simple;
	bh=7Joa235dMXbaGR/0P8CaB74jeMQ5OGhSqUDmv4iYY+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkLgrqVXxTaW0rEG+bOHf8lWs3hf6Xud5U30exfI/R/4d7FvwgK9enukeuLrDnqkCCDJMujkHfoYpzp7d6EDwK9WWzKl5rcbJvjo0yxB7AqSF6vy0xqNY5wRWpSJ039abmS5geI3r/HaP0wLGpwHNNEbT9TguGnwVg+1Ak87CRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yhq3mmEL; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso1872485a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757345962; x=1757950762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzjRY7OCEhANtHRWQB+PpwrfD3gB0K9s93cny8H02tg=;
        b=Yhq3mmELsq12omAtvqgAuHPEjm6uaYs/pD0nG6gDN9x6pVY1jZc9lJ5ofs4FHyXia5
         RSRj3dS+71VpLKEUBJnAqM2zbJQyd62OFar1TbgyD79mpDT/TumsK6omgjr6SDhOfcde
         I2JPA8DZeeVdYM5XDrCRZbdIpt+QVDVrZk0AYPNgw/PvWRmSWC3bNhsGko21IJUCN83i
         wAxFG+T8aTiE0xaAJ4drujxrUq93kdWznrUV87RkTxe2rRrjhTd85mcyi9MTqppHsMJh
         /TxVEs4t9c+ZeRaJA6GcszWM2fnXjA9Mo/fnonpfVYTZUwy54nszW5tIEPWvhq+v78Bw
         ilrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757345962; x=1757950762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzjRY7OCEhANtHRWQB+PpwrfD3gB0K9s93cny8H02tg=;
        b=OkEJW9JX3Qaf5OS7oZ/d7LHOxx+BoqDCGAfvxQoTOrD9metyjJqH7VF9wQve/3PoOz
         M+MkD5Uei8jqw4smO9NGx59gF8ueTZn0anK6HQH/wFH0esjELFLzpMyLdbxHAh/Ywy+b
         mXSWTk1HzGghAXZktZB2vs6t1Gnf1W9ygLc5ZhrskUI7PUYiL0q8JPfccZG+NKVNWV3x
         dUQSwJBs8VMFJ68Mn+VKGMkkoyDFNuMxe5jF2vAAiRUi2t1CrUvGq1SjxG8xZC8e5+TO
         /nrFzjHvTD9Gi2yR7163iXBRCfWO6XOIE4PJQH+eolSw9VwfHpwLQGZ/qvYCIjkwLNFn
         aaRw==
X-Forwarded-Encrypted: i=1; AJvYcCXIWKHq7qbCnGOVChMCnUYfRHCwg0X32/sd+z2YEhA6bBSd9aDazEB15L7v3HwuV/LVSTStQs/KhW/A0bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZY1Mm/78XVJ1hCjdYyb+z+EAWpx/vRshkKWVQSbtxOzM5PBAP
	x3owaqE9IT/ZxMqQ10L3k+j/X8hmayKHKG7rjtGrwt8/WYwDISwVVQ5NZawZazYrWaKzE1OFs7c
	LoesBgysKAwS0ferG/5o323ENdn0+NyQ=
X-Gm-Gg: ASbGncusHhZEOyBmjIB7KrvIpvEaefKLz7BzwSbWKx1qATlw2CIAclr8FKAH1+aw0XC
	v2NxHQHJRbE9YY/jk5ccHc93X1BX6RMPYG8fb8oLzH/0d9BXC0g6IPEXk8GKKeEmrL/YWO+xD9N
	BLao8T18J3q4WEQTh7cbUXsDdaQDtiF/2FI6xdw2elnUMaXx6rT7bthxbOim33PYXYrnRAcFAt9
	Y2dU4K86FhScbrKIb1eUA==
X-Google-Smtp-Source: AGHT+IE6vIcWEitB/WEHH3m91SXOReU2BzV1xyn5fSZTas3gakszgk+FTNuCFOHNNE7e1L+wE/DVue/0/y5UWyLKzfI=
X-Received: by 2002:a05:6402:4416:b0:626:d96d:c0bb with SMTP id
 4fb4d7f45d1cf-626d96dc3e8mr5927847a12.9.1757345962344; Mon, 08 Sep 2025
 08:39:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-12-ryncsn@gmail.com>
 <CAF8kJuPJU78Dw7iFXK1avk1CCwaRSskK6yPgib0984MjhM3ptQ@mail.gmail.com>
In-Reply-To: <CAF8kJuPJU78Dw7iFXK1avk1CCwaRSskK6yPgib0984MjhM3ptQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 8 Sep 2025 23:38:46 +0800
X-Gm-Features: AS18NWBmxiajmfScv2n3P7by4ia3vaKho37OVplgg0Syg1odlI9ln-a46gnuIlg
Message-ID: <CAMgjq7AxBa6Y8vi1Fbj1Lua6ODfDwfqfGHTjhGtn24LBjManuA@mail.gmail.com>
Subject: Re: [PATCH v2 11/15] mm, swap: use the swap table for the swap cache
 and switch API
To: Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 11:35=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> Acked-by: Chris Li <chrisl@kernel.org>
>
> Some nitpick follows.
>
> Chris

Thanks!

> > +
> > +/*
> > + * swap_cluster_lock_by_folio - Locks the cluster that holds a folio's=
 entries.
> > + * @folio: The folio.
> > + *
> > + * This locks the swap cluster that contains a folio's swap entries. T=
he
> > + * swap entries of a folio are always in one single cluster, and a loc=
ked
> > + * swap cache folio is enough to stabilize the entries and the swap de=
vice.
>
> I was wondering if we have a better word than stabilize, we haven't
> defined what does stabilize mean. I assume it means protecting from
> racing access to the swap cache entry. If we describe what it protects
> or what it prevents, that would give more detailed meaning than
> stabilize.

Right, I used to use the word "pin". What it means here is: locking
the folio will ensure folio->swap won't change so the folio will have
a stable bind with the swap cluster its folio->swap points to. Also
the swap device can't be swapped off so there is no risk of UAF.

How about:

 * This locks the swap cluster that contains a folio's swap entries. The
 * swap entries of a folio are always in one single cluster. The folio has
 * to be locked so its swap entries won't change and the cluster is binded
 * to the folio.

...

> > @@ -123,57 +136,45 @@ void *swap_cache_get_shadow(swp_entry_t entry)
> >   * SWAP_HAS_CACHE to avoid race or conflict.
> >   * Return: Returns 0 on success, error code otherwise.
> >   */
> > -int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
> > -                        gfp_t gfp, void **shadowp)
> > +void swap_cache_add_folio(struct folio *folio, swp_entry_t entry, void=
 **shadowp)
> >  {
> > -       struct address_space *address_space =3D swap_address_space(entr=
y);
> > -       pgoff_t idx =3D swap_cache_index(entry);
> > -       XA_STATE_ORDER(xas, &address_space->i_pages, idx, folio_order(f=
olio));
> > -       unsigned long i, nr =3D folio_nr_pages(folio);
> > -       void *old;
> > -
> > -       xas_set_update(&xas, workingset_update_node);
> > -
> > -       VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> > -       VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
> > -       VM_BUG_ON_FOLIO(!folio_test_swapbacked(folio), folio);
> > +       void *shadow =3D NULL;
> > +       unsigned long swp_tb, exist;
> > +       struct swap_cluster_info *ci;
> > +       unsigned int ci_start, ci_off, ci_end;
> > +       unsigned long nr_pages =3D folio_nr_pages(folio);
> > +
> > +       VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
> > +       VM_WARN_ON_ONCE_FOLIO(folio_test_swapcache(folio), folio);
> > +       VM_WARN_ON_ONCE_FOLIO(!folio_test_swapbacked(folio), folio);
> > +
> > +       swp_tb =3D folio_to_swp_tb(folio);
> > +       ci_start =3D swp_cluster_offset(entry);
> > +       ci_end =3D ci_start + nr_pages;
> > +       ci_off =3D ci_start;
> > +       ci =3D swap_cluster_lock(__swap_entry_to_info(entry), swp_offse=
t(entry));
> > +       do {
> > +               exist =3D __swap_table_xchg(ci, ci_off, swp_tb);
>
> Thanks for changing it to xchg. I understand that by "exist" you mean
> the previous existing swap table entry. However after it was taken out
> from the swap table, is it still considered an "existing entry"? I am
> considering "old" or "prior" might be a better name. Just nitpicks
> anyway. If we use "old", we can rename "swp_tb" to "new_tb" to make it
> obvious what we are replacing with.

Good suggestion.

>
> Also I saw this kind of for loop repeat a few places.
> Maybe considering some for loop macro to do:
>
> for_each_folio_offset(folio, ci, ci_off) {
>       exist =3D __swap_table_xchg(ci, ci_off, swp_tb);
>       ...
> } end_for_each_folio_offset();
>
> The kernel has a lot of similar for loop macros.
>

There seem to be only a few users like this, but I can have a try.
Will use this style if it helps to reduce LOC or make it easier.
Thanks!


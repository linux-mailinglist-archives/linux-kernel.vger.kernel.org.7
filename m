Return-Path: <linux-kernel+bounces-808480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2FAB50054
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96DE04E71B9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFCA350822;
	Tue,  9 Sep 2025 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bf/l+ArI"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB73F350D77
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429700; cv=none; b=hLKGmN2PcCFbjH+PE9/RhDTWOiGxDHqVQi20T/I90FpPihuw6VWslJN5kmOWujUy21A6A+V4Zvu93mPRqhaeUhx1U9CbtnxVLQLNFvGFmReCFfIo0nHU/IB79HUCsKh1XyyGgVR729WNjEM2uB7jiENH6xuf98dMdAoQmYxmW9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429700; c=relaxed/simple;
	bh=ciGJKXOEN0Cr6JCNlySQlowtRSx6HHxITdJSUYo19sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LxXyFM364TmFszckRvuDqMi7ndQGcqigmo66lPEvV4rYsd//8IR2PzYjLJjIbk5/vlspcHDOmb299f+3RPm1huRhAIozpDmPFU/hsN8qHZvod6qLfXSYwOiykw0X39c2Bt8ZhjV25kvK+O2wrK5jUbHchVujWlMWBqm1i+N6J8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bf/l+ArI; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-624fdf51b44so3484133a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757429697; x=1758034497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GWXE+3wBOcPt7oKnTkYOal1ucKO7Pnm2lZVyHLTocM=;
        b=Bf/l+ArI53hwS7driH1ucr3hNhu5E+EmmP7Yz/7xjgM5njSy6QRHURyoMTqgUAEo6j
         MXGuCP65T2m/j8cUZA/mJVczpsmTm9KOFbe3o2e6dxhTdGWSMnO2PHDjNmPge5UBkTSd
         dVlnfjikFEg1TTuk9xRtL3+D62MzHpn7fmImFYv48SCZhZrCQzMqo+VRn5+VB+FQzZux
         MVpePLUguTrXIK6kCuquwBhH2AU5Ar2TJYdbCGBWkF6WJczevYigrvjAOThh43faZkzK
         /AeZCqUdDHfdnEWokiFr2mrZeu+q94auRlEEHcCF0DLFoKfENI+PFI1Ae7w/Yc+hEHEb
         zkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757429697; x=1758034497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GWXE+3wBOcPt7oKnTkYOal1ucKO7Pnm2lZVyHLTocM=;
        b=Xio62KLfZxq6YAg2zcc9UxwmqP/sSoAcnR1kdTleOOMfYHxWmYIkgHnaGtZEAjzM16
         K6CK3mpjQvLxL8PHJalr8XlDPNPfUSmn982OadLjUmQluFUzBF1K4MQ+CdpmFBLYa9BV
         URgsuunWMRLyVF6gQ/G4Nauy+mNfHf5GP6ZTNLqBUrnku6WY8gHn4VQuLvpaPDZanAhZ
         9mwRjb0UZDwh0J/dO21NUCzQ+oMDbUOxw8B565IH8EGgz0MbTmegSwDjZKDBIIkwG+WU
         j6nhdKIryTT1o/BDms64RhNtmvfm62G+XXfrQAVRF2R9y9kedY185XoQuefEhdJhTZe7
         3YTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn4QZUxo2ba7dmfg38fV6zLBzYWZZ9O5+1CZqFaQtUoIpoui2NOmn7Gid218DkX8AN+12fsHuFsurv0PU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk1e1XaMdKBuovoZDAtpXcuxQ9zI7ss70MIHIZnee4iymTPfYc
	JgIzFDthdGJ+nQhHdIXPD7Bo4AwnxjagXOKpTElJeR9OBwxSwLYL8niFvQapcK3LH1HETHyoiu7
	EVufVr1ckwuJLfQnMtj+fuuDiGTMYk0w=
X-Gm-Gg: ASbGnctCynO6toth22Hz8uQgyKlkg2qSLgAwxuJYotzPVEN1gzG23QoMDDLCIaclrOk
	J/8LCVwtRcg0y3Yor7SUR+IGQFcK2hncCjK1/NQ6idII0fTpPIUgTqR1of4vPia8Mwix5pKjs23
	y+NGHWac5YF/6kb7SpbXmuZ7WPgJlB0ob9+q0Te07qbytveEeT+/XqVKl+x+9we9keZu8fJQQH7
	ES9YwRhGW0xnQMft8g8GQ==
X-Google-Smtp-Source: AGHT+IEMt+u1ClOjcV2n5CQ17ZjrpPmx/eiarEJGhF0xznnFrQSXo9j9Ba6/99ZFdT4zmW929GCRlOqIyVzGOUfqDZQ=
X-Received: by 2002:a05:6402:23ce:b0:621:99dc:8cea with SMTP id
 4fb4d7f45d1cf-6237cdccd25mr9687939a12.37.1757429697063; Tue, 09 Sep 2025
 07:54:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-5-ryncsn@gmail.com>
 <bd8338cf-6723-46ef-9043-3ced8be56e62@redhat.com>
In-Reply-To: <bd8338cf-6723-46ef-9043-3ced8be56e62@redhat.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 9 Sep 2025 22:54:20 +0800
X-Gm-Features: AS18NWC1_9y38Nsi39iOZh1hJsvE5_7RXH2EllayI3pifDOFrHDVGEcDnTcEUrc
Message-ID: <CAMgjq7BPk1PJn0JGo+ERnisSimG0FSuiQZHDY3bf2gBgE5rU1g@mail.gmail.com>
Subject: Re: [PATCH v2 04/15] mm, swap: check page poison flag after locking it
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 8:40=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 05.09.25 21:13, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > Instead of checking the poison flag only in the fast swap cache lookup
> > path, always check the poison flags after locking a swap cache folio.
> >
> > There are two reasons to do so.
> >
> > The folio is unstable and could be removed from the swap cache anytime,
> > so it's totally possible that the folio is no longer the backing folio
> > of a swap entry, and could be an irrelevant poisoned folio. We might
> > mistakenly kill a faulting process.
> >
> > And it's totally possible or even common for the slow swap in path
> > (swapin_readahead) to bring in a cached folio. The cache folio could be
> > poisoned, too. Only checking the poison flag in the fast path will miss
> > such folios.
> >
> > The race window is tiny, so it's very unlikely to happen, though.
> > While at it, also add a unlikely prefix.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >   mm/memory.c | 22 +++++++++++-----------
> >   1 file changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 10ef528a5f44..94a5928e8ace 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4661,10 +4661,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >               goto out;
> >
> >       folio =3D swap_cache_get_folio(entry);
> > -     if (folio) {
> > +     if (folio)
> >               swap_update_readahead(folio, vma, vmf->address);
> > -             page =3D folio_file_page(folio, swp_offset(entry));
> > -     }
> >       swapcache =3D folio;
> >
> >       if (!folio) {
> > @@ -4735,20 +4733,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >               ret =3D VM_FAULT_MAJOR;
> >               count_vm_event(PGMAJFAULT);
> >               count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
> > -             page =3D folio_file_page(folio, swp_offset(entry));
> > -     } else if (PageHWPoison(page)) {
> > -             /*
> > -              * hwpoisoned dirty swapcache pages are kept for killing
> > -              * owner processes (which may be unknown at hwpoison time=
)
> > -              */
> > -             ret =3D VM_FAULT_HWPOISON;
> > -             goto out_release;
> >       }
> >
> >       ret |=3D folio_lock_or_retry(folio, vmf);
> >       if (ret & VM_FAULT_RETRY)
> >               goto out_release;
> >
> > +     page =3D folio_file_page(folio, swp_offset(entry));
> >       if (swapcache) {
> >               /*
> >                * Make sure folio_free_swap() or swapoff did not release=
 the
> > @@ -4761,6 +4752,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                            page_swap_entry(page).val !=3D entry.val))
> >                       goto out_page;
> >
> > +             if (unlikely(PageHWPoison(page))) {
> > +                     /*
> > +                      * hwpoisoned dirty swapcache pages are kept for =
killing
> > +                      * owner processes (which may be unknown at hwpoi=
son time)
> > +                      */
> > +                     ret =3D VM_FAULT_HWPOISON;
> > +                     goto out_page;
> > +             }
> > +
> >               /*
> >                * KSM sometimes has to copy on read faults, for example,=
 if
> >                * folio->index of non-ksm folios would be nonlinear insi=
de the
>
> LGTM, but I was wondering whether we just want to check that even when

Thanks for checking the patch.

> we just allocated a fresh folio for simplicity. The check is cheap ...
>

Maybe not for now? This patch expects folio_test_swapcache to filter
out potentially irrelevant folios, so moving the check before that is
in theory not correct.. And folio_test_swapcache check won't work for
the fresh allocated folio here...

I'm planning to remove the whole `if (swapcache)` check in phase 2, as
all swapin will go through swap cache. By that time all checks will
always be applied. The simplification will be done in a cleaner way.

> --
> Cheers
>
> David / dhildenb
>
>


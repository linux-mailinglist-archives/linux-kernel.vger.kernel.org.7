Return-Path: <linux-kernel+bounces-673469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAC9ACE1A2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 17:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6780618993BC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 15:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5775219C558;
	Wed,  4 Jun 2025 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xLjRE2n+"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45DC1624DD
	for <linux-kernel@vger.kernel.org>; Wed,  4 Jun 2025 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749051587; cv=none; b=G8yiL+/EOl0L/XW5Xvssns+uVcsZsmf235tNsF2lDeFw3RJLx5fzdFyCQ3pM/qKjCbQ9u8V4Z5qSJNBHEhae7+CQ+8Z0WgXDqg8V4wQWfr3LyRnmMQW2Pqp9UzIV54IXvbzDmHg1ybSrhfTW0Ue580S1wvBlrwwiNKydxehBrSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749051587; c=relaxed/simple;
	bh=DRbtIFSLrs9jcYvzqOyx2Auzxn1+blLgpV3of5W2K3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPQGyvifBcX7NtMrfwxwCET+/HILgs8Pdm2vFQZPClPoYjmcgwJUbUnmyIdB94pEe3YJVVrXNWTEhNLwc6rKtMDVFoyvDsjLnB8271ALshWu0SHU9e/bOYANUjvWz7Kf8oVTJcKV4qSnaH/ytjBRpXr9HdfaJNdHzU4CYbw800A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xLjRE2n+; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a58ef58a38so256981cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jun 2025 08:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749051584; x=1749656384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaIUTtis4g7w9h9/ucFToLx1kZiFQCisI5TV2JiWp7U=;
        b=xLjRE2n+pBtwYK5s20RYtIokKS9LL/N5xTXdszymuijM1wbQcwE+g3xvSWAWa0N8a3
         uW23ZgTUEM8jhbgtX9O2L9u17TsaGzVUjfy/KEAaiqh+vttvHcfso0fj5Wth1YELiTfY
         UnCf9/Dask43QyEIVjNZqJwXHYQCUpUyZy9TjVpKKpWjdieyOAIHHCefZFQLl4pAeta5
         ph1ur1J+oGZ+XsOXbxU38DuY1kCmcKdX1FF3A9y/D0DNF6d3ExHAod9ULxvtl4AxIoPe
         wRuQgzlRALlI8E4qkLKtqpWgOJP5SaJSCid1Uopil15VxvI7cz7+anR5VJHnYuhv349q
         nk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749051584; x=1749656384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaIUTtis4g7w9h9/ucFToLx1kZiFQCisI5TV2JiWp7U=;
        b=NSdH09Om+hWu5GWIZ0jxBdGXCl3Qf6d7AjRJXhauqgFfT1Ic/9cNPzXiYu6Yz+BeA+
         p7NNupvP0f1xSYrbZn6UTvmG2t4f5hiL72MqKhlOJaw2x3hDZvRYqhC8tDMW7iWm+8jt
         kA/+X1AI55J4cEF19/pWTuAF01zw+aLaOpFQ9C00F4cmmRT65BK6r4IficG/hrj4msgJ
         ZGn6ovr9IYFOEL315m5LRmmsXW/9j2Bp1m7wUHYRtZClM04bh5rTWJxmBR3XOOoegZxm
         5M6wZmU7SPS4BVvTLQdyjcs+UbaYD1IJKOoiANpETwZ/jtqNjFN/0aHE0heXtLEodvlW
         BltA==
X-Forwarded-Encrypted: i=1; AJvYcCVcDHANSHnLV8kZPXo9Bw+HUM/gKpuG8ZaPpUcicM4HbHg0YmiUxReIXu1r7M50pgqeE4mhycec47UhKxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOxk521E8QtSdX2Xmt52BVRHg7mReDaq5znHoClkqxSCuzrXar
	GAoBlU5t/o43yIcpFLSEi2ECmSFG674Nkv3iqV6R0TSXy2P3iBmfNiNFiy91XAl72lO2pHLcPvS
	zylcfuQqU6mrJDHqoQ1e0FSN0LGNz1kT/zUHEUXuh
X-Gm-Gg: ASbGncs4jOiTHpnN35bjE2M+85hEnvRSSY2PbdUadC1FPrWtAEfLlpZn1SxZAQruSWl
	ZotGaTZBm+bkUQWevxpY5QrcgOXXZpt3ePtePgSGBqFnTSD9nYQYp2vAPwayNb3QrXS1XeXqE9d
	9Exg77+bMlhRBRHN1Sohiuu1AxxiVkcQGzI8hPb04k6JqGz8HzRTRc+BDbzSLhnHBCzamUf5UP
X-Google-Smtp-Source: AGHT+IGRNN0Nu/Cd9xexZVozmzGYncXDcXneYvDGwMtEg8bwYQBRyVY6g+btTzUvAuW4Pg8yQBu3fuKnwJ8vlqK4mkY=
X-Received: by 2002:a05:622a:551b:b0:494:b641:4851 with SMTP id
 d75a77b69052e-4a5a60fed52mr4023891cf.27.1749051583921; Wed, 04 Jun 2025
 08:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604151038.21968-1-ryncsn@gmail.com> <aEBnjWkghvXqlYZo@x1.local>
In-Reply-To: <aEBnjWkghvXqlYZo@x1.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 4 Jun 2025 08:39:32 -0700
X-Gm-Features: AX0GCFsWpIOVI6OZ80FViRxGFHREe5YmcX2RyGPtytnkb9wTVut9NUMVmwCE9zc
Message-ID: <CAJuCfpHC3eZuTWtzafbNWQHpKxx+vsLkXQcaf5_bZUtjbJos+g@mail.gmail.com>
Subject: Re: [PATCH v4] mm: userfaultfd: fix race of userfaultfd_move and swap cache
To: Peter Xu <peterx@redhat.com>
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Barry Song <21cnbao@gmail.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, 
	Lokesh Gidra <lokeshgidra@google.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 8:34=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Jun 04, 2025 at 11:10:38PM +0800, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > On seeing a swap entry PTE, userfaultfd_move does a lockless swap
> > cache lookup, and tries to move the found folio to the faulting vma.
> > Currently, it relies on checking the PTE value to ensure that the moved
> > folio still belongs to the src swap entry and that no new folio has
> > been added to the swap cache, which turns out to be unreliable.
> >
> > While working and reviewing the swap table series with Barry, following
> > existing races are observed and reproduced [1]:
> >
> > In the example below, move_pages_pte is moving src_pte to dst_pte,
> > where src_pte is a swap entry PTE holding swap entry S1, and S1
> > is not in the swap cache:
> >
> > CPU1                               CPU2
> > userfaultfd_move
> >   move_pages_pte()
> >     entry =3D pte_to_swp_entry(orig_src_pte);
> >     // Here it got entry =3D S1
> >     ... < interrupted> ...
> >                                    <swapin src_pte, alloc and use folio=
 A>
> >                                    // folio A is a new allocated folio
> >                                    // and get installed into src_pte
> >                                    <frees swap entry S1>
> >                                    // src_pte now points to folio A, S1
> >                                    // has swap count =3D=3D 0, it can b=
e freed
> >                                    // by folio_swap_swap or swap
> >                                    // allocator's reclaim.
> >                                    <try to swap out another folio B>
> >                                    // folio B is a folio in another VMA=
.
> >                                    <put folio B to swap cache using S1 =
>
> >                                    // S1 is freed, folio B can use it
> >                                    // for swap out with no problem.
> >                                    ...
> >     folio =3D filemap_get_folio(S1)
> >     // Got folio B here !!!
> >     ... < interrupted again> ...
> >                                    <swapin folio B and free S1>
> >                                    // Now S1 is free to be used again.
> >                                    <swapout src_pte & folio A using S1>
> >                                    // Now src_pte is a swap entry PTE
> >                                    // holding S1 again.
> >     folio_trylock(folio)
> >     move_swap_pte
> >       double_pt_lock
> >       is_pte_pages_stable
> >       // Check passed because src_pte =3D=3D S1
> >       folio_move_anon_rmap(...)
> >       // Moved invalid folio B here !!!
> >
> > The race window is very short and requires multiple collisions of
> > multiple rare events, so it's very unlikely to happen, but with a
> > deliberately constructed reproducer and increased time window, it
> > can be reproduced easily.
> >
> > This can be fixed by checking if the folio returned by filemap is the
> > valid swap cache folio after acquiring the folio lock.
> >
> > Another similar race is possible: filemap_get_folio may return NULL, bu=
t
> > folio (A) could be swapped in and then swapped out again using the same
> > swap entry after the lookup. In such a case, folio (A) may remain in th=
e
> > swap cache, so it must be moved too:
> >
> > CPU1                               CPU2
> > userfaultfd_move
> >   move_pages_pte()
> >     entry =3D pte_to_swp_entry(orig_src_pte);
> >     // Here it got entry =3D S1, and S1 is not in swap cache
> >     folio =3D filemap_get_folio(S1)
> >     // Got NULL
> >     ... < interrupted again> ...
> >                                    <swapin folio A and free S1>
> >                                    <swapout folio A re-using S1>
> >     move_swap_pte
> >       double_pt_lock
> >       is_pte_pages_stable
> >       // Check passed because src_pte =3D=3D S1
> >       folio_move_anon_rmap(...)
> >       // folio A is ignored !!!
> >
> > Fix this by checking the swap cache again after acquiring the src_pte
> > lock. And to avoid the filemap overhead, we check swap_map directly [2]=
.
> >
> > The SWP_SYNCHRONOUS_IO path does make the problem more complex, but so
> > far we don't need to worry about that, since folios can only be exposed
> > to the swap cache in the swap out path, and this is covered in this
> > patch by checking the swap cache again after acquiring the src_pte lock=
.
> >
> > Testing with a simple C program that allocates and moves several GB of
> > memory did not show any observable performance change.
> >
> > Cc: <stable@vger.kernel.org>
> > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > Closes: https://lore.kernel.org/linux-mm/CAMgjq7B1K=3D6OOrK2OUZ0-tqCzi+=
EJt+2_K97TPGoSt=3D9+JwP7Q@mail.gmail.com/ [1]
> > Link: https://lore.kernel.org/all/CAGsJ_4yJhJBo16XhiC-nUzSheyX-V3-nFE+t=
Ai=3D8Y560K8eT=3DA@mail.gmail.com/ [2]
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > Reviewed-by: Lokesh Gidra <lokeshgidra@google.com>

Very interesting races. Thanks for the fix!

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> >
> > ---
> >
> > V1: https://lore.kernel.org/linux-mm/20250530201710.81365-1-ryncsn@gmai=
l.com/
> > Changes:
> > - Check swap_map instead of doing a filemap lookup after acquiring the
> >   PTE lock to minimize critical section overhead [ Barry Song, Lokesh G=
idra ]
> >
> > V2: https://lore.kernel.org/linux-mm/20250601200108.23186-1-ryncsn@gmai=
l.com/
> > Changes:
> > - Move the folio and swap check inside move_swap_pte to avoid skipping
> >   the check and potential overhead [ Lokesh Gidra ]
> > - Add a READ_ONCE for the swap_map read to ensure it reads a up to date=
d
> >   value.
> >
> > V3: https://lore.kernel.org/all/20250602181419.20478-1-ryncsn@gmail.com=
/
> > Changes:
> > - Add more comments and more context in commit message.
> >
> >  mm/userfaultfd.c | 33 +++++++++++++++++++++++++++++++--
> >  1 file changed, 31 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index bc473ad21202..8253978ee0fb 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -1084,8 +1084,18 @@ static int move_swap_pte(struct mm_struct *mm, s=
truct vm_area_struct *dst_vma,
> >                        pte_t orig_dst_pte, pte_t orig_src_pte,
> >                        pmd_t *dst_pmd, pmd_t dst_pmdval,
> >                        spinlock_t *dst_ptl, spinlock_t *src_ptl,
> > -                      struct folio *src_folio)
> > +                      struct folio *src_folio,
> > +                      struct swap_info_struct *si, swp_entry_t entry)
> >  {
> > +     /*
> > +      * Check if the folio still belongs to the target swap entry afte=
r
> > +      * acquiring the lock. Folio can be freed in the swap cache while
> > +      * not locked.
> > +      */
> > +     if (src_folio && unlikely(!folio_test_swapcache(src_folio) ||
> > +                               entry.val !=3D src_folio->swap.val))
> > +             return -EAGAIN;
> > +
> >       double_pt_lock(dst_ptl, src_ptl);
> >
> >       if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src=
_pte,
> > @@ -1102,6 +1112,25 @@ static int move_swap_pte(struct mm_struct *mm, s=
truct vm_area_struct *dst_vma,
> >       if (src_folio) {
> >               folio_move_anon_rmap(src_folio, dst_vma);
> >               src_folio->index =3D linear_page_index(dst_vma, dst_addr)=
;
> > +     } else {
> > +             /*
> > +              * Check if the swap entry is cached after acquiring the =
src_pte
> > +              * lock. Otherwise, we might miss a newly loaded swap cac=
he folio.
> > +              *
> > +              * Check swap_map directly to minimize overhead, READ_ONC=
E is sufficient.
> > +              * We are trying to catch newly added swap cache, the onl=
y possible case is
> > +              * when a folio is swapped in and out again staying in sw=
ap cache, using the
> > +              * same entry before the PTE check above. The PTL is acqu=
ired and released
> > +              * twice, each time after updating the swap_map's flag. S=
o holding
> > +              * the PTL here ensures we see the updated value. False p=
ositive is possible,
> > +              * e.g. SWP_SYNCHRONOUS_IO swapin may set the flag withou=
t touching the
> > +              * cache, or during the tiny synchronization window betwe=
en swap cache and
> > +              * swap_map, but it will be gone very quickly, worst resu=
lt is retry jitters.
> > +              */
>
> The comment above may not be the best I can think of, but I think I'm
> already too harsh. :)  That's good enough to me.  It's also great to
> mention the 2nd race too as Barry suggested in the commit log.
>
> Thank you!
>
> Acked-by: Peter Xu <peterx@redhat.com>
>
> > +             if (READ_ONCE(si->swap_map[swp_offset(entry)]) & SWAP_HAS=
_CACHE) {
> > +                     double_pt_unlock(dst_ptl, src_ptl);
> > +                     return -EAGAIN;
> > +             }
> >       }
> >
> >       orig_src_pte =3D ptep_get_and_clear(mm, src_addr, src_pte);
> > @@ -1412,7 +1441,7 @@ static int move_pages_pte(struct mm_struct *mm, p=
md_t *dst_pmd, pmd_t *src_pmd,
> >               }
> >               err =3D move_swap_pte(mm, dst_vma, dst_addr, src_addr, ds=
t_pte, src_pte,
> >                               orig_dst_pte, orig_src_pte, dst_pmd, dst_=
pmdval,
> > -                             dst_ptl, src_ptl, src_folio);
> > +                             dst_ptl, src_ptl, src_folio, si, entry);
> >       }
> >
> >  out:
> > --
> > 2.49.0
> >
>
> --
> Peter Xu
>


Return-Path: <linux-kernel+bounces-787339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E97B374DE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 00:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2D85E2400
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 22:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79759288502;
	Tue, 26 Aug 2025 22:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vWH8hwgB"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7537626AA83
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 22:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756247024; cv=none; b=QIH065MHmYj/lABXuCl16ymBpDC4EIwGlHvEblcLLhKlATDdpTj3fe+SmNpgyeLGaBxUHX/WOi+rVlngrBPyhBJ3usVzEFggIboG5IajlbO88KcpN3g/GmA/MEajGIHboemGAacZs8I6H5gv0/COthNxmhgvcI+8MMpfb5BBgCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756247024; c=relaxed/simple;
	bh=ANCeMl+L+Gzjz61oeqU8xcvRBeboNAygm63clmz+rtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFa20yY9UnfKgl3fHB430MegEcDUOe4RKKXdJ0+2mUtXG5s3D4No/6C12zGBlI8IAe0F3aARZeG9+35XUw9/diZQ6FY8+nIVVTGGTHks0WpYA9mQyQK6yOYZi1Td0YYr/DPLEql0+bgMNCJsVaS4Ajt+lKEZXAHcjpkIqpbitKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vWH8hwgB; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-618660b684fso4019a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756247021; x=1756851821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdzAj4hdgXbHM9u8eX6/Ze1u+O9VPPOiYd1/e8bzusU=;
        b=vWH8hwgBd26yBklQSqFrgEHRgU1RSs+H4wxMMudv8Zzlx7t0rjJMyiI7qHn2OlvtJt
         C0OyJn5uP1W8DxA1iGdhtq9A/T+jGhR1tDiWNCdhj69Ersi5utizNrCQYlXMyMqnI6aK
         SwPO4v41rkoCnqJfpnXrtC+HAZg0naB5xXQYP7+VVcZr//MlSs8AoqwL3THGBlg6gfZk
         Q8uGcS4NvfFf1+avIozmn4/sZyHLXE103GvnSUaoCNoLSddNJl5z5CzgNyt2Ky3HLKFS
         0CPYDXzo/Kv4d/YTNecbpP65lHu8WzJ7CvMnbVtVA2vGmEkdjL62eVHxNESDikeR03bN
         UX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756247021; x=1756851821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdzAj4hdgXbHM9u8eX6/Ze1u+O9VPPOiYd1/e8bzusU=;
        b=b/DaVNfx8sgGqjio1ddyDwN3YvDn3X5/+i3SLOCtRkpnYoyO47zPZmNhNzJ3XpOsn9
         aA+owSysKAP2u+FRhQbh0AQJxTukeSbqExXsTJFUqaMmVXygtnT0bZEw0YGN2D/wImtf
         r1fkE5QzLhdyULO8Zjc7+QQQT4B5tOGD4HxuoIc+0Tl3FMzULZR11AazCdA3FeL1rEis
         BFjaJMAcULiMCSD09glN8OaCditcF8zHZ8zRxILtlzl/Fd9qyeSNApODQKWBePMMSMt3
         uvOdoeVrhcYnJqyU7yg2PH/XWvSl32RlRdXdhnTJVIGqvHiA4S7s/PNdy3GHp+hoQMT4
         04CA==
X-Forwarded-Encrypted: i=1; AJvYcCX0TcJo0l7STc1hRUz3BFqRXGxyrAe70u8XwMGSaKvKQIYviwT4teI8aZDK/2pY2U8DaUl5j2vLNmqM340=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqCzQLz7gR2AxP2GPCoGxKAiduTh0bOIEw94ofQhGdiFISn0at
	cVR3JpFJ6x4PxJpcF7T9RAUryfzwGG/OUavDAdH4+Ymf8n6vX/kPFsoSy5Nehsa+Vm31j7X4gwz
	eXyKh3auPvWI17xTH68qBobXEWciQcE0KfecMv03J
X-Gm-Gg: ASbGncvTfOZW2FsWxdM/LEF7f74bPhGrsFtUtiNlFSlTW3mOqNrpPK+vxNKa1ytW86e
	ZCrhhE5B2AQNLYXU5nfZ+N+MEltCsvJ0RJKovfHsB5K1nWuf8zTsEKTqhEE566Hw2kzrL6cZ/1T
	CVYXLNgYhifs9QtgVe2LV1chjgxWlP5LQiAuuk+o/8BJo+zYGCFmPtugs/xLV4GSep0nZa+Zj2Q
	tg4D+oJL837z6JihFVIg8DFWnbr0QOWD11H+j3yug==
X-Google-Smtp-Source: AGHT+IH5laHTN2ceQXtx48Rb1PyJw6NCArX3BwpFynb13vIQot7VtB6qXl2BVraBEpEyuBdH6PnHzmOOsPl0buTNmrg=
X-Received: by 2002:aa7:d817:0:b0:61c:ad8d:eeb3 with SMTP id
 4fb4d7f45d1cf-61cad8def77mr105462a12.5.1756247020395; Tue, 26 Aug 2025
 15:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+EESO4Z6wtX7ZMdDHQRe5jAAS_bQ-POq5+4aDx5jh2DvY6UHg@mail.gmail.com>
 <65dd5d54-87ab-49a8-8734-2201a0014feb@lucifer.local>
In-Reply-To: <65dd5d54-87ab-49a8-8734-2201a0014feb@lucifer.local>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Tue, 26 Aug 2025 15:23:28 -0700
X-Gm-Features: Ac12FXxHsj5ejTjMAqm2KdWR-My4JCztbeCu5nshJDlgNWqk9Y_R3t6Y32y6-PI
Message-ID: <CA+EESO5zUO8x21u1KAG5U3Rghaxw8GFGZMhsbM3E2AyeHFYRMw@mail.gmail.com>
Subject: Re: [DISCUSSION] Unconditionally lock folios when calling rmap_walk()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Harry Yoo <harry.yoo@oracle.com>, Zi Yan <ziy@nvidia.com>, Barry Song <21cnbao@gmail.com>, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	android-mm <android-mm@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 8:52=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Aug 22, 2025 at 10:29:52AM -0700, Lokesh Gidra wrote:
> > Hi all,
> >
> > Currently, some callers of rmap_walk() conditionally avoid try-locking
> > non-ksm anon folios. This necessitates serialization through anon_vma
> > write-lock elsewhere when folio->mapping and/or folio->index (fields
> > involved in rmap_walk()) are to be updated. This hurts scalability due
> > to coarse granularity of the lock. For instance, when multiple threads
> > invoke userfaultfd=E2=80=99s MOVE ioctl simultaneously to move distinct=
 pages
> > from the same src VMA, they all contend for the corresponding
> > anon_vma=E2=80=99s lock. Field traces for arm64 android devices reveal =
over
> > 30ms of uninterruptible sleep in the main UI thread, leading to janky
> > user interactions.
>
> Can we clarify whether this is simply an example, or rather the entire
> motivating reason for raising this issue?
>
When I started off I thought maybe there are other cases too, but it
looks like as of now only uffd MOVE updates folio->mapping to a
different root anon_vma.

> It's important, because it strikes me that this is a very specific use
> case, and you're now suggesting changing core locking to suit it.
>
> While this is a discussion, and I'm glad you raised it, I think it's
> important in these cases to really exhaustively examine all of the possib=
le
> consequences.
>
> OK so to clarify:
>
> - You want to traverse the rmap entirely without any rmap locks whatsoeve=
r
>   for anon, relying solely on the folio lock to serialise, because
>   otherwise rmap read locks here block other rmap write lock calls.
>
There is a misunderstanding. I'm suggesting locking *both* folio as
well as anon_vma during rmap walk. To avoid any confusion, here are
the simplifications in mm/rmap.c that I suggest:

diff --git a/mm/rmap.c b/mm/rmap.c
index 568198e9efc2..81c177b0cddf 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -547,7 +547,6 @@ struct anon_vma *folio_lock_anon_vma_read(const
struct folio *folio,
        struct anon_vma *root_anon_vma;
        unsigned long anon_mapping;

-retry:
        rcu_read_lock();
        anon_mapping =3D (unsigned long)READ_ONCE(folio->mapping);
        if ((anon_mapping & FOLIO_MAPPING_FLAGS) !=3D FOLIO_MAPPING_ANON)
@@ -558,17 +557,6 @@ struct anon_vma *folio_lock_anon_vma_read(const
struct folio *folio,
        anon_vma =3D (struct anon_vma *) (anon_mapping - FOLIO_MAPPING_ANON=
);
        root_anon_vma =3D READ_ONCE(anon_vma->root);
        if (down_read_trylock(&root_anon_vma->rwsem)) {
-               /*
-                * folio_move_anon_rmap() might have changed the anon_vma a=
s we
-                * might not hold the folio lock here.
-                */
-               if (unlikely((unsigned long)READ_ONCE(folio->mapping) !=3D
-                            anon_mapping)) {
-                       up_read(&root_anon_vma->rwsem);
-                       rcu_read_unlock();
-                       goto retry;
-               }
-
                /*
                 * If the folio is still mapped, then this anon_vma is stil=
l
                 * its anon_vma, and holding the mutex ensures that it will
@@ -603,18 +591,6 @@ struct anon_vma *folio_lock_anon_vma_read(const
struct folio *folio,
        rcu_read_unlock();
        anon_vma_lock_read(anon_vma);

-       /*
-        * folio_move_anon_rmap() might have changed the anon_vma as we mig=
ht
-        * not hold the folio lock here.
-        */
-       if (unlikely((unsigned long)READ_ONCE(folio->mapping) !=3D
-                    anon_mapping)) {
-               anon_vma_unlock_read(anon_vma);
-               put_anon_vma(anon_vma);
-               anon_vma =3D NULL;
-               goto retry;
-       }
-
        if (atomic_dec_and_test(&anon_vma->refcount)) {
                /*
                 * Oops, we held the last refcount, release the lock
@@ -1006,7 +982,7 @@ int folio_referenced(struct folio *folio, int is_locke=
d,
        if (!folio_raw_mapping(folio))
                return 0;

-       if (!is_locked && (!folio_test_anon(folio) || folio_test_ksm(folio)=
)) {
+       if (!is_locked) {
                we_locked =3D folio_trylock(folio);
                if (!we_locked)
                        return 1;

> - You want to unconditionally folio lock all anon and kSM folios for at
>   least folio_referenced().
>
Actually file and KSM folios are always locked today. The anon folios
are conditionally left out. So my proposal actually standardizes this
locking, which is an overall simplification.

> In order to resolve a scalability issue specific to a uffd usecase?
>
With the requirement of locking anon_vma in write mode, uffd MOVE
currently is unusable in practice due to poor scalability. The above
change in mm/rmap.c allows us to make the following improvement to
MOVE ioctl:

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 45e6290e2e8b..c4fc87d73ab7 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1192,7 +1192,6 @@ static int move_pages_pte(struct mm_struct *mm,
pmd_t *dst_pmd, pmd_t *src_pmd,
        pmd_t dummy_pmdval;
        pmd_t dst_pmdval;
        struct folio *src_folio =3D NULL;
-       struct anon_vma *src_anon_vma =3D NULL;
        struct mmu_notifier_range range;
        int err =3D 0;

@@ -1353,28 +1352,6 @@ static int move_pages_pte(struct mm_struct *mm,
pmd_t *dst_pmd, pmd_t *src_pmd,
                        goto retry;
                }

-               if (!src_anon_vma) {
-                       /*
-                        * folio_referenced walks the anon_vma chain
-                        * without the folio lock. Serialize against it wit=
h
-                        * the anon_vma lock, the folio lock is not enough.
-                        */
-                       src_anon_vma =3D folio_get_anon_vma(src_folio);
-                       if (!src_anon_vma) {
-                               /* page was unmapped from under us */
-                               err =3D -EAGAIN;
-                               goto out;
-                       }
-                       if (!anon_vma_trylock_write(src_anon_vma)) {
-                               pte_unmap(src_pte);
-                               pte_unmap(dst_pte);
-                               src_pte =3D dst_pte =3D NULL;
-                               /* now we can block and wait */
-                               anon_vma_lock_write(src_anon_vma);
-                               goto retry;
-                       }
-               }
-
                err =3D move_present_pte(mm,  dst_vma, src_vma,
                                       dst_addr, src_addr, dst_pte, src_pte=
,
                                       orig_dst_pte, orig_src_pte, dst_pmd,
@@ -1445,10 +1422,6 @@ static int move_pages_pte(struct mm_struct *mm,
pmd_t *dst_pmd, pmd_t *src_pmd,
        }

 out:
-       if (src_anon_vma) {
-               anon_vma_unlock_write(src_anon_vma);
-               put_anon_vma(src_anon_vma);
-       }
        if (src_folio) {
                folio_unlock(src_folio);
                folio_put(src_folio);


> Is this the case? Happy to be corrected if I've misinterpreted.
>
> I don't see how this could possibly work, unless I'm missing something
> here, because:
>
> 1. When we lock anon_vma's it's at the root which covers all anon_vma's
>    covering parent/children of forked processes.
>
> 2. We do "top down" operations that acquire the rmap lock on the assumpti=
on
>    we have exclusive access to the rmapping that have nothing to do with
>    the folio nor could we even know what the folio is at this point.
>
> 3. We manipulate higher level page tables on the basis that the rmap lock
>    excludes other page table walkers.
>
> So this proposal seems to violate all of that?
>
> For instance, in many VMA operations we perform:
>
> anon_vma_interval_tree_pre_update_vma()
>
> and
>
> anon_vma_interval_tree_post_update_vma()
>
> Which removes _all_ R/B tree mappings.
>
> So you can now race with this (it of course doesn't care about folio lock=
)
> and then get completely incorrect results?
>
> This seems fairly disasterous?
>
> In free_pgtables() also we call unlink_anon_vmas() which iterates through
> the vma->anon_vma_chain and uses the anon lock to tear down higher order
> page tables which you now might race with and that seems even more
> disasterous...
>
>
> >
> > Among all rmap_walk() callers that don=E2=80=99t lock anon folios,
> > folio_referenced() is the most critical (others are
> > page_idle_clear_pte_refs(), damon_folio_young(), and
> > damon_folio_mkold()). The relevant code in folio_referenced() is:
> >
> > if (!is_locked && (!folio_test_anon(folio) || folio_test_ksm(folio))) {
> >         we_locked =3D folio_trylock(folio);
> >         if (!we_locked)
> >                 return 1;
> > }
> >
> > It=E2=80=99s unclear why locking anon_vma exclusively (when updating
> > folio->mapping, like in uffd MOVE) is beneficial over walking rmap
> > with folio locked. It=E2=80=99s in the reclaim path, so should not be a
> > critical path that necessitates some special treatment, unless I=E2=80=
=99m
> > missing something.
> > Therefore, I propose simplifying the locking mechanism by ensuring the
> > folio is locked before calling rmap_walk(). This helps avoid locking
> > anon_vma when updating folio->mapping, which, for instance, will help
> > eliminate the uninterruptible sleep observed in the field traces
> > mentioned earlier. Furthermore, it enables us to simplify the code in
> > folio_lock_anon_vma_read() by removing the re-check to ensure that the
> > field hasn=E2=80=99t changed under us.
>
>
> I mean this is why I get confused here though, because you seem to be
> saying 'don't take rmap lock at all' to referencing
> folio_lock_anon_vma_read()?
>
> Perhaps I misinterpreted (forgive me if so) and indeed you meant this, bu=
t
> then I don't see how you impact contention on the anon_vma lock by making
> this change?
>
> I think in general - let's clarify what exactly you intend to do here, an=
d
> then we need to delineate what we need to confirm and test to have any
> confidence in making such a change.
>
> anon_vma locks (and rmap locks) are very very sensitive in general and
> we've had actual security issues come up due to race windows emerging fro=
m
> inappropriate handling, not to mention that performance around this
> obviously matters a great deal.

I couldn't agree more. My changes seemed to simplify, otherwise I
wouldn't have suggested this. And David's reply yesterday gives
confidence that it wouldn't negatively affect performance either.

Thanks,
Lokesh
>
> So we must tread carefully here.
>
> Thanks, Lorenzo


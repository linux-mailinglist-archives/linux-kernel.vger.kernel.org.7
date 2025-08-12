Return-Path: <linux-kernel+bounces-765075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 405D7B22B12
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07546234BE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4622EFD99;
	Tue, 12 Aug 2025 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3RaPM4D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F0C2C159B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009872; cv=none; b=u4spKliSvFImaX4r45rNONmrnA5Yh/BhvAQC7SpLwP9qwTJbmTUloQ9sLsyuQUOKEjs4TyaOWVHTKeNtSoHtqs5/ExX6b3XuSjeybRgoNh4malDBmXCX7treJZsUoM4RGv8T4yLimYTqV2w3MTQmAyGF6WNT7dYvkZgSv05ppxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009872; c=relaxed/simple;
	bh=+05/BsvotnDAz7g0h9qCgrbdK3mJtv7m3Are1HkFWSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/vFBmEt5KczBRVm6l1D4jdQuPRs4rc5oMOADELAq0+7JWlHJYGp2Eg0Chflhxls2TCCtxFDcfyozid1v7iVhki009mjac4koE4yhzEcIWvXjvFoD84JABJ5YGk8vFYqO0QiYMdTpfJoLvXZKpNkBjB4wxXmFpWs7fM5+SvWRS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f3RaPM4D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755009870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLLcNx5rUVjSB6a5QhKP843kVJWKb0b8D2KnjHFIuZE=;
	b=f3RaPM4DZc13mbj06ZPP4TAFCaDyEmggec0ER4q/QUHFOHUfgt1uk3mxcXXitTX52VcRi6
	8IQBAQFk3w+PheDFm0bpaOHTIdHVUhXN7+Qh6TAg/7qCe5g5ibu5vvOahYRy2gXFF0oXie
	W63YhI2f2nxZOxdxERAYE7cjnsatb1E=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-Lj5yeXEyNMWMNfrvcBlH3Q-1; Tue, 12 Aug 2025 10:44:28 -0400
X-MC-Unique: Lj5yeXEyNMWMNfrvcBlH3Q-1
X-Mimecast-MFC-AGG-ID: Lj5yeXEyNMWMNfrvcBlH3Q_1755009868
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4af199d0facso168262191cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755009868; x=1755614668;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLLcNx5rUVjSB6a5QhKP843kVJWKb0b8D2KnjHFIuZE=;
        b=fGsm8tzkG+Bn7RMaqYkqPMk/Ir0v9mPuEdez0Z6jSHuNWq4WxMbU+PzA17Bvn2J5ya
         7nPbA/7tQ3AKx6pbpDXuvaQ8OOP1bAXtk9+i6G5S+H7stn8sKP05LXMg32OnhouETL0L
         XMr5azY5RBMnuJXIawSYAvZ1oiiowKhCLSjIrvUgiue8WrMNYzcvOD9x8u4BLx3ZyoIs
         wyvMMh8LdLjrGSqqQLw1jzMk6A7afzdCinbxKSre+gp7B/wcrcAkc6x4z7qPTWrtjGNQ
         h/bxFMkyJxIEEsIo+xjVFaZLkGXoobwKkAN5Y5uhFwxTH53RXmpWk3n3f6OFVc2zWDdl
         wBpA==
X-Forwarded-Encrypted: i=1; AJvYcCXFs9ICfJE6pcTwjfi2gPCt/iFmtJLdxqkey7xmSq8jqfOGZwwkR0RgMpO0WIL0NZSAd/Faouh1koAv4kY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJl84l7lmpS1qbkjlUmZZ/3BXSNF/lphbBwm6RQBJ7a99urUgW
	C/Hk5fjYzRLCcWQxL9ltOBzP+I77ISbHmRqZFaNpAQtlhhi4MQ+l2tWgbh4yi+oECOYq88NxMsk
	lSthvMuFTcVx/wyLXU+CnoVAE0WY1rCG1r56TESCHxXACSWIWVze7TyJwe6mxpbnbrA==
X-Gm-Gg: ASbGncsYcmvYsdkqL+XVKDpm4fnyzNjGgJXne9mEYPD+U/anN1TIUv15bt7jUTRnWi/
	4OHp7ezosFF2EtUP9X+RSmuaJgYoK8mQNJHPNTvz3qgyVSTxp30J3i6k9BtUCUFbTU6ORpzG7GC
	U/Vncp8d7ilfO5OCAfVgZ8TMdnJdKnR+bB+oRXaaJmF2w4AEQDDRnhuefyo/nAJdzzaU4QEIaeo
	ROdnuqMaI5JzqT43KwR0kd22mFQcL5B3lnzXXRtYzhz3r08+ysKLydJRkA96g2LrZWhR10/K/RV
	ghHykRZE4+5IHj8ucN7Niwo9iF2eGGFV
X-Received: by 2002:a05:622a:447:b0:4b0:7327:1bed with SMTP id d75a77b69052e-4b0ec98cb3cmr36006251cf.1.1755009868106;
        Tue, 12 Aug 2025 07:44:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW+Q4suIFY7HXceW95xp4YuQL9IQHdbxyoR0crEXcoT6UOm7JtlKpI2ViaCfT/cx+pZ6nmiw==
X-Received: by 2002:a05:622a:447:b0:4b0:7327:1bed with SMTP id d75a77b69052e-4b0ec98cb3cmr36005911cf.1.1755009867642;
        Tue, 12 Aug 2025 07:44:27 -0700 (PDT)
Received: from x1.local ([174.89.135.171])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b085586307sm105898441cf.56.2025.08.12.07.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 07:44:26 -0700 (PDT)
Date: Tue, 12 Aug 2025 10:44:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
	aarcange@redhat.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, ngeoffray@google.com,
	Suren Baghdasaryan <surenb@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Barry Song <v-songbaohua@oppo.com>,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4] userfaultfd: opportunistic TLB-flush batching for
 present pages in MOVE
Message-ID: <aJtTPkenKeFuFFNQ@x1.local>
References: <20250810062912.1096815-1-lokeshgidra@google.com>
 <CAGsJ_4wbXkfaAn+79g20SfE-0Ak4QACVP+Mw2vAvMnxBCcLAsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4wbXkfaAn+79g20SfE-0Ak4QACVP+Mw2vAvMnxBCcLAsQ@mail.gmail.com>

On Mon, Aug 11, 2025 at 11:55:36AM +0800, Barry Song wrote:
> Hi Lokesh,
> 
> 
> On Sun, Aug 10, 2025 at 2:29 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> >
> > MOVE ioctl's runtime is dominated by TLB-flush cost, which is required
> > for moving present pages. Mitigate this cost by opportunistically
> > batching present contiguous pages for TLB flushing.
> >
> > Without batching, in our testing on an arm64 Android device with UFFD GC,
> > which uses MOVE ioctl for compaction, we observed that out of the total
> > time spent in move_pages_pte(), over 40% is in ptep_clear_flush(), and
> > ~20% in vm_normal_folio().
> >
> > With batching, the proportion of vm_normal_folio() increases to over
> > 70% of move_pages_pte() without any changes to vm_normal_folio().
> > Furthermore, time spent within move_pages_pte() is only ~20%, which
> > includes TLB-flush overhead.
> >
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Kalesh Singh <kaleshsingh@google.com>
> > Cc: Barry Song <v-songbaohua@oppo.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > ---
> > Changes since v3 [1]
> > - Fix unintialized 'step_size' warning, per Dan Carpenter
> > - Removed pmd_none() from check_ptes_for_batched_move(), per Peter Xu
> > - Removed flush_cache_range() in zero-page case, per Peter Xu
> > - Added comment to explain why folio reference for batched pages is not
> >   required, per Peter Xu
> > - Use MIN() in calculation of largest extent that can be batched under
> >   the same src and dst PTLs, per Peter Xu
> > - Release first folio's reference in move_present_ptes(), per Peter Xu
> >
> > Changes since v2 [2]
> > - Addressed VM_WARN_ON failure, per Lorenzo Stoakes
> > - Added check to ensure all batched pages share the same anon_vma
> >
> > Changes since v1 [3]
> > - Removed flush_tlb_batched_pending(), per Barry Song
> > - Unified single and multi page case, per Barry Song
> >
> > [1] https://lore.kernel.org/all/20250807103902.2242717-1-lokeshgidra@google.com/
> > [2] https://lore.kernel.org/all/20250805121410.1658418-1-lokeshgidra@google.com/
> > [3] https://lore.kernel.org/all/20250731104726.103071-1-lokeshgidra@google.com/
> >
> >  mm/userfaultfd.c | 178 +++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 127 insertions(+), 51 deletions(-)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index cbed91b09640..39d81d2972db 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -1026,18 +1026,64 @@ static inline bool is_pte_pages_stable(pte_t *dst_pte, pte_t *src_pte,
> >                pmd_same(dst_pmdval, pmdp_get_lockless(dst_pmd));
> >  }
> >
> > -static int move_present_pte(struct mm_struct *mm,
> > -                           struct vm_area_struct *dst_vma,
> > -                           struct vm_area_struct *src_vma,
> > -                           unsigned long dst_addr, unsigned long src_addr,
> > -                           pte_t *dst_pte, pte_t *src_pte,
> > -                           pte_t orig_dst_pte, pte_t orig_src_pte,
> > -                           pmd_t *dst_pmd, pmd_t dst_pmdval,
> > -                           spinlock_t *dst_ptl, spinlock_t *src_ptl,
> > -                           struct folio *src_folio)
> > +/*
> > + * Checks if the two ptes and the corresponding folio are eligible for batched
> > + * move. If so, then returns pointer to the locked folio. Otherwise, returns NULL.
> > + *
> > + * NOTE: folio's reference is not required as the whole operation is within
> > + * PTL's critical section.
> > + */
> > +static struct folio *check_ptes_for_batched_move(struct vm_area_struct *src_vma,
> > +                                                unsigned long src_addr,
> > +                                                pte_t *src_pte, pte_t *dst_pte,
> > +                                                struct anon_vma *src_anon_vma)
> > +{
> > +       pte_t orig_dst_pte, orig_src_pte;
> > +       struct folio *folio;
> > +
> > +       orig_dst_pte = ptep_get(dst_pte);
> > +       if (!pte_none(orig_dst_pte))
> > +               return NULL;
> > +
> > +       orig_src_pte = ptep_get(src_pte);
> > +       if (!pte_present(orig_src_pte) || is_zero_pfn(pte_pfn(orig_src_pte)))
> > +               return NULL;
> > +
> > +       folio = vm_normal_folio(src_vma, src_addr, orig_src_pte);
> > +       if (!folio || !folio_trylock(folio))
> > +               return NULL;
> > +       if (!PageAnonExclusive(&folio->page) || folio_test_large(folio) ||
> > +           folio_anon_vma(folio) != src_anon_vma) {
> > +               folio_unlock(folio);
> > +               return NULL;
> > +       }
> > +       return folio;
> > +}
> > +
> 
> I’m still quite confused by the code. Before move_present_ptes(), we’ve
> already performed all the checks—pte_same(), vm_normal_folio(),
> folio_trylock(), folio_test_large(), folio_get_anon_vma(),
> and anon_vma_lock_write()—at least for the first PTE. Now we’re
> duplicating them again for all PTEs. Does this mean we’re doing those
> operations for the first PTE twice? It feels like the old non-batch check
> code should be removed?

This function should only start to work on the 2nd (or more) continuous
ptes to move within the same pgtable lock held.  We'll still need the
original path because that was sleepable, this one isn't, and it's only
best-effort fast path only. E.g. if trylock() fails above, it would
fallback to the slow path.

> 
> > +static long move_present_ptes(struct mm_struct *mm,
> > +                             struct vm_area_struct *dst_vma,
> > +                             struct vm_area_struct *src_vma,
> > +                             unsigned long dst_addr, unsigned long src_addr,
> > +                             pte_t *dst_pte, pte_t *src_pte,
> > +                             pte_t orig_dst_pte, pte_t orig_src_pte,
> > +                             pmd_t *dst_pmd, pmd_t dst_pmdval,
> > +                             spinlock_t *dst_ptl, spinlock_t *src_ptl,
> > +                             struct folio **first_src_folio, unsigned long len,
> > +                             struct anon_vma *src_anon_vma)
> >  {
> >         int err = 0;
> > +       struct folio *src_folio = *first_src_folio;
> > +       unsigned long src_start = src_addr;
> > +       unsigned long addr_end;
> > +
> > +       if (len > PAGE_SIZE) {
> > +               addr_end = (dst_addr + PMD_SIZE) & PMD_MASK;
> > +               len = MIN(addr_end - dst_addr, len);
> >
> > +               addr_end = (src_addr + PMD_SIZE) & PMD_MASK;
> > +               len = MIN(addr_end - src_addr, len);
> > +       }
> 
> We already have a pmd_addr_end() helper—can we reuse it?

I agree with Barry; I wante to say this version didn't use ALIGN() that I
suggested but pmd_addr_end() looks better.

Other than that this version looks good to me (plus the higher level
performance results updated to the commit message, per requested in v3),
thanks Lokesh.

-- 
Peter Xu



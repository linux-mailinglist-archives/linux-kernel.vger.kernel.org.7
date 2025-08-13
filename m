Return-Path: <linux-kernel+bounces-766308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55993B244E9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC697188F822
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B512D2D5A14;
	Wed, 13 Aug 2025 09:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IG37BMA3"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EC72ECEAC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755075797; cv=none; b=glpKFc0oualXTBtXnr9lC+gyNbNoY972S1dI9mdzC5i0LavR2tPd/2JklWHFcPL1ZPxm+FtXlIY/XevvxncPl9whooI3jVLKh7bAXQjMRDY+FKzzSoCkJjmyI1tkP1/FTpHWo7wJLJE57UoE7QWZ/UmI20G7t9x3+Sh8sgKWN+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755075797; c=relaxed/simple;
	bh=EUZaSgDMayOYr2r4e5x/jKd00oZtPeRfPNvfJXgc+34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJLvwyvNPR1/RUEV+5/ggvNtdsklt8UQq8JnhpFQ3RoelWGWsa1g9Xp6My4m1F9p5QnTLX5FHpxELlERFEDDOYi2HSVABzSVhQPFMIaogUWPrL8qPh7wWVPrtgf9XlygUmnbvn0IGC2U3hTtl7ulGo6AL+5NhALDnc8KYn6Zd8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IG37BMA3; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-53949f3ed30so2558590e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 02:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755075794; x=1755680594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voNOIsNIDIOSY89DvHxjFqypSpnZL2H3uOxQi9alac4=;
        b=IG37BMA32iKPMIr0385mz5qbaXWqdehbpEOnNyn6Y+h3eS2kz8JBg5q15DZ/GwRYsP
         huYsWE9AsayMjDeXtmpwEdxMd4c0dkEkc/QiX+JwkqNG+eaTzhArR9pYVlgoPH2EIGJn
         +JDgf0oU5mmusuBzZXEmjraOkKqNDh6exsAzrJB7uDQH8y/gyE5aXLucD9vQnMGSZxPr
         +bt5lz/A6dveXSXXuXoL7D1tOykNNtwZK1bU5xvbZxMLPj19dyLRlqot4EG7nWpFC990
         JLFh3xxIVIKUj+EWvOp/Z9SJ22AD5+kdur9hhP29x81cb2JMUX8ghgarNINIKFzyxdCW
         CtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755075794; x=1755680594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voNOIsNIDIOSY89DvHxjFqypSpnZL2H3uOxQi9alac4=;
        b=SFS14vIz1SHsWD0Tygp8MlHPOnA0il/d6bU1SOwaR2W0baX3SmIq66rBWyYTzsA6Z2
         BMAczyss5t0CHdvycMRrMAzec7/YcJlE8+VLt6Oh+VHJ6Lc2IToHX8jsom/r9Gt2Nzc+
         744WfKbHFEn4Qj4Gq6NUZaI/ezyGos8txhJL4ZtcGKbidrmCvoYgRAkNDeIvBYzrvPZo
         MlvBWF9O6plCN0W+nlPwG514O5QzajlM92BjpS/uc1A3/zPzAImMCf/y5BQh/gUz8N+7
         qXS+NvLC2NEDysU9xeNTCo1hqO0L8j4ogCkSwlxqRlpmT6IPll5/6ueojMH3wI816Fmd
         4dhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3BvQ5/Qn2jd9Tg6P97HkwH3dJ2TuZ806+DadUMZy6QZR1Qk3dj+j0K1YrsCJ2t2fqKgsfizWVGkxaPbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3k6Bv/kX57PggWL5xilnjutGO2LZMpJy7Pme6H64Mg8xh2FND
	KDx8Z878PcGMu3BMsvgUemgytu7nbBwUYN+fZyKOFhNV2p6HY/QTQ/lJ9y7ahAdGLMdsuwhzR1W
	GwWqSpXSBKorpf2UtjMeQ5yc3bfJ3bYAY8zKH
X-Gm-Gg: ASbGncsAtZAnaOt/Y/zoPnxagIv1qtCwQR0/2aKEJxDnzs/I3yE8YEGqYPaagH38STk
	0wNr40HcnXbBF1IQMmbesK7XtxWC/ffXwsMU2hDObOh3tGlZauotFU6kTH2hBN8qHI8oZ1wNWty
	WeiKgC87Uw9UO/cXMPLSOh7maeea/aridR2OQDNn1msdc5EUOHz77wZ/UQW7yvCLFlXk5k6m8nL
	zIbaEoPTE5mmABedQ==
X-Google-Smtp-Source: AGHT+IGuh9iHJ1JWc3gYcYGVmBmp0xY+JZbyoVk+K1ITPktWKiItf2ByWP4lQ9Mmtl//A68HDXzuauOSj81kR2pdG5o=
X-Received: by 2002:a05:6122:2090:b0:539:4097:794a with SMTP id
 71dfb90a1353d-53b0b66e1dfmr619879e0c.12.1755075793795; Wed, 13 Aug 2025
 02:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810062912.1096815-1-lokeshgidra@google.com>
 <CAGsJ_4wbXkfaAn+79g20SfE-0Ak4QACVP+Mw2vAvMnxBCcLAsQ@mail.gmail.com>
 <aJtTPkenKeFuFFNQ@x1.local> <CA+EESO763JtY3jjmgGGbJjSQcnJJFNpDs2iPaUwjP44VpyyzdQ@mail.gmail.com>
In-Reply-To: <CA+EESO763JtY3jjmgGGbJjSQcnJJFNpDs2iPaUwjP44VpyyzdQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 13 Aug 2025 17:03:02 +0800
X-Gm-Features: Ac12FXxub7pbHdwNO3uqCxu946h-k9RRK50QHzhG6uYyQAeU83e_ljmwtaOwEXY
Message-ID: <CAGsJ_4y98H-8aK9r_5YrSPV=SCU=-rZf7YPMz32K0C8oFnUCNA@mail.gmail.com>
Subject: Re: [PATCH v4] userfaultfd: opportunistic TLB-flush batching for
 present pages in MOVE
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: Peter Xu <peterx@redhat.com>, akpm@linux-foundation.org, aarcange@redhat.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, ngeoffray@google.com, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 11:44=E2=80=AFPM Lokesh Gidra <lokeshgidra@google.c=
om> wrote:
>
> On Tue, Aug 12, 2025 at 7:44=E2=80=AFAM Peter Xu <peterx@redhat.com> wrot=
e:
> >
> > On Mon, Aug 11, 2025 at 11:55:36AM +0800, Barry Song wrote:
> > > Hi Lokesh,
[...]
> > > >
> > > >  mm/userfaultfd.c | 178 +++++++++++++++++++++++++++++++++----------=
----
> > > >  1 file changed, 127 insertions(+), 51 deletions(-)
> > > >
> > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > index cbed91b09640..39d81d2972db 100644
> > > > --- a/mm/userfaultfd.c
> > > > +++ b/mm/userfaultfd.c
> > > > @@ -1026,18 +1026,64 @@ static inline bool is_pte_pages_stable(pte_=
t *dst_pte, pte_t *src_pte,
> > > >                pmd_same(dst_pmdval, pmdp_get_lockless(dst_pmd));
> > > >  }
> > > >
> > > > -static int move_present_pte(struct mm_struct *mm,
> > > > -                           struct vm_area_struct *dst_vma,
> > > > -                           struct vm_area_struct *src_vma,
> > > > -                           unsigned long dst_addr, unsigned long s=
rc_addr,
> > > > -                           pte_t *dst_pte, pte_t *src_pte,
> > > > -                           pte_t orig_dst_pte, pte_t orig_src_pte,
> > > > -                           pmd_t *dst_pmd, pmd_t dst_pmdval,
> > > > -                           spinlock_t *dst_ptl, spinlock_t *src_pt=
l,
> > > > -                           struct folio *src_folio)
> > > > +/*
> > > > + * Checks if the two ptes and the corresponding folio are eligible=
 for batched
> > > > + * move. If so, then returns pointer to the locked folio. Otherwis=
e, returns NULL.
> > > > + *
> > > > + * NOTE: folio's reference is not required as the whole operation =
is within
> > > > + * PTL's critical section.
> > > > + */
> > > > +static struct folio *check_ptes_for_batched_move(struct vm_area_st=
ruct *src_vma,
> > > > +                                                unsigned long src_=
addr,
> > > > +                                                pte_t *src_pte, pt=
e_t *dst_pte,
> > > > +                                                struct anon_vma *s=
rc_anon_vma)
> > > > +{
> > > > +       pte_t orig_dst_pte, orig_src_pte;
> > > > +       struct folio *folio;
> > > > +
> > > > +       orig_dst_pte =3D ptep_get(dst_pte);
> > > > +       if (!pte_none(orig_dst_pte))
> > > > +               return NULL;
> > > > +
> > > > +       orig_src_pte =3D ptep_get(src_pte);
> > > > +       if (!pte_present(orig_src_pte) || is_zero_pfn(pte_pfn(orig_=
src_pte)))
> > > > +               return NULL;
> > > > +
> > > > +       folio =3D vm_normal_folio(src_vma, src_addr, orig_src_pte);
> > > > +       if (!folio || !folio_trylock(folio))
> > > > +               return NULL;
> > > > +       if (!PageAnonExclusive(&folio->page) || folio_test_large(fo=
lio) ||
> > > > +           folio_anon_vma(folio) !=3D src_anon_vma) {
> > > > +               folio_unlock(folio);
> > > > +               return NULL;
> > > > +       }
> > > > +       return folio;
> > > > +}
> > > > +
> > >
> > > I=E2=80=99m still quite confused by the code. Before move_present_pte=
s(), we=E2=80=99ve
> > > already performed all the checks=E2=80=94pte_same(), vm_normal_folio(=
),
> > > folio_trylock(), folio_test_large(), folio_get_anon_vma(),
> > > and anon_vma_lock_write()=E2=80=94at least for the first PTE. Now we=
=E2=80=99re
> > > duplicating them again for all PTEs. Does this mean we=E2=80=99re doi=
ng those
> > > operations for the first PTE twice? It feels like the old non-batch c=
heck
> > > code should be removed?
> >
> > This function should only start to work on the 2nd (or more) continuous
> > ptes to move within the same pgtable lock held.  We'll still need the
> > original path because that was sleepable, this one isn't, and it's only
> > best-effort fast path only. E.g. if trylock() fails above, it would
> > fallback to the slow path.
> >
> Thanks Peter. I was about to give exactly the same reasoning :)

Apologies, I overlooked this part:
                src_addr +=3D PAGE_SIZE;
                if (src_addr =3D=3D addr_end)
                        break;
                dst_addr +=3D PAGE_SIZE;
                dst_pte++;
                src_pte++;
                folio_unlock(src_folio);
                src_folio =3D check_ptes_for_batched_move(src_vma,
src_addr, src_pte,
                                                        dst_pte, src_anon_v=
ma);

I still find this a little tricky to follow =E2=80=94 couldn=E2=80=99t we j=
ust handle it
like the other batched cases:

static inline unsigned int folio_unmap_pte_batch(struct folio *folio,
                        struct page_vma_mapped_walk *pvmw,
                        enum ttu_flags flags, pte_t pte)

We pass the first PTE and use a function to determine how many PTEs we
can batch together. That way, we don=E2=80=99t need a special path for the =
first
PTE.

I guess the challenge is that the first PTE needs to handle
split_folio(), folio_trylock() with -EAGAIN, and
anon_vma_trylock_write(), while the other PTEs don=E2=80=99t?

If so, could we add a clear comment explaining that move_present_ptes()
moves PTEs that share the same anon_vma as the first PTE, are not large
folios, and can successfully take folio_trylock()?
If this condition isn=E2=80=99t met, the batch stops.

Thanks
Barry


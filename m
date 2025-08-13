Return-Path: <linux-kernel+bounces-766830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A27B24BB4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD74188B264
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0F72EAB6A;
	Wed, 13 Aug 2025 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kp3BZfBd"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41A62E8899
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755094337; cv=none; b=tvHM1Vz+20AvNHkqS8SgP0tnXhfu1YJSkVmdNb6PVHD2tUyvdlU9t9FVo3h3G6wfgMbrHPQ0g4ghek17ehKM/J6IHU3tOrUcUujwe5g1JUe5RN66yMUU+H2Pmb/16rNxR5eREtkQVXzZG3if3UX9rd3FWmbi2JjKdHyoBAojC/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755094337; c=relaxed/simple;
	bh=b48lt8mn1Ki40ZHepnDPM60+Lky3+XTbKR3TQd2N7os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZgQ0xQ3b5rYhYfJhv6f83Z5H4Q6VjnG/wUasWFiGXjrjLbq6JoZgLW02g2E53x20ydbVH+XnlAD27Dg/AnMvxTM+J/2DL6EClOK9gxVuLkHu3BltT60qYkVu498+2Cuis+aLL/RPtMGL+eYq2XcCRaNiHMTEKC+IpuM029/HYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kp3BZfBd; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-617ff2c8e5dso10570a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755094333; x=1755699133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkjlqmLiRBxptQz45vn5dg0H17v0dA1AGcg91Qnwr4k=;
        b=Kp3BZfBdLG/eOj8Q1Az90xSa1Ah4YI77zO8aC1fgZ7b3KkTQ1aK0xQgwQJduPjK/UA
         gXSb0QLGhTCKo7S5jtF0mG2wEzWJV3Ll0BeDcY+mJtUR+U2+BRE6MVfKrGFiw4hO92XY
         xGejrQLzsjObA8E+Hty+C9ViuiaYWBKixyinJFUz6C3/8mMb1ypUAUGqkZGBF4GsOA8f
         sJ04mI9NOTo1iwZNwupHojyHVhrgiCfFo6L/LgOR+upCOzUAcW7NuymD3uMGQ6GULLvw
         6hPVdj7siBFgsojCG/qfBfgXy7uHEwArwBsc2FRAE0vw+LGqkgspiF2JoDOvZeUKiOxq
         nhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755094333; x=1755699133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkjlqmLiRBxptQz45vn5dg0H17v0dA1AGcg91Qnwr4k=;
        b=lqfQuTMolYjOTk4efiTvobrolab3tIdPR2nO88IrpCFPqVLxv8DSChWi+WxwJKc55O
         qsZe1fH8Gq/6h5bumLLBbaVUbdvgYilSqsy5nrsQF2usGQZBcksDCjd2AlZKCbHDkYrm
         IS4yMiXpip1lnEo3JNo0leR1NxDZOS08u6CetfxvyGuGmn/vaSdIj4S1fL6x4vBJopmr
         qKXklXARcJo0NZbxLoh67v/XlBmsjcADC7x0zEkUl24f8LcvsCszB4XGb8eBjbrJEKM6
         6lyN+w9bff8GMcUM3dF0rY0VCDOpXG/GhydJZ4ibu5P8bKKCUBVNNCSAKfAJ2VWQgaZa
         Jkcg==
X-Forwarded-Encrypted: i=1; AJvYcCVJoycznfntzDjSjbxdvoximiO+HDMrC2+XuWRblpsPKMwS9AxbUMN9rAAlljmkXUmma2FKm9VABXEiUfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTg+DShwYOjMvOXdhCtWSERcg3K8KYTp0/HDhgoG0vsR/SjKML
	FfioRg1qq5r9BzQztMrhdTEypErQqZ8T+FBgQSsEbbcIzir7RUucpsm0JEs0iPn/aeGa0SQpYdI
	vUCDoAkh8xEQ87jjT9elWUX3X9G+Y2/YSon3oJV8a
X-Gm-Gg: ASbGnctDTDNX/XTMlHdHCrybFGK66uIQXQsYmtsQL4UsD7b8ZEB3fdPyO8XMlbvR6/B
	x3OINc54U8aAeQcYjBAZ3JfShLXIGdLXSq3OdxH4WprkPanRWkGUYP1SsKNOA2mFq8M5ufLtFjt
	Jx4tV6DkNSW3hUCjibkQ89+6Ovnq2WvEKx8vmwXTbP6dV0qoYMYTL2feQSY9JYkWSvbMVCB0v6C
	hqtXSgRf1s8U4d5+yc5h6BYkQtn+SfbQ0vqYqbPg8Kl/jdkkB0=
X-Google-Smtp-Source: AGHT+IHpsS1eTrEGvR3363fwaPPMu7U8npszqW0lvxFFfHbG1gOFWCGxufRpUJ4UlBdSmonQQ+VW78cKaBNDy1C+O7c=
X-Received: by 2002:a05:6402:24d4:b0:615:5ae7:a3ae with SMTP id
 4fb4d7f45d1cf-6186d539fd8mr72219a12.1.1755094332952; Wed, 13 Aug 2025
 07:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810062912.1096815-1-lokeshgidra@google.com>
 <CAGsJ_4wbXkfaAn+79g20SfE-0Ak4QACVP+Mw2vAvMnxBCcLAsQ@mail.gmail.com>
 <aJtTPkenKeFuFFNQ@x1.local> <CA+EESO763JtY3jjmgGGbJjSQcnJJFNpDs2iPaUwjP44VpyyzdQ@mail.gmail.com>
 <CAGsJ_4y98H-8aK9r_5YrSPV=SCU=-rZf7YPMz32K0C8oFnUCNA@mail.gmail.com>
In-Reply-To: <CAGsJ_4y98H-8aK9r_5YrSPV=SCU=-rZf7YPMz32K0C8oFnUCNA@mail.gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Wed, 13 Aug 2025 07:12:00 -0700
X-Gm-Features: Ac12FXy7s_4dlzUn7ZVKxVS4OWNMJRiZRK02IquoT5AygK6YYxLLICI9IgH2TEg
Message-ID: <CA+EESO7ddhP-7tkkPUgusNjtyekx7HhJijKuJid1pLh0Z31kJQ@mail.gmail.com>
Subject: Re: [PATCH v4] userfaultfd: opportunistic TLB-flush batching for
 present pages in MOVE
To: Barry Song <21cnbao@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, akpm@linux-foundation.org, aarcange@redhat.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, ngeoffray@google.com, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 2:03=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Tue, Aug 12, 2025 at 11:44=E2=80=AFPM Lokesh Gidra <lokeshgidra@google=
.com> wrote:
> >
> > On Tue, Aug 12, 2025 at 7:44=E2=80=AFAM Peter Xu <peterx@redhat.com> wr=
ote:
> > >
> > > On Mon, Aug 11, 2025 at 11:55:36AM +0800, Barry Song wrote:
> > > > Hi Lokesh,
> [...]
> > > > >
> > > > >  mm/userfaultfd.c | 178 +++++++++++++++++++++++++++++++++--------=
------
> > > > >  1 file changed, 127 insertions(+), 51 deletions(-)
> > > > >
> > > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > > index cbed91b09640..39d81d2972db 100644
> > > > > --- a/mm/userfaultfd.c
> > > > > +++ b/mm/userfaultfd.c
> > > > > @@ -1026,18 +1026,64 @@ static inline bool is_pte_pages_stable(pt=
e_t *dst_pte, pte_t *src_pte,
> > > > >                pmd_same(dst_pmdval, pmdp_get_lockless(dst_pmd));
> > > > >  }
> > > > >
> > > > > -static int move_present_pte(struct mm_struct *mm,
> > > > > -                           struct vm_area_struct *dst_vma,
> > > > > -                           struct vm_area_struct *src_vma,
> > > > > -                           unsigned long dst_addr, unsigned long=
 src_addr,
> > > > > -                           pte_t *dst_pte, pte_t *src_pte,
> > > > > -                           pte_t orig_dst_pte, pte_t orig_src_pt=
e,
> > > > > -                           pmd_t *dst_pmd, pmd_t dst_pmdval,
> > > > > -                           spinlock_t *dst_ptl, spinlock_t *src_=
ptl,
> > > > > -                           struct folio *src_folio)
> > > > > +/*
> > > > > + * Checks if the two ptes and the corresponding folio are eligib=
le for batched
> > > > > + * move. If so, then returns pointer to the locked folio. Otherw=
ise, returns NULL.
> > > > > + *
> > > > > + * NOTE: folio's reference is not required as the whole operatio=
n is within
> > > > > + * PTL's critical section.
> > > > > + */
> > > > > +static struct folio *check_ptes_for_batched_move(struct vm_area_=
struct *src_vma,
> > > > > +                                                unsigned long sr=
c_addr,
> > > > > +                                                pte_t *src_pte, =
pte_t *dst_pte,
> > > > > +                                                struct anon_vma =
*src_anon_vma)
> > > > > +{
> > > > > +       pte_t orig_dst_pte, orig_src_pte;
> > > > > +       struct folio *folio;
> > > > > +
> > > > > +       orig_dst_pte =3D ptep_get(dst_pte);
> > > > > +       if (!pte_none(orig_dst_pte))
> > > > > +               return NULL;
> > > > > +
> > > > > +       orig_src_pte =3D ptep_get(src_pte);
> > > > > +       if (!pte_present(orig_src_pte) || is_zero_pfn(pte_pfn(ori=
g_src_pte)))
> > > > > +               return NULL;
> > > > > +
> > > > > +       folio =3D vm_normal_folio(src_vma, src_addr, orig_src_pte=
);
> > > > > +       if (!folio || !folio_trylock(folio))
> > > > > +               return NULL;
> > > > > +       if (!PageAnonExclusive(&folio->page) || folio_test_large(=
folio) ||
> > > > > +           folio_anon_vma(folio) !=3D src_anon_vma) {
> > > > > +               folio_unlock(folio);
> > > > > +               return NULL;
> > > > > +       }
> > > > > +       return folio;
> > > > > +}
> > > > > +
> > > >
> > > > I=E2=80=99m still quite confused by the code. Before move_present_p=
tes(), we=E2=80=99ve
> > > > already performed all the checks=E2=80=94pte_same(), vm_normal_foli=
o(),
> > > > folio_trylock(), folio_test_large(), folio_get_anon_vma(),
> > > > and anon_vma_lock_write()=E2=80=94at least for the first PTE. Now w=
e=E2=80=99re
> > > > duplicating them again for all PTEs. Does this mean we=E2=80=99re d=
oing those
> > > > operations for the first PTE twice? It feels like the old non-batch=
 check
> > > > code should be removed?
> > >
> > > This function should only start to work on the 2nd (or more) continuo=
us
> > > ptes to move within the same pgtable lock held.  We'll still need the
> > > original path because that was sleepable, this one isn't, and it's on=
ly
> > > best-effort fast path only. E.g. if trylock() fails above, it would
> > > fallback to the slow path.
> > >
> > Thanks Peter. I was about to give exactly the same reasoning :)
>
> Apologies, I overlooked this part:
>                 src_addr +=3D PAGE_SIZE;
>                 if (src_addr =3D=3D addr_end)
>                         break;
>                 dst_addr +=3D PAGE_SIZE;
>                 dst_pte++;
>                 src_pte++;
>                 folio_unlock(src_folio);
>                 src_folio =3D check_ptes_for_batched_move(src_vma,
> src_addr, src_pte,
>                                                         dst_pte, src_anon=
_vma);
>
> I still find this a little tricky to follow =E2=80=94 couldn=E2=80=99t we=
 just handle it
> like the other batched cases:
>
> static inline unsigned int folio_unmap_pte_batch(struct folio *folio,
>                         struct page_vma_mapped_walk *pvmw,
>                         enum ttu_flags flags, pte_t pte)
>
> We pass the first PTE and use a function to determine how many PTEs we
> can batch together. That way, we don=E2=80=99t need a special path for th=
e first
> PTE.
>
> I guess the challenge is that the first PTE needs to handle
> split_folio(), folio_trylock() with -EAGAIN, and
> anon_vma_trylock_write(), while the other PTEs don=E2=80=99t?

That's right. We need to keep the complicated dance in
move_pages_pte(). That's why, unfortunately, we can't unify the way
you are hoping.
>
> If so, could we add a clear comment explaining that move_present_ptes()
> moves PTEs that share the same anon_vma as the first PTE, are not large
> folios, and can successfully take folio_trylock()?
> If this condition isn=E2=80=99t met, the batch stops.

Certainly. I'll add a description comment for move_present_ptes() to
explain this.
>
> Thanks
> Barry


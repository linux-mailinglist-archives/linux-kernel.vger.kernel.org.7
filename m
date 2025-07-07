Return-Path: <linux-kernel+bounces-720352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23589AFBAA6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68457168B44
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C354C264A90;
	Mon,  7 Jul 2025 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kq2C6f9n"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91150263F28
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751912888; cv=none; b=V8WG3R33/2anx/QoYDIQ3o0uLOPUEZ/t9x/RjdndhXoor+p/66/hvp2NkVbKLZmwhLCiDTPwxN2Wq6FTA0DBObbovhFKerEWWQNILnp091d4J6O2jIg30hZBKU2iJTqdWgoO9B6Dyon/4VpdIEf3XMgiTaxe6dX3O5FGkBICqYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751912888; c=relaxed/simple;
	bh=S9kEKj1+iXu7ajcvT5kRaKFBGmOU+As9xblZjGoEOIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6+WRRYXZX7Ta2jmVNmrN4VUw2um1bII09rxu1XmMkleaEnkTD9P0QP7TkPa0w/Lt66HeUGJqaJq9gX4oi54Wzowo7PlOVHWo35KNDg52pN8cPn/7WY44sGywhF/N6sm+vhwZfD3LEKGiQYLsKgGFruRzMpzmCJi4Ghq8sxE4rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kq2C6f9n; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e7b4ba530feso2879938276.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 11:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751912885; x=1752517685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owDFJen4YTDNma7AUk9STl34vl+r82F90HPmi/p/5YA=;
        b=kq2C6f9nruYK5wyeHuaOOIuRZ6dzl9peIokrlyXBlVlFq1UBUVtmIKl2dADSEWhaVr
         qcGjUqH+zuEwJ96AGPUq6dCM4LQp7DH6UnYE+6pwEtYSDbQym9gYqHMC4cDypOD/n7hU
         6HGrBS/N2kE1//jDeutAplge27QLLdN6fCsNn707x531twz8EN0ai3mIAo/iM0ILfZUZ
         8lKIWXhv9aUuB4N1rDxl7CHTLmtGUls8UdPHXoSXDq5gvsmuHx+WOqiJ/xRQKW2FFiVG
         igLnjEh3eqU+Zu5FUTR+jVwbvNgtXirmHwTaI0MuhYugW+JKV1KyAV04hZcrBKCww7Tw
         n74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751912885; x=1752517685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owDFJen4YTDNma7AUk9STl34vl+r82F90HPmi/p/5YA=;
        b=bwuMQG9TOxCUGDPKgQve8IqLHRoOKyLcfXEor7LBYVB8OgNiAlMKJvUsBg6UAUBL+7
         DIMpWww7C/lKl5S/hRJwYLyLrdFRuoaz/Ur7u6W8K2E3tCVOdq1qIqsJ8Iz8P8vjrFt6
         2MAwrm1XYmyT/XYY5t6kz0XNzB9GwrMtH/Z+l6+3l7ligXbiQUi9Kg0MaeOlgHFd8YQ0
         I5SzbwgGN0t+S74zEm+rJGBVJ3KD0OxH55R3gGnoQ2zyM5KqoAO7CQpFnJgt+AdpUYsV
         fX2FsaFEHFqwHC2JVwMUZ71D0hyAWDS4CkoJjkJJg73BnKbXUrJsmLDvALkKAb9MXUgf
         Q5Jg==
X-Forwarded-Encrypted: i=1; AJvYcCU5/yWiCjg3cXcFAwiYXjz8UnQpVw2Dm/iwIK2ZbD1gHwurg58LCgzdaAQtvAVUFMeN3Bv+2ZP6Vt7q9Ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEu/pSCJYnL5Ya1sF+B0fXnhREDh3cNDznO5T5B47wt95/4yHc
	Dg/AHn4ZQJ7j2ecWbcgNwkuk/e43ucYsbZHerebMYme3KCTTRcvGXHEwHH0dNaJy3a7+LonhLj+
	mqqM6pJJDWuatuZ6MBSx5RnlnVJKF8A9+pqgV0O7e
X-Gm-Gg: ASbGncuFhOphP2Ec6hvhj20rTdod9eMjEnNN3cJ2oeN6mkEXrn7Ar3p/4H06ePYvU0y
	be0/YkXGjTa5VAbv5TyHyzzX2urcSvwNq+anGcAgDhTZlfNvu9cg16gZjuMxkE7rkMcsdKDHWOk
	T8afyKJe+WL9clQ17+WjUw/sX4rAlT8+Y1GUytKuKx8yY2wQIApSxp1x6dj/XCBp3KM+a0U4AVX
	w==
X-Google-Smtp-Source: AGHT+IGALxRhMgh7BE91T+jJhyG+rEGC8sNFThaOOtDHVthOVl+i2kZqlVjxvI4H8+dEE+6nS2sYRpdFrW0Z4Ws+/BQ=
X-Received: by 2002:a05:690c:6f02:b0:713:f7dd:5d7c with SMTP id
 00721157ae682-71668ded91cmr174799297b3.19.1751912884636; Mon, 07 Jul 2025
 11:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <8548af334e01401a776aae37a0e9f30f9ffbba8c.1747264138.git.ackerleytng@google.com>
In-Reply-To: <8548af334e01401a776aae37a0e9f30f9ffbba8c.1747264138.git.ackerleytng@google.com>
From: James Houghton <jthoughton@google.com>
Date: Mon, 7 Jul 2025 11:27:28 -0700
X-Gm-Features: Ac12FXwfXFYyW7dt7flmw9fdJeBgsdRSXtn9Ce_9e810HW9a_XvXDOUG_TQfUZU
Message-ID: <CADrL8HXczKJnrCA0wD2qMHPtV1+VCW+mgJC2LSa5DsEuX4++Uw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 16/51] mm: hugetlb: Consolidate interpretation of
 gbl_chg within alloc_hugetlb_folio()
To: Ackerley Tng <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com, 
	ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com, 
	anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu, 
	bfoster@redhat.com, binbin.wu@linux.intel.com, brauner@kernel.org, 
	catalin.marinas@arm.com, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	dave.hansen@intel.com, david@redhat.com, dmatlack@google.com, 
	dwmw@amazon.co.uk, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	graf@amazon.com, haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, 
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jun.miao@intel.com, kai.huang@intel.com, 
	keirf@google.com, kent.overstreet@linux.dev, kirill.shutemov@intel.com, 
	liam.merwick@oracle.com, maciej.wieczor-retman@intel.com, 
	mail@maciej.szmigiero.name, maz@kernel.org, mic@digikod.net, 
	michael.roth@amd.com, mpe@ellerman.id.au, muchun.song@linux.dev, 
	nikunj@amd.com, nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com, 
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com, 
	pdurrant@amazon.co.uk, peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, 
	qperret@google.com, quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 4:43=E2=80=AFPM Ackerley Tng <ackerleytng@google.co=
m> wrote:
>
> Previously, gbl_chg was passed from alloc_hugetlb_folio() into
> dequeue_hugetlb_folio_vma(), leaking the concept of gbl_chg into
> dequeue_hugetlb_folio_vma().
>
> This patch consolidates the interpretation of gbl_chg into
> alloc_hugetlb_folio(), also renaming dequeue_hugetlb_folio_vma() to
> dequeue_hugetlb_folio() so dequeue_hugetlb_folio() can just focus on
> dequeuing a folio.
>
> Change-Id: I31bf48af2400b6e13b44d03c8be22ce1a9092a9c
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

I think I agree with Binbin[1] to either put the rename of
dequeue_hugetlb_folio{_vma =3D> }() in its own patch or drop it
entirely.

I think the rename would 100% make sense if all of the
dequeue_hugetlb_folio*() functions were called from
dequeue_hugetlb_folio_vma() (i.e., after this patch,
dequeue_hugetlb_folio() was always the entry point to dequeue a
folio), but in fact dequeue_hugetlb_folio_nodemask() is not always
called from dequeue_hugetlb_folio_vma().

I don't feel strongly at all, either way the name is not confusing. So
feel free to add:

Reviewed-by: James Houghton <jthoughton@google.com>

[1]: https://lore.kernel.org/all/ad77da83-0e6e-47a1-abe7-8cfdfce8b254@linux=
.intel.com/

> ---
>  mm/hugetlb.c | 28 +++++++++++-----------------
>  1 file changed, 11 insertions(+), 17 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6ea1be71aa42..b843e869496f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1364,9 +1364,9 @@ static unsigned long available_huge_pages(struct hs=
tate *h)
>         return h->free_huge_pages - h->resv_huge_pages;
>  }
>
> -static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
> -                               struct vm_area_struct *vma,
> -                               unsigned long address, long gbl_chg)
> +static struct folio *dequeue_hugetlb_folio(struct hstate *h,
> +                                          struct vm_area_struct *vma,
> +                                          unsigned long address)
>  {
>         struct folio *folio =3D NULL;
>         struct mempolicy *mpol;
> @@ -1374,13 +1374,6 @@ static struct folio *dequeue_hugetlb_folio_vma(str=
uct hstate *h,
>         nodemask_t *nodemask;
>         int nid;
>
> -       /*
> -        * gbl_chg=3D=3D1 means the allocation requires a new page that w=
as not
> -        * reserved before.  Making sure there's at least one free page.
> -        */
> -       if (gbl_chg && !available_huge_pages(h))
> -               goto err;
> -
>         gfp_mask =3D htlb_alloc_mask(h);
>         nid =3D huge_node(vma, address, gfp_mask, &mpol, &nodemask);
>
> @@ -1398,9 +1391,6 @@ static struct folio *dequeue_hugetlb_folio_vma(stru=
ct hstate *h,
>
>         mpol_cond_put(mpol);
>         return folio;
> -
> -err:
> -       return NULL;
>  }
>
>  /*
> @@ -3074,12 +3064,16 @@ struct folio *alloc_hugetlb_folio(struct vm_area_=
struct *vma,
>                 goto out_uncharge_cgroup_reservation;
>
>         spin_lock_irq(&hugetlb_lock);
> +
>         /*
> -        * glb_chg is passed to indicate whether or not a page must be ta=
ken
> -        * from the global free pool (global change).  gbl_chg =3D=3D 0 i=
ndicates
> -        * a reservation exists for the allocation.
> +        * gbl_chg =3D=3D 0 indicates a reservation exists for the alloca=
tion - so
> +        * try dequeuing a page. If there are available_huge_pages(), try=
 using
> +        * them!
>          */
> -       folio =3D dequeue_hugetlb_folio_vma(h, vma, addr, gbl_chg);
> +       folio =3D NULL;
> +       if (!gbl_chg || available_huge_pages(h))
> +               folio =3D dequeue_hugetlb_folio(h, vma, addr);
> +
>         if (!folio) {
>                 spin_unlock_irq(&hugetlb_lock);
>                 folio =3D alloc_buddy_hugetlb_folio_with_mpol(h, vma, add=
r);
> --
> 2.49.0.1045.g170613ef41-goog
>


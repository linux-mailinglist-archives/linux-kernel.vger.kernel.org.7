Return-Path: <linux-kernel+bounces-813607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAD4B5482D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE6117CF6E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCF7280308;
	Fri, 12 Sep 2025 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRp4QO8f"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C71517BA1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670214; cv=none; b=ttAkSx6DROCDhEyFh4E4BDn62HtYNfwpIdjp9ICPWC2oj+u6ETdRp296taek3SKzb1zUKjHQPCruC1BBihktrt1abGSoBobdS5rdNvsmPKnCp8K83CXm5B4jmX3zLshj3lmQMj7osxInP6syqmMQH0tlsmHbk6ntTTMD8Ild5GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670214; c=relaxed/simple;
	bh=ax4lfeT22K2Tg4wZehKRsBnRhQp4gc/l5I0VC7YWUlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+SD/UAMtWWyqbHTwp8UP6/eIP7bBA06mYmlUMcoQzeEgHY5gNrtmUAQ4lwuIYYYYDDfD+Q6fifzwaWGSo8OsCk7QBXc0236mQY+bKKLXxjNFq+8P0IZSxUnOSBBNY3LwvY3oXN59FI2R8Fc/JhELIwd6grc3m3mUcOHtBRpxmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRp4QO8f; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62105d21297so3426945a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757670210; x=1758275010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OETlIHZhLuu2YOWBlAPQ9XetW3Ixqb//beh5cOzY/AE=;
        b=KRp4QO8fsM9uN34ZBTxmR4w3x/xhqvsAzXAQD9P6d+uT08Phn+AxluIp180l1+lFmK
         6rT0iKhanSeqgeaLwz014lYq2YSh9QkAUxM1NyPIlIQU+SlkeVK9Gvf8/Vj2sTMFgm/r
         gktPGftdjg788v97yk5IGmoILBoJ5cpzllgY1cRvUjVwGMpFGdvfP4gjFUWbCb8aPAQI
         e5ktywW6rHMFakRTyG4UXUs3VOiwyzoy2hstybx0DGOHqcsU2IVYjgx8RozI43i9XaeX
         64yIxWHueRmlikVGzOjlJW4wvZAuqgLyi+hZhZKKpgZzVbKIqSyiFY5v+BjN1w8+36P5
         mlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757670210; x=1758275010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OETlIHZhLuu2YOWBlAPQ9XetW3Ixqb//beh5cOzY/AE=;
        b=BEtFq6qlpa63eHGfg6ruSnxgJEE5uq5qN0zq723FZszXBcbpl2/k5qIRhiRh1cyY/g
         LFGBzrA+CmkqK7LKuRe9CKdcYtFbYq/dnQMqhA/IexuaHqS/JQH7bXtekFC8RyfHA5DM
         p0I/XqEEtBjdQNhfF3Z0yWFe39tmV7crfuNQ+oXkhrE+dUaGs/+xiMrulMROMZ8dx0ls
         Q1xWV3KhhmESD9Dyt8aLdMVqCbDSymSoi/u1YYktl9Dleo7e/ToS5IPglpfG/WZtcrZF
         GRI6Prsq06ca9yN4hkPSo8/IXxQvf3+rebXLz2wcz4r2Kgv2zEHqTBrGKklusq/cml1A
         Qxhg==
X-Forwarded-Encrypted: i=1; AJvYcCXryaNqNYOcaEFwkqBx1asKftZSw1TZhbhg4wV0l++x1YK0R3FDrIRW7Zo5SnB1eOEhWrtAEaqLRcnhkT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4HiG9b1DTxHD7DlTyCClV4zMTsQ8Za9M7OxRlKTqo5wPAzcGC
	T+nzJJv28UzG45hRbZ37Dngr5BEb7r1OfzEQq6RM3xJQNrO0RPAxPQsGdQ70Sgyysh4oBrEJTWt
	uDjcs1CiY97UFY17rGBnbZ6m7yjR/I+s=
X-Gm-Gg: ASbGncs4Dzr3LLlKSuEe+UXpWnmUOZqDLlkDmEQGcDmH56JQzUANFeJ3NIt9YoX6vd1
	ULuZ1OfYOgTcPkvLNHtsD+40MskVm1Vo3lxv9R54J2DiTq2SzlatbJgEaup0taLfWwmTiCBYaLW
	RfdO2dhkdOflKleG2SZzOkl5jopwlxFAGqehjYxCu5cq5FryXlCiwgitqlOvj3sQySuyVh/1hs3
	9tGEfy/WkU=
X-Google-Smtp-Source: AGHT+IEzZL/B+m1oA93uBf6bciqzmOCInPrUEGceQPEbgzipBFvRN2q5E9EMf4RZciIhQg3sL5+cbhvs5JrscubJ+vY=
X-Received: by 2002:a05:6402:2553:b0:627:f96f:aa7a with SMTP id
 4fb4d7f45d1cf-62ed85204f8mr2284392a12.30.1757670210176; Fri, 12 Sep 2025
 02:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910160833.3464-1-ryncsn@gmail.com> <20250910160833.3464-12-ryncsn@gmail.com>
 <CABzRoyZc1zHHy5eFaO5hRY=bM36xsk3COd=r18KahmrP11tpSw@mail.gmail.com>
 <CABzRoyaAA3D0nfkQcBMjZ7crUckJXXpGmYfmq6ojQC+BQUigFw@mail.gmail.com>
 <CAMgjq7CtYpe4sEYaw2carqGskvchV9Z+1yn2Wa3nMP2VguV_eQ@mail.gmail.com>
 <223c560b-0234-4203-a11d-661656317808@linux.dev> <d5f84730-c7c0-4059-a5b7-061a9eaebc5c@lucifer.local>
In-Reply-To: <d5f84730-c7c0-4059-a5b7-061a9eaebc5c@lucifer.local>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 12 Sep 2025 17:42:53 +0800
X-Gm-Features: AS18NWCKrRyfpaANX_oyOUj3Wt6htqC4Oat1olLvElN275-UZVlguwjwLMwtUec
Message-ID: <CAMgjq7BbYmTCmA+NPS_jQ3iWM4DJR1mkDe925qTcYOMzbGwnGg@mail.gmail.com>
Subject: Re: [PATCH v3 11/15] mm, swap: use the swap table for the swap cache
 and switch API
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 5:31=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Sep 11, 2025 at 10:54:19AM +0800, Lance Yang wrote:
> >
> >
> > On 2025/9/11 10:48, Kairui Song wrote:
> > > On Thu, Sep 11, 2025 at 10:34=E2=80=AFAM Lance Yang <lance.yang@linux=
.dev> wrote:
> > > >
> > > > On Thu, Sep 11, 2025 at 10:27=E2=80=AFAM Lance Yang <lance.yang@lin=
ux.dev> wrote:
> > > > >
> > > > > Hi Kairui,
> > > > >
> > > > > I'm hitting a build error with allnoconfig:
> > > > >
> > > > > In file included from mm/shmem.c:44:
> > > > > mm/swap.h: In function =E2=80=98folio_index=E2=80=99:
> > > > > mm/swap.h:462:24: error: implicit declaration of function
> > > > > =E2=80=98swp_offset=E2=80=99; did you mean =E2=80=98pmd_offset=E2=
=80=99?
> > > > > [-Wimplicit-function-declaration]
> > > > > 462 | return swp_offset(folio->swap);
> > > > >
> > > > > It looks like a header might be missing in mm/swap.h. Please let =
me know
> > > > > if you need any more information.
> > > >
> > > > Confirmed that just adding #include <linux/swapops.h> into mm/swap.=
h fixes it.
> > > >
> > > > diff --git a/mm/swap.h b/mm/swap.h
> > > > index ad339547ee8c..271e8c560fcc 100644
> > > > --- a/mm/swap.h
> > > > +++ b/mm/swap.h
> > > > @@ -3,6 +3,7 @@
> > > >   #define _MM_SWAP_H
> > > >
> > > >   #include <linux/atomic.h> /* for atomic_long_t */
> > > > +#include <linux/swapops.h>
> > > >   struct mempolicy;
> > > >   struct swap_iocb;
> > > >
> > > > Cheers,
> > > > Lance
> > > >
> > >
> > > Hi Lance,
> > >
> > > You are testing V2 not V3 right? The build error is in V2 and I can
> > > confirm that. But In V3 I've added "ifdef CONFIG_SWAP" for the
> > > swp_offset usage in swap.h. I've just tested allnoconfig and it
> > > works fine on aarch64 and x86_64.
> > >
> > > V2: https://lore.kernel.org/linux-mm/20250905191357.78298-12-ryncsn@g=
mail.com/
> >
> >
> > Ah, I was testing V2. My apologies for the noise!
> >
>
> OK so my bug is different then :)
>
> I think the issue is that you're not properly checking for:
>
> #ifdef CONFIG_MMU
> ...
> #endif
>
> This is v3 (I see the #ifdef CONFIG_SWAP) btw.
>
> So swapops.h is wrapped by #ifdef CONFIG_MMU which is why the declaration=
 is
> missing.
>
> The below fixpatch fixes things for me.
>
> Cheers, Lorenzo
>
> ----8<----
> From 5a3969a438af9c33422a45fe813a44068d784b2f Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Fri, 12 Sep 2025 10:28:40 +0100
> Subject: [PATCH] fix
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  arch/sparc/include/asm/pgtable_64.h |  3 +++
>  mm/swap.h                           | 37 +++++++++++++++++------------
>  2 files changed, 25 insertions(+), 15 deletions(-)
>
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm=
/pgtable_64.h
> index b8000ce4b59f..b06f55915653 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -1050,6 +1050,9 @@ int page_in_phys_avail(unsigned long paddr);
>
>  int remap_pfn_range(struct vm_area_struct *, unsigned long, unsigned lon=
g,
>                    unsigned long, pgprot_t);
> +void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pf=
n);
> +int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long a=
ddr,
> +               unsigned long pfn, unsigned long size, pgprot_t pgprot);
>
>  void adi_restore_tags(struct mm_struct *mm, struct vm_area_struct *vma,
>                      unsigned long addr, pte_t pte);
> diff --git a/mm/swap.h b/mm/swap.h
> index caff4fe30fc5..18651687fcd1 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -53,7 +53,7 @@ enum swap_cluster_flags {
>         CLUSTER_FLAG_MAX,
>  };
>
> -#ifdef CONFIG_SWAP
> +#if defined(CONFIG_SWAP) && defined(CONFIG_MMU)
>  #include <linux/swapops.h> /* for swp_offset */
>  #include <linux/blk_types.h> /* for bio_end_io_t */
>
> @@ -317,7 +317,26 @@ static inline int non_swapcache_batch(swp_entry_t en=
try, int max_nr)
>         return i;
>  }
>
> +/**
> + * folio_index - File index of a folio.
> + * @folio: The folio.
> + *
> + * For a folio which is either in the page cache or the swap cache,
> + * return its index within the address_space it belongs to.  If you know
> + * the folio is definitely in the page cache, you can look at the folio'=
s
> + * index directly.
> + *
> + * Return: The index (offset in units of pages) of a folio in its file.
> + */
> +static inline pgoff_t folio_index(struct folio *folio)
> +{
> +       if (unlikely(folio_test_swapcache(folio)))
> +               return swp_offset(folio->swap);
> +       return folio->index;
> +}
> +
>  #else /* CONFIG_SWAP */
> +
>  struct swap_iocb;
>  static inline struct swap_cluster_info *swap_cluster_lock(
>         struct swap_info_struct *si, pgoff_t offset, bool irq)
> @@ -442,24 +461,12 @@ static inline int non_swapcache_batch(swp_entry_t e=
ntry, int max_nr)
>  {
>         return 0;
>  }
> -#endif /* CONFIG_SWAP */
>
> -/**
> - * folio_index - File index of a folio.
> - * @folio: The folio.
> - *
> - * For a folio which is either in the page cache or the swap cache,
> - * return its index within the address_space it belongs to.  If you know
> - * the folio is definitely in the page cache, you can look at the folio'=
s
> - * index directly.
> - *
> - * Return: The index (offset in units of pages) of a folio in its file.
> - */
>  static inline pgoff_t folio_index(struct folio *folio)
>  {
> -       if (unlikely(folio_test_swapcache(folio)))
> -               return swp_offset(folio->swap);
>         return folio->index;
>  }
>
> +#endif
> +
>  #endif /* _MM_SWAP_H */
> --
> 2.51.0

Thanks for the info. But I think V3 should be good?

CONFIG_SWAP depends on CONFIG_MMU so if you have !CONFIG_MMU, you must
have !CONFIG_SWAP.

I didn't adjust the header in V3 and fixed it differently from what
Lance is suggesting, V3 wraps swp_offset with CONFIG_SWAP. It should
covers !CONFIG_MMU case too.

The folio_index in V3 (this patch) looks like this:

static inline pgoff_t folio_index(struct folio *folio)
{
#ifdef CONFIG_SWAP
        if (unlikely(folio_test_swapcache(folio)))
               return swp_offset(folio->swap);
#endif
        return folio->index;
}

I just tested !MMU and it seems fine.


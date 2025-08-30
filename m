Return-Path: <linux-kernel+bounces-793023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A46B3CBEC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 17:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4ED1B2680C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 15:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8DB25785C;
	Sat, 30 Aug 2025 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJQxctD/"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4044D1A7253
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756567535; cv=none; b=hi/M7O3sL6aQsmvQt6Cv+ORwC3awvjdgkgdDmuuHiNvdDVaXkljO8osC8f1wPrX8qFf5ahqeMHLsi+G78pCse+FntbsFe/wMqTsrti2dg0wZsJlXv61P/S2OsBOONZNsz+na6eiYCkPk5pLnEXYDZ9Nvn1fWH//kJf6paLGx910=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756567535; c=relaxed/simple;
	bh=4A35t+zITSs7Z8TRcnLRaG4CHQr2Zfh7wEFQJvpkV2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIuHj9TiqN4VgQQtzocyTQdVkfHcrA8Vw/75u4V3aNZL0IXt3j7eG0TBXcugygr+bKXQ38CfSGa7uDoRTp3086/L7aQIaNfKW+vMHy6dVIshg+vbbKMcHN3AH+dkoS+M/gEpCEMBs2/oiq0ZhHi2LCq3eFhuyE7KprAXXI5TTpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJQxctD/; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61cebce2f78so4977666a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 08:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756567530; x=1757172330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6kYItPA2rvepUFOxaTnei2fpyIaZlQm+Xg013dccqM=;
        b=HJQxctD/tlxgbdZb42soS96p+VythetXNmhpzX/dVCxwhrNikX+v+Jjho/R42gZjM+
         BAfcF3JWFF2bdGGerqtahpfTRRY/nSC44Qa+uFYIJGQYxKzR+kqtVqF5waqfjO6JGvO2
         aLBNX0lV0gAMzHnjdQuuET0Jwx3sw3fm45flvtx/KyZrNp/k1KdKSCBx0s93ttwOUgPw
         Oa4G2tOfIV43N7npeDixLPKLdufOLyj2xlifvmAair3MvdzkZsRJBgdlJP2urQPbPPgJ
         j+5MwZ/W/O2hGeMhEZIoPqSU7XQY6neTsO2ismn7IAKX127kBli4FzssDti+Xr+bZfv3
         bnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756567530; x=1757172330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6kYItPA2rvepUFOxaTnei2fpyIaZlQm+Xg013dccqM=;
        b=hXbKO+d8zv/3JzeKStInFLJ4msBdPZ2Q554Wb+Qh7lcTXyq6e32lnsZvzWHQH+83rq
         MJEYcUU5LbSg6owvW7onFqd7JeO+QD8S6z6Sr+wWrlkrcYsjIDn0v5g8cXYpZFRGqMJN
         ZoMXu93fhRVug10icKR3aBgdcuwVupcr3HqX9MU6RQjusXrrqZWXCD7sUqf3R6RSCiX4
         AlKF414/vr7FDalhHf3o6sZu7nDLkEP32BTGemxKTtZLJaVEfL71/7bcWrdQbiyRltBE
         d7jQD/CPfxcZfkt+yceGJLSo9213licbXtqlylFY1xgbi2kRslSBHQZf1fp5XdHpW/e0
         uvkw==
X-Forwarded-Encrypted: i=1; AJvYcCUrwn8t/xgXhjErEjJYbmK1XumyCk8FCQJ1TFSq5PNrGZGcibC1Z+Cr1/T2Gr89W2G7llSTJlhfgsq/mNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4d6LzhN5sGHVcH7fmkHtzzqcAsWiFogrPWMObdVDnRVibjTLB
	zAvuimjIm1UlXmv4omy+wuyKGfsiWo3ZRAFwCgeAIA0Gs4HhHaycQZm4lmAKLBmNT5pUlH6UqEX
	PkwXXivPZAwjtYA0sSZdcaMzn2SS8RnM=
X-Gm-Gg: ASbGnct7I1RxzHeM04f9YB2r546Kuiy9HnpP+d+CYvKLb5ii7aEQ7wbkoLz4Vn7jrCv
	pA6xVk4FqJKBjE6R2MBs0+Op4bUClvyp7vbTsDSPdSpCPMTVocFUADTLaQVwuk6dkLbiWh/hBbV
	CoTM+FMHXzm0K65WfYMnbY1PexX06M0Sc5RSc1TkU5TXarCFvkB3HqI1YVFGLh+nDHOpVNeILi5
	d8B/WnXFisHMW9sxg==
X-Google-Smtp-Source: AGHT+IEG/i9X+YtYffXXjBDaRIylIj01ccFFC782cu4dGLzAX1iUtuOg8wg0de6jTk1W/+z/qvvdiRqHhLqkUMJCkP8=
X-Received: by 2002:a05:6402:42ce:b0:61c:5cac:2963 with SMTP id
 4fb4d7f45d1cf-61d26eb426fmr2073283a12.29.1756567530195; Sat, 30 Aug 2025
 08:25:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-8-ryncsn@gmail.com>
 <CACePvbXB-G5vhoEt87BZcjDZ8kZWo3mZtAZ60YbR_gcjnPz29w@mail.gmail.com>
In-Reply-To: <CACePvbXB-G5vhoEt87BZcjDZ8kZWo3mZtAZ60YbR_gcjnPz29w@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 30 Aug 2025 23:24:53 +0800
X-Gm-Features: Ac12FXwkRmXS_EEoguE7kdUtX-HWl799kuxhC4q_pkBr2-9zH7mf_51DiLIJbJk
Message-ID: <CAMgjq7Aznd7=m6JTNGM4EyFj+6pqHTRBCo2hsQL-cKi0LZggOg@mail.gmail.com>
Subject: Re: [PATCH 7/9] mm, swap: remove contention workaround for swap cache
To: Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 1:03=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Kairui,
>
> It feels so good to remove that 64M swap cache space. Thank you for
> making it happen.
>
> Some nitpick follows. I am fine as is as well.
>
> Acked-by: Chris Li <chrisl@kernel.org>

Thanks.

>
> Chris
>
> On Fri, Aug 22, 2025 at 12:21=E2=80=AFPM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Swap cluster setup will try to shuffle the clusters on initialization.
> > It was helpful to avoid contention for the swap cache space. The cluste=
r
> > size (2M) was much smaller than each swap cache space (64M), so shuffli=
ng
> > the cluster means the allocator will try to allocate swap slots that ar=
e
> > in different swap cache spaces for each CPU, reducing the chance of two
> > CPUs using the same swap cache space, and hence reducing the contention=
.
> >
> > Now, swap cache is managed by swap clusters, this shuffle is pointless.
> > Just remove it, and clean up related macros.
> >
> > This should also improve the HDD swap performance as shuffling IO is a
> > bad idea for HDD, and now the shuffling is gone.
>
> Did you have any numbers to prove that :-). Last time the swap
> allocator stress testing has already destroyed two of my SAS drives
> dedicated for testing. So I am not very keen on running the HDD swap
> stress test. The HDD swap stress test are super slow to run, it takes
> ages.

I did some test months before, removing the cluster shuffle did help.
I didn't test it again this time, only did some stress test. Doing
performance test on HDD is really not a good experience as my HDD
drives are too old so a long running test kills them easily.

And I couldn't find any other factor that is causing a serial HDD IO
regression, maybe the bot can help verify. If this doesn't help, we'll
think of something else. But I don't think HDD based SWAP will ever
have a practical good performance as they are terrible at rand read...

Anyway, let me try again with HDD today, maybe I'll get some useful data.

>
> >
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202504241621.f27743ec-lkp@intel.=
com
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/swap.h     |  4 ----
> >  mm/swapfile.c | 32 ++++++++------------------------
> >  mm/zswap.c    |  7 +++++--
> >  3 files changed, 13 insertions(+), 30 deletions(-)
> >
> > diff --git a/mm/swap.h b/mm/swap.h
> > index 4af42bc2cd72..ce3ec62cc05e 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -153,10 +153,6 @@ int swap_writeout(struct folio *folio, struct swap=
_iocb **swap_plug);
> >  void __swap_writepage(struct folio *folio, struct swap_iocb **swap_plu=
g);
> >
> >  /* linux/mm/swap_state.c */
> > -/* One swap address space for each 64M swap space */
> > -#define SWAP_ADDRESS_SPACE_SHIFT       14
> > -#define SWAP_ADDRESS_SPACE_PAGES       (1 << SWAP_ADDRESS_SPACE_SHIFT)
> > -#define SWAP_ADDRESS_SPACE_MASK                (SWAP_ADDRESS_SPACE_PAG=
ES - 1)
> >  extern struct address_space swap_space __ro_after_init;
> >  static inline struct address_space *swap_address_space(swp_entry_t ent=
ry)
> >  {
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index df68b5e242a6..0c8001c99f30 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -3203,21 +3203,14 @@ static int setup_swap_map(struct swap_info_stru=
ct *si,
> >         return 0;
> >  }
> >
> > -#define SWAP_CLUSTER_INFO_COLS                                        =
 \
> > -       DIV_ROUND_UP(L1_CACHE_BYTES, sizeof(struct swap_cluster_info))
> > -#define SWAP_CLUSTER_SPACE_COLS                                       =
         \
> > -       DIV_ROUND_UP(SWAP_ADDRESS_SPACE_PAGES, SWAPFILE_CLUSTER)
> > -#define SWAP_CLUSTER_COLS                                             =
 \
> > -       max_t(unsigned int, SWAP_CLUSTER_INFO_COLS, SWAP_CLUSTER_SPACE_=
COLS)
> > -
> >  static struct swap_cluster_info *setup_clusters(struct swap_info_struc=
t *si,
> >                                                 union swap_header *swap=
_header,
> >                                                 unsigned long maxpages)
> >  {
> >         unsigned long nr_clusters =3D DIV_ROUND_UP(maxpages, SWAPFILE_C=
LUSTER);
> >         struct swap_cluster_info *cluster_info;
> > -       unsigned long i, j, idx;
> >         int err =3D -ENOMEM;
> > +       unsigned long i;
>
> Nitpick: This line location change is not necessary.
>
> >
> >         cluster_info =3D kvcalloc(nr_clusters, sizeof(*cluster_info), G=
FP_KERNEL);
> >         if (!cluster_info)
> > @@ -3266,22 +3259,13 @@ static struct swap_cluster_info *setup_clusters=
(struct swap_info_struct *si,
> >                 INIT_LIST_HEAD(&si->frag_clusters[i]);
> >         }
> >
> > -       /*
> > -        * Reduce false cache line sharing between cluster_info and
> > -        * sharing same address space.
> > -        */
> > -       for (j =3D 0; j < SWAP_CLUSTER_COLS; j++) {
> > -               for (i =3D 0; i < DIV_ROUND_UP(nr_clusters, SWAP_CLUSTE=
R_COLS); i++) {
> > -                       struct swap_cluster_info *ci;
> > -                       idx =3D i * SWAP_CLUSTER_COLS + j;
> > -                       ci =3D cluster_info + idx;
> > -                       if (idx >=3D nr_clusters)
> > -                               continue;
> > -                       if (ci->count) {
> > -                               ci->flags =3D CLUSTER_FLAG_NONFULL;
> > -                               list_add_tail(&ci->list, &si->nonfull_c=
lusters[0]);
> > -                               continue;
> > -                       }
> > +       for (i =3D 0; i < nr_clusters; i++) {
> > +               struct swap_cluster_info *ci =3D &cluster_info[i];
>
> struct swap_cluster_info *ci =3D cluster_info + i;
> looks simpler. Pure nitpick and personal preference, you don't have to
> follow it.
>
> > +
> > +               if (ci->count) {
> > +                       ci->flags =3D CLUSTER_FLAG_NONFULL;
> > +                       list_add_tail(&ci->list, &si->nonfull_clusters[=
0]);
> > +               } else {
> >                         ci->flags =3D CLUSTER_FLAG_FREE;
> >                         list_add_tail(&ci->list, &si->free_clusters);
> >                 }
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index c869859eec77..c0a9be14a725 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -237,10 +237,13 @@ static bool zswap_has_pool;
> >  * helpers and fwd declarations
> >  **********************************/
> >
> > +/* One swap address space for each 64M swap space */
> > +#define ZSWAP_ADDRESS_SPACE_SHIFT 14
> > +#define ZSWAP_ADDRESS_SPACE_PAGES (1 << ZSWAP_ADDRESS_SPACE_SHIFT)
> >  static inline struct xarray *swap_zswap_tree(swp_entry_t swp)
> >  {
> >         return &zswap_trees[swp_type(swp)][swp_offset(swp)
> > -               >> SWAP_ADDRESS_SPACE_SHIFT];
> > +               >> ZSWAP_ADDRESS_SPACE_SHIFT];
> >  }
> >
> >  #define zswap_pool_debug(msg, p)                               \
> > @@ -1771,7 +1774,7 @@ int zswap_swapon(int type, unsigned long nr_pages=
)
> >         struct xarray *trees, *tree;
> >         unsigned int nr, i;
> >
> > -       nr =3D DIV_ROUND_UP(nr_pages, SWAP_ADDRESS_SPACE_PAGES);
> > +       nr =3D DIV_ROUND_UP(nr_pages, ZSWAP_ADDRESS_SPACE_PAGES);
> >         trees =3D kvcalloc(nr, sizeof(*tree), GFP_KERNEL);
> >         if (!trees) {
> >                 pr_err("alloc failed, zswap disabled for swap type %d\n=
", type);
> > --
> > 2.51.0
> >
>


Return-Path: <linux-kernel+bounces-806165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EF6B492AF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D734F3A95C7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9533330C626;
	Mon,  8 Sep 2025 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkC9hNME"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1681C30CD92
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757344513; cv=none; b=ZZkWe76VCtRU7ebQqJPlsP0Og5Ogy8+Hp/lkUUuUZlyNLVO8z+XetykSxm5+wClxeN0OFAyDlmzZkc8+p7hRR5Nz/JERqkTpLbtootr+yvy/Q6eEVAYfXL1QLTLsg52C4GLvl2oEAVIfDtJCHuZaARJlE369SLntgHwJDoldtjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757344513; c=relaxed/simple;
	bh=FBvWTtV6ZRQH5ZQxtAJCYllYJw2QDNVpTLvipTQ3TNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSgrwWO4s2VzXxel4GYEwv5KUIBlPvIpO9kcqcc7wuUhV1N+NPKnqmfc53HEoxEmt9OV72Q3OGQmg8BDb6qdExmFHUs3ThyPd8d+DaJMSxCfPvgvqWO8hqfQhLSQVm3LpolKmQaIlSrZjVJqobeCi0Beku+DTaHpInhU7CQDdBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkC9hNME; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61d143aa4acso7238748a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757344510; x=1757949310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXA2Jum3C80Q1Y4JkqkK6rtU/2eiC3aTbCjeS9iNmzA=;
        b=lkC9hNMEIQdrBzMuYx8PqJsFJozCf0GJW8l4ApV0oEo+t2G8ATIop5yjJIPQKs1uI2
         8S/QXrAz0QRI9CMG57vPXE9UNKaG/j6gIt8QWeg+lQN55TojbNkeYpanrpYWOUQ/rIDv
         iODhsIfNfteO/s7IF+v5J7tpfmzCUgUQEpEp1Wuw7V4G304H4y1Qq4fX3SCuxbKyodXk
         zQ7njDyZ6/XNw9uAO3IPfeE+V/i2OJ/g0v8Qlzyp7h1MY+UnbcxhxF1qwF0SLV02cm0T
         9VEmsfyOk1rD5fxlizMESz+eRJpWAGBz3YcTmLDCmp0Oo9RGkn8DkZWVQlD35g2nb3H0
         90nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757344510; x=1757949310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXA2Jum3C80Q1Y4JkqkK6rtU/2eiC3aTbCjeS9iNmzA=;
        b=E56SD+yw5h6sTClgx0OWZEK8BSj4FJc7m9I8pJFwxDsYQdswZ+gdT1WyKLFjWN2WcP
         qbf916g+qwZB25sRt++ksTJjEZ3ruEozqGCHohLr5pwTcATuo9yota//KHC/R1i5Y7W4
         E6AQEmg9MaDe/s5fwy2OIVSEEbg6ONdCHcTaoPO9wGeEv6uR08dRQov56oiwl30UjRJh
         CyT+UhOARrKqIiB2QXpOg01fmnFLA+is+GMYSFqXBxMeEp6nGBAW3A/jHClDC1rpjY/7
         +wtOLJfThb8/JoFfwcXF8Pro7LdAjhBAVnWbaHRQGc6W/ilzmBEZz2M8YJYIgXwVpejK
         WuVA==
X-Forwarded-Encrypted: i=1; AJvYcCXtFwhHZEtGb4/cg4us5VRioX0OJJ2ysgSCqF1B41cjpclD4Sgmrm5F/CGqKLnb6DkOebwWyTw1uzbSDLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJTtCbKjZC8dFtXXF6AprNimlrkYLu/+AGjhVHDxzGPRLwAGxR
	FRKHUmY30H7raGi7luxxkdtIUggL8TMbZZNqRVdCX6lWTI/wmjYeJ7I3BAHe4f+6GeoaCnOd4Sn
	PxDEvbzrgBaD3vtXKwg6WEIyn4GmbuhQ=
X-Gm-Gg: ASbGncsawExZAg9t3JAF2Ozuu5ZB8iVtRXvPpsFPXNNnUWax6yPGs7QCi6m0YQQ0zEY
	8ghkefsEhY0FmLMOfjLYOvEAhXoPPB8WKYrXBSVZpZotm7qTNy2XKCQrnCTe+8snjZj4bJZuvT2
	9o/uREB78y4TEHeQAz0m7jLsLvUE4hYgjZ86ffupg+vIvIGnsMZUvrFd47Xo4KXslV9wEhpTl4b
	7nLrpzAYKm4PBwV75HtCQ==
X-Google-Smtp-Source: AGHT+IFfzgh7slkI9APLqBFcPALe6N6LfPwpqVZHZal2suURwJH/Q0oQbDMfDqtIwsdF4Gq5DaUCBzS9zexyL7jPqeM=
X-Received: by 2002:a05:6402:4415:b0:61e:a5c8:e830 with SMTP id
 4fb4d7f45d1cf-6237aec0166mr7232307a12.1.1757344510250; Mon, 08 Sep 2025
 08:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-12-ryncsn@gmail.com>
 <4e0847db-0503-406b-95b4-02ee7e8f9604@redhat.com>
In-Reply-To: <4e0847db-0503-406b-95b4-02ee7e8f9604@redhat.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 8 Sep 2025 23:14:33 +0800
X-Gm-Features: AS18NWD12hxIhTxyJKTGDZ2indGJ3CbXeECCYM7JzuKXWB8xNJgaDKDEKpvdK3M
Message-ID: <CAMgjq7DwOe_OJ4qyfY-2=kmaY4tfvQGaedie+6NvPPX7YD0YGA@mail.gmail.com>
Subject: Re: [PATCH v2 11/15] mm, swap: use the swap table for the swap cache
 and switch API
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

On Mon, Sep 8, 2025 at 11:09=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
> > +static inline struct swap_cluster_info *swap_cluster_lock(
> > +     struct swap_info_struct *si, pgoff_t offset, bool irq)
> > +{
> > +     return NULL;
> > +}
> > +
> > +static inline struct swap_cluster_info *swap_cluster_lock_by_folio(
> > +             struct folio *folio)
>
> I would probably call that "swap_cluster_get_and_lock" or sth like that .=
..
>
> > +{
> > +     return NULL;
> > +}
> > +
> > +static inline struct swap_cluster_info *swap_cluster_lock_by_folio_irq=
(
> > +             struct folio *folio)
> > +{
>
> ... then this would become "swap_cluster_get_and_lock_irq"
>
>
> Alterantively, separate the lookup from the locking of the cluster.
>
> swap_cluster_from_folio() / folio_get_swap_cluster()
> swap_cluster_lock()
> swap_cluster_lock_irq()
>
> Which might look cleaner in the end.

That's a very good suggestion.

>
> [...]
>
> > -struct address_space *swapper_spaces[MAX_SWAPFILES] __read_mostly;
> > -static unsigned int nr_swapper_spaces[MAX_SWAPFILES] __read_mostly;
> > +struct address_space swap_space __read_mostly =3D {
> > +     .a_ops =3D &swap_aops,
> > +};
> > +
> >   static bool enable_vma_readahead __read_mostly =3D true;
> >
> >   #define SWAP_RA_ORDER_CEILING       5
> > @@ -83,11 +86,21 @@ void show_swap_cache_info(void)
> >    */
> >   struct folio *swap_cache_get_folio(swp_entry_t entry)
> >   {
> > -     struct folio *folio =3D filemap_get_folio(swap_address_space(entr=
y),
> > -                                             swap_cache_index(entry));
> > -     if (IS_ERR(folio))
> > -             return NULL;
> > -     return folio;
> > +
>
> ^ superfluous empty line.
>
> [...]
>
> >
> > @@ -420,6 +421,34 @@ static inline unsigned int cluster_offset(struct s=
wap_info_struct *si,
> >       return cluster_index(si, ci) * SWAPFILE_CLUSTER;
> >   }
> >
> > +static int swap_table_alloc_table(struct swap_cluster_info *ci)
>
> swap_cluster_alloc_table ?

Good idea.

>
> > +{
> > +     WARN_ON(ci->table);
> > +     ci->table =3D kzalloc(sizeof(unsigned long) * SWAPFILE_CLUSTER, G=
FP_KERNEL);
> > +     if (!ci->table)
> > +             return -ENOMEM;
> > +     return 0;
> > +}
> > +
> > +static void swap_cluster_free_table(struct swap_cluster_info *ci)
> > +{
> > +     unsigned int ci_off;
> > +     unsigned long swp_tb;
> > +
> > +     if (!ci->table)
> > +             return;
> > +
> > +     for (ci_off =3D 0; ci_off < SWAPFILE_CLUSTER; ci_off++) {
> > +             swp_tb =3D __swap_table_get(ci, ci_off);
> > +             if (!swp_tb_is_null(swp_tb))
> > +                     pr_err_once("swap: unclean swap space on swapoff:=
 0x%lx",
> > +                                 swp_tb);
> > +     }
> > +
> > +     kfree(ci->table);
> > +     ci->table =3D NULL;
> > +}
> > +
> >   static void move_cluster(struct swap_info_struct *si,
> >                        struct swap_cluster_info *ci, struct list_head *=
list,
> >                        enum swap_cluster_flags new_flags)
> > @@ -702,6 +731,26 @@ static bool cluster_scan_range(struct swap_info_st=
ruct *si,
> >       return true;
> >   }
> >
> > +/*
> > + * Currently, the swap table is not used for count tracking, just
> > + * do a sanity check here to ensure nothing leaked, so the swap
> > + * table should be empty upon freeing.
> > + */
> > +static void cluster_table_check(struct swap_cluster_info *ci,
> > +                             unsigned int start, unsigned int nr)
>
> "swap_cluster_assert_table_empty()"
>
> or sth like that that makes it clearer what you are checking for.

Agree.

>
> --
> Cheers
>

Thanks!


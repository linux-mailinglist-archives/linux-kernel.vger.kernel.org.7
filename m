Return-Path: <linux-kernel+bounces-806204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A64FB49384
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0DA3A6373
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDA73002C1;
	Mon,  8 Sep 2025 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGd0wPsV"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9140110E0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345599; cv=none; b=QpPqNcqYc38QMUZ+GFRJRODjJSqk2QehhJ2gy5QIPlwTf5cln4vFh+Q80CS+YHmgyKzzRwRbn8ArX18CxjhgB6qPvXX3Bq1KESzhSV7zfLhI5tuuf5DbfZPjHffS+20yOqzrOf63cvCMg352GWi7k612uyWsTPzQXaZ9OGosqp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345599; c=relaxed/simple;
	bh=8QPXTPhdAbGrl5k2bDPsy6vR3UsZlsN+1qm5aiPquyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sGAv1ybbRfx5YDfo43h9V+/23gPt/Z2AcO3IOKGFMpx2q0ABFbY95xHfm915pBTxjTgVZmeH5aNOgJPnhkZG8Rs/oleHDCvX3h1UfB4ZtZ5EtnpO4zqNb7jfFSmMREceLHBpo3/j3uL+j/5NDTJjsvxE/Gt5U2UIBtBkLdbu+JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGd0wPsV; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so5419766a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757345596; x=1757950396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZVrR3an19UV8FKFFnWTfq7Zz5DZQLrwj3scgnZZSmI=;
        b=bGd0wPsV4XLfDRo+snBznNhm/Zwo9vF2RyU9nzZsbl+KnQmOSkEnqdgfhfbmY5/n2z
         9vDEAdaqe2vNIc+gFrb0POw3aoL5EHGKaZ/arG837wkkQq7MdC/onVX1ewvweTzEAvUn
         J+N0ex31kZhDUfShvKy78VzURRUTjsbkkCBYbQR0GzvoBmy4X+yNfhg6PQ79phNyjfqE
         fHGbLJBYBhxBamKyPOS/sxkgi03+gyJ2329QA1QbZVb6lZoqVmR8AQ1YrNF5BF/v9SJo
         TeZQz7hTX9mPmUFW4AyIYqVTnMs5k18LAEWMMf5rIM0YG0BaG91BJY8TcO2LLhOGUkKi
         /iFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757345596; x=1757950396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZVrR3an19UV8FKFFnWTfq7Zz5DZQLrwj3scgnZZSmI=;
        b=wzN3Uw1v95WJ1GhgXbkbCzElGUVAZwxoiZ8i6RKhFxg9y78fNMW0oNOFiuBIz6r+zE
         msPOdiSJbyKoEU8JXHrd1mG5CG/gdfXhhdcWa1yfw5zlNKyZR/WCCrfZTUKbZ9RcbqDm
         oq/SmCbgR3nJ8vJEzWdduk7PX8SI2MVx4UjTeFrs6VoMHHKpFEF0aMb+YE2RTDt78hob
         d8PgBmkt/RfKWF4CP6BOFJUGFeY+wG7IgyhETEaRRggnbdlNBjvddtHetCE/kkHSk82U
         Q8RZaoGBfN2l5XfNea+ShM3zBwW85P1tGKKxq7ailXSENICO6cXyGnOWn20qc0YDXeOx
         feYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtMsFlYXq4XubyO9Os1znSm8BULEjtTstXNo+EEot4/Z6HoPmvXje7xk5ZLnq7nfkjCCXyGpUXPcSUeVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWjQ6ZxAX2oHXEgbij0q/VkWjaiyEwSkzkotSjLQgZ63nJeFmN
	Wt74BG2fbW2DF4Tjgq3heI0m8mYEICgnuUn6knHXlUiUVYg2JqnY47Do7X5a0xdNERIbsn30dXF
	3TiEU6YvU7Q3IOb+YKaPOjxkO4aNeG7U6JxeMYJkznA==
X-Gm-Gg: ASbGncu+Y+cendXulmxmhNKeV3Qvj835uqf8V7Af6y9Ov3bA3lH1OgZbLRLhr4zSSjZ
	B2jFaHCurucFOHyWto/ju6PWIt89vXrGuAdfUXo2JoPW6MuFMjaSt0dL/SeEj9vGThjIB/XImx8
	/asJWPHs7rWVo5GVr7II8tlv2EfxXK7krfc0cjwrtzOk4lI4Z9+ApdRjIcQoAky1TLb2cYbIGJw
	wpz6See2uk=
X-Google-Smtp-Source: AGHT+IFRFi5Xqpl2pdT2FnrxwsH/ow75+LcLyLfi/+OQwqwShtSEx3U0nw6dCvXNmCJHklh+F0eyqHKuhFK+SySG/DE=
X-Received: by 2002:a05:6402:26cb:b0:627:c107:842d with SMTP id
 4fb4d7f45d1cf-627c1080d8emr4566072a12.4.1757345595382; Mon, 08 Sep 2025
 08:33:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-12-ryncsn@gmail.com>
 <4e0847db-0503-406b-95b4-02ee7e8f9604@redhat.com> <CAMgjq7DwOe_OJ4qyfY-2=kmaY4tfvQGaedie+6NvPPX7YD0YGA@mail.gmail.com>
In-Reply-To: <CAMgjq7DwOe_OJ4qyfY-2=kmaY4tfvQGaedie+6NvPPX7YD0YGA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 8 Sep 2025 23:32:37 +0800
X-Gm-Features: AS18NWDbSr0Gkko7eoHtA8RoONl_d7BHBe6TNsfkvf1so0l3yE74J8Gr3SEqiHM
Message-ID: <CAMgjq7DWOiz85i0aQZFKgdWcBvKLZDHkOT-FCiXwiax1kbSZng@mail.gmail.com>
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

On Mon, Sep 8, 2025 at 11:14=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Mon, Sep 8, 2025 at 11:09=E2=80=AFPM David Hildenbrand <david@redhat.c=
om> wrote:
> > > +static inline struct swap_cluster_info *swap_cluster_lock(
> > > +     struct swap_info_struct *si, pgoff_t offset, bool irq)
> > > +{
> > > +     return NULL;
> > > +}
> > > +
> > > +static inline struct swap_cluster_info *swap_cluster_lock_by_folio(
> > > +             struct folio *folio)
> >
> > I would probably call that "swap_cluster_get_and_lock" or sth like that=
 ...
> >
> > > +{
> > > +     return NULL;
> > > +}
> > > +
> > > +static inline struct swap_cluster_info *swap_cluster_lock_by_folio_i=
rq(
> > > +             struct folio *folio)
> > > +{
> >
> > ... then this would become "swap_cluster_get_and_lock_irq"
> >
> >
> > Alterantively, separate the lookup from the locking of the cluster.
> >
> > swap_cluster_from_folio() / folio_get_swap_cluster()
> > swap_cluster_lock()
> > swap_cluster_lock_irq()
> >
> > Which might look cleaner in the end.
>
> That's a very good suggestion.

Hmm, one problem here is swap_cluster_lock's args are the `si` and
`offset`. But swap_cluster_from_folio returns a pointer to the
cluster. Retrieving the offset / si pointer after having the pointer
to the cluster seems redundant and troublesome.

I think maybe swap_cluster_get_and_lock is better. (Not sure if it
looks strange to take a folio as argument).

>
> >
> > [...]
> >
> > > -struct address_space *swapper_spaces[MAX_SWAPFILES] __read_mostly;
> > > -static unsigned int nr_swapper_spaces[MAX_SWAPFILES] __read_mostly;
> > > +struct address_space swap_space __read_mostly =3D {
> > > +     .a_ops =3D &swap_aops,
> > > +};
> > > +
> > >   static bool enable_vma_readahead __read_mostly =3D true;
> > >
> > >   #define SWAP_RA_ORDER_CEILING       5
> > > @@ -83,11 +86,21 @@ void show_swap_cache_info(void)
> > >    */
> > >   struct folio *swap_cache_get_folio(swp_entry_t entry)
> > >   {
> > > -     struct folio *folio =3D filemap_get_folio(swap_address_space(en=
try),
> > > -                                             swap_cache_index(entry)=
);
> > > -     if (IS_ERR(folio))
> > > -             return NULL;
> > > -     return folio;
> > > +
> >
> > ^ superfluous empty line.
> >
> > [...]
> >
> > >
> > > @@ -420,6 +421,34 @@ static inline unsigned int cluster_offset(struct=
 swap_info_struct *si,
> > >       return cluster_index(si, ci) * SWAPFILE_CLUSTER;
> > >   }
> > >
> > > +static int swap_table_alloc_table(struct swap_cluster_info *ci)
> >
> > swap_cluster_alloc_table ?
>
> Good idea.
>
> >
> > > +{
> > > +     WARN_ON(ci->table);
> > > +     ci->table =3D kzalloc(sizeof(unsigned long) * SWAPFILE_CLUSTER,=
 GFP_KERNEL);
> > > +     if (!ci->table)
> > > +             return -ENOMEM;
> > > +     return 0;
> > > +}
> > > +
> > > +static void swap_cluster_free_table(struct swap_cluster_info *ci)
> > > +{
> > > +     unsigned int ci_off;
> > > +     unsigned long swp_tb;
> > > +
> > > +     if (!ci->table)
> > > +             return;
> > > +
> > > +     for (ci_off =3D 0; ci_off < SWAPFILE_CLUSTER; ci_off++) {
> > > +             swp_tb =3D __swap_table_get(ci, ci_off);
> > > +             if (!swp_tb_is_null(swp_tb))
> > > +                     pr_err_once("swap: unclean swap space on swapof=
f: 0x%lx",
> > > +                                 swp_tb);
> > > +     }
> > > +
> > > +     kfree(ci->table);
> > > +     ci->table =3D NULL;
> > > +}
> > > +
> > >   static void move_cluster(struct swap_info_struct *si,
> > >                        struct swap_cluster_info *ci, struct list_head=
 *list,
> > >                        enum swap_cluster_flags new_flags)
> > > @@ -702,6 +731,26 @@ static bool cluster_scan_range(struct swap_info_=
struct *si,
> > >       return true;
> > >   }
> > >
> > > +/*
> > > + * Currently, the swap table is not used for count tracking, just
> > > + * do a sanity check here to ensure nothing leaked, so the swap
> > > + * table should be empty upon freeing.
> > > + */
> > > +static void cluster_table_check(struct swap_cluster_info *ci,
> > > +                             unsigned int start, unsigned int nr)
> >
> > "swap_cluster_assert_table_empty()"
> >
> > or sth like that that makes it clearer what you are checking for.
>
> Agree.
>
> >
> > --
> > Cheers
> >
>
> Thanks!


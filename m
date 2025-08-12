Return-Path: <linux-kernel+bounces-764083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94250B21DCE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA6C1694B8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67522367DC;
	Tue, 12 Aug 2025 05:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHPm74vQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B0B29BDA4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754978320; cv=none; b=Ei1yPe6jP3ys7i74IJCKGYgwEbPIxZJnq8Xdd6r4AO/KB4OU7Spl6mFKsBjF4o2WbUAjEVkwRi5S741c+U4dhykF3+GZ6i08+b3R/1YmZKShNZpawxuTjCEPC9OevYKqKicG6stwPKVDcW67tENVv7ur9GqMmWyZUp7BgQRNkho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754978320; c=relaxed/simple;
	bh=5/IY6DIk3onVp/qtCNMehb2TxY8eCwzuw7RtOQJuQas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEGA3xO2URdrSXZwnayS9Mx32uI/PipEP34yh2DBU+GAGbXb9jDyzYI6+lWd+8IjT+M8DqTtw0NAK2Y7tZpp3fB8R9Fax71gfhL9nUcxfXeAzD0fHRQZmOijw2g92uk3cGK6jh2josPoArMD8pmkXZWL2cLwzxTwvobDAHv70GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHPm74vQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B301C4CEF0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754978317;
	bh=5/IY6DIk3onVp/qtCNMehb2TxY8eCwzuw7RtOQJuQas=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rHPm74vQQP6+4xv5GKUq+Yid8PFLFpE16C1OzihWakyVIsdQph7mlcJiR6GcoBqk5
	 unkTOREJE5OJ5z+/G1XWSShuFgX3q4eSev7xu/AlnyW0rHpLpo6/3Du5yF1VzkQiyO
	 ZAdPPWGmBjaK3PrO6WnQT1Dueluf7HzeY02QuiWxZ7mTs7gnbZpkQeCKN2orsFbQYb
	 gXdcro4Z22fkTxbrO6JUxG8Jqr914Zl9oq4abyyNE/AERslF/WO8JgBifScTD01rj7
	 6qtDt1AW2bwByXJJ6/78BHVJgWPkvpQMgJjpeTkQy5n32U52/cvA74At3FQTT3Z+5G
	 d+NuoioC1oU8Q==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71c42f1b4e7so6493287b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 22:58:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/pOgi3NgAHQkxSznSSguIQ7Sb31BAXJ594oXRjcafZIeO+5z47VHeS09GKKgxPNen/dR2DpyGHDIa6/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YznsDHk6jfsMc6+us+vVJEdLWeMbqlCYyNI5UZbkXAxXz6Z9VNR
	jeldh0XV8qY7jbfHLNL1aoFDpre8rndtVdkIU0GG8tUsegWXpAU9Y78Mj7oWuHPzhOcLFgd7+Jj
	vfummS5nGCUZG9D4pn+9MBHxigEXMnqPKjHV70eeOig==
X-Google-Smtp-Source: AGHT+IHxPmqLpRi7tVGLNW6BM10nSnUTAR4Hfu96ndWi0UBHb9Z6BoUVpa9fxWCcvwq63GZGNjOqRrIM8H10gWjMOgE=
X-Received: by 2002:a05:690c:4d08:b0:71c:1754:26a7 with SMTP id
 00721157ae682-71c42a7b6fdmr27964767b3.32.1754978316845; Mon, 11 Aug 2025
 22:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808-swap-scan-list-v2-1-d50e4758ecee@kernel.org> <CAMgjq7DnniGUdpQQA0YF+LuMuL9+FCLQJP2Q04G_Hsd1sztv9A@mail.gmail.com>
In-Reply-To: <CAMgjq7DnniGUdpQQA0YF+LuMuL9+FCLQJP2Q04G_Hsd1sztv9A@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 11 Aug 2025 22:58:25 -0700
X-Gmail-Original-Message-ID: <CACePvbV65tjGnWr_zFs5ZHoAX2x=As=rMrwJKCho6c5-Dw7qaA@mail.gmail.com>
X-Gm-Features: Ac12FXxqc0syoLGdo5ljlvqqxbaJSAIDobIKRfOTmrg0MugEHBH3FWYc6Za-Hmk
Message-ID: <CACePvbV65tjGnWr_zFs5ZHoAX2x=As=rMrwJKCho6c5-Dw7qaA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/swapfile.c: introduce function alloc_swap_scan_list()
To: Kairui Song <ryncsn@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 12:52=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Fri, Aug 8, 2025 at 3:48=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote=
:
> >
> > This the alloc_swap_scan_list() will scan the whole list or the first
> > cluster.
>
> Hi Chris,
>
> This sentence reads strange to me, but English is not my native
> language so I'm not very sure about it.

Ack, my bad, let me rephrase it.
>
> >
> > This reduces the repeat patterns of isolating a cluster then scanning
> > that cluster. As a result, cluster_alloc_swap_entry() is shorter and sh=
allower.
> >
> > No functional change.
> >
> > Signed-off-by: Chris Li <chrisl@kernel.org>
> > ---
> > This patch goes on top of Kairui's swap improve cluster scan series:
> > https://lore.kernel.org/linux-mm/20250806161748.76651-1-ryncsn@gmail.co=
m/
> > ---
> > Changes in v2:
> > - Adjust change base on Andrew's feedback on int type and break out of
> >   loop.
> > - Link to v1: https://lore.kernel.org/r/20250806-swap-scan-list-v1-1-a5=
fe2d9340a2@kernel.org
> > ---
> >  mm/swapfile.c | 86 ++++++++++++++++++++++++++++++++-------------------=
--------
> >  1 file changed, 47 insertions(+), 39 deletions(-)
> >
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 4a0cf4fb348d..f26678d68874 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -820,6 +820,29 @@ static unsigned int alloc_swap_scan_cluster(struct=
 swap_info_struct *si,
> >         return found;
> >  }
> >
> > +static unsigned int alloc_swap_scan_list(struct swap_info_struct *si,
> > +                                        struct list_head *list,
> > +                                        unsigned int order,
> > +                                        unsigned char usage,
> > +                                        bool scan_all)
> > +{
> > +       unsigned int found =3D SWAP_ENTRY_INVALID;
> > +
> > +       do {
> > +               struct swap_cluster_info *ci =3D isolate_lock_cluster(s=
i, list);
> > +               unsigned long offset;
> > +
> > +               if (!ci)
> > +                       break;
> > +               offset =3D cluster_offset(si, ci);
> > +               found =3D alloc_swap_scan_cluster(si, ci, offset, order=
, usage);
> > +               if (found)
> > +                       break;
> > +       } while (scan_all);
> > +
> > +       return found;
> > +}
> > +
> >  static void swap_reclaim_full_clusters(struct swap_info_struct *si, bo=
ol force)
> >  {
> >         long to_scan =3D 1;
> > @@ -913,32 +936,24 @@ static unsigned long cluster_alloc_swap_entry(str=
uct swap_info_struct *si, int o
> >          * to spread out the writes.
> >          */
> >         if (si->flags & SWP_PAGE_DISCARD) {
> > -               ci =3D isolate_lock_cluster(si, &si->free_clusters);
> > -               if (ci) {
> > -                       found =3D alloc_swap_scan_cluster(si, ci, clust=
er_offset(si, ci),
> > -                                                       order, usage);
> > -                       if (found)
> > -                               goto done;
> > -               }
> > +               found =3D alloc_swap_scan_list(si, &si->free_clusters, =
order, usage,
> > +                                            false);
> > +               if (found)
> > +                       goto done;
> >         }
> >
> >         if (order < PMD_ORDER) {
> > -               while ((ci =3D isolate_lock_cluster(si, &si->nonfull_cl=
usters[order]))) {
> > -                       found =3D alloc_swap_scan_cluster(si, ci, clust=
er_offset(si, ci),
> > -                                                       order, usage);
> > -                       if (found)
> > -                               goto done;
> > -               }
> > +               found =3D alloc_swap_scan_list(si, &si->nonfull_cluster=
s[order],
> > +                                            order, usage, 0);
>
> All other alloc_swap_scan_list calls use `false`/`true` but this one
> uses `0` for `scan_all`.
> And it should be `true`, right?

Yes, good catch. Will send out a V3.

>
> > +               if (found)
> > +                       goto done;
> >         }
> >
> >         if (!(si->flags & SWP_PAGE_DISCARD)) {
> > -               ci =3D isolate_lock_cluster(si, &si->free_clusters);
> > -               if (ci) {
> > -                       found =3D alloc_swap_scan_cluster(si, ci, clust=
er_offset(si, ci),
> > -                                                       order, usage);
> > -                       if (found)
> > -                               goto done;
> > -               }
> > +               found =3D alloc_swap_scan_list(si, &si->free_clusters, =
order, usage,
> > +                                            false);
> > +               if (found)
> > +                       goto done;
> >         }
> >
> >         /* Try reclaim full clusters if free and nonfull lists are drai=
ned */
> > @@ -952,13 +967,10 @@ static unsigned long cluster_alloc_swap_entry(str=
uct swap_info_struct *si, int o
> >                  * failure is not critical. Scanning one cluster still
> >                  * keeps the list rotated and reclaimed (for HAS_CACHE)=
.
> >                  */
> > -               ci =3D isolate_lock_cluster(si, &si->frag_clusters[orde=
r]);
> > -               if (ci) {
> > -                       found =3D alloc_swap_scan_cluster(si, ci, clust=
er_offset(si, ci),
> > -                                                       order, usage);
> > -                       if (found)
> > -                               goto done;
> > -               }
> > +               found =3D alloc_swap_scan_list(si, &si->frag_clusters[o=
rder], order,
> > +                                            usage, true);
>
> And it should be `false` here.

Ack.

Chris


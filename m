Return-Path: <linux-kernel+bounces-879579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF88C23819
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C9344E9613
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C502326D73;
	Fri, 31 Oct 2025 07:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RotUCLMm"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36E8126F0A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761894713; cv=none; b=tdFCA1Lmn+zeI7S2hIVaKlmNb+cbh07808TtXNHOiOu5XWcT1fiUNcgpBXPQ4d+f6V2dGrE6UcJmW1ORqw6fsirDtnThScu/NyVJfxPURrRqUzB33LPUytRmovVCSgsFhJe2T0mwsYvh+lIs0SAmigTQTsNxAZxCvhh86XvbPrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761894713; c=relaxed/simple;
	bh=VZYM/0sosGMiKyD6UrQR72FuCUB38UrgBQx4ZdyCbcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOsH/BGL+B1KUwdfM2gR70xutrn2gsb0JEyRlyCHWzOgREJ0+S3jy9eW5GOp3dpjUyHFeMHX8sCNWeFE/Gdnb5jalDqI/8r1YVBtSKTzcLRYqPf+lMgMZsgwKtqjh6PJHGkYeYZ2Ci4YCpWPEdFF2/UWui/2HyUfoPrd8995/ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RotUCLMm; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63c2d72582cso3195373a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761894710; x=1762499510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXB+Vh+b92T0wuC0Ul2D33PSfjieUXT8f5pmdI4rnpo=;
        b=RotUCLMmzHvi3PwAevq64pNYB83h0OLpu7+1OZaBZI0Y24BDaLxMHxVDIIGPsE+KkB
         ZSfNGYv29sCGSEosDcbpjdGfE96mJEPPePBhw8UPpIsy73ImcURlE0kcdA+92KdFbEc2
         k5YWZnbW258VuwUgjksNADIMmMPPirRDt5ZTylRvsj3YMlLjOJcDYI9VFQwLVncZ2iau
         iVHK4DW4aTvuGtkurcre++aZnGl/YydvVtH+X5qD2WoAHAICUSdX8roM4i04jnieF4O1
         kevSwTscvl2mw+utREVoqP+9S5HGXRzF+26OuD1X/8fhPgLy0EE+XXbfw9QdUkCzknnI
         Vdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761894710; x=1762499510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXB+Vh+b92T0wuC0Ul2D33PSfjieUXT8f5pmdI4rnpo=;
        b=b7Im7g0DiQwbjJQ9BOUf7rEM2FREo2pu5ZHkLVt1WKimq/ImetxpVpLBQKFRtDpBaY
         AMXwscnbYnG0ywKDnddch4dq44KU17WxaVd1Kv91EDz2GKxs/ki9iK8Y7+6IhVVoMDQG
         y28W7l9BzxdsRYh9M32yBELU+MwTbtvnBlTvIzLoETGEUKWgIC5EjbycWggt8or0O2Ys
         9w6/gNZHcOfnwhtMdah7AI8LYbg/Kxetmq0lLTwsIT6e8uuHUJHrDWBFnyEYlszdZYc8
         /iuKct/1FrvsD8nNg7tjj5zivEgzaFlAWJB+KK2YJUOmc2xaqyTNQ7RLCEuI+Pg8i/Mm
         vAZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXll1yVrJM/ApErs2RCElxM94NzUDacAmaSdSkZRf7ncgGmfOrTzI6s/7ornCkMd+el8+P1+WGGuHW4tRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuCPYPyi6fOdsNpknK6X+buhXj54ZoCbisrpVFfBfddg5y201i
	VPyhuS6P67EMVQeG6Ync0zcBKA4gk9VZIz5G312eYk3CpkNMeiaF6JBwWIe3c7Upmvl2czIMg1a
	zJ0OKeIRBPDfecXhAhuLJEc2Dl0E/nQM=
X-Gm-Gg: ASbGnct/hnXXtDkC9kW0wxrOOTjpIGrXNTCfyXCAbLkoC44eCAGgkbEEMs7k/7R51n5
	tp9p0OUm4CaRnscZdYSSRDnRIe8L6SrFJbEFTg9aOL3ebCA2y5lhfhD9krlYVt/yoO1vBcdPQgu
	CuXlXnVoSY77p5fnrYxfY5l7Deg6mrWN5/AzsAjN1Eo0n0OW0XtFYgdm0wkE834a933Y0/c82oH
	U/aE3560QOK5keFVnwtH8ILE5I27+RMbszUJmprTOiXYk6kQbGowgoQ+nWv
X-Google-Smtp-Source: AGHT+IEa+rgq4Th4Ha/g3FBZ4FkmU4TjKVn+RGltX7Wmz1uoTotbPOvX8BJ4rCoXh+dAatlVRaYla2NKrWme3YUf5D0=
X-Received: by 2002:a05:6402:51cf:b0:639:ffb5:3606 with SMTP id
 4fb4d7f45d1cf-6407703ef39mr1959342a12.33.1761894709939; Fri, 31 Oct 2025
 00:11:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
 <20251029-swap-table-p2-v1-10-3d43f3b6ec32@tencent.com> <aQRIOMsAkDciWFw/@yjaykim-PowerEdge-T330>
In-Reply-To: <aQRIOMsAkDciWFw/@yjaykim-PowerEdge-T330>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 31 Oct 2025 15:11:13 +0800
X-Gm-Features: AWmQ_bkR65N4sXjn4E7jF7ZR-b0DRabhpr_6ttycSokgao5UgLF3qlUaZW0wRPk
Message-ID: <CAMgjq7A2gs+CMRftP9r4Pt=GKDAO=NaZVuKFYBVkZZjgz8c96g@mail.gmail.com>
Subject: Re: [PATCH 10/19] mm, swap: consolidate cluster reclaim and check logic
To: YoungJun Park <youngjun.park@lge.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 1:25=E2=80=AFPM YoungJun Park <youngjun.park@lge.co=
m> wrote:
>
> On Wed, Oct 29, 2025 at 11:58:36PM +0800, Kairui Song wrote:
>
> > From: Kairui Song <kasong@tencent.com>
> >
>
> Hello Kairu, great work on your patchwork. :)
> > Swap cluster cache reclaim requires releasing the lock, so some extra
> > checks are needed after the reclaim. To prepare for checking swap cache
> > using the swap table directly, consolidate the swap cluster reclaim and
> > check the logic.
> >
> > Also, adjust it very slightly. By moving the cluster empty and usable
> > check into the reclaim helper, it will avoid a redundant scan of the
> > slots if the cluster is empty.
>
> This is Change 1
>
> > And always scan the whole region during reclaim, don't skip slots
> > covered by a reclaimed folio. Because the reclaim is lockless, it's
> > possible that new cache lands at any time. And for allocation, we want
> > all caches to be reclaimed to avoid fragmentation. And besides, if the
> > scan offset is not aligned with the size of the reclaimed folio, we are
> > skipping some existing caches.
>
> This is Change 2
>
> > There should be no observable behavior change, which might slightly
> > improve the fragmentation issue or performance.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/swapfile.c | 47 +++++++++++++++++++++++------------------------
> >  1 file changed, 23 insertions(+), 24 deletions(-)
> >
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index d66141f1c452..e4c521528817 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -778,42 +778,50 @@ static int swap_cluster_setup_bad_slot(struct swa=
p_cluster_info *cluster_info,
> >       return 0;
> >  }
> >
> > -static bool cluster_reclaim_range(struct swap_info_struct *si,
> > -                               struct swap_cluster_info *ci,
> > -                               unsigned long start, unsigned long end)
> > +static unsigned int cluster_reclaim_range(struct swap_info_struct *si,
> > +                                       struct swap_cluster_info *ci,
> > +                                       unsigned long start, unsigned i=
nt order)
> >  {
> > +     unsigned int nr_pages =3D 1 << order;
> > +     unsigned long offset =3D start, end =3D start + nr_pages;
> >       unsigned char *map =3D si->swap_map;
> > -     unsigned long offset =3D start;
> >       int nr_reclaim;
> >
> >       spin_unlock(&ci->lock);
> >       do {
> >               switch (READ_ONCE(map[offset])) {
> >               case 0:
> > -                     offset++;
> >                       break;
> >               case SWAP_HAS_CACHE:
> >                       nr_reclaim =3D __try_to_reclaim_swap(si, offset, =
TTRS_ANYWAY);
> > -                     if (nr_reclaim > 0)
> > -                             offset +=3D nr_reclaim;
> > -                     else
> > +                     if (nr_reclaim < 0)
> >                               goto out;
> >                       break;
> >               default:
> >                       goto out;
> >               }
> > -     } while (offset < end);
> > +     } while (++offset < end);
>
> Change 2
>
> >  out:
> >       spin_lock(&ci->lock);
> > +
> > +     /*
> > +      * We just dropped ci->lock so cluster could be used by another
> > +      * order or got freed, check if it's still usable or empty.
> > +      */
> > +     if (!cluster_is_usable(ci, order))
> > +             return SWAP_ENTRY_INVALID;
> > +     if (cluster_is_empty(ci))
> > +             return cluster_offset(si, ci);
> > +
>
> Change 1
>
> >       /*
> >        * Recheck the range no matter reclaim succeeded or not, the slot
> >        * could have been be freed while we are not holding the lock.
> >        */
> >       for (offset =3D start; offset < end; offset++)
> >               if (READ_ONCE(map[offset]))
> > -                     return false;
> > +                     return SWAP_ENTRY_INVALID;
> >
> > -     return true;
> > +     return start;
> >  }
> >
> >  static bool cluster_scan_range(struct swap_info_struct *si,
> > @@ -901,7 +909,7 @@ static unsigned int alloc_swap_scan_cluster(struct =
swap_info_struct *si,
> >       unsigned long start =3D ALIGN_DOWN(offset, SWAPFILE_CLUSTER);
> >       unsigned long end =3D min(start + SWAPFILE_CLUSTER, si->max);
> >       unsigned int nr_pages =3D 1 << order;
> > -     bool need_reclaim, ret;
> > +     bool need_reclaim;
> >
> >       lockdep_assert_held(&ci->lock);
> >
> > @@ -913,20 +921,11 @@ static unsigned int alloc_swap_scan_cluster(struc=
t swap_info_struct *si,
> >               if (!cluster_scan_range(si, ci, offset, nr_pages, &need_r=
eclaim))
> >                       continue;
> >               if (need_reclaim) {
> > -                     ret =3D cluster_reclaim_range(si, ci, offset, off=
set + nr_pages);
> > -                     /*
> > -                      * Reclaim drops ci->lock and cluster could be us=
ed
> > -                      * by another order. Not checking flag as off-lis=
t
> > -                      * cluster has no flag set, and change of list
> > -                      * won't cause fragmentation.
> > -                      */
> > -                     if (!cluster_is_usable(ci, order))
> > -                             goto out;
> > -                     if (cluster_is_empty(ci))
> > -                             offset =3D start;
> > +                     found =3D cluster_reclaim_range(si, ci, offset, o=
rder);
> >                       /* Reclaim failed but cluster is usable, try next=
 */
> > -                     if (!ret)
>
> Part of Change 1 (apply return value change)
>
> As I understand Change 1 just remove redudant checking.
> But, I think another part changed also.
> (maybe I don't fully understand comment or something)
>
> cluster_reclaim_range can return SWAP_ENTRY_INVALID
> if the cluster becomes unusable for the requested order.
> (!cluster_is_usable return SWAP_ENTRY_INVALID)
> And it continues loop to the next offset for reclaim try.
> Is this the intended behavior?

Thanks for the very careful review! I should keep the
cluster_is_usable check or abort in other ways to avoid touching an
unusable cluster, will fix it.


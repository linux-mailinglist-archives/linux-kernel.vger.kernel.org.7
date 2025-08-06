Return-Path: <linux-kernel+bounces-757222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCFEB1BF60
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B563B8D9F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8AD1C8633;
	Wed,  6 Aug 2025 03:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNfA+/ee"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7631F3FC7
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 03:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754451545; cv=none; b=FfMtsRtbRmenFnbK/idpAkcpLuoYL+G/iQyHV8jIlqr6PNRtFwGtVOmCIklvOIi4PYKvBwcOhLEVAJ8xahBH1vcMcEj7vOP8/7xeu1HKBS8g9icxAt8odfZA/QaB32QsV0F65f8CV3SM9irYYsiUwUFihC1Okirs5pXJbYrekyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754451545; c=relaxed/simple;
	bh=wKpbvesH5uwc3ZDqC7L74CN76b9fwUBYaAvVuNr0oeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5BgKanLMmWo5BWqt7xM4DDAfDmHxtuffdPMBnhN8zsJm1ptffyi/Y7KgJLKrwKcuttNkkdOCbW/SxLumA8wo5XdPjR2tbbcNEzmbZJsAL5JBqYJhIJEu9F6Q0otWXR629WVMFijC5u/zsFADIVAWcUyabQ3d865pvSSDNc8mMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNfA+/ee; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-33243562752so35470671fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 20:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754451542; x=1755056342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pT8gPUg++PGfeMd5QsLj4CoRRQLdIXbXj3kUkk+1RlU=;
        b=mNfA+/eesHUCfOKlJ5CXzBIK8BHvQQRYSGAcJJtrblftUaHkzuMXvG6CcAupTssSeU
         3jkWjAcsZk6KWhLwOW5LdZBESPqDUTLq3UEo3q6tehotOc+sXqo9FepwV3PsHNRv2k72
         G+jxmtNInddJNVJaliCrVrgNCLNIEdy59jKm9vYBZn6QXfUmg84G3ur+1/W0tpEQixcK
         eidjcqSpn9hh1lqt7fYZZuxYXh5XdRwP0jpT2vXzz8hWzPMrM4bnsDgB4+8FphLYlJLF
         SMxu2tAqyADvBZinqlnG+7xT+azIv9RYK7HEDGUU/QCu6syMGM01SAR6lpuXYSgpw+9P
         prWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754451542; x=1755056342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pT8gPUg++PGfeMd5QsLj4CoRRQLdIXbXj3kUkk+1RlU=;
        b=EojY7HQuSfYjorhL6eFYegd2bnj0IZEQmPne2MAg3O1Xmpppqrfv9u/46OCdIQfxPq
         1FJatr/pCzlhjjq4ZQRMNVR/JpemzxYVkP7iZ+rxhhCZpXYAvY6+T4ePe1v0jw6655mo
         OwIV+7qiYg/QjLVLf02aCXPc160QBKo1FbqVTIlNyEaRk0t9+kCePdDtnIl0Z/tutWa6
         lFc8kK9HzFCH9r7xRriHcvyn4GL9aawpWmmD9S6CPKR+FoFTunTSmeLLQArab6RWZFA2
         R7xd8IN9itasRUSRTxWmT2KLcVgQXqFqozpMkMzFVUZa7aGi3fBrTz3vd7iaFXDI/KNg
         H5DA==
X-Forwarded-Encrypted: i=1; AJvYcCWfsniQYAkJ1MS5+m5fhQZTA5oiQ4K63K90ZrrZ/JlHm38lmgwBohGedT4fesiUYiVOockKnZRveRw7Ai8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHalnrlk6QtEyfsGJ7cjShmgzmU/l9q3DZcLfy+qEpJPIpzjtH
	lRWxyUwOsKATGfq1kc6WCMRPh/dlgtfWorI/jZOa4wM8R/gGbRqAaVtlvfEpq2E9GsCxUs+RyAE
	ZjY/XIHamkSl5lcDvrbsiAsZpEObOsBY=
X-Gm-Gg: ASbGncvOuK1in5SQENRWpRoF+3AZx6OkbltMCKh3PVWzwhFw7PjKoUBgaFFv7q9iQ2b
	I9suIMhzzMcIkgIm/wrfm0jG3QlYvQO/1vrPTxFyyhzcno9gHJ+hIEq0Y6pz9N4UdpuROybmtf/
	6MIrB26I5Ohi8EhlEy3KEd26xdMdZbj5GRsFga3/zyoV4ODMcdwaY84TuyuJ3IIp57ATupb0YLh
	xuTP/M=
X-Google-Smtp-Source: AGHT+IHBglAwtqm4z8yQjqRQOQCSCAmCv05JxtHTKVaBxejjFoGIwClaEp5JLlQx8mxDV/3A3dGBJkVF8V5tSxeBUcc=
X-Received: by 2002:a05:651c:e0b:b0:332:8187:f837 with SMTP id
 38308e7fff4ca-333814040f2mr2549651fa.27.1754451541451; Tue, 05 Aug 2025
 20:39:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804172439.2331-1-ryncsn@gmail.com> <20250804172439.2331-3-ryncsn@gmail.com>
 <CAKEwX=PkJdz3Um9j4m2bPahN9NbQpn7QnOvEAxDdWUHTqSvchg@mail.gmail.com>
In-Reply-To: <CAKEwX=PkJdz3Um9j4m2bPahN9NbQpn7QnOvEAxDdWUHTqSvchg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 6 Aug 2025 11:38:25 +0800
X-Gm-Features: Ac12FXzGr6EunkglBI1a6aoXX9TZJeqjSvqs_Z6HQHT5Ue_7xnXoMTR827GcYFQ
Message-ID: <CAMgjq7CSRrjLYF=7ckieNsAhDX_Fqp0OkHxrGHB0gQG7=_RdOA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm, swap: prefer nonfull over free clusters
To: Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 8:06=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Mon, Aug 4, 2025 at 10:24=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > We prefer a free cluster over a nonfull cluster whenever a CPU local
> > cluster is drained to respect the SSD discard behavior [1]. It's not
> > a best practice for non-discarding devices. And this is causing a
> > chigher fragmentation rate.
> >
> > So for a non-discarding device, prefer nonfull over free clusters. This
> > reduces the fragmentation issue by a lot.
> >
> > Testing with make -j96, defconfig, using 64k mTHP, 8G ZRAM:
> >
> > Before: sys time: 6121.0s  64kB/swpout: 1638155  64kB/swpout_fallback: =
189562
> > After:  sys time: 6145.3s  64kB/swpout: 1761110  64kB/swpout_fallback: =
66071
> >
> > Testing with make -j96, defconfig, using 64k mTHP, 10G ZRAM:
> >
> > Before: sys time 5527.9s  64kB/swpout: 1789358  64kB/swpout_fallback: 1=
7813
> > After:  sys time 5538.3s  64kB/swpout: 1813133  64kB/swpout_fallback: 0
> >
> > Performance is basically unchanged, and the large allocation failure ra=
te
> > is lower. Enabling all mTHP sizes showed a more significant result:
> >
> > Using the same test setup with 10G ZRAM and enabling all mTHP sizes:
> >
> > 128kB swap failure rate:
> > Before: swpout:449548 swpout_fallback:55894
> > After:  swpout:497519 swpout_fallback:3204
> >
> > 256kB swap failure rate:
> > Before: swpout:63938  swpout_fallback:2154
> > After:  swpout:65698  swpout_fallback:324
> >
> > 512kB swap failure rate:
> > Before: swpout:11971  swpout_fallback:2218
> > After:  swpout:14606  swpout_fallback:4
> >
> > 2M swap failure rate:
> > Before: swpout:12     swpout_fallback:1578
> > After:  swpout:1253   swpout_fallback:15
> >
> > The success rate of large allocations is much higher.
> >
> > Link: https://lore.kernel.org/linux-mm/87v8242vng.fsf@yhuang6-desk2.ccr=
.corp.intel.com/ [1]
> > Signed-off-by: Kairui Song <kasong@tencent.com>
>
> Nice! I agree with Chris' analysis too. It's less of a problem for
> vswap (because there's no physical/SSD implication over there), but
> this patch makes sense in the context of swapfile allocator.
>
> FWIW:
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>

Thanks!

>
> > ---
> >  mm/swapfile.c | 38 ++++++++++++++++++++++++++++----------
> >  1 file changed, 28 insertions(+), 10 deletions(-)
> >
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 5fdb3cb2b8b7..4a0cf4fb348d 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -908,18 +908,20 @@ static unsigned long cluster_alloc_swap_entry(str=
uct swap_info_struct *si, int o
> >         }
> >
> >  new_cluster:
> > -       ci =3D isolate_lock_cluster(si, &si->free_clusters);
> > -       if (ci) {
> > -               found =3D alloc_swap_scan_cluster(si, ci, cluster_offse=
t(si, ci),
> > -                                               order, usage);
> > -               if (found)
> > -                       goto done;
> > +       /*
> > +        * If the device need discard, prefer new cluster over nonfull
> > +        * to spread out the writes.
> > +        */
> > +       if (si->flags & SWP_PAGE_DISCARD) {
> > +               ci =3D isolate_lock_cluster(si, &si->free_clusters);
> > +               if (ci) {
> > +                       found =3D alloc_swap_scan_cluster(si, ci, clust=
er_offset(si, ci),
> > +                                                       order, usage);
> > +                       if (found)
> > +                               goto done;
> > +               }
> >         }
> >
> > -       /* Try reclaim from full clusters if free clusters list is drai=
ned */
> > -       if (vm_swap_full())
> > -               swap_reclaim_full_clusters(si, false);
> > -
> >         if (order < PMD_ORDER) {
> >                 while ((ci =3D isolate_lock_cluster(si, &si->nonfull_cl=
usters[order]))) {
> >                         found =3D alloc_swap_scan_cluster(si, ci, clust=
er_offset(si, ci),
> > @@ -927,7 +929,23 @@ static unsigned long cluster_alloc_swap_entry(stru=
ct swap_info_struct *si, int o
> >                         if (found)
> >                                 goto done;
> >                 }
> > +       }
> >
> > +       if (!(si->flags & SWP_PAGE_DISCARD)) {
> > +               ci =3D isolate_lock_cluster(si, &si->free_clusters);
> > +               if (ci) {
> > +                       found =3D alloc_swap_scan_cluster(si, ci, clust=
er_offset(si, ci),
> > +                                                       order, usage);
> > +                       if (found)
> > +                               goto done;
> > +               }
> > +       }
>
> Seems like this pattern is repeated a couple of places -
> isolate_lock_cluster from one of the lists, and if successful, then
> try to allocate (alloc_swap_scan_cluster) from it.

Indeed, I've been thinking about it but there are some other issues
that need to be cleaned up before this one.


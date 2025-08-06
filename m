Return-Path: <linux-kernel+bounces-757197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CED53B1BEF9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5F818A5901
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3140D190676;
	Wed,  6 Aug 2025 03:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nbcj5hYG"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9018B79F2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 03:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754449405; cv=none; b=PFCzDY9CTx4lIrxG1dhyzYFuqsG4GtO4NgAIwmF5Dd9JZ4BoVKi9qsD9SLaaozXX4vGmWA4omhlQssDX6ff2/PvSTMERNLwBUBRO+QlJ638zPUWKFHIR2WarSE0c7/7+xMQkcoWYpj3WqVcTGzdmXgpMiY1wdOm3JR6nYRKwpRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754449405; c=relaxed/simple;
	bh=Dq66dCrQaeiUwhJEVtert45l1M6tRZEdviW/1TyFsUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLN3/vGe310IxN2bJVITcHhVMVy4WBCFd8XjQjrURscyUSAQyM9rd6nk+kdNe0/frjpfKNfzP2s8njhQqOK8LGBeWQDdv2P/obng+TDF6Rbtf7WC8f1ttWRbZPdTvMJksUUAHKjXG5mYOWHtdVNPukA45e4r4Ayr1VQz5BYgK6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nbcj5hYG; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-332612dc0d1so25685911fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 20:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754449402; x=1755054202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9gZYHBoazKH3rjXuPK5OlYak4Pcs3GQzqOG3Z86lDc=;
        b=Nbcj5hYG8ExNGaDF8ElToRxivVhKYVY88IdcgOwi26m/hPDPOyjxs8Z1KNhvw3k9ik
         aajwEG4NbHEAbxl4Lu5YXAdJjJYHL1voVVLAhXvNoRHWw2TSIsJ8dTWo4jPKjN1FukBN
         vDhVVsUGaGmCKDX0Fk/6Nch+zKbgUpgO1NuuSaY+w0KX8yXwayaVzHOzoX4omS9BVIGj
         z363kKqbqTd5GegY4iglq3wqErbJz8Z7Q3tbcZPVAGBUFEqG6KySRU01ev5pd4ZYorrM
         MM5TFkr5flNrwPOPfcdZH9qmU33u4OHgu/uxiWSHq2JHzRJ9f1f5mTk6HlwpDVLnlOFH
         bKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754449402; x=1755054202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9gZYHBoazKH3rjXuPK5OlYak4Pcs3GQzqOG3Z86lDc=;
        b=UFPo50i5cz+sKEWhcVan1bJ3heDFjVZqU+TyKSOVsrBJPV2hWAEffbgrDHbBR6gg/f
         Gi4vbr6mQT1KUiO83wpDfbFF2wwir8ZSpFfqlibEJEd3zMGnNN1NUKuKJxXinYqP5Ueh
         wm6Z6LO7yRRv+YUYKH5gSWOVIk08rDbAZAev8PR5zIHQCAHqBvFx5TaPr9pJ9yr1tTNH
         Hobm/RA+m6y1IuQsgE/hc0feW/D2BVAdTSVcn8sVJ7apsdnS+oikXBwzLw5OskYvhyCa
         JVBQQmXsToP0vdj8z6QuwePr167u6YwktkR9v5OyInt4nSnf+fD9FgERbr04XQQxUyOY
         QmSg==
X-Forwarded-Encrypted: i=1; AJvYcCWer62F+FIspn02XXJRw+4HTNgSpe3ev7WoqphRPAazLr5p3ZMalRuezYYU2aSZCSLDDty80dZQ/9NBZEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAp/wTRwHfHuHgjBmZDypKpm7IR4gei4HuoKQqvMnElwIiGXPC
	1UyL91jBhA9L/19b6+T1grd+3dfP3yS/sB1hyLA61dvURSusml6XP8pfnGVx09adhl6hichykGf
	5bCs/FU80EUmTitDZLK5oV9PyxIW5Vq1diQ0mJPI=
X-Gm-Gg: ASbGncusbFhsKzcohHpdzREoASk6lsXDrkbLvDGCmMVlgj9Z7NQxEsXKPU4JRVcxRAG
	TWqte4A47jGXCTAGP8VqDAnPrpkfyJI5Mg8eQdNMnQb7LJVkb1lDZXon4CJkZ3MQQhIxrakRRVc
	fEUb2LpflKxB5C4XPoKZQCFEoBmfttEH7hIDcFfzPu+hY/diSDbZuRJWgj2IqRUB5Qhd7UinNHv
	7EII9A=
X-Google-Smtp-Source: AGHT+IEi9Cw1yLSBYhDfGj8ifvZFfup2ldm7Hs9ePdk1zXy82LC6OWq/dk5WMP5T2rN7DVpi7cZ7ZY8bVanuzuqVW4c=
X-Received: by 2002:a05:651c:31c2:b0:332:4558:b30b with SMTP id
 38308e7fff4ca-333812b070amr2956421fa.18.1754449401342; Tue, 05 Aug 2025
 20:03:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804172439.2331-1-ryncsn@gmail.com> <20250804172439.2331-2-ryncsn@gmail.com>
 <CAF8kJuPY20cybaFqBXk34sEgZ8ydNOk7AoOtmNGLtdO3huzE-Q@mail.gmail.com>
In-Reply-To: <CAF8kJuPY20cybaFqBXk34sEgZ8ydNOk7AoOtmNGLtdO3huzE-Q@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 6 Aug 2025 11:02:43 +0800
X-Gm-Features: Ac12FXw-4ibyz3mto4mqVWye7WxZvW2ejJd4ZWbmNS5Fo5San-d3zHvFn9O3qQM
Message-ID: <CAMgjq7Bu3PmDzrEptRUifzZqkQX1cZQ-2DQjjmvQiknJvtGGPQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm, swap: don't scan every fragment cluster
To: Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chris Li <chrisl@kernel.org> =E4=BA=8E 2025=E5=B9=B48=E6=9C=886=E6=97=A5=E5=
=91=A8=E4=B8=89 07:30=E5=86=99=E9=81=93=EF=BC=9A
>
> Looks good to me with minor nit picks on commit messages and comments.
>
> Let me know if you will refresh a version or not.

I'll send a V2 to improve the series. I think no code change is
needed, the change log can be improved.

> Nit: I suggest the patch title use positive terms, something along the li=
nes:
> "Only scan one cluster in fragment list"
> "Don't scan" seems to describe what the patch does not do rather than
> what the patch does.

Good idea.

>
> On Mon, Aug 4, 2025 at 10:24=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Fragment clusters were mostly failing high order allocation already.
> > The reason we scan it now is that a swap slot may get freed without
> > releasing the swap cache, so a swap map entry will end up in HAS_CACHE
> > only status, and the cluster won't be moved back to non-full or free
> > cluster list.
> >
> > Usually this only happens for !SWP_SYNCHRONOUS_IO devices when the swap
>
> Nit: Please clarify what "this" here means. I assume scanning fragment li=
sts.
> From the context it can almost mean "map entry will end up in HAS_CACHE".

Yes.

>
>
> > device usage is low (!vm_swap_full()) since swap will try to lazy free
> > the swap cache.
> >
> > It's unlikely to cause any real issue. Fragmentation is only an issue
> > when the device is getting full, and by  that time, swap will already
> > be releasing the swap cache aggressively. And swap cache reclaim happen=
s
> > when the allocator scans a cluster too. Scanning one fragment cluster
> > should be good enough to reclaim these pinned slots.
> >
> > And besides, only high order allocation requires iterating over a
> > cluster list, order 0 allocation will succeed on the first attempt.
> > And high order allocation failure isn't a serious problem.
> >
> > So the iteration of fragment clusters is trivial, but it will slow down
> > mTHP allocation by a lot when the fragment cluster list is long.
> > So it's better to drop this fragment cluster iteration design. Only
> > scanning one fragment cluster is good enough in case any cluster is
> > stuck in the fragment list; this ensures order 0 allocation never
> > falls, and large allocations still have an acceptable success rate.
> >
> > Test on a 48c96t system, build linux kernel using 10G ZRAM, make -j48,
> > defconfig with 768M cgroup memory limit, on top of tmpfs, 4K folio
> > only:
> >
> > Before: sys time: 4407.28s
> > After:  sys time: 4425.22s
> >
> > Change to make -j96, 2G memory limit, 64kB mTHP enabled, and 10G ZRAM:
> >
> > Before: sys time: 10230.22s  64kB/swpout: 1793044  64kB/swpout_fallback=
: 17653
> > After:  sys time: 5527.90s   64kB/swpout: 1789358  64kB/swpout_fallback=
: 17813
> >
> > Change to 8G ZRAM:
> >
> > Before: sys time: 21929.17s  64kB/swpout: 1634681  64kB/swpout_fallback=
: 173056
> > After:  sys time: 6121.01s   64kB/swpout: 1638155  64kB/swpout_fallback=
: 189562
> >
> > Change to use 10G brd device with SWP_SYNCHRONOUS_IO flag removed:
> >
> > Before: sys time: 7368.41s  64kB/swpout:1787599  swpout_fallback: 0
> > After:  sys time: 7338.27s  64kB/swpout:1783106  swpout_fallback: 0
> >
> > Change to use 8G brd device with SWP_SYNCHRONOUS_IO flag removed:
> >
> > Before: sys time: 28139.60s 64kB/swpout:1645421  swpout_fallback: 14840=
8
> > After:  sys time: 8941.90s  64kB/swpout:1592973  swpout_fallback: 26501=
0
> >
> > The performance is a lot better and large order allocation failure rate
> > is only very slightly higher or unchanged.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  include/linux/swap.h |  1 -
> >  mm/swapfile.c        | 30 ++++++++----------------------
> >  2 files changed, 8 insertions(+), 23 deletions(-)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 2fe6ed2cc3fd..a060d102e0d1 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -310,7 +310,6 @@ struct swap_info_struct {
> >                                         /* list of cluster that contain=
s at least one free slot */
> >         struct list_head frag_clusters[SWAP_NR_ORDERS];
> >                                         /* list of cluster that are fra=
gmented or contented */
> > -       atomic_long_t frag_cluster_nr[SWAP_NR_ORDERS];
>
> Nit: please have some comment in the commit log that why remove the
> frag_cluster_nr counter.
> I feel this change can be split out from the main change of this
> patch. The main performance improvement is from only scanning one
> fragment cluster rather than the full list right? Delete the counter
> helps, but in a much smaller number.

RIght, I can split this into two patches, removing the counter has
basically no measurable performance effect, it's just no longer used
after this change.

>
> Chris
>


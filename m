Return-Path: <linux-kernel+bounces-756747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AB4B1B8C2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE223B3A54
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93C321A928;
	Tue,  5 Aug 2025 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TlyQHFbU"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50071F5838
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754412405; cv=none; b=LU8DsdAZi6sgcVAwP4b02g6aarIgJ7an08IsCcOZIctNYarxQp5Y7+1RMcF2EPyndTlx4usJvNdELr5N7T2O6I0W58SSnGRi3VWt7+j6FIFy/1ykE7D6QYP+CdKRRHPR9GHwrsilP8ENxwR7FbLpvIaasSMlgmMHUU/MYxtUWH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754412405; c=relaxed/simple;
	bh=l0RxCTsXFF8391IAhRwoPNmaelsxs5V8yAF1l14fxkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMVilseQuhEtK1ukIKY/Nc3DPRCnjqF+/9GEMfDBUv//ImnplMN2cKM+hvAKfGEQsz5rR1eRuE2tcZ2mGzdlkkvEHFLMjCuASdk3hDxOAOqlYQ5SAYl+zfLaaoEdpqyweL32oMx9Hh1FnzeGYSBsSHm9eRXYRuNeNeF26NRtJjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TlyQHFbU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24070ef9e2eso5485ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 09:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754412403; x=1755017203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0RxCTsXFF8391IAhRwoPNmaelsxs5V8yAF1l14fxkk=;
        b=TlyQHFbUTMwuB0xlLntH3nI7h0en1JC3JMDOJoUbWUO+rSYucWQvdJj7ZEh4FKBjEo
         rtEcoRwbXZiRL4zdo3PEyY/A3TOSf4OIUz89cnpT4pOAoM4kv6qBQyyZbzU6MBImwS7g
         9ToBvMdWIDAjAJV8OKi+C8XyaIdoDKCWLav1BoUwN6vEHe+ftkgF+tkbWWUYlX1rXk4R
         UjoR6S7najBUNFjxYRE/c9FQ8MhufMpcsy3C/6crktymNEVnj6HYmphYukuwSjuRc0bf
         adFH2LJELZu7uR3JggJZC7Ppcx8O7ouCN5IsTRppcHElAZZagVwyKcUzkNys9Dht36mQ
         JxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754412403; x=1755017203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0RxCTsXFF8391IAhRwoPNmaelsxs5V8yAF1l14fxkk=;
        b=xPjiJkPOma334wdtwdvcnH8CqzhBHIu1HGmSNqB89ufuyTua5rQxo2/4hTXtz5ReB9
         J4uEQWWY+9w93PeYrQLdwGIUS5qe+b/+HJnLs4U4zSQH//Hy3BRM/FzW91OzEqLDOlKx
         wApqe3QYThTiPNEcyszZml0ZYDNAlQ6NWQtBwsf+y+Cy0VqU+kQQKmj6ZpFm0Jk3cnmw
         u9Cb5D3m48BoXrmkeel4h5lOt8RxMmzVyYJx3lOzAUM68XdYqvq2xTvIlNbzHybG1AYl
         yEppL3oJXyJDjSTZWYXcvYy6ZPBtQ6lxOciQyiivK0PHYuUQEzCybXvGaj4vhkkViSLZ
         50Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWlB/5wil6eL4cltsrucug26awNG5gnb3ekI9f/JQfibscShDSpVEMP3QePG3PPq2n5OJegDCudM4FfZXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX5SOSOIsRsI26/ei/3U7mAYz1z+h8trxeck9nMsPrnoiwV7SU
	aanFfWmriL8MiQvkeMDAE9FTwRTq7k3w+Q7Nr5q5af45Zm3bm/9CbLsQsn7YIyXD73bWu/yBhfT
	v63xtr8DaUEQoH5ILfBJJi8TYWAYy5bREHr+DcggEJfQOJS4B1ILe+vxs/4g=
X-Gm-Gg: ASbGncsjP12B5ihqfc4fUi7DiXdw1bcQCupr6+xDQLnhbXH1H8yHc2jpQ+0uKAMiVlX
	jZ0louc0caBZkCyKh6aGfneLQCj1YCA2na2v56wLhDQPB/H8CeJ25OnrMNigZqMfk5vlyoEfeml
	KUDb4E09Yucz4EcAPsRtP+OcGuRfcQTWG4KofINdIgfgccPK25ak2lw73y5Bzx0iezYSyueK5f9
	H0xtE2FFJkJnJmkIUdUWcdhot1KQkracz/PWEDH
X-Google-Smtp-Source: AGHT+IFbtH6J0AjO4QU4T/tefsfeSE0rL1OzSJr1N/DUHjvBaYU77HeoyM1+WKB2X0d+93TslMU104SV+ZAQGFLorx8=
X-Received: by 2002:a17:902:ea02:b0:234:afcf:d9e8 with SMTP id
 d9443c01a7336-2428e9ca60bmr3484235ad.7.1754412402595; Tue, 05 Aug 2025
 09:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJDx_rgzkZognxWzOXJ-ZxdTtUaM3FT6bmpkwxMz03XiX3fKAQ@mail.gmail.com>
 <d395b14a-9a84-4f25-b4f0-45e8500fc5fe@redhat.com> <CAJDx_rgrp1TpOt-iDcsSGRTL=qZZsK_dpKL1bSkyunPGcGXt5g@mail.gmail.com>
 <4566222d-6b91-4789-bdd6-61e3769f5dbf@suse.cz>
In-Reply-To: <4566222d-6b91-4789-bdd6-61e3769f5dbf@suse.cz>
From: Juan Yescas <jyescas@google.com>
Date: Tue, 5 Aug 2025 09:46:30 -0700
X-Gm-Features: Ac12FXy4BT6ZbkseE6fl0wteJa2HqcPFNTVMsUS4ZZOo4qkH5jwtMaLF9Pp-ohE
Message-ID: <CAJDx_rjxGff38aS_MBwgh6LpDqp6G4zjUvg6tr73KU0HYfGvXA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/page_alloc: Add PCP list for THP CMA
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>, akash.tyagi@mediatek.com, 
	Andrew Morton <akpm@linux-foundation.org>, angelogioacchino.delregno@collabora.com, 
	hannes@cmpxchg.org, Brendan Jackman <jackmanb@google.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, 
	Linux Memory Management List <linux-mm@kvack.org>, matthias.bgg@gmail.com, Michal Hocko <mhocko@suse.com>, 
	Suren Baghdasaryan <surenb@google.com>, wsd_upstream@mediatek.com, Zi Yan <ziy@nvidia.com>, 
	Kalesh Singh <kaleshsingh@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Isaac Manjarres <isaacmanjarres@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 2:52=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 8/5/25 3:22 AM, Juan Yescas wrote:
> > On Mon, Aug 4, 2025 at 11:50=E2=80=AFAM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 04.08.25 20:20, Juan Yescas wrote:
> >>> Hi David/Zi,
> >>>
> >>> Is there any reason why the MIGRATE_CMA pages are not in the PCP list=
s?
> >>>
> >>> There are many devices that need fast allocation of MIGRATE_CMA pages=
,
> >>> and they have to get them from the buddy allocator, which is a bit
> >>> slower in comparison to the PCP lists.
> >>>
> >>> We also have cases where the MIGRATE_CMA memory requirements are big.
> >>> For example, GPUs need MIGRATE_CMA memory in the ranges of 30MiB to 5=
00MiBs.
> >>> These cases would benefit if we have THPs for CMAs.
> >>>
> >>> Could we add the support for MIGRATE_CMA pages on the PCP and THP lis=
ts?
> >>
> >> Remember how CMA memory is used:
> >>
> >> The owner allocates it through cma_alloc() and friends, where the CMA
> >> allocator will try allocating *specific physical memory regions* using
> >> alloc_contig_range(). It doesn't just go ahead and pick a random CMA
> >> page from the buddy (or PCP) lists. Doesn't work (just imagine having
> >> different CMA areas etc).
> >>
> >> Anybody else is free to use CMA pages for MOVABLE allocations. So we
> >> treat them as being MOVABLE on the PCP.
> >>
> >> Having a separate CMA PCP list doesn't solve or speedup anything, real=
ly.
> >>
> >
> > Thanks David for the quick overview.
> >
> >> I still have no clue what this patch here tried to solve: it doesn't
> >> make any sense.
> >>
> >
> > The story started with this out of tree patch that is part of Android.
> >
> > https://lore.kernel.org/lkml/cover.1604282969.git.cgoldswo@codeaurora.o=
rg/T/#u
> >
> > This patch introduced the __GFP_CMA flag that allocates pages from
> > MIGRATE_MOVABLE
> > or MIGRATE_CMA.
>
> What kinds of allocations would then use __GFP_CMA? (let me try guess
> one - zswap backend?)
>
> > What it happens then, it is that the MIGRATE_MOVABLE
> > pages in the
> > PCP lists were consumed pretty fast. To solve this issue, the PCP
> > MIGRATE_CMA list was added.
> > This list is initialized by rmqueue_bulk() when it is empty. That's
> > how we end up with the PCP MIGRATE_CMA list
> > in Android. In addition to this, the THP list for MIGRATE_MOVABLE was
> > allowed to contain
> > MIGRATE_CMA pages. This is causing THP MIGRATE_CMA pages to be used
> > for THP MIGRATE_MOVABLE
> > making later allocations from THP MIGRATE_CMA to fail.
>
> If you don't want THP's to use the large (THP-sized) MIGRATE_CMA pages,
> what kind of such large allocations would be ok to use MIGRATE_CMA then?

The large THP MIGRATE_CMA allocs are used by GPUs or devices that require
large chunks of memory (have many cameras for example).


> > These workarounds are mainly because we need to solve this issue upstre=
am:
> >
> > - When devices reserve big blocks of MIGRATE_CMA pages, the
> > underutilized MIGRATE_CMA
> > can fall back to MIGRATE_MOVABLE and these pages can be pinned, so if
> > we require MIGRATE_CMA
> > pages, the allocations might fail.
> >
> > I remember that you presented the problem in LPC. Were you able to
> > make some progress on that?
> >
> > Thanks
> > Juan
> >
> >
> >
> >
> >
> >> --
> >> Cheers,
> >>
> >> David / dhildenb
> >>
>


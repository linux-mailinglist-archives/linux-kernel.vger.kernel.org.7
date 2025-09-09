Return-Path: <linux-kernel+bounces-808946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9E6B506C1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5244C545C6B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3028302CD0;
	Tue,  9 Sep 2025 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aYYbb+Fv"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851C31D799D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757448721; cv=none; b=CxXQeOcfotkuuTjKILLCsVopQuZPiw8yMWjlYAN19qJ1VDYO4X6cnEhBKCvHkjYImq+qf9DPjcaghvKSM2H/EsLwxRlGeimpJsxkMrr5aWBdONQRNQRChMHYSYEVH/JqbbsNvHnJ9RbcwukqCJU/yEDEs3voBzTVnZckcPrBbfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757448721; c=relaxed/simple;
	bh=RMqutGN+yLrgM+NB4+zfhtscJz9Ec3G94PrW8rPDTWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktlVe/93Nh22skhpZHaGjXKUoJgP874R1e45C4UNA8YsYgIZIP+YYk39jsdJ6twqHmrQbAZRsv9rWrj/d3QAYsScA/Rr6wTC1fpy1UDmPmDyx/7j6+sf+R9LxVMzZPDXqPKGfE5Xjkuvr3292dkE0IsunNLkvcT7kF5sebbxBnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aYYbb+Fv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24cca557085so9655ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 13:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757448718; x=1758053518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMqutGN+yLrgM+NB4+zfhtscJz9Ec3G94PrW8rPDTWY=;
        b=aYYbb+FvEOneOIa8M+PLtxCdFGt58Sb6FXZlF7Sa9nMm9GBKfdEHju27AGXRtbVL8k
         xF9Y1vkKwYsrcrfDlCsjtGAIIDlM1ZbMz/k9W4Y+0gdvV8Tbhewps71zVPRf2xptl5DP
         bb6oDzuZXfu1XSnc8wO2mm8uSkNVBM5zmjPP4yqIs9XVvYCKBaoy95auhBBQ1xCjFmYS
         DyQjvCObd33g/cjSiOsjLL74s7ancgezz5pbcRw6F/UWllZ17RWZre5gm+pM7kVqHs5f
         tfmZ9L0MTm0h3Sk67C49OItD4XxIXthaBGimzw0Dpv6UU+o9i4ceBScPk5dTl9ZpCEPe
         E6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757448718; x=1758053518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMqutGN+yLrgM+NB4+zfhtscJz9Ec3G94PrW8rPDTWY=;
        b=jGZ1x1Stzs9b7EavODdv/BH7w20Bn/2fWQ5DqaxTQ75J0voiWeGN/q0hkEl5imcGW2
         WWgY+TJyCCm8D5cDmicrovN4BIvJx2sgzM5zWbzb+KBVnAaALJJNU64f1aTy4NbcZF9v
         oYLx+VcSis9bkEUplLo7n8XJ2R9eOSfrMO+E+AjcBbFZSTJUj1lf1rHW04b8oWwpUT+3
         0wcJ8Rj3OLxXYsHz6gC406wemZOyiZsigIG0lwidLdu1Tb4SxBuvi0ptxVKpvsOJhxH3
         R/EmXv8RuKWK40UrEWR8e4t7sVEgn5mdMTNOG09FOXMHO0NqjTWub94bpxZwp4ADJP07
         hSjA==
X-Forwarded-Encrypted: i=1; AJvYcCXZUnfWhzEvfrLHDuT9OMLibiFMX4T7ZXzG84eU5j/L6nAvemwo0vK+Y3ESGG8yXJU/z4VwWQTb/jtyfg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu8HV6DuELBvqdZDodsGUTmMJAyxfF6SkbFXF95ypegg2aoYHa
	Rm3EPKFxNQazeP2mLKgeIKDEAaoUZRHcYYl7KuUK5APEyAkb6vfvOOXnOx9/qw+ARS/ZE1luwg/
	VGdHiL3VsNVcuOhEruj5RlIe9rYErpG4e+eBimviJ
X-Gm-Gg: ASbGncsrrXaELfp9MFOgrcmTaOeH0i5OV0sZQdT+gZHcGow2v91TZ4RhIwba+0jK5+x
	c6esPVEF15tzE34Tokun6IVAdgWyBdsIh13GaEcW4LcxLURTaQvQ9YtMQHQdwlxFRbHXtTKORaQ
	Yt7vk8nrQRkG/YolvSI57IWzQQESR+yo90S5I1W5tOXLqW6lXYTOA2Hi269N2yUcbsRvgygtADz
	VHYGHQbiV0fO8WQUgrUXX5W+qlTd0vuoli0pExUYZw=
X-Google-Smtp-Source: AGHT+IFX3Yblf4ZODycC555w3xs5DUtNy1StojhqIRO/qAVf35qb6Qt4MYDTGQXUSZ6pqO5kIY7S+3D62K27CD/FW6s=
X-Received: by 2002:a17:902:e5d0:b0:24c:f4b1:baaf with SMTP id
 d9443c01a7336-25a7d989bb5mr37875ad.1.1757448717349; Tue, 09 Sep 2025 13:11:57
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJDx_rgzkZognxWzOXJ-ZxdTtUaM3FT6bmpkwxMz03XiX3fKAQ@mail.gmail.com>
 <d395b14a-9a84-4f25-b4f0-45e8500fc5fe@redhat.com> <CAJDx_rgrp1TpOt-iDcsSGRTL=qZZsK_dpKL1bSkyunPGcGXt5g@mail.gmail.com>
 <486c5773-c7fa-4e19-b429-90823ed2f7d5@redhat.com> <CAJDx_ri==3SxFcuKXHpNjrtxbp0hLyhM+zXeJ-LQX38rfbUChw@mail.gmail.com>
 <6dee6cd9-c67f-480f-b728-21c3a7b72004@redhat.com>
In-Reply-To: <6dee6cd9-c67f-480f-b728-21c3a7b72004@redhat.com>
From: Juan Yescas <jyescas@google.com>
Date: Tue, 9 Sep 2025 13:11:44 -0700
X-Gm-Features: Ac12FXy9H8LSTetHGcFYnz6pqWAly0dnCfLL-mWF9ljJktwSF-hLAn2umBneJkE
Message-ID: <CAJDx_rh_bTC5EY=qMSda5GuNLzZMZg8nM8_hfUea3Y8oGJMfNw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/page_alloc: Add PCP list for THP CMA
To: David Hildenbrand <david@redhat.com>
Cc: akash.tyagi@mediatek.com, Andrew Morton <akpm@linux-foundation.org>, 
	angelogioacchino.delregno@collabora.com, hannes@cmpxchg.org, 
	Brendan Jackman <jackmanb@google.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	Linux Memory Management List <linux-mm@kvack.org>, matthias.bgg@gmail.com, Michal Hocko <mhocko@suse.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, wsd_upstream@mediatek.com, 
	Zi Yan <ziy@nvidia.com>, Kalesh Singh <kaleshsingh@google.com>, 
	"T.J. Mercier" <tjmercier@google.com>, Isaac Manjarres <isaacmanjarres@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 2:08=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 05.08.25 18:57, Juan Yescas wrote:
> > On Tue, Aug 5, 2025 at 2:58=E2=80=AFAM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 05.08.25 03:22, Juan Yescas wrote:
> >>> On Mon, Aug 4, 2025 at 11:50=E2=80=AFAM David Hildenbrand <david@redh=
at.com> wrote:
> >>>>
> >>>> On 04.08.25 20:20, Juan Yescas wrote:
> >>>>> Hi David/Zi,
> >>>>>
> >>>>> Is there any reason why the MIGRATE_CMA pages are not in the PCP li=
sts?
> >>>>>
> >>>>> There are many devices that need fast allocation of MIGRATE_CMA pag=
es,
> >>>>> and they have to get them from the buddy allocator, which is a bit
> >>>>> slower in comparison to the PCP lists.
> >>>>>
> >>>>> We also have cases where the MIGRATE_CMA memory requirements are bi=
g.
> >>>>> For example, GPUs need MIGRATE_CMA memory in the ranges of 30MiB to=
 500MiBs.
> >>>>> These cases would benefit if we have THPs for CMAs.
> >>>>>
> >>>>> Could we add the support for MIGRATE_CMA pages on the PCP and THP l=
ists?
> >>>>
> >>>> Remember how CMA memory is used:
> >>>>
> >>>> The owner allocates it through cma_alloc() and friends, where the CM=
A
> >>>> allocator will try allocating *specific physical memory regions* usi=
ng
> >>>> alloc_contig_range(). It doesn't just go ahead and pick a random CMA
> >>>> page from the buddy (or PCP) lists. Doesn't work (just imagine havin=
g
> >>>> different CMA areas etc).
> >>>>
> >>>> Anybody else is free to use CMA pages for MOVABLE allocations. So we
> >>>> treat them as being MOVABLE on the PCP.
> >>>>
> >>>> Having a separate CMA PCP list doesn't solve or speedup anything, re=
ally.
> >>>>
> >>>
> >>> Thanks David for the quick overview.
> >>>
> >>>> I still have no clue what this patch here tried to solve: it doesn't
> >>>> make any sense.
> >>>>
> >>>
> >>> The story started with this out of tree patch that is part of Android=
.
> >>>
> >>> https://lore.kernel.org/lkml/cover.1604282969.git.cgoldswo@codeaurora=
.org/T/#u
> >>>
> >>> This patch introduced the __GFP_CMA flag that allocates pages from
> >>> MIGRATE_MOVABLE
> >>> or MIGRATE_CMA. What it happens then, it is that the MIGRATE_MOVABLE
> >>> pages in the
> >>> PCP lists were consumed pretty fast. To solve this issue, the PCP
> >>> MIGRATE_CMA list was added.
> >>> This list is initialized by rmqueue_bulk() when it is empty. That's
> >>> how we end up with the PCP MIGRATE_CMA list
> >>> in Android. In addition to this, the THP list for MIGRATE_MOVABLE was
> >>> allowed to contain
> >>> MIGRATE_CMA pages. This is causing THP MIGRATE_CMA pages to be used
> >>> for THP MIGRATE_MOVABLE
> >>> making later allocations from THP MIGRATE_CMA to fail.
> >>
> >> Okay, so this patch here really is not suitable for the upstream kerne=
l
> >> as is. It's purely targeted at the OOT Android patch.
> >>
> > Right, it is a temporary solution for the pinned MIGRATE_CMA pages.
> >
> >>>
> >>> These workarounds are mainly because we need to solve this issue upst=
ream:
> >>>
> >>> - When devices reserve big blocks of MIGRATE_CMA pages, the
> >>> underutilized MIGRATE_CMA
> >>> can fall back to MIGRATE_MOVABLE and these pages can be pinned, so if
> >>> we require MIGRATE_CMA
> >>> pages, the allocations might fail.
> >>>
> >>> I remember that you presented the problem in LPC. Were you able to
> >>> make some progress on that?
> >>
> >> There is the problem of CMA pages getting allocated by someone for a
> >> MOVABLE allocation, to then short-term pin it for DMA. Long-term
> >> pinnings are disallowed (we just recently fixed a bug where we
> >> accidentally allowed it).
> >>
> > Nice, it is great the issue got caught and fixed upstream :)
> >
> >> One concern is that a steady stream of short-term pinnings can turn su=
ch
> >> pages unmovable. We discussed ideas on how to handle that, but there i=
s
> >> no solution upstream yet.
> >
> > Are there any plans to continue the discussion? Is it in the priority
> > list?
>
> Ohh, it's somewheeeeeere on the todo list :)
>
> Do you (or one of your colleagues) have capacity to work on that? One
> idea was to flag folios as "pending on migration" and disallow any
> further short-term pins until migration is done. IIRC, there were other
> ideas (e.g., isolated pageblock).
>
> > Maybe
> > a topic we can discuss in LPC Japan?
>
> Sounds good, feel free to propose this as a topic. I wills end out the
> announcement of the MM MC probably next week.
>

The topic has been proposed in the Kernel Memory Management track.

https://lpc.events/event/19/abstracts/2397/

Thanks
Juan

>
> --
> Cheers,
>
> David / dhildenb
>


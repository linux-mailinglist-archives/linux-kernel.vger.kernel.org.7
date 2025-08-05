Return-Path: <linux-kernel+bounces-756757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B75B1B8DE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B53411666D9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A697A291C14;
	Tue,  5 Aug 2025 16:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hdDlUiko"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943B02566E9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754413075; cv=none; b=nZ4+hCZjvpudWu0GCoPwsqflPJXz+uyEaOEKu7MYCC3z8PgXYNJxBRM3GZci7IDmuN0BcoWK+ZRebhBz/Hpcvzd3zOgu8640aqOCmsD9Hk128EEFSy4BOzpqUgusW5wmrQPrWafU83gjfxC/yFZDeEKN5qmQHmjjdm189+OMdjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754413075; c=relaxed/simple;
	bh=GEnVU5KAskdWYUBQ/kSGgyrV9wf/VcctSOFlUiJlPrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjcbAVQtURmEoGbEcWMb5wq9yF8pPv18YXYOzEMJEimLNacuZYGF/BysnEDuB3EqCIuQX6OJyz5xVQIqJP8wjy0PAN7abXwJdVZSzTUX5XhfVp6331UZF4ZL1hqVsEubwokMP3srK4LAwHSvESvySs6qiAU/sqE9HQ3y0WevHxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hdDlUiko; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-240718d5920so6805ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 09:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754413073; x=1755017873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEnVU5KAskdWYUBQ/kSGgyrV9wf/VcctSOFlUiJlPrU=;
        b=hdDlUikotQVkOqJKzXFQ5rlM+8K61Hk9GPHX3hZ43GGkzrlUhdgfgzd3jCceAR4oNT
         Xvg22qvCZfvx2jDq/C8GnbgZRky/RUJ5YBqs6aIa6/0I1fVjqdO3K9byMLdM6OuYNFYf
         MLSE8aOFkNlAR+JQ7Dx1JjM1RLKFmDf1+Vo3m4pLxm/SRbKApd6RSQOH3zy/jt1M7usE
         pYvpKvr0EJUTzxNQHYDZl4ZoERpzYIlbQRpGGhK5JcUsbHeKCBbxwPfQufT6ZcURUxke
         EsZFK1K4fOA8kZB408KIboEtl3yPv0SwDdkOxxKGnfMCbCxc2MW4jv3Qm/WTU2+OXy1e
         j8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754413073; x=1755017873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEnVU5KAskdWYUBQ/kSGgyrV9wf/VcctSOFlUiJlPrU=;
        b=g9UaIzQQKA+pWuP8OqFNngot/odDztrrqafv/AuN5+QByUJwOzFH5uiF/urYyHGL8A
         1z8INM0AGnrqHos1UwQZrFqKMmq2yCS2kzAGKSjzELaHjJVmgNHxb6peW7qW1C2KA8rR
         zIk30polRFniXnxR3p40lVbzWaYun37h6oi2BUpWYaWdYZVMT/1PgVVpYASMey6ltWh0
         BiZu4zqIfSXrjmHJmFjAXVrVgccrB1JQ20rm+mJ39kXzhUxZwWQc3fbvi9NfdOH42j7I
         nvtjSnU+48qso6BX/vYuu/FgzacjSgeuOfeMf37fGQ+fs33M6ztZ+Uo704REYLcV0Jas
         uzzg==
X-Forwarded-Encrypted: i=1; AJvYcCWsMDwNLhrjPx9vnndDPwhaZAcYEI+iBgq4pP3D10DS3gjRxRyPhd4FTjlvUTv8c3VM/AMdzlVrhWW6CYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOHnZSFD9KOE5WXW6WL9vQ2XsSRPrgXSj7W0hz2kVfNQRhqGVw
	XsTHS9fcRJy3AKHHprXRLcfAdqWwILC2/ckVSuUYhIb/YG8eLYJ7nCMAylTjojV0eTPVbv4Z98q
	k3nYnYQOIPptogyvLdW0ExyT9fctxFFBxPQHbcBBp
X-Gm-Gg: ASbGnct6Vd/NIwQdwZBDPT+uJk1vTkt8cbyTbetjtqINZeC4AnVanMKU8g4BlOFRuHy
	wR3H86uoC1BWr5VW2uKuGXWBwlY/m3tT1LoaiHkYWZ/Zms3ZJRmPFT+P1ct2MTF3fv1nHrsPmcl
	UPqTC1ViG240tf41U8Q5c3NCLDeZkUCSUorBsYstcdy12E6CGAv3FZJOcC1ib4kDzs+0cEsV1Kh
	VOAkm8PgdZOkaiwLAN/OYBzWFoS871vsyT2mg/y
X-Google-Smtp-Source: AGHT+IFHALxRLkmhDed/lnhoMX9pMKBECdTY93R6Sdw6v3eSIKnTQjB+1XTGHNMoRl1Mtb+hpgpseJBwvLL9afKRuuU=
X-Received: by 2002:a17:903:41c9:b0:240:a4b5:fe0d with SMTP id
 d9443c01a7336-2428e9d9866mr3490245ad.6.1754413072472; Tue, 05 Aug 2025
 09:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJDx_rgzkZognxWzOXJ-ZxdTtUaM3FT6bmpkwxMz03XiX3fKAQ@mail.gmail.com>
 <d395b14a-9a84-4f25-b4f0-45e8500fc5fe@redhat.com> <CAJDx_rgrp1TpOt-iDcsSGRTL=qZZsK_dpKL1bSkyunPGcGXt5g@mail.gmail.com>
 <486c5773-c7fa-4e19-b429-90823ed2f7d5@redhat.com>
In-Reply-To: <486c5773-c7fa-4e19-b429-90823ed2f7d5@redhat.com>
From: Juan Yescas <jyescas@google.com>
Date: Tue, 5 Aug 2025 09:57:39 -0700
X-Gm-Features: Ac12FXwewq6mHJ3iXKimK9YdL07pdhlid5gd2fFisX11Nn-jXdYL26T35WBbNug
Message-ID: <CAJDx_ri==3SxFcuKXHpNjrtxbp0hLyhM+zXeJ-LQX38rfbUChw@mail.gmail.com>
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

On Tue, Aug 5, 2025 at 2:58=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 05.08.25 03:22, Juan Yescas wrote:
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
> > or MIGRATE_CMA. What it happens then, it is that the MIGRATE_MOVABLE
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
> Okay, so this patch here really is not suitable for the upstream kernel
> as is. It's purely targeted at the OOT Android patch.
>
Right, it is a temporary solution for the pinned MIGRATE_CMA pages.

> >
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
>
> There is the problem of CMA pages getting allocated by someone for a
> MOVABLE allocation, to then short-term pin it for DMA. Long-term
> pinnings are disallowed (we just recently fixed a bug where we
> accidentally allowed it).
>
Nice, it is great the issue got caught and fixed upstream :)

> One concern is that a steady stream of short-term pinnings can turn such
> pages unmovable. We discussed ideas on how to handle that, but there is
> no solution upstream yet.

Are there any plans to continue the discussion? Is it in the priority
list? Maybe
a topic we can discuss in LPC Japan?

Thanks
Juan

>
> --
> Cheers,
>
> David / dhildenb
>


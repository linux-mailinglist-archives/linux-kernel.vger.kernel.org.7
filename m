Return-Path: <linux-kernel+bounces-756775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD507B1B909
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5DDF7A3320
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5600228136B;
	Tue,  5 Aug 2025 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x96FL6qx"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBC13FE5F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754413969; cv=none; b=JXNMt7MlYTVLEG0kWt195mrK0NJFcuQB5CaM3FP8k77oGYQvxxeBBz/CH/PINLw6cQ3hHgZ3hbXfs7/P4pgSiC1D0RPY5R2VCl8hG1ebotIqWUAsc6uIUqakcuETzfGPf5N+DLbdIScOi8/j0DN6feJRcpz8fA5kgkIKswk1f1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754413969; c=relaxed/simple;
	bh=ZbqWwHu/MN3vqLicN/YCVD8yPLwHYccLVOVJvse0Ql4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0h8paocg2sj7y5YETj/CY728LULdMRkDXR0FbORe2V27kLBSullW6C4gSmku+UgW04li+DEnaX4pWRBuIctyorw1/1Tgo9rKlHFaIv7UZfJ7Y4Slu7vk0GjiR2nDifRIf4I3+skK2Bc2rqyaUxyHoyc20a7BmKk4aND8vgtvlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x96FL6qx; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-240718d5920so11565ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 10:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754413967; x=1755018767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbqWwHu/MN3vqLicN/YCVD8yPLwHYccLVOVJvse0Ql4=;
        b=x96FL6qxTUpY3CNSoqWkRBrFfZB6dzUnq0Dls8EeG44bgTnRx5UQrtCeb2vg8qx0Me
         l9Kdcw5V76jfu4RmeSYLMPoeZNNmeosYrg5n4XLFwGZcxT2Ht4sI86eL4Ql1PCVZH4zx
         m/bJgRpjd+1bxERwVNTRb3chA3plZzinpfz4HP04t3w8TgLl0QEzefjPMRnQocrn3owx
         Uhpjomb4x/2ISeHboCG39pn3dW6aNraaHZJBX/q3YxeXIHPb5xMV1lxH5BUiak41HrXb
         iBDAW1JBsWGyaQC3kJKt01ygue114jMxgxQ9sx9mjhzaVf3pLzgQ5X5Pni7cOB/0sN3f
         OwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754413967; x=1755018767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbqWwHu/MN3vqLicN/YCVD8yPLwHYccLVOVJvse0Ql4=;
        b=A1Zs6QM1by3DF/Mi/eaPUPLf1j25ycNRRqGVhi30jA0q8OZa0v4Apcfd1+5kSkdcK+
         77DbpcRTxX2XCWpMqIEsVf7Dz+YutifYiwn6zR9nl2lto/XsTZXaFNGs+LZc8gHtC5h/
         0E8lrteyPrGQnhdYware5RR4H6QJ2SvHQc4Qox4uwRvz9NYK88blPHkfw5yabzq/QMSb
         10nvvncp8ZuPPYdpiLtAtXF9wZMUfw7lIXEyB0o+JFLc6acnJZgCxc2H7kKBKZ1LtC2e
         IjoeBYaMSH/BtGozFdFFsypZNEfasdW4xvpiw34dUarKeNVXITyHgkO2bwYBuPDPzdSA
         d+Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVex7CMEZkDjYlazDZhKU59hjHF4YRCj89BFU428pbMBvA1ygnwaPUT+mS0BI7dyB9kteFkIAX1YONUcPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlkdj181RN9Bev06j+aTk5ekdKmdeojGUhSqcMfc7tnvd/rna1
	009ny3AM7YPJa2dJ9wAJ0LcRJtDGPkN6K31BAvfVkFUDK3Q+Z2VWun9LaY3KN1bTnZ987LVq3Op
	eX3tvIKoziNbpCitw12NKihP8CMVzBw5Sm3llUuD1
X-Gm-Gg: ASbGncvVM1bWjl2hdnKKYqua7+VoQhpR/G2HyOM9FwVMhXqh8+iDB2JtrgPEfUPgV7R
	VKyC33YfIhHU0VAZYSSxsA3LhYWQ6TZ7W4MJj8UEg6Gb4vWtxHCKM4PFN+wP2CS5BvEesZldYu3
	FeJ138bMNTBoPkObMt3XAIZD4+jHG6mI250qzHZGMZgW8s/rdnh27t0TtORy6JtlmFs9I5qeMbp
	y/bbufubcwcRI13FmBrcuiPD04U0xdntkSh+RQ1
X-Google-Smtp-Source: AGHT+IFqLQ/GSA1XGpDzG6V9bPnbhZrv/PKGEBMGpW4YJVcfW/eWUxu6GeLWbRSsDGK01TuGGZ4dXbAcwThguioGfg0=
X-Received: by 2002:a17:902:fa08:b0:23f:df2c:9f0d with SMTP id
 d9443c01a7336-2428eaf87a8mr2475625ad.21.1754413967127; Tue, 05 Aug 2025
 10:12:47 -0700 (PDT)
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
Date: Tue, 5 Aug 2025 10:12:34 -0700
X-Gm-Features: Ac12FXx118qPMOpTYedhO-FDr1Ci1_iGrsVIoyffTe-jrpJNkQjp-q60_k-xYAk
Message-ID: <CAJDx_rjvYdjPYHbBDKvkaWV=-OPJG=oRdSAugaOyJAXaOVu-9w@mail.gmail.com>
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
> What kinds of allocations would then use __GFP_CMA?

The __GFP_CMA allocations are used to allocate userspace anonymous memory. =
This
was done initially in the alloc_zeroed_user_highpage_movable()
function, now it is done
in vma_alloc_zeroed_movable_folio().

> (let me try guess
> one - zswap backend?)

Yep, the __GFP_CMA pages are also used in zram block driver.

Thanks
Juan

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


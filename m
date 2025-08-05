Return-Path: <linux-kernel+bounces-755801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3A2B1ABF9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 03:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 652FB7ABCC1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 01:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53E1189905;
	Tue,  5 Aug 2025 01:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F1HRIu4s"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6C7F9C0
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 01:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754356956; cv=none; b=JbEF216uIozdwR7W2zO68aioX8ufIdbzJ1w9q4z6KkAcISJOCDTd1HdfH8yYksb97O5NVGDFxxnSIuf+QFgOGc+Tvqz9DOOWafDlC0jIGM0Wfx+/x84vXnXWn1yvWV7JNDMKFzxkmPdh9/3H9dxpQMISYkBwUch2EWqs3Ct9gz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754356956; c=relaxed/simple;
	bh=hAJ4RHocJtdCibwUW7vMzbUCC5UcCNRUv+aRR+ZSOM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doTGGw6NPGyIvxeqfB1BxVUoPjVn26qgWB8EigZ2x8MSXewwU8NH4SeW9fjdfbt61LKygJ1L6Xywx/gK713Vq8t98d7Vz1btt6N/MJu4XX9iEbiSWcrfYr+f/aFENq4gi3nU/bGAJIr2F8MTjEkM87C4ljDxuflOgGJQrGWrAzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F1HRIu4s; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24070dd87e4so76825ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 18:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754356954; x=1754961754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAJ4RHocJtdCibwUW7vMzbUCC5UcCNRUv+aRR+ZSOM4=;
        b=F1HRIu4ss9auFdJP9fL1jGueX/gy49Rg9XGy/ElVlAwD4TOsXXAtPOQD0wbWlzhcA2
         AMs0F1epEQDxVPFvKV9B2qCbgwVH1n5iFnuz2FnDkRXpyozgPrdB6Vv5hzSSoTL+w6OX
         nxKztsVkk0IIk9VDZSpkgVJKfeHUnn95pl3mF3lm53aB1pSgpyF59k9txMxEIUbtsbdz
         5cmtZ4fp2CsFVZt+JHZAgXvHM4taq72Gbe5MAaSBJ8Cly4jgo96kbQHX/LA0YQn6ClEf
         3jSD4OkEHnqVecEY0VJWKOhzHYTNr5Tvw4Pct46Jk4f0fPGH7aR8VBnHce0BOwrY3EZ9
         rRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754356954; x=1754961754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAJ4RHocJtdCibwUW7vMzbUCC5UcCNRUv+aRR+ZSOM4=;
        b=Ec6cCA4mAMZowzwwJ0iYtA3U/wZHEpUsBEiEeu/JndTHu7zmCqnpIizb3gShjTQLtG
         FBrZy3s9d4IB4i8a6sOQT5v2+ZWIjwIHkgKKVRgcMrkfpreW3d11yXtUf7TNTukRJU4c
         AU3Q+GO7Y1e//+kffYcVj6fHPKqnfgQ8bylqMA1g0L7W9DVrOcOIlYnWnGhvzz95GmQo
         eAI8/jSbO5diAg0qQqKUJvruwQQUMeJ90md7CfiDknn3/vubXK7NHIFiHd4R6R7UAWUj
         5EmP0uq2ZWSUA0+yELnbIqbSUcgnCaIl5fCZf5T5xyBmVwKGj7GEfc8BALo7/A8IlnfW
         xmEw==
X-Forwarded-Encrypted: i=1; AJvYcCX9NIMJzT0UDcCQGs4A4YCrgazGcvk0TUdJ3SVCI5ekOCjXtBuYaEbNVNWGMm6j5GuccJAzgqLbFMPf7eU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJoHlE/Wbd2WO6NnQo4ynfkRD6BjgwqTmgoNrSHw8pOhgTcq1c
	Z5+hgZ6oHgh9BgwczwKKeWiEGpkfRARIdsFcTl9lsYAu/GdD+aojrJruPGRSqjYYtNwl0MGzBfp
	PquW9XIqxQ7CgS7HR6/cVfufSkTWVW0ujaQ3YVAth
X-Gm-Gg: ASbGncuWnyRHd0Bjt3zwfu1tkzb6J/k2ZeLaQn3ZlclTYcgBWzWpRsamDGnlBAKtDgQ
	0DUte1BM/DS3D5jF0lAkz1O2AB4NBBDrwbik31uZSWq6/MBnY1VfTS42jouAOmy8LOvu4+679iM
	MGI/M9VLuHf8Fghor26UhDSc2xnjTF8lSx6XSZrM9pqG9AG1xsgEcchSADUqnpeSkRaHabyH5+s
	A4iOMvwy+fXCAiRKV7LbgpB+9V7/8gTpSCBd8JE
X-Google-Smtp-Source: AGHT+IHUNdtQwZDC9iJcA9U28t/KjMRhfY0lm9oTiYDKuEahIO/YtsfurNp2t+vB8T6wdGKdYuKho7IuX7hBOXsBD6M=
X-Received: by 2002:a17:902:d50b:b0:223:ff93:322f with SMTP id
 d9443c01a7336-2428e9b08e0mr357745ad.2.1754356953205; Mon, 04 Aug 2025
 18:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJDx_rgzkZognxWzOXJ-ZxdTtUaM3FT6bmpkwxMz03XiX3fKAQ@mail.gmail.com>
 <d395b14a-9a84-4f25-b4f0-45e8500fc5fe@redhat.com>
In-Reply-To: <d395b14a-9a84-4f25-b4f0-45e8500fc5fe@redhat.com>
From: Juan Yescas <jyescas@google.com>
Date: Mon, 4 Aug 2025 18:22:20 -0700
X-Gm-Features: Ac12FXz6D7iBBMFZt4PN7BOj1xXY8Im3BiqcIN-p29imUt-Q6tjBh8yWlEWjeZQ
Message-ID: <CAJDx_rgrp1TpOt-iDcsSGRTL=qZZsK_dpKL1bSkyunPGcGXt5g@mail.gmail.com>
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

On Mon, Aug 4, 2025 at 11:50=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 04.08.25 20:20, Juan Yescas wrote:
> > Hi David/Zi,
> >
> > Is there any reason why the MIGRATE_CMA pages are not in the PCP lists?
> >
> > There are many devices that need fast allocation of MIGRATE_CMA pages,
> > and they have to get them from the buddy allocator, which is a bit
> > slower in comparison to the PCP lists.
> >
> > We also have cases where the MIGRATE_CMA memory requirements are big.
> > For example, GPUs need MIGRATE_CMA memory in the ranges of 30MiB to 500=
MiBs.
> > These cases would benefit if we have THPs for CMAs.
> >
> > Could we add the support for MIGRATE_CMA pages on the PCP and THP lists=
?
>
> Remember how CMA memory is used:
>
> The owner allocates it through cma_alloc() and friends, where the CMA
> allocator will try allocating *specific physical memory regions* using
> alloc_contig_range(). It doesn't just go ahead and pick a random CMA
> page from the buddy (or PCP) lists. Doesn't work (just imagine having
> different CMA areas etc).
>
> Anybody else is free to use CMA pages for MOVABLE allocations. So we
> treat them as being MOVABLE on the PCP.
>
> Having a separate CMA PCP list doesn't solve or speedup anything, really.
>

Thanks David for the quick overview.

> I still have no clue what this patch here tried to solve: it doesn't
> make any sense.
>

The story started with this out of tree patch that is part of Android.

https://lore.kernel.org/lkml/cover.1604282969.git.cgoldswo@codeaurora.org/T=
/#u

This patch introduced the __GFP_CMA flag that allocates pages from
MIGRATE_MOVABLE
or MIGRATE_CMA. What it happens then, it is that the MIGRATE_MOVABLE
pages in the
PCP lists were consumed pretty fast. To solve this issue, the PCP
MIGRATE_CMA list was added.
This list is initialized by rmqueue_bulk() when it is empty. That's
how we end up with the PCP MIGRATE_CMA list
in Android. In addition to this, the THP list for MIGRATE_MOVABLE was
allowed to contain
MIGRATE_CMA pages. This is causing THP MIGRATE_CMA pages to be used
for THP MIGRATE_MOVABLE
making later allocations from THP MIGRATE_CMA to fail.

These workarounds are mainly because we need to solve this issue upstream:

- When devices reserve big blocks of MIGRATE_CMA pages, the
underutilized MIGRATE_CMA
can fall back to MIGRATE_MOVABLE and these pages can be pinned, so if
we require MIGRATE_CMA
pages, the allocations might fail.

I remember that you presented the problem in LPC. Were you able to
make some progress on that?

Thanks
Juan





> --
> Cheers,
>
> David / dhildenb
>


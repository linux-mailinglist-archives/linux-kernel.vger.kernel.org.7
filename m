Return-Path: <linux-kernel+bounces-796487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D6AB40144
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84794810B5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524262D9ED8;
	Tue,  2 Sep 2025 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBEujoMD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D9C2D131A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817441; cv=none; b=CTD6pVykHhE7tJuUN0WE0op0+k0e2oAxBSCSyZl29kRAN/HjkuaUjXKXmYyjehTf0AADWeHuHg/gx/qGga20tEE+CRAJ0bXFvDZjzI47QNsSdzvpW/MLMacippJbQHmcnIISWBmkoyPanRmgrmSsdfx2m9YnWgvn16Ea0WrL+Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817441; c=relaxed/simple;
	bh=qtptNUL8d4rhr8+RJ1neEPE2bGDD2Ksu68uXBEjf0Tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LgG3kRoLmeZnGxl+dXPrE2nrUSQYMWQUbb14XE1M9/hzEcqPS8xYnKiVDUdr6DnjHFs7RU4XoWyNhXwr4a3edZcStj4FcLFZw2WlZTOa24VLkdEtFe7/f7STNLfmkYBgVy4QhrI/1e11GjHjVcRhhead/R6ngzSGsUoks2ob7pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBEujoMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1A3C116D0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756817441;
	bh=qtptNUL8d4rhr8+RJ1neEPE2bGDD2Ksu68uXBEjf0Tg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RBEujoMDrKCKRavtx6n1+N2Md6Yyu0iAykIwwEjBUppN2pstys2YzkyPmf/cUfQAp
	 rq3A1DympA1Okn5Jzv/KQkmbbQo4LVkxSrLxEV/vWni/C/URusk2q4QAEwjOYQaRQ7
	 CNlNwT/oCHzLk4y7hi3rT8vWrj7JHl/JoM/Vbn+Z+xcKuuV704DjNgJWSPre2TjWXG
	 3hVUHgl7xH7IUi8zIM1yfPB6y8T5Y48FnLHHs5dQHXfbwOPGkc2lDyDZC2tBGQDgZ8
	 KtM+nf0bUjh6OgFBhDRkQ/cKgYbwesFtNFMZ9iuefL7zPYIMZjLB8FC84TSkQM6YWB
	 MLp+arQ32E7Tg==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d60504bf8so46404277b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:50:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWM9Y13VYRJJRJ0HMFJPu286kPT7N/8eFmoO82C1DkhFBJ44+yeiiNOZZc0LYyYocp0NJiO6zYh3YAMVWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo932BFpb9dBXHY/8cc/WUFiQyTJve8/lVHFWhE0EEtZPTOD90
	orfOCOI49BIF0vu6/ByVqrupN1elu8SKtMPIeCVDxNCdyE2aNL/0fQuW5jYU/NRIyr1XwtvNslw
	5ykOgyFYaWEbntm0ZVwpeslVByGVRSx0wKo03OtK8FQ==
X-Google-Smtp-Source: AGHT+IFVXBziZnAXtY7UJyF4jsrXraoffuaNWH6DNadyTShnx/MSIVbICVBeT/+7TTzFGz2dzYpxMqBWI8MahuDUmOc=
X-Received: by 2002:a05:690c:dcd:b0:720:378:bec2 with SMTP id
 00721157ae682-72276511331mr119403207b3.33.1756817440419; Tue, 02 Sep 2025
 05:50:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-4-ryncsn@gmail.com>
 <ed486d6d-1664-43b6-9d5c-696305f833b1@redhat.com>
In-Reply-To: <ed486d6d-1664-43b6-9d5c-696305f833b1@redhat.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 2 Sep 2025 05:50:29 -0700
X-Gmail-Original-Message-ID: <CACePvbV=iR=r3rR8Xov9B9ntgG+XXM4jwy_bhGzUQmi8yWzpzA@mail.gmail.com>
X-Gm-Features: Ac12FXy15-vkRjE13xZWnbwl5FOzZS_8Qv0OdwUQBfi8tnkwI6upzb-z1-HyKYk
Message-ID: <CACePvbV=iR=r3rR8Xov9B9ntgG+XXM4jwy_bhGzUQmi8yWzpzA@mail.gmail.com>
Subject: Re: [PATCH 3/9] mm, swap: rename and move some swap cluster
 definition and helpers
To: David Hildenbrand <david@redhat.com>
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Nhat Pham <nphamcs@gmail.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 3:21=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 22.08.25 21:20, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > No feature change, move cluster related definitions and helpers to
> > mm/swap.h, also tidy up and add a "swap_" prefix for cluster lock/unloc=
k
> > helpers, so they can be used outside of swap files.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
>
> [...]
>
> >
> > -#ifdef CONFIG_THP_SWAP
> > -#define SWAPFILE_CLUSTER     HPAGE_PMD_NR
> > -
> > -#define swap_entry_order(order)      (order)
> > -#else
> > -#define SWAPFILE_CLUSTER     256
> > -
> > -/*
> > - * Define swap_entry_order() as constant to let compiler to optimize
> > - * out some code if !CONFIG_THP_SWAP
> > - */
> > -#define swap_entry_order(order)      0
> > -#endif
> > -#define LATENCY_LIMIT                256
> > +#define LATENCY_LIMIT 256
>
> No need to touch that line IMHO.
>
>
> I enjoy the new function names.

I enjoy that naming convention too, wink wink.

Chris


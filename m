Return-Path: <linux-kernel+bounces-822989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6953FB853A5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35393A40C8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C96313280;
	Thu, 18 Sep 2025 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGZFAI/w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E7F313269
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205205; cv=none; b=Yx/EajhHtGK0NZZn3uUYoxr6QlWNaZew3RpaCyL+lfnAgA4dC1hYT2EJUQcllqnQY+54jg9DLpENyv6VvHSEVvSBj5rKjB4Vn9oItPhbp4rBiC+3GipZQ1g8SMVzVeQBkhb0yFX6GzoCGbYkBzswSaJyM1IwygzfKTlbAxBgdAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205205; c=relaxed/simple;
	bh=OWZhryAvRQtDyjeStvoQhj1ITDFDPTCq/irqjRsFVR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uC1u4VC2wDQcIvd78FCYdhjH1oarLJmtVu2nbCs77ONnimQtnirYVMKDtYjMnlpBPKaLtdvrRj5Gy5mloQS4QbBtnZRMlYjMquV/3QBdoN5eA/LD4OXB8ukvf5CJXSuo84Wi/fgdTMWQprRq1yn62I+KdwWOG+9A79GfMDZiHFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGZFAI/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BADC4CEFA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758205204;
	bh=OWZhryAvRQtDyjeStvoQhj1ITDFDPTCq/irqjRsFVR8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AGZFAI/w3PnQAru63me4ay9jcaUlh2xe9SKRc+AnrbhbOSWIHnJULSpTHXF8mBdH2
	 g1CCR4xfum6T5US/0VPAFJg9rWMbHWRhVxHwdWRD8/lTly0KGojQ7dCoAlHOa/FzxO
	 gGAGahj1CzvbfPpzYutFt3Ll+KLdEaJ1U4/8WyjBgtsrtRQuzew+MswdAHxkqW91H0
	 f+YEdfxz3vDTr8sBecc5GQN1oBiJPLbed4JAiRiI5tLUxpMzCguyaDqgi+1WU4RPR/
	 wSamAdiZcSXghDtYJgSpz4sAY9J2XDizVueMNCzf8uasuTaiVDFzECHmYBGJQXg7Mc
	 w9AU5drGotPPw==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d6051aeafso8042967b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:20:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIm+79SKU7Y5Mxh2hh23n1m1jObKiEGbVl2md8zkL3OaGm3G5e/mw/OugS/CcaNhSS+nB+1BHnLdUAPGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YysMLtEz9JHnbP1BLnM7wJIjlrawBN2iHZzENeaPttSb7eVMWBY
	YWjaJ9i3Iy5uLMngDwypU9qgkIABf5Pj1N4TEouvteknEvRrn906UbPoXLzOpMS4OGFNA8tPdwk
	kvQYRLbDKJiW0H4/epBKNmhJKpry52+RoxNpeCmwCTQ==
X-Google-Smtp-Source: AGHT+IHJ5VJ815IdenFpro8uYXEfzkWvkvnL+QTGV/q4zXxuxIvJR5FbvI/qS7bEiRnQ3lj33uFOCWbw2B2cpQMqPjE=
X-Received: by 2002:a05:690c:18:b0:71f:e430:666b with SMTP id
 00721157ae682-73892a49056mr46759697b3.32.1758205203651; Thu, 18 Sep 2025
 07:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160100.31545-1-ryncsn@gmail.com> <20250916160100.31545-2-ryncsn@gmail.com>
 <CAGsJ_4w2GqGj8HZMfwndsWu7qkORqsnaw9WwhmQS=pW4gR7nEA@mail.gmail.com>
 <CAF8kJuNbUyDWcJ13ZLi-xsiYcbY30w7=cFs7wdxszkc7TC4K2Q@mail.gmail.com>
 <CAGsJ_4wKWem-STYAnh_0EgSFKzzs1M1c7wz6K82wLt6T6JEw9A@mail.gmail.com>
 <CACePvbU8cUs-wwPsXkZ24EWga5bXxxUGSCT18rKAWFYn5w9rpw@mail.gmail.com>
 <CAGsJ_4yhDU_WVfEybDhGE-WF5+w-fak1-F8jqbAQ-Qw1+qWkaw@mail.gmail.com>
 <CACePvbUabb+L6Z9Nb-41fLR-FMhj--cDWSbnXtCj3rpqXModiQ@mail.gmail.com>
 <CAGsJ_4y8yTX48ESHKgLNCvM1M1_gY9uGnD4qiz8n+gD47Zd1Hg@mail.gmail.com>
 <CANeU7QkZBWFO6SeVHtmm73oLu7r0zavePQEYmQfH8opKPH1QWw@mail.gmail.com>
 <CANeU7QmcC=-CTmJ7i8R77SQ_WArBvjP3VrmpLOy-b7QhCfMRYA@mail.gmail.com> <CAGsJ_4zmkibM_Ex7kGMsr2sni85H-cnxQvh0XwkWiALNQy+zAQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4zmkibM_Ex7kGMsr2sni85H-cnxQvh0XwkWiALNQy+zAQ@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 18 Sep 2025 07:19:52 -0700
X-Gmail-Original-Message-ID: <CACePvbXae0zymE_BHydXtA_pjZ2NqabVyqxu1xKxLjLKmeYH9g@mail.gmail.com>
X-Gm-Features: AS18NWAMcE25uboInmnLpD0pUJ78wF8y-VpV56txG6Fyry-vKnC2XHT05OGiLaE
Message-ID: <CACePvbXae0zymE_BHydXtA_pjZ2NqabVyqxu1xKxLjLKmeYH9g@mail.gmail.com>
Subject: Re: [PATCH v4 01/15] docs/mm: add document for swap table
To: Barry Song <21cnbao@gmail.com>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 1:59=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Thu, Sep 18, 2025 at 3:03=E2=80=AFPM Chris Li <chrisl@kernel.org> wrot=
e:
> >
> > Hi Barry,
> >
> > How about this:
> >
> > A swap table stores one cluster worth of swap cache values, which is
> > exactly one page table page on most morden 64 bit systems. This is not
> > coincidental because the cluster size is determined by the huge page si=
ze.
>
> I=E2=80=99d phrase it as =E2=80=9CPMD huge page,=E2=80=9D since we also h=
ave =E2=80=9CPUD huge page.=E2=80=9D

Good point. Will do.

>
> > The swap table is holding an array of pointers, which have the same
> > size as the PTE. The size of the swap table should match the page table
> > page.
> >
>
> I=E2=80=99m not entirely sure what you mean by =E2=80=9Cpage table page.=
=E2=80=9D

The page that gets pointed by the page table, or the page that holds the PT=
E.

> My understanding is that you=E2=80=99re saying:
> The swap table contains an array of pointers, each the same size as a PTE=
,
> so its total size typically matches a PTE page table=E2=80=94one page on =
modern
> 64-bit systems.

That sounds good. Thanks for the suggestion.
I take your suggestion with some small modifications, mostly to
clarify the total size is the total size of one cluster of swap
tables. The total size of all swap tables in a swap file is much
bigger.

How about this:

A swap table is an array of pointers. Each pointer is the same size as a PT=
E.
The size of a swap table for one swap cluster typically matches a PTE
page table,
which is one page on modern 64-bit systems.

Chris


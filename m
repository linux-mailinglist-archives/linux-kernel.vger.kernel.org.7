Return-Path: <linux-kernel+bounces-819709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A4EB7EA1B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6430B2A65EA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D020C29D282;
	Tue, 16 Sep 2025 22:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZkcLUZC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B5B2BDC2A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758062541; cv=none; b=hSMch40YwjE0rKPPfCy6+TgYhVGEcVdG/KjWYxyPTTQq9aWbGFgwca2zMmg1awXfCH+SJif/Rh47VCGxXd6tvYMiyLYU7+tipXjRyPSk579tKVltNB92wQJaVW6Ey8yzjyy0ljbbAADrq08QLbh51e0Ynka09aoF0r7A/tMrUUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758062541; c=relaxed/simple;
	bh=t4iTrV+CqcFLDpG4Gp8BKSUYWO2Ix48fUK0eR2N/m20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kC2+v7a3dg1iO4OM3+nlzbfP8dcV0AiGW4+JeGJgjdI4ig3l83soraWxOv5eYJip4fHfxxlMUaTyITxKS/zsoFBrkmjGqcSUKo1IoTm0lfxqmKpMl7GUYMUzC1vc14QB/nd5eBV1LKfHDs2k6fQcdm/0WxmyEtQ/iTO2kSq/Fbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZkcLUZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B25C4AF09
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758062540;
	bh=t4iTrV+CqcFLDpG4Gp8BKSUYWO2Ix48fUK0eR2N/m20=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KZkcLUZCDSstkZ3Ty026dyokebf5jPCTNbVbbw7XSxBv6QWqs0Jw4YBWjxIU+INE6
	 IEf/UAFqrndL9634RW5NgSlYc2z2ei242KeZvvWQWiuMeyz3Tmqo5XsX/ydqQ4BDYt
	 MhtLjbwffmITqL4fEi4olcX82T906tXyWejOQQ8OUO9Jt2iG9IoiBspEm+Cxc8OFCs
	 xmUvJNkv0YJSo11UnyBYw2LLI3BhYT5lmWDYOZ5OXlXtVxG7ODY3E5HaAJNlpJkWD3
	 Yj20CyNOmHf8qZM5+Kk56wGchd7ZVguUAOjGDbGP2TEpNHfX65n1OPwHr++3Iqpoj1
	 beoT7wy6y1J5w==
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45f28aba94cso30865e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:42:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdOboBDlxz52l9SuTQVDp+InfaS3zYZyvzhjlZLiquKCrP3lchd8At8jpsiRdzIM8etwYc7ljE8ewtZe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGIfpnxtmhfJ/BIkayETCIEkpbFZlan8DAF9RlvhktU/N3SWdo
	BGXkGxsIHe2F3dSfNr6pnDfTJ2QUM1dBJMbAiZDY+YWDKNZwTetj6ilftMqwTr57Vkd4toj5y1V
	BvvZ8LS0pH/UvfbCucrI2JQbHC6oPx5s+RKNmmyCx
X-Google-Smtp-Source: AGHT+IHWLOmuD/tU8v3ni2BKIAlWeib4S+ucs/1zjlARg1seSLctmJGnrUIwP3gUbQopXbQ3T+B3asPvoCAu+Yfk/Lg=
X-Received: by 2002:a05:600c:26c5:b0:45c:b4fb:f0b3 with SMTP id
 5b1f17b1804b1-461a07c7283mr159535e9.3.1758062539040; Tue, 16 Sep 2025
 15:42:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160100.31545-1-ryncsn@gmail.com> <20250916160100.31545-2-ryncsn@gmail.com>
 <CAGsJ_4w2GqGj8HZMfwndsWu7qkORqsnaw9WwhmQS=pW4gR7nEA@mail.gmail.com>
In-Reply-To: <CAGsJ_4w2GqGj8HZMfwndsWu7qkORqsnaw9WwhmQS=pW4gR7nEA@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 16 Sep 2025 15:42:07 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNbUyDWcJ13ZLi-xsiYcbY30w7=cFs7wdxszkc7TC4K2Q@mail.gmail.com>
X-Gm-Features: AS18NWDQO70jEWQyR-tJB4PbRe5EI87TY1HG1tDIFqnOkXu_DbegsZNLqYZwqoM
Message-ID: <CAF8kJuNbUyDWcJ13ZLi-xsiYcbY30w7=cFs7wdxszkc7TC4K2Q@mail.gmail.com>
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

On Tue, Sep 16, 2025 at 3:00=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Wed, Sep 17, 2025 at 12:01=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > From: Chris Li <chrisl@kernel.org>
> >
> > Swap table is the new swap cache.
> >
> > Signed-off-by: Chris Li <chrisl@kernel.org>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  Documentation/mm/index.rst      |  1 +
> >  Documentation/mm/swap-table.rst | 72 +++++++++++++++++++++++++++++++++
> >  MAINTAINERS                     |  1 +
> >  3 files changed, 74 insertions(+)
> >  create mode 100644 Documentation/mm/swap-table.rst
> >
> > diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
> > index fb45acba16ac..828ad9b019b3 100644
> > --- a/Documentation/mm/index.rst
> > +++ b/Documentation/mm/index.rst
> > @@ -57,6 +57,7 @@ documentation, or deleted if it has served its purpos=
e.
> >     page_table_check
> >     remap_file_pages
> >     split_page_table_lock
> > +   swap-table
> >     transhuge
> >     unevictable-lru
> >     vmalloced-kernel-stacks
> > diff --git a/Documentation/mm/swap-table.rst b/Documentation/mm/swap-ta=
ble.rst
> > new file mode 100644
> > index 000000000000..acae6ceb4f7b
> > --- /dev/null
> > +++ b/Documentation/mm/swap-table.rst
> > @@ -0,0 +1,72 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +:Author: Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com=
>
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Swap Table
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Swap table implements swap cache as a per-cluster swap cache value arr=
ay.
> > +
> > +Swap Entry
> > +----------
> > +
> > +A swap entry contains the information required to serve the anonymous =
page
> > +fault.
> > +
> > +Swap entry is encoded as two parts: swap type and swap offset.
> > +
> > +The swap type indicates which swap device to use.
> > +The swap offset is the offset of the swap file to read the page data f=
rom.
> > +
> > +Swap Cache
> > +----------
> > +
> > +Swap cache is a map to look up folios using swap entry as the key. The=
 result
> > +value can have three possible types depending on which stage of this s=
wap entry
> > +was in.
> > +
> > +1. NULL: This swap entry is not used.
> > +
> > +2. folio: A folio has been allocated and bound to this swap entry. Thi=
s is
> > +   the transient state of swap out or swap in. The folio data can be i=
n
> > +   the folio or swap file, or both.
>
> This doesn=E2=80=99t look quite right.
>
> the folio=E2=80=99s data must reside within the folio itself?

For swap out cases that is true. The swap in case you allocate the
folio first then read data from swap file to folio. There is a window
swap file that has the data and folio does not.

> The data might also be in a swap file, or not.

The data only in swap file is covered by "data can be in the folio or
swap file", it is an OR relationship.

I think my previous statement still stands correct considering both
swap out and swap in. Of course there is always room for improvement
to make it more clear. But folio always has the data is not true for
swap in. If you have other ways to improve it, please feel free to
suggest.


> On a 32-bit system, I=E2=80=99m guessing the swap table is 2 KB, which is=
 about
> half of a page?

Yes, true. I consider that but decide to leave it out of the document.
There are a lot of other implementation details the document does not
cover, not just this aspect. This document provides a simple
abstracted view (might not cover all the detail cases). One way to
address that is add a qualification "on a 64 bit system". What do you
say? I don't want to talk about the 32 bit system having half of a
page in this document, I consider that too much detail. The 32 bit
system is pretty rare nowadays.

Chris


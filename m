Return-Path: <linux-kernel+bounces-796478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 238F4B40121
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84D04E7CF5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFE92D63ED;
	Tue,  2 Sep 2025 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VB9JPZA9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341C32D595B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817188; cv=none; b=O6NEwXBpxr4LIB82rgHT3EV9qgprPrPP3s1mnUto10Y5eWUJe/ucrjWA/AlACyaUS8spgj9Cs9s7PyUZB2uzk3OI67aGu8+opt89X0lWuIqytqM84jiS3pViHx/rdT6HDYPEAW4eneYo4CfyDb0aOaFy2A7qk0n+m1yZQsHZTHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817188; c=relaxed/simple;
	bh=jOieBAdKq+Jk/zOQnhoH+w34fueGOes42t8OWIFbIDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6xGSw1wJsl3wL5xex3ZAzekAKVM1ireKJ7VnmBleU6Tsztho1j511ge444tEk4Nx3P1IUOOsKemSrfFAfbqukomfEmc6v43ZUfOrOesoRR4h8rTsFmWfZekC7mUNSENE32TMG1scE3zNVie+EwD6/02/WeudNIvmnpcnuyoH80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VB9JPZA9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85A3C4CEFA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756817187;
	bh=jOieBAdKq+Jk/zOQnhoH+w34fueGOes42t8OWIFbIDY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VB9JPZA9RCu3qjMGQAm74GWgS1xp9XUsEB45Ary6FU82UenY0Zn8adZfIpI9h566K
	 FQVEdDLJuFO1+qrdMgHTfCnzzxVtxxu4Fugjy1a3SgasusIMkYMP+0QpEqhCY6OA7y
	 AK8dyPkQkwJ1JBAOcfyNwStnFC+xn4KBz6NDKc/edNsUE/K9fP3YpdRGaUlgsdfrEH
	 xOhcK/Bt/UDkxPmftvswm/BEzIYw1D9bZLkRneahihjrxpeirCp8jwPubeiRLGITlg
	 Si9IoQc2ztcJ8paiBxL5nDcN7oZoQa7b1q30uAPoK3NoU0RWHfY3ZcjTHKO4lxpJKJ
	 bkiAsKZn7zq8w==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d603f13abso53415997b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:46:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQbXt1oIgP6Ogy2gE9Amuv6oXKISd0f0qhyQuzS8bF3nOvNCfj7E61bsnW3sTJ0SYRR6j81raLamCFv2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw53yILao3rLdqkxe+waNSsL2fX6ZD+rp50CsWj9KnjNyP3zisx
	LTD0P7GF6NMUnwm1hKzPDRi9So2R+/EnEhaJmyXmigHT0RVlflQ7uNlZj+eOx/QySZLyoD9Hgyv
	qgYZ9VzWUMPF9utZ0AmTHqu4vUlqJqJsgQlJahTlpJw==
X-Google-Smtp-Source: AGHT+IED0lg2698fOemE35zLVrPDmVbySfg8LCS3cQ4HucMwxzGZ2PHSsimY7oa1U9hph/JcpzmWGJ+uTLEqNf7mybM=
X-Received: by 2002:a05:690c:64c7:b0:722:6f24:6293 with SMTP id
 00721157ae682-722764d1a86mr111055047b3.32.1756817186932; Tue, 02 Sep 2025
 05:46:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-3-ryncsn@gmail.com>
 <911dc3b4-c511-4ef2-a159-091780987965@redhat.com>
In-Reply-To: <911dc3b4-c511-4ef2-a159-091780987965@redhat.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 2 Sep 2025 05:46:15 -0700
X-Gmail-Original-Message-ID: <CACePvbXs3J6qYWFycVW8rGjiaOw9iTFLdWq1Lq4HyaDkSY45uA@mail.gmail.com>
X-Gm-Features: Ac12FXy7nblHn4LKwFgkQrQWVUfFCHgtM428VnsEBAgz8jKNZju1D-xaxLOVN18
Message-ID: <CACePvbXs3J6qYWFycVW8rGjiaOw9iTFLdWq1Lq4HyaDkSY45uA@mail.gmail.com>
Subject: Re: [PATCH 2/9] mm, swap: always lock and check the swap cache folio
 before use
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

On Tue, Sep 2, 2025 at 3:18=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 22.08.25 21:20, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > Swap cache lookup is lockless, it only increases the reference count
> > of the returned folio. That's not enough to ensure a folio is stable in
> > the swap cache, so the folio could be removed from the swap cache at an=
y
> > time. The caller always has to lock and check the folio before use.
> >
> > Document this as a comment, and introduce a helper for swap cache folio
> > verification with proper sanity checks.
> >
> > Also, sanitize all current users to use this convention, and use the ne=
w
> > helper when possible for easier debugging. Some existing callers won't
> > cause any major problem right now, only trivial issues like incorrect
> > readahead statistic (swapin) or wasted loop (swapoff). It's better to
> > always follow this convention to make things robust.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
>
> [...]
>
> > +/**
> > + * folio_contains_swap - Does this folio contain this swap entry?
> > + * @folio: The folio.
> > + * @entry: The swap entry to check against.
> > + *
> > + * Swap version of folio_contains()
> > + *
> > + * Context: The caller should have the folio locked to ensure
> > + * nothing will move it out of the swap cache.
> > + * Return: true or false.
> > + */
>
> I appreciate the kerneldoc.
>
> Intuitively, this should be called "..._swap_entry".
>
> But I wonder if "contains" is really the right term to use here. It's
> more like that a swap entry "belongs to" (was assigned to) a folio, right=
?

Right, in the other design doc I use the word "binding" for the
relationship between folio and swap entry. As if it is a binding
contract, your folio data goes and only goes here. There is no owning
relationship. Other folios might want to compete and win over the
binding contract as well (the race in swap in).

> Sure, we store the information in the folio, but the "contains" is a bit
> weird.
>
> folio_matches_swp_entry() maybe?

Yes, I like the name folio_match_swap_entry() you suggested in the
other email as well.

Chris


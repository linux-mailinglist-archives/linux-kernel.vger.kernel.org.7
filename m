Return-Path: <linux-kernel+bounces-822043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE02B82ECB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA9D1C027E7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154251A3166;
	Thu, 18 Sep 2025 05:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izUyabaY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6782334BA43
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758171806; cv=none; b=WCcFjhElkf1Idz4nDUdvFdL9ysdb1nymvUuKj24ahedhJrZFV4+JYt5MOlph7U2El0hPiYjFXv9ZC29/x9eSTgF9TrLjDkTe9eTNpro4aE1F5EN0gc0b2rzrCCtLk0jB9aDf+Cs8/Dx4bUUTjpG7FH9rHTjOiA1d2HvapvDDUBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758171806; c=relaxed/simple;
	bh=7W2lyROUGHdP3dsbt+IeiIDj0Na9XdzQYQpgVUVsyN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rm6aeMbQZTQry7ZoM9e1KWSC/fBk9Pnx9KKEHZNZbqxdm3TY0XI07cQiJeGQZyBH37gVIdGQVZJjXX1VWUKWwSu26OoF46m5DDd3c/59prLZwwkbgChygOUy+BkQCaOUumV8U834vsXGHiMtizjLNhN1y8v6j36UAqoxf4milq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izUyabaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6A7C116C6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758171806;
	bh=7W2lyROUGHdP3dsbt+IeiIDj0Na9XdzQYQpgVUVsyN0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=izUyabaYS7grO/2feGgm4ifhXXubscrYpOhrSWJPSPAPh9GNyU0RSxAHRKYqAZNn+
	 h2QD6dVImkGjyaT38IHQnZ2USYxggw0keMChQpMYW7qydowgmQdIzK9zAsk5FpGqr2
	 l8eIPHa2TSS+t4HpCyb0/zSJIhJr6bCDB1kAvDN7FUBsqZ5afVCCZpwyzsM9wANL2I
	 UHew6ZhWygly0Fn11FaKu9lkm/FxKDrGlii/1ausztBtCBnfSdiCzMLO/HCGGog0u8
	 vpmjdUNF3pp8rFrlOncb4XbwoiyheubejLenzaT/LRRgkImGIkxaKPEhKvBuHmgjVX
	 ga7b+Xc5uB4Ig==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f98e7782bso701251e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:03:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXV3HctvqLFXroXRko1OH7GzAQxTPftBz4lNgaPSbmyr84udRvdfFq+Tp2lEhGFaJPWz6OPqqilDw17oU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmkpRbg8lxbzAWQZDLzlFhGVQQqc6may+CA39hAB+2tK7cp23o
	1KHKazOENQuChVnlsmFZBYJK5vWjxm1Mc7+VDE/4FpzYR9/uvIJ7C+VPX/UOZa3Q+ixnbQjt5fT
	UhFeyhMbLEHrQfQ2noepGMnIUxfdu7g==
X-Google-Smtp-Source: AGHT+IGD1CQLqGySmhrkzQzsiSL90znsRrvPLPTc7vfVtF4Ow+HKYTydxL79tCPmKxbplpuM3Gthu0dxw6cuB/nL9SI=
X-Received: by 2002:a05:6512:ea1:b0:576:59cd:ffb1 with SMTP id
 2adb3069b0e04-57894ebf20cmr648428e87.22.1758171804455; Wed, 17 Sep 2025
 22:03:24 -0700 (PDT)
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
 <CACePvbUabb+L6Z9Nb-41fLR-FMhj--cDWSbnXtCj3rpqXModiQ@mail.gmail.com> <CAGsJ_4y8yTX48ESHKgLNCvM1M1_gY9uGnD4qiz8n+gD47Zd1Hg@mail.gmail.com>
In-Reply-To: <CAGsJ_4y8yTX48ESHKgLNCvM1M1_gY9uGnD4qiz8n+gD47Zd1Hg@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 17 Sep 2025 22:03:12 -0700
X-Gmail-Original-Message-ID: <CANeU7QkZBWFO6SeVHtmm73oLu7r0zavePQEYmQfH8opKPH1QWw@mail.gmail.com>
X-Gm-Features: AS18NWB6V52_xqiX64XXMAqy3-yf52xEFlsm6O0XCWcfwFVru9CDfSCEY0zMNRc
Message-ID: <CANeU7QkZBWFO6SeVHtmm73oLu7r0zavePQEYmQfH8opKPH1QWw@mail.gmail.com>
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

On Wed, Sep 17, 2025 at 4:38=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> > > This approach still seems to work, so the 32-bit system appears to be
> > > the only exception. However, I=E2=80=99m not entirely sure that your =
description
> > > of =E2=80=9Cthe second last level=E2=80=9D is correct. I believe it r=
efers to the PTE,
> > > which corresponds to the last level, not the second-to-last.
> > > In other words, how do you define the second-to-last level page table=
?
> >
> > The second-to-last level page table page holds the PMD. The last level
> > page table holds PTE.
> > Cluster size is HPAGE_PMD_NR =3D 1<<HPAGE_PMD_ORDER
> > I was thinking of a PMD entry but the actual page table page it points
> > to is the last level.
> > That is a good catch. Let me see how to fix it.
> >
> > What I am trying to say is that, swap table size should match to the
> > PTE page table page size which determines the cluster size. An
> > alternative to understanding the swap table is that swap table is a
> > shadow PTE page table containing the shadow PTE matching to the page
> > that gets swapped out to the swapfile. It is arranged in the swapfile
> > swap offset order. The intuition is simple once you find the right
> > angle to view it. However it might be a mouthful to explain.
> >
> > I am fine with removing it, on the other hand it removes the only bit
> > of secret sauce which I try to give the reader a glimpse of my
> > intuition of the swap table.
>
> Perhaps you could describe the swap table as similar to a PTE page table
> representing the swap cache mapping.

Hard to qualify what is "similar", in what way it is similar.
Different readers will have different interpretations of what similar
means to them.

> That is correct for most 32-bit and 64-bit systems,
> but not for every machine.

I think I will leave it as for most 64 bit systems, the swap table
size is exactly one page table page size and that is not coincidental.

> The only exception is a 32-bit system with a 64-bit physical address
> (Large Physical Address Extension, LPAE), which uses a 4 KB PTE table
> but a 2 KB swap table because the pointer is 32 bit while each page
> table entry is 64 bit.

I feel that is a very corner case. I will leave it out of the
document. I want to present a simplified abstracted view. There is
always more detail to distract the simple abstracted view. That is why
we have physics.

> Maybe we can simply say that the number of entries in the swap table
> is the same as in a PTE page table?

Yes, that is what I want to say, for most modern 64 bit systems.

Chris


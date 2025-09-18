Return-Path: <linux-kernel+bounces-822189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBC1B83406
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD55B3B3455
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A663B2DE6EE;
	Thu, 18 Sep 2025 07:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/jPoKA6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E222454764
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758179015; cv=none; b=pJfcVcHW3OE+giofsOPjaMNsSRDVf3+x1Pkk2xNigbdKl3debe+2IlJLNA+sffKtabfn4v6cINXXeKetV2g0srH4iFtKSDE8bNYk4E1jt5bgnyvfnc5viBmzEH3SP3xUTASZ7elciTzlg3ZFjbJ8Su/7zLr1GBSDI1UKf5/ijZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758179015; c=relaxed/simple;
	bh=w+ErpBRL1l1AWMxlK8Kv80OYxkNODRdorjcQzFTx4Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMBUfA46sbyu5f4m1cyn3b3kDRaPArMC5Uad4t3n85z78+FYZS2DH4fuQmHh5uMWEW73mA7x1FeiZ7hKEY7qFJiJs7wwR6jL2ds2c1pQxhwb5ojKlKCngm4XXjE9GpBEdyYKxn65AfmWbz+CQJzQqTqHFrbvmZ6ScKTtKpWLGHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/jPoKA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654C8C113CF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758179014;
	bh=w+ErpBRL1l1AWMxlK8Kv80OYxkNODRdorjcQzFTx4Vw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p/jPoKA6AhiIzCBP61Nuqy1q6G1Fl792+ptGL7xQCo7KrkYrD5FfEW/MQOWUz6cMD
	 H4Yil1LNC3vThRtVziWcCCxN3OzaQuoL9Z32NE3S907ZmcOqRz0EotVjsr/T84qkN3
	 WqH0sgW4yjmYKbageMFD3Am5BITisMQrCQw5xlTsAE9XQ/eEv1CR8N2CH/oU6w5TAu
	 g7VKmnwg0Lhjv+Rjfxl/wKybdHc+0dgKRZczTtYRZIlvRgZK6bKUZLSqoQ0XKyvmSM
	 KMIrkxEdiP6XV7M5e8WiZWVrg38ADigKta8ypu4iVxAiY9CQj5DJgEwEfoFDZ6scS+
	 NJ1RK7r8TA/3g==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5608b619cd8so694148e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:03:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXnHAJ/OSOjlVXwOrm2UU307xpPUgDF2Ab+EVlZ6IA92wf07aka/XEgJ73BFMQZWnEsKsjdSnBGhYWnLT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXpG7O1pY8JUOmAvWAtYbTK8mQ8L579YnLYHy4um6t4kKyIpVR
	+NYSPzVWyqST7Hhx0QWryGcq5aPqDyI2i7UcwV10OfKRadQ2NNTMVSJQNcl5UA61oVXCRQwan3/
	VtDQsmkwFOfayZcwl18lmQh6WcotghQ==
X-Google-Smtp-Source: AGHT+IGJs/PcXCDxOEGAiTcDcrXuGdiFMqjgrLIi1+1jjccVhq9MjHPWG23k6+kfQ5dKqi7auT6HU1FGc+Nq4YAKaiY=
X-Received: by 2002:a05:6512:3b2b:b0:55f:3faa:7c2b with SMTP id
 2adb3069b0e04-5779bdc6d10mr1368887e87.39.1758179012976; Thu, 18 Sep 2025
 00:03:32 -0700 (PDT)
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
 <CAGsJ_4y8yTX48ESHKgLNCvM1M1_gY9uGnD4qiz8n+gD47Zd1Hg@mail.gmail.com> <CANeU7QkZBWFO6SeVHtmm73oLu7r0zavePQEYmQfH8opKPH1QWw@mail.gmail.com>
In-Reply-To: <CANeU7QkZBWFO6SeVHtmm73oLu7r0zavePQEYmQfH8opKPH1QWw@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 18 Sep 2025 00:03:20 -0700
X-Gmail-Original-Message-ID: <CANeU7QmcC=-CTmJ7i8R77SQ_WArBvjP3VrmpLOy-b7QhCfMRYA@mail.gmail.com>
X-Gm-Features: AS18NWC9pu8B5pH4dlv8MuU8SxVN9kdKP9S1B5I9Sg97ymUY5ImXVEPfBbPThSs
Message-ID: <CANeU7QmcC=-CTmJ7i8R77SQ_WArBvjP3VrmpLOy-b7QhCfMRYA@mail.gmail.com>
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

Hi Barry,

How about this:

A swap table stores one cluster worth of swap cache values, which is
exactly one page table page on most morden 64 bit systems. This is not
coincidental because the cluster size is determined by the huge page size.
The swap table is holding an array of pointers, which have the same
size as the PTE. The size of the swap table should match the page table
page.

If that sounds OK, I will send an incremental patch to Andrew.

Chris

On Wed, Sep 17, 2025 at 10:03=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote=
:
>
> On Wed, Sep 17, 2025 at 4:38=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > > > This approach still seems to work, so the 32-bit system appears to =
be
> > > > the only exception. However, I=E2=80=99m not entirely sure that you=
r description
> > > > of =E2=80=9Cthe second last level=E2=80=9D is correct. I believe it=
 refers to the PTE,
> > > > which corresponds to the last level, not the second-to-last.
> > > > In other words, how do you define the second-to-last level page tab=
le?
> > >
> > > The second-to-last level page table page holds the PMD. The last leve=
l
> > > page table holds PTE.
> > > Cluster size is HPAGE_PMD_NR =3D 1<<HPAGE_PMD_ORDER
> > > I was thinking of a PMD entry but the actual page table page it point=
s
> > > to is the last level.
> > > That is a good catch. Let me see how to fix it.
> > >
> > > What I am trying to say is that, swap table size should match to the
> > > PTE page table page size which determines the cluster size. An
> > > alternative to understanding the swap table is that swap table is a
> > > shadow PTE page table containing the shadow PTE matching to the page
> > > that gets swapped out to the swapfile. It is arranged in the swapfile
> > > swap offset order. The intuition is simple once you find the right
> > > angle to view it. However it might be a mouthful to explain.
> > >
> > > I am fine with removing it, on the other hand it removes the only bit
> > > of secret sauce which I try to give the reader a glimpse of my
> > > intuition of the swap table.
> >
> > Perhaps you could describe the swap table as similar to a PTE page tabl=
e
> > representing the swap cache mapping.
>
> Hard to qualify what is "similar", in what way it is similar.
> Different readers will have different interpretations of what similar
> means to them.
>
> > That is correct for most 32-bit and 64-bit systems,
> > but not for every machine.
>
> I think I will leave it as for most 64 bit systems, the swap table
> size is exactly one page table page size and that is not coincidental.
>
> > The only exception is a 32-bit system with a 64-bit physical address
> > (Large Physical Address Extension, LPAE), which uses a 4 KB PTE table
> > but a 2 KB swap table because the pointer is 32 bit while each page
> > table entry is 64 bit.
>
> I feel that is a very corner case. I will leave it out of the
> document. I want to present a simplified abstracted view. There is
> always more detail to distract the simple abstracted view. That is why
> we have physics.
>
> > Maybe we can simply say that the number of entries in the swap table
> > is the same as in a PTE page table?
>
> Yes, that is what I want to say, for most modern 64 bit systems.
>
> Chris


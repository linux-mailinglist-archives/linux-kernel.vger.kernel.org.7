Return-Path: <linux-kernel+bounces-821367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9B6B8113E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A74023BB600
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5D12F4A17;
	Wed, 17 Sep 2025 16:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjwqC0BK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4591224B04
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758127739; cv=none; b=YjVkVvN6rMWA9neiR5Q6Jy1wyLIUrsT5rnJ6JOvGWiqgPpXs9ol5njiANclihE5adop9bAWKgSYIv8xZQ45h6PEDBbS3y09wtzh79GEpYZ3cPcli1NSttvSzJdEMrCjUp64+3ST02380hi1RribrWn1yg5Vh9E9bIH2ti7Tpkig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758127739; c=relaxed/simple;
	bh=yUPC1zdWN5kKx+k6dBvxwjTFs2977h19xDLTjdHgTTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1P26egAN1gb+mkO5dZQAtGuVaj4idz9iLIo6W97YRXrrO0CgXuG/J6Rv7zSica23BYu2bA57hd6Gds1fP5WH0e8RSvA6ONHyreL+LphA5IRWhi1k9eUkgDjtDLxqOMwft22280yTtVS9oQ5/v5GCwVpytvGa6N2LZgp0bQNfAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjwqC0BK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E86FC4CEFA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758127739;
	bh=yUPC1zdWN5kKx+k6dBvxwjTFs2977h19xDLTjdHgTTw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OjwqC0BK5syFJ4ucBTiiaVfcojW8yy4lWxQUj0EGvgLResgn5JCf6ls1LuwvzPhY6
	 Nxfxshvnn0chhXgjaGus7TyRITxO9UUnSa5fE/e3MQnEO4fyiioga+673diyYidIwR
	 VLpJ6m1aJ0LKl3IVzbcoNhZ04l5ieFGqC3tVHkZcKaetueQrpK6yZBTiBgd4shU1wd
	 sKzkv291oAbLsZgP1r80MzbcGz5vvZfVJGWq4+eMkvMdJ4EOAeU3F6p2xcS1QVI0o8
	 ixN96A8J+gaaRlkIRBauPV0qGNSwOVpJeD1TkfHvl7rtdht7JcGXE3J/RlRDKWVYQ8
	 NJd6jVM4KjBMw==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-72e565bf2feso472647b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:48:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWArqqdp9szm8zDs/Jz0u2VSk5r0q3qCPU65BUxqZOxzrsBJIu+dGtrHcifKHF6ujgiw+azyy6U05J9fkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOHTbI/9WiZxttCaFCCSpBfdwf456p4+zHIHTzwtpS0MMbZ9b7
	Nf2ktutgSsB0+BpGnpn6Mr5o1ThD0nxr1iH6oX7pKJ5P51Q/9gROzf3CrHEevzCm/81uZOUbzLd
	pw6Ls2Q43KuhQZ10AWXQuny2/JgWqJo5s2PcitgQzYA==
X-Google-Smtp-Source: AGHT+IF0pKHAAeegJZZWoeLW97bU+nM2aZay5XgoAAF9236iZFlM4qN22XQNvUtyEBR/AyicnuDETAMdJbBTFlco/OA=
X-Received: by 2002:a05:690c:4b07:b0:724:bcb8:7d57 with SMTP id
 00721157ae682-73893141fe3mr22032967b3.54.1758127738739; Wed, 17 Sep 2025
 09:48:58 -0700 (PDT)
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
 <CACePvbU8cUs-wwPsXkZ24EWga5bXxxUGSCT18rKAWFYn5w9rpw@mail.gmail.com> <CAGsJ_4yhDU_WVfEybDhGE-WF5+w-fak1-F8jqbAQ-Qw1+qWkaw@mail.gmail.com>
In-Reply-To: <CAGsJ_4yhDU_WVfEybDhGE-WF5+w-fak1-F8jqbAQ-Qw1+qWkaw@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 17 Sep 2025 09:48:46 -0700
X-Gmail-Original-Message-ID: <CACePvbUabb+L6Z9Nb-41fLR-FMhj--cDWSbnXtCj3rpqXModiQ@mail.gmail.com>
X-Gm-Features: AS18NWAcw0qwgnqmnCF1ULPrhYr_hOxdDMPg7RIERdgeixYVmG8XAhG_ABvnJZU
Message-ID: <CACePvbUabb+L6Z9Nb-41fLR-FMhj--cDWSbnXtCj3rpqXModiQ@mail.gmail.com>
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

On Tue, Sep 16, 2025 at 4:48=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
> > In your above two examples, what is the respected swap cluster swap ent=
ry size?
> > In other words, how much entry does one swap cluster hold?
> >
> > Sorry I am not very familiar with the ARM page tables.
>
> Oh, my mistake=E2=80=94I recalculated:
>
> For a 16 KB page size, SWAPCLUSTER_SIZE will be 2^11 =3D 2048, so the swa=
p
> table is 2048 * 8 =3D 16 KB.

So my original description is correct in the sense that, the 16KB page
size, swap table is 16KB, this is not coincidental.

> For a 64 KB page size, SWAPCLUSTER_SIZE will be 2^13 =3D 8192, so the swa=
p
> table is 8192 * 8 =3D 64 KB.

Same here. For 64 KB page size, the swap table is 64KB as you just told me.
I am just trying to give a bit of a glimpse of where I get the
intuition for swap tables.

>
> This approach still seems to work, so the 32-bit system appears to be
> the only exception. However, I=E2=80=99m not entirely sure that your desc=
ription
> of =E2=80=9Cthe second last level=E2=80=9D is correct. I believe it refer=
s to the PTE,
> which corresponds to the last level, not the second-to-last.
> In other words, how do you define the second-to-last level page table?

The second-to-last level page table page holds the PMD. The last level
page table holds PTE.
Cluster size is HPAGE_PMD_NR =3D 1<<HPAGE_PMD_ORDER
I was thinking of a PMD entry but the actual page table page it points
to is the last level.
That is a good catch. Let me see how to fix it.

What I am trying to say is that, swap table size should match to the
PTE page table page size which determines the cluster size. An
alternative to understanding the swap table is that swap table is a
shadow PTE page table containing the shadow PTE matching to the page
that gets swapped out to the swapfile. It is arranged in the swapfile
swap offset order. The intuition is simple once you find the right
angle to view it. However it might be a mouthful to explain.

I am fine with removing it, on the other hand it removes the only bit
of secret sauce which I try to give the reader a glimpse of my
intuition of the swap table.

Thanks for catching that.

Chris


Return-Path: <linux-kernel+bounces-819724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 195A9B7C814
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746D41B264DF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390A82ECEA8;
	Tue, 16 Sep 2025 23:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl4oqzv2"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C397A2882CE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 23:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758064181; cv=none; b=S+mczJyGR0hcUvjIy/O8vJgWv771V1ATJMAStXJVFvMvgc+ATxXY/PIeDlaFF4ecfVzEfwfehQW4BXxRGd/stxiUfdTwBx84gO6AG+B3K4VRbGNpIBTCIUJuZMX+OEZzKTWEUmk+Y40E1w5sQfeiFTzGRhjn0ExZ7t3KmPn7NdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758064181; c=relaxed/simple;
	bh=7RbhQKHgi9s3KCFnRe5mGz8rY0YVyLvGeLZ1wPJH/aE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/siCxrMzIyLbcHAN1ESIkyREzav/eyIyOw/tbeh/8xzxsL364mKLJwqZ7TbOwim/kbLR99bdPYx2VZmBzSccQEQYOjcIt0/Pvj0BGUoGkr10tMQwIVy44ZWjsqGWdJ/YcpRFgCW2ADK7dnvvMwaS6JrAhFmkAXZfBx7IlnYnGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nl4oqzv2; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5449432a9d7so4046445e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758064178; x=1758668978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZoWPSr5f5pxAJKEGF4VF+yUZq/h9CKKdkAf/iFmmuY=;
        b=Nl4oqzv2N5mWi8j6805wLEAxM9/PCL/LZ3I9E7yklARuYoHCiO1YFQJXZ2Vb6tcKyD
         SiGyNfYS2JxsCVhZkppyLMglLE2HJL2t+LdH6cb0LFaGk6+IDHgBv3AmUrwGWw4OVU9p
         O6NFFw+Z3jbAMTR/DN0aKz8NMuJ1U739o7rxpWGvB+ty/NDK/Yubw6T+GIqYKdTm79/b
         6aDBSxzNKtjkEtoXVkN0ck6mNUxaj2fSCbSQTyr6vx7ERXB/DlMy9Mf2RJKADOh0HmqT
         sVSVULmmKFE1WqNQy9AfoBPWmQWcIpiqXdxe+555FNrkOLYGHs7hBPYmiaL6yau0uivT
         uwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758064178; x=1758668978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZoWPSr5f5pxAJKEGF4VF+yUZq/h9CKKdkAf/iFmmuY=;
        b=rIdNKDKrF+B17KXa2/5wZRljfwkyZvIoA+PYC8BlcDKBOQgY7yFNCfvpoJF4tA69Y+
         kJZoSIqo1wwRo5awgZKnn8+/I0Qqx8lvRSaNIDYCSHE2WJgsjrIY3Y9bSxNRn+CV9prd
         vGH+VFWsjOmPplt0FNuQCSRv7R6Mo1PjOeE9BLzTHu8XKzcpGOXaw0EDbZeS4jRA8sR5
         dome/TfdCMxhqH/giLvPUE1MWsM4UjifguZbQvL3AQXKuAQRwn0I9iHAMBf4tClY2s8u
         87vpvt3lJ2g71h031htbhrkz0ByMOArsxxR2SKhtKAUZHEUV/Tv6egVrG0pt3mP+55Hu
         wrDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5u0BftwLMGf11JkapPixLb4Dr99JIaxr7tizUQez/UkpY9KYQsAsmQX++bU1BdrlhbaqbAOV1/pXXUGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YynDiFAiZkoHKCGLVifu9TlkhsonTdxnWOMYzMhj08yqfhhmO7S
	YBuSARnHLUPReuQLIMWm08ir5qWP1sV1OyhuDotzA8NnfW0cU0ucQhowY46S/WxGjqCGcrPo2SH
	cxkTNYnWzxBD4zETgYWEXjtaxgny1Q4s=
X-Gm-Gg: ASbGncsUEY08h5wrQP9mLlZbKJcvjwTRmKDUoJ9AX8LvOkMSAidmvFE7g9wgiPEkG0I
	8FTUpP+9OJhZTF39tWSnEPP7uVbzCztcvv1C13BEMh809kcSpEph4Ji89jEOxEQRVDgYROUZ4/e
	LEr0tikn371Oy5qk6k2QYc31h83Fv+QDMpQf668tpi5s4nUvX9SI5xTHSVRXIz8Si0hD7AoF1/b
	onXX47R6QTkJUn3U/ExkA9cVbUvWE+CyF3pC8jKzv4Nk4lLzrp5
X-Google-Smtp-Source: AGHT+IFH4dLKUMqa34fjb7j6T5CwS42y15aQ209a+zQSgeA70wSL2jbR4X0awUWxCCck1q1twgB/TcPSg/vrP+5Dojc=
X-Received: by 2002:a05:6122:16a8:b0:544:754e:a51f with SMTP id
 71dfb90a1353d-54a60b94058mr70697e0c.11.1758064178419; Tue, 16 Sep 2025
 16:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160100.31545-1-ryncsn@gmail.com> <20250916160100.31545-2-ryncsn@gmail.com>
 <CAGsJ_4w2GqGj8HZMfwndsWu7qkORqsnaw9WwhmQS=pW4gR7nEA@mail.gmail.com> <CAF8kJuNbUyDWcJ13ZLi-xsiYcbY30w7=cFs7wdxszkc7TC4K2Q@mail.gmail.com>
In-Reply-To: <CAF8kJuNbUyDWcJ13ZLi-xsiYcbY30w7=cFs7wdxszkc7TC4K2Q@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 17 Sep 2025 07:09:27 +0800
X-Gm-Features: AS18NWBpp6Do-OXSJCLFlf8g1JUBc_W37C6J4z5CgCnsoFNYj4_QvYdIiMAeazc
Message-ID: <CAGsJ_4wKWem-STYAnh_0EgSFKzzs1M1c7wz6K82wLt6T6JEw9A@mail.gmail.com>
Subject: Re: [PATCH v4 01/15] docs/mm: add document for swap table
To: Chris Li <chrisl@kernel.org>
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

On Wed, Sep 17, 2025 at 6:42=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Tue, Sep 16, 2025 at 3:00=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Wed, Sep 17, 2025 at 12:01=E2=80=AFAM Kairui Song <ryncsn@gmail.com>=
 wrote:
> > >
> > > From: Chris Li <chrisl@kernel.org>
> > >
> > > Swap table is the new swap cache.
> > >
> > > Signed-off-by: Chris Li <chrisl@kernel.org>
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > ---
> > >  Documentation/mm/index.rst      |  1 +
> > >  Documentation/mm/swap-table.rst | 72 +++++++++++++++++++++++++++++++=
++
> > >  MAINTAINERS                     |  1 +
> > >  3 files changed, 74 insertions(+)
> > >  create mode 100644 Documentation/mm/swap-table.rst
> > >
> > > diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
> > > index fb45acba16ac..828ad9b019b3 100644
> > > --- a/Documentation/mm/index.rst
> > > +++ b/Documentation/mm/index.rst
> > > @@ -57,6 +57,7 @@ documentation, or deleted if it has served its purp=
ose.
> > >     page_table_check
> > >     remap_file_pages
> > >     split_page_table_lock
> > > +   swap-table
> > >     transhuge
> > >     unevictable-lru
> > >     vmalloced-kernel-stacks
> > > diff --git a/Documentation/mm/swap-table.rst b/Documentation/mm/swap-=
table.rst
> > > new file mode 100644
> > > index 000000000000..acae6ceb4f7b
> > > --- /dev/null
> > > +++ b/Documentation/mm/swap-table.rst
> > > @@ -0,0 +1,72 @@
> > > +.. SPDX-License-Identifier: GPL-2.0
> > > +
> > > +:Author: Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.c=
om>
> > > +
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +Swap Table
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +Swap table implements swap cache as a per-cluster swap cache value a=
rray.
> > > +
> > > +Swap Entry
> > > +----------
> > > +
> > > +A swap entry contains the information required to serve the anonymou=
s page
> > > +fault.
> > > +
> > > +Swap entry is encoded as two parts: swap type and swap offset.
> > > +
> > > +The swap type indicates which swap device to use.
> > > +The swap offset is the offset of the swap file to read the page data=
 from.
> > > +
> > > +Swap Cache
> > > +----------
> > > +
> > > +Swap cache is a map to look up folios using swap entry as the key. T=
he result
> > > +value can have three possible types depending on which stage of this=
 swap entry
> > > +was in.
> > > +
> > > +1. NULL: This swap entry is not used.
> > > +
> > > +2. folio: A folio has been allocated and bound to this swap entry. T=
his is
> > > +   the transient state of swap out or swap in. The folio data can be=
 in
> > > +   the folio or swap file, or both.
> >
> > This doesn=E2=80=99t look quite right.
> >
> > the folio=E2=80=99s data must reside within the folio itself?
>
> For swap out cases that is true. The swap in case you allocate the
> folio first then read data from swap file to folio. There is a window
> swap file that has the data and folio does not.
>
> > The data might also be in a swap file, or not.
>
> The data only in swap file is covered by "data can be in the folio or
> swap file", it is an OR relationship.
>
> I think my previous statement still stands correct considering both
> swap out and swap in. Of course there is always room for improvement
> to make it more clear. But folio always has the data is not true for
> swap in. If you have other ways to improve it, please feel free to
> suggest.

I assume you=E2=80=99re referring to the swapin case where a folio has been
allocated and added to the swap cache, but it=E2=80=99s still being read an=
d
hasn=E2=80=99t been updated yet?

I assume it could be something like:
The data may be in the folio or will be placed there later. It could
also reside in the swap file.

Alternatively, leave it unchanged.

>
>
> > On a 32-bit system, I=E2=80=99m guessing the swap table is 2 KB, which =
is about
> > half of a page?
>
> Yes, true. I consider that but decide to leave it out of the document.
> There are a lot of other implementation details the document does not
> cover, not just this aspect. This document provides a simple
> abstracted view (might not cover all the detail cases). One way to
> address that is add a qualification "on a 64 bit system". What do you
> say? I don't want to talk about the 32 bit system having half of a
> page in this document, I consider that too much detail. The 32 bit
> system is pretty rare nowadays.

I=E2=80=99d prefer that we remove all descriptions about matching PAGE_SIZE=
,
since we would need to double-check every case, like 16 KB or 64 KB pages.

For ARM64 with a 16 KB page size, the last-level index uses 24:14.
For ARM64 with a 64 KB page size, it uses 28:16[1]. For them, 512 entries
are not one PAGE.

[1] https://developer.arm.com/documentation/101811/0104/Translation-granule

Thanks
Barry


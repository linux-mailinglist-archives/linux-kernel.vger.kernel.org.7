Return-Path: <linux-kernel+bounces-819763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4161B7E6E1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145FF460FEB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794AA2D0C69;
	Tue, 16 Sep 2025 23:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yzbj9kE+"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24207246BA9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 23:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066492; cv=none; b=hZNaiI89fDffCuYD/lRzSm/TJjDDs+d07G52ICfu6kAhtdBNRDt8XzNij1PfhMSyupycH/EcDSJWUy73M5WbjQI9t3jdRCsFUVnBYperPKQqUu2wyzn6iyS8UPa+gsNwN6vw2EDaqwJf/vzvc68SGjkF9QU07xoLCpXRHv/oVn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066492; c=relaxed/simple;
	bh=AX2Uhe2shIBkYU8CsbbK5nYq6dNzTDggl7Aa2/+nUuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gp6stHiJv8W/iy70TBDy+ndsK6TLuiIlTbahLjEdX3sPpqfX5DaWry9Ahjy+0SRVDgrM3OoRwU9lw+K3pcu+EqKhkV/YvHbnU8de9emHjQhRAgKaRtDTz5aG+kXzhOWEHxyvQg7qnp8cktipeADiie794XVPe/WaJybdSFTtdg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yzbj9kE+; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-8e286a1afc6so273331241.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066489; x=1758671289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AX2Uhe2shIBkYU8CsbbK5nYq6dNzTDggl7Aa2/+nUuQ=;
        b=Yzbj9kE+sjDFMV0vyC1u5d2pq5NNHEpYtqUQk/Wpbg0y0q/5/kTaWZj80tLE5jagEv
         vVe9ySHbBKVWyuiipNZXv7Lkcs6FPV4OYKE8w2FskuVkbg+/Ov6lKsRlragZ8vVz/vQk
         eRnt5TmmnrbTc2YlgEO606x05vbj56fFHyJ1cgSPjBR5uXJUVMzdEiMejwpaO3mAHbJS
         wqRBn78IgEAo57Bf8pjH0qeUKvZPmrolaK7mnTZePDN60sNOu0yWfAzESgef4dn01h/6
         Wcn/5TtwThjlv1+ftXZRiSm0NxpQWdX4yeSJmN4hS5jI2i0uPgvRGKQ8zQckfQF32hGU
         GTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066489; x=1758671289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AX2Uhe2shIBkYU8CsbbK5nYq6dNzTDggl7Aa2/+nUuQ=;
        b=lJkr9CQiLKsMn4PBEidXcBi7ZdycGsl/BKE4lLGaZ/xL8FRbO8tov88Bd1aJ1i8Qab
         YAyehhxB9AogreQkxqGtZV0MDczxSwPnOgmURnbZlOSlpG2FO5jv+74UbkLeN8xJ3iRx
         fTUfIo06XaYLCX1jJFj0oV7uZ5LN92VocxMMORLXH8HDNt1Xi8Gj9zsUy/be9evP6rXV
         xTvX1zRsdBNKCAE9gCD+ybv4Vb1PZ8m8ikDFreUw+SU0Em/vtvQIoIZaklA6EaI+Z+cw
         9JNNXXFMaQHLx9B+6NbDlmRGDLOhzEkC3AVNpAHqxnYJilNSdZ9zQrIKz+Vlmf8PC6Ne
         WQvg==
X-Forwarded-Encrypted: i=1; AJvYcCVp/533SBKwY82XC3y8OMNB0G7I4NDLio7kfPAXGLR0cmSwCgSiKSDL/qbLTJW5eH6r/PFrm2TeksZczsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH/V7789fB7eaIhu8SKQQQx3+cw4IaSFk6RLAEtsEOjljy8Sm/
	mGYOVDVQTxyEbpXfzKuGffoQcskcRzM3bNV/0c9j1PbNXJx7SogGt4+xAFUAB6rns15SUu6Bb3w
	EiPCD7gfHw6D22wQ7SU5zw0GiaUWDQbk=
X-Gm-Gg: ASbGnctHteJWac5GDB74mU3VneXOOfRh3lVVaQ5gjeMHuRqTYhsYECt4cAJRd2DxSwr
	DLw0gLI7MFB5M5X25OonRXD64XqLuW01nITPjlcYqT+/4Nmy2mMo9ucZsdJB+vUA07pb0g+pp63
	nXGPR20uUwR2/9IafeJFOKcRQg5/hKpuygO7SAOCqudX7I2WH0v0Sw/7Lgxk9g8bVK8rcgmClsl
	XG1Up5ZUp8XWtWCK0kPZ+B95ItTEOdie/1wussyPA==
X-Google-Smtp-Source: AGHT+IE+A5eH4A9XbrcV6L3/iogkJLV7v3HZJWYSYnyfskZz0vpYrpSeiq5AxvLwi2VwAg9k/O0XILXcjesfeyLPwWU=
X-Received: by 2002:a05:6102:5345:b0:4e2:a235:24d1 with SMTP id
 ada2fe7eead31-56d77a41f0cmr59406137.4.1758066489375; Tue, 16 Sep 2025
 16:48:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160100.31545-1-ryncsn@gmail.com> <20250916160100.31545-2-ryncsn@gmail.com>
 <CAGsJ_4w2GqGj8HZMfwndsWu7qkORqsnaw9WwhmQS=pW4gR7nEA@mail.gmail.com>
 <CAF8kJuNbUyDWcJ13ZLi-xsiYcbY30w7=cFs7wdxszkc7TC4K2Q@mail.gmail.com>
 <CAGsJ_4wKWem-STYAnh_0EgSFKzzs1M1c7wz6K82wLt6T6JEw9A@mail.gmail.com> <CACePvbU8cUs-wwPsXkZ24EWga5bXxxUGSCT18rKAWFYn5w9rpw@mail.gmail.com>
In-Reply-To: <CACePvbU8cUs-wwPsXkZ24EWga5bXxxUGSCT18rKAWFYn5w9rpw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 17 Sep 2025 07:47:57 +0800
X-Gm-Features: AS18NWDx8V6TSFDsmNKOJekO1Fe4wrTlWrhxUHp7P6KzNek6fCA9KPdH7ss8W_I
Message-ID: <CAGsJ_4yhDU_WVfEybDhGE-WF5+w-fak1-F8jqbAQ-Qw1+qWkaw@mail.gmail.com>
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

On Wed, Sep 17, 2025 at 7:29=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Tue, Sep 16, 2025 at 4:09=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> > > I think my previous statement still stands correct considering both
> > > swap out and swap in. Of course there is always room for improvement
> > > to make it more clear. But folio always has the data is not true for
> > > swap in. If you have other ways to improve it, please feel free to
> > > suggest.
> >
> > I assume you=E2=80=99re referring to the swapin case where a folio has =
been
> > allocated and added to the swap cache, but it=E2=80=99s still being rea=
d and
> > hasn=E2=80=99t been updated yet?
>
> Right. That is the case swapfile has the data and folio does not.
>
> >
> > I assume it could be something like:
> > The data may be in the folio or will be placed there later. It could
> This is for swap in only, does not describe the swap out case.
>
> > also reside in the swap file.
>
> Right and it did not have the same coverage about data that can be
> both in the folio and swapfile. Sorry about the pedantic. If we want
> to improve it, we might want to cover the same level of detail.
>
> > Alternatively, leave it unchanged.
> I think considering the swap out and swap in case, the original is
> fine. The reader will need to make some effort to map to what it does
> in the code, at least the description is correct.

Ok.

>
> >
> > >
> > >
> > > > On a 32-bit system, I=E2=80=99m guessing the swap table is 2 KB, wh=
ich is about
> > > > half of a page?
> > >
> > > Yes, true. I consider that but decide to leave it out of the document=
.
> > > There are a lot of other implementation details the document does not
> > > cover, not just this aspect. This document provides a simple
> > > abstracted view (might not cover all the detail cases). One way to
> > > address that is add a qualification "on a 64 bit system". What do you
> > > say? I don't want to talk about the 32 bit system having half of a
> > > page in this document, I consider that too much detail. The 32 bit
> > > system is pretty rare nowadays.
> >
> > I=E2=80=99d prefer that we remove all descriptions about matching PAGE_=
SIZE,
>
> I am fine with that as well.
>
> > since we would need to double-check every case, like 16 KB or 64 KB pag=
es.
>
> The cluster size is determined by the last to second level page table
> page size. I fail to see why 16KB matters here for the cluster. Are
> you saying in the 16KB page size case, the custer size is 512/4 =3D 128
> swap entry per cluster?
>
> > For ARM64 with a 16 KB page size, the last-level index uses 24:14.
> > For ARM64 with a 64 KB page size, it uses 28:16[1]. For them, 512 entri=
es
> > are not one PAGE.
>
> Now you got me curioused.
>
> In your above two examples, what is the respected swap cluster swap entry=
 size?
> In other words, how much entry does one swap cluster hold?
>
> Sorry I am not very familiar with the ARM page tables.

Oh, my mistake=E2=80=94I recalculated:

For a 16 KB page size, SWAPCLUSTER_SIZE will be 2^11 =3D 2048, so the swap
table is 2048 * 8 =3D 16 KB.
For a 64 KB page size, SWAPCLUSTER_SIZE will be 2^13 =3D 8192, so the swap
table is 8192 * 8 =3D 64 KB.

This approach still seems to work, so the 32-bit system appears to be
the only exception. However, I=E2=80=99m not entirely sure that your descri=
ption
of =E2=80=9Cthe second last level=E2=80=9D is correct. I believe it refers =
to the PTE,
which corresponds to the last level, not the second-to-last.
In other words, how do you define the second-to-last level page table?

Thanks
Barry


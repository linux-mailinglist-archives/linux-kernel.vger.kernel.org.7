Return-Path: <linux-kernel+bounces-819734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08827B7D807
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D2D324CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202D52EFDBA;
	Tue, 16 Sep 2025 23:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSH/P5vr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749E41B394F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 23:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065341; cv=none; b=Qvhx6ashkMda2zB2TDIiqHgg9fp7Co/FpYsDOW2ih4wlZ6Rve0LuhtdUU2/eTfsc2yEKycDRLVvnoSgTHKgvTGvP2gVQMX4b8Iz1N9n6yFnAna1FKnHvvwTGfRp7MPuYWCQKjnTUZTeDskrnW/1b97PqCmZp1qv4+F7oW+74PbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065341; c=relaxed/simple;
	bh=LGvykd1nT8oriIHpNmzR+OSQDJaKsFdiiA4ZAshy8xM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FEyDdpzwd1IC7K3yLblg4X7ch1Lp61USV/tP3fKQwon8u4ro+mkihuljgBuD8fLXKvbWGhcoKUFcHYQud/Ylfis8cRJy9Vlt/of5I/7gHp3L3Em5reeLHSy3eu+F+bjyinUBn03oCzdj4F5XorCfOmTU3YK5Be3PlAwCwhO214o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSH/P5vr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037B5C4CEEB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 23:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758065341;
	bh=LGvykd1nT8oriIHpNmzR+OSQDJaKsFdiiA4ZAshy8xM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YSH/P5vrx8CKIXAvy/xTBRiRAVNmMdR+OCHwSGi4G0vl/AI7y9/IRaKALqjvLlEMC
	 djUAnQxCg09Xq3C9p+iZ23fXMiuQqEe48LjSeoBgN3ku6HojFPrV3LLsyjFp6W5OmA
	 XS/dYglm4VWX1vmHYiuO1EX0U+FJk10RdGJiEo9AZLLt+smfKCQrx91jrDY7SgL3Ib
	 uMngR1E9dF933xwHG2I0PymwolYgm0MHGa9njkjvrC83+031Al2Loi319WVNNslji3
	 J9uaZKM5j/rBKpUslLu3NjKt+GbOVpY7FpDDN3r+/tXIx4301fKPHOBnTDNdlqWJqN
	 CujrOZbTRqOBA==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d603b674aso41736307b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:29:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGVS+9szRUUthC4rjtVpGuL+iVkpKk8j7FbLZSG5G9SfIPLVsmWtuMSIs3cuFQXxzXkRA0YXt5l1E/DF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd+XgbNsMyzaFj8k8xH0FFVZR93JD99Q1C66giMqtQj9Sf3ji8
	c+toQfc0bATY6RsDEuoiv2Z4erqygujcgEVTSKeAD1Z5NJC2ebIwb5w+qgE2HRPlYcSuSGYIcBY
	nghgkosX+tNKu8kdqHNT/d8ua9o4NYysgcpJ9HyvPLQ==
X-Google-Smtp-Source: AGHT+IGij916d5sP85+tuss02Upn/245YaMM5bz3jwhN4dO54AsUWUls4eLhNMOciKeNZilYYN0w64QPz6dGBbFqQpU=
X-Received: by 2002:a05:690c:600e:b0:723:92c4:beeb with SMTP id
 00721157ae682-73892a629e7mr597217b3.40.1758065340338; Tue, 16 Sep 2025
 16:29:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160100.31545-1-ryncsn@gmail.com> <20250916160100.31545-2-ryncsn@gmail.com>
 <CAGsJ_4w2GqGj8HZMfwndsWu7qkORqsnaw9WwhmQS=pW4gR7nEA@mail.gmail.com>
 <CAF8kJuNbUyDWcJ13ZLi-xsiYcbY30w7=cFs7wdxszkc7TC4K2Q@mail.gmail.com> <CAGsJ_4wKWem-STYAnh_0EgSFKzzs1M1c7wz6K82wLt6T6JEw9A@mail.gmail.com>
In-Reply-To: <CAGsJ_4wKWem-STYAnh_0EgSFKzzs1M1c7wz6K82wLt6T6JEw9A@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 16 Sep 2025 16:28:49 -0700
X-Gmail-Original-Message-ID: <CACePvbU8cUs-wwPsXkZ24EWga5bXxxUGSCT18rKAWFYn5w9rpw@mail.gmail.com>
X-Gm-Features: AS18NWDaf018NL2Ds7liDcEY9OWYh3Bgw6P4zsvyeNjVw4_3JGi9egdPzhgDInI
Message-ID: <CACePvbU8cUs-wwPsXkZ24EWga5bXxxUGSCT18rKAWFYn5w9rpw@mail.gmail.com>
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

On Tue, Sep 16, 2025 at 4:09=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
> > I think my previous statement still stands correct considering both
> > swap out and swap in. Of course there is always room for improvement
> > to make it more clear. But folio always has the data is not true for
> > swap in. If you have other ways to improve it, please feel free to
> > suggest.
>
> I assume you=E2=80=99re referring to the swapin case where a folio has be=
en
> allocated and added to the swap cache, but it=E2=80=99s still being read =
and
> hasn=E2=80=99t been updated yet?

Right. That is the case swapfile has the data and folio does not.

>
> I assume it could be something like:
> The data may be in the folio or will be placed there later. It could
This is for swap in only, does not describe the swap out case.

> also reside in the swap file.

Right and it did not have the same coverage about data that can be
both in the folio and swapfile. Sorry about the pedantic. If we want
to improve it, we might want to cover the same level of detail.

> Alternatively, leave it unchanged.
I think considering the swap out and swap in case, the original is
fine. The reader will need to make some effort to map to what it does
in the code, at least the description is correct.

>
> >
> >
> > > On a 32-bit system, I=E2=80=99m guessing the swap table is 2 KB, whic=
h is about
> > > half of a page?
> >
> > Yes, true. I consider that but decide to leave it out of the document.
> > There are a lot of other implementation details the document does not
> > cover, not just this aspect. This document provides a simple
> > abstracted view (might not cover all the detail cases). One way to
> > address that is add a qualification "on a 64 bit system". What do you
> > say? I don't want to talk about the 32 bit system having half of a
> > page in this document, I consider that too much detail. The 32 bit
> > system is pretty rare nowadays.
>
> I=E2=80=99d prefer that we remove all descriptions about matching PAGE_SI=
ZE,

I am fine with that as well.

> since we would need to double-check every case, like 16 KB or 64 KB pages=
.

The cluster size is determined by the last to second level page table
page size. I fail to see why 16KB matters here for the cluster. Are
you saying in the 16KB page size case, the custer size is 512/4 =3D 128
swap entry per cluster?

> For ARM64 with a 16 KB page size, the last-level index uses 24:14.
> For ARM64 with a 64 KB page size, it uses 28:16[1]. For them, 512 entries
> are not one PAGE.

Now you got me curioused.

In your above two examples, what is the respected swap cluster swap entry s=
ize?
In other words, how much entry does one swap cluster hold?

Sorry I am not very familiar with the ARM page tables.

Chris


Return-Path: <linux-kernel+bounces-788864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1F2B38B44
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 23:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F721C2185B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A2D2C2377;
	Wed, 27 Aug 2025 21:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGtQFa50"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F17C149C6F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 21:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756329410; cv=none; b=VQV1E2StPobGT6QvNRXoKqY0T5boiFDQy1EwtekpxfbeVf9FgE7z8zantQMWMUEZp4Z9PZAtIcTA/DHV6trRLoSx1yO+KR0Kl9Byf59siM3n7crhLM9FaJ4dWqgbPfQpb4JeQF5KkOg5YlOCwpVODZOwKk9WifP8Ki0EAV4xKSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756329410; c=relaxed/simple;
	bh=h2vwcYvB52wM6p8rPx+g4cI7a/giRHNuNaRI6L0ndwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVCKdIChz6IEEaCtISGpmlMdg8+QnKJztzlsqCsNXd0WrqpVsgLCBFGZhi9X3ZYPSJc/RD71WVq8UZIptpmEU0g37pnv9li6ixj7RbhhAc74ij07LtC+DAOUhdplIXF9X4nztwo8IJRTcxtIBP30HKuLd39B8WoGM3Ufetv4fCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGtQFa50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3883C4CEFF
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 21:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756329409;
	bh=h2vwcYvB52wM6p8rPx+g4cI7a/giRHNuNaRI6L0ndwg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NGtQFa50GgZfyUt2ZuklQdFNsYfU7Ys+pBXZw8rBRW1zV9/d+vb8cykG3SNhiz1ju
	 ntwrf/VUpSNZTYkw+edjpYah9yvLRRDK/+Q0pfk/KjsYptsiGmDdMOKGKytBlYH79B
	 idZv06zyv/gxjGjsMVGWdKkmFtx75Uuf+3v6UxjKAKBsaZyGYOGeS/qQjvs/aA8cg6
	 nslq5b5+CYWVk5khPQ3gcCLPMIHBrk8zcdtCNL55XL2aFJDq8gocRgru5Gv0folsVb
	 IlzJyV7zVvZGG8zVIGs0jbuLdPOHgyYH9mg+RqBhcW/O8uY6NRNeSEZIaeozATIKO4
	 VBAdq/fSgfpCA==
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e96e892081eso159389276.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 14:16:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW1f+7vbIB6MHbAsjK6maKxGiC32yte734moylc/HwIbjOV9lBHu4gl3i3P6Ijwt8jDq0Ud5gYiGOx2UR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYSZO7I+6HGBBSN6cfO4yhqhzZEshU6B4HRB50nR5kNFH6uwwM
	QG20s9FLCD9R5XECnfn4x11EK1uhf5xb3tzuvKBGy1+9m2y/etI8GGiFEhGXyebETlpaSQGtb6B
	isH3RhGnkNiWuB4jaFpU8GmqIHg0acTZhkx3bm51hyw==
X-Google-Smtp-Source: AGHT+IFExBNFXHaK1D9PX+y6rV6yrbQyNeRcW17eknQkn390Bdly6Ur/L2Q/PGdRn8kWIwZ+xuAQ6TWixh5N9DqDn2s=
X-Received: by 2002:a05:690c:3345:b0:71f:b944:104f with SMTP id
 00721157ae682-71fdc568115mr250305367b3.50.1756329409097; Wed, 27 Aug 2025
 14:16:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACePvbWzyqJJxP8BFXS_NDLcXCz-YXkt8eYBxv3CER9RpnJVXA@mail.gmail.com>
 <20250827174513.47171-1-sj@kernel.org>
In-Reply-To: <20250827174513.47171-1-sj@kernel.org>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 27 Aug 2025 14:16:37 -0700
X-Gmail-Original-Message-ID: <CACePvbXnaWZh61aH=BHoGDqbKvBSE52Me+PpE-WMXcGpRy0FFw@mail.gmail.com>
X-Gm-Features: Ac12FXxDZkGQigQMPqlJ2_x7uvW4YhEBBCZKu1uKYoU3sLqFVC_3DHYznctEp38
Message-ID: <CACePvbXnaWZh61aH=BHoGDqbKvBSE52Me+PpE-WMXcGpRy0FFw@mail.gmail.com>
Subject: Re: [PATCH v5] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Takero Funaki <flintglass@gmail.com>, David Hildenbrand <david@redhat.com>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 10:45=E2=80=AFAM SeongJae Park <sj@kernel.org> wrot=
e:
> > > >
> > > > On Fri, Aug 22, 2025 at 12:08=E2=80=AFPM SeongJae Park <sj@kernel.o=
rg> wrote:
> [...]
> > > """
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -952,6 +952,7 @@ static bool zswap_compress(struct page *page, str=
uct zswap_entry *entry,
> > >         struct zpool *zpool;
> > >         gfp_t gfp;
> > >         u8 *dst;
> > > +       bool dst_need_unmap =3D false;
> >
> > A bit nitpicky. That variable name is too long as a C local variable.
> > We want local auto variables to be short and sweet. That is why you
> > have "dst" rather than  "u8 *destination_compressed_buffer;"
> > The local variable name is too long and it can hurt the reading as well=
.
> > Can we have something shorter? e.g. "mapped" or "has_map"
>
> I agree your points, and thank you for suggestions.  I will take "mapped"=
.

Thank you.

> > > We may also need to initialize 'dlen' as PAGE_SIZE ?
> >
> > If there is a code path can lead to dlen use not initialized value? If
> > not then we don't have to assign it.
>
> The success return path of zswap_decompress() checks dlen together with
> decomp_ret as below.  So I think we need to initialize dlen, too.  Please=
 let
> me know if I'm missing something.

I normally don't worry about those, the compiler will complain if I
get it wrong. The compiler might have false positives, but should not
have false negatives because the compiler can see all the incoming
edges of the basic block. It is a trivial graph reachability problem
if we allow false positives reports.

Anyway, I just opened the editor to check again. Yes, if we goto the
read_done, the if condition using dlen can introduce a new incoming
edge that has len uninitialized value to be used. Yes, need to
initialize dlen =3D=3D PAGE_SIZE or you initialize it at the memcpy of
page.

> I will post the fixup by tomorrow morning (Pacific time) unless I
> hear other opinions or find my mistakes on the above plan by tonight.

You are too humble, that is the normal reviewing process. You can take
your time.

Chris


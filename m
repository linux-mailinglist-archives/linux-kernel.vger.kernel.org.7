Return-Path: <linux-kernel+bounces-745373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1877B11907
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575F5AE1061
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC63291C2F;
	Fri, 25 Jul 2025 07:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k3sRP6/o"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C021A291C19
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753427662; cv=none; b=VCteYftb0x1krbFUiWcuK8j4q30w9Ob7J2H+T43q5GI5VWhjMMIW/+igrcC+akY31Vp+4zpZS3OcYoZl0iGpMgO0hP9A7E/qYSWv1cXwUEHP/T8ImSZAxQXve8Ua2QhRnqi41FNLErhMnxGTxez/PJSmimDZUlYGLY3fL+HJKnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753427662; c=relaxed/simple;
	bh=E4YkhBRj1KR+XPLrBsHY5EKKqoJslsa67oYsFvhdDew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZJbvW3yISWqkyrD/Op/IBmOpuqd5sCWbHARhX4FVwQkDv4Ol1cExX+7L1wixDDBXXNUr1cYdd2jzQQj4cvemoB1+mgTwoTSBJwb+tuT8ruqrK6977zxeIrQWEu4ADBrB8lCw9XoQniTxAjaPylN520X4W5YZ3JThptDsGLnRF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k3sRP6/o; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45618ddd62fso18946375e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 00:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753427659; x=1754032459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9vHt5UXfKsv8YlchEcAgj1SPpwPqe3D7/osin4AnlY=;
        b=k3sRP6/obyvGWLd1Q6AGosndkTETfz2sdSF9CwFmyWN4t32775cHEFo6BbmKP3fnxD
         dAQYD9VanTxwHMfpXUn0Ka0geZR02cYfev94PBTxi48cm/IvhWXGJvqL4FRCSIksBHLz
         qILty51Crjf+Qh3utq2DD+evidx1hhgbYrduJjS9So+jYobpMCfl+KXQwu/M1LqMyd13
         7gJGGnHVvAtEyWG2Dc8Xtg/TRkxHWAoXnvFXPtOjjjyHresfFCiCzFAXZcpM1OotWS6I
         K3ArcUG21yRE4KrTknqgvduRuY0iIBymDThHAXPcC541gwvRulLRAvJSonpsr7NkTr4v
         Kg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753427659; x=1754032459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9vHt5UXfKsv8YlchEcAgj1SPpwPqe3D7/osin4AnlY=;
        b=na1foem2HtSVSPQK7uOHhobmDz4SA8nk0I7193HNRztwymReR5kYIdvMOQ86medpnw
         z5OpqquDpGGY+hW3xtMSEtsi7es2CmjyxcFGv4VaGlfdE4/Oa4TashLB111turji2XGm
         OdwkUqsTxtRYN68Jj1ARit60urkU0HjXzhsDuHGj7NXckvrseR9NYpE4xk8auHoBdRAP
         mhCpaVx11YNHuN0kaBoeTviG8I6XL+7chhsVxIN0tG4kNouzjf6BfOlkaP4M5FoZ1Q2C
         T/qravqd9LYwTdScnrA+jPxxJ0sDX5DeP6R83wJyjp075YAT7fZ/7C8dif89abS480C3
         EsLA==
X-Forwarded-Encrypted: i=1; AJvYcCWS7botkTrcxkMcYqQEcw+5oh8fhMaIOGArI1ald9k5J0QKjdGRQ2+5yIsIsxSj4+sADyKuGiPBg0H2q8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrJtw54RJ8T/+wrTY32kli2h2OlP7vulTjlG9C+MmbRDvotVhU
	2NXmCJpaL7O4E3ecqd1NcRofqiyXL3vgzHUz5gc8qH0gU+ghsCVvh7nOhHvsV2enHjDhaymyZMU
	ropc2CiaUZdVbCc3Vu47P29tZQgycXJdePI3WxVOD
X-Gm-Gg: ASbGncsfB+2YQHHJ1fC0OtNuI7w3/QHrgh6oIbOE6MYX7bm1EBunSWWCJ++81h25KlY
	eBQv2h8aEYOg2QtWa3ujn7DiP86fZf9WoZxpVluFzmnSaoeDzeq6GurTRs0hGRz0ivem5HqF2H/
	KeC8DHrMTi9ahtVpnEif15PwbIJ6dUEyDOlE6HwSPxg/e9vS1Sa5Bs1XUyeePAJ/yIh8E1aCtv5
	SYDOdhZ/3CiRpi77QfowMy641pAsHkRZlLiNUPU5/I9uMk+
X-Google-Smtp-Source: AGHT+IE4kl/WAV/DJhHC0LW0odI/joljZCgor1iGezxfvCxEn51uKapoKTZqJK2GZ/JKTo8UOtRjEV7yfpgZ91zr4FI=
X-Received: by 2002:a05:600c:4f07:b0:456:58:1114 with SMTP id
 5b1f17b1804b1-45877447996mr3587685e9.9.1753427658863; Fri, 25 Jul 2025
 00:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715135645.2230065-1-vitaly.wool@konsulko.se> <20250724135449.2cb6457b90926cce1b903481@linux-foundation.org>
In-Reply-To: <20250724135449.2cb6457b90926cce1b903481@linux-foundation.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 25 Jul 2025 09:14:05 +0200
X-Gm-Features: Ac12FXy3-hBwFSqnBK583mYkueFJy_LL2mllk3DPkZ3jUCXGxkbYOdiRiOuntB4
Message-ID: <CAH5fLgjatYenX_xPvRW11BnRw1wP_G19eY-7AqUctnuZ3rGBYA@mail.gmail.com>
Subject: Re: [PATCH v13 0/4] support large align and nid in Rust allocators
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vitaly Wool <vitaly.wool@konsulko.se>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, rust-for-linux@vger.kernel.org, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org, 
	bpf@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 10:54=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Tue, 15 Jul 2025 15:56:45 +0200 Vitaly Wool <vitaly.wool@konsulko.se> =
wrote:
>
> > The coming patches provide the ability for Rust allocators to set
> > NUMA node and large alignment.
> >
> > ...
> >
> >  fs/bcachefs/darray.c           |    2 -
> >  fs/bcachefs/util.h             |    2 -
> >  include/linux/bpfptr.h         |    2 -
> >  include/linux/slab.h           |   39 ++++++++++++++++++++++----------=
-----
> >  include/linux/vmalloc.h        |   12 ++++++++---
> >  lib/rhashtable.c               |    4 +--
> >  mm/nommu.c                     |    3 +-
> >  mm/slub.c                      |   64 ++++++++++++++++++++++++++++++++=
+++++++++--------------------
> >  mm/vmalloc.c                   |   29 ++++++++++++++++++++++-----
> >  rust/helpers/slab.c            |   10 +++++----
> >  rust/helpers/vmalloc.c         |    5 ++--
> >  rust/kernel/alloc.rs           |   54 ++++++++++++++++++++++++++++++++=
++++++++++++++-----
> >  rust/kernel/alloc/allocator.rs |   49 +++++++++++++++++++++-----------=
--------------
> >  rust/kernel/alloc/kbox.rs      |    4 +--
> >  rust/kernel/alloc/kvec.rs      |   11 ++++++++--
> >  15 files changed, 200 insertions(+), 90 deletions(-)
>
> I assume we're looking for a merge into mm.git?
>
> We're at -rc7 so let's target 6.17.  Please resend around the end of
> the upcoming merge window?

I think it would make sense for this to land through mm.git, so yes
that sounds like a good plan.

Alice


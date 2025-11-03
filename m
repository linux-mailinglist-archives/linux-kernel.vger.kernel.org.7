Return-Path: <linux-kernel+bounces-883649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C485FC2DFA7
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 21:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76DCC3BDEC9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 20:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5515245014;
	Mon,  3 Nov 2025 20:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QC5uAEl3"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2B172622
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762200244; cv=none; b=tXS+2AoJTeuxy+Vi4Kb6WbUS3PRLtfVAh41c43izEcCpGtpOkpvFzUiTJktRbfdpBIUnXc+6WoYlg8TWzgQLMfz/bDadhbd1NPCpVsVyjZ3lGtp0/4uoOcpZj/WbXoUrYgSAKt8yTuC6eX/eZGVWGUslLxTO2fZIYud7HPidD3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762200244; c=relaxed/simple;
	bh=EimBx6u8pVhXHOt0w84uZZATnisjVkN5HjMA8PjIaTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wqt0p9CgqKb5bJVemF6tS2NTMayvqnzCJG+ERn1uE4d8Vt1ltC6ZBJTXYeevOrlHp8ihahQVDP+oMs3HewDePjqfXD790smF0wPw0YEn8zG73BAreYoKDO6E/HYh07t5RDILYiCjiobXjMOFCPLYZQToNuq8k94ZmqxZsYmAVh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QC5uAEl3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29576941248so1991345ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 12:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762200240; x=1762805040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTsBY+ZblQfJHoe0nK0yZ2Jkez47FzHS1ypWZAhmRjo=;
        b=QC5uAEl3wZuWxgfDeCb44tAPTwwPwzq7LAz25igx69ZGJWeCkYtEno9YNVeZxgBoYN
         PHZDyrxrRIWzsSQnxepZ+17cKu4GfExrmfeqo3g2EOLF09VIW0WmF7A46uIk4tWo9an8
         eG5uXXOAEooD3aAy9XKu47MFN41i9ij7W86kYrUsEoCRMQz4rdjlvfb5NgymHl1WOLJN
         W1FGvSnjVfAm2Z/UwHqzqjsV/T7rSadguyy3YUTUiSGOP9Pv877L8x7Zw1yiFRx+ezrZ
         NPQeMCmkoERggfdJqppO+B8luJWnFHrYqKBVBJDcCnQLHYva1Fffg8rJ3mcNjxFvRUWT
         EuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762200240; x=1762805040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTsBY+ZblQfJHoe0nK0yZ2Jkez47FzHS1ypWZAhmRjo=;
        b=id9OicTJ3aZ2Av6h6WXTWVI5zVPrAclpMkHjak5ljCLi3DP+lFWytCXrNxwNFOpV+U
         69gkSJWcxnsELwW/4z7f63NgjJcbMWOyu7pyFfo0hckPSSPhGNSsJ37UEgyW35snMBoE
         ZaEugm7wEe0ALeEnrq/50zyXmJtehqW6NFb6CQoQrzg+RKV1BPI+QgaAH9RqXdfgT3+0
         /RpPrQO2ZlsxTjlkQCUkqC0dhB+rlfmCXlvSCh0n9m4XK8zi+mDmI3FFsR/erV/PexM1
         kD0qjBq4aUJNVDK2LlX9GaOWS7rVLaGrL6Rp/fOJls7IAYmPUKMwK6Z6N8ZeZfeJm2y2
         JxVA==
X-Forwarded-Encrypted: i=1; AJvYcCWPk3ky1PR/ybjeFJZ3mmCVjiwcKpulWfItykh+ZSxHuOAuA4msmtzCUd/KUPlW2B8Z/6E4IHpICToiKkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza8/BOSfD9r9oSoYJlFSM54Q3OIUGNH6TCNvsAni8CX2NJvAak
	AbqG22cdiyqUNNCMwriBzf9GjrqamwOiW8gG8JC/fzGeP0i7tzdiNPlUSDMVQFJuAkyeSH3M47b
	FkRutcQ3yGhfXrXqitY335vgc5tpFvLIWtkq6ydNnt0iMhHTEaqqXnO8=
X-Gm-Gg: ASbGnct6JsiVQr+aeKW9gURRkeF3FSfcqQNAMaowlS7UZl1o5jrLJ5UyU/0wlrNYW0N
	VXfWGuyP0bQb6QLEJc6B4RU8amxbcBrOJtkvH9+QrTDy9N0YzGAg9c6OUvHXyE92GGz+W9Vka/g
	QT3L//9sRSpPz2wJc13/Ls3N/hshtAmepWJy64fiBA1tYPQjk9WajWCjD9GIpBRpudUoQQkqk4j
	DNnawFpdl54MwylE+hM4INVzi0m6rl3TTUtBWki2V80kfVjjTUQ5m5CIrBs0OTlHKzpZOjIWNQZ
	ffDkFvd/yc/hq8JMxs/pG7mkgd6WO8olk6wxISI=
X-Google-Smtp-Source: AGHT+IE+MJwdTHxUV/03KsqerebJXKaRzuJF6Wl2pnND8KZ3b7dpCKazeXCtQa0ctg+IsC4VccurcR6C5oAoKWwKI20=
X-Received: by 2002:a17:902:d48d:b0:290:bde0:bffa with SMTP id
 d9443c01a7336-2951a36c273mr97647795ad.1.1762200240453; Mon, 03 Nov 2025
 12:04:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015172555.2797238-1-csander@purestorage.com>
In-Reply-To: <20251015172555.2797238-1-csander@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 3 Nov 2025 12:03:49 -0800
X-Gm-Features: AWmQ_bmR1xKRPxzHCcqxg83g0jMYHGS5VpJiMbsgB9ezmv7F7vYqC0JhlQ0hPPk
Message-ID: <CADUfDZq807sZ5ZMeX3adbV70Pjjbn299kTwyADhEiJqcxMO6xA@mail.gmail.com>
Subject: Re: [PATCH] io_uring/memmap: return bool from io_mem_alloc_compound()
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,
Any comments on this minor cleanup?

Thanks,
Caleb

On Wed, Oct 15, 2025 at 10:25=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> io_mem_alloc_compound() returns either ERR_PTR(-ENOMEM) or a virtual
> address for the allocated memory, but its caller just checks whether the
> result is an error. Return a bool success value instead.
>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  io_uring/memmap.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/io_uring/memmap.c b/io_uring/memmap.c
> index 2e99dffddfc5..b53733a54074 100644
> --- a/io_uring/memmap.c
> +++ b/io_uring/memmap.c
> @@ -13,30 +13,30 @@
>  #include "memmap.h"
>  #include "kbuf.h"
>  #include "rsrc.h"
>  #include "zcrx.h"
>
> -static void *io_mem_alloc_compound(struct page **pages, int nr_pages,
> -                                  size_t size, gfp_t gfp)
> +static bool io_mem_alloc_compound(struct page **pages, int nr_pages,
> +                                 size_t size, gfp_t gfp)
>  {
>         struct page *page;
>         int i, order;
>
>         order =3D get_order(size);
>         if (order > MAX_PAGE_ORDER)
> -               return ERR_PTR(-ENOMEM);
> +               return false;
>         else if (order)
>                 gfp |=3D __GFP_COMP;
>
>         page =3D alloc_pages(gfp, order);
>         if (!page)
> -               return ERR_PTR(-ENOMEM);
> +               return false;
>
>         for (i =3D 0; i < nr_pages; i++)
>                 pages[i] =3D page + i;
>
> -       return page_address(page);
> +       return true;
>  }
>
>  struct page **io_pin_pages(unsigned long uaddr, unsigned long len, int *=
npages)
>  {
>         unsigned long start, end, nr_pages;
> @@ -157,18 +157,16 @@ static int io_region_allocate_pages(struct io_ring_=
ctx *ctx,
>  {
>         gfp_t gfp =3D GFP_KERNEL_ACCOUNT | __GFP_ZERO | __GFP_NOWARN;
>         size_t size =3D (size_t) mr->nr_pages << PAGE_SHIFT;
>         unsigned long nr_allocated;
>         struct page **pages;
> -       void *p;
>
>         pages =3D kvmalloc_array(mr->nr_pages, sizeof(*pages), gfp);
>         if (!pages)
>                 return -ENOMEM;
>
> -       p =3D io_mem_alloc_compound(pages, mr->nr_pages, size, gfp);
> -       if (!IS_ERR(p)) {
> +       if (io_mem_alloc_compound(pages, mr->nr_pages, size, gfp)) {
>                 mr->flags |=3D IO_REGION_F_SINGLE_REF;
>                 goto done;
>         }
>
>         nr_allocated =3D alloc_pages_bulk_node(gfp, NUMA_NO_NODE,
> --
> 2.45.2
>


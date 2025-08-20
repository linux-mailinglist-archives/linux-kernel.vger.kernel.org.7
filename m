Return-Path: <linux-kernel+bounces-776935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FC6B2D32A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1771882B38
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 04:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CFA2580ED;
	Wed, 20 Aug 2025 04:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOrzfHuo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0170F220F38
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 04:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755665374; cv=none; b=BxzCmgQ18pvjk6eHVi7s36hNcutUUBzxpViAId+mjg7roOp68HQlIAZxX9k4LY2L9muLCUhbzGqyO+eItF3plIIXX+NEpTOZ1/sisy4aE6EEY6QF90FcxmAyQJqOa1ho7i3qnUbByVdeGd24OU4o2VGLwgfWs8p5AlfM2gHrJaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755665374; c=relaxed/simple;
	bh=P4OZPdJzjtMd9WS2zQ1ChyG8f5e6hQg5Pc1tc9hQJyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PL15gKov1aMJce0K8NLIpxQVUTeyM3j6DeMySOUPmyrqEjbTUDo55fIWcpOa4/zaTW9pSDs5wSBWJbwGWzYj+yPpZGKgCik6j8nK7iKa5LRnFYKvTs9LKcDsWhuklGoAVX5bBO1H+4WMbeXIfJnQS6+d28DjZSs6XlxYRfy/kaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOrzfHuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E92DC2BC86
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 04:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755665373;
	bh=P4OZPdJzjtMd9WS2zQ1ChyG8f5e6hQg5Pc1tc9hQJyc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QOrzfHuoxKtlOSwqlv+bO5TZbkjL2fOmmPykviKXKLcMVLJVK0QmzaMreKsN1Ui/O
	 ULwduBlATxd9LryNI8x+8m8CyXz/oIp7mgygYXkSKHYHldCEAtXrTnM6CHCQ58/8Yg
	 tyr75d4llJJHTyKuPHSxVaY3B2bEK/Z6Lxx8kxXGzZVzXvcOzKK5AjrsoJ+97Wr3RG
	 pbWLl58UzaeF3qFyH1LNpaeQE0drthQn3jobMhx8kpIPvMvSyesCQgECwthMSBL9VZ
	 uDTPXMks2eCxc2DCjXhB4azIWM4ju7nnOzQnS1EdxNsxQIs/h4G+m8Wk1byHemQJyk
	 svCGGgderZCwQ==
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-459fbc92e69so47355e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:49:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVfeyS0Aqxbfye8YgIQzxrcnlHn3JvtKuIXx63N0s9IYJbyiYav63Ey6bFbU8RiBGdhjy2kO1mwYuSzK/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ONrIWWkh0SOEqFG7hcoxPbNif8u3EOQ7XMt0BpZ33a/TOIF/
	T8RWxjvBt5wSaaxGUoCjz1684Y0witTxL/iZqwcwuNuOKD+TCnzq72HcT83K93FNnDV4TtdCT3y
	NDrHnSSsi2Q9elVdJXGfzB9yNSMTKXem4iLVmaYqX
X-Google-Smtp-Source: AGHT+IFCBaA1civFtdIb6102WgW1wwKDHrQ40ZAiA8MIqsnpCc72+2FUaZhCf8KxfJEP3xFxhcGRE4HbOsCbAWY3ri0=
X-Received: by 2002:a05:600c:c106:b0:459:efb0:6687 with SMTP id
 5b1f17b1804b1-45b4777c108mr750575e9.6.1755665372081; Tue, 19 Aug 2025
 21:49:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819193404.46680-1-sj@kernel.org> <CAGsJ_4ygTv1tCJeuF43NhRR4E0kiMLpk6i8c+UHoUMt6LXykww@mail.gmail.com>
In-Reply-To: <CAGsJ_4ygTv1tCJeuF43NhRR4E0kiMLpk6i8c+UHoUMt6LXykww@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 19 Aug 2025 21:49:20 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPNjZc39xHx4NEiymzO29HkLfk9dFYXSu1vZ3tu9VeDvA@mail.gmail.com>
X-Gm-Features: Ac12FXwEsBGmmhpKRLWis8jHILZsWH0UuSzOgykLKT2AqKDYJihra3lilyoboK4
Message-ID: <CAF8kJuPNjZc39xHx4NEiymzO29HkLfk9dFYXSu1vZ3tu9VeDvA@mail.gmail.com>
Subject: Re: [PATCH v4] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: Barry Song <21cnbao@gmail.com>
Cc: SeongJae Park <sj@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Takero Funaki <flintglass@gmail.com>, 
	David Hildenbrand <david@redhat.com>, Baoquan He <bhe@redhat.com>, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 6:13=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> [...]
> > +
> > +       /*
> > +        * If a page cannot be compressed into a size smaller than PAGE=
_SIZE,
> > +        * save the content as is without a compression, to keep the LR=
U order
> > +        * of writebacks.  If writeback is disabled, reject the page si=
nce it
> > +        * only adds metadata overhead.  swap_writeout() will put the p=
age back
> > +        * to the active LRU list in the case.
> > +        */
> > +       if (comp_ret || !dlen) {
> > +               zswap_crypto_compress_fail++;
> > +               dlen =3D PAGE_SIZE;
> > +       }
>
> I=E2=80=99m not entirely sure about this. As long as we pass 2*PAGE_SIZE =
as
> dst_buf, any error returned by crypto drivers should indicate a bug in
> the driver that needs to be fixed.

That is what I have in mind for that counter, if that counter is not
zero it is something with the crypto has gone wrong. If we are sure
that it can never fail, maybe we shouldn't check the error return?

> There have also been attempts to unify crypto drivers so they consistentl=
y
> return -ENOSPC when the destination buffer would overflow. If that has
> been achieved, we might be able to reduce the buffer from 2*PAGE_SIZE to
> just PAGE_SIZE in zswap. There was a long discussion on this here:
> https://lore.kernel.org/linux-mm/Z7dnPh4tPxLO1UEo@google.com/
>
> I=E2=80=99m not sure of the current status =E2=80=94 do all crypto driver=
s now return a
> consistent -ENOSPC when the compressed size exceeds PAGE_SIZE? From
> what I recall during that discussion, most drivers already behaved this
> way, but Sergey Senozhatsky pointed out one or two exceptions.
>
> Let=E2=80=99s sync with Herbert: have we reached the stage where all driv=
ers
> reliably return -ENOSPC when dst_buf is PAGE_SIZE but the compressed
> size would exceed it?

I agree -ENOSPC should treat the compression ratio the same too low.
However, is the crypto library able to return any error other than
-ENOSPC? I am tempted to do something like BUG_ON() or WARN_ONCE() if
other errors we think are never possible. However even the BUG_ON and
WARN are discouraged in the kernel so we should handle the error. The
one error is we can log it and monitor it to make sure it never
happens.

If we are absolutely sure the other error should not happen. We should
remove the free form error from the interface to reflect that. Make
the function should just return bool success or failure as a buffer
too small.

Chris


Return-Path: <linux-kernel+bounces-776942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A1CB2D348
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F2607B73F2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85A72367CF;
	Wed, 20 Aug 2025 05:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVYveFQL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0DF19C542
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755666491; cv=none; b=Ds164rAgesdAvn0VnMmqGHZvDmos8cQ0pZ0i0p8UIDyY+DXTQVhyyKmULcz1p5qSCcAN5ZD5TAmuIOkowKmcky08ZxBPm++3dRSx7j4o9/7EBKA52i9z0VnyJnimnbg/GAgu517w8S4EuInZ9P4Ljk/xlhkq0ij2tq7UZdksH7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755666491; c=relaxed/simple;
	bh=y99OgHX40on6ADXNSxmxvGOSw8+Z8/8ThnthTGcVsk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPLoeVBN+1oyDRiVUyOQGc0Dh0szYzbRvyyQkz3r2FoFZJfYFfEIO1fEDGTW1RBZSkb8nEIzh/OtjGGnu/0E8djk8+G+iE1m5q4XjErf8T+FLsJDN8Z3+NVJmMG1PWrQcbyME5cQyhPs0++wAkS8TQs70E2cxgZzGnL4h+43q78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVYveFQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6D6C19424
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755666490;
	bh=y99OgHX40on6ADXNSxmxvGOSw8+Z8/8ThnthTGcVsk4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RVYveFQLWmdxMXHFyjaRUQB2b9ZtrBS0jNDneYYIG/CtPVVs5+oxY1aykM5aBjJq3
	 FwKaqkJwBHN0XxxUQ130snihfdZpAqx/vmwB0urAEvsA5V8LqGu9fxrwA0x/AIJG+U
	 DDevRROUyyfp1x08mu7BQ/yaq/20pE8PdBy9Xcbgq4y/nDpKY9/KAfKFSrPlqTvKBG
	 A6Y7Ln9gDa773KcxL9G6iR+1BYbps75sckrutnqCoI+KIpxhfzYgsv0FJ6/pT9dn6f
	 SnV82a1kXqVxbwzPjszLbWMZ7Ls9BlrejmxQg3pQwKazhGf3VeApGRLDyJusbppcn+
	 7J3ah1MdBuaYQ==
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-459fbca0c95so45305e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 22:08:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPs12DjaUes/Qsnrs9Z3qimeCIfmfZOj5FZ5EDwwPu+EnIlTA7xyCaCa9fnEMUn+r3SXWQyEqXLhQc9iQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJYF0VcTEHoQ2qlF4UMCPgO0CglNjoRs4FTPLdvQoHHW2FMn9p
	MO+9hdhqcxzKmFedZtaZjiHTJxJFq4EdDuxuKnItR+mSf767PksDlGfhSokxIBtanlAozC+qeTq
	gFwiJOTPfcPAifTIvG1wjscOzyQF2kU5C6r9Xjdwa
X-Google-Smtp-Source: AGHT+IFhIzuv03luG+BoMe6O4xCkFDBZpYYxSUt5s/dQ0dX18xb062MZ8DznmZ+Nwe+PubE77wGdn8A9FVeSk9fJBwE=
X-Received: by 2002:a05:600c:64cc:b0:453:5ffb:e007 with SMTP id
 5b1f17b1804b1-45b4777c033mr929375e9.4.1755666489205; Tue, 19 Aug 2025
 22:08:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819193404.46680-1-sj@kernel.org> <CAGsJ_4ygTv1tCJeuF43NhRR4E0kiMLpk6i8c+UHoUMt6LXykww@mail.gmail.com>
 <aKUi7hvcaK0h0oMg@gondor.apana.org.au> <CAGsJ_4z6YvQULrEmNjFjLNrJ4RK6w0+d9uF2-7v06gOYirrYRw@mail.gmail.com>
In-Reply-To: <CAGsJ_4z6YvQULrEmNjFjLNrJ4RK6w0+d9uF2-7v06gOYirrYRw@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 19 Aug 2025 22:07:57 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNJ8s2D9NBdXDQ4vpBP0a-5k7r_=DdFuJJ95nMKmm6LBg@mail.gmail.com>
X-Gm-Features: Ac12FXzkxJ66YMlu3CzfHeCyeefFGrtiCzJsZOH8GdN7VhIacH_Aq7toBgk6y9U
Message-ID: <CAF8kJuNJ8s2D9NBdXDQ4vpBP0a-5k7r_=DdFuJJ95nMKmm6LBg@mail.gmail.com>
Subject: Re: [PATCH v4] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: Barry Song <21cnbao@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, SeongJae Park <sj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Takero Funaki <flintglass@gmail.com>, 
	David Hildenbrand <david@redhat.com>, Baoquan He <bhe@redhat.com>, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 6:34=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Wed, Aug 20, 2025 at 1:21=E2=80=AFPM Herbert Xu <herbert@gondor.apana.=
org.au> wrote:
> >
> > On Wed, Aug 20, 2025 at 01:13:13PM +1200, Barry Song wrote:
> > >
> > > Let=E2=80=99s sync with Herbert: have we reached the stage where all =
drivers
> > > reliably return -ENOSPC when dst_buf is PAGE_SIZE but the compressed
> > > size would exceed it?
> >
> > It doesn't matter.  Software compression should never fail, and
> > if it does fail due to a bug, that's not something that the user
> > of the API should worry about.
> >
> > Hardware compression should always fall back to software compression
> > in case of failure.
> >
> > IOW all compression errors should be treated as incompressible
> > data.
>
> That is why I think it makes little sense to add a counter
> zswap_crypto_compress_fail, since zswap already passes 2*PAGE_SIZE as
> dst_buf, which is large enough to hold even incompressible data. Adding
> a counter that will always stay at zero seems meaningless.

I was thinking the crypto might be able to return errors other than
the destination buffer being too small, here we give 2x the dst buffer
already, shouldn't see a buffer to small error. In that case, having a
counter mostly stay zero, only an exceptional error case is none zero
is fine.

But if that error case can never happen, we should convert the crypto
compression from returning error number to bool instead. It does not
make sense to return a free form error code and also demand the caller
does not check on it. If you insist that the caller should check
return value like a boolean, just let the API return a boolean.

Chris


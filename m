Return-Path: <linux-kernel+bounces-780656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2A4B3079D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4351D05EA7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0DF3128AD;
	Thu, 21 Aug 2025 20:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWyAPBk6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77FE3128A0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755808944; cv=none; b=EfIABnMP/k3TIWU11gCl9tYti1cbiKlYFsm99euoeelmPW0JMt7Ez5zWHpvc90Y0lmhfHJ6fDB9CWGkawsAhfZ2iOe2htXmxhQvyTAdflwFGQNP0D8ju8hi+xh26uoQtYF8HpTcG4CORZwk/c9/5U+h4JKdS7jX3pwWLmIxXkXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755808944; c=relaxed/simple;
	bh=Xyr2vTQWJi84phHGI09fHiyAc/a2HiFJYMzB+7vMKUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udxcGCqfTC0LnJ6jPm5bs6JBxC3GdSacYx75ORl8I+6hQH3j9CL+AzxXAlX1QmE8+fnQ9uAPBB2+MgZfIyC6KdckRk77d+HQpCMVst+kHtd8YFXhI8kHWHMXScZ8ZXQsjokNiimgBDR5UHv3mYycF63YiAh9LEARm7c6KFlbYEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWyAPBk6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C343C16AAE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755808944;
	bh=Xyr2vTQWJi84phHGI09fHiyAc/a2HiFJYMzB+7vMKUY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uWyAPBk6TQh4uZnvEeJ07eNzt1pl5zG9rmldduuxYxRyfKEAMUVD8cQsfBbfwVSBD
	 pP1s8CGg9G7iP+YLi0bLtxLzMTq+WGQl+nV13zWSNa+QvXZ+H7d0QYkfn01nKyY2nA
	 gCKFjQCOm8iOJ5JTPikff45cTnMpvdrxFPNiGbh7YGBXH41c7Ii62rLhoAXNqzTv4X
	 v4OzAQbyIUkRZgTdciycY40FqqkLhJ5mCKk9PjrojY5Xu6Vvi2gtj2EilksoznfVyJ
	 w8sHlKuVPcC9EJ6fUUf4Y+xJ0sXKFKeYdt8tlfHECs6PWt4BGAeK6/mGXjjXlBXjf1
	 T0HjMag/QYNVg==
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459fc675d11so5855e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:42:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV30uWBAWm34WDcko0a04UeujubbrjS1gAYnx4PrTif6dvWZlC1NAj4u2MzPd0WAugB6cZ2ZRfspB+d1tM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIp//h33lAn9dD+ALxYWNLJpzz8GfxGELOh1IoXNKL3ltupCLR
	8JFUUuPKaMcwAmvatOfCdBytokD3x9jCBFMJlVU8p5T2wl0XYo565UIaseUgtLm6rhVGVe48G/V
	eO2FdqHT6XGJYrR70vnw1ya5tUrjiUN3RTFCGlDsu
X-Google-Smtp-Source: AGHT+IHDZCalgfqlYi7MkLgFbyjbhsH3CZf0MNkISUXvgYgeAZsgXeUqGGDOaCg+VIv8TDFRobw1n05v/ADvT2/804M=
X-Received: by 2002:a05:600c:8b01:b0:453:79c3:91d6 with SMTP id
 5b1f17b1804b1-45b52119c8dmr9385e9.1.1755808942940; Thu, 21 Aug 2025 13:42:22
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819193404.46680-1-sj@kernel.org> <CAGsJ_4ygTv1tCJeuF43NhRR4E0kiMLpk6i8c+UHoUMt6LXykww@mail.gmail.com>
 <aKUi7hvcaK0h0oMg@gondor.apana.org.au> <CAGsJ_4z6YvQULrEmNjFjLNrJ4RK6w0+d9uF2-7v06gOYirrYRw@mail.gmail.com>
 <CAF8kJuNJ8s2D9NBdXDQ4vpBP0a-5k7r_=DdFuJJ95nMKmm6LBg@mail.gmail.com>
 <aKVYyGWiWRYgxfE-@gondor.apana.org.au> <CAF8kJuPPsLzWu8+xm2A_UPHMBhb7OTjJNErM1Kp3hPmvHXNDUQ@mail.gmail.com>
 <aKVbqi6wd3Spz-TM@gondor.apana.org.au>
In-Reply-To: <aKVbqi6wd3Spz-TM@gondor.apana.org.au>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 21 Aug 2025 13:42:11 -0700
X-Gmail-Original-Message-ID: <CAF8kJuOJsZ2RbvFedfKADVqa0TUrkO-ceqrtaMXgiHAS0V19hw@mail.gmail.com>
X-Gm-Features: Ac12FXwy1vPVdOsVeHesiENd9Xc9-_4Gop9B9f4wYnWvLSSwoexOz99om6lRJM4
Message-ID: <CAF8kJuOJsZ2RbvFedfKADVqa0TUrkO-ceqrtaMXgiHAS0V19hw@mail.gmail.com>
Subject: Re: [PATCH v4] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Barry Song <21cnbao@gmail.com>, SeongJae Park <sj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Takero Funaki <flintglass@gmail.com>, 
	David Hildenbrand <david@redhat.com>, Baoquan He <bhe@redhat.com>, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 10:23=E2=80=AFPM Herbert Xu <herbert@gondor.apana.o=
rg.au> wrote:
>
> On Tue, Aug 19, 2025 at 10:20:45PM -0700, Chris Li wrote:
> >
> > In that case it is fair game for the caller to check for the error
> > other than -ENOSPC. If the return value is -EINPROGRESS during
> > synchronous crypto compression, it is a bug. We are not encouraged to
> > use WARN_ON, then having an error count to check that something truly
> > unlikely but possible to happen is better than folding it into
> > incompressible and pretend the error never happened. At least we can
> > know such an error case happened.
>
> Sure warning on -EINPROGRESS is fine.  But every other non-zero
> return value should be treated as incompressible.

Ack.

Thanks for the feedback.

Chris


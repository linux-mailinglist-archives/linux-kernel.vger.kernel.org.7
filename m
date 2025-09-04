Return-Path: <linux-kernel+bounces-801192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E93B4411F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A20587951
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6BD23D287;
	Thu,  4 Sep 2025 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MWFum7xT"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79477C8F0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757001248; cv=none; b=XPTXjRxp5eLt8u11KfmiZTiLrtvdYdei05hYuOhDjeYJG0xmUb6ke0uRCMMGYUEfVaZop0GF/HuxnNjN1sVEcVthBil67qPab3mKU5ag+YLl6llodyW9wL50pwIBuAglj5BsmznmjXg0Cre7Kn07moU4Yv8xiWBBt3WbRJtfU8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757001248; c=relaxed/simple;
	bh=8bX8Pw0dU1Nv0/aA0MnnTJ1bz+yUeok84T0x+Kv0XEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWp7PlijGwnMycvLvLjYkc/RyMyVZPrnvQQTc7FHkMr9YiR4/d4TxITR4/ZHkhR4eVOVA9LjI7F0O6jJEer8dFXRELjk4L4Ci93JzaTXe8J8MkalaqEey7bixaUb0ZlGLEbsDRIMcUrXucXFJ19UNbhwrRxxa1Ty7cu7XXQpaWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MWFum7xT; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24ab15b6f09so202225ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757001246; x=1757606046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgDq9K4RutiA3+hQQ/hGnSVwSGPHlJ2FijaFdFtw3Mw=;
        b=MWFum7xTOueXqsd1BLAS5FS/utN8enQfM9z40gr78ZNtJNmCzYL1Ns0IzAW+6C7CCq
         ibOiQvk5X4nYmu9+oWgJ3oZrg3BjNaeDMBDbK6kcUC/UJWvLinLZ513wgmVPoF+cpwzD
         TBq7Kk3EWWSePCJSKf7wijoakR4yDlbl5PXvmN6T3ANZTU5gb074CQt4/M4ilzvOSiaa
         fiQ2N+f3JmQekyOAnVbdZlFtgggeVr/sZg7JlV9GPLzmMSXmxZMtvApw3iXzr/M1whxC
         CwuWgp/KPjrOZ/7/aaJYKwvt2bLCDbFBda9rLQ/bIEbXiyMR8g8yW3KymAxTPJSQ0Bjk
         VP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757001246; x=1757606046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgDq9K4RutiA3+hQQ/hGnSVwSGPHlJ2FijaFdFtw3Mw=;
        b=tSDxxNrAPwR7k7o0v532glhWfwjjkcowAecNs1oWIP/LKOZqNXBB//Rd7hNMShiB3g
         dIk2xBY92tmVCa5NnaNRxJwg569pq2LGxKESzb2Jl/rjW4aWeKa1ePQp3dbinittb2RU
         LsLz2YSLc+iHhM26B2ZjTh/e6EfB6tKoOjJlUnLjFUCgAiJ8zjcHNZeveRa3EgALRLUF
         NqwWdh7o22UCc/7/Fln0kS3y6TiEnmoLbFG40+XQgrJtRznqVrfXMAP4MNI66dI8tbaO
         d+CoDtToscxBAEIpccVUoow7OfwRku5a53KPlbMt/oSh32DZYFEUqUqiosP/9Cykkgp3
         B5/A==
X-Forwarded-Encrypted: i=1; AJvYcCUck48/IF/PdneMiYZ6cCvrrk3fqlFVDlMEd5ECDm4KV6SbUsCIELcswxhTPJuNgOxeV9UoQQ1U1U2OcZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEGt5rSPIAc93/B+ogWEw9oQORl33s1JGxEBtSXYf5/zLgCldI
	4jTN0uOX7I5vyAaEWSFZWnUjRsUGAM+udvZk7RdUqSLqHj1cQa4H/jQmDwwqu4rsYC0eCI1J0+a
	V6zt6gpQICFL4XFDgHhmGyidt70K22xslY8ZtWogR
X-Gm-Gg: ASbGncv6ZFblD1OK0GfQ0S7mbYxijn1Qp0HB3K7lsGp2X1cO/i4Lkgt0vzj6J9XFSrP
	ag+noRyD90uH6X7aJqAfm+yCyv8Ys0tIyDz2Ay4a5O/1UWfJEN9HRcff7lzJ3lCznInv2zv4P3O
	/7KM7F4eqMBl3EJ1WS5u23zOZzymkCdLVzI9TbWMMzwE1YGV4JY2JHMb97PUN5xdU35fWHghyFF
	o2+RL3XISUSzVT3pxob30pBGGb9gdRVfCL1ItNIb323kKqP4SFxniq1V2hYLXhAog==
X-Google-Smtp-Source: AGHT+IFn09tZFMUc7Fo4TXop3uOW4hFYWgY+V3qnhieRUGzXAnxOjxJLxOzHpopesCWQqDuc8eiCaAklrshD5N2EaOI=
X-Received: by 2002:a17:903:2450:b0:24b:1741:1a4c with SMTP id
 d9443c01a7336-24ccaab49d7mr3468945ad.0.1757001245354; Thu, 04 Sep 2025
 08:54:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903-james-perf-read-build-id-fix-v1-0-6a694d0a980f@linaro.org>
 <20250903-james-perf-read-build-id-fix-v1-2-6a694d0a980f@linaro.org>
 <CAP-5=fWHGFBaCgiRcj8zVy196OE07F8jnSUbjvsO_HerdqeyTg@mail.gmail.com>
 <70bd9eea-905a-4fa9-8265-f84ab9894b12@linaro.org> <2b958dec-7ba9-41a3-b11b-43b5e8418849@codeweavers.com>
 <549d3812-a606-4981-83f5-0a99b0ff9f6a@linaro.org>
In-Reply-To: <549d3812-a606-4981-83f5-0a99b0ff9f6a@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 4 Sep 2025 08:53:54 -0700
X-Gm-Features: Ac12FXzHwKy2t84CiPZNRVWOAvpknEgxnXzuzVKZ0Zr3bUGonJJspm9wVw5gIqg
Message-ID: <CAP-5=fXKthsZe3J4_UHHGwDafBq7pHzM18Mh=_2QrnSfCT3nOg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf symbols: Fix HAVE_LIBBFD_BUILDID_SUPPORT build
To: James Clark <james.clark@linaro.org>
Cc: =?UTF-8?B?UsOpbWkgQmVybm9u?= <rbernon@codeweavers.com>, 
	Sam James <sam@gentoo.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 7:18=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
>
>
> On 04/09/2025 9:27 am, R=C3=A9mi Bernon wrote:
> > Hi!
> >
> > On 9/4/25 10:13, James Clark wrote:
> >>
> >>
> >> On 03/09/2025 5:07 pm, Ian Rogers wrote:
> >>> On Wed, Sep 3, 2025 at 8:15=E2=80=AFAM James Clark <james.clark@linar=
o.org>
> >>> wrote:
> >>>>
> >>>> read_build_id() now has a blocking argument, but libbfd uses fopen()
> >>>> internally which doesn't support O_NONBLOCK. Fix the build by adding
> >>>> the
> >>>> argument and ignoring it:
> >>>>
> >>>>    util/symbol-elf.c:964:8: error: too many arguments to function
> >>>> =E2=80=98read_build_id=E2=80=99
> >>>>      964 |  err =3D read_build_id(filename, bid, block);
> >>>>
> >>>> Fixes: 2c369d91d093 ("perf symbol: Add blocking argument to
> >>>> filename__read_build_id")
> >>>> Signed-off-by: James Clark <james.clark@linaro.org>
> >>>
> >>> Libbfd should go away:
> >>> https://lore.kernel.org/lkml/20250823003216.733941-14-
> >>> irogers@google.com/
> >>> but I can imagine that currently this is hit in a build test - sorry
> >>> for missing that and thanks for the fix!
> >>>
> >>
> >> Yeah just one of the build tests, I'm not actually using it.
> >>
> >> Remi are you still using this? To be fair the addition for PE support
> >> is fairly recent and even includes a binary for testing it so I'm not
> >> sure if we should be so quick to remove it.
> >>
> > Yes, I'm still using it occasionally, and I think it's generally useful
> > for Wine profiling purposes and I would rather prefer that it's not
> > removed.
> >
> > I know it's not built by default because of license conflicts. I didn't
> > realize that was an issue when contributing the changes, and it is quit=
e
> > unfortunate (and silly IMO).
> >
> > Then I'm not particularly attached to libbfd and any other option that
> > would let perf read PE files would be alright, as long as PE support is
> > kept.
> >
> > Cheers,
>
> It looks like libLLVM might work. Looking at the doxygen there are vague
> references to PE binaries around the getBuildID() function. But as
> mentioned in the linked thread, it's huge at 100+ MB.
>
> WRT that thread, I think maybe re-writing some of this in Perf wouldn't
> be so bad. Surely getting the buildID is trivial. For PE binaries it's
> hard to tell what's supported currently, what's being used and what's
> being done by what library or tool. addr2line, libbfd, symbols,
> disassembly etc.

I know some people who work on LLVM for Windows for the sake of having
a Chrome build from Linux. It should be possible to migrate the libbfd
use cases to LLVM. If I remember John Levine's Linkers and Loaders
book correctly (contents available by way of your favorite search
engine) everything is just a variant of COFF anyway.

It is a shame that the PE testing in buildid.sh (and the testing in
general) is requiring `cc` as it'd be much nicer to have the tests in
a form similar to the perf test workloads (e.g. perf test -w noploop).
I don't have a good idea on how to fix this but just wanted to note
it.

I'll write a non-blocking patch for read_build_id with libbfd that
matches what the others do and should avoid the hang in the meantime.

Thanks,
Ian


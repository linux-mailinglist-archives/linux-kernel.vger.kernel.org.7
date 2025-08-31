Return-Path: <linux-kernel+bounces-793551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2225B3D510
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 22:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF0D1764CE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 20:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E83F236453;
	Sun, 31 Aug 2025 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5wgrxi4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723CB22F76F
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756670704; cv=none; b=gVfnK8jNtoDDlBwxjV9sLd8mSJ8h4Px44kIFLvy8/sD9MKhIsE2oVkTNuzpeCGPbOHBlsmUpr89HBzQOd6UO/TY0Lhc+fxjnXj0iqF/iAa7E+6f3ZsdHjceTiT4xlZ+C3/GsiMNZv7jPoOajm6qmXowUVg6skZB1QycihwbsdTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756670704; c=relaxed/simple;
	bh=LWRpUSL/GnmdcvyMwvmcVlZ7Yq9l1dg62LV4rSyXoX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6lhJfofyD3pTRH0zG5pe05NCrMnJLjdgUnXTQKTywQjBVPLtOALSqxzqbrom+qcRhrDQgD7WZ4Ew8y/U6FebWC0MLmX6/Bpc2HUcaNjLtR4z4xyjgal3fbGFN9KddlaZf3poLxQZV73q2Eyj6yNy4ol++P/dnIOHOkhZYXJ0Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5wgrxi4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1482EC113D0
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 20:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756670704;
	bh=LWRpUSL/GnmdcvyMwvmcVlZ7Yq9l1dg62LV4rSyXoX0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K5wgrxi4a68oR1olGOtkvYpIi9jQ406zgLUafhAovo24R0AVEctGr4ILQPtQzeVA3
	 PMcfEX/a+yOTgdbALNwjWL6qLlhun3N6W/gOFbaHOR9/6bp3WDSNxae3oNsuvMbWvF
	 lkLKGjpRgB2A/SOPSWE+ZmfgN/c4K0JgDb0Z4M80sBqcdUw3N5064VxM0olTs1N/5V
	 MM458JySQ1ylBWcSS1ekw+MzveUqlflLybVzOPB8/HYuEB2Ao7R1PqOHmZsnE3Mi/i
	 g5DYcEXkNifFkkxwdfjkgeo6LsmE7fp/qQ6g8N9CpftF/wSOkpGHFrV1fDmGYr3dLu
	 Mr5rt1Js9ytOA==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d5fe46572so34465247b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 13:05:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWjq2JPFN+V/NnFIHRJUacwIQDe64DJt0cO93zgKqQtqmjhX58hSED7KVDdVY7VQ/DfCXB/8gCxGQgQFSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTAR8zZH06qsprKgSvoerHBl+XJGl28Sg3FsDIa9SpNHT+c/vm
	HdrE/ATLc7OIoqQfh1FcmHJgeQKIjJgEOKsoMVZB5wMOQ6nUpqD2INj8uRzkfI+PVh6cTqXiylS
	SZqvxj798INPp7+Rc/eJi20HKcmx6/RpUd+clAdiRPA==
X-Google-Smtp-Source: AGHT+IEvrMUALCHiCTbTOeCcpOCPaO1Fu8A9uaO8xl5ArGIFN5AJnhsZL8URqDZn4jBZvXcL+BqUUAZilA4DBK//Zzs=
X-Received: by 2002:a05:690c:b06:b0:71b:f46e:691 with SMTP id
 00721157ae682-72276370c8cmr63246317b3.11.1756670703140; Sun, 31 Aug 2025
 13:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-8-ryncsn@gmail.com>
 <CACePvbXB-G5vhoEt87BZcjDZ8kZWo3mZtAZ60YbR_gcjnPz29w@mail.gmail.com> <CAMgjq7Aznd7=m6JTNGM4EyFj+6pqHTRBCo2hsQL-cKi0LZggOg@mail.gmail.com>
In-Reply-To: <CAMgjq7Aznd7=m6JTNGM4EyFj+6pqHTRBCo2hsQL-cKi0LZggOg@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sun, 31 Aug 2025 13:04:50 -0700
X-Gmail-Original-Message-ID: <CACePvbUt+=+5mZ2E6L_EhUYLTWst_STab=LjPiBfvZuX8jenMA@mail.gmail.com>
X-Gm-Features: Ac12FXz-89GEcBe6LbFCY4BPOk3iEpBAci6KuW0YkObl510MGiMrV1R0KFjr83Q
Message-ID: <CACePvbUt+=+5mZ2E6L_EhUYLTWst_STab=LjPiBfvZuX8jenMA@mail.gmail.com>
Subject: Re: [PATCH 7/9] mm, swap: remove contention workaround for swap cache
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 8:25=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Sat, Aug 30, 2025 at 1:03=E2=80=AFPM Chris Li <chrisl@kernel.org> wrot=
e:
> >
> > Hi Kairui,
> >
> > It feels so good to remove that 64M swap cache space. Thank you for
> > making it happen.
> >
> > Some nitpick follows. I am fine as is as well.
> >
> > Acked-by: Chris Li <chrisl@kernel.org>
>
> Thanks.
>
> >
> > Chris
> >
> > On Fri, Aug 22, 2025 at 12:21=E2=80=AFPM Kairui Song <ryncsn@gmail.com>=
 wrote:
> > >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > Swap cluster setup will try to shuffle the clusters on initialization=
.
> > > It was helpful to avoid contention for the swap cache space. The clus=
ter
> > > size (2M) was much smaller than each swap cache space (64M), so shuff=
ling
> > > the cluster means the allocator will try to allocate swap slots that =
are
> > > in different swap cache spaces for each CPU, reducing the chance of t=
wo
> > > CPUs using the same swap cache space, and hence reducing the contenti=
on.
> > >
> > > Now, swap cache is managed by swap clusters, this shuffle is pointles=
s.
> > > Just remove it, and clean up related macros.
> > >
> > > This should also improve the HDD swap performance as shuffling IO is =
a
> > > bad idea for HDD, and now the shuffling is gone.
> >
> > Did you have any numbers to prove that :-). Last time the swap
> > allocator stress testing has already destroyed two of my SAS drives
> > dedicated for testing. So I am not very keen on running the HDD swap
> > stress test. The HDD swap stress test are super slow to run, it takes
> > ages.
>
> I did some test months before, removing the cluster shuffle did help.
> I didn't test it again this time, only did some stress test. Doing
> performance test on HDD is really not a good experience as my HDD
> drives are too old so a long running test kills them easily.
>
> And I couldn't find any other factor that is causing a serial HDD IO
> regression, maybe the bot can help verify. If this doesn't help, we'll
> think of something else. But I don't think HDD based SWAP will ever
> have a practical good performance as they are terrible at rand read...
>
> Anyway, let me try again with HDD today, maybe I'll get some useful data.

I am pulling your leg about the HDD number :-) I know that thing is
hard to get and I'm counting on you having a dead HDD on the way to
get it. Evil Chris that is.

I think we don't have to make claims like that HDD is faster. Just say
HDD might or might not swap faster, because we haven't really test it.
People who are about HDD swap can test themself and report back to the
mailing list.
I think we should use SSD to simulate HDD, testing the HDD code works
in the simulated mode, no crash, no data corruption that is good
enough.

HDD swap is so slow that most people don't really care. I asked in the
LPC a while back, nobody there is using HDD swap seriously. At most,
just in case my SSD swap overflows, allow it to overflow to HDD.

Chris


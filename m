Return-Path: <linux-kernel+bounces-835442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BE1BA71A5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 16:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DED93B9791
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 14:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F382D1F582C;
	Sun, 28 Sep 2025 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phvoTT7U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5738413B284;
	Sun, 28 Sep 2025 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759070192; cv=none; b=m/ufLB64dwnLpyVza25yXkG1KHE+Gq7POPBHLwCCERe1c3beIR7E4RzN3YyF92s24E8qlRgWgZUYwrZnl5gVsIWOV5lgKAuJrMvHgg2jnBjeNkvM/BRdjAI4Od6oZCBnBy+UjQ/BgB9H9B8qPul5ryO4O8NXn+kqWzlcv06T+IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759070192; c=relaxed/simple;
	bh=xjQLvrKt9akl9GuheEGr+P2uPV9FsTvq0tDl6rUUN+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYex7twov1gm4aW8GKMM95lsHGmpu1ELcmaZ1apn5F2tO/CkSC+38aF6EoqgPUL69Ao3T4Ci3pFBlXGle8mE6nJdJz3kXAIEeyvCWo5XHq6FTjol03tDs+9ENjzJqnQMTZDGN9m/hBp/lXsbibXA2x0YJ0J+XUzWGBMvltAiPm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phvoTT7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72425C4CEF0;
	Sun, 28 Sep 2025 14:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759070191;
	bh=xjQLvrKt9akl9GuheEGr+P2uPV9FsTvq0tDl6rUUN+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=phvoTT7UCIJjosOrV+WiY/ecV/D1sXuKIFi3R8TrX2Pns5qbLfpmiAmNrA1RZGaPg
	 aQNii2M3zKe1t490lqauPgolU6NFPn5TBq/jSXWYFKAML2rCg7S9JJcIxzp0UE+9Ph
	 CKQdGxwbd3IRDhNVmUgS2dI5aKBcNxHp4aEHDaU9Wn9Yw1aApFd42OrD9JXzLUyU0u
	 tnIlR+X9Y6Yh2G0h3/7z74HnJBmr8P4JBm/0wxUIWtpEsU3KqAsSqC9OeTqRM6wJPd
	 C6QbDTQRHb/y8jMJ5M3AqrL2+yFENt7MSaboP7shXcD/8B6u7lsh3qrgdTrd+Il1yB
	 IrPvpXWO85q1A==
Date: Sun, 28 Sep 2025 17:36:27 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
	linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, multikernel@lists.linux.dev
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture
 support
Message-ID: <aNlH6-hFc6OmDF_e@kernel.org>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <78127855-104f-46e2-e5d2-52c622243b08@gentwo.org>
 <CAM_iQpU2QucTR7+6TwE9yKb+QZg5u_=r9O_tMfsn7Ss7kJbd9A@mail.gmail.com>
 <aNZh3uDdORZ5mfSD@kernel.org>
 <CAM_iQpWXFQwtayT7Zv7iJd7zQZ=rX_P1ZK2P11-6ohRhLpg7Xw@mail.gmail.com>
 <aNlErhpO1g17gdgM@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNlErhpO1g17gdgM@kernel.org>

On Sun, Sep 28, 2025 at 05:22:43PM +0300, Jarkko Sakkinen wrote:
> On Sat, Sep 27, 2025 at 01:43:23PM -0700, Cong Wang wrote:
> > On Fri, Sep 26, 2025 at 2:50 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > >
> > > On Wed, Sep 24, 2025 at 11:39:44AM -0700, Cong Wang wrote:
> > > > On Wed, Sep 24, 2025 at 10:51 AM Christoph Lameter (Ampere)
> > > > <cl@gentwo.org> wrote:
> > > > > AFAICT various contemporary Android deployments do the multiple kernel
> > > > > approach in one way or another already for security purposes and for
> > > > > specialized controllers. However, the multi kernel approaches are often
> > > > > depending on specialized and dedicated hardware. It may be difficult to
> > > > > support with a generic approach developed here.
> > > >
> > > > You are right, the multikernel concept is indeed pretty old, the BarrelFish
> > > > OS was invented in around 2009. Jailhouse was released 12 years ago.
> > > > There are tons of papers in this area too.
> > >
> > > Jailhouse is quite nice actually. Perhaps you should pick that up
> > > instead, and start refining and improving it? I'd be interested to test
> > > refined jailhouse patches. It's also easy build test images having the
> > > feature both with BuildRoot and Yocto.
> > 
> > Static partitioning is not a bad choice, except it is less flexible. We can't
> > get dynamic resource allocation with just static partitioning, but we can
> > easily get static partitioning with dynamic allocation, in fact, it should be
> > the default case.
> > 
> > In my own opinion, the reason why containers today are more popular
> > than VM's is not just performance, it is elasticity too. Static partitioning
> > is essentially against elasticity.
> 
> How do you make a popularity comparison between VMs and containers, and
> what does the word "popularity" means in the context? The whole world
> runs basically runs with guest VMs (just go to check AWS, Azure, Oracle
> Cloud and what not).
> 
> The problem in that argument is that there is no problem.

If I was working on such a feature I would probably package it for e.g,
BuildRoot with BR2_EXTERNAL type of Git and create a user space that
can run some test and benchmarks that actually highlight the benefits.

Then, I would trash the existing cover letter with something with clear
problem statement and motivation instead of whitepaper alike claims.

We can argue to the eterenity with qualitative aspects of any feature
but it is the quantitative proof that actually drives things forward.

BR, Jarkko


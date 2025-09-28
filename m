Return-Path: <linux-kernel+bounces-835446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3A8BA71C3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 16:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A711899954
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 14:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E97520101D;
	Sun, 28 Sep 2025 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0Iw+J01"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98931714B7;
	Sun, 28 Sep 2025 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759070516; cv=none; b=PrVhJhSHELe3aW1X1UaDyZB6uUbZaHgna60tBZYNd2GT+LFly1FdWU/s9gTGEAAeqcid2KY87FPqCZYm95hBnmwnbc16/jvppvvKfSRpH61OJVav7aqMgfeS0ni6baFX0fmiYkywyN2ZGHuDtF+XO2VSKkL9Vc9KPioGQpE+wH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759070516; c=relaxed/simple;
	bh=SzzdI+GX07mAERTWzTnj3dkki2cHhdg6x0GIVS4BA9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqVe9W9ATMDjPSEmmdLTIRM16XyWu7VDDpn+CGZ/v0lRPM2Z+UmSt0RSAXBrPqSzEwz9COWj15k+O3sPDd2if7HGnt5YIDD6psp1gZCrMPpp9QVJdRWnvd8SnQDjXWxuLtbkHTkQhBcQ1dkXhzumqel5yZ8XBGvq1AFKfTF0lZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0Iw+J01; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAF9C4CEF5;
	Sun, 28 Sep 2025 14:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759070516;
	bh=SzzdI+GX07mAERTWzTnj3dkki2cHhdg6x0GIVS4BA9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m0Iw+J01S0fGdnbq0MAZ6PTKcjL5BY1ZlP4amzY+Kn/GmtCBnY9dg7UsSWwM1Yorm
	 Cd2dsk1mHNjW5aDtyRHfS5v+K5t2fQOYDgVR5NhZ53bD4iWJOh9aqzXG45qM4Blxir
	 0emDc2Vs5ir0T7W06O8Fnia5yaxbnYy1kEdS1AL2SWBMsPd+xvmeAr2t1russfADFJ
	 LmwTnZaw7OCcQLjHiCJtpMNOS8JnuYDb2HudfgMCMcvg9vgongLpQPlPYArVRORTR/
	 sLwXxYgBzKeBbQ30FVP+VRBHnkyPf4N2ZhvocRvD2jIuO43CU8/sbkK4yek2c/W59H
	 iH7YAtiOApm1A==
Date: Sun, 28 Sep 2025 17:41:52 +0300
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
Message-ID: <aNlJMAHhFE-O3IX9@kernel.org>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <78127855-104f-46e2-e5d2-52c622243b08@gentwo.org>
 <CAM_iQpU2QucTR7+6TwE9yKb+QZg5u_=r9O_tMfsn7Ss7kJbd9A@mail.gmail.com>
 <aNZh3uDdORZ5mfSD@kernel.org>
 <CAM_iQpWXFQwtayT7Zv7iJd7zQZ=rX_P1ZK2P11-6ohRhLpg7Xw@mail.gmail.com>
 <aNlErhpO1g17gdgM@kernel.org>
 <aNlH6-hFc6OmDF_e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNlH6-hFc6OmDF_e@kernel.org>

On Sun, Sep 28, 2025 at 05:36:32PM +0300, Jarkko Sakkinen wrote:
> On Sun, Sep 28, 2025 at 05:22:43PM +0300, Jarkko Sakkinen wrote:
> > On Sat, Sep 27, 2025 at 01:43:23PM -0700, Cong Wang wrote:
> > > On Fri, Sep 26, 2025 at 2:50 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > >
> > > > On Wed, Sep 24, 2025 at 11:39:44AM -0700, Cong Wang wrote:
> > > > > On Wed, Sep 24, 2025 at 10:51 AM Christoph Lameter (Ampere)
> > > > > <cl@gentwo.org> wrote:
> > > > > > AFAICT various contemporary Android deployments do the multiple kernel
> > > > > > approach in one way or another already for security purposes and for
> > > > > > specialized controllers. However, the multi kernel approaches are often
> > > > > > depending on specialized and dedicated hardware. It may be difficult to
> > > > > > support with a generic approach developed here.
> > > > >
> > > > > You are right, the multikernel concept is indeed pretty old, the BarrelFish
> > > > > OS was invented in around 2009. Jailhouse was released 12 years ago.
> > > > > There are tons of papers in this area too.
> > > >
> > > > Jailhouse is quite nice actually. Perhaps you should pick that up
> > > > instead, and start refining and improving it? I'd be interested to test
> > > > refined jailhouse patches. It's also easy build test images having the
> > > > feature both with BuildRoot and Yocto.
> > > 
> > > Static partitioning is not a bad choice, except it is less flexible. We can't
> > > get dynamic resource allocation with just static partitioning, but we can
> > > easily get static partitioning with dynamic allocation, in fact, it should be
> > > the default case.
> > > 
> > > In my own opinion, the reason why containers today are more popular
> > > than VM's is not just performance, it is elasticity too. Static partitioning
> > > is essentially against elasticity.
> > 
> > How do you make a popularity comparison between VMs and containers, and
> > what does the word "popularity" means in the context? The whole world
> > runs basically runs with guest VMs (just go to check AWS, Azure, Oracle
> > Cloud and what not).
> > 
> > The problem in that argument is that there is no problem.
> 
> If I was working on such a feature I would probably package it for e.g,
> BuildRoot with BR2_EXTERNAL type of Git and create a user space that
> can run some test and benchmarks that actually highlight the benefits.
> 
> Then, I would trash the existing cover letter with something with clear
> problem statement and motivation instead of whitepaper alike claims.
> 
> We can argue to the eterenity with qualitative aspects of any feature
> but it is the quantitative proof that actually drives things forward.

I'd also carefully check as per modifying kexec that more complex use
cases are compatible such as IMA. I don't know if there is an issue with
secure boot but I'd make sure that there is no friction with it either.

There's also shared security related hardware resources such as TPM,
and in this context two instances end up thus sharing it for e.g.
measurements, and that type of cross-communication could have 
unpredictable consequences (would need to be checked).

BR, Jarkko


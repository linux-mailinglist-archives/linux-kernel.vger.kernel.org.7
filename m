Return-Path: <linux-kernel+bounces-835439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7A3BA718D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 16:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2AFA1897A57
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 14:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3F721882F;
	Sun, 28 Sep 2025 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIaEscUT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B20190685;
	Sun, 28 Sep 2025 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759069363; cv=none; b=EoGra7j9izDeMrj1N0JnaRC1hye16QHluqI6CUTqDc/xOTVy6hmun4hs2ALpw4Sfu3SRy0OLSHmL8VkDxHGtzWQCsRkHckWmrPbKLceZtT83tw+ZfZ4y5zrJ19hrvBPeUgAhqJXxzvOdUpMcsiO8AkrMHe36BJN8XkyV+7pPyXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759069363; c=relaxed/simple;
	bh=Wg1xrNCbGg8db7MqipyCxrrsmMoVbFCLhcRL36NHECw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYWxVp+U1HrGBqhD+pZGwZbgT90A0ZjF1esak8Lu+0wb6Bvgl8QfipidHlYke5IPjbRiKrC0UA7QnpCGxiZ6yV0nfHVuIAwjLPxxuah3WX6BAMzrtIbN0xyrKsM1tbXBPkflnsSJ6+USZPgoOG0xG839JoAR3SQJ9taajFgeeoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIaEscUT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA39C4CEF0;
	Sun, 28 Sep 2025 14:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759069363;
	bh=Wg1xrNCbGg8db7MqipyCxrrsmMoVbFCLhcRL36NHECw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TIaEscUT6E8LJ+NgIrEGjJB2yfmv0DOXQQ3iMgMZewcagvseJj47Zq7TbBcssaQgr
	 rGIH8EVofkWfFbNGyD9UNbpBzi0pz53pYgVouaJYpMKlmDvy9TBwMU+olwn269wf9J
	 T41s4Q3jouYy2lr5tDBEQeiT/eoFSGDOpL0XPUbw3HPWZzVFw+J1z4pE4VH/K+coWe
	 +c/sMEtUxdRwap2G1mPwgXnfFvVaq8LZWqUcrV5n0ZbIzim4JDZucgNI0bkZKhnNWH
	 GRpY/iuBWdp1Ds9iYdYd19AHQgmgAmb9vfi62Kfzhqnu81lPLCvD1oo91CKyc1gyRj
	 N9WRiNJ694s/w==
Date: Sun, 28 Sep 2025 17:22:38 +0300
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
Message-ID: <aNlErhpO1g17gdgM@kernel.org>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <78127855-104f-46e2-e5d2-52c622243b08@gentwo.org>
 <CAM_iQpU2QucTR7+6TwE9yKb+QZg5u_=r9O_tMfsn7Ss7kJbd9A@mail.gmail.com>
 <aNZh3uDdORZ5mfSD@kernel.org>
 <CAM_iQpWXFQwtayT7Zv7iJd7zQZ=rX_P1ZK2P11-6ohRhLpg7Xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM_iQpWXFQwtayT7Zv7iJd7zQZ=rX_P1ZK2P11-6ohRhLpg7Xw@mail.gmail.com>

On Sat, Sep 27, 2025 at 01:43:23PM -0700, Cong Wang wrote:
> On Fri, Sep 26, 2025 at 2:50 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Wed, Sep 24, 2025 at 11:39:44AM -0700, Cong Wang wrote:
> > > On Wed, Sep 24, 2025 at 10:51 AM Christoph Lameter (Ampere)
> > > <cl@gentwo.org> wrote:
> > > > AFAICT various contemporary Android deployments do the multiple kernel
> > > > approach in one way or another already for security purposes and for
> > > > specialized controllers. However, the multi kernel approaches are often
> > > > depending on specialized and dedicated hardware. It may be difficult to
> > > > support with a generic approach developed here.
> > >
> > > You are right, the multikernel concept is indeed pretty old, the BarrelFish
> > > OS was invented in around 2009. Jailhouse was released 12 years ago.
> > > There are tons of papers in this area too.
> >
> > Jailhouse is quite nice actually. Perhaps you should pick that up
> > instead, and start refining and improving it? I'd be interested to test
> > refined jailhouse patches. It's also easy build test images having the
> > feature both with BuildRoot and Yocto.
> 
> Static partitioning is not a bad choice, except it is less flexible. We can't
> get dynamic resource allocation with just static partitioning, but we can
> easily get static partitioning with dynamic allocation, in fact, it should be
> the default case.
> 
> In my own opinion, the reason why containers today are more popular
> than VM's is not just performance, it is elasticity too. Static partitioning
> is essentially against elasticity.

How do you make a popularity comparison between VMs and containers, and
what does the word "popularity" means in the context? The whole world
runs basically runs with guest VMs (just go to check AWS, Azure, Oracle
Cloud and what not).

The problem in that argument is that there is no problem.

BR, Jarkko


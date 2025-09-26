Return-Path: <linux-kernel+bounces-833860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BDDBA33CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC76762434C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CF72BD5B4;
	Fri, 26 Sep 2025 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cC6TftOz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4D02BD5AD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880226; cv=none; b=fWWBHoD68tVZlg944xuv7LMKcp6dNkDV/kxJ6TKQqYRV4Dndhi/t1pye+zNs22DYAUj2NPzG+x2bUBDZxpNWQim33/0xfGVmZ7X7ff26vQKOxFYGx/8CvcESUODMk0gwYHopZa1ZDr/CDB81s3kZHbQv+WxZNuoFNX5uOOfGS4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880226; c=relaxed/simple;
	bh=K1LIWmxcJgPXbCty1TvudCcCG/Db51jwCowiiS1WLyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdOQ2Gh5Q/PGW2zUVbdBfweI83bDt9EkRMqsqAqdnsJ8Tanm1GE1pzGs26tea4w6mkLmLBkyuN8LptEv4fhfTVUURX2PRKRYRR+dYTCCHeC75P5WQWy3omCHaZpgE5+z/i4hgZHHP3LoxgibLwMjXcAh9oePUhYNYxItKzmaMN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cC6TftOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6347BC4CEF4;
	Fri, 26 Sep 2025 09:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758880225;
	bh=K1LIWmxcJgPXbCty1TvudCcCG/Db51jwCowiiS1WLyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cC6TftOzZulw88Zy/RIdnz49WQvsFfuCTGHjLnGltVCATuNNwJv7JONJztiYMWfYa
	 62whYl/7yz6SRU/zVD91MX5TkSjEv2rdXF6C3UwtczFjrduOaycKKiG3DOKfln+gAq
	 vG1tQjTt8tNeqXiQXkrf1W4piu+vS2z+MnU9t6PAyd0jWzSuY6J9VD4Zl7HZq6eK8K
	 0yjAsjGGNOw4wbF9Lw/I8soG16mFDSgu5Ii1p2iDLwAcIm86pBCEuyiYcjqTDuGNm6
	 o+5MxBesF5tOS590obpAv/TgxXJDuIyyoYUvc2Ev77DN4qQ+4qrZVJbcCcAJBDMC0b
	 moOtbuI0S1uuA==
Date: Fri, 26 Sep 2025 12:50:22 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
	linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture
 support
Message-ID: <aNZh3uDdORZ5mfSD@kernel.org>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <78127855-104f-46e2-e5d2-52c622243b08@gentwo.org>
 <CAM_iQpU2QucTR7+6TwE9yKb+QZg5u_=r9O_tMfsn7Ss7kJbd9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM_iQpU2QucTR7+6TwE9yKb+QZg5u_=r9O_tMfsn7Ss7kJbd9A@mail.gmail.com>

On Wed, Sep 24, 2025 at 11:39:44AM -0700, Cong Wang wrote:
> On Wed, Sep 24, 2025 at 10:51 AM Christoph Lameter (Ampere)
> <cl@gentwo.org> wrote:
> > AFAICT various contemporary Android deployments do the multiple kernel
> > approach in one way or another already for security purposes and for
> > specialized controllers. However, the multi kernel approaches are often
> > depending on specialized and dedicated hardware. It may be difficult to
> > support with a generic approach developed here.
> 
> You are right, the multikernel concept is indeed pretty old, the BarrelFish
> OS was invented in around 2009. Jailhouse was released 12 years ago.
> There are tons of papers in this area too.

Jailhouse is quite nice actually. Perhaps you should pick that up
instead, and start refining and improving it? I'd be interested to test
refined jailhouse patches. It's also easy build test images having the
feature both with BuildRoot and Yocto.

It would take me like half'ish day to create build target for it.

> Dual-kernel systems, whether using virtualization or firmware, are indeed
> common at least for automotives today. This is a solid justification of its
> usefulness and real-world practice.

OK so neither virtualization nor firmware are well defined here.
Firmware e.g. can mean anything fro pre-bootloader to full operating
system depending on context or who you ask.

It's also pretty hard to project why VMs are bad for cars, and
despite lacking experience with building operating systems for
cars, I'd like to believe that the hardware enforcement that VT-x
and VT-d type of technologies bring is actually great for cars.

It's like every other infosec con where someone is hacking a car,
and I seen even people who've participated to hackatons by car
manufacturers. That industry is improving gradually and the
challenge would be to create hard evidence that this brings
better isolation than VM based solutions..


> 
> As you stated, it should not depend on any firmware or specialized
> hardware, hence I am making this effort here. Let's join the effort, instead
> of inventing things in isolation. This is why I not only open the source code
> but also open the roadmap and invite the whole communication for
> collaboration.

I'm not sure if specialized hardware means but hardware features
used by e.g., kvm are not in the category of "specialized", unless
you referring specifically to SNP and TDX?

> 
> Regards,
> Cong Wang

BR, Jarkko


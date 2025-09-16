Return-Path: <linux-kernel+bounces-819235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F35FFB59D28
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C4A3A43FF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D077F223DEA;
	Tue, 16 Sep 2025 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ua1hLY+X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2152420DD42;
	Tue, 16 Sep 2025 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038931; cv=none; b=Inn2olHD3Y0gXR9JfOhw4y3GfH/OZbgKnJddVAhg2Fl5M7l5RFNQzYB+m7/lmFzBtQS/JWDazh6qMEdH3oyg6dTHBzcNnTyF6sSSkrWrzVMcLAkptl4QQn74OuMe21bJJDZOS/evVEQh3FoOBFBmtv2pdsreO2D526jIbRdrXRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038931; c=relaxed/simple;
	bh=5hX+MeZ8vcEMEurO6Y40AR819qOTZbK9YJY3iGxx6k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNdrYPnYCI5Ck9gUT5KOSe5SVbF2p2sEvq4LSfN80gA2q1T1gJ2wgpmEISKbTev1TykJ/OSz/NTkmPM8Sj8+N7npw0IjLI0IJ5slPR22QfWMx6aZ+UnO+AGI5+BwSgyE4kf3WB2H4WVSNAc1oQkrxlwa4eZCf8Uphmcm39fxBEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ua1hLY+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCF7C4CEEB;
	Tue, 16 Sep 2025 16:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758038930;
	bh=5hX+MeZ8vcEMEurO6Y40AR819qOTZbK9YJY3iGxx6k4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ua1hLY+XBsg8eXHWBeeCokC451ULHY3woDF80vGCLpv8zvT5OXl9RngvHcXv1QyWa
	 +iFodlFuB4pfDZ8xLk11FndVKtk9JhvYb0mWGE5B94JrqmFrFeJxGipBlibYu5zal5
	 nOikZ0ATXBUFHmfB7V+I/5aWpjtSDlXy4Qcq7oOT6QBBMLse2pCmqU9OCEsKusiohp
	 O85BEqEmHM51ATbJZcYPJ2UuzPG0soFxApgfQKuxzQJex38+csItNRoEJrVqKdHW4U
	 lDzYjx/6hyh46yGuOeypN5dnd4CKnmCJMJ+wcajPaNA6Yt7uLHTC/EtLW6Or4GJrM2
	 yxwOwNITszBYA==
Date: Tue, 16 Sep 2025 17:08:45 +0100
From: Lee Jones <lee@kernel.org>
To: Corey Minyard <corey@minyard.net>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Corey Minyard <minyard@acm.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net, jeffbai@aosc.io,
	kexybiscuit@aosc.io, wangyao@lemote.com
Subject: Re: (subset) [PATCH v11 0/3] LoongArch: Add Loongson-2K BMC support
Message-ID: <20250916160845.GB3893363@google.com>
References: <cover.1756987761.git.zhoubinbin@loongson.cn>
 <175760122164.1552180.16853979882678693472.b4-ty@kernel.org>
 <CAMpQs4JbQU3D-Bs2687BXSC=FKJBS6RMvWAKb6AJEtzit6hWqw@mail.gmail.com>
 <20250916084002.GF1637058@google.com>
 <CAMpQs4+J2zYgZaGYBSaf4UwzKZY-qMoD1oe2vmgJQXAfghqu=w@mail.gmail.com>
 <20250916101438.GA3585920@google.com>
 <CAMpQs4+kj0i1BpJ4Nk+Z=Ov-AMEWcqPmkbruNhD--TmycX4z-Q@mail.gmail.com>
 <aMl_47OOOotywm0U@mail.minyard.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMl_47OOOotywm0U@mail.minyard.net>

On Tue, 16 Sep 2025, Corey Minyard wrote:

> On Tue, Sep 16, 2025 at 06:51:25PM +0800, Binbin Zhou wrote:
> > On Tue, Sep 16, 2025 at 6:14 PM Lee Jones <lee@kernel.org> wrote:
> > >
> > > On Tue, 16 Sep 2025, Binbin Zhou wrote:
> > >
> > > > Hi Lee:
> > > >
> > > > Thanks for your reply.
> > > >
> > > > On Tue, Sep 16, 2025 at 4:40 PM Lee Jones <lee@kernel.org> wrote:
> > > > >
> > > > > On Fri, 12 Sep 2025, Binbin Zhou wrote:
> > > > >
> > > > > > Hi Lee:
> > > > > >
> > > > > > On Thu, Sep 11, 2025 at 10:33 PM Lee Jones <lee@kernel.org> wrote:
> > > > > > >
> > > > > > > On Thu, 04 Sep 2025 20:35:04 +0800, Binbin Zhou wrote:
> > > > > > > > This patchset introduces the Loongson-2K BMC.
> > > > > > > >
> > > > > > > > It is a PCIe device present on servers similar to the Loongson-3 CPUs.
> > > > > > > > And it is a multifunctional device (MFD), such as display as a sub-function
> > > > > > > > of it.
> > > > > > > >
> > > > > > > > For IPMI, according to the existing design, we use software simulation to
> > > > > > > > implement the KCS interface registers: Stauts/Command/Data_Out/Data_In.
> > > > > > > >
> > > > > > > > [...]
> > > > > > >
> > > > > > > Applied, thanks!
> > > > > > >
> > > > > > > [1/3] mfd: ls2kbmc: Introduce Loongson-2K BMC core driver
> > > > > > >       commit: 67c2639e1fc1a07b45d216af659c0dd92a370c68
> > > > > > > [2/3] mfd: ls2kbmc: Add Loongson-2K BMC reset function support
> > > > > > >       commit: 2364ccc827e44064e9763f2ae2d1dcc5f945fdf3
> > > > > >
> > > > > > Thanks for acknowledging my patchset.
> > > > > >
> > > > > > I can't confirm why you didn't apply the IPMI patch, but this appears
> > > > > > to break the patchset's integrity, potentially causing missing Kconfig
> > > > > > dependencies (IPMI_LS2K select MFD_LS2K_BMC_CORE).
> > > > >
> > > > > Pretty sure this doesn't break anything.
> > > > >
> > > > > What build errors do you see as a result?
> > > > >
> > > > > > Additionally, as Corey previously explained[1], this patch can be
> > > > > > applied through your side.
> > > > > >
> > > > > > [1]: https://lore.kernel.org/all/aFVtNAY4u2gDiLDS@mail.minyard.net/
> > > > >
> > > > > We only apply cross-subsystem patch-sets to a single tree if there are
> > > > > good reasons to do so.  In this instance, I can't see any reason why the
> > > > > IPMI driver cannot go in via it's own repo.
> > > >
> > > > However, there still seems to be a text dependency issue. The IPMI
> > > > patch modifies the MAINTAINERS, which depends on the first patch.
> > > > If the entire series of patches cannot be merged together, does this
> > > > mean the IPMI patch can only be merged after the MFD patch has been
> > > > merged into the mainline?
> > >
> > > No, not at all.  So long as all patches come together during the
> > > merge-window, there is no issue.
> > 
> > OK, I see, thanks.
> > 
> > Hi Corey:
> > 
> > What do you think about it?
> 
> I thought my ack would be sufficient, but I've pulled this into my tree.
> I can't apply the MAINTAINERS portion of this, but that can go in
> later; you can send me a patch for that after the next kernel release.
> 
> I'll make a note to Linus that this depends on the MFD changes.

Feel free to separate that from that patch and I'll happily apply it.

-- 
Lee Jones [李琼斯]


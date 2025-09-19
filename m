Return-Path: <linux-kernel+bounces-824077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D522FB88127
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16FB67B8398
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 06:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0682BEC26;
	Fri, 19 Sep 2025 06:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQVVZekg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49E025A33A;
	Fri, 19 Sep 2025 06:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758265181; cv=none; b=R9DGH8PIByH6XbY7VnUrTTy2dOodri4KM6wu3GETdO/rPU7kEnm97S2TjYZBCc88BBgOoms60cvUui7W+C/3Zsahazt0f05oZlL689zkZWBXfUES/kgMJftibHCuFaUxEmCD88JthIzOVvnMfAQn2n98FfdQxriPkqLOwP4EYlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758265181; c=relaxed/simple;
	bh=mKFe7ErjMyDbh3IfVTq6XcrQTTvr6P3elo0MM+YunJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSx//AunMp6CTw7P9XbqLfQXaMd0W2DNnxbpAPiZJ5r4S9Nd0yhn34Bb6od/9ueT4eQUM8E61fuslu/IO0IZYSamQtI1bZHjHO2lpiaePo5tI6PWDoAiPL7S/XHJJHvCWcAQFRIfUih81fqvsPMqgoLfI1XZTDTMflrNC3/4X9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQVVZekg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC84C4CEF0;
	Fri, 19 Sep 2025 06:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758265180;
	bh=mKFe7ErjMyDbh3IfVTq6XcrQTTvr6P3elo0MM+YunJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQVVZekgpbpP6dmzemqDlDMj+Dk5LqsUBR2UD3mh5vrujVolh6Sm/iGEM6JqH8Dph
	 DiIUDS+vzB6pjzR0csiWINGtk6cinsJ+DybBeSYGcs7lLyO06ym1kwBFdW9C8fJhat
	 jbamDAnmseSFAqwaYQVIP5S0A14qqPlhm8CQTTmgOyLiDHK/acoVb2mvQ86I/jrrCj
	 0By+Ct+pS6D/oAtLd/JsmveZaXl03/PEfYnBwiZ22a9Yni0dFJNWYPNX3HNGHC/yy0
	 CNaiuNvQswoqTJ4LxscqYEmuY35a6qZNnihnzTwgKz9TeeeN6QEnm9E7xZ1c+4eEOj
	 VHdao5sloh6lA==
Date: Fri, 19 Sep 2025 08:59:36 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] of/irq: Add msi-parent check to of_msi_xlate()
Message-ID: <aMz/WBO5r+6dh6Qi@lpieralisi>
References: <20250916091858.257868-1-lpieralisi@kernel.org>
 <20250918135555.GA1540012-robh@kernel.org>
 <aMwjcIS/rvxkSZdr@lpieralisi>
 <CAL_Jsq+XKT+HkE0W0BLKbQ76RtgBrKToLAVaWOy80mLkD=x0+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+XKT+HkE0W0BLKbQ76RtgBrKToLAVaWOy80mLkD=x0+A@mail.gmail.com>

On Thu, Sep 18, 2025 at 02:44:23PM -0500, Rob Herring wrote:
> On Thu, Sep 18, 2025 at 10:21 AM Lorenzo Pieralisi
> <lpieralisi@kernel.org> wrote:
> >
> > On Thu, Sep 18, 2025 at 08:55:55AM -0500, Rob Herring wrote:
> > > On Tue, Sep 16, 2025 at 11:18:58AM +0200, Lorenzo Pieralisi wrote:
> > > > In some legacy platforms the MSI controller for a PCI host
> > > > bridge is identified by an msi-parent property whose phandle
> > > > points at an MSI controller node with no #msi-cells property,
> > > > that implicitly means #msi-cells == 0.
> > > >
> > > > For such platforms, mapping a device ID and retrieving the
> > > > MSI controller node becomes simply a matter of checking
> > > > whether in the device hierarchy there is an msi-parent property
> > > > pointing at an MSI controller node with such characteristics.
> > > >
> > > > Add a helper function to of_msi_xlate() to check the msi-parent
> > > > property in addition to msi-map and retrieve the MSI controller
> > > > node (with a 1:1 ID deviceID-IN<->deviceID-OUT mapping) to
> > > > provide support for deviceID mapping and MSI controller node
> > > > retrieval for such platforms.
> > >
> > > Your line wrapping is a bit short.
> > >
> > > I had a look at who is parsing "msi-parent" themselves as that's
> > > typically a recipe for doing it incorrectly ('interrupt-map' anyone).
> > > Can we make iproc_pcie_msi_enable() use this? It's quite ugly reaching
> > > into the GICv3 node...
> >
> > I am not sure I get what you mean here. Possibly iproc_pcie_msi_enable()
> > can reuse this patch's code if I extend it and make it a global function,
> > yes and somehow use that function to carry out the check for an
> > msi-parent property with no #msi-cells property or an #msi-cells == 0.
> 
> I meant using of_msi_xlate() (or even of_msi_get_domain()).
> 
> > Don't get what GICv3 node has to do with that though, sorry.
> 
> Just trace what the code there does after it gets the MSI parent. I
> didn't study it too closely, but why is a iProc PCIe parsing GICv3 MSI
> stuff itself? There's either some missing feature in the
> irqchip/domain APIs or it's being dumb.

I think it is setting up the host bridge to steer MSIs to the GIC ITS.

Platform specific stuff - nothing to do with irqchip/domain.

Lorenzo


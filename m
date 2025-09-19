Return-Path: <linux-kernel+bounces-824105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE53B88235
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F065217DD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5896429BDB6;
	Fri, 19 Sep 2025 07:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvjzJifU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBA61862A;
	Fri, 19 Sep 2025 07:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758266321; cv=none; b=Z+tOdWYkXD23Xr4RH3IHGBA2TUS/iGpqnN6D7l8IxxqDWFAvCFbLU/FbHpJ9DsEw47KYKUZ3NaM/747bw/0Yzapfu/6h+6PSPnn/mBI8MHiHAN3AECyds1if84F1m9KG6SEnwXprVF24mINpZOfgp81JEMOjOvKgqOkVymRMxc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758266321; c=relaxed/simple;
	bh=5tSIdJQP1tIdIsNeNk84JqAQX+HeQ6XQr+kbFkQIixM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5hrMeV4PokUJ9WnjAUfZlN3zub0l/eVQqejk7akahwI5jO73d7HRkpLpXKE3RjxFYyht4XipJohppho2AT2PNUoNzWqo5Ru0SqbURH1zeLF+Q0QcbQ71YZKofQVc6qpkr0lUfzLxavdu3lCwKFqtGDO6rhP6IKAaCkIsjF4pZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvjzJifU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E51C4CEF0;
	Fri, 19 Sep 2025 07:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758266321;
	bh=5tSIdJQP1tIdIsNeNk84JqAQX+HeQ6XQr+kbFkQIixM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SvjzJifUjhpsXlzjcIDJ8ccaxl9apNLSSwyzS+ME+E9fZdtmTbYdwCjKqP8zlQRzV
	 ukXRsLK+wEfHxVw2IXXHtGgbrKlfiwfDsncuDK2d2IELOSFHBECuMvGg85ZPK3kX7o
	 FpM5wkqNhdVFSFqNrCMHWOSmItQkxZvZCmNghzGr4yJMpkk/kYwl38Iug++0EUj92d
	 lv5Sv2VvwIqTeZaaKvAZQkIHVTPVW3VBARkuKn3tlgtd3ZKInnk+jfJ1SMdWeW+Gwy
	 5ds9wmY8lCbVHAhCqmw23sbhNHl/WuFQMJgrScPk+E4VfV/gEpDpgREuAsWrnMDOVG
	 vD+ZcQhooPZzw==
Date: Fri, 19 Sep 2025 09:18:36 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] of/irq: Add msi-parent check to of_msi_xlate()
Message-ID: <aM0DzMe8qW4eKQBX@lpieralisi>
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

https://lore.kernel.org/all/20240818161816.GA173148-robh@kernel.org/

Isn't of_msi_get_domain() leaking a reference when it finds an IRQ domain and
return ?

Possibly I can generalize it and use it in this patch too.

Thanks,
Lorenzo

> > Don't get what GICv3 node has to do with that though, sorry.
> 
> Just trace what the code there does after it gets the MSI parent. I
> didn't study it too closely, but why is a iProc PCIe parsing GICv3 MSI
> stuff itself? There's either some missing feature in the
> irqchip/domain APIs or it's being dumb.
> 
> Rob


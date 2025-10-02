Return-Path: <linux-kernel+bounces-839846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D7EBB2913
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 07:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70401188C7AB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 05:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F26265CBB;
	Thu,  2 Oct 2025 05:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bbz2hFRz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8362F1482F2
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 05:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759384561; cv=none; b=d+IeWFuOGrl8eoNmsv5erfRPL7YdGS/TVpTJBQcqbkHCWfkQWhW4Y2ytDMWQ6NAAhJvmHb0fKpMxswI5gIl4ff09+0uaZ2fzAJ4wKSdLo6BE1OR2ai5oIOzlBMit27iARK4/YIyZmaSDZ6JbeyER2T+uQkQKrON981WhxLinAcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759384561; c=relaxed/simple;
	bh=sjRl4ou0eow8nXINzPQSF0Bim7bUxidH2Kpa82qrK8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqH/+vvfOtHNPhq2clQQoo6ZdP7Fo/WVBP2APZmJnTT12HxOqBS/zBLX2nCrFDvdaZbMOIp23rAbXsRIc8waoA0CktD4tFxi33rX0+lW/RZewpiINhhv8sZrfwPatoxtaLcBbE7HFEltpeMK9M9tkNfwyMBLgQTc6uzQ9A26Z0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bbz2hFRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B83C4CEF4;
	Thu,  2 Oct 2025 05:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759384561;
	bh=sjRl4ou0eow8nXINzPQSF0Bim7bUxidH2Kpa82qrK8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bbz2hFRz6PwOP+Rj38SocIeZ/Aw08QIhSxdzfqXeull0uO5AiY6dKct8BySSYLhpe
	 B1Gzg3Wly8WIEqGo0wzas3BrcEHdqxAPePhFbmdTvpr7Lu9ypYVxDeyxGIF0QSbwUo
	 t2fs2HBdLGDKiCEd69xm0LTDY/25GoNclKtCDZI8=
Date: Thu, 2 Oct 2025 07:55:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vincent Liu <vincent.liu@nutanix.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Check drivers_autoprobe for all added devices
Message-ID: <2025100209-hefty-catalyst-e5b2@gregkh>
References: <20251001151508.1684592-1-vincent.liu@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001151508.1684592-1-vincent.liu@nutanix.com>

On Wed, Oct 01, 2025 at 04:15:07PM +0100, Vincent Liu wrote:
> When a PCIe device is hot-plugged, or when a VF is created, the
> drivers_autoprobe sysfs attribute is not checked. This means that
> drivers_autoprobe is not working as intended, e.g. hot-plugged devices
> will still be autoprobed and bound to drivers even with
> drivers_autoprobe disabled.
> 
> Make sure all devices check drivers_autoprobe by pushing the
> drivers_autoprobe check into device_initial_probe. This should only
> affect devices on the PCI bus as device_initial_probe is only called by
> pci_bus_add_device (bus_probe_device already checks for autoprobe).
> In particular, only hot-plugged PCIe devices/VFs should be affected as
> the default value of pci/drivers_autoprobe remains 1 and can only be
> cleared from userland.
> 
> Signed-off-by: Vincent Liu <vincent.liu@nutanix.com>
> ---
>  drivers/base/bus.c |  3 +--
>  drivers/base/dd.c  | 10 +++++++++-
>  2 files changed, 10 insertions(+), 3 deletions(-)

If this is a PCI-specific issue, why not cc: the pci developers and
maintainer as well?

Also, a PCI patch shouldn't be for the driver-core only, I think the
subject line needs to have "driver core" in it.

> 
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 5e75e1bce551..320e155c6be7 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -533,8 +533,7 @@ void bus_probe_device(struct device *dev)
>  	if (!sp)
>  		return;
>  
> -	if (sp->drivers_autoprobe)
> -		device_initial_probe(dev);
> +	device_initial_probe(dev);
>  
>  	mutex_lock(&sp->mutex);
>  	list_for_each_entry(sif, &sp->interfaces, node)
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 13ab98e033ea..37fc57e44e54 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -1077,7 +1077,15 @@ EXPORT_SYMBOL_GPL(device_attach);
>  
>  void device_initial_probe(struct device *dev)
>  {
> -	__device_attach(dev, true);
> +	struct subsys_private *sp = bus_to_subsys(dev->bus);
> +
> +	if (!sp)
> +		return;
> +
> +	if (sp->drivers_autoprobe)
> +		__device_attach(dev, true);
> +
> +	subsys_put(sp);
>  }


I don't see why this is specific to PCI VF devices.  Did you see the
recent PCI patch for not probing VF devices that was sent out yesterday?
I think that might fix this instead:
	https://lore.kernel.org/r/20251002020010.315944-1-jhubbard@nvidia.com

thanks,

greg k-h


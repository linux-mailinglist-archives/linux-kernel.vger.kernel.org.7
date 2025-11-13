Return-Path: <linux-kernel+bounces-899467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E264C57D58
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 40978348F0B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B12726CE22;
	Thu, 13 Nov 2025 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3zw7zFF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76CE242D7B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763042639; cv=none; b=ruTE4NeRxaax0qiCs5JOtYNKWcJGxuN35EsHznBiw1TpZKFVPBfAYyA317fEfY6M3BDBD12+x9S0yaD7Va/OUApg20+1BdPtucWUAukVG51CFFDs/QVE4CkdKJKpvF9ahUgjONHL7muNDPLk7PUhiYgAtSCSljVKNagFjCXt/wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763042639; c=relaxed/simple;
	bh=z2x6JxKdxIywACj2Z4cT2SWajXm2/X+gEB4hW4Fsjzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IM4+e94b2bxoOBUVhha3RF8MGtwTNxMSXPH2Tj5V1wFHHLgfM8ncNLgnONmOJuNxdefaqWyitWDhinlpkmXJCGv6TcreUpK5vORvgo6B9bK0RjTLZt0I4AkOdGo5qSSUl5MNfKcWBYrzEcR5ob+VKDoaSig7sIsYa0I6Ytpq8jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3zw7zFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3620EC4CEF7;
	Thu, 13 Nov 2025 14:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763042639;
	bh=z2x6JxKdxIywACj2Z4cT2SWajXm2/X+gEB4hW4Fsjzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o3zw7zFFZ7P5FhXITHwKv+uXXtSaB8fIRWDQ6IH8n58EMXqwnQGjPpFinFgsCpTAI
	 oIreFv4Voj/Hx3/8/bMTjanlhcdfTJpp4xWq9lOofjJkw1Z5Dda0bXSq0mJupBJu1h
	 Byx4yfvb1HvZSVIOs17Cm0ckBtzFpKtmBfWZCwCgJZjvc872jir0j96YlZ4pfG9OUx
	 1m1B40Y1f5FdoIHiDQZNee+GxC4EBLe6fNJwlEM06d/fNLil5OoqR4usjTTaNZO0Jo
	 aZG2UWtJ2hxM/7Zu84AeZozB34suYAI1tZWaDvuxsC4VFot+6tGkGHPW+x5Mnkkrt0
	 0dUuGGYgMmXPQ==
Date: Thu, 13 Nov 2025 14:03:55 +0000
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, linux-kernel@vger.kernel.org,
	Chong Qiao <qiaochong@loongson.cn>
Subject: Re: [PATCH v1 2/2] mfd: ls2kbmc: Use PCI API instead of direct
 accesses
Message-ID: <20251113140355.GI1949330@google.com>
References: <20251030113735.3741913-1-andriy.shevchenko@linux.intel.com>
 <20251030113735.3741913-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251030113735.3741913-3-andriy.shevchenko@linux.intel.com>

On Thu, 30 Oct 2025, Andy Shevchenko wrote:

> There is PCI API to access device resources. Use it instead of

Nit: "There is a ..."

> direct accesses.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/ls2k-bmc-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-core.c
> index 616ff0a28b00..7b0a5fed1d1d 100644
> --- a/drivers/mfd/ls2k-bmc-core.c
> +++ b/drivers/mfd/ls2k-bmc-core.c
> @@ -484,7 +484,7 @@ static int ls2k_bmc_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  
>  	ls2k_bmc_cells[LS2K_BMC_DISPLAY].platform_data = &pd;
>  	ls2k_bmc_cells[LS2K_BMC_DISPLAY].pdata_size = sizeof(pd);
> -	base = dev->resource[0].start + LS2K_DISPLAY_RES_START;
> +	base = pci_resource_start(dev, 0) + LS2K_DISPLAY_RES_START;
>  
>  	/* Remove conflicting efifb device */
>  	ret = aperture_remove_conflicting_devices(base, SZ_4M, "simple-framebuffer");
> @@ -493,7 +493,7 @@ static int ls2k_bmc_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  
>  	return devm_mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
>  				    ls2k_bmc_cells, ARRAY_SIZE(ls2k_bmc_cells),
> -				    &dev->resource[0], 0, NULL);
> +				    pci_resource_n(dev, 0), 0, NULL);
>  }
>  
>  static struct pci_device_id ls2k_bmc_devices[] = {
> -- 
> 2.50.1
> 

-- 
Lee Jones [李琼斯]


Return-Path: <linux-kernel+bounces-899466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 707B7C57D52
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 09DA03440D7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D0E26CE1E;
	Thu, 13 Nov 2025 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dy6fndSs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E750EEBB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763042602; cv=none; b=IV6fyPSYc8Pp1PPe04BUkPY0wOjdWskZ8RnM2XR0sbutYs8Hz2eJq5vItKX82xyjq9ecCWaw9KNnpeBnsDcPHhHYjXXFM4pS+l6TY/XnjGvIsP1HfMda+/hHEzPEGFRexqLEQNrsS2Z20T9I67ajweUIG/2I+SXCwDsqdM3aJA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763042602; c=relaxed/simple;
	bh=RkD3aXfuzMi4KBYIaN14zzvqHv4At5lqCZbDQJko0wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdsOXiDGhd3Npo6XhBCQ1fnMQkcPekDnl7zqoAgKAIs4CJVTa+NTqWkeMnZ1yzp2tfdNGyLSJGgMfJoN18KCC257pRen9kg4a/VzjdHlc4WzlXZjYqOXGv3UwoGeMUu9ZKISUZB1UgbhCFvYGNJVNTXS3NXx1JCrGlf9J2h3CvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dy6fndSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F41C4CEFB;
	Thu, 13 Nov 2025 14:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763042601;
	bh=RkD3aXfuzMi4KBYIaN14zzvqHv4At5lqCZbDQJko0wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dy6fndSscdgvpCF0G0+J7RrZSCTNfES7Eie7ayxkdnTa+4K0zSpdYYJwo9EFXumBK
	 YKlvpHf10C776qNgzL/m+kDcShgFTOHeMCBgYvTuukboxQ9br8CoC4arJAs+qvrwQR
	 1FAYx44QRAMJnTFAIuH4CSHBRdyYBgs8Trm6AZ4m5CSfPlEN+uGlwB5eTWIGJtsq1l
	 Jz16w85KeRz0xom5URRVHw0XcI9MXI+sxrfC2Ig9Gdescjrcrcq194x4vqLrSMT0GM
	 2WyZfamDyPpTrO+qb4/IzaUhDm0HkEHAJt4VUflv5YXHf+QBdyyewOl3hg27VfPq0g
	 FhwXRTaaLOeBQ==
Date: Thu, 13 Nov 2025 14:03:17 +0000
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, linux-kernel@vger.kernel.org,
	Chong Qiao <qiaochong@loongson.cn>
Subject: Re: [PATCH v1 1/2] mfd: ls2kbmc: Fully convert to use managed
 resources
Message-ID: <20251113140317.GH1949330@google.com>
References: <20251030113735.3741913-1-andriy.shevchenko@linux.intel.com>
 <20251030113735.3741913-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251030113735.3741913-2-andriy.shevchenko@linux.intel.com>

On Thu, 30 Oct 2025, Andy Shevchenko wrote:

> The mixing managed and non-managed resources lay lead to all possible

Nit: "The mixing of ... may lead"

"all" really?  Maybe drop that bit.

> use-after-free bugs. In this driver the problematic part is the configuration
> space bits that may just gone behind the functions back, e.g., when interrupt

"have gone", but is this the best way we can describe this?

> is being served. Fix this by switching to managed resources for PCI.
> 
> Fixes: 91a3e1f5453a ("mfd: ls2kbmc: Check for devm_mfd_add_devices() failure")
> Fixes: d952bba3fbb5 ("mfd: ls2kbmc: Add Loongson-2K BMC reset function support")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/ls2k-bmc-core.c | 36 +++++++++---------------------------
>  1 file changed, 9 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-core.c
> index 69387dad6661..616ff0a28b00 100644
> --- a/drivers/mfd/ls2k-bmc-core.c
> +++ b/drivers/mfd/ls2k-bmc-core.c
> @@ -464,25 +464,23 @@ static int ls2k_bmc_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	resource_size_t base;
>  	int ret;
>  
> -	ret = pci_enable_device(dev);
> +	ret = pcim_enable_device(dev);
>  	if (ret)
>  		return ret;
>  
>  	ddata = devm_kzalloc(&dev->dev, sizeof(*ddata), GFP_KERNEL);
> -	if (!ddata) {
> -		ret = -ENOMEM;
> -		goto disable_pci;
> -	}
> +	if (!ddata)
> +		return -ENOMEM;
>  
>  	ddata->dev = &dev->dev;
>  
>  	ret = ls2k_bmc_init(ddata);
>  	if (ret)
> -		goto disable_pci;
> +		return ret;
>  
>  	ret = ls2k_bmc_parse_mode(dev, &pd);
>  	if (ret)
> -		goto disable_pci;
> +		return ret;
>  
>  	ls2k_bmc_cells[LS2K_BMC_DISPLAY].platform_data = &pd;
>  	ls2k_bmc_cells[LS2K_BMC_DISPLAY].pdata_size = sizeof(pd);
> @@ -490,27 +488,12 @@ static int ls2k_bmc_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  
>  	/* Remove conflicting efifb device */
>  	ret = aperture_remove_conflicting_devices(base, SZ_4M, "simple-framebuffer");
> -	if (ret) {
> -		dev_err(&dev->dev, "Failed to removed firmware framebuffers: %d\n", ret);
> -		goto disable_pci;
> -	}
> -
> -	ret = devm_mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
> -				   ls2k_bmc_cells, ARRAY_SIZE(ls2k_bmc_cells),
> -				   &dev->resource[0], 0, NULL);
>  	if (ret)
> -		goto disable_pci;
> +		return dev_err_probe(&dev->dev, ret, "Failed to removed firmware framebuffers\n");

Nit: May as well fix "remove".

... since the patch set doesn't apply.  Please rebase onto MFD or -next.

-- 
Lee Jones [李琼斯]


Return-Path: <linux-kernel+bounces-871543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FB2C0D9A2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 786924F8F38
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E31230F930;
	Mon, 27 Oct 2025 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="1ttVBZ8w"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629F530FF3B
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568223; cv=none; b=kz6roVjqAVX+IEa8hZ7Tt9zKraD3xiFWF03j8uZG5lKq1OCyhTr9jwBgH0JUxNZJokd3hC17x1RTPLvMkxdE5JJIKJR6yqoHVG7subt9efnsbcj8bVvEq9kz5E/7njIK8w1grfe/YSnKLo8Jp5z74JFtvxhB4t4tXrz0iFTaOZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568223; c=relaxed/simple;
	bh=eLQyIPcXagOHVeJ7T1QmYxtkY/1LoZO7/OV1+Imxg8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyGaTn92VlkDlavxi/itu5ZLLvlUt5qwtvBe7EDnDipqOzUkoDi5TDhKEETBNkXwvocvsa15aSNUvCDhein0v8kvWBSApJwHDMIz2jmKowFu2qCR261JR6U7y9V6IrnLaodJ7lfAtQjg2yco5LTDkjiqr4AEyjfIe86ay9THktY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=1ttVBZ8w; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1C44D59903;
	Mon, 27 Oct 2025 13:30:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1761568219;
	bh=eLQyIPcXagOHVeJ7T1QmYxtkY/1LoZO7/OV1+Imxg8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1ttVBZ8wgoNk7NvrIGfQdHOZsqEKmSTndxKtmT77RzDVNjRxqaplshCssnkK18Flj
	 4smnQLV/5ZGJIMnuxxeTzhp3SsrvMyriOF93Po6HtmGqw3wMncobqQoL4Au3v1Hsrn
	 w8LkIimq7DSUO+BskpRwvhbkXwLmak20NrRMsQ+dKjomr5F3/tySafzxT5yHKYXEsz
	 62j49uZkWG4lqHn2jsF2jy6p1ecjGfQqwmH3Q1UZvLsRDt9ziDogOKoIEPIhBXyYF4
	 DKf6BjMFeio5S6RSNmRDUd5zF9GBUkEP30yCqNzEO/ucNpDXnH0MxQemz/YqIMPf5a
	 1AWESwoGwE1Zw==
Date: Mon, 27 Oct 2025 13:30:17 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: suravee.suthikulpanit@amd.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu/amd: Enable PCIe ACS only if AMD IOMMU is on
Message-ID: <3agjkv6s4zk6y4ir7ix7bnqeoxl6i63hcwwksh6dews3wg7v3h@wm2nopcqv6yo>
References: <20251011031448.2699-1-guojinhui.liam@bytedance.com>
 <20251011031448.2699-2-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011031448.2699-2-guojinhui.liam@bytedance.com>

On Sat, Oct 11, 2025 at 11:14:48AM +0800, Jinhui Guo wrote:
> To preserve PCIe performance, ACS is enabled only when
> AMD IOMMU is not disabled.
> 
> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/init.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index f2991c11867c..38e8c38c5f10 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3314,8 +3314,10 @@ static bool __init detect_ivrs(void)
>  	}
>  
>  out:
> -	/* Make sure ACS will be enabled during PCI probe */
> -	pci_request_acs();
> +	if (!amd_iommu_disabled) {
> +		/* Make sure ACS will be enabled during PCI probe */
> +		pci_request_acs();
> +	}

Instead of checking amd_iommu_disabled here it is better to move the
pci_request_acs() call to early_amd_iommu_init(). This function is only called
when amd_iommu_disabled is false and runs still before PCI probing.

Regards,

	Joerg


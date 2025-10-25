Return-Path: <linux-kernel+bounces-869903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B23B3C08F77
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 13:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DACC4E4490
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 11:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3FF2F7471;
	Sat, 25 Oct 2025 11:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrWPmUgv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FF917C21E;
	Sat, 25 Oct 2025 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761391990; cv=none; b=jL/CrhFd3jOI0TeCvRrtcRBWjOtk1X1Qwsgq9sVtYwry8mSnFWcpta5QEZrnpBbcRrhkS3FLjpNpOLVvTtSg+/ziDwyihZQfYGuo/zzN/+IoBza8cUBb5Mp63z3PEZ/8CnGV3KV/wAhUExCXpP/Cp4DvoW3aDcNvzHMiB6ux8Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761391990; c=relaxed/simple;
	bh=ezU1DRuGnsw3vL5rtzM9FxW6SZkGjKTA78pL3akBlcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PkH9NeB3tjXau2BaUUE1G29F0LDVh/G2ALbQvL4N1PsfGTNKqXecoXLNmFCwgb42fc46+9ufnTxWuPsOvmPrIKhoeQNA/rUXzh/FTMV0H+4E2IGEgJ2+aXM9JzyCorDaY3jzaD9IAMc+9ZOaZqfWdpL4giv/hMQxtbNnKg4A7j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrWPmUgv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8A8C4CEF5;
	Sat, 25 Oct 2025 11:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761391987;
	bh=ezU1DRuGnsw3vL5rtzM9FxW6SZkGjKTA78pL3akBlcc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XrWPmUgv9wm7Xf+5SoC4m4HgmwHOgp+cOLmMOL/7gJZTq/cTMIVWhGrE+wUgjK6QR
	 svfNZxO3UKMHSD9ahwZiJRKu8tgQkdFirbzfB3cd37HDG1UTh+HsHpmJPwrwnTX8gC
	 s0jUW5IN3YboJB+GJcZXPMqGX3Qwqk5TMyibS2CVpj9NvMAu2m87i2fm0Zjh11kMpC
	 +p2tnpMRDiDJVB7tQJPrw5E8m2bJu1dbR1uX+ZQmhtCwAqKh2QqGEakZHPv18+1z5y
	 AGl/uZfLEDSJf3lr+UAOzS3c6/Fkrdvj7RdFlg2V44gGiMtZRl4DTXDdAusZ1kaQuL
	 VSM6s+ervkFoQ==
Message-ID: <a2fc02e2-d75a-43ed-8057-9b3860873ebb@kernel.org>
Date: Sat, 25 Oct 2025 13:33:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] misc: rp1: Fix a reference leak
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Andrea della Porta <andrea.porta@suse.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <8f55f8866a6680830c9d318201a29293ac50a591.1761334487.git.christophe.jaillet@wanadoo.fr>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <8f55f8866a6680830c9d318201a29293ac50a591.1761334487.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/10/2025 21:36, Christophe JAILLET wrote:
> The reference taken by of_find_node_by_name() in the probe is not released
> in the remove function.
> 
> In order to avoid a reference leak, use cleanup.h to automatically
> release the reference at the end of the probe when it is not needed
> anymore.
> 
> In order to do so, a reference also needs to be taken when DT is not used.
> 
> This simplifies the error handling path and makes direct returns possible
> in several places.
> 
> While at it, also add a missing \n at the end of an error message.
> 
> Fixes: 49d63971f963 ("misc: rp1: RaspberryPi RP1 misc driver")
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is compile tested only.
> 
> This change is speculative. Review with care.
> 
> Changes in v2:
>   - implement Dan's suggestions
> 
> v1: https://lore.kernel.org/lkml/4e92a271fdb98560c4e659556a1f3e99e7d0d38e.1760987458.git.christophe.jaillet@wanadoo.fr/
> ---
>  drivers/misc/rp1/rp1_pci.c | 42 ++++++++++++++++----------------------
>  1 file changed, 18 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/misc/rp1/rp1_pci.c b/drivers/misc/rp1/rp1_pci.c
> index 803832006ec8..0abfeb4a28e3 100644
> --- a/drivers/misc/rp1/rp1_pci.c
> +++ b/drivers/misc/rp1/rp1_pci.c
> @@ -5,6 +5,7 @@
>   * All rights reserved.
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> @@ -185,9 +186,9 @@ static void rp1_unregister_interrupts(struct pci_dev *pdev)
>  static int rp1_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	u32 dtbo_size = __dtbo_rp1_pci_end - __dtbo_rp1_pci_begin;
> +	struct device_node *rp1_node __free(device_node) = NULL;

This is not recommended way of using cleanup. You should declare it with
constructor.... if you cannot that's strong indication you are not
suppose to use cleanup.

>  	void *dtbo_start = __dtbo_rp1_pci_begin;
>  	struct device *dev = &pdev->dev;
> -	struct device_node *rp1_node;
>  	bool skip_ovl = true;
>  	struct rp1_dev *rp1;
>  	int err = 0;
> @@ -200,42 +201,40 @@ static int rp1_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	rp1_node = of_find_node_by_name(NULL, "rp1_nexus");
>  	if (!rp1_node) {
>  		rp1_node = dev_of_node(dev);
> +		/*
> +		 * Take a reference to match of_find_node_by_name()
> +		 * behavior. This makes cleanup.h usable in both cases.
> +		 */
> +		of_node_get(rp1_node);
>  		skip_ovl = false;
>  	}
>  
>  	if (!rp1_node) {
>  		dev_err(dev, "Missing of_node for device\n");
> -		err = -EINVAL;
> -		goto err_put_node;
> +		return -EINVAL;
>  	}
>  
>  	rp1 = devm_kzalloc(&pdev->dev, sizeof(*rp1), GFP_KERNEL);
> -	if (!rp1) {
> -		err = -ENOMEM;
> -		goto err_put_node;
> -	}
> +	if (!rp1)
> +		return -ENOMEM;
>  
>  	rp1->pdev = pdev;
>  
>  	if (pci_resource_len(pdev, 1) <= 0x10000) {
>  		dev_err(&pdev->dev,
>  			"Not initialized - is the firmware running?\n");
> -		err = -EINVAL;
> -		goto err_put_node;
> +		return -EINVAL;
>  	}
>  
>  	err = pcim_enable_device(pdev);
> -	if (err < 0) {
> -		err = dev_err_probe(&pdev->dev, err,
> -				    "Enabling PCI device has failed");
> -		goto err_put_node;
> -	}
> +	if (err < 0)
> +		return dev_err_probe(&pdev->dev, err,
> +				     "Enabling PCI device has failed\n");
>  
>  	rp1->bar1 = pcim_iomap(pdev, 1, 0);
>  	if (!rp1->bar1) {
>  		dev_err(&pdev->dev, "Cannot map PCI BAR\n");
> -		err = -EIO;
> -		goto err_put_node;
> +		return -EIO;
>  	}
>  
>  	pci_set_master(pdev);
> @@ -243,13 +242,11 @@ static int rp1_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	err = pci_alloc_irq_vectors(pdev, RP1_INT_END, RP1_INT_END,
>  				    PCI_IRQ_MSIX);
>  	if (err < 0) {
> -		err = dev_err_probe(&pdev->dev, err,
> -				    "Failed to allocate MSI-X vectors\n");
> -		goto err_put_node;
> +		return dev_err_probe(&pdev->dev, err,
> +				     "Failed to allocate MSI-X vectors\n");
>  	} else if (err != RP1_INT_END) {
>  		dev_err(&pdev->dev, "Cannot allocate enough interrupts\n");
> -		err = -EINVAL;
> -		goto err_put_node;
> +		return -EINVAL;
>  	}
>  
>  	pci_set_drvdata(pdev, rp1);
> @@ -295,9 +292,6 @@ static int rp1_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	of_overlay_remove(&rp1->ovcs_id);
>  err_unregister_interrupts:

And gotos is another strong indication that you should not use
cleanup.h. See cleanup.h for further explanations.



Best regards,
Krzysztof


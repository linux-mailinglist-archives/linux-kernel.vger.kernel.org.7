Return-Path: <linux-kernel+bounces-862597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493FABF5B69
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064F33BF7F8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2426328B7C;
	Tue, 21 Oct 2025 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b2fmxSKX"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EE923D7CA
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041501; cv=none; b=qaSTKuL6reXWoVsP8DjORRz2xILWV4/czRcjvLqvY5WjHhyoEojZJLy4eMzyW8MRSzruBUnQzlIl9PDbUsKpWDa0Ok3FyA88vB1WxsxYriOULQaRQHyiQSqETu2VA4ccaEwHyhQsbOTQ0gN0EfjRFIG0U8rPW+pAkBnWop3DDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041501; c=relaxed/simple;
	bh=WiMf9dKx3lK/m+WFc7bYk8BEVUV+C2IpEy0TaPV7vQA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kP+RGF0SaY8NY/bujUISL1nFI1Sq+HX2QCZQmH+wb/OIBsQ+j5C58qy0Ry6lOPg2KiKvJKBg0N43bP0yNf4A8fz4A2h3HkzHWFe+P2rkA1cp1uhC/fsy+fI7dJsYndQGogdb+peqs/s+JwYdLcY94aj2tkdK8GC8+rh4Mvhlh1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b2fmxSKX; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so1090227166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761041498; x=1761646298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nWn298GnuRBsbGfuPpfpx5jbtRMR1Y9OyRz1ODcUKUo=;
        b=b2fmxSKXL0wByu96jWuJXkdBj6GoTipFb/7tR6QSYay2JhCAzKEpCH1Tz34LEnCi2c
         fpnLy5f2ft8802Fpb2c0gwu04bx/car4w6S/ikv2DthfS7lQrUjBWhbxSwBhjQaLABrH
         zRESNVJhXDMnQgVWwb7hK+nurwADTfrmCh5Np0mlXgWTcj+h5w/rJd3borkya2b/A4wX
         nYTsyg/TkQdB0X+vOLrjK0Z3lf2BNyJ8vNcTg7Q+Ady9ancLfefvtlwi/8L9B1wMyZQv
         mj851BawoNRK8mvj48BP/ygNrEZJqjPjje5WWj/XUyE6z0wh+nHXFeA0/qTb0taJDImx
         N34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041498; x=1761646298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWn298GnuRBsbGfuPpfpx5jbtRMR1Y9OyRz1ODcUKUo=;
        b=vlK+BTxzeK6FBbvi5SHA5UCmk+EUCdMFKBs0dFZbyPIvv4z81pC4GyEvEyHC0cScVh
         TpA2xvn/qtui1zCVto036dyfA/qaUthC0bNfQONaZOzXqgtmbsYa7qMYvPtRGHTVwgLz
         snTQ6TyfayojkN4bOEZ/v5qfWy+2ks+hzOQzB4szN5TLtnp3/TmdHELfwldMzEe72Xxk
         JuNUhlk1lqLs+HbFmxFJNCAIOWRR01Ke34LDyQ3s/9gq/P02kExFBTMu2uFhNTH0g/ne
         UKmrTflAzdjVTvfmVLSmUEtaV6I22r6WXuKcuDXY3bINMYkRJMieOABm87PVxlRfNwfu
         bMUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV74aMp8rKNYeAZg3taVhV5ZR9tr8Q7K/kzNUDaRVfWh1DNRQ8r8N21EpLr0gtnuxYVbvHZG6EGpG98CU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YznoNl2wEBxmb4wlVfuyh6x53OiSC/RVsL+hY8pX0jm4KstNPPn
	8KYDLSvKGvdwthVx1zEG0cISFjQdwrakgwPtyufAka2mJvSYTT5WzDdAMBViQp9aJ0c=
X-Gm-Gg: ASbGncufcjz+WjdLPXvNINZggDsVzWv4k3P3X9WlDGMw5DHyAeO8s5O+9QUeOlL8egH
	GdZVcjpvuIkUUjlbT0n6nGxUFuEi4WQ8w3BA40qT/FUzmk4Pxfca+iwNwkxypVFTcFqIUy+zpBk
	4A+jsd3gWcS/kPZ7d/MWOw0euOToxsoFbxXJPjqN34ubq1BSOUUXkzUpjVok4p7qwM9vOmTJ9qe
	eicaDgJrRxD7P6DwuKX2nH7kfMvqrMk4Cj5chm8745fXYeTYxBTA3WF+xPldFYD/Q4Rs8JxwLry
	EyMOWFsNkGXMDf95ZMrmsCQNat0DjIGAfLnvz0ZLYi4GcsR3gTIll8b+gNGbboUUlo1Kf5VkY1C
	2QRbBNZcHyZ3vfUF6aawsKnghAMcs4fU3q0w4WacIhHGLxngD+D0xQrpVPRgLEbQ4x2lMFQ/G5W
	NYN9U6a8rSN0cTpvh4X6Gf0rTg98XHht3vCOTW1guTV1O13jGIrXY=
X-Google-Smtp-Source: AGHT+IGtc+wMv+0/UvOWo4ZlIFtKwvrLvoQzsHEcKxZ/ii2ij83WJTxb9LrL3zXX8owfzEY1HOLjPA==
X-Received: by 2002:a17:906:dc90:b0:b3d:c47c:7ce9 with SMTP id a640c23a62f3a-b6475706b58mr2122637066b.54.1761041497898;
        Tue, 21 Oct 2025 03:11:37 -0700 (PDT)
Received: from localhost (host-87-9-62-200.retail.telecomitalia.it. [87.9.62.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8391547sm1041437966b.22.2025.10.21.03.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 03:11:37 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Tue, 21 Oct 2025 12:13:49 +0200
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Anand Moon <linux.amoon@gmail.com>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] misc: rp1: Omit two variable reassignments in rp1_probe()
Message-ID: <aPdc3Zm4GrJUs9s3@apocalypse>
References: <28b3e6b0-0090-4256-8dd6-5a01fc4bd576@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28b3e6b0-0090-4256-8dd6-5a01fc4bd576@web.de>

Hi Markus,

thanks for your patch!

On 15:00 Mon 20 Oct     , Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 20 Oct 2025 14:51:43 +0200
> Subject: [PATCH] misc: rp1: Omit two variable reassignments in rp1_probe()
> 
> An error code was assigned to a variable and checked accordingly.
> This value was passed to a dev_err_probe() call in an if branch.
> This function is documented in the way that the same value is returned.
> Thus delete two redundant variable reassignments.
> 
> The source code was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Andrea della Porta <andrea.porta@suse.com>

> ---
>  drivers/misc/rp1/rp1_pci.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/rp1/rp1_pci.c b/drivers/misc/rp1/rp1_pci.c
> index 803832006ec8..3baea1a24549 100644
> --- a/drivers/misc/rp1/rp1_pci.c
> +++ b/drivers/misc/rp1/rp1_pci.c
> @@ -226,8 +226,7 @@ static int rp1_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	err = pcim_enable_device(pdev);
>  	if (err < 0) {
> -		err = dev_err_probe(&pdev->dev, err,
> -				    "Enabling PCI device has failed");
> +		dev_err_probe(&pdev->dev, err, "Enabling PCI device has failed");
>  		goto err_put_node;
>  	}
>  
> @@ -243,8 +242,7 @@ static int rp1_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	err = pci_alloc_irq_vectors(pdev, RP1_INT_END, RP1_INT_END,
>  				    PCI_IRQ_MSIX);
>  	if (err < 0) {
> -		err = dev_err_probe(&pdev->dev, err,
> -				    "Failed to allocate MSI-X vectors\n");
> +		dev_err_probe(&pdev->dev, err, "Failed to allocate MSI-X vectors\n");
>  		goto err_put_node;
>  	} else if (err != RP1_INT_END) {
>  		dev_err(&pdev->dev, "Cannot allocate enough interrupts\n");
> -- 
> 2.51.1
> 


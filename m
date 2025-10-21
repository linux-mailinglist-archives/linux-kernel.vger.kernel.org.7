Return-Path: <linux-kernel+bounces-862918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B80DBF686E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22236503E09
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A837F332912;
	Tue, 21 Oct 2025 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aysCUjlf"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE266331A5C
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761050768; cv=none; b=N7T0BEW8fyRtzpwCec1j8yCAaoQ8tNTs5GQU/rJ8+yvoJ5mNrrM7ckwOsqRHAOPsRPBHQju7W2+6EvDivqzkLin/X4d/aYytEBX0edFDSrOiH+6ysNQvWUGvkTxGBSC+CD+3WcOt+3jBpDRTeIuQe7buG5X+DK/qn1hltd5sBQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761050768; c=relaxed/simple;
	bh=QIFsKITDeO14f22yjRcsI1tvABH66DujhBaXrZO3X1s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOBDPP/BkoG0ttOvkIf3FQImlY0cp8TwnSkMsk80ZkImKI2FQq7keA3Z23jYWTxaQKM8iM3AKgsbKvzJpdNPyloflt70eDvYfg7OANR8GDb/dnxZDoSx/Jtst7VnCsY8SoFxnRWiGkHS2kLYK6cqn1pOhqEg9fYcvCr5xyyDoqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aysCUjlf; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b6bbfc57b75so318545866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761050762; x=1761655562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gPEA5AJ6rJJ5XwW1iyN0mjNhsPIcrDuB2VtGOFvKXMA=;
        b=aysCUjlf8yuGqOGBAkgYTutoyUmepx89wGm46yCulA5CSmPb3qMrnsChi++mfdvfO/
         8CpZfvYsPToVCpaW+U2FpGP5Nqt8jslgDryRrDKYfqUB+UQqdV2+qJzkvQuIMuQYQAzn
         wG1YSfMzHUygBs7GD4BfiO3dpZnMOiYsxulvjB3ps+jcH2ruV9++q8QvVHAXfG4D70RF
         ah50snwzx0ysqSpGFDls8bEo+O9yYpg2AElOHTR7J3mvLYNxC/OshhdxjcngF9RNTCGX
         z0QwRCq/pbhKP0zxF2Zkl/1L5sPRjdhE+4cbOSuoe+o3KMlwH8w11lRIcjDR385fFiWf
         4RTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761050762; x=1761655562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPEA5AJ6rJJ5XwW1iyN0mjNhsPIcrDuB2VtGOFvKXMA=;
        b=E29YonxbLSVcoNTXqrJpIBT0LfoFftRrHuiY1Yb49zYbicSkn2fWG512ihvh3IQ0zo
         2F0wKHMxCONn3OHxryElFXGOog3uIkulNBrGt5/IgSyKNi/muvHy3ouBFqZauhv4eL5u
         kuyUhksIJ8dGf2gA90WFSmwoMuR5RR291yrkhg5itOeuhq7qQRVdLK+w4npVg6R/5+K6
         AVeWdUzCgG1h+3gEFuccjM5sw/AMPJ/D2+mwWjhf8JBvbNtGmNGeiwVaKeBRCP8qepra
         xKpBj2Qa0xEMHLyMCV9g2evvXvqTdUVUpzQIwuvPZO9pTpsOyWbrmHF7bb44Gyc7BJsp
         tNeA==
X-Forwarded-Encrypted: i=1; AJvYcCWQtG0GXxofWnYgh5TpHSEHHVzHtKpkRqcGA6mxsw2INfms62Y7uHGK5I/Ftvrjqm5BD8VZ00/23oyqYMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk7Z6mnZ2GT0DjwfBGPzLo+ZQNhP4b6RZqKEfa8DNTgW86E0lm
	3h04UhpyVC7ysNuthHjJknwRgQ+ylzoFYPJVtICr3G/F9Gbvb/dv4n6lP/WjpgDJJ58=
X-Gm-Gg: ASbGncuKUNK4XrUlZ7Hqp2synR/tMXWcu5sHqBFYoaT6LY/GwMzk19yuiBV4/1yxpUK
	7G3QMzlj+oxUr9azSM/ype7M7yOYPxy812cwwZgWGMGMV24isqJ8ELgqNnJFpmNrx2NzKfDkSjH
	ow8phTVtp2VWKkVyZyqAJqoa/34DRSGx/TY0ae7t1Iu21/vwQKnyjgpQ5FdT3WI23bvfCobns5E
	LNpoFP3F5zUGhFFprXgSAYfRpMbxMosiKe3KLsD7fKU7/7KqGD5bwgGrgAyVof1TnSIuhiINT3p
	QvVI/tW1x3Ih0ccANy42D9GBsAyGHg5ALCyEsy//+b5J/F2BlWCguBg0AH3eXqz1lTcWKMwiG0Z
	na5ALMrIki2bxrkpanYa/b+oEYSVvy88yfr1OMg3yOO7psnhr/h5LLoTI9OVLBTMXSgKwFxLL1V
	XpuY9pssB1xJdsAuv2oiXqE+b9i4NndTQVWcXQ7e6q
X-Google-Smtp-Source: AGHT+IErY7EU44w5k9OeH3Q13um8hP0cnU0hb65JCssR27vMTstr7rVqdpDS7r8Zy3EePCbIn+wClw==
X-Received: by 2002:a17:907:6d0d:b0:b40:bdc3:ca04 with SMTP id a640c23a62f3a-b6459d3039bmr2269518066b.0.1761050762288;
        Tue, 21 Oct 2025 05:46:02 -0700 (PDT)
Received: from localhost (host-87-9-62-200.retail.telecomitalia.it. [87.9.62.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e83914d0sm1052945566b.21.2025.10.21.05.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 05:46:01 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Tue, 21 Oct 2025 14:48:14 +0200
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] misc: rp1: Fix some error handling paths
Message-ID: <aPeBDmeBGWDEKp05@apocalypse>
References: <4e92a271fdb98560c4e659556a1f3e99e7d0d38e.1760987458.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e92a271fdb98560c4e659556a1f3e99e7d0d38e.1760987458.git.christophe.jaillet@wanadoo.fr>

Hi Christophe,

On 21:11 Mon 20 Oct     , Christophe JAILLET wrote:
> Error handling in the probe and the clean-up path in the remove function
> should be adjusted depending on if data is taken from DT or from overlay at
> runtime.
> 
> of_overlay_remove() should not be called when of_overlay_remove() was not
> called.

on the second occurence:
s/of_overlay_remove/of_overlay_fdt_apply/

> 
> of_node_put() should be called in the remove function to avoid a potential
> reference leak.
> 
> Fixes: 49d63971f963 ("misc: rp1: RaspberryPi RP1 misc driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is compile tested only.
> 
> I think (hope...) that a cleaner solution is possible. So feel free to
> improve it or completely change it if needed.
> ---
>  drivers/misc/rp1/rp1_pci.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/rp1/rp1_pci.c b/drivers/misc/rp1/rp1_pci.c
> index 803832006ec8..9105269488a9 100644
> --- a/drivers/misc/rp1/rp1_pci.c
> +++ b/drivers/misc/rp1/rp1_pci.c
> @@ -44,6 +44,8 @@ struct rp1_dev {
>  	struct irq_data *pcie_irqds[64];
>  	void __iomem *bar1;
>  	int ovcs_id;	/* overlay changeset id */
> +	struct device_node *rp1_node;	/* useful only if skip_ovl == true */
> +	bool skip_ovl;

can we initialize ovcs_id and use that instead of skip_ovl? This
would save one flag.

Many thanks,
Andrea

>  	bool level_triggered_irq[RP1_INT_END];
>  };
>  
> @@ -289,10 +291,14 @@ static int rp1_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		goto err_unload_overlay;
>  	}
>  
> +	rp1->skip_ovl = skip_ovl;
> +	rp1->rp1_node = rp1_node;
> +
>  	return 0;
>  
>  err_unload_overlay:
> -	of_overlay_remove(&rp1->ovcs_id);
> +	if (!skip_ovl)
> +		of_overlay_remove(&rp1->ovcs_id);
>  err_unregister_interrupts:
>  	rp1_unregister_interrupts(pdev);
>  err_put_node:
> @@ -308,8 +314,12 @@ static void rp1_remove(struct pci_dev *pdev)
>  	struct device *dev = &pdev->dev;
>  
>  	of_platform_depopulate(dev);
> -	of_overlay_remove(&rp1->ovcs_id);
> +	if (!rp1->skip_ovl)
> +		of_overlay_remove(&rp1->ovcs_id);
>  	rp1_unregister_interrupts(pdev);
> +
> +	if (rp1->skip_ovl)
> +		of_node_put(rp1->rp1_node);
>  }
>  
>  static const struct pci_device_id dev_id_table[] = {
> -- 
> 2.51.0
> 


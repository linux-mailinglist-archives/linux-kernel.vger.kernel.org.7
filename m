Return-Path: <linux-kernel+bounces-817143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70772B57E6D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C411680EF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B4D313557;
	Mon, 15 Sep 2025 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="iuaJnCDi"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F295A3101AE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757945333; cv=none; b=pSi0LtNqQzQWxLv+0ThHGXfVCvEsUwXEeMmfpOu13RlJzHUOxyk0+T2eUh/s/mnz9Nz10CN53+8BWNbM5hFt5qQV/z6oGTIw+vdcfHEXGIiervticTrYkXxiypX7WcWteXSJdyoqQJN7TjgC24akH+OCXv1W9C02KqgrAQGyRRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757945333; c=relaxed/simple;
	bh=CFdz9SBebPziM2fQihiODisdksPGhrdbkpIvqubAghI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2Sw6bcK/gyWQ5vZS0hINTJIAiN+uL229dBOzukIhwSCcJ6hRT4A4BYw3k0E2c5HKs9Lqdb2dJAqECp8S3S5iKjePGMCnb9dlHQ/D6nXsLbF/cAbzdX+h58dN5ahLgQ9iNSTM1b1fHWgUtK9msLILGHydoWn+C7iZCSCWLV3EjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=iuaJnCDi; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-78393b4490cso8896266d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1757945331; x=1758550131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bT/fKPYPqCKNM08+lHlTAaEmzw06dWk4v6JQAr9+btc=;
        b=iuaJnCDif0E82LxhFJpb+snLTcMHd2LMw9oN5oMEPM4wL29dmPBmp2Mqlg/gtVY/hF
         9tjxGpGDbjqfeB0Npgkme5Zm2Qk1VhyDjMDx1kP5zINIu8GIkBaVbfHcmdROndbKo7rZ
         6BNAVfPSy96b8osIo/Gc7+Ns8gNZUglXjG5VUexG5mx+dNZEnQLDv+5j7i1+gN8cV0z+
         UmVWDGdpnAubZJwMCP3j7KeVbGsl35x2qzSqi7e66c1qDmcQbnyQWs8qeVrjipLFwsHW
         iqUWjW2wbG4445OVEA813kIht04EA3+S6+qt11T+bgslm9z/ZeZhaqkKrg7vdtlHmj05
         pREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757945331; x=1758550131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bT/fKPYPqCKNM08+lHlTAaEmzw06dWk4v6JQAr9+btc=;
        b=Vguo18qOyoLR0Un2Rdy7oNGCLacLqxAd4eKLteJUm7eS2cCx5tB1wnQn4BL6+zN71c
         vHt3HOkF6xNCCbAYimNaoSMAOZ4BJWOhEYIJ4CSLfexw5SNDApzTFvYNLODgGLQtg7HE
         rzZxZQBhZU4M4c/l5DY3+VrlYfLCjnpKv8dxBJuaUZ2cp1fVs5HJ0Tr1DNL3XXPS5Pb5
         vN8pVdx8Wb6+oK+Ilyd+FITv1bdMnJ9eSn13sfHLCQZFGnq3rpBp/mRr8T1ojUREbLmL
         2HH0fbRUNLsEZCSxqTcPOvBrZjt07vkhZjIg35KfNGEl6GciCupSeJVbM8mFJfvmgCBX
         RCPA==
X-Forwarded-Encrypted: i=1; AJvYcCXfzUcAj9xCJ3dDPjl4jTbjU+RDzawrwrorC0N2dBKUsBNEYVFhOvRuPiOLApHQ2E3rSDNrG/VKCQUbvDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCLGwYLPl3OibsK4eC/R6EEe3H/VPNhe7qX2Gd9OI6t2lUreHT
	9hOmNnG5Kp6rO5rzlXcoWXveUkE7VYWpGTtK36rLy0aXlBw1HdTOwUsOzAQxr0e/BQ==
X-Gm-Gg: ASbGncv0FOJ3iAXb4ZWrEpDVqw1lLdg8ulUlNTL3Bzj5CjrGTp13ajH4NciFwPhk8N/
	lSPa0WloCYuQZTmpI/VDqqgrCYGK29p/1zKurkUunUhuaWGdCG5Ip7+s4Frq0uQtrIOdjl5zXEr
	LC6sqBU3Ypq62O6sdlBX/HYWcTHI+r/ZmC8FnyBvwx+I2CMSvhDNfecc58gz6Xz1AOfcCw5Csnj
	qcQJEZpv+NdOHESUKc2O76fl6KbOtKuGZmL0R1e/7XoDpU6sTRIgR7G6ONkyCoaV1V7cFjkbbfl
	Tl0UFY5kPwJyDB4wVkv8HOijbvIoJleI8QnkJ/i9LBHpIIPjwVPsu+G7fW+ynF8CvA8DqLcrVlU
	iETrCh94IBTJBxvaUZ+x4fV2nvDWErw2wAMpdpobMJA==
X-Google-Smtp-Source: AGHT+IGgUoL7jLIBaXg5mPC5yFH8zCfSY55YjyfTo82yTMlTSMjgpi1YulLIkoPwfHcFLdYBMd00kA==
X-Received: by 2002:a05:6214:d83:b0:72a:1744:aa07 with SMTP id 6a1803df08f44-767c410ad98mr176817436d6.45.1757945330498;
        Mon, 15 Sep 2025 07:08:50 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-787dba7125bsm10991896d6.6.2025.09.15.07.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 07:08:49 -0700 (PDT)
Date: Mon, 15 Sep 2025 10:08:47 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] usb: uhci: Add reset control support
Message-ID: <3cf94df2-48e1-4cbe-8f0a-84f05cb9760d@rowland.harvard.edu>
References: <20250915073926.3057368-1-ryan_chen@aspeedtech.com>
 <20250915073926.3057368-3-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915073926.3057368-3-ryan_chen@aspeedtech.com>

On Mon, Sep 15, 2025 at 03:39:24PM +0800, Ryan Chen wrote:
> Some SoCs, such as the Aspeed AST2700, require the UHCI controller
> to be taken out of reset before it can operate. Add optional reset
> control support to the UHCI platform driver.
> 
> The driver now acquires an optional reset line from device tree,
> deasserts it during probe, and asserts it again in the error path
> and shutdown.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  drivers/usb/host/uhci-hcd.h      |  1 +
>  drivers/usb/host/uhci-platform.c | 19 +++++++++++++++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/uhci-hcd.h b/drivers/usb/host/uhci-hcd.h
> index 13ee2a6144b2..4326d1f3ca76 100644
> --- a/drivers/usb/host/uhci-hcd.h
> +++ b/drivers/usb/host/uhci-hcd.h
> @@ -445,6 +445,7 @@ struct uhci_hcd {
>  	short load[MAX_PHASE];			/* Periodic allocations */
>  
>  	struct clk *clk;			/* (optional) clock source */
> +	struct reset_control *rsts;		/* (optional) clock reset */
>  
>  	/* Reset host controller */
>  	void	(*reset_hc) (struct uhci_hcd *uhci);
> diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
> index 62318291f566..010c458e7d8f 100644
> --- a/drivers/usb/host/uhci-platform.c
> +++ b/drivers/usb/host/uhci-platform.c
> @@ -11,6 +11,7 @@
>  #include <linux/of.h>
>  #include <linux/device.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>
>  
>  static int uhci_platform_init(struct usb_hcd *hcd)
>  {
> @@ -132,19 +133,33 @@ static int uhci_hcd_platform_probe(struct platform_device *pdev)
>  		goto err_rmr;
>  	}
>  
> +	uhci->rsts = devm_reset_control_array_get_optional_shared(&pdev->dev);
> +	if (IS_ERR(uhci->rsts)) {
> +		ret = PTR_ERR(uhci->rsts);
> +		goto err_clk;
> +	}
> +	ret = reset_control_deassert(uhci->rsts);
> +	if (ret)
> +		goto err_clk;
> +
>  	ret = platform_get_irq(pdev, 0);
>  	if (ret < 0)
> -		goto err_clk;
> +		goto err_reset;
>  
>  	ret = usb_add_hcd(hcd, ret, IRQF_SHARED);
>  	if (ret)
> -		goto err_clk;
> +		goto err_reset;
>  
>  	device_wakeup_enable(hcd->self.controller);
>  	return 0;
>  
>  err_clk:
>  	clk_disable_unprepare(uhci->clk);
> +
> +err_reset:
> +	if (!IS_ERR_OR_NULL(uhci->rsts))
> +		reset_control_assert(uhci->rsts);

This error handler was added in the wrong place.  It should come before 
err_clk, so that if an error occurs in platform_get_irq(), the clock 
will be unprepared and disabled.

Alan Stern

> +
>  err_rmr:
>  	usb_put_hcd(hcd);
>  
> -- 
> 2.34.1


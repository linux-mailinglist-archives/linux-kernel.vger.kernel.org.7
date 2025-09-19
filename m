Return-Path: <linux-kernel+bounces-824793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7432FB8A29E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED185175F0D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DBA3148C3;
	Fri, 19 Sep 2025 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="AV7yuJwf"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BAC70830
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294204; cv=none; b=R5PLBHO6mpg5UqoBPZuoGVlVztMKrN64/Wa95qtb8sXGhav+31K9vWZ8H2R/6rlSoSuj+bzCkAvLHCLt6IArp8FXe9K9xfW6zy+hrz9rUM+OkXO2LenadlSIIvksRVMingIbHLG4RbY6XguAykPyM8kTjZQMkw9L+1qgBnAYm80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294204; c=relaxed/simple;
	bh=VpWztYwxlC4gMifd+Ha6GcloBpo1TRsrsojMqZ6IwKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQLYu6ubIdB35911XYSdOKRFn5xmK9kXDNmL1M+oqdf/CglOCdImorsMGx40uN4A2Oh9QJ6tfV8fQAsjDV+0lU7GHzBmGIYnOR8wMsX9L57Af7f/26pz0FVGMyJR+IMbBsbHfGJ8Dw+dJbRugCI8NLgSmIBkE+bIz5oztUNYlBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=AV7yuJwf; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-81999b1e9ccso227120885a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1758294201; x=1758899001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h4yk0L0m2YyOV3Nsx1VlOk0MGMOAEd0mQJ4qs4qAJKA=;
        b=AV7yuJwfMpAWDh9609+yB12v2hIAuX02dpTRybfODTnbO+j+FxxIOiWJPDI9SZcL1e
         sx1qAxuEev7l+pdiDSLaBYs+AzLYA3qMpJ5XwgtT6GkTBSeEyiVwaUD65r1e+GgZ0XQ9
         Bk82VGxulW/XKJzsCfq9oFZ2CKWicJbZQeELSc5eYgimG9Zar7vuUdH0uEzEB4tze75a
         ze8tDavJbKn6vS8eX7rFLpYMOyrEeCZOCwRcAIFMeeRSIRxP2JonXmnbrPb12tUwFbuz
         Bz3hG/fNgwldzRebgAnrLX/vINq4yJPqO9bZpKgeX5Suws2ZnUAIgNoG6o5BgMNDAjxQ
         rlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758294201; x=1758899001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4yk0L0m2YyOV3Nsx1VlOk0MGMOAEd0mQJ4qs4qAJKA=;
        b=hEYyp8EkNtXFq/q57cshSow00kJR3ETFkouoPIBh+XmIcroAoeCnS1FMXWzOD3vEPr
         XoPoweT6zl2wWJnM5ONvIzGI5ZvFPWzPLQCHy+XoTfVr3iYPZt8+K7mBRye/adxU55wS
         6WDEXPC5MA1zRb9yGs/lVRZzrzvHr3KnxVBvPORecSbjXVJo3qtNzog/0Yk2VU3whKKZ
         G95n2YV+5Jttn08WJRKSuZvjDDjWCQUrpCl9OSsTA5nf6hSh4OlZXdee1WJfWWz73Of5
         jgOP0fws3octJYEARoNAbhwTEVWqTARpiwjpFGoYovLVQLGJFtPSSOMpKC1KkJCvjPi3
         hysQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3RlBQT9Pj2KmAOgunowvbtR3zkgmSbI8sVLKvB4a4ioWicmhiwd9L4Tl19fNKZm9RYhhBPQ0qD2Uuuuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDkonsGyuenSYd6SRiWc3M2GOO7WcVz403G9dt2E+LN991ShgD
	HAxRS6FST/KbTM7XeyRzHy9ZcwpQs7HHQDLEoaWF941J6tnTLQOgcszF9xSGuwrUEQ==
X-Gm-Gg: ASbGnctAFjH+M1qobITiPqevjQw+fcyRy78a2tGAGLfbG0hEGjwPWFuQf1HaBUrQZBg
	82wCweKYsnCzLx1lRzCt01n7R0aX4XiTwlH/jhS4vQ9miwbjM4XQdQ+w82YK2VX1zjPSBmLAuOQ
	P3xcCYzHsiSvWQBaZ6PMSQWBQxKmK6zKF2HwisdGUNd2L8IdVwbAlUxKzwXuiusdtbgdJX59Tgs
	6tATW3exRHjqMdxIndaVYdHWoQjDd/DSKI5ffN/oqpSdMhW8+Jn/EXqzB660GTx4MtbTKWoT12S
	QtOwORFhP7GAu1MDCC4lWZ5bGSiXpKNaM2bugio8rbOrJKDcTTiF2HtJvRqQJvzG3hWyYWA8qgi
	/ZQYivTYddKzHHHoqytYLrUQR0mt94G1mBzk=
X-Google-Smtp-Source: AGHT+IFp77cMd6GqPBGe5WvLIisHAqV/1FC5no9jIM9sJ2NZm/RlCjBbuh5QO7SS6a/+S22CdYggrQ==
X-Received: by 2002:a05:620a:520a:b0:825:dd8f:1a61 with SMTP id af79cd13be357-83ba2c93824mr366464385a.3.1758294201220;
        Fri, 19 Sep 2025 08:03:21 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::bb27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836304820e7sm350662085a.40.2025.09.19.08.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:03:20 -0700 (PDT)
Date: Fri, 19 Sep 2025 11:03:17 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] usb: uhci: Add reset control support
Message-ID: <9c867c34-047d-4771-b9a6-a2c88dd1f800@rowland.harvard.edu>
References: <20250919025712.719246-1-ryan_chen@aspeedtech.com>
 <20250919025712.719246-3-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919025712.719246-3-ryan_chen@aspeedtech.com>

On Fri, Sep 19, 2025 at 10:57:10AM +0800, Ryan Chen wrote:
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
>  drivers/usb/host/uhci-platform.c | 18 ++++++++++++++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
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
> index 62318291f566..f255358d6242 100644
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
> @@ -132,17 +133,29 @@ static int uhci_hcd_platform_probe(struct platform_device *pdev)
>  		goto err_rmr;
>  	}
>  
> +	uhci->rsts = devm_reset_control_array_get_optional_shared(&pdev->dev);
> +	if (IS_ERR(uhci->rsts)) {
> +		ret = PTR_ERR(uhci->rsts);
> +		goto err_clk;
> +	}
> +	ret = reset_control_deassert(uhci->rsts);

Does this work right if uhci->rsts is NULL?

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
> +err_reset:
> +	if (!IS_ERR_OR_NULL(uhci->rsts))
> +		reset_control_assert(uhci->rsts);

How could this code ever execute if uhci->rsts is an ERR_PTR?

Also, why does this code test for NULL...

>  err_clk:
>  	clk_disable_unprepare(uhci->clk);
>  err_rmr:
> @@ -156,6 +169,7 @@ static void uhci_hcd_platform_remove(struct platform_device *pdev)
>  	struct usb_hcd *hcd = platform_get_drvdata(pdev);
>  	struct uhci_hcd *uhci = hcd_to_uhci(hcd);
>  
> +	reset_control_assert(uhci->rsts);

when this code doesn't?

Alan Stern

>  	clk_disable_unprepare(uhci->clk);
>  	usb_remove_hcd(hcd);
>  	usb_put_hcd(hcd);
> -- 
> 2.34.1
> 


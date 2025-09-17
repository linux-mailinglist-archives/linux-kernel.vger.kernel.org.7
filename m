Return-Path: <linux-kernel+bounces-820968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D71B7FE01
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FF9627F46
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D6B2D2483;
	Wed, 17 Sep 2025 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="fQQ/etmm"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620AE2C0F90
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117779; cv=none; b=bJmMZtuOCH+B/KwacVS0ziNQtqtRJdh6xNxw+poPWLz6SrTAh+NhTTaUtaQybT6h//gmmxrhT+scE1QU6QD7I9Ib812DEPiRE8H177or4bQwfNlGKglaLvqrRwkjPpFEHwpC/9saoImxJ1kU/IAiLkcy3lhYPxU4n695RKmeF20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117779; c=relaxed/simple;
	bh=u65F9ibn0/EbG13e/4IgxRNvUJYSs9cVYFGQuF34WGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVTpR2SXQbTXKzjtZzPBzai9JtEckx6srdwYVE4yOuhQVO3TEAs9fsl/+8bQfZ9me0owXR+9NBBlLTLbue0iF56v5CO+tq7rAVwqPv0XiP35zhrIEy+PKgrjmSqyIL2aBHl3Z/svsDfiGUqaUmufV6WzSKJQUOKQozbUl3QylCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=fQQ/etmm; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-782ba4488b8so37927116d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1758117776; x=1758722576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6oT1gAMoRrlj04Hb48NO47TuLVXjyiMx+T7Y3GCHqFE=;
        b=fQQ/etmmhSAtf02Jj9wEbAgxR2cms8RuEKxcrARQufb40E/BxXf4gbMgg1gJ0QR9hu
         kZSHLyCY5wxL+WMQVxsIn0IqV80OX5YZLAI2o3wpYfj9nq3hnMJMiT0RJjMR6kEt8CL0
         0TfvIG5M1JRDM3e5VX3cG7TLmRIvNgJL7vzNRIMS04Ktv61ZMP7Ftx+Yt0xfoX30Gg7g
         37alP0M7SJRRLa6JHdKTIS0tgojkiJgDtMnk7KhwC3roFV5VOTtMX9X5GJnNVtceeIS0
         MbQN3FUpFCscps0RlwNGKp8eBMlREZUpH7o6Oy9RTnuY3mH1RmFtFxfrfYHpFlQOBOhS
         VjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758117776; x=1758722576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oT1gAMoRrlj04Hb48NO47TuLVXjyiMx+T7Y3GCHqFE=;
        b=R8GYCvPNDXlltCe6rfdF1vS4WeFFK7xwVYbzDM7858n3vvvIW1OI6bTwiozrDDooll
         khUm5DfX08aXrC1tszjFJVxtqEO9aLpz4t9lRmjoMDmGUdBCrgviBed6zKYApaTGeRn7
         osEFahlfo/bdm/RXU/pTiyiUBfpjwyoZ+vkhPhCgZUPr27riED6gjj/r+kFJ5b23eVD1
         Szj86HZwsJ70bHS7i/UdRjL744tkMoBK01FQ9sAv7QhRuWHOct59iKVNkXlolOPbkE0S
         adB7ZX4BLSH03cETei2YPqVwLhKIlGUrV6jwUlxOU8g0InR7/iemNl5EzOtz4rHF/L4j
         JNJw==
X-Forwarded-Encrypted: i=1; AJvYcCWdUQCed87ZiXZzYLBplCQTiYSmlFgU2EZl0hDIZpAJMka1J+4zb7RLe6yS4eFyWAU67PnO3GWTQPvufrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUqPVxCl0gqlqHw3fENAO2Qx2UXnWf5JZw2UAnMDFwxuwbUlgG
	5ZEDJaSoyXv9HWupLyxI/kpqJzXHMAucP971nq2BaXUklMnEd+7o58h0gUnt1MoE7g==
X-Gm-Gg: ASbGncuBzh19TSxhn/Pi3RXz1XhVUT8MS3iHWA1VH8FEGEtjZDVo/qqZPBhiGHIwx5m
	405AiOZqji0VnwE0tq30gzoTgVrOSSmg0S9v9t5jJxA1jZr1z/5iHv6kkLM7OsPnMZG86htyGqm
	Zq8dq/1hDDTO+V78h9UEaEiI4cDs3mqR9+ceVvc0BDB1BgFSt3MUz9fbmYzhi5KyTl7m3UiPT8H
	bTfOVWe5OITkIn31Xl1goaEyV3xAfozSX6YeIht67w1+7rGg3E27VzWLjfg8ti+iiUkoqMgcTem
	40o878zan0zlfJ0lNOXH+51SrDmRezn4Iy675xu3WzuDN8JL0MA5XRb9VeoZ3pCGwqLaJldGEqw
	1ZvmZYcNEdM2LyjUynIchMhiLB/8Fa92nU79iPxy9/yGBNA==
X-Google-Smtp-Source: AGHT+IF0RKbDCJQqlOaQ5lIihcYpXIyfMX0yPpffB1uNIpJ5D1oZ3LkjnzHtCCpYKRDg9m9F5+RN0Q==
X-Received: by 2002:ad4:5c8c:0:b0:78b:684e:88b5 with SMTP id 6a1803df08f44-78ece94094cmr21380316d6.46.1758117775796;
        Wed, 17 Sep 2025 07:02:55 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7858cb5ac70sm51464736d6.20.2025.09.17.07.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 07:02:55 -0700 (PDT)
Date: Wed, 17 Sep 2025 10:02:52 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] usb: uhci: Add reset control support
Message-ID: <291b2bc2-6a61-44e9-91cb-56044c4277e6@rowland.harvard.edu>
References: <20250917021926.3692137-1-ryan_chen@aspeedtech.com>
 <20250917021926.3692137-3-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917021926.3692137-3-ryan_chen@aspeedtech.com>

On Wed, Sep 17, 2025 at 10:19:24AM +0800, Ryan Chen wrote:
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
>  drivers/usb/host/uhci-platform.c | 17 +++++++++++++++--
>  2 files changed, 16 insertions(+), 2 deletions(-)
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

This new field is used only in uhci_hcd_platform_probe().  Therefore it 
does not need to be stored in the uhci_hcd structure; it can simply be a 
local variable.

Alan Stern

>  
>  	/* Reset host controller */
>  	void	(*reset_hc) (struct uhci_hcd *uhci);
> diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
> index 62318291f566..1c1715bddc27 100644
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
>  err_clk:
>  	clk_disable_unprepare(uhci->clk);
>  err_rmr:
> -- 
> 2.34.1
> 


Return-Path: <linux-kernel+bounces-601821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D886FA872EB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Apr 2025 19:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2F43ADC20
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Apr 2025 17:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AB21DF969;
	Sun, 13 Apr 2025 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wUVTW/fE"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0796F1EF0B1
	for <linux-kernel@vger.kernel.org>; Sun, 13 Apr 2025 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744564666; cv=none; b=l76Q57EGL1LnjySAOtZZDAlZmiZvr7P3siXFQstS8OXC3nB9cFr2zeZuWbPyOFHcZo7FBYeLw13HT8W+ulLe8EWNGVug0i14DmWncKEG/Qn7Q6M3KH2n9UhmuTLlpjtM8ZMOOIi1TEdgGiffrRRfKSZZMrPoeh2AaKrLsSqO9qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744564666; c=relaxed/simple;
	bh=8BO3fdOcQT0WqsO1kMIDe2VATzrdhyw9yVBK+2+M+Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyJ0KRgs+bNm0py7Q2IC5f4Z+7ucJnvwoZIJlpVt8CyRjoT//yJL0DdknxAwgkJtdT6J097fYAT1q5vrnHHLfJD6S4049mdE4YPKf3p8KBkTPbw9MjDYMCR4IIebAReEzXVbykanuCiv0mA1UXUv4Z/FGNLmVCEg2C61WhAcb6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wUVTW/fE; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7394945d37eso2984933b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Apr 2025 10:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744564664; x=1745169464; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tvo1AqLyr+P74wryzNC2MhPCbinbOghs0H5a0GVjRKI=;
        b=wUVTW/fEoiHuA6TMt3WOiiMU2nfp/59DDMflZ7lLmWD+SDhD8R+OthHVo7yOJMJx2Z
         dN9iNHAl2N1JxXGuCVI+FSnwPjBN3BeUa9wDfu2AZ3M6ln6d5tLPqD5oIS6M5DDyTL1b
         uy+2UqqlZ5YFoj3xPHXaiR1/skiUa/rdEbnMrss46jJY88DCxC/F2rjSLAuF7XhiTdBW
         iRDsh2zsVfsNEZV5XDaI02Rnxk6E3wE64p5QoSN40VsWmEZtnYWLlr6JyrKmnrOJsUka
         dGTqd0G7pceMnbjZCcetVDkhC6xsnaP6hVgASxi7j5+99Z52mttR4m8gBy9/9uqBz3Xr
         rmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744564664; x=1745169464;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tvo1AqLyr+P74wryzNC2MhPCbinbOghs0H5a0GVjRKI=;
        b=XupVavVS46RjEQIrrC7HDzD+yyTPPrv0OE7HULcy1n1wMwN50WbqzYVYE4hgkMxlXI
         k7vCHABQ7SkGLbnM+G3tKgg7yYtHq/nNDiomgvIVHOgX8Q9lC9WzIl0kBEvxJnMVGv7u
         aDF2lh8ty5iQa+LrBnIqSAlCf8M4dFv48qIrlagW9O8Q8si19C+G6yBq6D/spsaDtqEH
         mQq9NpOydIKGXFwpqM9WfcyISVbhMNXZkWB6aESRU+a3cJfX4S+jZ95uTWJ4wSXobNeD
         hXqPgkC8URjeMx6oc8xrgWeF9LVr+V5S3JfD/MFAAOPB6TO1lombPtd4H9l5GgFK85zv
         o2AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlA7sCvnAmmYRZYW2FxfwoDdaJsG2O3NOncYAEA085JWjn2k1UAX/9zHWEh0LjGFhbmhB5jwb0hZCno3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAXBoWafE9T5QJuT2vLnQM5PI7ZGid4yHErD03DSC73lNXGiZI
	biuGnQE2n+KdAhFdvz/IsMqNvxveRb0aNX7K9UEp3I/yO1cHx8dPreDO8bLfGw==
X-Gm-Gg: ASbGncsmRm3CC1fl6y6KbNZ4p3GQqIRb8eHSxBiQ3AppsE96QTiKWu+jUlZNERqv9Ga
	y+BatB4OnT1mcx56RDbibM6/qHqSaWh67mykK74KAbjlaKrGROTvAZYaipSMIPXroqFW4oDxpyd
	jhFVq6wsEljfqLILc4c80kKwWwSKNSN64C+6ZeLw9ksvxCkmQw4lJxzuennv4ODJomtrR3fkLJd
	r69ahFtDnqf0O7MGaE0jQ20Tv1W3OwFhu5q5kuSMZdhTaJbft7kTIt0wHtIHQr5liu3jeTkBnGC
	Tpcv0Isc/eGLNtc4471+U0j5aNzRG7BYcJzk23FYLgZIf1bQC9gqHWNvOBnLYLc=
X-Google-Smtp-Source: AGHT+IGEF9tHk5qwg4OxLxK6w9YLSpLNHAhgJxvCUsO1Pirx8TGENW/hAM/zxwUCHFP7Xw61cGiCug==
X-Received: by 2002:a05:6a20:9f07:b0:1f5:a577:dd1b with SMTP id adf61e73a8af0-2017978f12cmr13438249637.1.1744564664334;
        Sun, 13 Apr 2025 10:17:44 -0700 (PDT)
Received: from thinkpad ([120.60.137.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a2d3a325sm6721497a12.60.2025.04.13.10.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 10:17:43 -0700 (PDT)
Date: Sun, 13 Apr 2025 22:47:36 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>, 
	Sven Peter <sven@svenpeter.dev>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH v3 11/13] PCI: apple: Use gpiod_set_value_cansleep in
 probe flow
Message-ID: <gljevi2izxszizvwm4yzpbzraxhjf47vm2lg7jrmm6d3ae62xu@cbqtbvw7miah>
References: <20250401091713.2765724-1-maz@kernel.org>
 <20250401091713.2765724-12-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250401091713.2765724-12-maz@kernel.org>

On Tue, Apr 01, 2025 at 10:17:11AM +0100, Marc Zyngier wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> We're allowed to sleep here, so tell the GPIO core by using
> gpiod_set_value_cansleep instead of gpiod_set_value.
> 
> Fixes: 1e33888fbe44 ("PCI: apple: Add initial hardware bring-up")
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Tested-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-apple.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index c00ec0781fabc..505adf64bd66d 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -562,7 +562,7 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
>  	rmw_set(PORT_APPCLK_EN, port->base + PORT_APPCLK);
>  
>  	/* Assert PERST# before setting up the clock */
> -	gpiod_set_value(reset, 1);
> +	gpiod_set_value_cansleep(reset, 1);
>  
>  	ret = apple_pcie_setup_refclk(pcie, port);
>  	if (ret < 0)
> @@ -573,7 +573,7 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
>  
>  	/* Deassert PERST# */
>  	rmw_set(PORT_PERST_OFF, port->base + PORT_PERST);
> -	gpiod_set_value(reset, 0);
> +	gpiod_set_value_cansleep(reset, 0);
>  
>  	/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
>  	msleep(100);
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்


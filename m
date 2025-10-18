Return-Path: <linux-kernel+bounces-859109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CC9BECCC2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 11:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DDED58326D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 09:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65A728725F;
	Sat, 18 Oct 2025 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XdJXgugo"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BCD354ADC
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760780899; cv=none; b=WGqHPH0tAvBsH+oIKWUw+ipvnyEQAU3MagVHGiuZRX/43MWZlL9AKpZRhXhJ4r6gHJjeFVPfeZmBnByhIWcz33o/H5hbPovhHAOE0Lqf48rCb9bwlXlJNJrBs9OnuE3fYYFJnow1NK9s7vF9S4lOD+ZBebwQ2PuMuDXre3E/o80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760780899; c=relaxed/simple;
	bh=A7f0rcwMMhuOxtJjZ+3BE68ZThRKtbmxH6yOW94VjA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAR0W7snnFC2jFqkSVlw/3iIhyur2vRfyVs6TNkBas0W1658OFBs29SFuI1Wd5XymV+cVT1YyWU4xQaG14FClgVvTjVPZ3IT8bI5m7emVsTd5a8vBI0MEIErZXeqGdnIRcJMcIdEW4BVf9AQ2YDrd5ZUriX4B6qrUMzTVMYN9fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XdJXgugo; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46fcf9f63b6so13394735e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760780896; x=1761385696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nhWVuNwxLp4oDhy9Y7Je0Sd3r/8yjdmEN4SRPPZ/YRc=;
        b=XdJXgugoJiC3tqkUxYfdqivCVFYy6DumHxlnfX8Ks8xVTD+WY3bGL7AO9PFHGiaIcT
         ugesKfl6+T5DM3XVJQzm9zLE2nqRSe8yMuywko7g0KYido+KrONE+eUzlrh7xHtb62J3
         oA/vR5vMF+2feTtisKB/ohVL1XY79P7a4B5OimvGYOvOxznq2rQ9lJs46JXQWpsyau5/
         Ke82gl/+quuB9qW89g87ibHB+ZUtx1KdE3TLF/E+aP7m5Z561+rYalrOCg1yddPuMw45
         OuTrOnBclkjsC7SiUmWtGWKWeqfSEpfHnjUqRmICW/LgtJQtA1lvTM9r5dc7RPzOQABY
         fcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760780896; x=1761385696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhWVuNwxLp4oDhy9Y7Je0Sd3r/8yjdmEN4SRPPZ/YRc=;
        b=StDWlD31hgJg8zfqHMVXeiUb/XeoUS0SYjqO7+80DVT+zhhyr4VTQX1lPDIlEHYgKL
         s+u0Pq7GTpA3HIc1pg47PU1dRO0WHLN3QVsZNqHr/PfxYrFOpGdYrSG4bNaWoKomBWNR
         qb3WNv5aZWE5PHzB03KXzx108WpE8gtDdiMAXa4AgAI3eVl2xzclqMQZBr77FeBkoZF9
         I7z3Mp/9Jnw/vOowrxVYskUwkNg9RGaUT5bhDNx5lP7Am99/n+dE1bJtkaSJuS25zMhR
         dkZzlTJLg5KjzlUY3u9pP9OLxyCYAsn5duJFU1QjpgHYKs3ZeFYsbwGmAgHzQXh4fe4d
         VZ0g==
X-Forwarded-Encrypted: i=1; AJvYcCV5aVbhvMGLSQsUQxqe7799matwqB8rUy+hbBz0k0XCZXXw1Rz+Ap5JvbpQWATuiPpQyuUWpl6NpQEn91U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqHScI7MDeCK0EQYLxaoes1SmrPZXbB9P9GIHq1MkY+2Un+euK
	DnpgwnRVYs/np4OxjuSkvaAueUgzy1CWjmh/EyUWgG/EHZHxEYIiAdKi5irICUOQtRk=
X-Gm-Gg: ASbGncsCimev6LOo6VDJDAbSZRHeLp3r6FDRaMISOmZH58Abfy3c2i2xPjeO1dChnEV
	saje2QYvb9hNo4g6/KTr6XmNO5dJzJC/yFMQIlxIVr8MbcaHJhDQgP1dgXMDT6+5w5JRVA0fSX0
	Fevx6CVeQD8wFlYI7RW6ddBX+0rWAk4FvF7vCHqvFfyIWlXuoBcW3qDfxH6UYc0R+3JkISYakAr
	oUFQFnTpxxGIPjtY+n5UKcob5B2k2uArnPEZ2RjWtsDJuTqBBLA7m2MbL+Xgk1Q9IEvmNrufm55
	RZQ5+SIJV0Z/G8dKYO7rd3l5ivU/iKNkBcU22Is/fnFPTtDIeFrfDZS0DNlL/hlJZ+ZEsiotqCs
	fdY1rQiwteTAcZEkJ0Tz79f3qdzWN5DYQvnQeMIKZWknzRWAksjFTWlfU0K/Xofnm7oGWXLEuyJ
	Zq4sy6t4KB/WVcHBbM
X-Google-Smtp-Source: AGHT+IG+kX1i7eggIHxYAK08ThcqnvRyiNfTqtAevzOHW/nGlWwTN/Eu/9VszT8osDHnwWAvHzqdHA==
X-Received: by 2002:a05:600c:3e8f:b0:46f:a95d:e9e7 with SMTP id 5b1f17b1804b1-471177ab11dmr52244015e9.0.1760780895638;
        Sat, 18 Oct 2025 02:48:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4715257d916sm37111235e9.4.2025.10.18.02.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 02:48:15 -0700 (PDT)
Date: Sat, 18 Oct 2025 12:48:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"open list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-omap@vger.kernel.org>,
	"open list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-pci@vger.kernel.org>,
	"moderated list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] PCI: j721e: Propagate dev_err_probe return value
Message-ID: <aPNiW8QzsLv4R0E6@stanley.mountain>
References: <20251014113234.44418-1-linux.amoon@gmail.com>
 <20251014113234.44418-2-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014113234.44418-2-linux.amoon@gmail.com>

On Tue, Oct 14, 2025 at 05:02:27PM +0530, Anand Moon wrote:
> Ensure that the return value from dev_err_probe() is consistently assigned
> back to ret in all error paths within j721e_pcie_probe(). This ensures
> the original error code are propagation for debugging.
> 
> Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v1: new patch in this series
> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index 5bc5ab20aa6d..9c7bfa77a66e 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -569,20 +569,20 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  	pm_runtime_enable(dev);
>  	ret = pm_runtime_get_sync(dev);
>  	if (ret < 0) {
> -		dev_err_probe(dev, ret, "pm_runtime_get_sync failed\n");
> +		ret = dev_err_probe(dev, ret, "pm_runtime_get_sync failed\n");
>  		goto err_get_sync;

Wait, no, this doesn't make sense.  It's just assigning ret to itself.
That's just confusing and pointless.

regards,
dan carpenter



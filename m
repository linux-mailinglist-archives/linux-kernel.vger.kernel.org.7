Return-Path: <linux-kernel+bounces-862191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA82DBF4A3B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35FE53B9856
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4A5257452;
	Tue, 21 Oct 2025 05:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nyIWR5Fm"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7552624DD09
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761024389; cv=none; b=HyiksPBxB29HSIbqolxrz7zMhfgPSrgm9D8saSfaiVSht6EnXHZitxMXY61Q9n9dEtSru61b6lUpc5Uc/FIfZ/scgArit18R24wr7pUHpFDJHmcZTqyiLbgrAndFNVFO0mKitGkjTif6opmhuhn3LnzcTaR+U2uZUqVl11zLcSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761024389; c=relaxed/simple;
	bh=Lh2hJUfWN74+RYC/v7DVT/JhYHN62QreXrlqKH1VsgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQIZvqt9kMhIvpcXyYNNh1LBsWqHHZh9WnS+za21BWoHbznp9Z7W+zl0gWYfOL3YdZ/u4GvbfpJde9fmxjobOIfefrcuajkBOpDj2OIzSh6geFJFPq+O7A7OUjzYEeRL9QPDIJe7ZBK8MhPLS3kcDhbMbEY/VU5Uay7aWsP1Np0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nyIWR5Fm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4710665e7deso18347105e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 22:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761024385; x=1761629185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LpXcdCxES8VhMciNpBuW1YUVsgbsbaaJgsQSe3LFXBs=;
        b=nyIWR5Fm2YYuBXcg++69ihYGT4RRrsj80Ek+PlUGmRYY8Olx+t1z90j9IRHrq3/b2S
         c4DIDCQREK5d6ZTUSQfnighqFR1F6XHBdCOldymbr1ZD8iCbbN2HiZtxbp7ugCLUAWbd
         nk8LZxzjb3E1SAthkoyaf0YGw69smPy9JWWxTVx08xE1Jv+iHbb1xtG4QXOrOXcPYUMa
         HQ49HztnArHLzfnmjBTplQTwikT5pipLRXcSfVaF4nSwyffIFJCu0OA3VoZ/MG4RiEXO
         tJbzM+sCaVsMANWC/qO2eWtEe/G/E0XB6G1ID9e8FK4W/ul3wMkd58saPQGUA8rb+h4h
         8Y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761024385; x=1761629185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LpXcdCxES8VhMciNpBuW1YUVsgbsbaaJgsQSe3LFXBs=;
        b=diwXNVRSdPM+BP2BzN/gmqy3FRuR/vSEOdRCmm059NrmGOuba/AxXGxDLMHkv/cQEj
         /+KuZ0oQaug7ATC7JkwTTBqLSN6LPIJCiZO7r3H2LwHw1t8iwuMMFZCLn72a+EL6KY+2
         mpWLfx+oT0zK/7MCXvVZd9tZpJm+Gg0igBLBEnvsbXBflzPr0Tz17RG4qakIZwKgc+To
         Bf+aFp+JnkwihkmJQpz9+4eeiSPecJ/PzE6dh1PFyb4bXS9Jld9AMFkMuT4VH9cDt4dT
         mJ54MUKcAC/v04lCA+HoHrjMPUgdNOsfYhZFSk/phiVQLsfRkeYD419F4Pv7xo+YLkMy
         Gw3A==
X-Forwarded-Encrypted: i=1; AJvYcCXavvbyeoXMbzm0S5XtwQXUabWbA4cl0+sUmGEQWivvR2SryN5WhAeI0bMI4DOn5VgbnUz8AtQPJg4jdPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze1nY/7ikPuwR4Z2dp2JrQiCt6CY1Lv6tE/AvlVHyMWNh3wPvh
	9n8mA4BHIBBGgxjaF6TidVq1DACeiJiO1VgPkYaTS60LLUS29bwgPpSSknJtj+9Aig0=
X-Gm-Gg: ASbGncuykdgPw5G64UqmSjW64CtOZZb2OKDekkf113VDPBC9nglSGq675XzbLugNXkC
	BjAeeIoAt/QQshDqqo7RhdXUmjM+h2yVkosWKnxmv0zGRyZWqMMHcHjLg3X/EG1HoWKfq2kOZv1
	J7sNmgiswU0HQ5B8y7mkI/i2yww63KRcMovmG6zBbpp7vrfvV53wAVRJpiuO8JlLnXxKqE/sQzM
	V401qFSAmJIEAa0BaOhpBpS8VIEU/jd+T30SxHIUpIwzRoMjA+ePEGG3ercatMiL3TcBWh5hMJB
	SzYI5Ulqj+u0CooxrPp4LtW6jW2rUkFe/ASCYjSiY3VW8JTfybLPrCS7De7U87F7Cz6TqbPpHyJ
	HZ9hw8OjvEZboOzXyS2COqcNm2PIfURqAWd55gvvWFk1xg930yElneU4Y4XgTlWmN/thiPWt73h
	AKw5Jo4q7ypPiX1934
X-Google-Smtp-Source: AGHT+IHIHSrtW3GijTRXt2IgYi51Hm0oWtBpCtSEWan639ujy1pKF9l/ZU8kFQADnPAQNheJfCrd6Q==
X-Received: by 2002:a05:600c:8185:b0:46f:b43a:aeed with SMTP id 5b1f17b1804b1-4711792cc0cmr108057125e9.40.1761024384730;
        Mon, 20 Oct 2025 22:26:24 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427ea5a0f88sm17811180f8f.7.2025.10.20.22.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 22:26:24 -0700 (PDT)
Date: Tue, 21 Oct 2025 08:26:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
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
Message-ID: <aPcZfI4qePMNuil8@stanley.mountain>
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

On Mon, Oct 20, 2025 at 09:11:16PM +0200, Christophe JAILLET wrote:
> Error handling in the probe and the clean-up path in the remove function
> should be adjusted depending on if data is taken from DT or from overlay at
> runtime.
> 
> of_overlay_remove() should not be called when of_overlay_remove() was not
> called.
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
>  	bool level_triggered_irq[RP1_INT_END];
>  };
>  
> @@ -289,10 +291,14 @@ static int rp1_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		goto err_unload_overlay;
>  	}
>  
> +	rp1->skip_ovl = skip_ovl;
> +	rp1->rp1_node = rp1_node;

This is a reference to the device tree node.  We normally drop the
refcount when we're done reading what we want from it.  So we can
call of_node_put(rp1->rp1_node) here on the success path.

We could just declare it with __free(device_node) and use cleanup.h.

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

It might be nice if of_overlay_remove() ignored when rp1->ovcs_id is
set to zero.  Then we could call it unconditionally.

regards,
dan carpenter



Return-Path: <linux-kernel+bounces-859110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5130BECCCE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 11:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3AF9634E87A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 09:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC861287267;
	Sat, 18 Oct 2025 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gp/wSoqa"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8147426D4CD
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760780964; cv=none; b=p0EaUkhdceH+59/TNgImvdiGUH0/R1KdHQrUQqcYhiB2EntGFFQwaoGpb+2wm/3LlGurqqzqhyFGXxQRhiD1P2F4jX0cABW2inq90bArBBdrGO8u2mA+rFRQRs9/33iwExKr2cMNxvXRtdlOcHhRWlb8qyq5zi1zeAhQl8e6FlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760780964; c=relaxed/simple;
	bh=aBrzw1BnOAqm6Mv2zDnLYL50/v6f/umcO6E955ZpIuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjjrRDVyZKw3fh2BHBWWy0PD2fQQvD8a8qfGILunkQn9xeVi7fu9GbX1s6btIS7rtdkiFa0keWc1wOh5ghD3JagWFa8r6lGfothNjfspR81IwRKEMedt36vrJXqHOhEJaVa23T9RzjsKQUM30m/igOVU20BCHXMBeYQHVcbNeRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gp/wSoqa; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-471b80b994bso3680415e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760780961; x=1761385761; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LJ1k9LDoSOqmBSAsuY78K6WJBTUTLHwdE0LZYjE4bkk=;
        b=Gp/wSoqaX5yfOGvI0KHhZuqmHzwPmG3YHcTFh77Q/XbXU55R3vXwRcUYQzD5oTDZ0B
         Lvud5gtAjtHKuabXdph34CMQ16LX6H110RljqAddb0ZXkyEZqtq/FSVaewqbJ+K8zC8e
         gP3Sfno2q/IEzkuMstw5OmgNLTV+kKuAnax8R911IrnbjSTUm7tmY7tx951RSsLKVK4U
         7TLeyy9zBnKeKn9rHDMwR7j+G/Z69BzZFVCqvkx3cdF6MPxjf3A30LltcN4wbB1QVk4U
         AsKi+U75YcDCJGyh66Av0JhVabhT03YO/+kPGbfV8u15c7GfNuIeR+WWk52hr9Wg0Icv
         QrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760780961; x=1761385761;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJ1k9LDoSOqmBSAsuY78K6WJBTUTLHwdE0LZYjE4bkk=;
        b=etb6XKQ/cSb7Gy5X2ODmPIF2vSAAX0jABNJnKlvQmHF8lr0iNmmFoj+BzUrEs/e6fY
         /h9gkqnuO3enk++yM4FvXh6cpXzim/Va+aW18vIuGirar4SFfukZMIi3R+QlEWG1Jnkg
         hdPxhiunzc6W4RFxHSzVs57pZcIlDfiZ/qjx7OviSZtxPUjbWffyMKdSkLbF5YPktLz2
         MBkWudNDmUqf5HCtsNv4JK5g/lZ7QVp1q9LIcICoNm5TPOWKhJUP+bMYxZP2Ir+aNJ8t
         Tp2VA+RxCgvu0nrUe3yuwPTJpj8Ixiid4J5ZowAdXgd3RbegkO2Ijw4Vm3TO7lXW9BtN
         PvYg==
X-Forwarded-Encrypted: i=1; AJvYcCVZMU3gB4Or9yrInikOeClndX2CKRxOg7scUvuuj72WgxqQDNcXttpom9FOIXkgr0eTLV8uthaAp72grWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9xVrXfdwkHk3k5Npc2KLypPtW+MQL8Khn0zROFRFuMNrUI7Pl
	KWljdNuTvJItXRS3SzkiLTf8a2JrH/CXAuT+I5RIuiI422JzBKxsUN5LLRBjjUSXtt8=
X-Gm-Gg: ASbGncuZkC6kvDrG9VmginUEVVEhori/xPiRkFkwoVBvcjmt8QFKpswcfuMeXEbpIYi
	3v5f9OPBUGHs67TTrjkzsu22Jt0dNtK5CorK3YZi0RLUAgDlJQgv4astXeV9hEQTuiWHjAtFf2x
	Uv4OOL34tqRo/Tb9ajrXzLkYCx0Bg/IlYYwhGN9LlWoNfDakfJmVsbbVelnuw/joMY+r6zaBqnI
	PT2+eLZFdmzBtrS2CA1XgE89UGWHz+DWLahgZSLHGyMtchzQ0VSwWavbwcLsXf7TzGLkFJLMis6
	+9eap4Q1EzQejugxoYgQnrEOlBFGdtnCAG1hiJK2CdTatm7srNV1Ki4ZmO3VKRZL3ptnN6s6UXE
	toG7ytIgwoZocLhIf2HcPZBKg5Uemtmoa4Spthm/XBcpZkT+WsOX8X7FNhNSPjCxiD2Llachxkb
	jyaXfPjA==
X-Google-Smtp-Source: AGHT+IF4PmKFPPexasdAngpm6lCQGA4zlUjMCH/pf+rmfZzvnzRywedipAIMxVKthaY73oX1yJKtZQ==
X-Received: by 2002:a05:600c:190f:b0:470:feb2:e968 with SMTP id 5b1f17b1804b1-471178b125amr50060315e9.15.1760780960846;
        Sat, 18 Oct 2025 02:49:20 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427ea5b3d4csm3936689f8f.19.2025.10.18.02.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 02:49:20 -0700 (PDT)
Date: Sat, 18 Oct 2025 12:49:17 +0300
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
Subject: Re: [PATCH v1 2/3] PCI: j721e: Use devm_clk_get_optional_enabled()
 to get the clock
Message-ID: <aPNineCsVgUyD6xW@stanley.mountain>
References: <20251014113234.44418-1-linux.amoon@gmail.com>
 <20251014113234.44418-3-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014113234.44418-3-linux.amoon@gmail.com>

On Tue, Oct 14, 2025 at 05:02:28PM +0530, Anand Moon wrote:
> Use devm_clk_get_optional_enabled() helper instead of calling
> devm_clk_get_optional() and then clk_prepare_enable(). It simplifies
> the error handling and makes the code more compact. This changes removes
> the unnecessary clk variable and assigns the result of the
> devm_clk_get_optional_enabled() call directly to pcie->refclk.
> This makes the code more concise and readable without changing the
> behavior.
> 
> Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v1: Drop explicit clk_disable_unprepare — handled by devm_clk_get_optional_enabled
>     Since devm_clk_get_optional_enabled internally manages clk_prepare_enable and
>     clk_disable_unprepare as part of its lifecycle, the explicit call to
>     clk_disable_unprepare is redundant and can be safely removed.
> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index 9c7bfa77a66e..ed8e182f0772 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -479,7 +479,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  	struct cdns_pcie_ep *ep = NULL;
>  	struct gpio_desc *gpiod;
>  	void __iomem *base;
> -	struct clk *clk;
>  	u32 num_lanes;
>  	u32 mode;
>  	int ret;
> @@ -603,18 +602,11 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  			goto err_get_sync;
>  		}
>  
> -		clk = devm_clk_get_optional(dev, "pcie_refclk");
> -		if (IS_ERR(clk)) {
> -			ret = dev_err_probe(dev, PTR_ERR(clk), "failed to get pcie_refclk\n");
> -			goto err_pcie_setup;
> -		}
> -
> -		ret = clk_prepare_enable(clk);
> -		if (ret) {
> +		pcie->refclk = devm_clk_get_optional_enabled(dev, "pcie_refclk");
> +		if (IS_ERR(pcie->refclk)) {
>  			ret = dev_err_probe(dev, ret, "failed to enable pcie_refclk\n");

This isn't correct.  It's assigning ret to itself when it should be
assigning PTR_ERR(pcie->refclk) to ret.

regards,
dan carpenter



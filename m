Return-Path: <linux-kernel+bounces-721345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C5EAFC7EC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4CBC1BC4DCD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E315026C3A0;
	Tue,  8 Jul 2025 10:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="freOrkbw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487DE26B74C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969226; cv=none; b=D7sHHd3cl+zX8Q3LtrJsL8k8jhFibu7qhFqVAhs1C4yNx/fcDOnEZotO1SkZuNdEKFzGFD5Zegfyy4P7kvN8T/fZYvTiwLxUw4c0YnEINQOZgZ3N8G+JS4YIOkkIhTYeB3oETOhc3OT36NizULzcqVST0S21MT1Kk2JcyJLA3B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969226; c=relaxed/simple;
	bh=fYyHl23C7iOML4Y3XMKrYo2vQEq5oT1hriKpsmH1Ugk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EILeVuHaJ93aVEQC0hax0F0E9gROoQO9QbQcGihVz9/dIcpHR7E3xks0PAbtJlxn/NkB6jn60Pnw0JMTB4PFn4BkupevHv0vn5LkmmcPVEVolYHbnBccMTTzVOoI2DqO33p4xYwId6NXb3FILxlpjIcol1jUkk+t6ebj/AQpkq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=freOrkbw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751969223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=58D8nthEMttD8EOjkycPcqwbL7GCEdeTDZ0Fg2Jn8PI=;
	b=freOrkbwKv7La195Q1fK8fA6gKnwc7hmLTSnFoiN7nZ1AqkMaxtRB94LwscZf2rjp/4LvJ
	i7Gx8Lc7H1/3pzCo32mK3so58ee9H+K9DfQ51xGrG7ASi2AKafqiRhQfcr/D2VxzRYiXQg
	FrTllqqRRcdWoHCJlqbNEdKPG9bbySY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-tEF9GXMSNGKQXiTAv-gJ0Q-1; Tue, 08 Jul 2025 06:07:02 -0400
X-MC-Unique: tEF9GXMSNGKQXiTAv-gJ0Q-1
X-Mimecast-MFC-AGG-ID: tEF9GXMSNGKQXiTAv-gJ0Q_1751969221
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4ff581df3so1838054f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 03:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751969221; x=1752574021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58D8nthEMttD8EOjkycPcqwbL7GCEdeTDZ0Fg2Jn8PI=;
        b=U14FMD1oNV40R8heta96PZHg0jcszFT2CQFbLKN/+dHvzn+I3vUqb+ho/h7RQ25Wtn
         n6Fg4wMp8wC3KILMmio9qCDOUEJAid7/NV36KZjgtP6hwWDVAddy1JdeNLrTTOxfEHXR
         5I1J2/2locHxNrB5LPYJcXXXZDGGgFnQUAIdQqYME/hlS20zaTPxwOGBUUcCI1EfAqZ+
         p65c5yiTyj4lR1Z9ZYaIRyeJblysaqIRSlrmzgZeoLGXsnAPHSwy+/YANF1gxOUUdn6e
         +RdcHZE9vJlxqQhbDsOGgM7g7PqDfim78hqqYos/T7qBEPb0OklC1ULJ971Qx+u1EtBl
         u7AQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/srcz84H9LeXvhTTDwroG8WblFATqbnA171CLe+c+CrYc/8OFKmB0JJLdXu5Y7bDEfGnJcaQ+LfCIi28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzil7DTrdyJpSsjc3ogVAUWCQxZX6kDsZ6oasHagYHiZKoUoKbX
	3X0ZZB3WOFJv92z/+FD/NfOiNDDyz5Li3DFTPWqEClB9tJM3HPkM/uvch72UZQt6U7gY60D09En
	tb0jGnFEgDMCS+U1oa76Hj48nKUol+2xEkz6H3NuvORnTwLjuwLmAuUf6dCzA2JWZZg==
X-Gm-Gg: ASbGnct9qhR1kdotkWFuICfammufeueMPP3PTvlIlO2D3hTmIu/Gh6pfjwaTLpDfjm2
	AVFN9RKn1uLlPVJYLPWxAfkCYE8KU1A/2BJ42NBuE+B/+W/XHnDzy2MyveAaxFQDT7BHDKH0nHx
	Gs63vxodwlOolkO1+WuGLL5j8JB9Pa0T9Tq7w2iyLBgMPy9oN5r5gtn8k0xl3iH3aTMY9JK5NDR
	UYBVF4Q2k8lILSOBHMwUrD4HdGnas+6fWmABA2B8xwQnpAPKQz1G9tYcsXyvK5N1Pb/eIUfaKhl
	Wqn0TFy0REV3E0lR2MFphsoL0HeCsDVsPY/YpVv/55KvIc6gCa9qfrGVjMo90APnLUWc0w==
X-Received: by 2002:a05:6000:2303:b0:3a5:271e:c684 with SMTP id ffacd0b85a97d-3b5de020c32mr1949628f8f.24.1751969220769;
        Tue, 08 Jul 2025 03:07:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtcYA73nlyPh3UUGiVwYijbG3S+DSKY5ccoYHAENjNZ6YmMjCSlj1e9xUsxHKnSmrtDCa3pg==
X-Received: by 2002:a05:6000:2303:b0:3a5:271e:c684 with SMTP id ffacd0b85a97d-3b5de020c32mr1949573f8f.24.1751969220180;
        Tue, 08 Jul 2025 03:07:00 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2717:8910:b663:3b86:247e:dba2? ([2a0d:3344:2717:8910:b663:3b86:247e:dba2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd2e7e89sm18221965e9.0.2025.07.08.03.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 03:06:59 -0700 (PDT)
Message-ID: <b68a06a1-076a-4345-bbb4-7dda1cd73591@redhat.com>
Date: Tue, 8 Jul 2025 12:06:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v14 04/12] net: mtip: The L2 switch driver for imx287
To: Lukasz Majewski <lukma@denx.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Stefan Wahren <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>
References: <20250701114957.2492486-1-lukma@denx.de>
 <20250701114957.2492486-5-lukma@denx.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250701114957.2492486-5-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/25 1:49 PM, Lukasz Majewski wrote:
> +static int mtip_sw_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	const struct mtip_devinfo *dev_info;
> +	struct switch_enet_private *fep;
> +	int ret;
> +
> +	fep = devm_kzalloc(&pdev->dev, sizeof(*fep), GFP_KERNEL);
> +	if (!fep)
> +		return -ENOMEM;
> +
> +	dev_info = of_device_get_match_data(&pdev->dev);
> +	if (dev_info)
> +		fep->quirks = dev_info->quirks;
> +
> +	fep->pdev = pdev;
> +	platform_set_drvdata(pdev, fep);
> +
> +	fep->enet_addr = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(fep->enet_addr))
> +		return PTR_ERR(fep->enet_addr);
> +
> +	fep->irq = platform_get_irq_byname(pdev, "enet_switch");
> +	if (fep->irq < 0)
> +		return fep->irq;
> +
> +	ret = mtip_parse_of(fep, np);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "OF parse error\n");
> +
> +	/* Create an Ethernet device instance.
> +	 * The switch lookup address memory starts at 0x800FC000
> +	 */
> +	fep->hwp_enet = fep->enet_addr;
> +	fep->hwp = fep->enet_addr + ENET_SWI_PHYS_ADDR_OFFSET;
> +	fep->hwentry = (struct mtip_addr_table __iomem *)
> +		(fep->hwp + MCF_ESW_LOOKUP_MEM_OFFSET);
> +
> +	ret = devm_regulator_get_enable_optional(&pdev->dev, "phy");
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Unable to get and enable 'phy'\n");
> +
> +	fep->clk_ipg = devm_clk_get_enabled(&pdev->dev, "ipg");
> +	if (IS_ERR(fep->clk_ipg))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(fep->clk_ipg),
> +				     "Unable to acquire 'ipg' clock\n");
> +
> +	fep->clk_ahb = devm_clk_get_enabled(&pdev->dev, "ahb");
> +	if (IS_ERR(fep->clk_ahb))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(fep->clk_ahb),
> +				     "Unable to acquire 'ahb' clock\n");
> +
> +	fep->clk_enet_out = devm_clk_get_optional_enabled(&pdev->dev,
> +							  "enet_out");
> +	if (IS_ERR(fep->clk_enet_out))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(fep->clk_enet_out),
> +				     "Unable to acquire 'enet_out' clock\n");
> +
> +	/* setup MII interface for external switch ports */
> +	mtip_enet_init(fep, 1);
> +	mtip_enet_init(fep, 2);
> +
> +	spin_lock_init(&fep->learn_lock);
> +	spin_lock_init(&fep->hw_lock);
> +	spin_lock_init(&fep->mii_lock);

`mii_lock` is apparently unused in the whole series.

/P



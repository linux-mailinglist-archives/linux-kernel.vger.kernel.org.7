Return-Path: <linux-kernel+bounces-889294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C326FC3D336
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 20:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 573A73B04D0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 19:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E6033DEE7;
	Thu,  6 Nov 2025 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9/zm0D7"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDEC259CBF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 19:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762456196; cv=none; b=hlqNg2iggxLvd0hLFviVYxlioP+0OnW9vzNzlD2Lwxcaw58Tb0fi4TCiLaCHCjLkNX9q9FiQVBnBmCtv5USAlz/m8NHO/z/JUi/ceztUwT3Pvq9LCRzPAe8KEifTDwdzI0kcCtsGGoIv7ah/QycpX8WgIPP+MdoOPPmIVP9kkmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762456196; c=relaxed/simple;
	bh=8YXu0CwsbL1OqkPAFy/EHBELfu62dANcIX0cLPrynzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHQHi7Kvx+FRrusVDC33AsclBR6GrNsEbQkZB2mVBk+9B8PVngzAOI3ucndZWbPrzqWBNg9fFEZmV55Hh4RKyFOPpzq7JxjjR9Z7ArfmhkKiX2lbTLI+wiItN67fTRWKM05+Z42XdtWSOgFo07pnt2DQTSHzAWZE+cN8F03xcEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C9/zm0D7; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6411f1c4b4fso232177a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 11:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762456193; x=1763060993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R9EJ31BMFRtngkVvmruU/yNAGPhyHC0PLxcC8cP7CEo=;
        b=C9/zm0D7Y7PYcio/tRbT7nsEJQGZVZ3/gqqa95C9H28afxPD2Reip6gYsPO3UaXSX9
         /2+tQsmLNwAjV8ErwWgkPdC4rqM5YGQqzu/kyTp72Yxl/X8f+SVoR+SfRe5q7PFRH8dT
         JSIkrn/OsYFNoxBdqFCW+/AL5dc8pS+hdtyza9027rbaGUwlPcHVMgUVD8k6tP+0EKSl
         T4Ned6t0gqWuPkb36/mep9CaMpAdKG27LomLIu5r8y84GEhnGXMA8ugNDuRLqJDMtJYz
         74rDgsrD3Pt7emBXcwxj2/uP2VYS53eP+4KsBKZHfLywQMARVyntPFE8j62Bu20zQHxA
         +gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762456193; x=1763060993;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9EJ31BMFRtngkVvmruU/yNAGPhyHC0PLxcC8cP7CEo=;
        b=jQXISDgr7RrU5NuGEY9qIIpLxx1wdOHU+bkT8atVLhqxsTiL7i1UjycmRfQXH0tfXW
         Nr8WzdMtJWJ5aMakVQ5uwASQPmZNvWdBJDSFRDUY96xGKIjN9hH9x9OfIW4QixAamM3T
         79qewFRM49QNo/TPm2uy/jgwlxsePVh6wNUHJp+3lNi9vKd4XhtWXG9h86qly76aVi+k
         jPofYCixf3BhXx0bfdKGYwWAvMvFbMN6k9gxqlRF83yoAmx68az1wx115IzRl2j/6CPx
         DSCaI7yIKtzQhQ53/dHfE3wm3DTejbfaf9dE8SJBv9Qwi5B9IctaLL9dUteWDUE4iBWE
         tk8g==
X-Forwarded-Encrypted: i=1; AJvYcCVphUhmaVtvlZDwZ/FJHV15UXSPmgzNz4RZRW3D+0ZrGBGvHpiK9/1bSUsSycw727Jwacv70eRiNNWe0dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjtErRWXdBGvRBBd/9+GRGOBGsMW497L1mEcFyA1oACx4wyC/v
	eo4XWbd7KkYN4QBL76wM4BHvHVneoo9qY8WXYdoLwUFCRPxEfcuI2oC+cpZ3BWhIuwQ=
X-Gm-Gg: ASbGncu/oiUfYzFuBF0OwE0C4s1c+2CxwZIgU2It9zn1w8qRmRHI2VI6q+ogEQWTr+c
	wwz/HpCyVb7cawlfVErdWTYqSgzEJ8g1UAaxaStsOUiSsPh6C/t75oxDB8NBa9IbDgymzVTqwN6
	0XtgiXjZlymIxfOxVWEPdKDz9QqjygUJ2JibOGUgr6T9SeMXjxg1o11DX26I7NjwREkTWp2sQPl
	43K2d8Q0IPQI8fsQCG0YpLaUZg13aiHb/P+mo2J0C930hs9gNIxFsBZCQ6hkCWV/RSU1XCdTopv
	zQt7jHuO6Qifh55TqPfenu+Y/neGj3ApfpHm60Xgs71U35UaG4Tfz+6v3ZVfsvyHjWZ+dgmYZnK
	ujiFb+NpZHvTm69l2VW2wWYTueDWoZLLWOM4QyPpv1aItdYsirPaNLnrjSwekNLyic5UwG37XiU
	m5nt4Q2UW0jtWj3OTzmtT6
X-Google-Smtp-Source: AGHT+IFLScIgFbO18qAgFVJ4C/yYi8kKG+DOMbXda6TV5rCC9yt4KlAUStwtjX1SD2b25R5SQ9YR2Q==
X-Received: by 2002:a05:6402:2110:b0:640:ed50:c1e4 with SMTP id 4fb4d7f45d1cf-6413f0efb7cmr263574a12.3.1762456193188;
        Thu, 06 Nov 2025 11:09:53 -0800 (PST)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f813e9fsm2419923a12.16.2025.11.06.11.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 11:09:51 -0800 (PST)
Message-ID: <d17ad0cf-eea1-4d72-8b02-2f8172ece8c6@linaro.org>
Date: Thu, 6 Nov 2025 20:09:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] crypto: artpec6 - Simplify with
 of_device_get_match_data()
To: Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Lars Persson <lars.persson@axis.com>, "David S. Miller"
 <davem@davemloft.net>, Tom Lendacky <thomas.lendacky@amd.com>,
 John Allen <john.allen@amd.com>, Srujana Challa <schalla@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>
Cc: linux-crypto@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@axis.com
References: <20251106-crypto-of-match-v1-0-36b26cd35cff@linaro.org>
 <20251106-crypto-of-match-v1-3-36b26cd35cff@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20251106-crypto-of-match-v1-3-36b26cd35cff@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/11/2025 17:31, Krzysztof Kozlowski wrote:
>  	struct device *dev = &pdev->dev;
> @@ -2853,12 +2852,10 @@ static int artpec6_crypto_probe(struct platform_device *pdev)
>  	if (artpec6_crypto_dev)
>  		return -ENODEV;
>  
> -	match = of_match_node(artpec6_crypto_of_match, dev->of_node);
> -	if (!match)
> +	variant = of_device_get_match_data(dev);

This needs cast for 32-bit builds like it was before. I will send v2.

> +	if (!variant)
>  		return -EINVAL;
>  
> -	variant = (enum artpec6_crypto_variant)match->data;



Best regards,
Krzysztof


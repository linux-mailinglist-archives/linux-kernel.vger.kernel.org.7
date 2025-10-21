Return-Path: <linux-kernel+bounces-862657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D34F6BF5DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8A21890849
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1702F1FCC;
	Tue, 21 Oct 2025 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ksczU2zu"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35C52EBDD7
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043284; cv=none; b=MCrxOiv+G5xvwv5/QZpEdfHHdarqZnP7sLB+uYR9rfA6uUHpTTkeER022BnKTjUuS3FrAZsfPwfFJXpQSWM9Oal/N19ylChpBkzXcz0KWcPi+AJvmvE1KhHYR74wLDvuFG3MJEqunzew6dn/IB3UX7UNDgPpn6kW4qi4omCygc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043284; c=relaxed/simple;
	bh=wFmGNq5wecu2rvPoLeVjeu8DJ3fyC5NSXcnwFpmBNmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=URht4o3Ejz6w6EBMrxZBx4vn1qho2s+pVsrqysOsSIyZ3vkNGtlc0LA7a4C7hgCQhIHVNB044tu79swLIprPyAuf1s1HUH/eY8pDo1kfqazz1j42b8YuhjobgU+34Fh6iAHzC0CCCG+Gw2VxzdLJXtY5qjW8xoZXA89u3Yiah8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ksczU2zu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-471810a77c1so4637645e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761043281; x=1761648081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8h9RVKYmCLG6RA4AVN/czLNpFQmu0nfw+mf3zct6TSM=;
        b=ksczU2zucDrsUCDewHHQLM/tFu2LMmtfnhjuGDzow+Xg2LDB1jYr/KT/inZDZU+Ysw
         DdTtdq3bSX3CUjHJ79tSNfg0ejgnDqrByPmIT9FjWvLQIPHDS//qm6djWZECRwS9TqPz
         Qr+WLI8u+40NL1gg2IvuMpC/H32eRLox/IvLbH6hy1xOsaUVGC7HqFwXTATSc4YqYuXl
         DNuEpY3ekVJ7LYtmP8SDx9+NLAGGF+eBVzwuiEz7QtLKZrZOH1DZCaT1FreOYMNHAlgo
         /u9kZww6WwbGH46brG8cioMFCdjhvOjXdfYC156RVHSc5rwDEjEf00JlyGIlWPnfuBD4
         lVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761043281; x=1761648081;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8h9RVKYmCLG6RA4AVN/czLNpFQmu0nfw+mf3zct6TSM=;
        b=PW2ZDP6J0TWv6a2hxNrthOpC10/d7h6vBbAj03mDohCCCp++mevOiuZQhTUCw5wHCi
         rJc2wiEohNmhJKhf8h0W9Lqucu59gvkBZN74VEqGj6XnfktnV++9GNC6Cv4OCoW/H7I5
         nFHBK0ttAxjT7iJ1tw5yz9XFwxLFpmMHPURTY+AXlPNnWmy4IxJ4fXJ0w9st31EISnGn
         VBk3IsRmO+Pcc8vO4/kK2UHzzoA3DO3tnann5Fdx0BK9BND8GI56Xg3Vf9aux4ZCp7eq
         2+QsXomA9LErl86msf8YSDlLNIZkX06LTXP7WRHT2JXni1XbvoSRo2iYHOLE+V32W1uO
         ShYg==
X-Forwarded-Encrypted: i=1; AJvYcCUA9R2/uYPGiLcjo+qwmFrW2wSFhNO62FBy5Nt78jhI1qTbqEUaR3Elvmxswr+L2wdImQhIYCUkIcGdPP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUKSiGy2KW5jBW33s4/HL1hlieLgPiYegwvWEbrmsHvdynMn9P
	ymOMkwxhrNpunrSztgqwjLBx6y5ehmMRbu8RuhUxgVLmdA/EiokHprw36KLrpnFwRr4=
X-Gm-Gg: ASbGncuqRR8q1wx7uvGnvbGJOcRr17gemgjUsp1GIg9u0IlpUTTcgD6SgOz1xa4jSjY
	1vg9eeGxqoYw0z4/DaZuBP0+JeVMF/5U2ncRg6E8L5SlCiXGN8lRprTRLSHkAEjQYKQ58ZHLCnR
	PP1r1aoJxPJ8F6uBRvbx1QYHhd4tEwZXm2TJtFFA88mZxSY2ASXmyaGfNyfwoEuveDY+Q4gZlfS
	gzbnm0JTw8D0QZhEuKytMs616hhttJ1ixwn+EMMpUF2p/8c/QqBNJDOxOxHDQRlwJ/dDh6n1Y0Q
	XsNnQTwvGw03faBV+BX4DC+Pcyp5fKedL2FOCKG1Osx2ytoiK1HOmdDwl2vxxA5tVoWY4C98YnC
	l/a0zDbOG/0La7mrqyHaQb3vUV2cENaBJ40yEEXGYvpA0eLT3YUobujxrgtnUu/C/5S7//mmDJh
	5WHBMBcoxDzeeGrEhFXaNWjUs+yHNnd3w=
X-Google-Smtp-Source: AGHT+IECO48MCyAWWL4svfEUvqpukC59xZ6C8+7QQlfqE6JHbxEe2N27PJvUVo0dNpXHT9b+pQH4Qw==
X-Received: by 2002:a05:600c:3b8d:b0:471:703:c206 with SMTP id 5b1f17b1804b1-47117917718mr68186215e9.5.1761043280919;
        Tue, 21 Oct 2025 03:41:20 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a797sm19705970f8f.27.2025.10.21.03.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 03:41:20 -0700 (PDT)
Message-ID: <89f4378f-c876-4c0e-8484-1a6144a6edfe@linaro.org>
Date: Tue, 21 Oct 2025 12:41:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] watchdog: sony-cronos-smc: Add watchdog driver for
 Sony Cronos SMC
To: Timothy Pearson <tpearson@raptorengineering.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee@kernel.org>, Georgy Yakovlev <Georgy.Yakovlev@sony.com>
References: <1787448596.1802034.1760983830792.JavaMail.zimbra@raptorengineeringinc.com>
 <1587929609.1802041.1760983921227.JavaMail.zimbra@raptorengineeringinc.com>
 <13657666.1802042.1760984066594.JavaMail.zimbra@raptorengineeringinc.com>
 <69142127.1802045.1760984091439.JavaMail.zimbra@raptorengineeringinc.com>
 <1149130558.1802047.1760984113046.JavaMail.zimbra@raptorengineeringinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <1149130558.1802047.1760984113046.JavaMail.zimbra@raptorengineeringinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/10/2025 20:15, Timothy Pearson wrote:
> The Sony Cronos Platform Controller is a multi-purpose platform controller with
> an integrated watchdog.  Add the watchdog driver for the Cronos SMC.


Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

> 
> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
> ---

...


> +
> +static const struct of_device_id sony_cronos_compatible_id_table[] = {
> +	{
> +		.compatible = "sony,cronos-watchdog",

Undocumented compatible, drop entire table.

> +	},
> +	{},
> +};
> +



...

> +
> +static SIMPLE_DEV_PM_OPS(sony_cronos_wdt_pm_ops, sony_cronos_wdt_suspend, sony_cronos_wdt_resume);
> +
> +static struct platform_driver sony_cronos_wdt_driver = {
> +	.probe = sony_cronos_wdt_probe,
> +	.driver = {
> +		.name = "sony-cronos-watchdog",
> +		.pm = &sony_cronos_wdt_pm_ops,
> +		.of_match_table = sony_cronos_compatible_id_table,

Either this or platform module alias, not both. Since you do not have
compatibles, then drop this and keep the alias.

> +	},
> +};
> +module_platform_driver(sony_cronos_wdt_driver);
> +
> +MODULE_AUTHOR("Raptor Engineering, LLC <tpearson@raptorengineering.com>");
> +MODULE_DESCRIPTION("WDT device driver for Sony Cronos SMCs");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:sony-cronos-watchdog");

Best regards,
Krzysztof


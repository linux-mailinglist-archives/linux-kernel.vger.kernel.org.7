Return-Path: <linux-kernel+bounces-812855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD50BB53DA9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA203A7979
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCEA23D7E6;
	Thu, 11 Sep 2025 21:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PGEoNag+"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAC1229B18
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757625754; cv=none; b=ayodRXJk1BpPe93h21ZCe+qOyQOSppcJh+L/pci6JUjmti/d17Ox2r5R/YTe46IFsrPWCpCNgNdY7awxG0frzaTF9CrP27UnlhDmzCtixIBfLslnaReK40kMQCgRa9mi9V6qaFPwGgdLsUiloXtuDJOSLq1qeqHYtBDMc9xtriQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757625754; c=relaxed/simple;
	bh=mpF9QO78XjKHHuLN0e4o5SiMPaTbBuzm/F6ez0J1I5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qGb8NPuuw044nc47feORaEkQce43kqNHVKsOXGxqwbHuO1BX3hXYI5KQz7FTyg3LqQ2vulUUEHiWRLWlmBOeIXtJnTV0hbO8v8i2MJ3JVoTUv9mR31doU7v5R20IXgxS2RACvkM53q+c9j/5i8RdnS0cJhTTnxS8pGHgp7tA5Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PGEoNag+; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-30cce8c3afaso762160fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757625752; x=1758230552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sAkTFP0wxwWUgNcsyxLjhWngpDbT6XEGsdkzHC+c2iA=;
        b=PGEoNag+OTsl5jSP+ogd9oIZvFz2LRwRw2FPa41g3CSv7yK+qrGVieRHXcYOCoWGRN
         AiZH6SjNtoHsvEGVZWcqCgrNBpEMo1B9vbhK+w9ZLR3kzgc97ZiDHG3umVQ1vgql/sPs
         mOUqjD68vub7SFoOKmRwCO0HFpRreT++mdCA2aKPFBTaD9rhlLNd7Lys9eWY8fnPDjHG
         92LHIsmlJLrf2twnrfvoPIVM/vr92m9UNKYyCaBEFaPELJxmEuH1UqJVMOL3CdYQrPxr
         8923Y71v2Py4Zagoi8BbuBtyfRqziMBus+cWVV21TFzGLxuBUFeZATDE0w8PA6dPZvTm
         yrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757625752; x=1758230552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sAkTFP0wxwWUgNcsyxLjhWngpDbT6XEGsdkzHC+c2iA=;
        b=B8FTmyUUeCK5LBYiL0VSWcWIXBNYa0hHXfxS3mSxH/JsUMSLaaFTHNdR/3gPRRHLe3
         l6QmbyzpTOso9ntAjEYuvWFy5IMEEVFbzmyD+TIIPzR0B817+sXNCh4q10Timr2eb2B7
         RZsPHc+Ez3pprYN7WrqC1wC7DynHQ4lOGxa/aWMT+hul1Nc2G3RjsFizWx7fyFpnTMma
         52y98BreyZpWXS3BbE9zW0mc47S+YmJhPH6n/TXLQj6jHU5TyaPE/3PN/X+sQBykQMsO
         dBgKoj4sQE0Tce2ro9ZWV0O4qm5su/hjW+Jfxrssgf2XCVSY2GySvQhi3vKG8qlrSHiP
         WAeA==
X-Forwarded-Encrypted: i=1; AJvYcCWvskOgWvMDnW4DHRBSy/xn5Oqk6cmj8BsJRpe5mjLWi0uPCUa7yxhqH8Kit8rG7SSFBebb0hqq566qg8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDTwJK4uG+XsLqVn7uzM9dcVnB5/sO8j7gvgyOWuxiwwscTSfo
	hU28XahnWWVO69jGSW2L7zj/x0XSSuhlnIfrsjDU6aJmC0ESlIgp7sBzcAvVFIoEaYY=
X-Gm-Gg: ASbGncuz/aASsFSK8J92gb0ct/h4GzScn4J4omFNn6g9TZa5pkkvvy+7n3fBUrTV3/z
	HVmDwGsqtYKwkBNWdW0dnBHfEykNKTOG8qlS/FOEjr7vZQGtDqHvdW13dwRKjPAf0jyxRSKIQFh
	2xYoMyQKGLhuq+ktZwbl4bSlMvgZz/0yIWGuu/WENNhZu1Q6+wATe8Oz+yL1B1NMKtFk0zdIMgf
	oQ5S7BnI1/dvtxPXxgagIpu43kKHlpqXVXhmoZHfra7it989cQXpJVRvgSyMGfndBJjZ5Uv42xm
	0s8vSe1NnRLse0WksViUcizcGkrHpWSFD3QJsU0jGaDLuVaY2Qlw6w+moS5M7A44mHYLOqQyD+Z
	Kqr+xdie1PkEidO6AHfng71Di9fCNHSEpyo29CRFIz2I2he64wlb3xPUWa2RC7njWPeByc3AXV7
	bPvHKcURSAcfRlkxbAs79e
X-Google-Smtp-Source: AGHT+IFwukD5DNSqehOYV9+RvvVGq7upnMbT0Iek6AnI933AnX9bpqbj2uYAEfMTQRiy63CyP5K42g==
X-Received: by 2002:a05:6871:29b:b0:32b:d4f1:89f1 with SMTP id 586e51a60fabf-32e567c3f9bmr301865fac.16.1757625752123;
        Thu, 11 Sep 2025 14:22:32 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:d684:59db:8b2a:5451? ([2600:8803:e7e4:1d00:d684:59db:8b2a:5451])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-32d357d3252sm673443fac.23.2025.09.11.14.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 14:22:31 -0700 (PDT)
Message-ID: <7da87a1a-1aa0-4625-9884-e88ce48b75a2@baylibre.com>
Date: Thu, 11 Sep 2025 16:22:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] MAINTAINERS: Support ROHM BD79112 ADC
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20250910-bd79112-v4-0-f82f43746a8c@gmail.com>
 <20250910-bd79112-v4-3-f82f43746a8c@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250910-bd79112-v4-3-f82f43746a8c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/25 6:24 AM, Matti Vaittinen wrote:
> Add the ROHM BD79112 ADC in the list of the BD791xx ADC drivers
> which are maintained by undersigned.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Revision history:
> v1 => :
>  - no changes
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af1c8d2bfb3deb870d8df44b8bae22e7cffb5aca..8e78a1168c17d8c2c7056e99e191d542ef0b95a6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21864,9 +21864,10 @@ S:	Supported
>  F:	drivers/power/supply/bd99954-charger.c
>  F:	drivers/power/supply/bd99954-charger.h
>  
> -ROHM BD79124 ADC / GPO IC
> +ROHM BD791xx ADC / GPO IC
>  M:	Matti Vaittinen <mazziesaccount@gmail.com>
>  S:	Supported

Should we include the devicetree binding files here?

> +F:	drivers/iio/adc/rohm-bd79112.c
>  F:	drivers/iio/adc/rohm-bd79124.c
>  
>  ROHM BH1745 COLOUR SENSOR
> 



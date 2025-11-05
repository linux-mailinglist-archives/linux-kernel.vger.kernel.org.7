Return-Path: <linux-kernel+bounces-886618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D74C3617B
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B813F34E796
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007C832E151;
	Wed,  5 Nov 2025 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nX2gNDxm"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F44832D7FC
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353449; cv=none; b=Lxo/rx5Jm5xHLB67+6lV87vT7H7skbCcA1Z8wXf6PvYDDvmGN0lYYC9c7DvKFLcnI7pRA3vDubp/IpUfWuRUHxoq3dALbMXBaVcuM5ByohkyxmIvfSklH3fAZGjsYit5lMwPqU7I3x59SPVKb+VsXDyio30ivE+9pcTglJKh5Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353449; c=relaxed/simple;
	bh=edQwmjnwDAbHXoEMvzYqiycGeKsl8E5DajV13S7XI7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cm/gg32vVCjOFtij7918GMHvMQRC1u3RH5ckGzvEu6OROO+KqEAUoPo7nn0udtSxc6H+NE/dDh1WgwRexg1qOE3IpE7rmbSKD9iz9jwOJ57RvQQfegxjStQPyuvOBiyuO0D0oTYYQz6OIol+DAdCfRVo312TFWRXIVa9vmQTLRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nX2gNDxm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47755de027eso14984175e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 06:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762353446; x=1762958246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hKd/GpoH2ztdg5nSuoSnCvB2pN5mPOmTjSyftlWEb74=;
        b=nX2gNDxmYkXQAcjVQMPV8s6h3DVmWUswNVm++dZRNAhvcRGuKB41yiMaXHGVjxzbI+
         DEDmsM9Y6pBITa1s91TXwkUHVI6x7gHILAiAdMjDO9sS3+9ptEJf0bk6RKBH3csPAdIq
         fxmS62V+w8mSk9nDEvN1DV1g2qkDCCNA9FZ1ozNavDbFAjXW7o0rgtaCH+hCk2bT7Dgs
         3+aIvUWZ45JZ86P1lmRs0bWetFCsRuGo5bkDJl1En7wwpEx4yIzf8Q8nkGKXffBoGYCY
         Qi5k4hXibpaZSOUDvEGgfl22e+pQaavMNNKIQnCrA8g9SD/W0+9QZi0G1xDXBwp5d/sb
         TyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762353446; x=1762958246;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hKd/GpoH2ztdg5nSuoSnCvB2pN5mPOmTjSyftlWEb74=;
        b=dPzLzbuYeIGFKJYcYmoISeVekz6fXkPgHfQ7HtGVKXTZgnVCD8m/bjfg3ez77t9ZYL
         eW3ARwRWsJ0gB3jeFkdR8lSMmSyvxXSazXvY2FQmQERrMZpsR3SMS265NG7RyZ3Omyh5
         nIES5bKWHUuDyuHts9fP+qMDeyyU2wsoQuMooAjVbxmIcuCMcEUT1RdyaUMBvLKes6RB
         G8f8V2LyIqgjSL82FaabwUPN9HyRQ1MGqKhi+F6WrrkCKSonU0kK0UaTN7PbgS9ByFRG
         ItVZiYyGtZiCZOVdN0KtBHkQQL1dCC+ucSZhwKpHWc6pa6J8V0D2A0hQj4rFkLYj1FHY
         Xgww==
X-Forwarded-Encrypted: i=1; AJvYcCWR1mWRgo0Qc0wMGqK1Y5EWEp27Gf8IbyFkp9MTKf3lOpCX8yMYJFkz3qk/aeaqJS4fZWtjfc/VwP+pbXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmWOPpIzuw2NjSPfYfsBhUk4Uc9Q6pY8erjSc94P3gi1INbS8h
	iWmgGaN9zIiv0c46IriSsQEJ73lSTCGzlR9uwQcCi1K7WW9SO8FSQGml
X-Gm-Gg: ASbGncuQ4C8mr7Fn/CRhVZEP24w09bTlUvDqe9XxGn/mmj1/z083DwbkTqPSymLffWy
	Mf623qkrKdIOWd8RWhhW/F8+JPSGoebNPT4lm0rydomhr5XPi0WaU9E4yQfVD94EugLZ9ps4nOc
	5X1GArZTAF37aLgismSRh9Vpv39cWfW7DmuABBdoKoUAP/2RL5Kxdz1j+CdPOvL7nBNC6jtx18B
	e/63zuSXk8oBmnM2PKvGy9MNAZ06FI7tqgvaF+zHlkyShNAQZFHkjmnysRl7qMSrpwEJ1bgKoUM
	PJFQv6AasyslHM71F3HRyhTyRx+yY1WKtI8vcUrmwlNPmqHXtc6r0MyWUrhm4c0vffu8bT9JOal
	dtB0c+JNH+MibgWHEANIPVe/QuaxfvAnjzREv6OE8c0WEF3GBioYsoBRh3IrYY1iyPvOwEhjr9M
	3iGFpHW1GnR9PVdjPVWAR7UvGZaAMKAvoWsQtj7hR4h9UNzNQYz00cWKszv6wci6GVcs7T7ldNq
	Xk=
X-Google-Smtp-Source: AGHT+IERQRPbVp/mia5i+e0J+ZNVV5LC5fqpuJ8bxJhknA+ckaj424HY5uFm671+QXbrmv37Ylw0ng==
X-Received: by 2002:a05:600c:4509:b0:477:55be:f615 with SMTP id 5b1f17b1804b1-4775cdad679mr25746975e9.5.1762353445550;
        Wed, 05 Nov 2025 06:37:25 -0800 (PST)
Received: from ?IPV6:2001:9e8:f106:5b01:5cbf:5078:e623:8643? ([2001:9e8:f106:5b01:5cbf:5078:e623:8643])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdc2cfasm52394155e9.2.2025.11.05.06.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 06:37:25 -0800 (PST)
Message-ID: <f589ef1b-4347-4771-802f-992dd0928bc3@gmail.com>
Date: Wed, 5 Nov 2025 15:37:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] gpio: add gpio-line-mux driver
Content-Language: en-US
To: Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Richard <thomas.richard@bootlin.com>
References: <20251105103607.393353-1-jelonek.jonas@gmail.com>
 <20251105103607.393353-3-jelonek.jonas@gmail.com>
 <CAMRc=MdQLN5s+MpkLUF2Ggc4vYo30zOXrA=8qkGmXvu7N3JjeA@mail.gmail.com>
 <12efb5b2-058e-4a9c-a45d-4b1b0ee350e7@gmail.com>
 <CAMRc=MehBmd+-z5PRQ04UTWVFYzn7U4=32kyvDCf4ZQ4iTqXhw@mail.gmail.com>
 <74603667-c77a-e791-d692-34d0201e5968@axentia.se>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <74603667-c77a-e791-d692-34d0201e5968@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 05.11.25 15:19, Peter Rosin wrote:
> Hi!
>
> 2025-11-05 at 14:24, Bartosz Golaszewski wrote:
>> Yes, "muxed-gpio" is good. I can change it myself when applying.
>>
>> Bartosz
> Isn't that the name in the device tree?
>
> Is
>
> 	muxed-gpio-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;

This would be quite odd and not what I had in mind when I suggested this.
But I probably didn't express myself good enough.

> really satisfactory? Can you really make that change as you apply
> w/o a re-review of the binding?
>
> Or, are we talking about
>
> 	glm->shared_gpio = devm_gpiod_get(dev, "muxed", GPIOD_ASIS);
>
> and
>
> 	muxed-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
>
> ?

I'd be fine with this, but as you mentioned, it needs a re-review of the bindings.
If it's just about the label being used upon GPIO request, I might switch to
devm_fwnode_gpiod_get_index to explicitly set a different label and keep
"shared" in the bindings and device tree property?

>
> Cheers,
> Peter

Best,
Jonas


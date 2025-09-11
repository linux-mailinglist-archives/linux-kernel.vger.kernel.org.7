Return-Path: <linux-kernel+bounces-812095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB81B532D5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB1C1C85D4C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA532324B0A;
	Thu, 11 Sep 2025 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i0HYpqA9"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FB0322A1F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595305; cv=none; b=IhGEJY2O5H/m8PEk3272LsQyKVkRiuEI+7Ad3yDubB0QTiwQ6R56rFERE//SSd7ufBIVZmfQDU9jiicIha5oOw5N5GXo9uKcQGzSgUIogVI5zkbT6MyAGdzxvxZl0o1sLpNoSib2hGc8uphiYX7vClnmmcVlK8QaLZKMM5wDk+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595305; c=relaxed/simple;
	bh=2oSOqVZN2yEJdOr1yjJzjaX0EOiSKgZ7QouF6tLg8hI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T6wlFwuvyvo+fHR9V9xogdx+v14KHRsl+9OtNiQ1+gqinK0LkS93QygCP48107ZBNaM5NGBHQ8iC7Ny3O61GyHSEEJp8t/QAtDiHFsn43Gpz4tYBoU7P5vanu8g95yIQNDuwaAYAzb0vYV7xrl5CaffAlK46IjjWbxUsGQheZyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i0HYpqA9; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3e2055ce7b3so479575f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 05:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757595302; x=1758200102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lzHYWAUSXTU099HyzOJQWZd7CmwZnR6rVbbpZB00I6A=;
        b=i0HYpqA9pIZnYpH66vlaiYOoUVo2UcmMd8R1bZO1Br3fDvHP+XPLOWDweEnV9BG28l
         KMKIHIzqJVThkhBxjoonazAog5ojh8jILz2Ho5p9H+2irfGIsTAq0VF6jqSvTTlWl01g
         daNCOngDBz+dKWsV76O8rk3udNhCD1QFVtAgU6K3NgDa5iwuwjL7rUAeKgeDyixhotbb
         6/Zj08lQJtTUQJXRd2ABrbVpg/boX6pgUxdq32ovPgeZVfgE1iS/GGFX9vbhi6mks5Ae
         cwksYUyX966LFxtasKaaA4ifA+3ZkJLpg8IGObzFFsaohT04aIjla/ZJP0AxSMcBUMxk
         tDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757595302; x=1758200102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lzHYWAUSXTU099HyzOJQWZd7CmwZnR6rVbbpZB00I6A=;
        b=KdwDougoOeUEa0pYJxoeq+PKH4a5KSnWZ7+sby8rQKePN/cF2M3OsOUCYfUiu6vd/5
         eWTthDhHtVqlfOW1T+JdHHKQgW1YaGRDUGqxAEfIS0tl/2bbCgt4Q9wgFLYG908HeA+X
         lWdKc4RpeqTpQcPa9HEN/YybEqMMZDMUyO4IXuUG08qWMoRGng6Z8d+B+0kn45Sp0fYm
         S3RpYzPnNuhKd+vki/8KLs+/Fodsw817MJmSO2mXdy3RtuEegD4ux1kamlX7m3yFhSCx
         RtAmO++b7eO4kZjPsg7xv/1qswR5HfhCxzGwlZRKdfj6sXz7z5G33aOEjGeiGKVz1X5A
         1APQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrfLHeSCtMH5tX226o54+NrfAFPwbrhRu0ADmDgfnZarTJPcs4lMq/yNyHxQmS0Ol5xUqdyG4KwfxBO9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4BMdohTZNh9psdmlQyLRks/CVP92BGi2LGqRw5Zq9L7JQo/eU
	iEcTIa2JAPUHR9mV7T4AQlnDsYoS+HFw4rsrX7QkwqzF2bZv/lImALqRvpQgM9YLF5w=
X-Gm-Gg: ASbGncspew1mAa4Sw/m0xFAMacZaQm2zeyyKxYBjBb7Au/3cFGdT4lAezWiCikt1EcI
	+s19twA8Efh+H8hpgjE1KzUZ0+wtq74Fj10wcnr2AfFa2SaiiaLIYsUpcrRkgxrtpRXsOuE1p3g
	qZhskrQZp/vv0Gkb03NNuOouBC3F5Osg6LpPCnzi5bAzPoHBvYAy0v7zD1Sb3z6dTHkWwrseQPM
	E7wW0Q0aBTnU3SePmvViydqPHI5h5aU5Px0Ji4jzA64kNujvOvMwbpssk+RI9gE24xuIVvQrkdd
	Ykto4yY6Dxm+lWkIm7YLyQgcvwfvgClH1eUBIjprGPI0dprL8NGROnmOYWvyIJUo75VMd12dgnF
	WpGit1T3dnAcqK+U0YYN1husictdIfKmyr9dPfarebgAAHZRLLyAJVUmzZZP8R/3e4d4xz/5aiF
	Q6S/e7GfVMcaeWj0NIU2Ro+Ww=
X-Google-Smtp-Source: AGHT+IEebi/zE5XDYf831iEgQZ391cMJunsa1tiSBIWMBmOGscKQgCSQqBnDSCMdT7jr02fwbzNWdQ==
X-Received: by 2002:a05:6000:2003:b0:3e4:bb5f:ee6d with SMTP id ffacd0b85a97d-3e641a6015bmr16847418f8f.15.1757595301674;
        Thu, 11 Sep 2025 05:55:01 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d521:838e:7c69:f457? ([2a05:6e02:1041:c10:d521:838e:7c69:f457])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e7607d7593sm2360205f8f.43.2025.09.11.05.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 05:55:01 -0700 (PDT)
Message-ID: <b4d2ad54-54d5-4c26-be49-b6ac671683d2@linaro.org>
Date: Thu, 11 Sep 2025 14:55:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20250910155759.75380-1-daniel.lezcano@linaro.org>
 <20250910155759.75380-3-daniel.lezcano@linaro.org>
 <20250910183212.6640e662@jic23-huawei>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250910183212.6640e662@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Jonathan,

thanks for the review

On 10/09/2025 19:32, Jonathan Cameron wrote:
> On Wed, 10 Sep 2025 17:57:56 +0200
> Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

[ ... ]

>> +/* Main Configuration Register */
>> +#define REG_ADC_MCR(__base)		((__base) + 0x00)
> 
> I'm not really convinced these macros help over just having
> readl(info->regs + NXP_SADC_MCR_REG);

That is really a matter of taste :)

I used to create this format in order to stick the macros with the 
debugfs register code which is not part of these changes. There is a 
similar format in drivers/clocksource/timer-nxp-stm.c or 
driver/thermal/mediatek/lvts.c IMHO is less prone to error than base + 
REG all around the code.

Do you want me to convert all the macros to info->__base + MACRO ?

[ ... ]

>> +static const struct iio_chan_spec nxp_sar_adc_iio_channels[] = {
>> +	ADC_CHAN(0, IIO_VOLTAGE),
>> +	ADC_CHAN(1, IIO_VOLTAGE),
>> +	ADC_CHAN(2, IIO_VOLTAGE),
>> +	ADC_CHAN(3, IIO_VOLTAGE),
>> +	ADC_CHAN(4, IIO_VOLTAGE),
>> +	ADC_CHAN(5, IIO_VOLTAGE),
>> +	ADC_CHAN(6, IIO_VOLTAGE),
>> +	ADC_CHAN(7, IIO_VOLTAGE),
>> +	IIO_CHAN_SOFT_TIMESTAMP(32),
> 
> Whilst we only insist on monotonic numbering, putting it all the way down
> at 32 seems excessive. Why not 8?  Perhaps a comment if this is to avoid
> moving it for some future feature.

The ADC has 8 channels for external acquisition however others channels 
8->31 are described as reserved. They may evolve in the future to more 
channels. That is probably the reason why 32 is used here.

[ ... ]

>> +	indio_dev->name = dev_name(dev);
> 
> This should be the 'part number'.  That is a little ill defined
> for a SoC integrated ADC, but generally not what we get from dev_name()
> on the platform_device.

Sorry, I don't get the comment. If I refer to the different drivers 
there is not consistency with the iio_dev->name.

rtq6056.c:      indio_dev->name = "rtq6056";
rzg2l_adc.c:    indio_dev->name = DRIVER_NAME;
sc27xx_adc.c:   indio_dev->name = dev_name(dev);
mt6359-auxadc.c:  indio_dev->name = adc_dev->chip_info->model_name;
mcp3911.c:      indio_dev->name = spi_get_device_id(spi)->name;

Are you suggesting to use the compatible part number ?

	indio->name = "s32g2-sar-adc";




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


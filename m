Return-Path: <linux-kernel+bounces-818339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DA5B59025
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51A557A3AD3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C882E7162;
	Tue, 16 Sep 2025 08:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjNyl9ex"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE632E0902
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758010451; cv=none; b=ActjO+e+V56y7h5WS861NgRXhS3GHLvze4suYpIhzBaHMTW0Tc3epYKA6Q7IR5XcZhs6q3vCQcf3gt6VRTL70xcc4zAfPrU8kgT2xC0+NNgryfesVhl+vHOpUilBXVi452l2jxCeXtBYAwpoNA5VEyEXCmLpeObvLzNwKlNmqL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758010451; c=relaxed/simple;
	bh=OkRn3wi3vVLwlm/wDKzvfBew8i5CbraIcmJaOETj/3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k5ec1Li/XIkC5O4wOvKX1IR5VEp14/rK3JhBAR5sK8//gZoBlrNtFba5XNYJpueeQzG+HJQCXxIrAFqUxZylurTekbjmppH8KM3nGgU5cBwQiAeHk4+eF+ioPRjy3PKJU+JgVln3ySRmsacDIzJnDR1Fl6HtekqQ5NZeKe+wgM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjNyl9ex; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-352e19bd72fso26696111fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 01:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758010447; x=1758615247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jM7l65ARIgofwE06qZfm8EVMSCpb/5Bo5xaYN803ql8=;
        b=QjNyl9exinOXW2DeNKK2qEYSQo658maKc2gFnzV5hAynCMuw//y5r1Yp2TBHvlxmwn
         V1znYPL5cITxV1yJFBq5G8ZyVgKgXk5AI8JgYjCcdpyH2YinFjDx2XI+/W7ise6W6BOx
         KWz/+MevUNH02LbBC2mM5dXIM+C9eAIbh+Hg7rScT6z31a2vWgZLSvo6Eip2hO4Nwdux
         TE68w30keWAB2cFkrAjUkf2CRmPZJJ+FUDbHhCryO3OZn+0Kq7Ompg07WC3I3Br2oLPT
         fmyOY5Og15HbYur3DirQsNhvYRovbPj1YVAHUF5qEGU79+3C9yG/eixc0pWANoLJRNrY
         7hUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758010447; x=1758615247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jM7l65ARIgofwE06qZfm8EVMSCpb/5Bo5xaYN803ql8=;
        b=ogW6O+sp3KnmRU69BFsVsmvLsUHI/3p9ljQ9oM2Vc3g2WGHv/gXIRmpVwaxNBiQMhg
         yWFovbUN9QkXLRHFB7Srmc72Zs5K+9dRnFvv85QW3EH7Z73+kMtKaxBekxd5iUP9NBxn
         /sNBzIMiHn3toNPTRt/TOi2IzkWxk/Z4a+XKEeitTPNiodYQVsx7eyD7G2kxKKM+K/lH
         loycgreN0ahGmuxno0YY6lJEw8L79IWmeyez9YA8LivybD/BXHD/b+TFtPTM4LmsRsVJ
         ROZ+1aC+Uwef7KwCK0jU+lhgSWrId73tAHn+Rfy+5W600iMvGYOqwv6XNSRAPLASN218
         tcIA==
X-Forwarded-Encrypted: i=1; AJvYcCV8otdEF3xOF9i1So7mLjWBOPVxZ4IrUz9m3Bcp+ReCJXHAnHBTVhFBgojk4XqqPQQkFj5n5jIjJSGfzF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTUzpbTMnTrleUsog9M3VjL7pi2jgKUXf/Zifzn7ON7tYQ5Aj2
	9pTRJPgSQphuwhGITy7IiuuQ0WkTq7DV1pmdhvRTldxQcDhsIWwfbCUv
X-Gm-Gg: ASbGncuV3+0h9DzTkdZOSR7WDjqAVxQ+c85oA4wy7cueuaegGWNzfVLGjai3nh48O8q
	27pOk6JWI/sMQaaecuHMnH1zoEzsly2lBy5xXud1ZpSQI7mmtVWTGTRz41V8xvf/MShVf6ZvR1F
	VQWGzj+wgBYtz/zBeB81wSyh1RvIhXsyMfQUB/UdvDRlIdZ6oD0jaareuSeKOQBYE/RKWVscCTE
	9lOqDJIyBgDkEKYqmvQO//KvbGYY7jah7HwlmIfS/g+LsxZxgzBmc7mHQApJavCc7EuGU92Wpfq
	iu8Fvz4tilZgXtX0czQHZN/RxzLgUHS8aN8WdODgajUqwEEt6MEEDbGNao/yAMtjTRsC2iUYnIW
	drPQqBEdQgvLh4ZyVfKpg8M0wRVOijQFvw8DH8bdJpq22kVLB0wSwyE5ytTXg+VIBUzteZmyf7w
	VJ01yX
X-Google-Smtp-Source: AGHT+IEJVE0MZfILx6PWce4nwraMO2Nm8lxid/SAnbgN3RqRMuFMYn2p9OaYKJPnb6fEuEss67LUxw==
X-Received: by 2002:a2e:a016:0:20b0:336:7e31:6708 with SMTP id 38308e7fff4ca-351403eccb1mr36499181fa.37.1758010446711;
        Tue, 16 Sep 2025 01:14:06 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f163f495esm31002351fa.24.2025.09.16.01.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 01:14:06 -0700 (PDT)
Message-ID: <14d3dc56-c6cf-464a-9a57-2a7a6afe8af9@gmail.com>
Date: Tue, 16 Sep 2025 11:14:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20250915-bd79112-v5-0-a74e011a0560@gmail.com>
 <20250915-bd79112-v5-2-a74e011a0560@gmail.com>
 <aMge0jYwYCiY72Yb@smile.fi.intel.com> <20250915211321.47865d3d@jic23-huawei>
 <c1d21e3c-b0a3-40a5-b693-a38673f8bf53@gmail.com>
 <20250916090206.02f601be@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250916090206.02f601be@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/09/2025 11:02, Jonathan Cameron wrote:
> On Tue, 16 Sep 2025 07:52:07 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> On 15/09/2025 23:13, Jonathan Cameron wrote:
>>> On Mon, 15 Sep 2025 17:12:34 +0300
>>> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>>>    
>>>> On Mon, Sep 15, 2025 at 10:12:43AM +0300, Matti Vaittinen wrote:

>>> --- a/drivers/iio/adc/rohm-bd79112.c
>>> +++ b/drivers/iio/adc/rohm-bd79112.c
>>> @@ -454,12 +454,18 @@ static int bd79112_probe(struct spi_device *spi)
>>>           data->read_xfer[1].rx_buf = &data->read_rx;
>>>           data->read_xfer[1].len = sizeof(data->read_rx);
>>>           spi_message_init_with_transfers(&data->read_msg, data->read_xfer, 2);
>>> -       devm_spi_optimize_message(dev, spi, &data->read_msg);
>>> +       ret = devm_spi_optimize_message(dev, spi, &data->read_msg);
>>> +       if (ret < 0)
>>> +               return dev_err_probe(dev, ret,
>>> +                                    "Failed to optimize SPI read message\n");
>>>      
>>
>> I am not really sure under what conditions the
>> devm_spi_optimize_message() could fail. It might be enough to print a
>> warning and proceed, but I don't think returning is a problem either.
> 
> No. Don't proceed on an unexpected failure whatever it is.  That's
> storing up problems that may surface in a weird way later that is much
> harder to debug.

Just a generic note, not disagreeing in this case.

I have had similar discussions before - and I have been on the both 
sides of the table. Hence, I don't have as strong stance on this as you. 
On some situations it is better to just try proceeding as aborting the 
operation brings no sane corrective actions but just reduces a device 
unusable.

On the other hand, as you say, usually bailing out loud and early is the 
best way to pinpoint the problem and get things fixed.

I still think that logging a warning should be a decent hint for someone 
doing the debugging.

Well, as I said, returning here is Ok for me - thanks for taking care of 
it! :)

Yours,
	-- Matti


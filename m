Return-Path: <linux-kernel+bounces-819115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AAEB59BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4350F17A6D3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFC9341ADD;
	Tue, 16 Sep 2025 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Uf9uWLSm"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB337341661
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035300; cv=none; b=cvpSWjbIZQIPF6R3r4AI+b+34FxAs1rcGpN1D9c+WJ0d3Y3dI+z944kvrQDTmnD0vBcZnFVvf4jwpANEOdRrvtLACSumLJ7PS98V+Ckz7Uj6qo/0mJDCTUupdYBsJzlyvl2dAhzguUDOqPdRMBVZnGaA8qBXgpjVXhwW9yUOHRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035300; c=relaxed/simple;
	bh=yMmIPhxzCHiujCLC93yUulSj03dbgF3K8hp313sB11s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yvgl9hL7dF+rXSpYEBgZZ1ruZhmzzQQ/o+qiEUgHU3qBzwjgVZaU3xhyjJXCEpBufvuPNdBnnhJKVvqmnLcTKz3HowC5bURiHKgvFcWqkHjZdRCNUVLb7Vg+Fbb5yGkT0hMJc/xhzxZijVufcfuRLlRQ3gR9cbYol2tm9fO8Xhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Uf9uWLSm; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-61bf9ef4cc0so3681924eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758035297; x=1758640097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0VyxsRgwzT4WdBEZrPds7tFrERwbS24Tu8hrZOF5hOk=;
        b=Uf9uWLSmKe5L7hqyoMxADwXupTmT/AA9LPc3Vp3GKVRw+vPO8lL6EEe735P06P9IiY
         VfGffOEH9NGKytZZkPBFdeuZoWJzft+9VG93LeJ1QQWb8bsl0792YeMtQXpxRIVm98Ma
         bxMYaXCHI3AGdxdnjWWcfFoD0g4L3A8HaylmGxvXDZCwBQ2RUpgcIqLJrmV99oH5fxAU
         wN8QoGtZywGHpyyiArtDFUUcys6Df3dmmcSDUc160gr/CX2a7pyvV+9MiPOOReM1c8Tr
         pLnWJ3L9tngf5rlah5XwyjOl42kw3hSjbhZYwlQ+gJwZkDGOtWH8eFgoPJQji+qQi1Rk
         h2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758035297; x=1758640097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0VyxsRgwzT4WdBEZrPds7tFrERwbS24Tu8hrZOF5hOk=;
        b=mkw8C7zEWSiHXc5OOId+/xFDATOHpun6ivFcJzIjenAiCYTgTZTinNHujJkxpfX1K0
         9jcKcrsUOcm9D92l48qLEiS4yeMyCgdJCJyvvAdx/jOFnDbRCkddB84JxsdZni5h2Bjx
         +i3IvMBilROaqJMnZureo98gxJEnh+/8tHJ83VcjJlKNk/5Q/EHoEv3Zm65lcejIP+zu
         Jfvuwb543IE9nFKb4UkSybOHV+6CPrmv6i8kzI6WLUHrBS8LALTzDoZIv7ChkVa9Xhyl
         pGc1XrYe8E/Psg+9hWYf+tHh7JxkunlXFAsquab8Od52R3obc5L/jlI2g1fuLmP5j5kl
         X45g==
X-Forwarded-Encrypted: i=1; AJvYcCUMuLHwCPH7hFJhJckW8fhVh3ZD9eDsb9kFs2Brb/ijdzUTkmEh29at9ktdYl1UfA51IYlKt6uDVOZutGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaAdL96+Ro5HQQXzhJDcn+G4IPKdqoArZveKp04tQK8gEnd17G
	OY7SXEQhhHyromzqJZMpuD3RYcsb2o7mattishJYFL1GxuT252xNDTJO00u+yy+ld6A=
X-Gm-Gg: ASbGnctpQC0UFNGq+siHk7eHxXVm+95dXFleul8e1sJoiAj5muATv2DJxv6RlBgSrTf
	vwyvfj81ozw4qhyHf8b+Vq8EOOLB20pwh/qVWwN8Ow+3YRFsViTmaE4ts/JkjSB5acxVeHaKfF6
	NW5/JKFxwMwQ8zxM0tHHv6Py7Q8G3DeMqeZNeA16cvg9jvySmCSxQEPj52guCecBBirMpBnNCQ3
	ECw5/m2/B+4xg5qbLeE+InvkeuM817jbRjU/Liww6S11cQPhHOG15caF27Qph/0sJd7zDOYrwx4
	Qa4ne6BHq6bgvjv0ut7IbTah4EQYAk+SB0wrHgkkyFytUfRnXBmrjsqdRijNfCTf6XWvtwrGzeM
	FJexHi0bni8/dLh+MwegO9Ln95s2ECMFiFKQDOrBkYsV52o4D69tOWfyn6A7DvAF6Vv2+VlfRaP
	A=
X-Google-Smtp-Source: AGHT+IFbaLaefbFuTwBnBZB5B64hmkV14poQrqqnj/+jrHHe5Qend6k64W8dMu0a3pnSETsE0eaV5w==
X-Received: by 2002:a05:6808:159b:b0:439:adcd:9e83 with SMTP id 5614622812f47-43b8d8a279emr7619487b6e.21.1758035296903;
        Tue, 16 Sep 2025 08:08:16 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:70a1:e065:6248:ef8b? ([2600:8803:e7e4:1d00:70a1:e065:6248:ef8b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b828d31c0sm3270184b6e.1.2025.09.16.08.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 08:08:16 -0700 (PDT)
Message-ID: <6a1b7294-25b4-4363-87d7-2e91c9c1b157@baylibre.com>
Date: Tue, 16 Sep 2025 10:08:14 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20250915-bd79112-v5-0-a74e011a0560@gmail.com>
 <20250915-bd79112-v5-2-a74e011a0560@gmail.com>
 <aMge0jYwYCiY72Yb@smile.fi.intel.com> <20250915211321.47865d3d@jic23-huawei>
 <c1d21e3c-b0a3-40a5-b693-a38673f8bf53@gmail.com>
 <20250916090206.02f601be@jic23-huawei>
 <14d3dc56-c6cf-464a-9a57-2a7a6afe8af9@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <14d3dc56-c6cf-464a-9a57-2a7a6afe8af9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/16/25 3:14 AM, Matti Vaittinen wrote:
> On 16/09/2025 11:02, Jonathan Cameron wrote:
>> On Tue, 16 Sep 2025 07:52:07 +0300
>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>
>>> On 15/09/2025 23:13, Jonathan Cameron wrote:
>>>> On Mon, 15 Sep 2025 17:12:34 +0300
>>>> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>>>>   
>>>>> On Mon, Sep 15, 2025 at 10:12:43AM +0300, Matti Vaittinen wrote:
> 
>>>> --- a/drivers/iio/adc/rohm-bd79112.c
>>>> +++ b/drivers/iio/adc/rohm-bd79112.c
>>>> @@ -454,12 +454,18 @@ static int bd79112_probe(struct spi_device *spi)
>>>>           data->read_xfer[1].rx_buf = &data->read_rx;
>>>>           data->read_xfer[1].len = sizeof(data->read_rx);
>>>>           spi_message_init_with_transfers(&data->read_msg, data->read_xfer, 2);
>>>> -       devm_spi_optimize_message(dev, spi, &data->read_msg);
>>>> +       ret = devm_spi_optimize_message(dev, spi, &data->read_msg);
>>>> +       if (ret < 0)
>>>> +               return dev_err_probe(dev, ret,
>>>> +                                    "Failed to optimize SPI read message\n");
>>>>      
>>>
>>> I am not really sure under what conditions the
>>> devm_spi_optimize_message() could fail. It might be enough to print a
>>> warning and proceed, but I don't think returning is a problem either.
>>
>> No. Don't proceed on an unexpected failure whatever it is.  That's
>> storing up problems that may surface in a weird way later that is much
>> harder to debug.
> 
> Just a generic note, not disagreeing in this case.
> 
> I have had similar discussions before - and I have been on the both sides of the table. Hence, I don't have as strong stance on this as you. On some situations it is better to just try proceeding as aborting the operation brings no sane corrective actions but just reduces a device unusable.
> 
> On the other hand, as you say, usually bailing out loud and early is the best way to pinpoint the problem and get things fixed.
> 
> I still think that logging a warning should be a decent hint for someone doing the debugging.
> 
> Well, as I said, returning here is Ok for me - thanks for taking care of it! :)
> 
> Yours,
>     -- Matti

For devm_spi_optimize_message() specifically, there is no
point to continue after an error. The call of this will
just be deferred until the first SPI transfer and the same
error will happen again. If there is an error, it means there
is a programmer error and the SPI message is malformed
(or could be memory allocation failure). So better to fail
early anyway.


Return-Path: <linux-kernel+bounces-818327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6DAB58FF6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A803A474C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4912853F7;
	Tue, 16 Sep 2025 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mst3Nk8q"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B457D28504C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009861; cv=none; b=qMmYP9zvlZ8CUmmlvAjNvSBPxbI8TLsJh7IKzph2qAq7i5hysj/UF3tA7DN0puH9U5CXCxcdl6z4gjVGHrrgzeVxGXBnp3ZKGtfckAmKaooq96hKxaLRgUxaD36uEZO83rE/SOzqeOVOPviwXhmjb1kv7Fk1qj0bwGoUecKS2Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009861; c=relaxed/simple;
	bh=MNvlhLg8T5jVTXPi8BC/ZgKt7EeQ5fPjlU+o+01GoDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fe0fIvQzz1HB4qtPEiNYV2MwixsXxRQDiJB0lXqgVJEpydVEk54W1u4xRXHbIjXl4mwS5njq1cKSN1+0IhoSFeQFaaxcmp2sAFyT3ZH5lQv9co4wXPZApg6nCQJn6eQWro0O06gdprXQRbBLD+eV8WLUm7lOIzAdkAbu8bjSa4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mst3Nk8q; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f6017004dso5157934e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 01:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758009858; x=1758614658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4P7S8hmaYihFI7uhYTzYx531ZGw0hfreIoPsZI54Jik=;
        b=Mst3Nk8qVk6BIgxv9hLCjRiOb2bmMOtJ7Eig+RU1Zaf52nJP8N/8511kIruOVzARSM
         OgHAJ4GcCQP3uWshzLg8a7CRXTJSBdvMY4lbVtrvJlCvgamjsmz2cCxY37TO/pI27c13
         J8yDapUFRDGZmivqiX7Lf7iN2gsid89YY/LyE242AcaJMay+f0tfXFzxW3xALORHXeqx
         akiFlc6hsKXzrX04tg9lW4FJ1KrC3tszNAT8O7b0S+LFNMQilsPiC4FrNh7+E1zSURww
         xoxV1dKLKlUlsu+tEX2LOQhKAuzYEiq+1zG0zR+MViucV0xB0/M6+Kg6riwmRTm9eHBb
         oFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758009858; x=1758614658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4P7S8hmaYihFI7uhYTzYx531ZGw0hfreIoPsZI54Jik=;
        b=VLMN6CjgAOiNka/jjylb453pKHWJjKmY9RZPU2O6I7wBi+My8rmHMO3SXC0hnL1FqL
         E8HzhDMBITPY+Juou4bb7N5HgZ/hgFL6Wa5gQnGNHxd2kPN9BoKbV1oodHO1M4CmEah0
         2fDRseRXWq+E5Ye1NNLhUQdZMMtA6P9xDnJeZ6ZwarJ7HKqZZqq/RES0LVNQcL50uPHQ
         TuBf4OEnifLDFWyRaPN4INuRkVOjjBILwHKt8/FhvLWlG3z+obIf2Lov4hoPBNjFf5dX
         J2uMsJqKKzpjH5MKqGgQKG42JTL6mynu5FO9KRvLZ+WA/EO88RdMMfpfhbKp9og62zWW
         u6/A==
X-Forwarded-Encrypted: i=1; AJvYcCW/8PRrYkuUCOhKXef1bjcuPaGm2kYUBj3ExqDIWM4tFGmQ2oIKzmOfB5tqmD1LpVlRSJMRZccr9nyZNkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCnEHw5EH5AMD9pjSvNt86oCRzgxuO3OuvCasmRB/pbgDFUOMO
	m2rY1U60UkfDVi2nIZMp3/OJOrRKNNeELg4H48sHInyj4gDPQDHCWwK/
X-Gm-Gg: ASbGncsILldayzs5cm0Y5cBGU8qsRss/T1iwSOmhwBOYlIsYNMi17mHu2/IJycnXR1j
	gs1f8Pfxzk+dMG+DBJfRcFNaiWuNmlWEPTwOdZaDxPhnoOxvJd6DWIMHVgRB8cvSaMnCs2Aemyz
	8gfdviltfDptUMhwD2hwvlHazSa2JuQS+LsYCiZUe1SleVY75CeLhP4pSqsotMkPz2BsIDnT44/
	1vM0GGU2L/2QcphzKIvpic4obzJyz/zvi4Gj8AFm+vPzvoakBvs0Bo0l+dQ9iGUotKhwN//AFZw
	1H4MdDR2ZUdJHrAVcga2x8BMMkkhBh0bDK5/nqJhBhJfMXGA6yxC/p4ov9ab+tlqDSaTBBkpsTf
	NUlVSgTHZ2Drkj1PKynF6rQD+tES90RM0iT/rnlvh7Q0fuQy9YuKk/DbGq8qW+i19NAq0vj0grg
	i5vG+g
X-Google-Smtp-Source: AGHT+IFIOSeqw4PYtMvjdrOVsg9klefu6E0u1vhsc82aTrTg6jl010DCPH8XGwIGvu11SJLHEXDYIg==
X-Received: by 2002:ac2:4e99:0:b0:56e:53bc:7465 with SMTP id 2adb3069b0e04-5704e723ebbmr3896222e87.43.1758009857617;
        Tue, 16 Sep 2025 01:04:17 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571a6d1c5absm3115808e87.40.2025.09.16.01.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 01:04:17 -0700 (PDT)
Message-ID: <b35bd683-27b9-4a82-8a57-ed5bb1758ece@gmail.com>
Date: Tue, 16 Sep 2025 11:04:16 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20250915-bd79112-v5-0-a74e011a0560@gmail.com>
 <20250915-bd79112-v5-2-a74e011a0560@gmail.com>
 <aMge0jYwYCiY72Yb@smile.fi.intel.com>
 <0b97adc3-4d77-480f-ace9-a53403c62216@gmail.com>
 <CAHp75Vcwy47iqNYd4Q4A_X+BSLrFrHyqA2E2kcwbshm1badFqQ@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAHp75Vcwy47iqNYd4Q4A_X+BSLrFrHyqA2E2kcwbshm1badFqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/09/2025 10:39, Andy Shevchenko wrote:
> On Tue, Sep 16, 2025 at 7:48 AM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
>> On 15/09/2025 17:12, Andy Shevchenko wrote:
>>> On Mon, Sep 15, 2025 at 10:12:43AM +0300, Matti Vaittinen wrote:
> ...
> 
>>>> +    devm_spi_optimize_message(dev, spi, &data->read_msg);
>>>
>>> And if it fails?..
>>
>> I am not really sure under what conditions this would fail. Without
>> taking a further look at that - then we just use unoptimized SPI
>> transfers(?). Could warrant a warning print though.
> 
> What is the point of having devm_ variant for it if it never fails, please?

I didn't say it never fails. I said that I don't know what can cause the 
failure. Because I don't know this, I can't say if it is reasonable to 
assume the SPI (or the system in general) are in unusable state making 
the failure a show-stopper for this driver.

If the failure is indicating "only" a failure of "optimization" this 
call does, then the driver should still be able to do it's job even if 
the SPI performance was reduced. Hence aborting the probe might not be 
necessary but the driver could proceed - although emitting a warning 
should make sense.

Well, I presume failing of the devm_spi_optimize_message() is not likely 
to happen if system is working correctly. Thus I'm not against 
Jonathan's edit which aborts the probe.

Yours,
	-- Matti


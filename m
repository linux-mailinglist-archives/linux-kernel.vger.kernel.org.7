Return-Path: <linux-kernel+bounces-802940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EAAB4589C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02422584F3A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CF5279780;
	Fri,  5 Sep 2025 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xxBeQ60l"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86828283FE1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078323; cv=none; b=GCsp/Xeft08fNdOa+Gkg4dQiep1BM2SqAcVdHxzPCWBDZW8v7EyDvJ+PO9M1+ziqJQVoLcpFzx7Zs8KZvn2Kl8UOcIm2HViWS9i1DypHsI6Hbb/1UGDeArtL9+bhkCWowmzyG0cG3cWWDGnlqJN7RSSuNV5Zb81dGvufnr9FG20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078323; c=relaxed/simple;
	bh=PIam7/m1K9PLm4L0jcQY+prj0AzYeP/tg8hGBiPIGRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ieiaBIV9F0SVC8HMEKhsJmUz+fiAIg/7uwEOKuKpB2G6MYzNoIVLaVcUfhJ9xAW82hIGF/f/jIpBf6x4mYpXaJCh3Nd0mchrRMbxGaOhYUmSu1APMiz7YJFPrCLKr9JHPenGauwJdzlN9yqKJOaGEClmmNBLx3LNExape8/hmhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xxBeQ60l; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-321289dee84so273767fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 06:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757078320; x=1757683120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O9TLIpS6DZeFRvn5V0GqnS35zXXGwC7qVEOe9mwxEto=;
        b=xxBeQ60lCSeI2HNOz6YxaTwWZlRmvmXvidMvvZ/FBt+ryvwxGxaWw+zfnVyBBdnK4o
         nFBdFTqzVAbCENK3jJvmuZv7DQyhMUh5o08SzUHPGotT4dEVp+aY0LtIW8kaILeh7O/2
         gWhTZoqq0Sfsyb1GolAjjpYIcrEd/tWHwCj6kWRkgDeQsfsX3FDCUF8LEplnEKCoWJ2u
         sfgPEAuTStMIPfjptT7Gz8uIrwVLDatkjhZU/4Tvo28fazqfEPaSLfnoUBX5r1mc1Icp
         FRkPruWLey4fgdQ23iMTWG5840m3qNOqB1BEUVKuXCesCP0f+9lZS5ThIb9rVLIdLQm+
         bOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757078320; x=1757683120;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O9TLIpS6DZeFRvn5V0GqnS35zXXGwC7qVEOe9mwxEto=;
        b=A1p6FRo+fTC66zR0gWbz9Z7yiEAHhWBr3etEGqlq1pkZhenfKEF+QXmxk13ersmgIC
         ZkLQGdO1ToEQnwB80UdEmxiWOCobDLc3tAOejap/H828Y/FGo2UmOuNcXGXRmG0ttsyL
         mW6ovdW7Qyd0UI1J2axjnRzLrsqjSZpTiuj7LP+9XQ7TS5Han5EphFl7tcn+b4D7u6xc
         hAduv4g0Zhw0Eqx2KZ242W/g+8Qk4Mg7RgM7GB8KGojITYv3k9RIMj6y7WFDZTwDE1G7
         zVWlOa26/5IVBEbud3OkVEqpgFByoQQc4kYB6DqwB6Wb25NVJZ+J8XXUcfA3gCqhcJkm
         1QgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNr1XusDN3BHHpSQXh+tLM0t86embv0eYFrIjdtKtDOGtzLf6kD9t7pR+Bxxb05U2nZb6nVLZZd0i/7LM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoLGp904ibxpFqEIXJMvGr0C3GXV7cWPJu7r77sdKUxhZDtnZN
	7HdAnypji8TX9dDR9hhtXILqmPy4bviQia9pquAqoS+r/CMUFaha9oL6GOZzYWhtJK8=
X-Gm-Gg: ASbGnctz9I7bkMGTOG7kBQ3xqpdXAuZ9rj61jHzB0AcAl2is4hgfKjaxUkybcJ/AAy2
	546b7d3usi4/29Xvz4hwzrVwLntE1+MMrjl/YUPQZ5rYtF9FdMBpQ8ZYfBzjQnRGg7YlR+K5oIJ
	ytdtwM1mnRV3uioKKNUPZrsWR0NNweAGAIAebBdKI4Ec+MEf0FWFdKShg5cqph1ls30sLFTiqeg
	4Vj+T1zIWpkCP0OcDSVTq2OrwSVF5FmOZqpzXK88DPCjF6Q5S5/uRHRHcZ1QpwqIsrgGOOgoWvm
	FNdd7xzVnT+qznS3EGhnkgAe85eHc7df8AtuS5fVuhAB3D/gwUmJf3VxaV+BiTy3npn8/q08Zwn
	JQlgEP/MkA8A2SbIQud3OmLSKEZD5RoICkmBvuRkC/o3GGylniLAp2/48t2c/s63EFkqs8ckW
X-Google-Smtp-Source: AGHT+IHyoxG6K9p+b3Shk6yuqM1oSIsNJ35yj9FZbQDKHKWiZhaNJK5mV8FUrwQzu5hPKQ4b6+5Ivg==
X-Received: by 2002:a05:6870:cb99:b0:315:c171:a0ae with SMTP id 586e51a60fabf-31963194753mr10066349fac.20.1757078320292;
        Fri, 05 Sep 2025 06:18:40 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:52e:cda3:16cc:72bb? ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-31d63f159fdsm2922413fac.14.2025.09.05.06.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 06:18:38 -0700 (PDT)
Message-ID: <d9aa680f-0664-4caf-b885-92c3fce6c7a4@baylibre.com>
Date: Fri, 5 Sep 2025 08:18:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 Eason Yang <j2anfernee@gmail.com>,
 Pop Ioan Daniel <pop.ioan-daniel@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <cover.1756988028.git.mazziesaccount@gmail.com>
 <facc8b9255a754f767807b7e5c79c0eb20c680e4.1756988028.git.mazziesaccount@gmail.com>
 <aLmVzDB4bk-z5d16@smile.fi.intel.com>
 <796291b5-f61a-4d68-9cbb-ae099dbb93d8@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <796291b5-f61a-4d68-9cbb-ae099dbb93d8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/5/25 12:41 AM, Matti Vaittinen wrote:
> Hi dee Ho Andy!
> 
> Thanks again. I really appreciate the effort you put in these reviews! :)
> 
> On 04/09/2025 16:36, Andy Shevchenko wrote:
>> On Thu, Sep 04, 2025 at 03:36:46PM +0300, Matti Vaittinen wrote:
>>> The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
>>> be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
>>>
>>> The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
>>> voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
>>> daisy-chain configuration) and maximum sampling rate is 1MSPS.
>>>
>>> The IC does also support CRC but it is not implemented in the driver.
>>
>> ...
>>
>>> +/*
>>> + * The data-sheet explains register I/O communication as follows:
>>> + *
>>> + * Read, two 16-bit sequences separated by CSB:
>>> + * MOSI:
>>> + * SCK:    | 1 | 2 | 3   | 4      | 5 .. 8 | 9 .. 16 |
>>> + * data:| 0 | 0 |IOSET| RW (1) | ADDR   | 8'b0    |
>>> + *
>>> + * MISO:
>>> + * SCK:    | 1 .. 8 | 9 .. 16 |
>>> + * data:| 8'b0   | data    |
>>> + *
>>> + * Note, CSB is shown to be released between writing the address (MOSI) and
>>> + * reading the register data (MISO).
>>> + *
>>> + * Write, single 16-bit sequence:
>>> + * MOSI:
>>> + * SCK:    | 1 | 2 | 3   | 4     | 5 .. 8 |
>>> + * data:| 0 | 0 |IOSET| RW(0) | ADDR   |
>>> + *
>>> + * MISO:
>>> + * SCK:    | 1 .. 8 |
>>> + * data:| data   |
>>> + */
>>
>> I don't know how to read this comment. In the monospace font the whole block
>> looks like a mess.
> 
> What do you mean by a mess? Don't you have the '|' -characters aligned? That's very odd because they are aligned for me. Or, is this otherwise unclear?

I find these diagrams very hard to read as well. I would just drop this part
and let people look it up in the datasheet. I don't think it adds anything
essential to understanding how the driver works.



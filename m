Return-Path: <linux-kernel+bounces-815499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CD9B56762
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 11:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C4F17A75C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 09:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C7923909C;
	Sun, 14 Sep 2025 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ou2ulugE"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D27237713
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757841912; cv=none; b=pINR2y0ja6CBvELphGxmiIm0jFshv1J7dlSh/feFpYmImm2iZxtyajQ0o29MYbaONR6eLjkNoHwPRa953Ats7u0SS4i64lWvhvPts1GJnJfUXi7Mvq/E/3nyueoHAWuUZPZXML6zjdItB/RjRh0MEzDOidoV1t/OLeRVI8m0Dug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757841912; c=relaxed/simple;
	bh=+4rCll//JnoBBbuxAXcj/sXjckzLz0gNp0tqg1XIkys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hu4hxgvgqwLviBGzuFrBJgmLtv3wzdOQJeZS84vPed/6fKN7qn6s9VtfW2ilUeNPQQH4umlHUj8JUL8CL4s4vN7GNuYJo0K021oaYPIXUGD8EKtrafSblYJ5QwQ9ThKhpinLofxIi+tCdYa3nEur1jBrEq6SYH52IeAfafJZZAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ou2ulugE; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f7ab2a84eso3033078e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 02:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757841908; x=1758446708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ho58j4q8V+4E8zb9CufZ62itbJsz3Kolr/iP45Pw0Rc=;
        b=Ou2ulugEbuNt8gwKSxoQkbh5M4n34ZRR3/ZDIZ5cHlHNRYeQBYHALfXK9DRrBY4iMz
         H38ZWIiQg4U61NU2YFwIADh86IdCr27GD4JJXwOOf9WlHT6OKgwjJKKmaa4G9ehHWUvf
         ePMGvobZWCp6JNqfjvUpXGDQvP2J2pVFdZzwqL78nudqx82gBKOvNvldXLpnbBUXWeqJ
         pbD8rpXsXXRtfOGn9PBpvwGCHH8hLoMJnwuSCDSbspHRW74dgJMEJ39gH+QD8poYtEfG
         v2vSYpOjobnF31Njp2cBVmP80vMxnJ/gVDq6v9LFu+/shNgPHNyOO42sSTjdS585T6ah
         p3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757841908; x=1758446708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ho58j4q8V+4E8zb9CufZ62itbJsz3Kolr/iP45Pw0Rc=;
        b=ZKcNQau+WUn43fPASMRVuDTAPPxoq6xzRG7/7/7GkVq/vR2CvemHH/eSFKzBGGJwcB
         OZkhzJoI9/uSYMsZwlQdjYrqm9cX+Xz8a0dCgRPfdPOWo6pd0REe9MXrYGIbWfRtQiWI
         8DNg2VQs1iws9aLVKCXHqUs05hdqw9A1NQTYr6Ym/lcVj4XKG15p9TjBojtutdoIR1PW
         UOdl4HBu1BD6ZjzRMFeZstKgb9ZWDFUU8+kUXeQFjTlEQaMmKvsZdsrnuLE7LhvwrfS5
         cYim+3WLVJDogukM3d0SVyeJ/WSbAm5GrCqhKaTkvlTDqckfJU3wNK26qdQdmbaZxe+z
         drcA==
X-Forwarded-Encrypted: i=1; AJvYcCWDXD/VJzXpqyT3YF2oSjstfltWK8g3SFi1FBBRunXjIWfhr3TbGG3BQrwdfNUyVAS6tugimHs72J8+nWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YypMqhccJvBGoc0G1CY46lstMiGdZ1DI5tfSH3KAoWrFjNDcLjh
	n970hazIwLyiSEjHk6RzQonNwQdt+ynnfI4/+2iQBeWjLtqH/+Ls+BJF
X-Gm-Gg: ASbGncsvAed69ft/FPGS+Q1JlsY934JO5jA34S6koBAhwfEKKBJ136nDyXU2x19JGLw
	vt0S/p5ulzep14WEMGX721VDT5fyA9Wd2r/4fyW/kZy/Ky1DOA8Zaf1qUXaTXZjO3Z4UZXomcke
	MxZmQsjXG1VaRZCM+LnCHgDdKVrNoW42aERvKSs+9cQV7umWY6HU0LmA6qWFs3c8eoyIyTGSThB
	rRIDGrNYuxmKUHPKetSzIp6MGh7R3JDX7MgqmZqgdD+sfJtMXOtKd3n8TGrDjHE4/huQnH/Dxlc
	jvuOqfGNI2Y/9GGdAkvzF17iSgkhauqWsa6wYmFI1w8fF3snHxQDD4aEhMDX0Pd9TpxTZRf2pkv
	V+fDkASBHEAOZxJkDNWfVI6ZrBzGH4DDloQBfcsK5gascWko6F9FRUONPAOw7S9v8MvNXys9e7R
	MhTrALKxpzq/GBTB4=
X-Google-Smtp-Source: AGHT+IGAdpstb81hppchzd4Q1HxoZsk6kfcEpq+JyA9XWnS84y0k2oKP6wonMMCI2UNWVAsmaWZNPQ==
X-Received: by 2002:a05:6512:140d:b0:55f:7050:9550 with SMTP id 2adb3069b0e04-57050440100mr2502409e87.38.1757841908140;
        Sun, 14 Sep 2025 02:25:08 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c3b6167sm2721362e87.25.2025.09.14.02.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 02:25:07 -0700 (PDT)
Message-ID: <7c1cd888-539e-42f9-8333-a68044257531@gmail.com>
Date: Sun, 14 Sep 2025 12:25:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20250910-bd79112-v4-0-f82f43746a8c@gmail.com>
 <20250910-bd79112-v4-2-f82f43746a8c@gmail.com>
 <20250910184619.0303163d@jic23-huawei>
 <d586b4a3-8fb8-45b5-a5a6-5bee8d366879@gmail.com>
 <20250913132438.11d14416@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250913132438.11d14416@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/09/2025 15:24, Jonathan Cameron wrote:
> On Thu, 11 Sep 2025 08:13:03 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Morning Jonathan,
>>
>> On 10/09/2025 20:46, Jonathan Cameron wrote:
>>> On Wed, 10 Sep 2025 14:24:35 +0300
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>    
>>>> The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
>>>> be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
>>>>
>>>> The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
>>>> voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
>>>> daisy-chain configuration) and maximum sampling rate is 1MSPS.
>>>>
>>>> The IC does also support CRC but it is not implemented in the driver.
>>>>
>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>
>>> Hi Matti,
>>>
>>> A few trivial things that I'll tidy up if nothing else comes up (I might not
>>> bother given how trivial they are!)
>>
>> Thanks again!
>>
>>> Also one question. I couldn't immediately follow why any random register
>>> read is sanity checking if an ADC pin is configured as GPIO.
>>>    
>>
>> Ah. Valid question! I see my comment below is partially wrong.
>>
>>
>>>> +/*
>>>> + * Read transaction consists of two 16-bit sequences separated by CSB.
>>>> + * For register read, 'IOSET' bit must be set. For ADC read, IOSET is cleared
>>>> + * and ADDR equals the channel number (0 ... 31).
>>>> + *
>>>> + * First 16-bit sequence, MOSI as below, MISO data ignored:
>>>> + * - SCK: | 1 | 2 |   3   |    4   | 5 .. 8 | 9 .. 16 |
>>>> + * - MOSI:| 0 | 0 | IOSET | RW (1) |  ADDR  |  8'b0   |
>>>> + *
>>>> + * CSB released and re-acquired between these sequences
>>>> + *
>>>> + * Second 16-bit sequence, MISO as below, MOSI data ignored:
>>>> + *   For Register read data is 8 bits:
>>>> + *   - SCK: | 1 .. 8 |   9 .. 16   |
>>>> + *   - MISO:|  8'b0  | 8-bit data  |
>>>> + *
>>>> + *   For ADC read data is 12 bits:
>>>> + *   - SCK: | 1 .. 4 |   4 .. 16   |
>>>> + *   - MISO:|  4'b0  | 12-bit data |
>>
>> This is not 100% true. I overlooked the ADC read "status flag" when
>> adding this comment for the ADC data reading.
>>
>> This should be:
>>
>>    *   For ADC, read data is 12 bits prepended with a status flag:
>>    *   - SCK: | 1 |      2      | 3  4 |   4 .. 16   |
>>    *   - MISO:| 0 | STATUS_FLAG | 2'b0 | 12-bit data |
>>
>> The 'STATUS_FLAG' is set if the input pin is configured as a GPIO.
> 
> That's good additional info, but I'm still struggling on why
> we are effectively providing a 'debug' check in ever register
> read. My assumption is that it should never fire unless you have
> a driver bug?

Yes, a driver bug or someone accessing the ADC outside the driver.

I kind of agree the check shouldn't be needed - but I've seen quite a 
few driver bugs during my career. XD The check is _very_ light weight 
compared to the SPI access time - but you're right that it is done at 
every ADC data read - which is 'hot path'. As a result, I am not sure 
whether to leave or drop it.

Yours,
	-- Matti

> 
> Jonathan



Return-Path: <linux-kernel+bounces-806705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C751B49ACB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179A61BC08AC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7412DA75A;
	Mon,  8 Sep 2025 20:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tjo6IIur"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9842D97AF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 20:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757362513; cv=none; b=Yha0dVzpWA8+vwja6X37ANWPy1OJYECPgKdvpJP2oGf/DyYxdViQ3tL6GY9nj4L0WbkRj8WDPTkNEkfnHLepGc2AGDecKsjc7SkKBrC5dcOZduGGqHhZbNbZKmPc23yadg8ss5PbP0B5hIsxYCMkJNPjubpz0RQGIuiH0vrJB9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757362513; c=relaxed/simple;
	bh=wh/dd7Jdte+PbRR35ECUmzuAI6uCWTfbMFdZ01umIwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bhu4hPJKPZIuJGEf0DDLqKsTafwyAJPfTVGPK2Je0/0f0xSkc8TkNxpvMYgx/yR9P6Hqa6mqSJCR0JoZ8T4cRgHouVg6SveG6N6vSewjfq/Tn8yoXry1oncZGb2ahsS1nUwMyUbEvepy2fC9CVsrz3B2izWnn3DzCyDy73yVNhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tjo6IIur; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3dce6eed889so3885690f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 13:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757362510; x=1757967310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jjQ5+oMfNA1z8X7OxHRV6oMq0vnVY8/Ms0Vhwhb2pfo=;
        b=tjo6IIurFIbys5VsS5hON1eX7rorrj7wDmCV2UaXXk6vc8T/sv7L+ma8KBW5vLj3gH
         llFKg7kXpF85QMtMObnRqoL44kIgck6ZLihe8nHd5rnByuoZ2yCpZxFaRbGgwl4UTG7t
         jzRw08YdAOoIsXbFxtFnh7F6/oPM3mN6TbFrO1gNES29UOb03xrkNQz3csIf843WO3yR
         Bg+TxUpaS1wQqc5XHsvvSnCARcre0M3UYqZ1YLaFfak4HVkIHRIdzq12NCK4IQn5RiuD
         Fh/7EE3s9guLh4mOja12ptg9fISyzAeN/nGYRqXbOolq80OHeib/X4OFvwcXPN9R+2mR
         Wztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757362510; x=1757967310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjQ5+oMfNA1z8X7OxHRV6oMq0vnVY8/Ms0Vhwhb2pfo=;
        b=cNXuExJvUmOdm0q2h3S0rhlzZOg2lMIR2UEd/aQYRpl1xT31djyjzLdHPlO+UhiLDu
         I14thqZ8R4wCtk/7VsolX0gkL77A9CCAkFNu3q7rVQzGOeHJG/0y9+ITQpJIzFFrVqAw
         CTsT24//xil+G8uFGKKabMg3/Ltfs0aE07gIG/QHZ9/t6r0LfnkquIjmdQUieDH/gifJ
         c8gPJqWhJjVceYW+oWfU3ceHqKoKVwiDGr6UN1U+uRZVYhtF5AVK4UbsoJvk+SR9+aX0
         9KeLKZJFdMDcL50e2F6Xz9T7POTBoxbi48C48zPCmGPbuwPK1ompSoAppydbKAMDeMYg
         tr1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYPOuLDdT3dW4R6W2pbqdUyIVs3EWXHn7AGaEOMRy2W4y4xPT6ZuENidB5TKGvsrXMBFCxdzEwV8t3/bI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBeK+Bvj3n/TcNurrr3tJZBQQeTmWhILYSZFOuPDDYcKfxzbCu
	Zdu/+y8BgXgUHp8Szsl60lBGHmbkxyAQrGq5s0kYf8MijU/8GdYIyINaNbFoKfhCAqVPZNtRJy7
	i0LEYNO8=
X-Gm-Gg: ASbGncsOJKUSyv1VS1uLC2zdJxrvd4e87EwQUUYayMriJxO8Ii1ePumxbRmImuWJo9s
	CgxS4gUHMgAmfi8licO8ctVoC14U/T36j3PViK2t9vb3LW4USDjxY5tLNlBqHuvGi4mad3Mzm3p
	qFLhnC95qVSuv8VVikAXtM7EzfUpYH/lL57RNxb8IteuVDx2dmkj8XOwOsb8iAqEbK1pnRw4cJv
	1TBE40GYKHi8Ko9zzBPH2qoOCu4edi0Yt/fJ4it9pSL/v7C/joL9ZSbkljvLfCFTS1lUdko/TTX
	nejuunOYbstvyisdU1CCJr4azIaK26vo+P3b9yxfZPjRbIh9m51QWDqsTaFX0k6fBcgYD+ZFSqQ
	wLvepoqRFnoZ2wdVNp/GUXnfkJg==
X-Google-Smtp-Source: AGHT+IEUXK+5uzEYEeWM2C4ugYvoTxY9jWpw3+DQwWpEwD7U8BI+a4nggbRKv+GtES+a6PSycdGhyA==
X-Received: by 2002:a5d:5f87:0:b0:3e2:804b:bfed with SMTP id ffacd0b85a97d-3e64c1c2183mr8374205f8f.42.1757362509754;
        Mon, 08 Sep 2025 13:15:09 -0700 (PDT)
Received: from [192.168.3.100] ([151.42.66.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e411219ddfsm13631814f8f.57.2025.09.08.13.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 13:15:09 -0700 (PDT)
Message-ID: <29a776da-cd28-46e4-8b64-400f462d8670@baylibre.com>
Date: Mon, 8 Sep 2025 22:15:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: amlogic: gxbb-odroidc2: remove UHS capability
 for SD card
Content-Language: en-US
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250907-fix-reboot-v1-1-7606fc91254e@baylibre.com>
 <1jecsi3ywb.fsf@starbuckisacylon.baylibre.com>
From: Valerio Setti <vsetti@baylibre.com>
In-Reply-To: <1jecsi3ywb.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks a lot for the review!

> The above should be enough.
> 
>>   	max-frequency = <100000000>;
>>   	disable-wp;
>>   
>>   	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>>   
>>   	vmmc-supply = <&tflash_vdd>;
>> -	vqmmc-supply = <&tf_io>;
> 
> ... but do not remove that.
> 
> That way the description is complete and the kernel is able to verify
> the regulator is properly configured.

Thanks for the hint! I didn't thought about this while working on it, 
but I tried it today and it worked perfectly.

> It is also easier for a bootloader to alter DT to add the UHS modes back
> (it is safe to do so if booting from another device that SD, such as
> eMMC)

This sounds like a nice improvement as well.

-- 
Valerio



Return-Path: <linux-kernel+bounces-791518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF50EB3B7DB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062575E48D1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E463054FA;
	Fri, 29 Aug 2025 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNc+BVsl"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B3928369A;
	Fri, 29 Aug 2025 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756461310; cv=none; b=Uy1MWcPHahqiytSn2KkHwF/o5FlGoLlg2rMoOni46JjHeqr1HG2GAS7egDUlyXF4Wr67tPt4KC6bBUMd8PBvHn8JX31c2XBPNDP12+SkjzVe+Ja9k/FonLNv1P42VfVjDgJ0kp5Ajt1zf4W2yjX5Z5sJSN7zhQPlj8/Luz+2fQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756461310; c=relaxed/simple;
	bh=lvnwu7JnIP2q7gxbn1yrIfxas5RvzC07Sryq3Oin270=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XHByJEFyKRa1M8KeAR7ikveo2TSLqPIHT0tZpbhcLgRtOfZtez0e4Gttj9eV9PTLoj1qZM1E2c1F0D+FQkO9BPrLda8v3GT4OAoS0Qf9nUlMs3gHxBbXtq43QK1atQI53pAbOmUoZp6StK8fq+8ELLChnfhIjGrETm/+epMi94s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNc+BVsl; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-327d8df861dso521495a91.2;
        Fri, 29 Aug 2025 02:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756461307; x=1757066107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pW9vz7eoAXqSFc+veThXo+AD+HH5rynr8/WpL9+HEgo=;
        b=LNc+BVsl3lS491mu8YIfqNHGMIps8d0hEvapppVoWzd3j7xcgpFzwlRKwg8iIjUot1
         mJ8tZqcDTNNU4RNzEA9EbG6qdJJe8dIZoCtw9s0ZnccwOAyOfeifWWT53RB7bFTIbulx
         uRprktsrDCBl9fyIR/Ym3TjMaonkjCxeaVhiq81z9Fk7E83M5JBlMtcZCGGMy7iz+6rM
         QejCL0tG5f0+MYBi3/8+r32QzZ2AIE1bO6bRkK1Z7e3bcWEUkPF6XNgN0HPQs/tHQgYK
         /6GU4rsmHoy5YZKtGrWSOXtK/vu6uamlg73qIQhmUjs72LGbQrDs/Umn4pstGFh7IMJl
         wpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756461307; x=1757066107;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pW9vz7eoAXqSFc+veThXo+AD+HH5rynr8/WpL9+HEgo=;
        b=IBh2sHwMW4sZxnRQB3NpQEGyTN+2Rduugl20iOmNRy1qnm1RR8YnVKJQGbRL0FbIKk
         F1HvN+M8Ya168gLFg2rC+Wzi3i6QM7a00fpG8nrxHKB+C0V34QRdy6V+/OH8+L6xz1r9
         OfUzKkUNc8Bd2PjiPK2CB5ykjEjzwj+tyYjbAMGCjDjwcR9rP5E6+JcNfLBt/spGxx4a
         DIxnKBjwHd0K+IYi122jsaxRVe6H+MNQPjwv/62ylfS58w3YdGEfUKT+/M/AOpbwH+qv
         ek7lH4tJzOHVZTtHRjBWmlmMGEq+CQ1VQRmCB+Aerat0WXpf6DmInAe1WyKv0yD61zyU
         B88g==
X-Forwarded-Encrypted: i=1; AJvYcCUrtuOZvdSJ3ycd0+f2zlewzMNk1eKiS/RJzWmJEpSUvBvZCdkxxo9UeGhCictFRLAeT5hhD9N0ZXB0@vger.kernel.org, AJvYcCV3u8fWyoVkfrJnUAYGNKvTDN3BtU1M9ZDQoUXW7OAyuir8m5f0VmZe2GWUmoJlOmVQrsMOzSOQRvAr@vger.kernel.org, AJvYcCXjAvu0Hi2l7YAtfsZlFxE8r0wLri6+krx8meIVJNN+xiDIWFjJ+uFdvPHLgpwUdX1yVbVdIeCJHBfrAx3V@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0DKFfb0WlmkMZ5sHyILWEwsxzSvLfdZpc6p068Dy+c0BD2tO+
	kGy7a1VJ3u2Tcvv9fRA4vThrrGKftt6ayUe0fqFNQiePFdg+hj6yX/+KFU+aDA==
X-Gm-Gg: ASbGncv4FOHNUXeiK29fesDEI9KB/U7qEi9YD+h9CV8UuTuru7tmt/QB3nmg/B9E2dB
	WXf5+g/+XRb5fXeCwOv8wdYVrNXAWdrIjVMSt1opfGimDDuKJT5qbtn7MqJkzG3A7Asm0v4W5YE
	E6c3NL4hj3XLczg9xLdmGkNjUFG+GL9Tzkzm+iH0sCm7HRcOSHZQVkDpjlQ3yqqdvhMOzx1CQix
	+RnJh7Vy1w5b77rWVLB0Eao5r56XXNkF6gab+qUnm2/x1/nEwwRwxBLzBUgkafFB2YkAZYErwa1
	XcAWcXcBTQiLYPYsgTwK3j0tHTybwo6NzqHoxhq3Bu0HCX0ireH8ZMlE1rk2m80oDRlLLNGJ98O
	FxBGEjRDqSmy0VxDBu+m9KmxHaDBQwfL9L/HzLfmi3LCgIO6Rq4OM58isOMFdv0Jzzojjy8oCXf
	uI9oP8yw==
X-Google-Smtp-Source: AGHT+IEi+rYMZdXOlNbObuRThfaUFvvBCVnU5aSV8xEMb1JfxCqZFJVFUTrJj3TC2y54JTzPfOuDjA==
X-Received: by 2002:a17:90b:4ac7:b0:327:c417:fec with SMTP id 98e67ed59e1d1-327c4171187mr7346658a91.15.1756461307249;
        Fri, 29 Aug 2025 02:55:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fde4cecsm7677506a91.29.2025.08.29.02.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 02:55:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ba2f563e-4eb3-42be-af05-c01bcef1d5e3@roeck-us.net>
Date: Fri, 29 Aug 2025 02:55:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] hwmon: (ina238) Correctly clamp temperature
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, jdelvare@suse.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
 wenliang202407@163.com, jre@pengutronix.de
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250829030512.1179998-1-chris.packham@alliedtelesis.co.nz>
 <20250829030512.1179998-3-chris.packham@alliedtelesis.co.nz>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250829030512.1179998-3-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/25 20:05, Chris Packham wrote:
> ina238_write_temp() was attempting to clamp the user input but was
> throwing away the result. Ensure that we clamp the value to the
> appropriate range before it is converted into a register value.
> 
> Fixes: 0d9f596b1fe3 ("hwmon: (ina238) Modify the calculation formula to adapt to different chips")
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>      Changes in v3:
>      - New. Split off bugfix from main patch
> 
>   drivers/hwmon/ina238.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/ina238.c b/drivers/hwmon/ina238.c
> index 5a394eeff676..4d3dc018ead9 100644
> --- a/drivers/hwmon/ina238.c
> +++ b/drivers/hwmon/ina238.c
> @@ -572,7 +572,7 @@ static int ina238_write_temp(struct device *dev, u32 attr, long val)
>   		return -EOPNOTSUPP;
>   
>   	/* Signed */
> -	regval = clamp_val(val, -40000, 125000);
> +	val = clamp_val(val, -40000, 125000);

That needs another correction: As it turns out, the default register value
is 0x7ff0, or 255875. That means we need to accept that range. The same is
probably true for negative temperatures, but I'll need to see the real chip
to be sure.

Yes, the chips only support a limited temperature range, but that is the
limit register, not the supported range. Other chips have a similar problem.
It is ok to limit the input range if the chip has a reasonable default set,
but if the actual chip default is 0x7ff0 or 255.875 degrees C we need to
support writing that value.

Guenter



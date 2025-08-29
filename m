Return-Path: <linux-kernel+bounces-792086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B98B3C012
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2987B1C23527
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457D73277B4;
	Fri, 29 Aug 2025 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bnJl5F14"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5D2326D7C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482757; cv=none; b=m/VvAmfJH6bP79kayI0SuHPWx796L+KVx5/aY6GVhglA5d8X/6qoUhTrbawZ+gY/XEGP1BQTU+lSEquYMFEfT/8PfbCCDrnME9sgcMZ5ydnXscEb3y8YXud6amHSsuzhpKEgExF4TwGCxeidS350c7QaPn0+W2OfTWdSFPZf8zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482757; c=relaxed/simple;
	bh=5Ym/jwTYuBac6qN/bi6EC8idQbMmFWSlyiT3FprCvsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BnHWqrgctQlYIJGCGNKv8sygyrmrHoC2ozap36ogUMgjxPwtRqZ+L9F+1McrvdQtRxRO1Rtq7B2Et1e11c0Ym9+eBADz0Pq5CbPhgWgqtzL5paL2zKZ/LwHwWKei4f62HtA+JLHFeSmrc7QAmykOLorQgo/mm6tKKeMBpypOjKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bnJl5F14; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-74382025891so1712033a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756482755; x=1757087555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+23BJPCKtGorADDC890VMTVjWSuA//k7zazsu5ZdqXU=;
        b=bnJl5F14HpVRdVjNzcgeaOWTEPn3joHTxD4OBFMS+NtSkqpX0mNowq2qQ23e+D6PKF
         xK4BU4OOzUbIYf+sXLQ14p3/9rIvd7E7Nv65CT/yJ3+3MAWbwRyf5cbUJdO1SeCS5wOq
         y9jcafCdq7kpcOCXVsfFXsNocNcTNMDA6OalA/pC2QfSmvJWCV3jaW27wSqZvi/JmPib
         0Z7TknDHnkWjLLukCWIhavuLBz4f6HYPk7n+UdLC00wFmgFMiRqQWnGm7I3DZ+8VAkVX
         1W8hCKWtGGnzPOi7IoEZfZGIStiRIE/oRyHXjjXyN9XCGdNKXKl7ZiXg/dKBdBzd0+L4
         UpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756482755; x=1757087555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+23BJPCKtGorADDC890VMTVjWSuA//k7zazsu5ZdqXU=;
        b=QbB/I+Ubhr03OS8SH093x8ZPDLedcwACXeMEzGNBX8h7PwQo0AqvvFcwF3Hxkl3m3L
         MMslb1k3JqfU8U7W7osBF4YP9er7c7s7JANt6WZVILnXObIz6CQypBvlaqdnUl/TVnwn
         1KDSiRxPfB1ZU+DaV8gYM8KJ9i0rP344+5k0jW7xMjus5OwbCvU76pMOiLFknIBh7nZW
         l0swml6ZceSu5cmWiR+32MS4qF69fZC5HPxkDiJwW/3W4qUOvkLFQI4OC5aIGM6a7ctO
         TQWl+L+NBJrIdyVppsLRFQzp9JihucgqcnAeYd8mWM5IOH0vjqK6TaCqnmb3ABCNLixT
         1szw==
X-Forwarded-Encrypted: i=1; AJvYcCWnF/oLnFcxQoGTWjHmJYWnQEgYBHch4hjs9Kpb4ezmLg23EweqHewkf2u/i02IV3kxp2rt+/raJ+kyt8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOIc9ol+vjnlwUeO1vqvME/fZC5heh5j39KaxGZOJFJOKOqgmj
	9age1dHYRFrOKPc7m3A4VbfJDpsFnRqOsGCjmuLSV3xziy8AepvUidBfvSq9k7mnx34=
X-Gm-Gg: ASbGncuCtBvc1G7R0FZUUqG6jMkIfQckWLyMlikXXvRojohlJHGPuhwPZK7Vw2wjGnm
	1FrriPxBVWxPm0dDv7ZejcVQkzRl9VWPUFl66uxnwTfQMg+39MUb2I623rJw+F1Z75ZciEQIwF/
	nxOjYCy9a5HlcSkJqAJoHYRFhwnDE1AyhVOu5HRlvxcPIR4aA4OB55N0VW2Rak79wYqohgTkuRj
	i+1gHf4CMSbxAbvZmjwvkIpDve8K5yuYtpPQh9VUicufYkenoVNO5zl3QeJlxuar8iVepCnkB3O
	WWcY6SFdu+SGvs0+MZpD35DxMF9uxT6jYegimom06BDu5k9rPjlaNJibO0mHDbIzOJARhLiU+Q0
	V7zoyvWhKGVpCwKzZ9mKWpy7RAq6L/b4E9vtJcXYJu5a47hQOby97hLNftQHAiFQGirGpwYIjq0
	ffLMmnhzJxwE+XCl/aqij+
X-Google-Smtp-Source: AGHT+IEXWYEKh1DA738p/y0oOalJucxmoKHVU9lI6MvOI7wGYxwoLUOBIB8PEz52I2MRTw1eKDB1JA==
X-Received: by 2002:a05:6808:81d3:b0:437:aedd:f87 with SMTP id 5614622812f47-437aedd13admr7644840b6e.41.1756482754716;
        Fri, 29 Aug 2025 08:52:34 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:8d0a:2553:5881:1318? ([2600:8803:e7e4:1d00:8d0a:2553:5881:1318])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-437f41765fasm21636b6e.8.2025.08.29.08.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 08:52:33 -0700 (PDT)
Message-ID: <960b23ff-827f-4ac6-a951-c61a0fec0c11@baylibre.com>
Date: Fri, 29 Aug 2025 10:52:32 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adc: Add driver for Marvell 88PM886 PMIC ADC
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Karel Balej <balejk@matfyz.cz>, Lee Jones <lee@kernel.org>,
 David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20250829-88pm886-gpadc-v1-0-f60262266fea@dujemihanovic.xyz>
 <20250829-88pm886-gpadc-v1-1-f60262266fea@dujemihanovic.xyz>
 <4f93d53a-3dfa-4b9f-8c09-73703888d263@baylibre.com>
 <2250556.Mh6RI2rZIc@radijator>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2250556.Mh6RI2rZIc@radijator>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/29/25 10:20 AM, Duje Mihanović wrote:
> On Friday, 29 August 2025 01:40:56 Central European Summer Time David Lechner wrote:

...

>>> +		*val = raw;
>>> +		dev_dbg(&iio->dev, "chan: %d, raw: %d\n", chan->channel, *val);
>>> +		ret = IIO_VAL_INT;
>>> +		break;
>>> +	case IIO_CHAN_INFO_PROCESSED: {
>>
>> Unusual to have both raw and processed. What is the motivation?
> 
> I was following what ab8500-gpadc does, no particular motivation.
> Considering the above, to me it makes the most sense to limit it to
> processed.
> 

In IIO, we generally prefer do the least amount of processing on
the value from the hardware, so IIO_CHAN_INFO_RAW is mostly used
and processed is only used in cases where there isn't linear scaling
or some other unusually thing going on.

So in this driver, processed probably makes sense for the resistance
channels since we have to do some calculation anyway, but for the
voltage channels, raw would be preferred.


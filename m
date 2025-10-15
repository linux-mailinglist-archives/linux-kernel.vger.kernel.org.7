Return-Path: <linux-kernel+bounces-855104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B86BE03E7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFCD24E9D9E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E28E298CC0;
	Wed, 15 Oct 2025 18:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OZjNTkPq"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7D26B942
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553994; cv=none; b=IWcOpAHrhe5zQasqK/z+Kas6R0pJHYu9URxwmgB7gAWf/CJjClGGWxtPTaM+mfaWHKdaJoPdKhL8IFxzHY3WjBPCE8NRNJwk4Q8wiTi895dSe/xWs1CRBKCgnt9u2FtN5fLRCqpF4Nf3a8ta/5dgDWDXEmkNiPxlH1CUpjum7rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553994; c=relaxed/simple;
	bh=YvgiZGtPFbCt2IU0u4vPOg9X+YBDn8GnfhZjI9AxjG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J30YVyG8Lnfz91e+i1BAGBsbXQM/ofNbfQzlBmCsM+Mh9xsW7eCd6pPMOnxjAB1vUbvYOD6V53zBuVdn9ERI3UfLjNLeU3kLg+Xurrma0KZPBdRurm/JlzVTWu4SewT2nJn32DLYo4bsN81CQGGD+apZ7D+b0BnN2RoYi7IorgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OZjNTkPq; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7bc626c5467so5174351a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760553990; x=1761158790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q1W1dpMIImxvQoP7g+++7QUy7cb9UdrUIxFQdJbQORk=;
        b=OZjNTkPqz6clw+zEkoi2JtBkcRSS5faiKVbPkh8zt+IremB1i11rtHe5SwqJDD8OI4
         ZtVT8D9M4NqvlSRPdHzXyNICvhv62MJ/cgu2R6N1mNyj2GuXDxjWARQo2ZgZawb7YFJs
         eqG0M2cK8bbxcmLAkIvs/tzucffpGHlE/l36fuZV4BUbU5pc5rlsKr+hsGUe3iubF2hq
         JvL5FbMHayWuKx9XlCpuFfcRKjqvemqLNq5lS9bZ8eT14FWGuGoS4I4Zhnz8pZrR1XXc
         fhwIrWiu+V31qK5MZh8vB3i0cr9chgxS/cA0Eptpi8IiPCHNOS0M7oTOXRx/WuQGFKg8
         09WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760553990; x=1761158790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q1W1dpMIImxvQoP7g+++7QUy7cb9UdrUIxFQdJbQORk=;
        b=Zgw7eYGoAAizD17qqWJLtO8833nGX20G0vpUJd8CJZzv03SoTZI2eFXgKdCiMDG1nn
         yzMBdvFf0ifGYp1MGILmDGKDMW1UHbv3kFArm/uyeKaADP82TmsSXPD6VeOJPoHHlnf6
         jjaRG/lV7bFTNdY6YTDV/FMsi4CTOdSV1L3QxB01J3h1TeU3bNijMO7w01jJcOgUsuD4
         q2sat+EWncaxU7CopZDLi5XhZGGH8v6jAXaEFCxWu9OsxGF6ELd04afsAUTtpU9SJeY6
         EGEkVn+OCbABC8MUQvbQKTjnElygRWqech8zt8WjwHWkcCPVdzH2siRQFog0kv6x92jd
         Xexw==
X-Forwarded-Encrypted: i=1; AJvYcCWx27HwO6mzhIyT7CeKfnpSJN4O11nyrmJVcXMq3AslNH+vXIybQ/0kJRGiToaUjDmca7qOK4HjYv1DdLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkxfFbNwCBC8vHDbJBoI/mbORmQOByXVRbLZag28eijAfHPnTF
	UYQ46sxlnqAEQMnJhkLkIEZWeuCHkbNA49D8O/gt0Gicqay1ZjNTBqkuqOU0AsxO2Cs=
X-Gm-Gg: ASbGncuydJVVOYc8Z5rNFwXqV/lZ5vIoazDYoT8HuWM+jhQh4Jexi2bHwjWWfV/lzwg
	ZVOVmBVQuuvbIt1YRHG6u7sr/gankzNgXG/Wm9dSpD/2rzbmIX5/zQpZs02XZ43iDP4c/kBbNbl
	fznD9JlSmT67i5ms3muSK3Ogo12SzJtG1oXyfiOYlkNEvrZVUjCV+TVLHbeqMjyF3yi1xkiaPln
	YYlRxyod7AyZ4E3SojJ0pTWdrqczrolxRSxuHVOASf+P+rQdtoaU/UEOX6BnVW1gTmx7mzHXhPa
	wCIx08ep7HpW7p/vuO75Dl8BpXwsRrpRquO+SnL7sJmw4UqaO1PyH9rSNz0WPEoXLzQfzAx9tXg
	cJ1aDS55IbRlKmlzYX9Ia87R1U5XiqPFpUUhRWviYolCrY5Gkr8WnTRIhd/teFTYb33Ac6VRJoX
	NRokic0pDueL4TILg=
X-Google-Smtp-Source: AGHT+IEeWyUK5JU0xMQ0zLXGTri5uRlu04b7SEkveGRRQqga9ddNeRw/aypGJc8FLMQHLk6d2PIOZw==
X-Received: by 2002:a05:6808:1b13:b0:43f:7e97:397f with SMTP id 5614622812f47-4417b3de534mr14932239b6e.41.1760553990406;
        Wed, 15 Oct 2025 11:46:30 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:c482:1912:c2de:367e? ([2600:8803:e7e4:500:c482:1912:c2de:367e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-441c9209c34sm3068700b6e.8.2025.10.15.11.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 11:46:29 -0700 (PDT)
Message-ID: <1d9704c6-1729-4288-973b-3b3596609553@baylibre.com>
Date: Wed, 15 Oct 2025 13:46:27 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] iio: adc: ad7380: Add support for multiple SPI buses
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
 <20251014-spi-add-multi-bus-support-v1-6-2098c12d6f5f@baylibre.com>
 <ef452c01679bee2c8bdbefe1df4775c432f8b345.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ef452c01679bee2c8bdbefe1df4775c432f8b345.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/15/25 5:36 AM, Nuno Sá wrote:
> On Tue, 2025-10-14 at 17:02 -0500, David Lechner wrote:

...

>>  
>>  	if (st->seq) {
>>  		xfer[0].delay.value = xfer[1].delay.value = t_convert;
>> @@ -1124,6 +1118,7 @@ static int ad7380_update_xfers(struct ad7380_state *st,
>>  			AD7380_SPI_BYTES(scan_type) *
>>  			st->chip_info->num_simult_channels;
>>  		xfer[3].rx_buf = xfer[2].rx_buf + xfer[2].len;
>> +		xfer[3].multi_bus_mode = xfer[2].multi_bus_mode;
> 
> Why not doing the above once during probe?
> 

There is nothing else in st->seq_xfer[3] that gets set in probe, so
I didn't really consider it. Seems like it should be fine to do as you
suggest though.



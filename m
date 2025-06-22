Return-Path: <linux-kernel+bounces-697152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D48BAE30B5
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jun 2025 18:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643613B1CD0
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jun 2025 16:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7291A1EF391;
	Sun, 22 Jun 2025 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2Cek2Rca"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6859F210FB
	for <linux-kernel@vger.kernel.org>; Sun, 22 Jun 2025 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750608866; cv=none; b=BsbAWQEQBeVXUppxU3hj6Cu6/ClvGPxdxIbUiZt5Jz19/jGCuHFVPH76O8m+ROc5YCv9p+uOgo93q9lUm6RwB4EPCTsN6d9EFgStiTfOToFNxyFqyV7NXHULFr86NZ6Qx8XlgajcZCXyLPkmdFW74b5lnk1tf7921YzrFnkW/S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750608866; c=relaxed/simple;
	bh=E4rFypkPIrk7vg0K520K6GmgIY8PC6BjosDROkARYXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EE8KmzLKWNi/nDFKn67RRSOZWIRPNDkwq1SP9K1THVq5WXifDu5HvoXTmHL5LKQ6bQNnWoFbVbsD4kyrPK4pu3arFV7JAPge5kmU2xr4WXSBMsfwGhfhM79lUzsSIPJ6KFzmtYFJZYO/QHcB6ZHABp9wgoFFR6B0ujL2OaWrwPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2Cek2Rca; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4066a0d0256so2239656b6e.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jun 2025 09:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750608863; x=1751213663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RT55BdTQMsSqQTGnDjBdNFy42bnLM9kJKWOx56hzQ1A=;
        b=2Cek2RcabWnqywSSBWimNtiF2CrvFqWJTQc1N8NFIlnfqjFoWRcrgZJQ3BlXwrIKeA
         4prNiMII4GBcXkyGdWiQ6vSd0GzFL5RbZuTJNkXuWa8VHVEzI7DO1e0v23+XN5YiBUNW
         VRezCx0d1fAJ2P0Dk9FSUDSeVbmcCFwqpRa5+zcrWTXR896C/hfxwxtQg1VFx7gIVbXA
         kXyIsEdyrA0G8N/cMrmschusgo+e8xs0hyYoRY3MmO1Y5uinSt4gyFlTkGZtmj0SGzp4
         gE8ONpq3cVXKsF4fCBKPNMMFOBTZr01+3hZR2DFtU7+ApgjcSmGeVbrNepSDzuIc6nNG
         +mdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750608863; x=1751213663;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RT55BdTQMsSqQTGnDjBdNFy42bnLM9kJKWOx56hzQ1A=;
        b=QLOg23lBpIqv7/RFO5fm5BXhjCC4m2UJSPKEDAvqm5DA8Cu9vU6i8nHNLbzLqtT8qS
         dtOah/p9dmqcoqyfDgguwWFTkJdZUDU2+528oX198Pq7s03MCEUy1LU1/K/7+NSyuLmx
         pki5YS8tCLRfcYNh2xD5ChnuawFfFI0rn2hjQ2bJo/mDaKu0gR8xm8JjwBUpCJkQJgga
         q3p0h90gqeGPT3KO5pF/AJIQj4e/hKHFT7KPUnyn3pkHuImMedXXvB0d6KngkEcZoYqR
         YZxzoL791j7WInu4vSGjqZ/1d1Re753yDWYarklK8dIRaIERWurezJpi2xlKnuenxTWD
         WeYw==
X-Forwarded-Encrypted: i=1; AJvYcCWFi5ddif7hf5taS4m93x6WPfZdc86iW7y5dgPdauBQ3gpEAvLFq/V23RYyt9GWMIG0A8y9+PQ6h8dLE9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ugFY3T0WJY2/2CwNkOX/M7+D+pUjfrezBgZIfjMbMPWNMYac
	6tJgqtjeYhsWu53fixHreNx13358cpIJMqGPqGkXiNC6CrXvA4ZVoTDDPX5WkMfaI+0=
X-Gm-Gg: ASbGncvQHyCXhE3xTg/K7DoQtXihRQcdu5VDGIBL1Ss7gRwT9Cw1tTIuYRG7l5H+JET
	ZP3TCBTDIHdhIYSzzI/Fdf8tznYikm7j9Sbd0dkwykBUHGoR5a0AU7iU673d2f865k1mFQLuMXT
	z7x5/HyjiQ2rf2apxbwZGtLqgj1AfATfyK6ildHsyZf3EjQ5uClXPz1EVpRtmTQEt6B9oVD8/eh
	oEE2Vftq1B16iv8i4GSiY+VrxXM2FElsPNmOmKRlW0n4Vgt+bB7qlTXoAGGpOBiL7f0FVDkGae/
	MWwouHzxT2MFRjQHXWBxMTlyhjV8+/gfbRzaC3r/CH67d8dHHhwoFAsMPMQB7E5DcQzXZaRF7Ea
	y2/v2XLGM4lGXtdDQX64r4bBLJ8aBgo8qoPWibMY=
X-Google-Smtp-Source: AGHT+IGsvJy3BWTWHSAyPkEPTBTxxziw2HN/QGBf2hFT6oQ7sBwQLlzrgTMkODdA9iou2mDpphfKRg==
X-Received: by 2002:a05:6808:1207:b0:406:6e31:18a1 with SMTP id 5614622812f47-40ac6eea095mr7296063b6e.2.1750608863396;
        Sun, 22 Jun 2025 09:14:23 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a78a:24a9:21db:1532? ([2600:8803:e7e4:1d00:a78a:24a9:21db:1532])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40adc0842b6sm417298b6e.8.2025.06.22.09.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jun 2025 09:14:22 -0700 (PDT)
Message-ID: <fb7c3825-89d5-4ae2-a19f-c527b0b000b4@baylibre.com>
Date: Sun, 22 Jun 2025 11:14:20 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] iio: adc: ad_sigma_delta: add SPI offload support
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org
References: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
 <20250620-iio-adc-ad7173-add-spi-offload-support-v1-8-0766f6297430@baylibre.com>
 <20250622160054.31cc5103@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250622160054.31cc5103@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/25 10:00 AM, Jonathan Cameron wrote:
> On Fri, 20 Jun 2025 17:20:14 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> Add SPI offload support to the ad_sigma_delta module.
>>

...

>> @@ -670,7 +700,8 @@ static irqreturn_t ad_sd_data_rdy_trig_poll(int irq, void *private)
>>  	if ((!sigma_delta->rdy_gpiod || gpiod_get_value(sigma_delta->rdy_gpiod)) &&
>>  	    ad_sd_disable_irq(sigma_delta)) {
>>  		complete(&sigma_delta->completion);
>> -		iio_trigger_poll(sigma_delta->trig);
>> +		if (sigma_delta->trig)
> 
> Is this defensive or can we actually get here with out a trigger?
> I would have thought in the offload case (so no trigger here) we'd not call this
> function at all.  Mind you, can't we get here with no trigger when doing
> a calibration or simple read normally?  

The difference is that with SPI offload, sigma_delta->trig is NULL
but without SPI offload, it is never NULL. iio_trigger_poll() doesn't
check for NULL and would crash with NULL pointer dereference.

During calibration and single conversion the poll function isn't
attached to the trigger, so I guess that is why it didn't really
hurt to call iio_trigger_poll() in that case.

> 
>> +			iio_trigger_poll(sigma_delta->trig);
>>  
>>  		return IRQ_HANDLED;
>>  	}
> 
> 



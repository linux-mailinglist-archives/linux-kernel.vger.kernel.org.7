Return-Path: <linux-kernel+bounces-804293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E15B47078
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 16:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED5D7C18A1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED4D1EEA5D;
	Sat,  6 Sep 2025 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sAg20UTU"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8809F366
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757169415; cv=none; b=QgFHE8ArvPgMjf+qHVXrspbDf/jrrrKyYckO3NbMSb9D3mE0OyWwaWDhRAVfVv+vD6C1BbQK3PgOVg4qqSn6IaKqRGwWFV1Aw2+g69ch38sKBx48c7BMu2U2jnwau/m6G9beYWd7KvGcdtyQVE+9b94cBEY+Zj3oAVjx4DsU8fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757169415; c=relaxed/simple;
	bh=T8hVLPv8a66ZfYKBxurm9B5KXEyOyaNJFkaLgFFNY2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTeuZ8DEbuCCrxzQ2zdvzKWMnEsZzaR7F3rFQSK2q72TLG3jboBLadiSkzzJ7BBEDJ39udzFvku4L2nW2WRtPer2yHr6I+vz1wghDx4aHKgLRVCfArg6L9EOGJvE8CZxFrhWS1OIFtDWXLUtbYcX4/UzqYQOf9d5w0YxTgr3DVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sAg20UTU; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-30ccea94438so2489291fac.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 07:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757169411; x=1757774211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XtLElYfVHsBdUbwIob7VFK2chyf/oqDL2uLl4gsB7/E=;
        b=sAg20UTU/F3awxm8TimBGd336vl83IMRLxZF6lYQ4Q86/jK+ZUiw+1Pe0bPidGdrSz
         5rmYDmkWP/VMrkz29E9F3sf1GlOCm6sckuC4CGWTR9nQC4kXg2mXyVI/WGNOh+xLJf5N
         qk7krAfOqbYEZBDYnyeMsXNXX1njFHwOyBzARFDoN8Ib/tWUw5dNV6iiK++dAVKlrRPb
         WcnYpMkM1LfVJkqSfvI8uENACJ2Qi7aB19y8jJ1v6cmP7yu3opPS78/xWQHbUYgoDoWE
         k3pTG8qHuLzl9Y6sW0kYMKt9fXCE1uiqmRGHsY83gTJgK059W1EJbpsY5PTGHl23X6FS
         GwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757169411; x=1757774211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XtLElYfVHsBdUbwIob7VFK2chyf/oqDL2uLl4gsB7/E=;
        b=usY1k57dfIStYSSQdqUSD6rItI+v/haOt5dCqu81BzUWDdHkj1UK6bksb6xaqhG+UE
         i1iDgN5uHtHOKOCfJ3kLCPHcYC64cpqVkWO+8XziqKuhzRZzccNmwoa5Bvwihpexh/Qi
         TN8/6utsXzGF4uQi2f9UjzzSQSXYbhCzKxEK/G19Z1pSvcGc1dc4IYLo5AF0WpxecDxZ
         zMA+p18zlblM4xrY8okC32qm8/fEpVBTY9C0+/Rr86yiVtfLeYtyssf3PfjQ3u8tD3pp
         eSbKbDZ+sTMkgXUA9ES/0RJXtmtGUBb+kc2WLOrBsQwVDAGwEY2r0j4B8dQGu+bTswxM
         xsxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG+klSrXgI7r/D6qrFKx8zNxOdBcNnNmG4tS4piGwDatjK4BGVEs2NnUZ6qHBG7ZuSOxIRzdaGY4OhwsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhvaX6l+IKaY0yHiNYujcGfKmOOfGBvN9bkyDsXxn3kQrtNpCr
	RLRRQR1TsnAyh4ZTKjtbhaH3LZyLqEJVDg76QmVAxUZfLgXFl/I/czA2loPGfJpfiok=
X-Gm-Gg: ASbGnctqUkcW9bExf9O9zmLfNt6ldLCj/roPnI+XoEIooTVI8pNLvnEapqdAuWcHAZO
	Fm0dLAUSBKq4HjrqX3ltyYsuSBAhvDuVGzRUKwwb6gAVfkw9loc980oeZpmFMH8mBi6uBBIkkwd
	JFMoqBgi1TxU12ljDVBo8N6zYib9OvtOnuf+wtTG23ksFt95AcLxP7n9XBKwf1x6isvYwX2HC7h
	q2Jt8BT95ElrVpMrCGvKoymn2S+3om+fCv9FThKM7dxPA25vGlztuNrH90LHHUngZk/r2wu9PiF
	NkS1Rr9MQpFxiVlRIxXqwALEQ5BzoIt8/3K00rdIwghkz49iH9g9erTUfcU6dJp98vY1sgUNplP
	20d8LXFAH0BUN8uHJvPerllOas3LAnBYT+8rJrj0DlOzbdpIbyLQWOySSrBYCHQpn6ocNRxQtML
	yEH+uwcwAS8Q==
X-Google-Smtp-Source: AGHT+IEiv3n9VHh+VuBKKRi72gcGyLp1esNwaCKtfvPvYSSwdGwsfpST2/0yRi8JXxPJzVF+OWIADg==
X-Received: by 2002:a05:6870:b61f:b0:315:9da9:aeed with SMTP id 586e51a60fabf-32265437b2cmr1190441fac.43.1757169411546;
        Sat, 06 Sep 2025 07:36:51 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:172c:2a16:ed5f:cfcc? ([2600:8803:e7e4:1d00:172c:2a16:ed5f:cfcc])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7459a657c0csm3211065a34.5.2025.09.06.07.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 07:36:50 -0700 (PDT)
Message-ID: <b4713092-62d1-433a-863a-e7c000797f39@baylibre.com>
Date: Sat, 6 Sep 2025 09:36:49 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] dt-bindings: iio: accel: bosch,BMA220 improvements
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Nuno S?? <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <20250901194742.11599-1-petre.rodan@subdimension.ro>
 <20250901194742.11599-2-petre.rodan@subdimension.ro>
 <210871b8-4967-40c9-bbaf-338d2d6d9c63@baylibre.com>
 <aLugeZiJjJhTpwUO@sunspire>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aLugeZiJjJhTpwUO@sunspire>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/25 9:46 PM, Petre Rodan wrote:
> 
> Good morning.
> 
> Thank you for your feedback.
> 
> On Fri, Sep 05, 2025 at 03:15:55PM -0500, David Lechner wrote:
>> On 9/1/25 2:47 PM, Petre Rodan wrote:
>>> diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
> 
> [..]
> 
>>> +  bosch,watchdog:
>>> +    description:
>>> +      In order to prevent the built-in I2C slave to lock-up the I2C bus, a
>>> +      watchdog timer is introduced. The WDT observes internal I2C signals and
>>> +      resets the I2C interface if the bus is locked-up by the BMA220.
>>> +      0 - off
>>> +      1 - 1ms
>>> +      2 - 10ms
>>> +    enum: [0, 1, 2]
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>
>> Why should this depend on how the chip is wired up? Normally, we don't have this
>> sort of control in devicetree.
> 
> I was also unsure on how it would be best to implement the feature, bellow is my thought process.
> 
> The feature itself is definitely required for the i2c implementation of this chip. I have witnessed it pull sda low for no good reason twice over a 100h period and this would render not only the chip but the entire bus unusable until a power cycle.
> 
> I think from a driver perspective ideally WDT should be set very early - within bma220_common_probe() would be ideal.
> 
>> E.g. if it is useful, why shouldn't drivers just always enable it?
> 
> The registers holding the watchdog are all zeroed out after power on which mean it's off. I think the driver should also default on this setting. In my first implementation I had it hard-wired to 1ms, but I felt this would impose my point of view on users and it would be nicer to give them control over it.
> 
> If you guys think that the devicetree is not the place where the WDT should be set that is fine by me, would you recommend something like module_param() instead?

I wish I had a good answer, but I don't have the right kind of
experience with this sort of thing to know what works best.

We could start with just always enabling it and if we find it
actually does cause some problem for someone, then we would have
more information about that use case and could make a more
informed decision on how to handle it at that point in time.

> 
>> If we can make the case that it belongs in the devicetree, it should use
>> standard units, e.g. property should be watchdog-timeout-ms with enum: [1, 10].
>> Maybe 0 for disabled is OK too - in that case should have default: 0.
> 
> Oh yes I can see it in bq256xx.yaml, to me this sounds absolutely perfect.
> 
> 
> On a different note, from a reviewer's perspective would you prefer the next revision of this patch series to cover less ground? I was thinking about leaving everything event related for later since I might go past 15 separate patches if I split every modification into it's own separate entry.

Yes, smaller series will get more thorough reviews so I'm always
in favor of splitting things up like that.

> 
> thank you again,
> peter
> 



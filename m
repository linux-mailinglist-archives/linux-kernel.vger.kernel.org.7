Return-Path: <linux-kernel+bounces-790675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A53B3ABA7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F02B567236
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB35B286D49;
	Thu, 28 Aug 2025 20:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh0YPmLA"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F90C282F1;
	Thu, 28 Aug 2025 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756412932; cv=none; b=k6no4Hzu81YuKSRbvrtk5F6iT5rqo5IzIZG/dH8Zlp4JNtWKkthHljduE/rY8FQoLZW+39sj5ETavEEN7VTFPb0Z1/AtE1X1AJpI/rRTACEoI8goHkEJ26DkFjAYcemtP2xDccYD8AAxpRxdVtm+mAkYzGiQXoxD952rQ4lARK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756412932; c=relaxed/simple;
	bh=9I0/gpakih7EwGz/n4gjT4jc/wYUW6A6EWfgITi0fno=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Es0DkoKAKJ8TPDI9NPU01MHVGybS+ctaXGS9qi6Q0GtO5RHBK1JbklbGLqh9/l/sPANS5ijX6W9NnU8wfs6nGRiJL8Bu+JfuVvrHWL9aBqTYL3W3bFSJXEZARW8kVjbv+LIZsLENS7ctvsAF/gpjKvIf9pHn1Nyg6BqWTk7DzrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uh0YPmLA; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-246648f833aso8860415ad.3;
        Thu, 28 Aug 2025 13:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756412930; x=1757017730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7FDuQAtDWO9ooIgl8NSvb+qtgW/WcmggLudIxZNT6Jw=;
        b=Uh0YPmLAXHwNFito88NeEz/IvOA/IlGhkx+wHzH/1+aFuWCsalnKX6EFklPivNbGNV
         r+7rB1Iy/pZkE06FOtkqOH8Vb9IiHmJxsQMG3T0E7sCUKI0YX2zxo5Lb18Y24eWK324V
         FVnXvYeGxpk5+MyvLtkdj0QuXDC95mJLav03lT3JZNnBocJ/wE+sQrCWtHW6DU/yzN9e
         Awxk1PoB2G+Irnvo6gJ2YGrM0cmYfr/5g+rpkwozo3HH8Nujdbggwhi9p//4ZSY9YjU3
         hGdhrUFmPwPHz8RsFwyJur70oPBvYsKioPhMdQzC8aWPkMslJpcbCnGdhQLQwc0knBQ2
         LOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756412930; x=1757017730;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FDuQAtDWO9ooIgl8NSvb+qtgW/WcmggLudIxZNT6Jw=;
        b=cl6PgWMoo/TLQVvNhmVZGzPlj6Ctb7FSH29/L32ZbPtZXVrRh8jTQ4qHlk0J7fjiv7
         +VWTt5wPEqJotHGBSKEPI4hHe0t/PDzKRVyDkCZ3ZzL3LVRISrkffeaElLeWe/59Mbz7
         xreAI7s6RhV8CVGZg1bvcViI53Hq4dMEgcG7C3Rg/SviK1WPIKVUol7YsUQdsrVwQ3s0
         e//V4QbCNoVaF9A8r0+SYYd6OBN6aGAmoKUpMLscw2501ud+LXXJP+2UfvkbznApeWQ2
         iklV65o5G9TjQr8IarXSI21fixP+C7wWphqOFKgkSrOLqTwM2KVcoJBtXM2JZiJSAsFP
         J60g==
X-Forwarded-Encrypted: i=1; AJvYcCUAcjwAgLbRP3e+znwQ44IMHTI/K6F+ebqxALg9EgJiS6zIzWyWqsdCLEAbJngogdgsuCSYAPAG1XrsbxdC@vger.kernel.org, AJvYcCUPsDmEg0+w2iQNI3hmruIqBlGdntksmH5OEUS7wCfFjHsO86v0H7iRHKofudRm5I8S22RZRMFywPUP@vger.kernel.org
X-Gm-Message-State: AOJu0YzOaFNJwr5jM9Q+I2KHp6CWqzXlJxWAetHT53YUDpTpB/0c7xLM
	kjXiAh1x/WW4Tj3e9La7SPWR7olC5vZ3ttqDuYOKWltKWmjCq8Lch3FJ
X-Gm-Gg: ASbGncu9gzi7RUw4CMySsC0gAQ2rnC7cl9sHNMq2gr72+NcAGZK7/7oQfv9PyYFDxXc
	6Y9Bi/DrKWIL4X/eauyODAv76JsVw+3CB/9bJvODMwuax7XFejse9kMr60k5gP57X5r9aQpzWVS
	Qv6WRzafBytjpkQiuFRiIyu67t4NQLa7CATSZZsLaKeduxR9d8waOMImmo1nOcZvPz1RvhYc6xZ
	XOKOzTPiX7Ow+/Sb+vY3Rs9CJGxidQ0F+y5Qipeob2dijLUrcZRaOjZg8Y4OBAT2KUcRzKaNrb5
	4MFWaQI4PSrIpOCClLYgDihJlw0QUx94B+Lbmsa7r4aNnbmXczu6IzmuWchGp59ZBhO5QWPCn0T
	vSN0q1EElWGDWVGPJLCAPDYrsHAS/+ovHXL96g1gwGdNcDs3KYpU3VQ7JEeY9d4k+m1eLutSm8p
	wx1GpVRQ==
X-Google-Smtp-Source: AGHT+IFDSbZKvJdneAFJyLW3JdcB7CecMtTL9uGD9RYK2/wyly96mz0Bm0FhW/7HQrQcA03v2YGT/A==
X-Received: by 2002:a17:902:e549:b0:248:fbec:7ca1 with SMTP id d9443c01a7336-248fbec806bmr22629785ad.61.1756412929450;
        Thu, 28 Aug 2025 13:28:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249063961desm3895585ad.103.2025.08.28.13.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 13:28:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c280ac26-3ba4-4e00-87a3-42d6584e80e7@roeck-us.net>
Date: Thu, 28 Aug 2025 13:28:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hwmon: (ina238) Add support for INA780
From: Guenter Roeck <linux@roeck-us.net>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, jdelvare@suse.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Christian Kahr <christian.kahr@sie.at>
References: <20250808030510.552724-1-chris.packham@alliedtelesis.co.nz>
 <20250808030510.552724-3-chris.packham@alliedtelesis.co.nz>
 <6e51d4b9-23fd-401b-afb1-2df943f85c3c@roeck-us.net>
Content-Language: en-US
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <6e51d4b9-23fd-401b-afb1-2df943f85c3c@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/25 05:09, Guenter Roeck wrote:
> On 8/7/25 20:05, Chris Packham wrote:
>> Add support for the TI INA780 Digital Power Monitor. The INA780 uses
>> EZShunt(tm) technology, which means there are fixed LSB conversions for
>> a number of fields rather than needing to be calibrated.
>>
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> 
> Your patch does not apply, and I can't figure out its baseline. Please
> reparent on top of the current mainline and resubmit.
> 
> To simplify review, the patch should be split into preparation patches
> (such as adding .has_shunt and .temp_max options), followed by the actual
> added chip support.
> 
> Other (not a complete review):
> 
> I don't see the value of adding INA780_COL and INA780_CUL defines;
> those are really the same as the shunt voltage limits. Actually,
> the current limits _are_ available for existing chips, only they
> are expressed as voltage limits on the shunt voltages. For the ina_2xx
> driver I was able to resolve that quite easily; we should do the same
> for the ina238 driver. Maybe I have an evaluation board somewhere;
> I'll need to check.
> 
> [ Sorry for being so late with this; I am being swamped at work :-( ]
> 

Follow-up: I ordered evaluation boards for INA228, INA237, INA238, and INA780A.
I'll want to see support added for current limits on all chips, using a similar
approach as the one in the ina2xx driver. After all, the shunt voltage limits
are really current limits in disguise. With that and appropriate chip specific
parameters the differences between the chips should become relatively minor.

This should also simplify adding support for INA700 which seems similar to INA780A.

Guenter



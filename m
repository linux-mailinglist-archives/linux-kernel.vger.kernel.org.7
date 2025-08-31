Return-Path: <linux-kernel+bounces-793580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80B9B3D589
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 00:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945B73B7318
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 22:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9554923F26A;
	Sun, 31 Aug 2025 22:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdJHe1YL"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4FAFC0A;
	Sun, 31 Aug 2025 22:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756678158; cv=none; b=DlN0YCjdyyNkbDYQaP5ZZB3ZQYDRYsKR14muFkbZJzjwOhes/HttOzcNMekbcTOXmakHxWZSzA4msN83S6/vV+RHGth/dx3l80CoCRyeeAaGhE+uKPepfFfwIDBT/n8MZ8Anl8vChXSy7YbjH0Xu3ec92weWrN9xelgQAJB/0Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756678158; c=relaxed/simple;
	bh=En/iASB3T25yAwsE1idzWgETjuWt5KBYtNfPHpoIfnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nvbv8pCcyA2bl4+NCSagtedP3P+711husOFkzx9eWbwlgvN+UBwSCrc5R4VZY8K4uFmGD/B4/ftNqmWkBpZ+nQxoi2AG/BhI9X2ncarrdO0twiFFTAa6g9GS+93oLX/k5YUwo7k3eH0sX2bkbkYOIkLR8F0G8p1fFfuEFyxgivg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdJHe1YL; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7725fb32e1bso90008b3a.1;
        Sun, 31 Aug 2025 15:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756678153; x=1757282953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=xt6mRdXHM8mR2e/EPUgOR4OHl60ekYcm4NYUT/jWMT4=;
        b=UdJHe1YLhUOfgDS0CrzQQOdLrY1ghrOr+kr8y4DyW0osfR3z7PlishdNF9u3nw3ymG
         ydJ+FktdIElX+nwOZ0hTaf1OF1VAZRCKqJd2VGboifiPnxl/nMIhKJ1kBZTF54ZyBFa4
         hbv4BK6gz2ZcFarMG7U5sVSHdLHfrJ0HPKaIsXyHkjXrZkXAYduPN78lshD680rxNMUO
         349ikYM5hxx7REAbrnorub2j072b2IVtTZEXpzY7MNZhC+9hNTGFyPtz7tou15UmrGno
         LwrZPWrwP93/Dvzy59KwosBcT0a6YCqHd2nIuU9C7Am7I7yQ8Qlb0tCJz0s6dOKpDop1
         eGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756678153; x=1757282953;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xt6mRdXHM8mR2e/EPUgOR4OHl60ekYcm4NYUT/jWMT4=;
        b=LBe4RG86989APNNguN+BcW6wHEllQyzwQIJc8uF70TMKCnPLu2zSoGM/QlN1S6DBjg
         emQDLpm3bNnl3RGTu2BIt7nJwrE8IJVSk0Nvkj4ACubWfwyUYkC8y9cMiU0+WB+IsBYB
         BAUgdx5iNPxcJHu2FMOmojU4SdQG973pbMck45v0M41CQm/G3T5e4Bn57FJUOtcPoYjn
         QwwVEgH/8DJSAzpmWSykbKuExKOi1l5Fv7RYMCGS1lJckvDNHzpHB6V2QnTgC5puf+Bc
         QBK0COgT2FZgWsMT1nGAIPi1ZxeFon0BdZm1aoDnHr4s3lZ6Ttr1t1K8M2Wa8SNUA7Y1
         Fc8A==
X-Forwarded-Encrypted: i=1; AJvYcCUfCkO22GlpEpfpmhwjZKmqOIqc0DhH0Kt4D83HFwTXasCyMVosQ1OKwqJBWcScAQtMfiBmkHFXqUdV@vger.kernel.org, AJvYcCVxqrQds2P7SBC2QhADKi7VQNchcPlsVdK+kEBi1atyaQHJWbf/1jLSnEJCJdXF9i4KlO4b6pm+0bOX2gwD@vger.kernel.org, AJvYcCWG7EF1iIdMmmP6qh4HUBrXHO18sy6cgVG6Kbh/iXkqbikA53BQwQMB9FRf2sAEzcN9Uq7sdaOGbFE9@vger.kernel.org
X-Gm-Message-State: AOJu0YzdotAmjgU7pzkcTSNa2AA7Lq3UwJ1F03eMRcN8X0+TwXnFesEh
	qjae2/dkgZbKJMXHbMonIKPjBpPbI1GAyI7MXT2T2fN6K5dOEeKFr5cY
X-Gm-Gg: ASbGnct6yqpNTYVt1dTlQ7G5J9B+1YKsjrCoeA200neG+hkkDA7e6tJItMLoUdLsbK0
	U8QuQzsopbcMPiMOsPYxFBg5ZXXj66yKlZmnj6Td6WVepQps8SvNSzyb5nbCCVO9lz5QT/twhdW
	/gI9IZYhlvmGWaF6VdbuEab1yP67JLzpkhfEkskJlPnkdvxioZpfsH952PzS5sg0lbOkO7PbBpZ
	hHGjJLeC0L3d6E6tnijvFMjX0fZMmrC7x6Ja4iuwqpxSr68+/wfkHyjp7J4xQY01xo08pAHFQ2l
	WhZbtFslK8zaoJohs0OTlPVGFYF5HRb/4+qsmbo0d4dSvo+Mu57pqCyfMyD8g9Z4nVWixz8ZoF7
	MmJQBcHA3iDRwXTKJCRJkJIPORzJzNEyYUtAZNzGi+/Yi2cxox1zBd9YVuBzhFD5hPCW8FF0=
X-Google-Smtp-Source: AGHT+IH6NxqANI4uDAuH6GEROuVVG4Sa68uoJoxAfkM5xN3bZyMgnY1+47Rc5304R4Y2ZCCfeqOI7A==
X-Received: by 2002:a05:6a20:42a3:b0:240:409:fa91 with SMTP id adf61e73a8af0-243d6e00cfemr8082881637.18.1756678152919;
        Sun, 31 Aug 2025 15:09:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327e8d3d635sm8263842a91.1.2025.08.31.15.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Aug 2025 15:09:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3196fcbd-2c06-42c6-a597-8332951473dc@roeck-us.net>
Date: Sun, 31 Aug 2025 15:09:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] hwmon: (ina238) Correctly clamp temperature
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
 "jdelvare@suse.com" <jdelvare@suse.com>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "corbet@lwn.net"
 <corbet@lwn.net>, "wenliang202407@163.com" <wenliang202407@163.com>,
 "jre@pengutronix.de" <jre@pengutronix.de>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20250829030512.1179998-1-chris.packham@alliedtelesis.co.nz>
 <20250829030512.1179998-3-chris.packham@alliedtelesis.co.nz>
 <ba2f563e-4eb3-42be-af05-c01bcef1d5e3@roeck-us.net>
 <d5bace8a-003f-4fb5-b9b6-93f0aa7cda41@alliedtelesis.co.nz>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <d5bace8a-003f-4fb5-b9b6-93f0aa7cda41@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/31/25 14:12, Chris Packham wrote:
> 
> On 29/08/25 21:55, Guenter Roeck wrote:
>> On 8/28/25 20:05, Chris Packham wrote:
>>> ina238_write_temp() was attempting to clamp the user input but was
>>> throwing away the result. Ensure that we clamp the value to the
>>> appropriate range before it is converted into a register value.
>>>
>>> Fixes: 0d9f596b1fe3 ("hwmon: (ina238) Modify the calculation formula
>>> to adapt to different chips")
>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>> ---
>>>
>>> Notes:
>>>       Changes in v3:
>>>       - New. Split off bugfix from main patch
>>>
>>>    drivers/hwmon/ina238.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hwmon/ina238.c b/drivers/hwmon/ina238.c
>>> index 5a394eeff676..4d3dc018ead9 100644
>>> --- a/drivers/hwmon/ina238.c
>>> +++ b/drivers/hwmon/ina238.c
>>> @@ -572,7 +572,7 @@ static int ina238_write_temp(struct device *dev,
>>> u32 attr, long val)
>>>            return -EOPNOTSUPP;
>>>          /* Signed */
>>> -    regval = clamp_val(val, -40000, 125000);
>>> +    val = clamp_val(val, -40000, 125000);
>>
>> That needs another correction: As it turns out, the default register
>> value
>> is 0x7ff0, or 255875. That means we need to accept that range. The
>> same is
>> probably true for negative temperatures, but I'll need to see the real
>> chip
>> to be sure.
>>
>> Yes, the chips only support a limited temperature range, but that is the
>> limit register, not the supported range. Other chips have a similar
>> problem.
>> It is ok to limit the input range if the chip has a reasonable default
>> set,
>> but if the actual chip default is 0x7ff0 or 255.875 degrees C we need to
>> support writing that value.
> I'm guessing that might change my introduction of temp_max in the next
> patch. I'll re-order my series to put the bugfix first with the changes
> mentioned.

Please wait a bit before resending; I have a series almost ready to send out
with various other changes.

Guenter



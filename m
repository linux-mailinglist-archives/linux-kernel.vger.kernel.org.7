Return-Path: <linux-kernel+bounces-810743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56FFB51EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F685683FE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B6827990B;
	Wed, 10 Sep 2025 17:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQ/XMwtG"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827442472A8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757524628; cv=none; b=q6TPZ9kmabPtAYIf6xb+AlQ9YMoZdONw95YiEVPiFmn9/vductNKRLgX3fAXX7K0WEdbZ/ez/nclHFqgCNmCdJ5h8W5qcJo60VivrZ3P2AhVSPhSqOKFlnFTvUNs8XHKO6jTY6pYsPiaM4gU4cyJbWGImLtmlfYovEi697iIJak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757524628; c=relaxed/simple;
	bh=/8scpJKa/iGwoxx0XEBO3b5H/jRJ5KUnLl7bAsgfxQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SC0QmJwK7Ap5I9L6LQhPrkXaJxc0yUxN9u1LAE1UUZzlpEWgKZdm0dFK/S/tkDXB8l2bn6T8yclEXeO3FXSktQbwtiodhVWo0mOu8EnW3a6168OBA0y/TYUDyqjljdSIQEVTBuwhGJjkti5v6c5cDq/kcMIGjDyvPdHcgnlNlcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQ/XMwtG; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b078aabeb9fso177598466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757524625; x=1758129425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qfe7dcIp1ydBJFqKaAb0AacZyDfVzRbrMNGs7rVhHAg=;
        b=hQ/XMwtGPXt4kDt5Rf29TJIiICzTBBvxenvFAKmb/qdj8fxMFgi9OeVOtG6KezD14K
         +vd0JoVh/G9wWo7aUVEx90OSvbTtUXMt17ykG2qjvnm2d6XYJ3HlMcVe0IAf/gaYmaQL
         534dWM+4t/fBSt0jLEHJiMBG2oUILGxkEX/H7c5Wh2AIajXziI39/PJV1wO7dMNudBBB
         1hjcbbfKUOD9foW3HJQzAkShi9ztNjqEabckKCIZy9yieHHCWw/kyhaUVYb+3kG4S5sn
         3T3tZsrzBC7e3AY4TiecvILOZ6zxc+lrY2EhDdzN48ecmFqpJwA1tsoVN2nFs8Bn67ng
         JIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757524625; x=1758129425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qfe7dcIp1ydBJFqKaAb0AacZyDfVzRbrMNGs7rVhHAg=;
        b=CORMVdPhga1sCvLsrl7cGLXTKhPXWiD+9atoC/Q5uMAcoEK9uI2zAy4zaXYWub+6A9
         90Z4oAdReJAR259kTXyUo0r9ax9qeMFtVyae0WSYA8iqn0uoJy7eZp3tQoAbAriX2HxZ
         TXO1puERUvFDax88nXCbu3lkDc5R+WEqXMn527b/4Pzib71+kFgejXkr8UJPOBqHUDpi
         T9/PZvSSnHp87Ny7fS5KR4RexrEWWF50rnTQQWi5FER0RayMpdD1wHnG/PamASNrvHj5
         yom9dVGfafDxJXGFICxuTQJp5uW1YriCP+SIUPxIbr2DD4xKY7boCCzP4IwBWMWGD6oI
         fP0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOpa8n8lA4oHOj4zYTrLZuSuNtU31e/6bKyy6y3a1CLSQbHpE31cCwhORAzo5UyLYS9zVa+oZdp40iRa0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8jEmNb+nrXCRy8UbHFbp9qNeipmWxnYU0eKKBEcVYHZjyVOLk
	pvKr5I3tbJBZYe+AazbU0cSSArL0v4iDQW3c6mRq+q0tfoxE/Oghxkv2
X-Gm-Gg: ASbGncuAwhLd0RdrMQF+2c2z0Jy710SNClhOgpd6dz5zA+w658+6rAOZS703mzlpAdd
	H5lSUQ2fjmHIWx6+6MLKz2P2qrYEM16aEFlncYIh/U7pKcu8aQkGrP2PVdotTPxaRl80cVq9ZCF
	+bWDVnFfe3vY0DjO2T8VtTaBI8GbPXu4gKKzDHPnaiJkN1OTu/25ZegYzrBHaKXYayGHtTcBa8l
	P3muvLKjjPCRrftDAVAkXiie6GM8wgnLRSlRx2eg+SR4PylAJqhJk57Wd2jmO3UL/YtAK61XBtZ
	DjDc61IEV5C8PIXk8uRU/LEYTPJdX/3V3b14qYUhTSt7h9CGeI7jy2tqWcynMTWzdFi1E0LC9/x
	RxOqGTtNMl9jrWs9EwjEWMxgG85hpB791/mPL07gzySE1h7yUXC9BShFyykkF2MKy/1vle0hN0d
	uqYUq9HA==
X-Google-Smtp-Source: AGHT+IGPnTERaGG2PTMA2cxq7DG9wKiV7iClodfojOAKtu9zwJ7Lvhr5isHQ3VORbCBRaD6Ey2Yd6Q==
X-Received: by 2002:a17:907:86a5:b0:b04:5b47:8bd8 with SMTP id a640c23a62f3a-b04b1663e38mr1596523266b.34.1757524624535;
        Wed, 10 Sep 2025 10:17:04 -0700 (PDT)
Received: from ?IPV6:2a02:8109:8617:d700:1266:7a83:f27c:69b7? ([2a02:8109:8617:d700:1266:7a83:f27c:69b7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b078304655dsm199803066b.11.2025.09.10.10.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 10:17:03 -0700 (PDT)
Message-ID: <7f095cde-cefc-4259-9f7d-9de17c12758b@gmail.com>
Date: Wed, 10 Sep 2025 19:17:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: i2c: alvium: Accelerated alvium_set_power
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: michael.roeder@avnet.eu, martin.hecht@avnet.eu,
 Tommaso Merciai <tomm.merciai@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-kernel@vger.kernel.org,
 Ricardo Ribalda <ribalda@chromium.org>
References: <20250909112252.2577949-1-mhecht73@gmail.com>
 <aMGUoQMGZ12oBnpa@kekkonen.localdomain>
Content-Language: en-US
From: Martin Hecht <mhecht73@gmail.com>
In-Reply-To: <aMGUoQMGZ12oBnpa@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sakari,

thank you for your feedback. Please ignore v3 because overlap. I will 
adopt your proposal and send v4. Nevertheless I'm in conversation with 
Ricardo because some eventually misleading feedback from CI to learn how 
to deal with that.

BR Martin

On 9/10/25 17:09, Sakari Ailus wrote:
> Hi Martin,
> 
> On Tue, Sep 09, 2025 at 01:22:51PM +0200, Martin Hecht wrote:
>> Now alvium_set_power tests if Alvium is up and running already
>> instead of waiting for the period of a full reboot. This safes
>> about 5-7 seconds delay for each connected camera what is already
>> booted especially when using multiple Alvium cameras or using
>> camera arrays.
>> The new function alvium_check is used by read_poll_timeout to check
>> whether a camera is connected on I2C and if it responds already.
>>
>> Signed-off-by: Martin Hecht <mhecht73@gmail.com>
>> ---
>> v2:
>> - added alvium_check to be used by read_poll_timeout as
>>    suggested by Sakari
>> ---
>>   drivers/media/i2c/alvium-csi2.c | 32 +++++++++++++++++++++++++-------
>>   1 file changed, 25 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
>> index 5c1bab574394..c63af96d3b31 100644
>> --- a/drivers/media/i2c/alvium-csi2.c
>> +++ b/drivers/media/i2c/alvium-csi2.c
>> @@ -443,10 +443,8 @@ static int alvium_is_alive(struct alvium_dev *alvium)
>>   
>>   	alvium_read(alvium, REG_BCRM_MINOR_VERSION_R, &bcrm, &ret);
>>   	alvium_read(alvium, REG_BCRM_HEARTBEAT_RW, &hbeat, &ret);
>> -	if (ret)
>> -		return ret;
>>   
>> -	return hbeat;
>> +	return ret;
>>   }
>>   
>>   static void alvium_print_avail_mipi_fmt(struct alvium_dev *alvium)
>> @@ -2364,8 +2362,25 @@ static int alvium_get_dt_data(struct alvium_dev *alvium)
>>   	return -EINVAL;
>>   }
>>   
>> +static int alvium_check(struct alvium_dev *alvium, u64 *bcrm_major)
>> +{
>> +	struct device *dev = &alvium->i2c_client->dev;
>> +	int ret = 0;
> 
> No need to assign ret here.
> 
>> +
>> +	ret = alvium_read(alvium, REG_BCRM_MAJOR_VERSION_R, bcrm_major, NULL);
>> +
> 
> No need for an empty line here.
> 
> But see below...
> 
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (*bcrm_major != 0)
>> +		return 0;
>> +
>> +	return -ENODEV;
>> +}
>> +
>>   static int alvium_set_power(struct alvium_dev *alvium, bool on)
>>   {
>> +	u64 bcrm_major = 0;
>>   	int ret;
>>   
>>   	if (!on)
>> @@ -2375,9 +2390,12 @@ static int alvium_set_power(struct alvium_dev *alvium, bool on)
>>   	if (ret)
>>   		return ret;
>>   
>> -	/* alvium boot time 7s */
>> -	msleep(7000);
>> -	return 0;
>> +	/* alvium boot time is up to 7.5s but test if its available already */
>> +	read_poll_timeout(alvium_check, bcrm_major, (bcrm_major == 0),
>> +		250000, 7500000, false,
>> +		alvium, &bcrm_major);
> 
> I presume bcrm_major needs to be non-zero to proceed rather than zero?
> 
> I think you could also do:
> 
> 	read_poll_timeout(alvium_read, ret, !ret && brcm_major, 250000, 7500000,
> 			  false, alvium, REG_BCRM_MAJOR_VERSION_R, bcrm_major,
> 			  NULL);
> 
> 	return ret ?: brcm_major ? 0 : -ENODEV;
> 
>> +
>> +	return ret;
>>   }
>>   
>>   static int alvium_runtime_resume(struct device *dev)
>> @@ -2442,7 +2460,7 @@ static int alvium_probe(struct i2c_client *client)
>>   	if (ret)
>>   		goto err_powerdown;
>>   
>> -	if (!alvium_is_alive(alvium)) {
>> +	if (alvium_is_alive(alvium)) {
> 
> If you prefer to change this, then I'd assign the return value to ret, as
> returned by alvium_read() and use it as the error code here, too. But this
> should be a separate patch.
> 
>>   		ret = -ENODEV;
>>   		dev_err_probe(dev, ret, "Device detection failed\n");
>>   		goto err_powerdown;
> 



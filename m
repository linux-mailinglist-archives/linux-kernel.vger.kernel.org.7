Return-Path: <linux-kernel+bounces-733902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FC0B07A66
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22AE91881A6D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9762F3C03;
	Wed, 16 Jul 2025 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJz4tDpD"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0939718C31;
	Wed, 16 Jul 2025 15:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752681146; cv=none; b=QNkC4YlV8MEdykUIK8HfWuQQKFI/KxsY1lLupEsSNZfr5fii7E2IEzVHQWfT44wgNTivK4jwMDUbE3sXxYBvPVQBRDPL/5zISe3gOPwc7ZaiHZyY3UNIqZxje4u5RvRqR+2wee/2Ldlh4aXgandqzRtzUhxpJDJsayA63rd+L58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752681146; c=relaxed/simple;
	bh=OylttVKD8mE7KPJBFkYcv6Rwt2AGyCAk9mSgrHZheW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcBB0LeUg1FlhqFt5bp/pUHaB0EMm0NWfrBpQwp6bVIwGq4Yc+YzG5t4+I/Ey95UVafQNaRJd+QZyWKYQGYCzo6VZhuQqaSW3i723OB7YoM0fl3FkwWKYls1SYAwmnZhisPCDKyBXQxKU0JUB+wvk3M7i8s5Pa9Da8LqiuBb+GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJz4tDpD; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b3182c6d03bso7802345a12.0;
        Wed, 16 Jul 2025 08:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752681144; x=1753285944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ukl7MYBC3ANSBm9jO5Nq81UCjp7PwuTwU9cCInIjQY=;
        b=bJz4tDpDhlXoM84gsLYzHAI316HUqnqzGRkmhNGJyacCdUUmoFWbaA++bLvutx3iKf
         yhGQnhg7aLZk3m4MLvhPeKXyc5ii54uoOHMqoQ762j3nplax1vJPt6evF9OmHpfIq7AY
         ZyhxsQUKN81ynhocl5xGKIW4SfEB27ES+yVzK8Hd6avOi8f8WfDRKjEGLTdzgy6doNvx
         URwW6ZC0amoudwVwMyG2DYGqz9htK7mO0H9DSr6pvPBI1TPfMXgRVsgojD/CUOGBnapn
         z5WVnIMEREmjqt2JjwWikGOY1W84eDytGQVyaPFlZxqAW0OoWSwozhBO3NizTAa7wdGd
         SUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752681144; x=1753285944;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ukl7MYBC3ANSBm9jO5Nq81UCjp7PwuTwU9cCInIjQY=;
        b=CDx2882HWqHz/aAvnyuonStXEarxb1qoB8VbcYbzHTLJXc7Hon4ul/+4cJ0dFiHfYJ
         LuViPGPZqHdBrba2hm/HxXAkTi5oqp6ux9ldsx4Fi7GxuWxz8niNS9xvAFe9ZZME2n2z
         tvpO7JRfd6J4o6H4lmzOul14It2LK+/iun1SzTpLDjED/yOvRyAfkzBN0LmQb2am0cz5
         VHRHDu9EvSRmXuVGAF/fWDo0ISNxJ2MOPQdFxWNlh+95xWO2iBMl4ZqtJ9YlCkPExNJn
         2hKy/UP+1uTKeGf2aPuHL0rq/Fyta+vFWuGwzh1L6oLqHg+1+bSnV8Xb34Dhvmtq3x/C
         fhag==
X-Forwarded-Encrypted: i=1; AJvYcCUBf/gIzjDOZoieyv3LU9tpEzgF/T4MQKL7vSJvAknFyGDmauEO7HKBffV7vAaeJUz0CS+CxQHN/Xqi@vger.kernel.org, AJvYcCVt2pfE9k1Gm/22JufROmrW4Ukraf23FWa/IVjy9V7SQsTSjpPXM6Tl0ekjw/YNHDbWc1xuTSwjmiuuGTb0@vger.kernel.org
X-Gm-Message-State: AOJu0YwZoSG30neceCsVDM3vP2VFm1hohIsObvD7mGjbotsLt+rvVUBw
	mAYJYtxHSzSgNMo7/2SKULA6gz2p1yyiZwn/QkL48bgFGiYjDpXD3UvL
X-Gm-Gg: ASbGncuGxafxs2GKmf9whpGvYRmnz7bBddPWn4dffC1Sd0/hiO2RUVY/rpEpVZTryiE
	K0ARQQp+msOI4rxKwfbATRDBMsbxBLY7ZEcnbRRV4aFGfxtpxHENaga0kNWkRopWrul/ZfUQGL5
	Gwfj1s+UYYu/jVKBg4AOS9lYKqHWsiCN+8sGULbM81wco7FH4eAHuA1AYy/Yv7FzlMQodligJqP
	fwZMxpfuNGT7AjICZGFV0A3N5NGB4uYIohpYGYZQdrSRAWAV9fXzaLADQtZ02suyEFXy+E5uGtC
	CHz9UyhZSMskTJ39GgwYEOpFGwKs+J9sIr27TUODmI96iY2UqQhjBRGqjMFCm0kgr5MFJldCdTN
	rGlj+lM9Sa8S549vQOFWD3Zb7TY1CXZRvSKyj8VjgxtfncOu421sR0aPfCSv0GgzZBCh8ilA=
X-Google-Smtp-Source: AGHT+IGTic8ujSiqr54AymsdvHDmW5v2mjFxNtDYCrb53c4AgefCHXmbrE0m0SWvFE3f1PRmTa/4gw==
X-Received: by 2002:a17:90b:580c:b0:313:1a8c:c2c6 with SMTP id 98e67ed59e1d1-31c9e76aa70mr5838168a91.16.1752681144241;
        Wed, 16 Jul 2025 08:52:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1fd90csm1620366a91.28.2025.07.16.08.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 08:52:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8e6d8c2f-ab9a-495d-8b43-878dbc0451ee@roeck-us.net>
Date: Wed, 16 Jul 2025 08:52:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hwmon: ina238: Fix inconsistent whitespace
To: Jonas Rebmann <jre@pengutronix.de>, Jean Delvare <jdelvare@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
 kernel@pengutronix.de
References: <20250715-ina228-v1-0-3302fae4434b@pengutronix.de>
 <20250715-ina228-v1-1-3302fae4434b@pengutronix.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250715-ina228-v1-1-3302fae4434b@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 13:49, Jonas Rebmann wrote:
> Some purely cosmetic changes in ina238.c:
> 
>   - When aligning definitions, do so consistently with tab stop of 8.
>   - Use spaces instead of tabs around operators.
>   - Align wrapped lines.
> 
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
> ---
>   drivers/hwmon/ina238.c | 30 +++++++++++++++---------------
>   1 file changed, 15 insertions(+), 15 deletions(-)
...
>   static struct i2c_driver ina238_driver = {
>   	.driver = {
> -		.name	= "ina238",
> +		.name = "ina238",

This was aligned with ".probe" below. Either leave it alone or change the tabs below as well.

Thanks,
Guenter


>   		.of_match_table = of_match_ptr(ina238_of_match),
>   	},
>   	.probe		= ina238_probe,
> 



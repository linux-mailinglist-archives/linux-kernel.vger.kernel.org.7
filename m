Return-Path: <linux-kernel+bounces-898102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E477C545FA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9140F4F78CD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DE22D0C64;
	Wed, 12 Nov 2025 20:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuzkCD29"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76D62C15A0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762977830; cv=none; b=IOX1sch/c+cb+RwVJ4rkFYKyN/1ihNw7Iogg8x+3tjeg0FzY1QoF1tZv77MpcRf5krIGVNvN9xLEBUTIZ5XMCvy8xz1w6sv554wUPJzfzCUTWWW8VSVE48ciMWISQprfzB9MWunh6Efxh16Q7gBp+2HYM7saXJD2oOjrifd+Xcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762977830; c=relaxed/simple;
	bh=f6zi5QMiRBllhcG57RFOS7f2OK8nmNoOL65KvXnrPuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e83mcRM4dsrTRKGBzZOaY3W7ldkz9PPGSKmmyaAxVh517VtjtYatCVeELmvihFwiBJEvh7tQXv3cs9Ygz2+VeN+mHeDBTK7ISKDo7SMPzlwEXoTinhXjB8LpNsnLvzBiHFvxPNKbIwYkCz+k++wa8iMxeTed2Iuft0xJE7PCwow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuzkCD29; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3414de5b27eso50068a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762977827; x=1763582627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=A4/qzGVtpLm7jp4TUuxxd+pG80ZGMpWn7pA9vIqFyPU=;
        b=UuzkCD29JV2rKGT5UAZIb01QSDihPmh+ivlVeMHJ6v1DOruHNoG4BlBeHmieHxalzw
         eoJP2XYmf4G6OjhXQjDk6TA8JlQzpjxyYWdEIvOZZUPGeq8t5VsLYYVmzXqznu3Y6JWo
         1vtpFXxXcPnT8ehpLwPHYWavTpjn9QLzEj2hKk/EMcAWn02GaElJ0Jppl0htUwNyk1t4
         pptXUEPM/Jn5H72xY/v60tNywpgCcMwYJOpWnPVY2PExkpQUMcPPJnvYj9hWl0iPrTht
         7D5wgW3HonlTL0ayTJKmXTKQROWFnciOXT79NO7wiRdRAh2lPHID88W63D29/3qjPOSG
         d2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762977827; x=1763582627;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4/qzGVtpLm7jp4TUuxxd+pG80ZGMpWn7pA9vIqFyPU=;
        b=f8pvg9r7zPDIay00WCZJJGVzIArlRxIYD1O/fO/vi20OtoMTLMf5DADjqxFm/lhOaW
         e7nWDu/tKNbNFXJyMbGUE3EKyZNpzOqjgYv5qkJffsnMQOWnieHd+XA/xMzgsr5N46Da
         rve9atOBvxUcFGVdOW5bJEqgyn6M2aMwV1zYfGtdf9j4e5EdyBrdVH+5DOrcOxxcGpEA
         9k0aqiVGN68fRbB8+V6wAoYR/0hsJcbMA8U9HOgHh37NvgoF5xg4A3uFuhcxGoTF556Y
         wlQ2kYiQAllFLqd4wMz8wF1cfqVG+oFgXwtdltb/D/5YYmMVV5sqmp2O61e8pL0Vnwtu
         Wd6g==
X-Forwarded-Encrypted: i=1; AJvYcCWhjpChZWI1aIMHlyUH/89xfhDyjYjCiVo+JhCYKdSnz1EDEUuqriYRF6G1LVZWLeQMei9chQA6ce2P/40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOzhs93xYEXr+QGlvrYzdyiH3KqOUkKJHnxtJtiSDMGPCGjIsr
	8UtrfZ39SGDb0VtTiHv7gUG1b0R+f1GNnTP69PdLLUgjCQJhQYDZw4n8
X-Gm-Gg: ASbGncsJ7d49uA/RPS2M/ooQ8dAcM6mtrYtpTizywxW6jdP2hTUSgXpCjSOxiPkzaMW
	LxSogKTXlhCGawX0ywQ8DN7yWfLce57pVs1vDoaMNqtMIq1Np5jcnByjdkE8JRnqaW8oiYhaI/n
	ml3wvLfBX2jdqbvqSCzj9sw2C7bE2kXJ3FwrIZMut7YEgVS0p1O0+mRPBUTbNDXweZYJkJ/b7s+
	QuPwshFqPs/6HXmvP3aIy1RQBnjyZ9MVBuK+apGLw9TGIgxIne9qVW9lrfVEAZ7YljvXxEFHn5F
	OgHxmgS+SD37kt3Oh6O62eb8VSXyOHi7C0j58JZYVetWowiGPqqnVFRF0aBjPVBkDWoQIj5f+Id
	uLa1aqpgeFNah+DPGFgbdBTHUBVhhO7oNs6aKDJ/ODpyWDq7deelcuG60yEiEy6+doRoyqx6dGY
	YxmU29aloK1yMm3xScVf1AOOw9urQdBeYLdbeqw6GxLG2OMDcj
X-Google-Smtp-Source: AGHT+IFyN9BPR0l1jVahDVmOs4NiwQ7miDwvjcX7fb72hixSWBHi4tA/7ZiP+Kew9BfBtAFIChz0Jg==
X-Received: by 2002:a17:90b:3ec7:b0:343:6c71:6d31 with SMTP id 98e67ed59e1d1-343dddf012dmr5710573a91.11.1762977826974;
        Wed, 12 Nov 2025 12:03:46 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343ea600620sm295598a91.0.2025.11.12.12.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 12:03:46 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <dfb3f5df-4ca7-4965-bfe9-07fb473f0506@roeck-us.net>
Date: Wed, 12 Nov 2025 12:03:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (gpd-fan) Fix the compilation error
To: Cryolitia PukNgae <cryolitia@uniontech.com>, luoqing <l1138897701@163.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 luoqing@kylinos.cn
References: <20251112015737.948693-1-l1138897701@163.com>
 <D1B4B203872C7799+d5630d66-0557-49bc-baf5-2abbe50cc625@uniontech.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <D1B4B203872C7799+d5630d66-0557-49bc-baf5-2abbe50cc625@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/25 19:09, Cryolitia PukNgae wrote:
> On 12/11/2025 09.57, luoqing wrote:
>> From: luoqing <luoqing@kylinos.cn>
>>
>> drivers/hwmon/gpd-fan.c: in the function 'gpd_ecram_read' :
>> drivers/hwmon/gpd-fan.c:231:9: Error: implicit declaration function 'outb' [-Werror= implrecental-function-declaration]
>> 231 |         outb(0x2E, addr_port);
>> ^~~~
>> drivers/hwmon/gpd-fan.c:244:16: Error: implicit declaration function 'inb' [-Werror= implrecental-function-declaration]
>> 244 |         *val = inb(data_port);
>> ^~~
>> cc1: All warnings were regarded as errors
>>
>> Signed-off-by: luoqing <luoqing@kylinos.cn>
>> ---
>>   drivers/hwmon/gpd-fan.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/hwmon/gpd-fan.c b/drivers/hwmon/gpd-fan.c
>> index 321794807e8d..57d4ee683f0d 100644
>> --- a/drivers/hwmon/gpd-fan.c
>> +++ b/drivers/hwmon/gpd-fan.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/io.h>
>>   
>>   #define DRIVER_NAME "gpdfan"
>>   #define GPD_PWM_CTR_OFFSET 0x1841
> 
> Has it already been fixed in it[1] ?
> 
> 1. https://lore.kernel.org/all/20251024202042.752160-1-krishnagopi487@gmail.com/#t
> 
Yes, I'll just need to send the pull request.

Guenter



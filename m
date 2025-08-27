Return-Path: <linux-kernel+bounces-788605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A49B3872B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31ABB7B6444
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5692D543A;
	Wed, 27 Aug 2025 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMOyKG7K"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599E28472;
	Wed, 27 Aug 2025 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310214; cv=none; b=OBAtP5cEY0tqgio4LCrK7GOEQ7QRE8MKrElbzdPFSzmrBUCc5ZoeZD3S0LjqeVIU5nZEcF5+vvdsmQurStysr+GkVafSE4tchy6CffcxoQ2BbRvYm0zjDnJ5zAS5MdJCPNqoyywNZWgNQBJq/nz4qp/Ok9Bi4JnHjIUw4Y51mIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310214; c=relaxed/simple;
	bh=vQ5InhBUZjPYKM0014rG1TV8XVuoOTobznhCUp9Lv6A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Os9ZcMTNoClFoNJMRj/4RvbYKFhQR3IEfVk6CMw5NoOXXZLEJonehRRn0y01wQflQCw7GPkFKJybsLp2NWJ5zMfgSfoPz4MdihhgcjBK7SJdbNdl9+jAEeldJc+OklZpQDRzfKRpmYTyERHyX90Dx65RZAGF8YMnJ8I5ayANGsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMOyKG7K; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77057266cb8so19897b3a.0;
        Wed, 27 Aug 2025 08:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756310212; x=1756915012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=926qV+YPdNGgWINkKfdvhIa27PzILOXKVbb0SqCQWbc=;
        b=XMOyKG7KKEeaoh8TAzmpe8DhWGlVyOIdHUl4Ahvycd6g5Vqfmg+5X5cN1/8We8RGYz
         TBGmlrc7ttYsvBwCZmheMUieEOfhc0vWsy3m4vWcmvRx2xPyQkVzZMnOxvPM/5xoDODh
         pLFwjdMYh3vewuDCwm5FWkJKwlvkJwPOXm5rjEMzDSXEnNgnDch1QmjQVjjjh5fUehQg
         1GEbtsJsW/nz6+cTiqgqoDY9MjMkEDtfA2xOkszLzer6CFwKO0NY/0JR4KJf+Elxh4Vh
         UQ89iqadtzagLGKpqAjreUy3nhFZw898abiWx9gsD7T+dzx4aJXBrsgdYdkX86L8QzBI
         ORcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310212; x=1756915012;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=926qV+YPdNGgWINkKfdvhIa27PzILOXKVbb0SqCQWbc=;
        b=aaaqSA3EXD2M6rPXibsm7AlZGwfcQqjpviJ1pHmhMkd4HOlw3hBmCJWiEu6AAkd6cE
         Kdt2x2NSz7mw46t595GT2+hc5hM1AP10hfmkvWfJ3DzoxPplm/zuBhsJhN8YDBPTqf7z
         yTzP0odteJDu0CtJlQyVgDN9zWSJKWbUkWddDQFRYvhifiRDU2NTRSgMjl2tr+Zrpn+J
         y1mzAWBzspdqH8gJBmDRc/ZkNV/Wy7YqvB9fh62aXPFcG7AwPX3e/hRFtMZQA8oof/Jf
         5l7BSta/XcovLgAQbJiXG6h8Oq5ODHHBZLDxE5eAkuMTSbkfh6zKpL5/2CQuRtOWsUfN
         dlbA==
X-Forwarded-Encrypted: i=1; AJvYcCXXMOKylibYdwej8ADHXA58jHE2dh4SnbBD0ZhJbpI8AR/5T3+MUFW03CngzlKBunhpl87H2wSASV3s+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTTXPjFOM2/CSx1arIbpWFca0DlrvH0MbS8pzSAyXn2Esm10zG
	RkhVZJKw9OKHcpzWIXcs8a3zWhnDkDZrXJrO/g5HwV4Gt/k25Tr0+QqjXISyVg==
X-Gm-Gg: ASbGncui7xaQguZ6yLIy4vLVFrZMgQql2dnkIIAIo3tfQXaD5p1YILD2Bam9Rgu7aS8
	YR74EPQm0VkNFJpFxcpbFF3iCau2O5lMxGT6gbPRcfatfWrZugiPxixmwOuH0aYifG2xZVsbJ/v
	6VqbWj9+rJVkzzAvCeSVKemrEdmylpXBSXV4/2WF3YRW7QTGvwEa22oP1WpnLTP7646TRrz0wwr
	/91P5flhLTkAm2hdgXpkfW+j1SWWbzSGgVL818a6EgAEj6vSgjWdaI6x2LzUUjWn8TBEaO2UVmO
	aw3KR2oW+e1xr5wmNc04MfsPDREz/2yINMdkcaQk9UWi5+NWAxTzdmzV8Ghy6D6f0vJjBJ+NSkt
	/9y2B9Fe2N8nt5zR8Zm9L/PoDquIViChSbUBD62UxA8aT9uM5xhu+u8kIEV/RrIrSHZ0l/z4=
X-Google-Smtp-Source: AGHT+IH0nHzuiK8j/ez+UhOHzdz/ndqtHMt/iok9pouE9q+T11jwjZJm2qonQ9jwn64fPlYqguPkbA==
X-Received: by 2002:a05:6a00:3e0a:b0:770:4c7a:304b with SMTP id d2e1a72fcca58-7704c7a3238mr17531407b3a.19.1756310212456;
        Wed, 27 Aug 2025 08:56:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7703ffb9d3bsm13449712b3a.23.2025.08.27.08.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 08:56:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4e6257df-4b7f-4ceb-995c-fe24a6ca6a2b@roeck-us.net>
Date: Wed, 27 Aug 2025 08:56:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: Add support for TI ina700 power monitor
From: Guenter Roeck <linux@roeck-us.net>
To: Christian Kahr <christian.kahr@sie.at>, jdelvare@suse.com
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <a8156dd0-ceff-4ad3-8647-a9c47491b599.98d92f9b-fa19-453e-a7dd-7ac376786b24.5ce0c954-cef9-4788-93e6-ea1d0263884f@emailsignatures365.codetwo.com>
 <a8156dd0-ceff-4ad3-8647-a9c47491b599.cccb958b-a4df-41b5-b2de-11045d5a9527.4676e9c5-8881-4585-a715-630663ab4f8b@emailsignatures365.codetwo.com>
 <a8156dd0-ceff-4ad3-8647-a9c47491b599.7b873dd0-16c4-429f-89d5-30f15a3af0d1.660caff0-2d53-4d54-b4b0-b8956c85dd8e@emailsignatures365.codetwo.com>
 <20250826102351.18166-1-christian.kahr@sie.at>
 <ff8d639d-a9b7-4992-8587-e6b5284c3540@roeck-us.net>
Content-Language: en-US
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <ff8d639d-a9b7-4992-8587-e6b5284c3540@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/25 05:13, Guenter Roeck wrote:
> On 8/26/25 03:23, Christian Kahr wrote:
>> This patch adds a new driver for the Texas Instruments INA700 power monitor.
>> Supporting Bus-Voltage, Current, Temperature and Energy.
>>
>> Signed-off-by: Christian Kahr <christian.kahr@sie.at>
> 
> Almost identical to the chips supported by the ina238 driver.
> Please add support for this chip to that driver.
> 

Also, please send me a register dump for the chip so I can add unit test code.

Thanks,
Guenter



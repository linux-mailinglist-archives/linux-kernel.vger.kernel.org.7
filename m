Return-Path: <linux-kernel+bounces-728200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C75B02491
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DDD51CA183E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7862D2D3ED6;
	Fri, 11 Jul 2025 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ax1F4sYH"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A49818DF6E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752262013; cv=none; b=rjLoSsVvOVKPI2AePf+/Af0u/lubHL6JkBLt8aYMRUCFVgrzmqV+jgzoP/vbKEqmWC05WCi2tTkw9ec/dKt+EhG434Zifmg1OQ14jjXPK/lQLc8SsJpWLv40UbD+Z8F6L9aSerw15yQ/srKRwDmWEaiCYW/SLiK9NowQugWntYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752262013; c=relaxed/simple;
	bh=or75oSC7xMtdvT+P19GwpFtw4cqH7zKdN1CT/MZeazE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwdxD7EFZhgEQJq4QhG2smvc6UBVJVv08YmmdOzW8+8o8vSf+UXAAuLHV6GaQOfOE+jHqHlPqhwfHOYwZCYHEGP9nUMMmu8zirG2ALTti5/vpoRFaA6/pmbQsOGHjsZQFqm6c0Huig4QzNXJ7VXPhvOrBZV6BpZORktOLy2d6Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ax1F4sYH; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-73cdff9a27aso601383a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752262011; x=1752866811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wg5KK/+q76TeFP1WmDWWnvUUhRJ3sjg6NUPg6wHBI4M=;
        b=ax1F4sYHemk1QFgUuQ+iOolOkucOpAGJTMNMJG4Z6EJlhKOvBpDzasFBatMZFXACOO
         YsoEzlb+K+gmezfXc2twBYs4vzepY+FDW22RqaZYM0Cx9ZLP6KsUjCVGZMR7as7OOnWe
         +8EFWnX825EdQxDt9XrASEeibLjBu0YaM17UuGy6E7gAyqMYXEzUOZBn7jckgILRtUMK
         2gDJE6EwZ/M18iBgy0ALSjJI181pKpbqvDhcacQAa31HGH3n5JSvl6pjj7uAVESMvKSf
         JxsG4oegzOog0uhMRkCOz7HD2NCTm2TEOFP0JDqCCNVd94/SrS5q1WMtPAXuximJW9Cs
         DICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752262011; x=1752866811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wg5KK/+q76TeFP1WmDWWnvUUhRJ3sjg6NUPg6wHBI4M=;
        b=BoV1R021bh+40WgpmF2WVCGK2YAcdcaXBZElRxvFTDL3o3yU46DkI18ng3ukREzX60
         hlQjwwLFxAVdB7cpFPdUWSMEDS+apHvwb1rGISC8dbW7/+ImT/k3Ud1G++fRzaShP+3W
         z/MeexsfkJGl8dnt7WxTtTF3MzjI1f3j8kX8l2nOOOsTi2dNVov61yuLrLo7zUrN4kAT
         M420spPgw4mi2rSFF22zbFACSSehNh2uWDy+iR25AxQSSOmMXKHhtuoqtAI75r2CEy0o
         M4Pz/VvmASOztxO6pTLZ55kqivv2gmFp+RUtcOmoG97/wem29YrNHzQ0FRNPZwl5yZ+S
         D1HA==
X-Forwarded-Encrypted: i=1; AJvYcCXqjyYbORScbZJDG1aMz8hDYRPGMt+E5rcBcQEL5rajZnCClGPMKtI9aGhu03FZ831E2fZhoGOa/j3hvDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAYpA6ZGN/ZCHuLIc1WHqWMcioPkte6+zQsiMrAGJEJEw4V9qZ
	tL1HBomRyzRQ/xSa6bvppyG2hp6XaSJBAOBbUKyRs1pmBULB06ecXHbInpu54XDZKI0=
X-Gm-Gg: ASbGnctD76YYIJ6/kRKitpxHoPqrlCXVmRv4sJEy6e/czJYGD1XV9jA6gyp4NuR2gWU
	s1Gpymffx02Uf7CB/UO/pzHhGLIzKGkr8AywnrPYs2/Oqe8gEB0e5OJdxGyNlxjpnwG9H3T9w7S
	yaAuG5La6Wepux2k/lVffAf2pH2aIBMbMtzZwbYToWNfDBdMKbSZY2i6iuozJYnBo0dYMPhVSBv
	AXDpC7l/MX4rSag7AgLWMxu6Px3G0UAbXROgeKQDcxFH7CwvyBd1bV5t0tUtHwAw6N0bCIUOfj0
	q9Sp79nkCOIt1Z3Vs+a1XS7246Ffv+6gsKqaES0Nsm3Z67zJYCk4ptqrgPrjks1YtBT+ryjyQJk
	upOXYe1ocWVoB2SO6fRqgquWItkLZ+XqvsQX/H6OPe6w/0+djU47H1eeO/4lghe8QG8OJD3wwHG
	SSLfKN1VFgEw==
X-Google-Smtp-Source: AGHT+IF63+9rtWdtijRYzjxleW6K+ny1FT/Z8DWiyhU6MepE9QNVk1o1SpTs+aOdhgDvwKb6SLEKTg==
X-Received: by 2002:a05:6830:2588:b0:73c:c4a7:3852 with SMTP id 46e09a7af769-73cf9dd76dcmr3479598a34.3.1752262011367;
        Fri, 11 Jul 2025 12:26:51 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4601:15f9:b923:d487? ([2600:8803:e7e4:1d00:4601:15f9:b923:d487])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73cf12a6961sm663016a34.56.2025.07.11.12.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 12:26:50 -0700 (PDT)
Message-ID: <27d969af-c856-4ea2-8666-fd5333c70420@baylibre.com>
Date: Fri, 11 Jul 2025 14:26:50 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: temperature: maxim_thermocouple: use
 IIO_DECLARE_DMA_BUFFER_WITH_TS()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250711-iio-use-more-iio_declare_buffer_with_ts-3-v1-1-f6dd3363fd85@baylibre.com>
 <aHE-o5_TvGtUyHoI@smile.fi.intel.com>
 <b564a925-1d17-43fc-86fb-8db0d845de44@baylibre.com>
 <aHFO7LhWXOuglaoz@smile.fi.intel.com>
 <4d41eafc-46b1-48c7-982a-1a3566f9b423@baylibre.com>
 <aHFdCBGWDs-IRMTC@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aHFdCBGWDs-IRMTC@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/25 1:50 PM, Andy Shevchenko wrote:
> On Fri, Jul 11, 2025 at 01:38:17PM -0500, David Lechner wrote:
>> On 7/11/25 12:50 PM, Andy Shevchenko wrote:
>>> On Fri, Jul 11, 2025 at 12:04:03PM -0500, David Lechner wrote:
>>>> On 7/11/25 11:41 AM, Andy Shevchenko wrote:
>>>>> On Fri, Jul 11, 2025 at 10:33:55AM -0500, David Lechner wrote:
> 
> ...
> 
>>>>>> +#include <asm/byteorder.h>
>>>>>
>>>>> Hmm... I see nothing about this change in the commit message.
>>>>
>>>> It is for __be16. I kind of assumed that would be obvious, but sure,
>>>> better to be explicit about it.
>>>
>>> Isn't it in types.h?
>>
>> No, only CPU-endian types are in types.h. The actual #define for
>>  __be16 is in include/uapi/linux/byteorder/big_endian.h.
> 
> Huh?!
> 
>> This is
>> included in one driver in staging, otherwise it is only included
>> in arch/*/include/uapi/asm/byteorder.h. And asm/byteorder.h is what
>> Jonathan used for similar in some of his recent IWYU patches as well,
>> so I assume that is the preferred way to do it.
> 
> include/uapi/linux/types.h:37:typedef __u16 __bitwise __be16;
> 

I see. I looked for #define first and found it so didn't go
looking for typedef. types.h it is.


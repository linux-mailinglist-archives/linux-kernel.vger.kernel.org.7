Return-Path: <linux-kernel+bounces-729125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6C5B03213
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 18:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 583E23A3775
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 16:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF58280327;
	Sun, 13 Jul 2025 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="m5YtDS05"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B12527978B
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752423988; cv=none; b=Ex+YrImBQLGrhrtBY9MRvZb5rV6ygCHNMXkLzVY835jnSPwSt3SM/YBtYD+5SGd41YJ35RppOTn6hDMFCGe4LB/9e1nr+LRXCBKhr/QVrX6kv+8wnigDjziBGir6UBGFlyRc1zwHMoVBIlgCwcfALFHlVNSTjkDcFV3PoGB4RlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752423988; c=relaxed/simple;
	bh=gdH1NhlVyJQoDiHovHxKfjkCYcSWgtGDQu0pEOmHv2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgT3Wx1YxcZHqSdGX4GvbHvGkomzhglzGTtIjIIckr5gJ+zcFDj+x7bbEa+ELukYJTpDZ7fBJLvUxFHVebRv1xqfgc1yGT5EOlveA/YCG8gd7AuIBFh+J63D9XBYs0in6RJno+xytN3qR5P4ppjocPiRrJZctLIYD+wEmZTl8yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=m5YtDS05; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-41785c4da4dso120461b6e.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 09:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752423985; x=1753028785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EzI8Vhw9vqqPgkEKPS/5cuWPR+iAIEM+7JG/QhQCQAM=;
        b=m5YtDS05IDKIhkipG1O827AISb40k6BEGhM2zUok2vf56fmFiIJeLhAoP1o8isrhzf
         AOFqtx+1JbLf31Wgd4bp+esdGOzzw042ekK0lfw/X/bF+cq0DoyoXGdeBqlOqzJ3bEJq
         8uA8TAfTha1+j6CCQd+rSWfzwuUsd92XvibMhKaoHhItInUiJMf8iOHbbVtddP2u1JbL
         PkflIGFGAcJczQCXLzaUtmQLQLdDi075s2Gg5lx51Rr4rDCS93HBJoZu2eAQ6s5cOL/T
         n+/GCWWVwGkhlCiZSoDxi7XbjfsFfS270TNatQAXxwUrAyLTg5Ie3Mz+VEFjkOoQb6Ze
         JGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752423985; x=1753028785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EzI8Vhw9vqqPgkEKPS/5cuWPR+iAIEM+7JG/QhQCQAM=;
        b=t/fA2OpxQIPhu2FEg7cWbjnyp0YyJGVWLI1UMBslCWr0AZdYZBA+ngG0ilExXn2J3Y
         nIgCzl5u4yQ6GsjWwwoEcmQpjL40YqhknxOP7QE0QNNHggMjs3q/Ngb16yp9Opk+2z4V
         +gG/jfxkTs1TjQ15r1lzwwB0Pdx/LhfgpK2rZu5Wj7xIr92g9Q+xaKyo3Py4CZdMOcxt
         LclDZhZMZDbjSysmV+RvL36u4r0KcmgozDcMVgggohg+opJaJGqs4fBqWZjFE3Se/szy
         YND8Eu6+DRk28Fn5N87z4YRLRKOJwMWw0vbDykgRMrqbyx3JGbiaBPRA5Hac5PNyJM2Y
         2N5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlBVIgAH9U8kJSNHhBisP7uhwKB0sQARxsb5F2ieD2kbYQcJt05vr9k1zrfFWE5ZlXfXN0WN44JIZvut8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBK6H7ano+2Owt3Xgr0XBFGFcMdNKYKW1YNPTaJoZR2NNIaPlb
	AE8oWpksCxDsI33LpCQW12zYWX0S2VDutxO80X4LY5a5k1fsfcflEw/9dNdsqUUei28=
X-Gm-Gg: ASbGncuOUF6D/x+FJNg1VcrUWDMGqJMAVuXQemfuRzgQLGsczo5RldkAvZrpzMXEZqC
	YJtRyYnPXUafX7UUGd/8uhOkqJjYBbm+tfDxczeBLyztqtC+lhW1pf4J4xPIDw6XlF956yxgf0e
	6Lp+VpOh7+N4D7gmEfakjckHO5k7nrl20m9q6uWBqUckbRLlloZ8X0OpHMG+woyaV2BSd5+xKL0
	xRu1T/IrJIzoSChtl+kgszVK8eFWGT6sQS/ectHWaPLw2EA/il0js8GShpuE57inQE6uuYQf8QG
	2lE3YbWnsY2iRKcQfOJLdmgmVM2C8u9FjFqvEFiKl4BXki7tFzagaFIs8OVGtRgrqA2ywfRFUHE
	3L60ChtvQuClih/54AVdZ6Hlo5/hWs1srtTmMo5oEWM8GL9iJZjtw2iqjOleogw58/HBYMfBo6a
	gCRihw9Ffv3g==
X-Google-Smtp-Source: AGHT+IGlbvM1Jo3S8RFj5ooqLLSylsq/8snbmxIY+6ky8Rp3oSbQLcuv4W3bSjHwG0JMyNf40vQ0Yw==
X-Received: by 2002:a05:6808:518f:b0:40b:315b:3775 with SMTP id 5614622812f47-4150ff89898mr7685880b6e.34.1752423985483;
        Sun, 13 Jul 2025 09:26:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3743:cf82:e4e8:b2b9? ([2600:8803:e7e4:1d00:3743:cf82:e4e8:b2b9])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-613d9f00d46sm915665eaf.22.2025.07.13.09.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 09:26:24 -0700 (PDT)
Message-ID: <8b822cda-6bf8-41b1-bb08-f52e2f0b88f1@baylibre.com>
Date: Sun, 13 Jul 2025 11:26:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: temperature: maxim_thermocouple: use
 IIO_DECLARE_DMA_BUFFER_WITH_TS()
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250711-iio-use-more-iio_declare_buffer_with_ts-3-v1-1-f6dd3363fd85@baylibre.com>
 <aHE-o5_TvGtUyHoI@smile.fi.intel.com>
 <b564a925-1d17-43fc-86fb-8db0d845de44@baylibre.com>
 <aHFO7LhWXOuglaoz@smile.fi.intel.com>
 <4d41eafc-46b1-48c7-982a-1a3566f9b423@baylibre.com>
 <20250713151017.28b9d162@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250713151017.28b9d162@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/13/25 9:10 AM, Jonathan Cameron wrote:
> On Fri, 11 Jul 2025 13:38:17 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 7/11/25 12:50 PM, Andy Shevchenko wrote:
>>> On Fri, Jul 11, 2025 at 12:04:03PM -0500, David Lechner wrote:  
>>>> On 7/11/25 11:41 AM, Andy Shevchenko wrote:  
>>>>> On Fri, Jul 11, 2025 at 10:33:55AM -0500, David Lechner wrote:  
>>>
>>> ...
>>>   
>>>>>> +#include <asm/byteorder.h>  
>>>>>
>>>>> Hmm... I see nothing about this change in the commit message.  
>>>>
>>>> It is for __be16. I kind of assumed that would be obvious, but sure,
>>>> better to be explicit about it.  
>>>
>>> Isn't it in types.h?
>>>   
>>
>> No, only CPU-endian types are in types.h. The actual #define for
>>  __be16 is in include/uapi/linux/byteorder/big_endian.h. This is
>> included in one driver in staging, otherwise it is only included
>> in arch/*/include/uapi/asm/byteorder.h. And asm/byteorder.h is what
>> Jonathan used for similar in some of his recent IWYU patches as well,
>> so I assume that is the preferred way to do it.
>>
> Never trust me :)  I may have been after be16_to_cpu() or similar
> though rather than the type. Can't remember. When I get back to those
> I'll take a look at the logs.
> 
> 

Yes, you used asm/byteorder for le16_to_cpup() then I (incorrectly)
made the leap that e.g. __le16 would come from there as well.



Return-Path: <linux-kernel+bounces-713723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D811AF5D9A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 17:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34ADC1886F76
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 15:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEEC2D77E3;
	Wed,  2 Jul 2025 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="u5UeLT3t"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5610264A6E
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751471293; cv=none; b=JmohRtVK4FFqGsJiFRTAmR8inwY0fwmk5wzuC0mfAiZYtPR3gxTPcjJ/O7n60p8HAocVtNxTQ9F9to6j+ekkFQ+/QNQw+3yLijgtuqwhKcO0pCrFVzZvxBy2PB0OmtRPi3RU/2PKXcrpbQ55eiVnBTFKZ4HH5GYfIxT2XH1jyLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751471293; c=relaxed/simple;
	bh=CrFtmeyPfBYUoJ7LTryEGmT/0pwcPxBwGEy8UlmESAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+KZkHKx0O3HSUC2WfijbUaixs7yI65TvnitJ//Ga+ipL40ELr5h9SJ1heCXH72DL+Eylh1PiHz7iMowpr+6ujU0pW5ryJbjsxy46DxYQjBuAcdTJg9PjvJEchjYMOr0ol66pt5+ZVkT7XM9/Q/O9bhKp2ajRzPpf5aG4WxL074=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=u5UeLT3t; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2cc89c59cc0so39950fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jul 2025 08:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751471291; x=1752076091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NQRpPjiuNrOHNg3sriarET4axQkkS4yzIoHAaUkDTGc=;
        b=u5UeLT3tOyUsy7B5fRheeL4nGjV03pFClgi/mQa/E+Xw0Z9iYH2s+SmFprYczo21lN
         3Zz65eAgu9SHHVrjpm1DqGHHIJL+9E2EWFwHBu/KdyTtuAFqBw5u2sxq5rxEChlnKhkW
         n95fAyCfyZOwsGs0weznpIoq267DnXdP08MFCkOE+SUuJstnRF7iKNulnyc0QGBCaHKJ
         MgnlZcseq0DD+wvdWHXCikPPp02U6/bOB0PjKhRJo6QChOB2qBlN8HbFyxC0eDqMIyYu
         PB3QYb3/ocHJgmS7Nic1lsgLwXPlTTWrE9XgilnZ3tZpHDluI4y0g36YaHWpk7tuXcrD
         Mahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751471291; x=1752076091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQRpPjiuNrOHNg3sriarET4axQkkS4yzIoHAaUkDTGc=;
        b=SJN1OLIZRck6QKLMCiS8lFg48D6cBnIAAUhnSUlIIAmNh6YBOSuQ6xk7q31uaUCnOG
         yOGXsueIKN129Dvpcu3dtfocuK6lorvAcb5L6ot0+JhiOAaLgIW/98tinsf3VdBgVPDn
         Q5lBMoep6XwAuDoyTiXbqRDDwrHsDmTgR3CJ6YY1aUax02fw00PV5GDnVObHmjO7Uaiz
         hTlRqCAj6hI3MfxYsr8HSrkcXii028EYjnpNuof46gQMjhD0iZLhkPL4/f+CuecEDV5V
         aVDrJtTxjrIq5tf85lGcafkqxwZd2/BAbd35YbIE2ncs9P/yNw3Axp7z5TNbAqS9H1XT
         dBBg==
X-Forwarded-Encrypted: i=1; AJvYcCWfwFdUmuB1QBq7QLahJ1SzDeuozzwb/Vv1F+3nNg0Hm3XhgI0mhrxCehP5wOF5AGmDdUYNQmDaRY0f5jA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmGgDlFjYfAtFhCdcfBL0spIwQt8FmRu2eVeIYD5+tiTFd+6lP
	6DVvYYDY58Cq+BG8cJCdWS6+H69MDO3w8EjKjP2uQqgSnPNflRYb/N8LqBmbrMXjQUs=
X-Gm-Gg: ASbGncvuKvhQWeTMJt80lZpmeqHYMXbyEN3ETF7z+xOHZ7iV4TV/NY5leOjU4nyB7y7
	ACrqCgoCaWQJvKL4S7l/Q8Mpkfa04y41iVarTZn9BEaOTxjo89i8jY7uFkY3m//EogFWX8p3Zop
	cc/QBcyYZugB2nh65QLJ1riemG2EBea0hghxfqi9lVrRMT/zX8CadnfTV6VJse75RwI2EZHFREL
	YkVf7xxOs9Y70DdKwvKNkIlcUnW0D0o0/WByUUR5nMgmx/yCrMUO1dMe9Y/3/bcrgMVc4lkM0rh
	LlsNdcVxhFpStTbkHycXFCXb3HvE3PyBCN2CHJKr9a3xV9JCZGtSLarOHQgMy9cP0GT7PnjbNid
	FkgTNxcxIXu4jjVNkCYb9X6AWn0qPQf8w+8W2qAFC98TAfEhLWg==
X-Google-Smtp-Source: AGHT+IGWxd92U1QTaYipBmuhf+rsxHSGYIp6LfrrKBZYu+SlPYX9jUvdjobhmSYehAHe+frRt1JZsA==
X-Received: by 2002:a05:6870:e38c:b0:2f7:53e7:1131 with SMTP id 586e51a60fabf-2f76bdeefdcmr24165fac.10.1751471290678;
        Wed, 02 Jul 2025 08:48:10 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:5c00:24f0:997b:5458? ([2600:8803:e7e4:1d00:5c00:24f0:997b:5458])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd4ef29absm3899896fac.14.2025.07.02.08.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 08:48:09 -0700 (PDT)
Message-ID: <6f6d51de-7c7e-48a5-86b8-c1a77f51ab4f@baylibre.com>
Date: Wed, 2 Jul 2025 10:48:08 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: imu: adis16550: rework clock range test
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Robert Budai <robert.budai@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250702-iio-imu-adis16550-rework-clock-range-test-v1-1-b45f3a3b0dc1@baylibre.com>
 <aGVIBVsFPcVw3lN6@smile.fi.intel.com> <aGVJPRmn1-HUBb40@smile.fi.intel.com>
 <3778ad13-3b62-4f68-946d-b861b0df4272@baylibre.com>
 <aGVNhIwn7CXO_lpP@smile.fi.intel.com> <20250702163126.000007ac@huawei.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250702163126.000007ac@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/25 10:31 AM, Jonathan Cameron wrote:
> On Wed, 2 Jul 2025 18:17:24 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
>> On Wed, Jul 02, 2025 at 10:07:17AM -0500, David Lechner wrote:
>>> On 7/2/25 9:59 AM, Andy Shevchenko wrote:  
>>>> On Wed, Jul 02, 2025 at 05:53:57PM +0300, Andy Shevchenko wrote:  
>>>>> On Wed, Jul 02, 2025 at 09:27:45AM -0500, David Lechner wrote:  
>>>>>> Rework the clock rate range test to test if sync_mode_data != NULL
>>>>>> instead of testing if the for loop index variable. This makes it easier
>>>>>> for static analyzers to see that we aren't using an uninitialized
>>>>>> sync_mode_data [1].  
>>>>>
>>>>> But at the same time it makes it not to be the usual pattern.,,  
>>>>
>>>> Reading the static analyser output I think the first hunk is only what we need,
>>>> but this is still false positive and it's problem of that static
>>>> analyser. Have you filed a bug there? (My point is that modifying the code for
>>>> the advantage of false positives of some static analyser is wrong road to go
>>>> in my opinion.)  
>>>
>>> I agree that we shouldn't fix this _only_ to make the static analyzer
>>> happy. But I had to think quite a bit harder to see that the existing
>>> code was correct compared to what I have proposed here.
>>>
>>> But if this is a common pattern that I just haven't learned to identify
>>> at a glance yet and everybody else can easily see that the existing code
>>> is correct, then perhaps it isn't worth the change.  
>>
>> To me checking against index variable (when it's integer, obviously) is correct
>> thing to do and regular pattern. OTOH, if the "index" is a pointer and rather
>> we call it "iterator", the angle of view is different because in some cases
>> it may lead to stale or invalid value which might be mistakenly dereferenced or
>> speculated (see more in the discussion about list entry APIs [entry is a
>> keyword here] and if list_entry_is_head() is a good approach.)
>>
> 
> Original code looks fine to me and is a very common pattern.  So I'd argue
> the static analyzer needs some work.
> 
> Jonathan

OK, we can drop the patch.


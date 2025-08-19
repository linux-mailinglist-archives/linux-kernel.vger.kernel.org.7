Return-Path: <linux-kernel+bounces-776004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B55DCB2C75C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07BFB1BC6A28
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47B727B33E;
	Tue, 19 Aug 2025 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GDuzY4BJ"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1105127A931
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755614634; cv=none; b=H37gvK7+O2Z0PKurnklevcahRTRFFch6c2Ex/zMXdBV/EjdM3EN0stmaZdGYQ97icnY4vYE3mv4f+qyj5YO8fkotntqZh48/xnA24MJg1/FS11Li5v80CZRKCQgVNSX0To/5XWE1e5UYKxmaHVcIsMtLvlQ1R/BC20QTPSEjVT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755614634; c=relaxed/simple;
	bh=3rHhLrHoLFeMwz9Y4IfzVNw2lV4GWZAwvlCt+1eLQBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dDNPxLtjb9BCaa6kKCJ1KMgsfLkOzvZ674JTZqOvdoEzDsS5UNASH1NF4RTUVoODSvbUyLSaVAZxw9+c1op5hfVR+YaQJfsKg2bfRP5SX3Z9HmhANRYKpinYLOT9E4LclcNd8IPiv3mwUJdOQVwDk+pXLn9jjyRn2nhVoSUdKA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GDuzY4BJ; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-61c17e31666so690464eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755614630; x=1756219430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Z5bxvYBSBLdym7Nb1x4kR9TKOagtFVtWVEo84Sb9OE=;
        b=GDuzY4BJD4rFR3bQ5hR41Vz2YErKB8SZVOKGgOigxMgsFoZE7QCzCeHyjFrJw39fEj
         iiSdIoMAqPhs2KmTO84VIqT2twaxAGApwhiuY0pO9IdMqG/AQ1DFsKuYIJAZ7q0WYZf7
         6Hw7SkyGcFB0FP2EX1YESyuKQoI4EUTTs51LOuF1920SovZUphFpL3T+4Dfdz0sRp6Ns
         SMrIrzzeEqWAFpFos8kKzqoxsx3HUlHu+fg7EauATHJG2wmrZMJAK5QDgH+0k+zh6Wr2
         /5y6w35txG002sH1H8U2CcLQy/l6f8LJ9SFJZ995j1MBykZIn1Yoy850LcLZ+ChQl5dr
         9lpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755614630; x=1756219430;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Z5bxvYBSBLdym7Nb1x4kR9TKOagtFVtWVEo84Sb9OE=;
        b=jZWaAqK0gG80XLgNOi1G03/5KNk/91E+THuMkKdbZD4kDiVwPH0K5OerrpGKY2bVqT
         YMa0xQHSyHjYiiIEkBNwnS8c5ynwBgymTxqN74B5Q0A2h5VezxKLaEQ+tACVrH0hBEBJ
         ja4gdNQiuUTJ2TApDQt29W6G8p0De8hR1eYdc4ww8XTU+mye0OmQ+KP11xyeC7futco3
         xoKP7Or6EkzKay1Uekb6ax8PruPa3owSeLAeiEgocEAO1GE+Yo+WvXsjK7EXXNXNIKaW
         gfjwNOZhXDuzpJdoGdjeBRIoFJHtcuxls83w4BBFCryX2cGSUFIT3LujHisbmSMzT482
         Bc1w==
X-Forwarded-Encrypted: i=1; AJvYcCXcy0jXScQugfuS0CTFC/kGuTPg02uWXonSlHOu+Wym7zsjW/QQMUAPWcUSXoVy7W5THjc9aJSv4/cZZgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHuBl21mpyd13HexxAuAc7r1AwCpRKriYwzRMiO6BzqI8DovNC
	3HwTldY28vVXySxeOpM4W6D/hRs0cOcERXq2tZrX1pBpajtRILklicx3JlRTq0/+0Tg=
X-Gm-Gg: ASbGncu3TkAXVDmbz+rTeNRjmRupn6g99w8XsaktGGa6Ip/0ViJEFrEqq/ZsUrRvvbS
	K3eNygIzF2TTcl7DhTjq6nXuNZyU7WRFOOJY8l1W5gXVzI5M5U3XcXIMG3CHAFwdjpFI2FZjCH/
	5CITKTgxagu/V33ulkpKA8YdLP3IVtro/8ayOKtZ7xOJy5DA4EIgLDdtcFKFQjOH8xo0hLxvcKh
	HRtbb870JF89yiNOUzjBXhbfTsOnrB8IQ4wZKbo6DW2UHDf3gaAr24/Pu6gej87wwli8dUECrZe
	yIdcVDmXsWchE+AlkzefvIpKddDn9+NogbBnd9u+vdj2HLOa2X8hTubjzS/z03FNOOUdmaDlB6Z
	q5PRhhYUpI/O1aEgTOLFAl13ZxdHqIOb0kNGGDetHaKvR7FMojtOfRphlCeCOm98O46IspJ6DVM
	w=
X-Google-Smtp-Source: AGHT+IFkLLPLg9PAHBHu7Rh5I0VIsdYwpUy55zZnMg13X7zvG1V5lI69odJR7k84aEPt3VDT/VtFzA==
X-Received: by 2002:a05:6820:1611:b0:61b:924a:b798 with SMTP id 006d021491bc7-61d919da03dmr1721044eaf.1.1755614630002;
        Tue, 19 Aug 2025 07:43:50 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:990c:4d50:9c6c:f367? ([2600:8803:e7e4:1d00:990c:4d50:9c6c:f367])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61bebfd18a8sm1120838eaf.13.2025.08.19.07.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 07:43:49 -0700 (PDT)
Message-ID: <3e00a420-0db7-4df4-8164-a48dffd864e7@baylibre.com>
Date: Tue, 19 Aug 2025 09:43:48 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] iio: mcp9600: Add support for IIR filter
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250818183214.380847-1-bcollins@kernel.org>
 <20250818183214.380847-7-bcollins@kernel.org>
 <f8e95533-c486-442f-a186-5e746dad2f4c@baylibre.com>
 <2025081910-arcane-parakeet-ded8c5@boujee-and-buff>
 <f7292e8d-ac7f-43af-b77a-7a1ad8403962@baylibre.com>
 <2025081910-shiny-trout-a937ef@boujee-and-buff>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2025081910-shiny-trout-a937ef@boujee-and-buff>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/25 9:32 AM, Ben Collins wrote:
> On Tue, Aug 19, 2025 at 09:15:23AM -0500, David Lechner wrote:
>> On 8/19/25 9:11 AM, Ben Collins wrote:
>>> On Tue, Aug 19, 2025 at 09:05:39AM -0500, David Lechner wrote:
>>>> On 8/18/25 1:32 PM, Ben Collins wrote:
>>>>> From: Ben Collins <bcollins@watter.com>
>>>>>
>>>>> MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
>>>>> to allow get/set of this value.
>>>>>
>>>>> Use a filter_type[none, ema] for enabling the IIR filter.
>>>>>
>>>>> Signed-off-by: Ben Collins <bcollins@watter.com>
>>>>> ---
>>>>> +		if (data->filter_level == 0)
>>>>> +			return -EINVAL;
>>>>
>>>> To implement Jonathan's request from v5, drop this error return.
>>>> We'll also need a separate bool data->is_filter_enabled field so
>>>> that we can keep the last set filter_level even when the filter
>>>> is disabled. (i.e. data->filter_level is never == 0).
>>>>
>>>> This way, if you set the filter level, you can enable and disable
>>>> the filter via filter_type and still have the same filter level.
>>>>
>>>
>>> Thanks, David. This is exactly what I've implemented, plus the
>>> filter_enable attribute.
>>>
>>> Adding the ABI doc updates as well.
>>>
>>
>>
>> Don't add the filter_enable attribute. The filter_type attribute
>> already does the job.
> 
> That doesn't solve the problem at hand. An example:
> 
> - Driver has 3 possible filter_type's, plus "none"
> - User cats filter_type_available and sees [none, sinc4, sinc5, sinc5+avg]
> - User cats filter_type and sees "none"
> - User cats frequency_available: What do they see?
> - User cats frequency: What do they see?

The ones for the last selected filter before it was changed to "none".
If the driver starts in the "none" state a probe, just pick sinc4
as the default.

> 
> Without filter_enable, [none, ema] driver works just fine. But the
> above driver does not.
> 

We can wait and see what Jonathan thinks. But if we introduce a
new filter_enable attribute, then we need to think about what to
do about the ad4080 driver since it was the one that recently
introduced the filter_type = "none". Ideally we would change it
to work the same so that we are consistent between drivers. But
there is always the consideration that we can't go breaking existing
ABI.




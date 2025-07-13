Return-Path: <linux-kernel+bounces-729129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA085B03221
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 18:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BD027A8AE9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 16:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD32127A134;
	Sun, 13 Jul 2025 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NIsyJAEG"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10A62264BB
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752424513; cv=none; b=EZdQCMWUiNPVq2tKYRHU+QnQT0ybdOHVCG2Fdb+6IhXMjPYew+3TSyUUJRUDiuv9cd4voMo4VubjGnuDGvr++tk99cMIe+bFyor9jiIOlmgpr3HL6XIvYK85KHMo7O1ErKim7P8wZbC1grk+RchZaDMSYZOlNGh1IVrL0Sob1vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752424513; c=relaxed/simple;
	bh=e51XuDAO7MIZrTWIVzDyyTodvw/VUpYDoGScusBtQsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqS4M6DbA+sDLdwQudcy3+18LuHH0utN9XQ7ltkDXaQjNdgK7yc8UuSoDMB7f9kq6YlnHj86W3S7jimVHUPmdu9A7aFRs7BqwSlWFwWZPpAQAgxeHf0eKCbAsIURlF8E6FXVbw8bJFLMBOfoAgbOGwnUXTovlZTsh9Z8dvuT2cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NIsyJAEG; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2cc89c59cc0so2433805fac.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 09:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752424510; x=1753029310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qhbmnFUV2H7taioQZFlDrGOjt+5H/kJTn/NqpDkf0C8=;
        b=NIsyJAEGZUcztVRemlbu9Mxb6Ptje90L1VqnuY5GiiWqM/G95hDAav6x0FWdHjsAF/
         KqqHXwm23tGeLOmdN0xtlZE99O3hemoTZ+uI5MD8ymmK1XJabbuHs6kVQ6SSRmkpgmQ6
         1J9R42fmCqXgWwtHYwK9i4VZ0UqwVBommFjLfgaDCI9L7HT9WuCcuXt2aKb6ySErbcFX
         z/FcDzkUnUQTkzXzmUCHa3iic10K4J6CMTiQNEbpCMARMMdKJh0auFq3Plhigh7soufp
         xtU0AxQ/quWSLPJ1Rf26N5MrHjdYCvqt/0+Ee+/O7gxSCV1ObhXoqOqdLOVJ5OW8YWz3
         3T1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752424510; x=1753029310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhbmnFUV2H7taioQZFlDrGOjt+5H/kJTn/NqpDkf0C8=;
        b=s3VQXFcIBH2z0HBUuTbfznkVBr+ZcXjZUQPRbgLCpmVDzgzOwAVorQeIW2clT0aYAl
         QX/fo6C62wObbGEIM0feXK4NFQfn27+CcrUCgvb05ftKY0ajXYHjdS9KSF6FNc9YSVnG
         xCHLz9sYj/gl0oT5VAwX1oG7JLTbZLc5EBkf4Z3EnLiQCkJgCsAsI2KcAlMwWiy6qKp5
         iO3yOTv2DHmxFcS6v+kdgs/SHeQoCCIL5ZGVniKVKLeUAdiKcbf9v8EMCq4qojKoABxp
         Fjj1xtxXQqC4Uh1r+O1fiWEDRa9F8JB3/LJnlEuTyUZt/SgfSpyguPizXohMH1VM5Ibr
         OQKA==
X-Forwarded-Encrypted: i=1; AJvYcCUssDnwia+/1ieXtRpxWfMVa4+/mQ08W9YKCF34R59fsvWZmJwKqkv+mrwMcEc1eLKumFxlfLpBBD+v51I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn6QEpq7WpkFWKCeSmQdfRx+4c60Jv/8XbdCZ99heaBVQ/ml7o
	lOKbUK0iIszbjjPT8o78I5eXSryQx9Q5FqHL53jmNZ6IfIPY8jARAdg7FAVS4LdNLQE=
X-Gm-Gg: ASbGncsBXpB1lW5lQ6z/nTVpvgwHxqY/hlyfSkQRvXHcXtXE2wcdz4mmB8Pq5Nrx/ZU
	MMBV2XyxseBa2cZ06A9Oj7ekkFO2CERAC6ZpjkjjzARbtTm5s+hYnc4zhm3HxzTKBP9NGKWL4ZS
	utk9bk1hJakH8khiVhRu8vnt49SR/S3hKpke2EKh4kvwfiwH3y3yCqTdeSnyIoQyjIBEkAgd7hO
	Cp+YswVoqRDesVk7Mh8aIFWx26AD/9qe+QIJ0rt+WJsyR3oINmbyYOKrQOD8QVR9zGSo+A+CEap
	cDJM8tS2kWz+SPY8x3thebBAksuNggvYZuvbmwIlma+WEx8wteQgAf1d99lNETWLhanYWAwI6pK
	llYAGwtxsJl8fTXKvPwU4+VXBTm7tKjiB3ztKssB8B/Tqor1NNSRI1bzxGurfREKT+0LC+WRrl/
	U=
X-Google-Smtp-Source: AGHT+IGTBIMnuapthYWNPo1waoFYzmq0C333tvP3kzTWZPcP5pUyxWSTGtx+di0uFdTWR+OTrleYqQ==
X-Received: by 2002:a05:6870:80cb:b0:2ef:88fa:e0c3 with SMTP id 586e51a60fabf-2ff0c7f1938mr9162252fac.13.1752424509852;
        Sun, 13 Jul 2025 09:35:09 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3743:cf82:e4e8:b2b9? ([2600:8803:e7e4:1d00:3743:cf82:e4e8:b2b9])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff1172e5c8sm1603919fac.44.2025.07.13.09.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 09:35:08 -0700 (PDT)
Message-ID: <bcf599e1-7816-4580-a2f9-039b0d3c0c99@baylibre.com>
Date: Sun, 13 Jul 2025 11:35:06 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7173: prevent scan if too many setups
 requested
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250709-iio-adc-ad7173-fix-setup-use-limits-v1-1-e41233029d44@baylibre.com>
 <20250713155839.07476235@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250713155839.07476235@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/13/25 9:58 AM, Jonathan Cameron wrote:
> On Wed, 09 Jul 2025 11:35:52 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> Add a check to ad7173_update_scan_mode() to ensure that we didn't exceed
>> the maximum number of unique channel configurations.
>>
>> In the AD7173 family of chips, there are some chips that have 16
>> CHANNELx registers but only 8 setups (combination of CONFIGx, FILTERx,
>> GAINx and OFFSETx registers). Since commit 2233378a8c60 ("iio: adc:
>> ad7173: fix num_slots"), it is possible to have more than 8 channels
>> enabled in a scan at the same time, so it is possible to get a bad
>> configuration where more than 8 channels are using unique configurations.
>> This happens because the algorithm to allocate the setup slots only
>> takes into account which slot has been least recently used and doesn't
>> know about the maximum number of slots available.
>>
>> Since the algorithm to allocate the setup slots is quite complex, it is
>> simpler to check after the fact if the current state is valid or not.
>> So this patch adds a check in ad7173_update_scan_mode() after setting up
>> all of the configurations to make sure that the actual setup still
>> matches the requested setup for each enabled channel. If not, we prevent
>> the scan from being enabled and return an error.
>>
>> The setup comparison is ad7173_setup_equal() is refactored to a separate
>> function since we need to call it in two places now.
>>
>> Fixes: 2233378a8c60 ("iio: adc: ad7173: fix num_slots")
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>> I know this isn't pretty, but after puzzling over it for a day, this was
>> the best I could come up with that didn't involve a complete rewrite of
>> the setup allocation algorithm.
>>
>> I don't really understand why we care about which setup was the least
>> recently used - it isn't like we are going to wear out one setup by
>> using it too much. 
>> Maybe it was just to reduce the number of SPI xfers?
> 
> Been a while, so I may be remembering the intent here wrong.
> The challenge of these allocators is exactly what you have called out.
> How do we cope if too many configs are needed to deliver the mix of
> channel configs requested.  I think the LRU thing was an attempt to
> reduce the amount of reconfiguring needed.  That's mostly relevant of
> single channel reads I think...
> 
> 
>> Anyway, ad7124 has a similar setup allocation algorithm, so it could be
>> nice to eventually replace both of these with something common that is
>> a bit simpler, e.g. always use SETUP 0 for single transfers and allocate
>> the rest of the setups in order for buffered reads with more than one
>> channel enabled.
> 
> So don't use setup 0 for buffered reads?  That sounds odd.

I didn't word that well. All setups would be used for buffered
reads.

> 
>> And just always re-write the setup each time so we
>> don't have to try to keep track of what each slot is programmed with.
> 
> Fair enough as a simplification.
> 
> If you've stopped using the lru, why are things like the _lru() functions still used?

This is just speculation on how we could do this differently in
the future, not what the actual change is here. A complete rewrite
seemed too big of a change for Fixes, so I've started with just
this patch for now and may consider doing what I've suggested above
in the future.



Return-Path: <linux-kernel+bounces-795099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E85B3ECD1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 19:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4A80482708
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E345820FA9C;
	Mon,  1 Sep 2025 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oTTNc8if"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC2D32F75C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756746049; cv=none; b=uLh63/dLhK2jjIPjfQpCCMSeDKBFl0mIsl8q+EU/21Mbd3aFqS3xX0nkhv9nRuhg3U+B2sfLgg2p5YEPmKa/HSU2h4PwPLqD5ksmt42R0czP7RyOK6/OKkqrGLtdn9e61JLDls/ZJfYsflCUU7VfUDoZ3EV4ZGcjhzGFtT/K+p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756746049; c=relaxed/simple;
	bh=Bt/E5fYRuYgMGd5E3qlp1QAR/XCLIWL9ANVQ3PXy9nI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHC8IZgv7YtghZTlilzRCXJU1TH2Es1334NgEX0jPFOxd85MjcT4piDMyUxVv65Ezg9N9h9sVIK8DtRmtBxxiZtmL8+A1gSSh08s9J4CsHjGuJp5zeW5e+BdCak7F2zr/6ymmtNpeIKA9yAvJncdgXyNh01gYjjX8+gl67QaFlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oTTNc8if; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-437e6c1803bso175732b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 10:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756746046; x=1757350846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DrqdFNDTpOyLhwZdVOt2XYhBmnygUG0NkUlt1st9S5o=;
        b=oTTNc8ifbwPQOA0dYpBVvS9Fqk0TWFOwKcNJVy4q5qAwNWzG4BuKclPd9gHICsKKEq
         QeqXED/p4+KMCVPrdiNI3xovxx4MHORr2tR1jA/q4ZG01xaWK+MFkVMBLYtjb9diaDu3
         XZrrnruUZUTDF86o+7AqX2EbgljUeOxQQmqKCARQWOqEvMLZbt5QYAXxhS7PNCMfFKBC
         moqZL55VcxkFoq3wXOpfyIusA300cQRT847LyAh12G55lmxOl4nddl6l4R047EwbrQmP
         UG248Z4OIRoCSMH2rABvDaZYq7AneOhUIePtYWnl2qwkQFnzHEf3jGpcIe7V3Uk5aWTV
         krbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756746046; x=1757350846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DrqdFNDTpOyLhwZdVOt2XYhBmnygUG0NkUlt1st9S5o=;
        b=KzsQN31xpKDAigbhM0E86/voJiSPVOjLWsElpR+xxQXAQ5ltpIH0Ogo7Sw9Ubk3ORh
         TZ33kMUQ9WOjR3XWnLWel6fuoXWulDkkCOwA1n1pRF0vP5BNUooy3pBFJA04MDta08CH
         HSK+R7tZSF2orZloYYLU++TiyGGx5wKIR6pGfROG/Jy9ynPacgsHqdd46rqChWGeBNTu
         yS+H5vYgiveXqUXaZnvbLwCo63r1vRJ3P6shgu9CuMzjiUnA8WD7oeIwe4RI1JRq0/Vp
         0yPvl6T20CK2qnbfI3+Tf+L7hdwAyDLUWb/C/HvFC3NQQH9eMzLoJOkwv953VUm04vPS
         sUaQ==
X-Gm-Message-State: AOJu0YwtI8ysO65yaQoyPtuwhhLE8lVpddRVyxa+zLSathTEBHXeP66/
	AHi4auz6Sos2gdZCdrsjTXDtRsOX7NmUg4L220VS2Sw0Rf3XOHYSnbtv+ZT536HGiqU=
X-Gm-Gg: ASbGnctP2i7CGtS+8DQ9Yzz9cjTDLu8KqNCd6WT4FPBmcsDxcxcexLR4xLkocTh3MUn
	23bhmni4XXVtAI2E8yvuMbagMNrCkcSwPcYDrz3NuJVS0KEcWQ3Lpyom4pb+QT0pJT3Pi5SbN+s
	JUiFEON1KEKHEfDCTmICXCTws4LVQRNYqRR9IigqaPqsFo499KASD5OE+M029wfjbGuuo+/cVDx
	nPUO1SXTKZQZI3J9twZmmvGI1h/tc4GVtbni/kQCqIC6akJlJkvBfez/by7X/3S4aWqobQvQObG
	yR+MM6qPhMPARoNumRIqI3bzn3XHVWpr/+cbUfQD1AgnoRFomD1Hb5Qd7iJM/U7DuztZsw4KbyG
	Pql2L8vVhOK+mUDe1QajDW5LBTVU4S1L/h7Y9JnG6GALRJOomIVkkGz1UABAC1XVGrLkGJAFs
X-Google-Smtp-Source: AGHT+IGB3TjTYkZgHsuQOjcnZwKuCtsoGCrFHqU14FGoXAjd8xo5T6xjTMwKegpWpbn1ROIfbcTsBw==
X-Received: by 2002:a05:6808:2386:b0:433:ef4c:6d85 with SMTP id 5614622812f47-437f7ce00d8mr4030240b6e.14.1756746045833;
        Mon, 01 Sep 2025 10:00:45 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3c0d:2a9:2478:d89e? ([2600:8803:e7e4:1d00:3c0d:2a9:2478:d89e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43800064245sm969232b6e.23.2025.09.01.10.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 10:00:45 -0700 (PDT)
Message-ID: <51042a87-0233-4748-b3c0-b167d3a4fa06@baylibre.com>
Date: Mon, 1 Sep 2025 12:00:44 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] staging: iio: adc: ad7816: fix race condition in SPI
 operations
To: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 nuno.sa@analog.com, andy@kernel.org, sonic.zhang@analog.com,
 vapier@gentoo.org, dan.carpenter@linaro.org
References: <20250901160310.399-1-moahmmad.hosseinii@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250901160310.399-1-moahmmad.hosseinii@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 11:03 AM, Mohammad Amin Hosseini wrote:
> The ad7816 driver lacks proper synchronization around SPI operations
> and device state access. Concurrent access from multiple threads can
> lead to data corruption and inconsistent device state.
> 
> The driver performs sequences of GPIO pin manipulations followed by
> SPI transactions without any locking. Device state variables (mode,
> channel_id, oti_data) are also accessed without synchronization.
> 
> This bug was found through manual code review using static analysis
> techniques. The review focused on identifying unsynchronized access
> patterns to shared resources. Key indicators were:
> - GPIO pin state changes followed by SPI operations without atomicity
> - Shared state variables accessed from multiple sysfs entry points
> - No mutex or spinlock protection around sections
> - Potential for interleaved execution in multi-threaded environments
> 
> The review methodology involved tracing data flow paths and identifying
> points where concurrent access could corrupt device state or SPI
> communication sequences.
> 
> Add io_lock mutex to protect:
> - SPI transactions and GPIO sequences in read/write functions
> - Device state variables in sysfs show/store functions
> - Concurrent access to chip configuration
> 
> This prevents race conditions when multiple processes access the device
> simultaneously through sysfs attributes or device file operations.
> 
> Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devices")
> 
> Signed-off-by: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>
> 
> ---
> Changes in v4:
> - Added locking to reader functions (show_mode, show_channel, show_oti)
> - Fixed incomplete reader/writer synchronization that could still race
> - Ensured all device state access is properly synchronized
> - Replace sprintf() with sysfs_emit() in all sysfs show functions
> - Use sysfs_streq() instead of strcmp() for proper input parsing
> - Implement locked/unlocked SPI function variants to prevent deadlock
> - Use channel snapshot to ensure atomic read operations
> - Fix sizeof() usage in spi_read to be more explicit (sizeof(buf))
> - Make oti write operations atomic (SPI write + shadow update under lock)
> - Fix race condition in ad7816_set_oti() by taking channel_id snapshot under lock
> - Fix return type consistency (ssize_t vs int) in show functions
> - Use chip->id instead of string comparison for channel validation
> - Add explicit cast for narrowing assignment
> - Add default case for unknown chip ID validation
> - Use cansleep GPIO variants in sleepable context
> - Improve lock documentation for protected resources
> ---

This is way to much to do in a single patch. Also, given that this
part is obsolete [1] and this driver is in staging, is it really
worth all of this effort to fix it up?

[1]: https://www.analog.com/en/products/ad7816.html


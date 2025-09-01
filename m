Return-Path: <linux-kernel+bounces-795312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42937B3EFC2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 22:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE230189205B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BAD26F2AF;
	Mon,  1 Sep 2025 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rLUDDSDf"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5EF26F293
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759065; cv=none; b=TDIejBDU8bCres6A5O1CwkV7Qkw74Afi/Z/koARMnH1UKCef9CqdHvNK6ldKNTZvwpFc7xJQc3gb5luWS6ockuf5rO8GtshVTAqo4scvkYgc2v/794gUaEat2po2GCQbANL2VGNa7kOS74Ov1ie9ZQ6+JZbck5pZ/3fjgdITWyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759065; c=relaxed/simple;
	bh=+HxizGUNPE0IAbaEtDTKLzRhHig2naRomVFB+5URGC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cr9yZrSxzUKHwhbp3BXpP4cs157G1xJfjnzFXt3dQ2dWFQEGOEPgxKp0ObbBuQr5nukTO30Egzovpy4KfzofcTiMxPeAD/RXhI86jCkEls8rnWqC3dtrt7g3k8VuzqiQgRJDs48/viCmz5zhYvXtxgmhlfrVwkniMGaAPtp2VY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rLUDDSDf; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-74557b7703aso954046a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 13:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756759062; x=1757363862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/zfsf0ToW5FKPBE5eHIj7npldCgSMxNQpkAfQKcXNrQ=;
        b=rLUDDSDf/YqG+lnXgJINjqXRnnb+9yUJBHclmECUxlrFcXuRBVSPYSSnw0VSTJ695N
         tF+J4Dz6XIVUHRj/RGsWidh/JFmAglX875IQ452rgwhYpiiEVHbB3xDiQRWH0nTHzTw3
         6SnXWfxHq/nUn1GBDkXPRFqH9CODqHXd6lqy0/IYN4hW8YcHees8Du6orDW37RoXjt0q
         MORCEUH6zwW0/SrUw64kUbeT7Hb3z0tRGvGd3r9sB0QUplIwCboI2IQ1SfzaY0NzqiTH
         5CNBVFXI4xuRA+vuhrlVkWTi39mEsBoxrJJdAdfnMHLFIuivQWyDXzecqtZDmiFTFx8A
         clPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756759062; x=1757363862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/zfsf0ToW5FKPBE5eHIj7npldCgSMxNQpkAfQKcXNrQ=;
        b=DhlhrSjevFywr0N5MhuS7owzZJM/qQ4hY/KK09jV1SJ2Gce40fRGs2515wF4EAnd3x
         nudXXFOXsvFmE+4l4ZQivXhzPg/bm7OSznwBYQnXVseiD8qKOiDaR/ZNG5m+SjU1aCOw
         cVERpdCSILrjVs21k7DcH/fKhUu299Eg8H4+4ADtz7mwhftJM1mYYL2G0iavo3n6FTtv
         nmoPHtds9zx3NqMT7VMlzGevrJsXG+UVyU6HkRWxZyiStMGEWf2+aJgfsoEiVrPG6E/L
         +PlXn3C1mJVK1ipKSD9BdSD+xMa2q9M1zfI9IjSv8uwLwzosnk65oSfp93uUqU0gulWY
         iJ7g==
X-Gm-Message-State: AOJu0YzbK9/0Rf3LT1eXoYV/1nS/5kaTTQLZoKOY3TF23x4l4zwqD+b2
	kzslsQOcZliSkl0yGJjloow4/L6Pan4Z76IkHXMNi0ltTIIVgEnWBJrMZvOziGUeq10=
X-Gm-Gg: ASbGncsDmKkNFFeY6RCqu/PBHZ4JS8LBU7/MrRR1klm5hHKuWzDhhjdQG9W1T+hGb90
	o20Kys4xIWYS9zHEL4YoQT6iv2QmxZCykqepbmXfjTPKl7qA8Nb7npnKN8yQtXGSfysNQIQXpvJ
	BsfPrDz2lHZA4FinqoVZDRAqQfweLEx/y7+/9njM7dzfRlWjTv/hYd2lJGB+sLFEqk8usqhNRPZ
	QVeaiJAXrtOqKfegNM45LJa7KHHWnmIDoBgd4bl+jhTusG/biEGrnPA8J8eMvKYk5djZbpA/MVy
	v0S3EWrYVoHpCQEhbzUlmzumWVA15RtLKkUCLoyusvIJwNYJouLBqDYM3T+PiBNNmZBpqAIwRqQ
	AvE5aR+Z+vS7rg+J8cMhXkeufO4iUoquZXZWfTokAucCgcCVWND9aJCtRVLr60nNsqbR+kHm1Pt
	XuVgsnrps=
X-Google-Smtp-Source: AGHT+IHn+yQITVhX7JOhNKmg1v0d4AeFsuyhfMZxVSx4jo79SO8Ist/PfxPol73ufoIwTw32azv2aA==
X-Received: by 2002:a05:6830:3109:b0:741:c038:f51c with SMTP id 46e09a7af769-74569dd8573mr5472670a34.11.1756759062500;
        Mon, 01 Sep 2025 13:37:42 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3c0d:2a9:2478:d89e? ([2600:8803:e7e4:1d00:3c0d:2a9:2478:d89e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7457428c153sm1192315a34.8.2025.09.01.13.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 13:37:42 -0700 (PDT)
Message-ID: <5365cf30-042e-4b71-87ea-3766c6f16bcb@baylibre.com>
Date: Mon, 1 Sep 2025 15:37:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] staging: iio: adc: ad7816: fix race condition in SPI
 operations
To: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 nuno.sa@analog.com, andy@kernel.org, sonic.zhang@analog.com,
 vapier@gentoo.org, dan.carpenter@linaro.org
References: <20250901194043.20366-1-moahmmad.hosseinii@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250901194043.20366-1-moahmmad.hosseinii@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 2:40 PM, Mohammad Amin Hosseini wrote:
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
> Changes in v5:
> - Rebased on top of latest staging tree
> - Dropped unrelated cleanups (sysfs_emit, sysfs_streq, type casts, etc.)
> - Keep only the mutex locking for SPI and GPIO access
> ---

My comments from v1 [1] are still applicable (have not been addressed).


[1]: https://lore.kernel.org/linux-iio/b6c2ac13-2781-49ba-964f-ca821b32e2a2@baylibre.com/


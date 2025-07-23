Return-Path: <linux-kernel+bounces-742680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDBDB0F54B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526B6189B55E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA6E2F2719;
	Wed, 23 Jul 2025 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JOThtsR6"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960A42EF66E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753280982; cv=none; b=sMp+ePN/nzwPIBE4YwYEqgzPHF6GSV41JjNEGWzLFGVwJ539eHfz/pMxz4yP4cq2ETrrNH0mdIjVG/6poXiLs6l/BFQigbH/IYpvAG/B1KVQ4d8XYQe5iK7L0RgmlKSuLncsmNkSUp0A4F+w8dG2IdZqSbGOAG5smVg8G3L0oFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753280982; c=relaxed/simple;
	bh=PPsQ8mITnmr3I8UwjYrUNojkeRQJSFbKPS7aIH5+wFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDcvKT9EUGFAOapgqZtzHkfkVLueWemp2sZQCnNRnQcG4XetQjeSP9bRKooXQCQWlmNROfEIte0ehoLZ0Bf/wt/2GcM1zkhwi2w1DBmXuJvdgMCsIkal4Sdx3xrdy38leOrtk/n5ZrI4/Ilk0SBpvr9X+5Y2NLiNR2l7mrwlw3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JOThtsR6; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-73e88bc38bbso3059194a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753280980; x=1753885780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qLButLoj9620WR1DJqpTFbSFouv61wpEe6LAYSZOeEA=;
        b=JOThtsR6TbgWZeX5KPd3BqmLWIZbHsN1//ttNycSg68BtYN5kfFCQRgooFg4TXF9PG
         hoHc0TzWi3Oy7ZXqsPXILo+qsNvvR9xPyH8g+oQd55q6n9FYW8ampZZbwGS3MpYKWukV
         vyDLyQvsM82+ASZzLnYg5i6du2P56Ay0Fub76/hf2HDxQcXpqFTAePfeJqvDhe2Dt8MQ
         8fHVbyVxSlnw5fp4tak+lP19764VDKxegD9l3triAK817tPvOsxHZlaSOrSss/2nk3VF
         xZ1LT3NjZZ3imuqd+TH8N2EcC8c2lTJ+WP1A3S4JhxCXLX9JUwbSj4nUfeMp657GNltB
         7tKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753280980; x=1753885780;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLButLoj9620WR1DJqpTFbSFouv61wpEe6LAYSZOeEA=;
        b=B5Yb6v9haig5K9H/mJ6yhJG/xJeKCeECUhnOlrbK75/aVyaIJpkQpWTG6U+A16Y0J5
         1ZGjLEdotQyfHt+yl2L5dPqzovL/0LB4B4CTK4GGF9tDBbcd+tRY1+HzR1izv/3XGEw0
         7xGHIJiREJocUBa4JNpirxSo2jJNlD7yhvtLHdAeAYxVhRxCRjm2XcqMvUuTBOakdRGu
         mQKF2kCsbTPzz714I/XdqqlRTyOadFmAFRC0WrqZ+NbeY4qNpQf+j4OucYexB9OQV8O3
         SqfApL9y2EOWGHH7bJee9AIKG3BPnPCOwdysVH3PMddLfc9gVJRHzlrB8DpdHaf81O2k
         fYPA==
X-Forwarded-Encrypted: i=1; AJvYcCUQcEd0nu2AC5CyZb0wvNEr96009iFOkugXstyf3jafFYyW20TvmLF13d7oMckAJ4i5Wu0nqK4X6dc8hkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws9uYE91UOxg0QR/UIZTD5mHuP6Ggo8+PtFqPZHgN6l/5RTwHU
	puKDaqqdgBO7XSICBEdTDGtlWgpiSyf1GZguJcRYZ2yqHcixDlKdYMywz8QkhcmQgTc=
X-Gm-Gg: ASbGnctwTxqluh7yXoO/XtqSrJ3d8/84CJrRjxY6dVGXZSn9s7kBHUOJ/OrXrrN7IgD
	w9IMWbKhh0rk2OJICznDP+bDDwj8sR73ymrBFyrHfdwxXa9ycxBSAiYLhAefn86qixCi8z6W2Zb
	qJn25D/4Hnljc8qA3pmuY5hc1l4I/yCRPer7BX9TtDcDN+omOUFP+5M+/rs51o2eAQPVTWS6DsP
	TnmMuULFUAzdhCVtYr60C8SOHcMEo1LGKpt2DsPlkw8NNobgXtBoE5TYl2quhhGs/0qgIF1Rave
	WS8ngo0La8czu/Flo3yGIUaJ+O+EbBEvxjLkCtphoKN4ZoyOoTIaXLi7uRr2v3mHFsZuJyX1zxh
	roOxf0eJ7J3FMFysQho4A7HketNxRANiaZGJ+nkRFxVHKVGkPMRNiADd+OIoyU6gXJQsrzCwM
X-Google-Smtp-Source: AGHT+IHlFVxr5zkaRfw2DOyo7XDcQNlbMyDdVec8aX5LzzNWMDYfM7aa0GQ0k+Ct91dsFVc5t0tkCA==
X-Received: by 2002:a05:6830:2a90:b0:735:bab9:c5c1 with SMTP id 46e09a7af769-74088abe8a6mr2512656a34.22.1753280979582;
        Wed, 23 Jul 2025 07:29:39 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:11dd:c0f5:968d:e96? ([2600:8803:e7e4:1d00:11dd:c0f5:968d:e96])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e8fc51467sm3447840a34.31.2025.07.23.07.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 07:29:39 -0700 (PDT)
Message-ID: <795dffe0-51cf-49a8-bbb1-1585edddf5ba@baylibre.com>
Date: Wed, 23 Jul 2025 09:29:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: proximity: hx9023s: fix scan_type endianness
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Yasin Lee <yasin.lee.x@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250722-iio-proximity-hx9023c-fix-scan_type-endianness-v1-1-48f5dc156895@baylibre.com>
 <823a28d6-e612-4e32-976a-cb99945848ce@baylibre.com>
 <aIDuEcHhaGtz2klP@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aIDuEcHhaGtz2klP@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/25 9:13 AM, Andy Shevchenko wrote:
> On Tue, Jul 22, 2025 at 06:08:37PM -0500, David Lechner wrote:
>> On 7/22/25 6:07 PM, David Lechner wrote:
>>> Change the scan_type endianness from IIO_BE to IIO_LE. This matches
>>> the call to cpu_to_le16() in hx9023s_trigger_handler() that formats
>>> the data before pushing it to the IIO buffer.
> 
>> It is odd to have data already in CPU-endian and convert it to LE
>> before pushing to buffers. So I'm a bit tempted to do this instead
>> since it probably isn't likely anyone is using this on a big-endian
>> system:
> 
> I can say that first of all, we need to consult with the datasheet for the
> actual HW endianess. And second, I do not believe that CPU endianess may be
> used, 

Why not? Lot's of IIO drivers use IIO_CPU in their scan buffers.

> I can't imagine when this (discrete?) component can be integrated in such
> a way. That said, I think your second approach even worse.
> 

hx9023s_sample() is calling get_unaligned_le16() on all of the data
read over the bus, so in the driver, all data is stored CPU-endian
already rather than passing actual raw bus data to the buffer.

So it seems a waste of CPU cycles to convert it back to little-endian
to push to the buffer only for consumers to have to convert it back
to CPU-endian again. But since most systems are little-endian already
this doesn't really matter since no actual conversion is done in this
case.




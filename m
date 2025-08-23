Return-Path: <linux-kernel+bounces-783178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C658B32A74
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50483B4D01
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C102EB861;
	Sat, 23 Aug 2025 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FZEHH0DZ"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ACE2EB5CD
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964998; cv=none; b=snadtpxfb65RPqNLuUS71ism45Cokq5UVC3qokMl9WCoZfeczkUxtNCo2mCg1Vx6bOW/KDJGWEKPBH78v7u+YVpbbLzVkvCp6zzNPbP4zsG0ojkQsmA9ClKO68+NUmY+qBiTBTauuVZ/My4EQ83JOUfoJ+HYCFiURGgn7mAkt+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964998; c=relaxed/simple;
	bh=bua1tPQwfQWa+hvfw1onqoeCC8jdTz/SIM8NGi2GfA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GyhpTQpdTfRQA7edl4ogRUJ8DUGekedGKoWSjmUNXzbTqkEyK+eC6pH3rpVQgmKVIK59KZ+8TI9jggx5qMpYX7meW7CJThBD42GWKzEEUjJ1yB00Ak1T9/pW1nEnmll0nC2RGmT4jofa3z2CrLS4IIFB2yWqkw99JqxJ1tU+tTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FZEHH0DZ; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-435de70ed23so1750047b6e.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 09:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755964994; x=1756569794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f15oMbDITgq7oB6xJ/vYq6N1D3lMcONr/Su4wF27UoA=;
        b=FZEHH0DZh51EF7Rkn4sF5+t9zG/nrnwUt9qEbMI3mp7Vu0Q/AdoRr5GJblL5Z4KjLn
         hMhG4Pp3LKTfoiH4Ynrjyk3URoRWKEXTQH9gweWupUN+UixwUlIXO7uerkk8/PyNCPA9
         M7snZxuhquuf29LkdX64ZBLdAFbfVx0od+RTSB154Vr1OWGV6MaKLxq0BlRZufdILBtV
         JXuMRf+RBJSj+0FwkHeEGIcVeUb4nY2tfm7hsW0tk3bDIraxl4VcKDYS/sZKWcjtePH8
         pAIyBJHOlcSI8SgTr7sNbMOv/PVRy7QyWwUAxj48ouXTw2MVAeJ4pzed0bMnz+Iszn1+
         PZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755964994; x=1756569794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f15oMbDITgq7oB6xJ/vYq6N1D3lMcONr/Su4wF27UoA=;
        b=MfD5vci5Ajm3cfrroewmWJqfSpJtcUlA+UM0FdWx2sVXB6m1tVrS05rFUmwfm/uX6i
         Tdrxuaz4WDKZPftdqnW92KLmYILNTkP9nZeQ/QR5RCAlHmAK2rcVytjAz0FbSH6ZNr8P
         7Aoc5qnhfCMyjorYYZ/n8rnTn5p++lHhG0OnMH+uy0KnhJHXoc2rYHFbPZHIJsd6cNfi
         G9EK9sMqCSiUKBlZ6h97LE77DYl3ipH6BZvzABOYTzGOGrwG5oVYoJhS0wjwsVoBNq+8
         NTxJo0e5wuaXEGNIeze1vpvypVBxh9WYAxV4gWNuDPzq6OdeWLLbqts4C8m0O6zB7xkq
         Mi7w==
X-Forwarded-Encrypted: i=1; AJvYcCV0ttwscYWFpZHrxsHKKNHVrh8hfnsBsS1ID53+7gW2K9mTjakqoHhUQiRHTKMRdAIreLcvIcRaeAXjIUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTkNs+ha2/fLVC+qTVKa1zL6ZkPvrOKknBNq5mwsxX9OatfM1X
	ODyoKSkP5eoQG78RbrI8MPaAo+4xOU1TP8bpBrBKpS8+KLmoAAffr9vEfY07RXYWENM=
X-Gm-Gg: ASbGnctVhPeLy8nYxK29iTcHHNuzEuJA9o7f/yzzNW62d+tIUgytX5n6pHCVgXQ41RJ
	eEv62NddOy66/uaA84XD6DdBjpfyAGLzVRMmPB6LPfmMUQXVqUG/FAnY5z8NvzJMUnSOX9/gSSq
	P84H5YfeMkrppXI0bPkYjWXM7bta3Z35kSSdR1fisPW0XNB7ue6OkHjB9tZtuCFAGSHBSskzo3y
	xUfxddlN9FcbySHqh8samu2h6lpnXQMBnxWwScf5HR/5vA+cHej5UkeaPiift7MnzyYbQYuRxhM
	RUTY1a1j3MXKTeBtxLmeCweg1uTDlRvmNAbF/emv0oCgVIx4N91IYjHlkHzLG1HXyblAr8lddRm
	0TWD3Oyvz1cZD1S30kZBeWAFpB3RMo65lodBXRKgC1SFWzwLi/8Sh6R99Ogvm4OTyYQqjWtXdMD
	wa6rPQ9Ao=
X-Google-Smtp-Source: AGHT+IF5S5n10x8t6fzxv7W+hQlkYBgQ5KnbdgnfR/wPKi0MkIYRDyZabVifnoN80ZoF4puOCUaYzg==
X-Received: by 2002:a05:6808:1a01:b0:434:aadd:727b with SMTP id 5614622812f47-437851dc733mr3895334b6e.20.1755964994112;
        Sat, 23 Aug 2025 09:03:14 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4d25:af10:67ec:53d? ([2600:8803:e7e4:1d00:4d25:af10:67ec:53d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-437967bf1bbsm405969b6e.7.2025.08.23.09.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Aug 2025 09:03:13 -0700 (PDT)
Message-ID: <1c0fe63a-e13b-4e01-9032-686298d3b632@baylibre.com>
Date: Sat, 23 Aug 2025 11:03:12 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: ltr390: Add runtime PM support
To: Akshay Jindal <akshayaj.lkd@gmail.com>, anshulusr@gmail.com,
 jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org
Cc: shuah@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250822180335.362979-1-akshayaj.lkd@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250822180335.362979-1-akshayaj.lkd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/22/25 1:03 PM, Akshay Jindal wrote:
> Implement runtime power management for the LTR390 sensor.
> The device would now autosuspend after 1s of idle time.
> This would save the overall power consumption by the sensor.

How much power does it actually save?

> 
> Ensure that interrupts continue to be delivered during
> runtime suspend by disabling the sensor only when no
> interrupts are enabled. This prevents loss of events
> while still allowing power savings when IRQs are unused.
> 
> Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
> ---
> 
> Testing summary:
> ================
> -> Tested on Raspberrypi 4B. Following tests were performed.
> 1. Verified that /sys/bus/i2c/devices/i2c-1/1-0053/power/control contains ‘auto’ value.
> 2. Verified the /sys/bus/i2c/devices/i2c-1/1-0053/power/autosuspend_delay_ms contains 1000 which is assigned by the driver.
> 3. Changed the autosuspend_delay_ms value from 1000 to 2000ms and verified it.
> 	3.1 Verified through the timestamp that whatever autosuspend_delay_ms is set, it is being honoured.
> 4. Verified that runtime_suspend and runtime_resume callbacks are called whenever any IO is done on a channel attribute.
> 	4.1 Verified that power/runtime_status first becomes active and then becomes suspended.
> 	4.2 Verified that power/runtime_active_time keeps on increasing with a delta of autosuspend_delay_ms.
> 
> Interrupt Handling Verification:
> --------------------------------
> 1. Verified that when interrupts are enabled on the device, then the device does not get put in standby mode and keeps sampling.
> 	a. As a result interrupts are delivered to the driver and are handled.
> 2. Verified that when interrupts are disabled, the device is put in standby mode and stops sampling.
> 	a.Since there is no sampling, so no IRQs will be generated. They are only generated when the device is resumed due to I/O on some sysfs attribute from userspace.
> 
>  drivers/iio/light/ltr390.c | 246 +++++++++++++++++++++++++++++--------
>  1 file changed, 193 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> index 2e1cf62e8201..9e2f33a401f2 100644
> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -30,6 +30,7 @@
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/events.h>
> +#include <linux/pm_runtime.h>
>  
>  #include <linux/unaligned.h>
>  
> @@ -105,6 +106,7 @@ struct ltr390_data {
>  	enum ltr390_mode mode;
>  	int gain;
>  	int int_time_us;
> +	bool irq_enabled;
>  };
>  
>  static const struct regmap_range ltr390_readable_reg_ranges[] = {
> @@ -154,6 +156,25 @@ static const int ltr390_samp_freq_table[][2] = {
>  		[7] = { 500, 2000 },
>  };
>  
> +static int ltr390_set_power_state(struct ltr390_data *data, bool on)

This function does completely different things depending on if the
last argument is true or false. It should just be two separate
functions and avoid the parameter and the if statement.

> +{
> +	struct device *dev = &data->client->dev;
> +	int ret = 0;
> +
> +	if (on) {
> +		ret = pm_runtime_resume_and_get(dev);
> +		if (ret) {
> +			dev_err(dev, "failed to resume runtime PM: %d\n", ret);
> +			return ret;
> +		}
> +	} else {
> +		pm_runtime_mark_last_busy(dev);
> +		pm_runtime_put_autosuspend(dev);
> +	}
> +
> +	return ret;
> +}
> +


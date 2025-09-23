Return-Path: <linux-kernel+bounces-829295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E937B96B62
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA65F19C65F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBBD246BB4;
	Tue, 23 Sep 2025 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="D32UbrOj"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617C6257437
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643439; cv=none; b=Er8ouI1zaq4G04AvbaVZJzv8NZNOLJf7SgSW5nqTWPwrfOEMYjXYjD4F5jabmLF2pqVM+NOYRkCa9ezSq4PzBOONFe4lzJeR1/9t3cQTyKflCE5q8CAd46oTqi0wjMwvysu6A9u+kSV2fuQYXX6kdQ9WA0arBTKQ68rI7RuqkPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643439; c=relaxed/simple;
	bh=VxXxBVnPT3bjBJlGNuKjLv1N/mqpt8+iHvovsX2ivRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pI1nYXkzhnQ7ulG9RETdWEF3IYYAY2HtD5CUJIZFmnPVG6jO3Jw5L3x00BqoJVHCdwiiSnyfpyLAGkwR84JjiTU3TSFdsCiJV1CsiPP/A8jAAMG4tL6QUZ/CVaPXU4f0LoBJYtfaTVPtTnncpy8M7oUA7MBS6z6vJK9PViJpkqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=D32UbrOj; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7851b646dcfso2173542a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758643436; x=1759248236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=law/k3CtXNu6hM9p5KpraV1Cz+DWuIPBGWWxReZ36Yo=;
        b=D32UbrOjk4gKhJX/uZLTgtT6sT1LMZp+IB5oht8sJ8bIizbvM0zgeC6N95iINwsPMk
         E4yt738kYwmHVWl4yVQMi3pi8GdkoWQYs4xLf2+Xfb8keOFhZVI1l5IlX1vqe9Puqpvf
         /69Le/ivN0oLIL2CRFyeB5yEAYfh9zrqU7UiUVA6FICnlGjuWwSc25So17GRe/PACDGT
         SI8rFu7qKCm4Tmo3Qhtt5KVReD3Fm6MpaxW80B8P/5vwLpvXNqh5JjRnGUANxruyxJK1
         S/5Q0AIf/5BvQ60+J1inv0NOReuHccF+ywiDc7rxQGAX++NBvzCALm+/uXDJeO8aoiAO
         UHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643436; x=1759248236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=law/k3CtXNu6hM9p5KpraV1Cz+DWuIPBGWWxReZ36Yo=;
        b=KRWogG2Wls5VXXucHAo6fZpBqHC+r7uiXoKQf3/9mMJf90Zui7d6D9T9StRwUTfvEi
         knmPNvwKhY1r5esYjm9Ien2XX5IpTLUv5KBxFXm7Ib9XWwvqJ3tui9Rmo1jPhEwih0Ge
         TaAuejxTE9dy3tU622hAjjhz/5fcZ12/isnsUulfDCfW/W/SS9Itzij1yIhTVVvrFUyI
         CIUpG7EqsV8Jl6uW/yLPYYVs3uGvIF5jRitB44Ygc2DrrFptpI0iAyhIB7qWNLTwrnt4
         Ce2c6WyI8N7WAJo7B9pBDz6M0IEis4uNeiNtTJj3zpQxaGOiHLSbdx27OWI7tkbyxQV/
         Okww==
X-Forwarded-Encrypted: i=1; AJvYcCV/1r6t442nQaecfrl4sl1dPGeDPSfkg8bfTYicCX4V0qRoVvLKjGslDjd5MccpcsadYwYL99HsXXmO2GU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwxuU+t228RXGZs0LzF9J6QKRlt3wLmmnEc3c07EQ9+5Z9fmc/
	N6FhUroMzAdfTcqKX0Y7yNe7zUZxXAwyAgdTzlwx9qV0PTwXtIoqNM0gPZBEBurch7s=
X-Gm-Gg: ASbGncujrbpMO7DJF9DANdAZUtohvbmXb8bUGAhh6bXeIGRG2HKooUWS2+0tcZwADHC
	GuACO7lIfie3epNgntoXZxp5tWL/9G3r8T/qvlcvcv+8c3Sa7fuam8gHj038QNwhJHpXa9g4mjR
	cRc1zuk3i/5HYS6iDKCs//jmjQaw07HOrCip3q5a5299rHaplQshfk2X6ra0bl9Z8tkxU7wj+WU
	ok+hn0lNzShGtzdYzD3n00OBs6Q3eBUi1P37wChRUi3AdqskczF8UW65l/hl8YH8xcO33jish7r
	mlpM/DkWJFQ3ZHquW+DTWzfWQZUEUz7DKaFTCCSc35zDYu9iuAxFnCsASOqGBgJ1benhii1ALsU
	Wr7JdpthgVP4jNperOB1bXgLWIXLGme69NlReln4UCPiZGmJ9s7/0iyJT9mbCdXfUz819Yym1mA
	8=
X-Google-Smtp-Source: AGHT+IGt+WO07cHyo0KGdsHsWGQNVNTID6bqFPImBKjJW+ieTZFVbQ/jTnDS2WSIykEd8QxgZNu6gQ==
X-Received: by 2002:a05:6808:3319:b0:43f:18a2:97ae with SMTP id 5614622812f47-43f2d494e3emr1476355b6e.30.1758643436230;
        Tue, 23 Sep 2025 09:03:56 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:505f:96cd:1359:fff4? ([2600:8803:e7e4:1d00:505f:96cd:1359:fff4])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43d5c67bbdcsm5948711b6e.7.2025.09.23.09.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 09:03:55 -0700 (PDT)
Message-ID: <21b52acb-9710-4363-803e-280773da0351@baylibre.com>
Date: Tue, 23 Sep 2025 11:03:54 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] iio: adc: ad4030: Add SPI offload support
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org,
 michael.hennerich@analog.com, nuno.sa@analog.com, eblanc@baylibre.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 corbet@lwn.net, Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Axel Haslam <ahaslam@baylibre.com>
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
 <da55c0ed6fe895dc84e79c8b64e5923a4851e58f.1758214628.git.marcelo.schmitt@analog.com>
 <30659b16-290d-4ae5-a644-214c106bbe87@baylibre.com>
 <aNK8ZZu74mK0_ygB@debian-BULLSEYE-live-builder-AMD64>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aNK8ZZu74mK0_ygB@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/25 10:27 AM, Marcelo Schmitt wrote:
> Hi David, thanks for the insightful review.
> 
> On 09/22, David Lechner wrote:
>> On 9/18/25 12:39 PM, Marcelo Schmitt wrote:

...

>>> +	cnv_wf.period_length_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq);
>>> +	/*
>>> +	 * The datasheet lists a minimum time of 9.8 ns, but no maximum. If the
>>> +	 * rounded PWM's value is less than 10, increase the target value by 10
>>> +	 * and attempt to round the waveform again, until the value is at least
>>> +	 * 10 ns. Use a separate variable to represent the target in case the
>>> +	 * rounding is severe enough to keep putting the first few results under
>>> +	 * the minimum 10ns condition checked by the while loop.
>>> +	 */
>>> +	do {
>>> +		cnv_wf.duty_length_ns = target;
>>> +		ret = pwm_round_waveform_might_sleep(st->cnv_trigger, &cnv_wf);
>>> +		if (ret)
>>> +			return ret;
>>> +		target += AD4030_TCNVH_NS;
>>> +	} while (cnv_wf.duty_length_ns < AD4030_TCNVH_NS);
>>> +
>>> +	if (!in_range(cnv_wf.period_length_ns, AD4030_TCYC_NS, INT_MAX))
>>> +		return -EINVAL;
>>
>> I hit this error during testing with the default max_sample_rate_hz assigned
>> in probe. We could have a loop for this too to try to get the closest valid
>> period rather than erroring if the exact value isn't available.
>>
> Yes, this makes sense. Though, looping to try to get a suitable period wouldn't
> potentially also change the duty_length we settled above?

I didn't think too hard about it or debug too deep. So it might be fine the
way it is. We'll just want to make sure that when testing with a 2 MSPS part
that we can get the max sample rate without error. The ZedBoard has some funny
rounding due to clocks being divided by 3, so it could just be a case of
having to to put in 1.998 MHz to actually get 2 MHz or something like
that because of the lack of accuracy due to rounding.

> 
>>> +
>>> +	offload_period_ns = cnv_wf.period_length_ns;
>>> +	if (st->mode == AD4030_OUT_DATA_MD_30_AVERAGED_DIFF)
>>
> ...
>>> +static int ad4030_set_sampling_freq(struct iio_dev *indio_dev, int freq)
>>> +{
>>> +	struct ad4030_state *st = iio_priv(indio_dev);
>>> +
>>> +	/*
>>> +	 * We have no control over the sampling frequency without SPI offload
>>> +	 * triggering.
>>> +	 */
>>> +	if (!st->offload_trigger)
>>> +		return -ENODEV;
>>> +
>>> +	if (!in_range(freq, 1, st->chip->max_sample_rate_hz))
>>> +		return -EINVAL;
>>> +
>>> +	guard(mutex)(&st->lock);
>>
>> Why not iio_device_claim_direct() instead of a new lock? We wouldn't
>> want to change the sampling frequency during a buffered read anyway.
>> This driver already uses iio_device_claim_direct() to protect other
>> register access.
> 
> The new lock is to protect concurrent updates of the oversampling and sampling
> frequency. Since, oversampling and the sampling frequency properties are
> mutually dependent one from another, a simultaneous write to those attributes
> could lead to an invalid oversamp + samp freq configuration.

I understand the need for the protection. And using iio_device_claim_direct()
seems like it could do the job without the need for an additional lock.



Return-Path: <linux-kernel+bounces-800973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D63B43E5B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F6F3AD3F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2E7281509;
	Thu,  4 Sep 2025 14:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lqwssEzK"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851551C7015
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995324; cv=none; b=DFWUI7UAixSScls/87msiLRG3X3rvJdBKESkK13GXwENRK+3GIHyRxIO4OYS+5fNEhXd8ACjPgPZs2K97JkI9c8AWSgtFUi+pyyxWc8L+4bm63egdvWqDuPJCGMwplr0gJgWBzhKt/trzOsicsIu0Txwh9sw/mBWtmHWfFbUJAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995324; c=relaxed/simple;
	bh=JUVIhjsLdfiCVR7aTSBrg6qWnvr8Z1sIuOVbEZ1Yyj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPq6MqWk0ZYGbkvOF7XXN9H+e3djjqhmujb7dNdKbXxjwI/bKa+TeSnn7POBNnh2NQTigj2mGdXn5K/CHgI8aw9sQJfYD/OcNl1hKVzWf+PnAh2FMSRNlZfwu+UVGqR1D/e7nE5eIq8QyDqZK15Jyj3+fSYzlBq+X7T5jFi0m6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lqwssEzK; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-31d6aa3e73fso730879fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 07:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756995320; x=1757600120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4anAvI6zTkpm38DA6jxPpN7MX7YPUcpKLf5CSNRTAAY=;
        b=lqwssEzKVna+NjfwQNVLyWW/JMI9KBRDDNy6zcLgkzdWZW+Av4pLeunyajGWBza2IJ
         I+HLZ9zrDRPXeDRFPBTBnjGhUe3b2CA4KSn1ogEBskQkFQbvm93hCPd2d+lDIE92+jS9
         ky0Ivqye9k1Ju+CKmZnmborzsWaP0KC+SbvgTo0+PdpJG0sMHyUuNBGMZeitg4d9LKzq
         CrriTLvkREk9jfM2gsxTasT0SBCn4FbFEbYBAHtmysBihgpv886jLLPvt2xQFplOoHgH
         1CDVqgxeXhfw85CGNVHlKSVhgHfBVnd1IjS4jiz3ViikzXgc9Eb19omt4mUr4tKkMw7N
         wmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756995320; x=1757600120;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4anAvI6zTkpm38DA6jxPpN7MX7YPUcpKLf5CSNRTAAY=;
        b=Nc5Aw0OyIQbAqudrNhYw1Cv8F3nCAJXtOhvYsMPsaWfWZQPPSVLYi2vbKjo/6SxeyH
         TGuW7z910yYpAJQ32AxrWaOnnYos6UF3AHV+ISMR3VfWObqwlg9J+YAhBlj0Oom3ugRN
         ygs6L8KDhojNrza6fOgBwe7rKUHPqH3Wjf0UE/4yKUYTAjeuVDNf+UI39IxFdtRklH+l
         bmLybaYaAFhSLfk7ya2GagWoVS37AOsFxXZ2NA3YQjHkJh4PCzDwEt0XqFrWpPRuhVNy
         TQ9pjBFkjs+wfKTWEi99sJUN46giQPsxwtLqLbxCRkey548xshEFP7moehZmil88nQWe
         53nA==
X-Forwarded-Encrypted: i=1; AJvYcCXSo7PhSP3Q0XtjRueGgz990nHJ27GQW8YwHSCsaeSrVqogCQ4G8+A5Kg8vVb10ZflW8ufrteJ9rZPbxGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0itOYBGYEa/VUGtpMAtbw5lY9SrXYlN8fVAxuVd8mGT1TWQNC
	7OV5g+qjg0wuErEOZpC3An/j1M1+keExJo8mUwq7sdMwsGcrSBeql/n4Z67V+bgsCf0=
X-Gm-Gg: ASbGncv8CKwQEiKMW0kNQ5XGytlKT8qwvH/Xk9bv3EYn8j3NSxB9NKIR+Q8iqdPEuKa
	MgKABTd8mOFggzfixG0v4GO0+UwLnx45jlY+uJ/iZQ5UE/kZ4TOLT8N5Q+0+16A7h/vvDhAGYPf
	Spsiy8RRs2idBLDZYEZS0AweMdZhh/svUncQewa9lT3EwLbgAMMOjXkgXGmPsdKvKGDuDCljl4m
	qT73GqndM54o4Xyq2iEeYNzUd3FG9T77kSOh73MtHJLBb1aYHACMw8P0KE7RRNbVJnWsmZ+cUto
	plmCMNYsOwKM390+WrmFO9fP18Q4X/txrNEIbD382qi12f+aNMYd0KKdu1hEMoHWReJ2MPaWAKl
	k6gqIkTFgITwlwhoN7N0DzCIOJjzP+aNu2adSjBpPNA6PU8dBcL//ioFVj54Fk2kYJbhjnhK40D
	o=
X-Google-Smtp-Source: AGHT+IGRYO6SnExFlsmIJCjeNxDbRtF2TQVIicSprf2/RUZ5NXsJCPkFpy0op4VxPZC8Wzpgm0M8Kg==
X-Received: by 2002:a05:6870:1582:b0:315:60a6:c28f with SMTP id 586e51a60fabf-31963098d63mr10467732fac.3.1756995320259;
        Thu, 04 Sep 2025 07:15:20 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a178:aa1c:68f0:444a? ([2600:8803:e7e4:1d00:a178:aa1c:68f0:444a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-745743b393dsm3113630a34.35.2025.09.04.07.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 07:15:19 -0700 (PDT)
Message-ID: <0a64efe5-9b07-4188-be30-54f268e862bf@baylibre.com>
Date: Thu, 4 Sep 2025 09:15:19 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7124: fix sample rate for multi-channel use
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250828-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v1-1-f8d4c920a699@baylibre.com>
 <20250901165751.305d0a68@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250901165751.305d0a68@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 10:57 AM, Jonathan Cameron wrote:
> On Thu, 28 Aug 2025 11:42:28 -0500
> David Lechner <dlechner@baylibre.com> wrote:

...

>> @@ -261,8 +263,12 @@ static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel
>>  	 * fCLK is the master clock frequency
>>  	 * FS[10:0] are the bits in the filter register
>>  	 * FS[10:0] can have a value from 1 to 2047
>> +	 * When multiple channels in the sequencer or the SINGLE_CYCLE bit is
> This sentence doesn't read. Maybe something with a few more words like.
> 
> 	 * When multiple channels are enabled in the sequencer, the
> 	 * SINGLE_CYCLE bit is set or when certain filter modes are enabled,...
> 
>> +	 * or when certain filter modes are enabled, there is an extra factor
>> +	 * of (4 + AVG - 1) to allow for settling time.

	 * When multiple channels are enabled in the sequencer, the SINGLE_CYCLE
	 * bit is set, or when a fast settling filter mode is enabled on any
	 * channel, there is an extra factor of (4 + AVG - 1) to allow for
	 * settling time. We ensure that at least one of these is always true so
	 * that we always use the same factor.

>>  	 */
>> -	odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * 32);
>> +	factor = 32 * (4 + avg - 1);
>> +	odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * factor);
> 
> 



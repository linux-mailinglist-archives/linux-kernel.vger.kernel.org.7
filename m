Return-Path: <linux-kernel+bounces-732195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2F3B0634A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863EC580740
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E185C24DD0C;
	Tue, 15 Jul 2025 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DnRwDJci"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DED23D2AC
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594144; cv=none; b=YnltEwmum62cr5G8fTroomslNxJFXGOttEzOw3VEr/WQ1NGWEgxtSXdiqjsd/pWOY/7HwEYHFOFeLnqxoKn7fNk8Cr3PWFI5Arx9F6MdfwW4/8EcpCj89WMjejvyOOiGojbb2F7ckO9cdVX/K0tt0EOeZHCcl3fnVzHlt6WHOZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594144; c=relaxed/simple;
	bh=Jp3TuuGMZISVt3scjRGWZV8TmBbV3ZwXzJUvPlSzNpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VPVqiPORSeYGRCaz3qlsuxn90tmMTsKo40O5SGfPd5Qg4HEPR5v4zlQabSlWbs+J9Q9sFZYhhcFuRiJ+vsAYKaxgeQc8E1Wv7MPmtUr/X3kbzg/66fTIm9s5vR7Fbz1S6E3ePOZ3tnwbs21yoUiuquI0p4UZz3OKZwcOeoxKHYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DnRwDJci; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8bb7d291-f94a-4e96-b3ec-93fbe06c8407@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752594130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Lm0K2qK8xC11GFjw87GrG0UT9zm3jP9M0ojmtC5alg=;
	b=DnRwDJcixhgIJ+WYj2NEwDVVBoXGyPaRSXv3Va9pn2GCI0w9PWzwveXc+Q0qwzRP5Vl0gM
	2v2T5uYuEccTk/x70zR1ULQv+cH3cUK3HOF5Rj1ZqxJpC5vGLivwPWeAgtMaWyaZsnXZJQ
	sna7WBlDK+hsZb6gQgmMzx01Jd9XAvo=
Date: Tue, 15 Jul 2025 11:42:05 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/7] iio: inkern: Add API for reading/writing events
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-3-sean.anderson@linux.dev>
 <aHYOuzdQ_jSKA898@smile.fi.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <aHYOuzdQ_jSKA898@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/15/25 04:18, Andy Shevchenko wrote:
> On Mon, Jul 14, 2025 at 09:20:18PM -0400, Sean Anderson wrote:
>> Add an in-kernel API for reading/writing event properties. Like the
>> raw-to-processed conversion, with processed-to-raw we only convert the
>> integer part, introducing some round-off error.
>> 
>> A common case is for other drivers to re-expose IIO events as sysfs
>> properties with a different API. To help out with this, iio_event_mode
>> returns the appropriate mode. It can also be used to test for existence
>> if the consumer doesn't care about read/write capability.
> 
> ...
> 
>> +EXPORT_SYMBOL_GPL(iio_event_mode);
> 
> Can we move this to namespace? Otherwise it will be never ending story...
> Ditto for other new APIs.

Never ending story of what?

> ...
> 
>> +			if (scale64 <= INT_MAX && scale64 >= INT_MIN)
>> +				raw64 = processed / (int)scale64;
> 
> Do you need the casting? (I mean if the compiler is dumb enough to not see this)

AIUI 64-bit division is not available on 32-bit platforms. The cast
ensures we get 32-bit division.

> ...
> 
>> +		case IIO_VAL_INT_PLUS_MICRO:
>> +			scale64 = scale_val * scale * 1000000LL + scale_val2;
>> +			raw64 = div64_s64_rem(processed, scale64, &r);
>> +			raw64 = raw64 * 1000000 +
>> +				div64_s64(r * 1000000, scale64);
> 
> Logically this should be 1000000L, but can we somehow use the constants?
> Like
> 
> 			scale64 = (s64)MICRO * scale_val * scale + scale_val2;
> 			raw64 = div64_s64_rem(processed, scale64, &r);
> 			raw64 = raw64 * (s32)MICRO +
> 				div64_s64(r * (s64)MICRO, scale64);
> 

This follows iio_convert_raw_to_processed_unlocked but ok...

>> +			break;
> 
> Ditto for other cases?
> 
> ...
> 
>> +	*raw = clamp(raw64, (s64)INT_MIN, (s64)INT_MAX);
> 
> You already have similar approach here...

Well, I can spell it 0x7fffffffLL if you'd like...

>> +	ret = iio_convert_processed_to_raw_unlocked(chan, processed, &raw,
>> +						    scale);
>> +	if (ret < 0)
> 
> Why ' < 0' ?

Originally I returned IIO_VAL_INT but later decided against it.

--Sean


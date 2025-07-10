Return-Path: <linux-kernel+bounces-726540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F944B00E6C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 950DD7BC245
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6315293C57;
	Thu, 10 Jul 2025 22:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0Brg2Gko"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A2528C036
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 22:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752185019; cv=none; b=kAnrAGgsH/ZqmIvJpEFffj3Rdz1iIpeNq19BMAE0s9oourBcwxunkOMgQDaJqK6cUzbxRKeSe25W/QW/0lJP3AVjoH/El5rYhtdombG4mn8zQ+G4oOCpoA+V3eEkUR5ipa4KNoSo0MHGargkSk4Y4tmZgZMyQZhQ1Xw9a5mA4wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752185019; c=relaxed/simple;
	bh=GBGFOa3OG0bj7emHNsuxL3vym81UWq+35MLYq0J6UwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FF/6+7BJtn8CBChx4+I17V/arTNebL8G0GJYeoy42XbhurR6UMnJ4qsp5iu2prhIS7LQf7irvBteP9+hySFHJOLB4Y38EDeDfkO5HhPV/MRQe7MTcX2DzE6sIlguHw8dAdQC+4wSgII0bEHvHhuJ47i2XI0vsMCL/hrp753+SrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0Brg2Gko; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-61396c3f681so450678eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752185016; x=1752789816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9izK7SdU2Zvx1a/5FWB+N7ETLSUOq+w/2KQJDcsSTjI=;
        b=0Brg2GkouhovksBn0FMuw1GLVrlcwjw7QNsGCWpbEjXNt6Ww/7sCdWE3gN51sYe13T
         s7USSqnGhoS/ezRN7p9GOJ6n/yFUKbN57iQukt94ZuCE6RIM+Nn7SzmnYrBVDgrhBG/q
         3TrVx5Vgq+z8wiwPPrUr7xFwVNXtiyvAMH8x0PVx4mnc4eeo0ZluYfH20LRkB91yJsam
         KE+8coJjmCx9hZdW3QmEsaPXOvPrMNj2+9xdNVZGV7Fq79InYR/qOLeEO8k/dbv12P3m
         +TD6OPSLefgMm5NyfoSqy+2vfj0cd4o85gcDmrkNexpj8k6IbMDZy10vuUS0WJn0Aiv+
         kaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752185016; x=1752789816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9izK7SdU2Zvx1a/5FWB+N7ETLSUOq+w/2KQJDcsSTjI=;
        b=KsND1PPOhh1MEh7Aw4vLfyYUX0QMeVO5bjmtFd5YEG5pfSsx5VTkW2pqYkyGCqH8fU
         s2fkMqxMyKEtGiizTXSB/o5EZcNNrgMH4e8XHEXMd08a52iBeKu+pxeQPtbEaZc7i8bB
         FW0JNX52P9zEYGVDq7uunjQiellfJ4F/mALhR8N9w+qDKrwGPVKrAswxGK4p9tcS7oH2
         BDlrlHGdudPNkUDzqxPXeMS5DsPQE9SOXllhlC/DQDD5g1znhZ+fnO66ZRIbEyJFdqRc
         leea6RgP/XsEgtIC+NFDTDwOQ/gMYyUJjR7E6GEHybMLQIGnJHmR6gjhsAVn4LhesGms
         rmCA==
X-Forwarded-Encrypted: i=1; AJvYcCULzlz9yYm7S7v96i0HD8MOLUjhnXUFZHQcjLYXXKkWreNlFMl2xM8e/gzqvx3NeFF0qm9HGJHDGNxU59o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXTJzvPgAHWvSPMmjVX1rKLrPObWMaDxqvUS4/jayxGbomrYUI
	29W0UcFHG8iYGlVFp/EpVaCvKEohqcyQObyDPkMI4ARELV18To0zTYd7ItKbpaJqj7930E5OQdU
	SDEGQK2s=
X-Gm-Gg: ASbGnctxk6EwvAfKfiRVEDYa4cgnpDUjlsfalnY264mVIy2Hkrowliss0GdevsRel6Z
	Vka9vEY3601xJakvY7vv9jWlwPa0He7b6VInbVuBmM5iK+SwElrwef0eqgx5qjA/rZkPKnHZqFF
	dI1RYgxma4gDscWX5fbFcAHvbUdbkSg6O8qYO0BOvKKGyua7KRGeLD3Bhav/vZ31Qi5G+FakM8Y
	WAzkCQGPAxXYejr8WF6k5jtyaQ4hubwvqO2sNIH8xIEu5d5C58exkPgheJB+9TZG3I/h8heL/bs
	+OO32+eYhxCAZtTgtxJ+agHX8ziAA4FKyFaWaj4o/5NVT+XwrltAxffNiukvIJKj0nn/+QmdJgX
	rzurqatIXMY8NKhLoPBJA0z+sZriRLljphco+Rv0=
X-Google-Smtp-Source: AGHT+IF918+idn8XbuYk1pxJjyhR11cy74s8+fiiK+vUPWZIkXXrlhRZQhgtsrdlFHaUc64rxkaPlA==
X-Received: by 2002:a05:6871:5293:b0:2ef:14cc:caa8 with SMTP id 586e51a60fabf-2ff2683c72bmr674426fac.3.1752185015594;
        Thu, 10 Jul 2025 15:03:35 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:6f38:cf8f:abb1:34f7? ([2600:8803:e7e4:1d00:6f38:cf8f:abb1:34f7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73cf12725d2sm350520a34.32.2025.07.10.15.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 15:03:35 -0700 (PDT)
Message-ID: <8c599d2e-a5bb-46e9-9f6f-781a6933fe1b@baylibre.com>
Date: Thu, 10 Jul 2025 17:03:34 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7313: fix calibration channel
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Guillaume Ranquet
 <granquet@baylibre.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250708-iio-adc-ad7313-fix-calibration-channel-v1-1-e6174e2c7cbf@baylibre.com>
 <75b46712867097cbe7a4e7bf070730d5c524149f.camel@gmail.com>
 <20250709165819.1015259e@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250709165819.1015259e@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/9/25 10:58 AM, Jonathan Cameron wrote:
> On Wed, 09 Jul 2025 10:33:32 +0100
> Nuno Sá <noname.nuno@gmail.com> wrote:
> 
>> On Tue, 2025-07-08 at 20:38 -0500, David Lechner wrote:
>>> Fix the channel index values passed to ad_sd_calibrate() in
>>> ad7173_calibrate_all().
>>>
>>> ad7173_calibrate_all() expects these values to be that of the CHANNELx
>>> register assigned to the channel, not the datasheet INPUTx number of the
>>> channel. The incorrect values were causing register writes to fail for
>>> some channels because they set the WEN bit that must always be 0 for
>>> register access and set the R/W bit to read instead of write. For other
>>> channels, the channel number was just wrong because the CHANNELx
>>> registers are generally assigned in reverse order and so almost never
>>> match the INPUTx numbers.
>>>
>>> Fixes: 031bdc8aee01 ("iio: adc: ad7173: add calibration support")
>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>> ---  
>>
>> Reviewed-by: Nuno Sá <nuno.sa@analog.com>
>>
> Applied to the fixes-togreg branch of iio.git.
> 
Just noticed a typo in the subject. Should be ad7173, not ad7313.


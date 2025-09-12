Return-Path: <linux-kernel+bounces-814258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1A9B5519B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37BADB62D40
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE6431B806;
	Fri, 12 Sep 2025 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3Iq82o9s"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08894309EEC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687271; cv=none; b=QGJS2IcpfJGaRwkwYOqEMR4JLZloCRXtl3Pv6Ju9QGngM06JLN75etqMuCGGh6z2mgvZcb2JCQZcYQXFA/AUqn17/QE0/Sv3pRxILqYHM5gLxvDuUZDvN5Gj3rIC1NQ1pYX9gozV+hE8yjFygfPU0BNqZkwRPdByPF5rT7zE69k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687271; c=relaxed/simple;
	bh=xvKkuDuT4tDgy/UE5wL4JG5idUxNjrx/Cbg6stFEYiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EiRhDcoUBkNi/2KYsS8RODFG9GyhOjzWGue/yJ9WbwVkMng4idQmu3pAe3B+0wlCjYWwiBgUlWqxtRRbnGKcyNMaFGYL+mIRc6PtR/xwz9XVZT/aQnhOpK0nqk4tCOD63SNU/0gBXJ2mHhQ20KQO8WTJU3tRsvmT+U+lDX/v8lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3Iq82o9s; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7459d088020so986639a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757687269; x=1758292069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XeSWmeoO30alM4SGxp8l0P3Dl3Lx3yjW/TdKB75posM=;
        b=3Iq82o9sByUC/sbMyJix0gEF05VP4KB1FEaR3TJSjkQUqj1zfFK1O/oG7UtEQYBw+W
         R9Jwt4lIbo4mcnTbCPpSCZg2yL0ipy8+gcwhRBgILTaOXVT8ADZYbZZTrC2zCHHAOyYC
         OKZuNQUSCWom4FpVfOPWwQQ0TPoDtshyeJl2RouQNwxfX8P07HZCluwC4bevqDhB1UQ0
         oN7FLA/eahGpw+IxN53aDz4ulGm5m5FZcPdGnGCNktrh0+i9toDGpbDsErtPxNk+nopK
         XfhNbTZu0ctAEI6IgmPByZDA+hpS/VvMDM+fKoODnYZpgamjxWyrc1wDZ/U3XaqeX7VT
         8Epw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757687269; x=1758292069;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XeSWmeoO30alM4SGxp8l0P3Dl3Lx3yjW/TdKB75posM=;
        b=JDKx71yGLF4vKOmvknG8hkzBScVtX53ezvBUpa3ZcsW03g6Mafo0Gm3mkS8EioOutU
         /cXXIswn0olc6aI1GoHVMJ4PvDMXwolc8wdJ1Lqd8Xisx1EigR7+6T5R3WwwxAaR4Ubc
         c8wAb6s+RtqYcXHitAyv8hynXd3YYKlKe/tU5unt0kSOBC3yeaBt1m2mfkX1pvRWwVoJ
         lybozwic5O5xipiBctzJoFbTt2tHLzB1AtjU/fjFJUpeJypnA0iUnzDLXm8rrJU2SZQ7
         E4Lh1voT2KANPTaW2slMj6ddn7MH8u85EuaDPBlG/CbFHH9rGyADUX7QHN+UMYMRz3a5
         KP9A==
X-Forwarded-Encrypted: i=1; AJvYcCX29BueutgVEPCum8D650wN+6v1RFOYOiw6yZ+UVUwFyWlCoPVdlKjiUdbMVVawSYuyB90oCT9H52GGDoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Jka8OpgCs5+4r82OQnnddiBiGyvUDyxKI6eCIe/X2Ok2MOlm
	9qfY5dHwPt/ccNVuhTjqxJCQYC0mY+0jiA+YPx2tjUpF4LAf/PSFHeLFJet1acvmb0c=
X-Gm-Gg: ASbGncssQlsPMDteZv43l+/ZdzbX+BVOxnM8dPQTlifNuli0F/IzGo5OsvZ1w7O0GaP
	/3QNqg4aLCwhilt4TNfzcprgIkeSJ5za8zGI/RX1dWRVfhNT3YN2Z3FjA06XV926D5i1LEt8Cjg
	U02LHudsEEaJ5yj1FlB3L8FKHlkAVHtYIoc5QfXlam+IoyF2b3Px1prnZRR8e/dfItvHg0Jdanx
	7azR+nKd9+UkKwzHs7EuLewNBEe9vLp14JUgkAgqVwk+I0oTgfE6QisxO5TUkChNN24Ix/IjyHv
	QMcZImxP8vT/xmLCVwDOdmhTZx5YJoJzJ5JFhXyLB7DlIJB99vbz5aA9forbPrFrInMS8GHpSzS
	UCmLvriHjzvYM/uqYiI4z8we5R28hUPJ86hVt093iLMdISWPOWK4L2l0LaPzFMKsh2E6n9EmQXV
	A=
X-Google-Smtp-Source: AGHT+IEP9sQNrQbQqJFC9+/KQJAwg9aeP94y7Xr+y9MeShoX1peXPBF36a5b54hrq2fEsDH/EtQHEg==
X-Received: by 2002:a05:6830:67c7:b0:74b:3422:f335 with SMTP id 46e09a7af769-753537700a6mr1927270a34.8.1757687269073;
        Fri, 12 Sep 2025 07:27:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1? ([2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524b8a399fsm1025877a34.24.2025.09.12.07.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 07:27:47 -0700 (PDT)
Message-ID: <87245221-c3d0-4026-980d-36562f0b4669@baylibre.com>
Date: Fri, 12 Sep 2025 09:27:47 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] iio: adc: ad7124: add filter support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
 <20250911-iio-adc-ad7124-add-filter-support-v2-5-b09f492416c7@baylibre.com>
 <CAHp75Vf69X4PmGx2c_9KvQwu1opLDyfL0+TyjwX2wTG9bgtMZw@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAHp75Vf69X4PmGx2c_9KvQwu1opLDyfL0+TyjwX2wTG9bgtMZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/11/25 11:49 PM, Andy Shevchenko wrote:
> On Fri, Sep 12, 2025 at 12:43 AM David Lechner <dlechner@baylibre.com> wrote:
>>
>> Add support to the ad7124 driver for selecting the filter type.
>>
>> The filter type has an influence on the effective sampling frequency of
>> each channel. For sinc3+pf{1,2,3,4}, the sampling frequency is fixed.
>> For sinc{3,4} (without post filter), there is a factor of 3 or 4
>> depending on the filter type. For the extra +sinc1, there is an extra
>> averaging factor that depends on the power mode.
>>
>> In order to select the closest sampling frequency for each filter type,
>> we keep a copy of the requested sampling frequency. This way, if the
>> user sets the sampling frequency first and then selects the filter type,
>> the sampling frequency will still be as close as possible to the
>> requested value.
>>
>> Since we always either have the SINGLE_CYCLE bit set or have more than
>> one channel enabled, the sampling frequency is always using the
>> "zero-latency" calculation from the data sheet. This is only documented
>> for the basic sinc{3,4} filters, so the other filter types had to be
>> inferred and confirmed through testing.
>>
>> Since the flat filter type list consists of multiple register fields,
>> the struct ad7124_channel_config::filter_type field is changed to the
>> enum ad7124_filter_type type to avoid nested switch statements in a
>> lot of places.
> 
> ...
> 
>> -       factor = 32 * 4; /* N = 4 for default sinc4 filter. */
>> -       odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * factor +
>> -                                              odr_micro * factor / MICRO);
>> -       odr_sel_bits = clamp(odr_sel_bits, 1, 2047);
>> +       divisor = cfg->requested_odr * factor +
>> +                 cfg->requested_odr_micro * factor / MICRO;
>> +       odr_sel_bits = clamp(DIV_ROUND_CLOSEST(fclk, divisor), 1, 2047);
> 
> I have a déjà vu feeling here. Is this similar code to elsewhere?  Can
> it be factored out to a helper?
> 
> 

It is changing the same code from a previous commit, not duplicating
it. I guess I could have introduced the divisor variable in the
earlier commit and saved some churn.


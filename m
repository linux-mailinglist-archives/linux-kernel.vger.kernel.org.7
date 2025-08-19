Return-Path: <linux-kernel+bounces-775958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FD2B2C6D0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D5FA203BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5440923B62C;
	Tue, 19 Aug 2025 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FnHNivYE"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A7B22157F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612927; cv=none; b=ohUxozWfzrXC1jZ2t3c6z6MQ7TLd21H3KD8VaktSYNEhTxsHZH83u253EhoQpLUaXkg5T0i0WkPYbd70LJpVeuWB2XqDLRF4bHXZykqX9dv2s2CgwFzHWIHJ99iw3PlRW/eldzlKzppws61aD7ny5cYO/OIa24E3byQFOMyE1Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612927; c=relaxed/simple;
	bh=E91A0EvBQGwTzDoV07eJuCoxJjwmCa8uGCWrOxeGhdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pDFmvqAr2SZiZfHaQL/6dtWI2Ij9ye8X8YntQwPalkCKmwgRCK90+dBZYQjL5T4xRX/sUvrMxIAl0CJndI5g76g/LomSL0wrjy/8jN10kO7ivYEb2OK/aQ6aaOtaD1eUazQgdzgmMf4tLUtxHw5Elz095d4SbGnRoL6meA3gDs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FnHNivYE; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-30cce534a91so2014891fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755612925; x=1756217725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6iJgXIyjoxyQaOeBIKWzkn4AAW3hsDkELpNRI4OWlq8=;
        b=FnHNivYE1FDnpTbo8xLF9Off5ZfZUFb294LvL/yvxW/WwTdQRDRhiiJ9+8OfqE8OpT
         Kw38xzrMVZDjUh3uq12WtgOt2BGIOMGFrY5YDFmewjnTY3eaLwPkU5AxO94aZRJifUmo
         UtDL9b2qyGqnrrsrD/BdwmKW/ar92p6xCmuoGa/cNrcEl+OVJRA/hitCW553mptKseVV
         oUymiKFyMIU97+gzeZ7WI5V7L5V+AA++QkwGfzWqYiZqcvVBcTKPlj5qT73iC7218nvt
         fetzBkMJRIcF7qSe58rvJgSwIkxVDxSUs+Y65H3AozZ/B4rCRKXqicJuOVjttyLg5+6I
         GS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755612925; x=1756217725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6iJgXIyjoxyQaOeBIKWzkn4AAW3hsDkELpNRI4OWlq8=;
        b=YaZclH0ielirvx+jYFiV8dfYg20JDaz4TH2ujkrXX5OBabNxPP4THBkAEMoHToq/z1
         GO6EFu8gnbnwQlor+6srtHdwm6L9oagkqMRBINc7ir43DMWrji/g2paJ94nEkMocj8YO
         887PEPl4t/R/FcBxOUKxv+1bpflTn66n3bJd4SQuXkAL/THCwqT3I9UBJUnImB3Kn4yS
         EkB0nQTGCBhw8Pp99ZX/BI1NWIpfVydFLLAb+aiit38jxJRMZrJCoxNCNiFE+qvNe6Wb
         9DMWn+bdEcmtr03teg/OJhjBQc0V5vx8BmdWCBVqJr8xTajUF/lABcT2ADke4M6fM/ev
         zS1w==
X-Forwarded-Encrypted: i=1; AJvYcCUrNwBpTSIDy44CyBIa6Rb/9LDHTHb0LoWx9A2ZETDUD9RBhAJ5AATV3GeUtTpbyyC6qfGsVIAlsJnME0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZHitCSaLWMTuAaU8lZ2Ckhg6zseJHsu/QNQ+h+h+Fw0gTO/aW
	wldrNvgi0jw8BqilA6YMM9QsvsRqfUbr4S8Xl4KiXz8UeJ4A55MtskAxUGk8oi0LzBM=
X-Gm-Gg: ASbGncuEHTk9Z5Ns87GAqJj8jDKxz4FcU2tjFTiQ9vXk6TonYbVPyKBSKbwYTpx4kKv
	MTI+znv4FaEU6JHUnYd4oobbRco4O9oDz9aJYQ2eVnHgAzML0Q0O2ty2cEokx8cC5opntBUOP4U
	93/J74eEB7x8rKU1i7rw5dJ2nSJe6nLjHs8HKmOR3SrBHQRwI1yMhun23+sH8G5FxU9+BNdp9zu
	b/h6oce980w1TE4VG2nc3mqUqqVABRUZUUpt5A3S4j6ZtCm01MVffm2MVaVLfCvEcRANCXLi8XZ
	NdwQ3v/jSuNw9Oo7l6I8P5Jhg3jf6uhZqLobHkoZspVQkpx+vwwKGUbfT7vYlOxTpGz5O9xjaM2
	8+/AxpCJTiw9LHL5V3Je/hJ4m2svaJO7zrqDsSt8o47MYNsxKgrWc6wrEx9UhDvpfys1Fb8xNkY
	akDyfesn6uDg==
X-Google-Smtp-Source: AGHT+IEt6dwsX4DtUvqC7sEljEdquQSqUldMPbdUrFmoYm8as/bmWB3i+egN0ftcqMAL3gZVqjC+cQ==
X-Received: by 2002:a05:6871:a1d1:b0:307:bfe5:481e with SMTP id 586e51a60fabf-3110c4bc7a6mr2132053fac.27.1755612925043;
        Tue, 19 Aug 2025 07:15:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:990c:4d50:9c6c:f367? ([2600:8803:e7e4:1d00:990c:4d50:9c6c:f367])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-310abbb4463sm3480511fac.29.2025.08.19.07.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 07:15:24 -0700 (PDT)
Message-ID: <f7292e8d-ac7f-43af-b77a-7a1ad8403962@baylibre.com>
Date: Tue, 19 Aug 2025 09:15:23 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] iio: mcp9600: Add support for IIR filter
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250818183214.380847-1-bcollins@kernel.org>
 <20250818183214.380847-7-bcollins@kernel.org>
 <f8e95533-c486-442f-a186-5e746dad2f4c@baylibre.com>
 <2025081910-arcane-parakeet-ded8c5@boujee-and-buff>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2025081910-arcane-parakeet-ded8c5@boujee-and-buff>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/25 9:11 AM, Ben Collins wrote:
> On Tue, Aug 19, 2025 at 09:05:39AM -0500, David Lechner wrote:
>> On 8/18/25 1:32 PM, Ben Collins wrote:
>>> From: Ben Collins <bcollins@watter.com>
>>>
>>> MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
>>> to allow get/set of this value.
>>>
>>> Use a filter_type[none, ema] for enabling the IIR filter.
>>>
>>> Signed-off-by: Ben Collins <bcollins@watter.com>
>>> ---
>>> +		if (data->filter_level == 0)
>>> +			return -EINVAL;
>>
>> To implement Jonathan's request from v5, drop this error return.
>> We'll also need a separate bool data->is_filter_enabled field so
>> that we can keep the last set filter_level even when the filter
>> is disabled. (i.e. data->filter_level is never == 0).
>>
>> This way, if you set the filter level, you can enable and disable
>> the filter via filter_type and still have the same filter level.
>>
> 
> Thanks, David. This is exactly what I've implemented, plus the
> filter_enable attribute.
> 
> Adding the ABI doc updates as well.
> 


Don't add the filter_enable attribute. The filter_type attribute
already does the job.



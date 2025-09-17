Return-Path: <linux-kernel+bounces-820853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F20B7F838
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 432617BE73D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5EE3195FE;
	Wed, 17 Sep 2025 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MtnX+JJi"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEBF3161A8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116316; cv=none; b=XnzoEPH3jeQ7CfIwGo3sycFhMXFr+pFhLp4vYTSvgO/bcz1iwcXMBl0Gl/wTtEYcdHEb9FCM5T1u5/J93Hxe0HycDXCQ7LbQi2yDEUdcu5YnbIjbm+BX21a+c60LAr1moxAqvBubV1Pg30jDPMKiuNkzOOA9Uw4AIsv9O3P+xjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116316; c=relaxed/simple;
	bh=sJYHJM64s7yCzGaJIO+3tV93jJsBkJ8/PTbhnoAG2sE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oAMFvJKgSYYee55io1tcp0076L1Vh7o/YCB/wbzd2Pwl3dOFTTp5TEIxkOvz3pxj0IYDlN7xSeM5zxyQBykjpbquG9l3MlErUUv+qXItHBFDlbODkjTHt2vba0cCOo9SGE9deT5j7kLPqzX9OCOdbHT5BpUHlXoS+82UcPXGgOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MtnX+JJi; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-74595f3852cso4696292a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758116314; x=1758721114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=obA4cYWkPNV+su100KjarnANTV2mpGWwTyFWdt6Fifk=;
        b=MtnX+JJiRJijMvAEs9gY98VVkhENHsLZleCpBYKAo5PaFRsR2KtJHLgs2eLvnnkkz7
         wDlZ7rrtqRc1izBxdvtKJ0y1iJuNXoHUysjgTc95jd42+Qeg5MYDWIh7uX1DDtUgdaHf
         hDGRcisrH7REM+jqgisnDhb0U35p0GN/8yBKm6/e96or/ijjnksCOfn9Edsgx6TFSFoV
         4UO8769leghcNDSiLEGIXKbcux5zdcSwrp9+ANFGPBxaKPc8ZHiKq3KnhaCuAYEEKGUi
         UwAcEUgw40UprIohm7vbh9lsjdumP8QnoYGed6xbr+iBlTl5HzjhI8YPooB7k2tHCOUc
         hYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116314; x=1758721114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obA4cYWkPNV+su100KjarnANTV2mpGWwTyFWdt6Fifk=;
        b=I4IwqKFkhPb0FS6gDM/DBDwR/4P45vZyFwRNcD2Hdoq4uBqtsvAaa0vp/c06Q6maOM
         QnWfB3SIISOemqIHY/30Xuqe89D8/a3Tz+Brnnz8OSZtTsG/bF2iUpL0ZqP3Hdth/+eR
         jP2L8TbWfZqjjU1veCeZQh/kpSbETJWnNW4O0t4t9r0b/5KNhRPeOGZwkulCZrgvTXos
         JPo8IQ0ngRm2s/kUUyaxzORobUcCfR1UMtb3CtQ9TvzNYoaz2jcVoGvbVTEm8RvWFbCm
         BJ0My+VZwyfX62GahU7q7Jo6cEc4BB4cbucDsPbSCqswr2SWHJRcjZhBXLXH2ZuKGLOs
         CsXw==
X-Forwarded-Encrypted: i=1; AJvYcCUeLmoIriZ7/s4FT2SZpga37e3Ch9LvHmaTr0hTEFwgvMIIYd4uGiFYJbUdRkwGzysweKPE+8Sb6WJ8Vfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz66yJQKRLsFfmthC6QVbFbqy4ez5y7YT/MLNghguc9JXOl2FoE
	/FzIA7hNcYApk20sUpkDYTO3rR1rQMJXplZoGlARRujUPw49QmVp8PF4ZDMaRb2jfzw=
X-Gm-Gg: ASbGncvV+SBTWnbSzGxXxv9WcXnmBIBLGov8set5VydR/iLb3f3bimUYbWAS5JXRuQm
	qCiJwk9hJGH8pFdtH6VeTq7OUi0Yb0RNVAsrPtaWkvkF1BZzd54uducNzWSOQaJ5t5RZSqAwjIs
	YMT20QIdR/j06ojZhScm9lOwXOvpvTx4EUMQa/s2SSoRFf0mUaJPu+c4h4M+Lt9nUn9s/un40Eh
	KSgk2vfQpUfT5JsIWMf419eeofS3h18XxCMJsuDooXLYCV0WYkWCmtI11F53iLNwkCiC+bgTCeK
	4vTRPWwsYgL+5icLA3vXZZX91fLFJ2I40mW4AqIK39Xvc4wiRbZEylSxf8gMUgn9tf9DtY7o0jG
	wmohVuCfZbw7yecrZZT9QhDDize+tEADtCQj+sWLtEgN+II3G8JKYfAzUynRJ7TfM7WNivtYX
X-Google-Smtp-Source: AGHT+IEj9mD7877pzh3fZR9S0vPJyM0+cMMJjBWnSZ7FP3k/jIVrXWGyKsRrne5bWcBWpiwT7vMSRw==
X-Received: by 2002:a05:6830:d01:b0:757:9c0:e752 with SMTP id 46e09a7af769-76323df6ce5mr1187586a34.36.1758116313824;
        Wed, 17 Sep 2025 06:38:33 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:72c:cb37:521d:46e2? ([2600:8803:e7e4:1d00:72c:cb37:521d:46e2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-75955bd9a38sm2640396a34.16.2025.09.17.06.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:38:31 -0700 (PDT)
Message-ID: <a86f859e-d70e-4444-a867-b54fc2ff01a8@baylibre.com>
Date: Wed, 17 Sep 2025 08:38:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add support for Microchip EMC1812
To: Marius.Cristea@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 jic23@kernel.org, nuno.sa@analog.com, conor+dt@kernel.org, andy@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20250917-iio-emc1812-v1-0-0b1f74cea7ab@microchip.com>
 <e9379a2f-be0e-4f8a-b464-df7382338107@baylibre.com>
 <5b46303db0c9efbd2c2adcba39b59082db82aa71.camel@microchip.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <5b46303db0c9efbd2c2adcba39b59082db82aa71.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/25 8:30 AM, Marius.Cristea@microchip.com wrote:
> Hi David,
> 
>>>
>>> Current version of driver does not support interrupts, events and
>>> data
>>> buffering.
>>>
>>> Differences related to previous patch:
>>
>> This is confusing. I think this version is v1, so there is
>> no previous patch. So why does this say "previous patch"?
>> Is this actually v2?
>>
> 
> No, this is the first patch. I put it there as a patch history and fill
> it up as the patch versioning progress.
> 
Got it. Next time, it would be better to not add the changelog
until v2. We are not used to seeing that in v1. :-)



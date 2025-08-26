Return-Path: <linux-kernel+bounces-786887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44445B36D77
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 753334684B3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ED9220F5D;
	Tue, 26 Aug 2025 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="coB0yhpF"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB44268C40
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756221076; cv=none; b=t4OnsSNvU57BUdOReytcZ5/nRq8HbH/bcZrZIozSjdlu2LdycvXhyMLhx4C28f3ADOt7mpIJe7JYDDMtVVFj+0TIeMsOoxV6QsnRqsPvy/V6j9PIeIDHR9w1EkHFIYXq3SZed0tJAx55y9g0bkGfVOd7s9TZNK6BnkNn3DgpUXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756221076; c=relaxed/simple;
	bh=bmG0z1HOhbjPckrji2ukzQh8cHrzhC38DcEeXeKZCBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bE69DaVjI4DVbGZZk+3bzZfp/ffI0HbCKW004QO7u09tFsv5REZQqxJvLmt2ee2MIe6A9LKQAHlaj71amRDtZSMOAZ/z01S0xYSrkTZTEcR0P8u4qyFo0+Fo7hjB262jvaJVf+YESE6EJuFOstNgstSxkBSLz4YhVKbVMky/6Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=coB0yhpF; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-30ccebab736so4033768fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 08:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756221071; x=1756825871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hLrgdFzlBPbDYpPHO34xWxrjl479AfkvLq/ffp8ncz4=;
        b=coB0yhpFGSMHHG9xDJO5qN7a40tnTqfJP7Io6QU1NmaQP0+fSw/39GJcwwCTkMh/SJ
         ZqCLnJoxGR3TznokxxAxiqJ95Pu7eAG7Ue104avddGF4oPACkHcW0PHy81c12qAWVqEQ
         vVyThwKBb2zzCL9Tw+zcY9/eVdorr2oTjplg7UbHckJXbasIJp2aebq8XDozM3xShXCx
         cdALq5eMpw76k72mSAvcuuUZJ1zMIeImjvBg+n0EWku7H6hFCc7kB1du7NJ7BJzR3r1a
         Evk/5VAvx7r5vMZWG6AkY2A4Q99F8rqYBJO4BSwJo64MuHLBPwjZ9zfYLi5SYJog0vc7
         iyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756221071; x=1756825871;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLrgdFzlBPbDYpPHO34xWxrjl479AfkvLq/ffp8ncz4=;
        b=VNT7CrmLGlF9NGBPXfWdehcfxaE4r6+GBVLKGQmYD8Mmd4dBrbxBIpy7JBTBdDX4fU
         GfgsxmYhxqNNm2nJBCXoK/FyBgsPB8GoHgnB8r7nIewqHLDWKQmtUmjFXOH8uMWm05K0
         lzA8144I/f7a5m65C5u+RE7llK0//NeML8Wo1aslAg3vaiewDF/DYpmfZT0BaG4nHnLR
         18nq3eHBe1PebEXGkFgzeG6S6KdWdKev7wcPs3g72s/IWdTn43mez1rggPW/RKbE0/If
         4bUanoPLJ+E9vRiRqvnmWzS44MB4koXUR5jnRCxR4Fms6MhuyD29FpIZ/ZztPg/RWRSe
         V4pw==
X-Forwarded-Encrypted: i=1; AJvYcCUmliC5gPddjsII8fk2BtPALH8+WvcL4xfPjEWH8zVwpH66PcIbbnAcEeyJAwb09DiyjxuKecfJCumdE4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2nLnhHBRY4dGwT0byxP8QCTRpqSnYiQteckLLYVp9BtDze/VN
	qJEJBWuEzYUqzR3VfOk9rA34I2bCLC7YCGvSdqHNY2jQVyDYoXeSAmFVWEgiilfd2t+7GnV+C3K
	UkNmM
X-Gm-Gg: ASbGncvmt3OqC136qmL/4ThVwobBcS2yd9TXQVpmAcPvdxLMCjHbE52VHfsRc/fPTTw
	Z/esWHGYp0Nqy+daQKxz9uQsc1jbu7DAWuladUdNoYmLtfX8kZ2R0Xk0a4O2o/jnqqHUJ1/adCu
	vw62t6Z6fRYW/M5dqIkq6dF/OV7KJCZ9kZtzYZHm8TGPG4qMqmPhXjc7U58R3X6sSNru3vuTuPy
	k9icV7gtDrldXK4eZ2weJPNPXcSedmwGVBvbpy53BcsRZRdwX2WbvxPIqKS74C7yeJiGJTaJOnv
	avRTgIgbiB6lhmpgFtJR9dcQnN/KCaXB7PmuJSUFyqsuIlZQYS4yOSIhMv//Oy4bJF9DScJeYQj
	GflM2kA56GG8PnQg1Leu5WPx2jGvg+KUQcDkoyw7UpfPUjqZdlFI5sCTlBg1dg6XoeRO2+FAb9p
	0=
X-Google-Smtp-Source: AGHT+IHPLPVoTYuyWUPPqegkgvkKkErW94mqeIgVxNaivppxvK7+bTtUe3engtClxePal6B2UlZO9g==
X-Received: by 2002:a05:6870:32d4:b0:302:5dba:5ae0 with SMTP id 586e51a60fabf-314dcb65a74mr7496856fac.20.1756221070609;
        Tue, 26 Aug 2025 08:11:10 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:aa9f:f4cd:76b1:fecb? ([2600:8803:e7e4:1d00:aa9f:f4cd:76b1:fecb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7450e4738b8sm2368838a34.32.2025.08.26.08.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 08:11:10 -0700 (PDT)
Message-ID: <181dafaa-ec04-43cd-b0a4-208da8cd89e9@baylibre.com>
Date: Tue, 26 Aug 2025 10:11:09 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iio: adc: ad7124: add clock output support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250825-iio-adc-ad7124-proper-clock-support-v2-0-4dcff9db6b35@baylibre.com>
 <20250825-iio-adc-ad7124-proper-clock-support-v2-4-4dcff9db6b35@baylibre.com>
 <CAHp75VeAMNp8gARndVRnh3EwrTb65MNFXL7pCThR+Ghd_+yHDw@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAHp75VeAMNp8gARndVRnh3EwrTb65MNFXL7pCThR+Ghd_+yHDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/26/25 3:13 AM, Andy Shevchenko wrote:
> On Tue, Aug 26, 2025 at 1:55 AM David Lechner <dlechner@baylibre.com> wrote:
>>
>> Add support for the AD7124's internal clock output. If the #clock-cells
>> property is present, turn on the internal clock output during probe.
>>
>> If both the clocks and #clock-names properties are present (not allowed
>> by devicetree bindings), assume that an external clock is being used so
>> that we don't accidentally have two outputs fighting each other.
> 
> ...
> 
>>  static const int ad7124_master_clk_freq_hz[3] = {
>> -       [AD7124_LOW_POWER] = 76800,
>> -       [AD7124_MID_POWER] = 153600,
>> -       [AD7124_FULL_POWER] = 614400,
>> +       [AD7124_LOW_POWER] = AD7124_INT_CLK_HZ / 8,
>> +       [AD7124_MID_POWER] = AD7124_INT_CLK_HZ / 4,
>> +       [AD7124_FULL_POWER] = AD7124_INT_CLK_HZ,
> 
> Perhaps / 1 ?

Seems redundant.

> 
>>  };
> 
> ...
> 
>> +               const char *name __free(kfree) = kasprintf(GFP_KERNEL, "%s-clk",
>> +                       fwnode_get_name(dev_fwnode(dev)));
> 
> What's wrong with the %pfwP specifier?

I didn't know about it.

> 
>> +               if (!name)
>> +                       return -ENOMEM;
> 



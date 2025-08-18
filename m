Return-Path: <linux-kernel+bounces-773948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC46BB2ACC1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709664E57E1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E90257839;
	Mon, 18 Aug 2025 15:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="a4P+wIjo"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FB8253F13
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530791; cv=none; b=eZj5mEAaoL/zzAHfyPmFp/mAMPXs10P4TwYXnWlxFXiZrzwqx6j6Z5QPgsh123MM1mSaprhYTFLjMa3re/GTB4B6a/METWcf4TNJHlIkJ351lkuHghqZgfcK3ajTVAUKBuYreBMfFACf3fbdwKcBd6XfODO/DnXscdu6k7CF8ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530791; c=relaxed/simple;
	bh=9yWCsTnE4xplQu+fdzJDVznRu1TCK8n0PjiryUSeKjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bXIvjN48VjVYcVNfznoYtZt0Wsc/CCscaLj0R2oNyV0vtzUI2q/NAK2yWfNHc2HKMe50nnRLGnr7Cg7YwqW2nWVNq5kF6/1ue3zFYYFw0I8Z5/nzQ2BBlH27HxqywjQ032oXsP22SmhLMs9uOByz1uFvEv99EPretsnw5l8XvE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=a4P+wIjo; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-30cce5be7d0so2078777fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755530789; x=1756135589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c5PKKDWSujsQQD/ZWb/LSNZsX1wV9B1TZv7vRfE49q4=;
        b=a4P+wIjoljpwWqRpVBrnQjjp+/jyg8tMwfcTt4FizxiEqqHvMPo/yG7JetDbKWEJi/
         pNp5zNsX5O72NB8OA4O7GqNBcfV1v3BX/KhDHpbZl582P75x6rurVkrRoB3r6NaPUX52
         KRJXou+OjmkQ/AuatuR+USKoMMuj2NS78CLM4AqTK56WVllsKRw9oVhbSQ2wr6iH5Bll
         j+x/8ln3Fpdiw1USz/6/JqaUV52ux2si38+DjaZmPa2chzQ0vhhcDPxO+cWhV7HcAZyt
         J1R4UCZKU32gXk7FMlk6cJfsFdp+TEs+jGiMuFuREh+tBJRD5m88S+JKQdxOsTS50lJM
         jbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755530789; x=1756135589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c5PKKDWSujsQQD/ZWb/LSNZsX1wV9B1TZv7vRfE49q4=;
        b=IiCDDdkWP31ty6oOD8m6Eg3gzMTr0yVA1tnlcnq69faz75OXsO1kPHGRKlZu3V11HN
         eg9OkC36KZZQoDl6N5nupHvPUqExSeGbD1/Z+3mb4cOuPwiYDVIRiOEe984rKRGskI9X
         360om5KCBd61GrIFr3uYzxVO0dsice+jvnqCOeCyEpjWnowfblZYnvjg13QnWsjQcyvB
         /r09B+b+9raJv1ArM0cpOwOWZG7CVfT7/6Nmgx8h1GT5er2SR++f6N3bylduC0QGvzYC
         pYrophcIMR32oLY07XCCjpv2iscNmZpR2t29zwYAqmuGDSUuq7bYA/TKT4jkeOqVvEkS
         zygg==
X-Forwarded-Encrypted: i=1; AJvYcCUHIVXz3kD6xW7RhaMXt03oOsfUcEWZ92CcnR/4zhlFYaq04xYTldpoYv2riQgJtK6dLVIhXz1bvEzgvz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ReXbuWBUx9dFA/NazGk4mBQpP1R71Kh5gmZil7tpZlRHo6vL
	LeouAqpDJk20egScTvWR2JUpMTxIsG9k8kOG9Fl7lf9J/xlr+9U/3JCKD4Whz7k7xt0=
X-Gm-Gg: ASbGncvAgQZF2rMvEQ0f7qjnlpHuZD481ef0vwDk/1yK/9KmNI4J3sN9UXLm3H4H90v
	USLV61NQSqlL24KAPEzY2IJ5UPENQlmHqXXxSs/ub/dCbqNdZ0ZEDM5Uz1ZVkYvKs23TJc/6V+R
	vEbUxHLlJa9IEKHyAfdNTCP74sAV5qIYueBgh7+0/yeXMfDEkTVrOmIk65g7y2oTQH8nWKNdJA/
	WYre9qXV7QzgXZhVo2pCWNxXLuIp8I5HvwQ28eMTe3sPW8zTpbnvADBOiMj9aXRKOUFyD2rhOR5
	c5Qds5rYBYdMncxm2jTfsNEWWH4GxOI17Q4Hni+BFbNEfV2LBQ0TApB52s4Wj8KDNF2YOTAZ84o
	qpGrCmA3Ubbvl3c0IecjArsl5yLd1TQ3YYkEW/hhi23HHhgHXKlthu9+EDFJwGsjfYpMA5MMbNg
	o=
X-Google-Smtp-Source: AGHT+IFi/cSOB5tF/taIVc9lB6VMcKGQulO1RAaOqvo83CjeGYWHvjFUzL4pihQB+kHoyN+pQ++BZw==
X-Received: by 2002:a05:6871:7283:b0:30b:c9ed:7f91 with SMTP id 586e51a60fabf-310aaf7bd7bmr7722267fac.31.1755530788952;
        Mon, 18 Aug 2025 08:26:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:ee1a:f057:94fa:9a73? ([2600:8803:e7e4:1d00:ee1a:f057:94fa:9a73])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-310ab953af1sm2652680fac.16.2025.08.18.08.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 08:26:28 -0700 (PDT)
Message-ID: <95b6d60e-4709-403f-8127-c50d40c7d8c4@baylibre.com>
Date: Mon, 18 Aug 2025 10:26:27 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] dt-bindings: spi: Add spi-buses property
To: Sean Anderson <sean.anderson@linux.dev>, Mark Brown <broonie@kernel.org>,
 Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
References: <20250616220054.3968946-1-sean.anderson@linux.dev>
 <20250616220054.3968946-2-sean.anderson@linux.dev>
 <ded7ba99-089b-47a7-95b9-ca6666dc3e29@baylibre.com>
 <0a3b69b8-e868-49c8-a0ca-c448ee3cd488@linux.dev>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <0a3b69b8-e868-49c8-a0ca-c448ee3cd488@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 9:56 AM, Sean Anderson wrote:
> On 8/15/25 11:49, David Lechner wrote:
>> On 6/16/25 5:00 PM, Sean Anderson wrote:
>>> From: David Lechner <dlechner@baylibre.com>
>>>
>>> Add a spi-buses property to the spi-peripheral-props binding to allow
>>> specifying the SPI bus or buses that a peripheral is connected to in
>>> cases where the SPI controller has more than one physical SPI bus.
>>>
>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>>> ---
>>>
>>> Changes in v2:
>>> - New
>>>
>>>  .../devicetree/bindings/spi/spi-peripheral-props.yaml  | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>> index 8fc17e16efb2..cfdb55071a08 100644
>>> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>> @@ -89,6 +89,16 @@ properties:
>>>      description:
>>>        Delay, in microseconds, after a write transfer.
>>>  
>>> +  spi-buses:
>>> +    description:
>>> +      Array of bus numbers that describes which SPI buses of the controller are
>>> +      connected to the peripheral. This only applies to peripherals connected
>>> +      to specialized SPI controllers that have multiple SPI buses on a single
>>> +      controller.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +    minItems: 1
>>
>> Finally have some hardware to test this series with using 2 or 4 buses.
>> I found that we also need an absolute max here to make the bindings checker
>> happy. 8 seems sensible since I haven't seen more than that on a peripheral.
>> We can always increase it if we find hardware that requires more buses.
>>
>> 	maxItems: 8
> 
> What is the error you get without this?
> 
> --Sean
> 

I don't have the terminal output anymore, but it was something along the lines
that there were too many items in the array. Like it had an implicit maxItems: 1.

Overriding in a separate file didn't help as the checker seems to consider
each binding file separately. I.e. sometimes I saw the same error twice.


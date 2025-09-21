Return-Path: <linux-kernel+bounces-826410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41491B8E787
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5D117C51F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE2A1514DC;
	Sun, 21 Sep 2025 21:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFj0uXoU"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947E62AD14
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 21:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758491398; cv=none; b=r2fnAppvcsI5nDMoYow4SGZQm99aPtl2iIyqvcGxfiAgIehnGeWN9VDWCvjD7anWIFSYmUte1ap9MC60jEyvnVXaWQsm4m0Yc4ZG34T5JDneB4NX6SppZPNwwgRMM97+GrQZSFSmWnFNcb386G6doubc2xoVE2V03uRMMgsuD6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758491398; c=relaxed/simple;
	bh=7eKHt9T539lDI5ArlWvRasiyebX1wFKURVFmnD+/P7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=holztyKQRylzEdaKk37SyBA1MFCpbsWkSyM8AQfLcxwZRmI3mzsFu+9Zt/mAo2x/6xwwSQrRBqaPMm4xsg0lkPs5Fo6TG08oacHTbGUdACrVfRUbWT2AugxI/wcG++dq3EJCPUTflm2OZYRuY15Ur9SAFonwHBpJyX9sBlR6V2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFj0uXoU; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77f41086c11so63970b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 14:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758491396; x=1759096196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r7CnfhF+eighLL2wsAMK46dbIgkAQtWdpB+QZlY15tQ=;
        b=WFj0uXoU1Ly8ZsUgL7osWFU8SZbzdssuFFcgvvDdGSQk54UTK2f0jPpaE1xT815XFK
         gVCotJj9q2idVAfrwLhnvH2lO74UqljVd17ZJ4PhKvQ7gNbJirZa5WRhWBRX50C8ksOd
         z0nE2XhQ9TmGFVrc/IvH0O316Q6+9s24f6ZP/U0HZYkT9wz7QHhi4ivE5PivbIsv4u6X
         FvnOYEYRCs6iCanmC45v020pohx/low8yXdJRRCNgmhJbVzX1fdqYcakn9MVnqWFVSxf
         f6VbCHnLnqz3SOlo0qkGj15YFTB23/l2QvuzINW0i1GcLeEa7mjpCTqBhm6ivCNQ3S6E
         vGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758491396; x=1759096196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7CnfhF+eighLL2wsAMK46dbIgkAQtWdpB+QZlY15tQ=;
        b=mq0/tq/PyJ75DoE68Bz/c+zWXQTWOd3/1wEH4SURxSdbpSn0sJD8HMr9e6MeaSUAtS
         l4jaIQHcVijWI4aQLjHyojvcBm6wC6SWYFH16HVguKtZrVj4LgNarqluhEEUYYlMuz8u
         5XqvrQuuaEaBKTlbpuuUeaD3DSe6NouszwH0xpxN6Fiab0gyoPu90OU7XqMSeKIfAvZK
         rZSMBNHwZHkMI2syYzMPdMVK5UXrtaQN9Wt8dBPs2tFYneigvNp2fQ1MU9cPk3Eu2LoZ
         jqSuf7kigVUI0Yt4/zOGT5nvPPzOWwdJ44B+LQylj8ozx963nYbSH/qZO4i3gIzFcpqh
         pD/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWT9e6nNVxxYk0yDudf0RDSCOgW0tpx4HioIwZMvjHusQCHFo0j5q1Yxl9wC4Fy8FjgljIdjBKb70uVsYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys/Ls4dYQPDqgdf+h1Uueq5xlVOv5tM5awTFwXsxGbtQY+7Dtw
	csLLHQNFJEfXfrUzvER3hAIjnfsaBL+8rvmASB9vIM/O5vwmp4XhfaZZ
X-Gm-Gg: ASbGncvwOQUIdWuW3KL5qETy3WGQW76+vWSrtZ2GmNuOME/bjRoB3I5NYhJzNcMvaOo
	G2GjXRQj/a5aghq0pGvbIY55+nt7+nuHvAWcEnZZp9TQG0Fx0AQMwVKsClf62RWQhEEL/d1eaaN
	F+U0b5YM27BF+fgrpZNoALxDrxqenwrejaQQxGSABzyR5LboDii19YoiuldzzCMYlZNRsYojBxp
	SolYGQGF8LbeAzkjQcMfnVn5nSA91iUpLBqIWFUF561WCpyu97D2qOM4jo8bdvHiZ+RDdIcgTSS
	SrUbbzva5jjOwLFJcJRQg9yE1Tcj+WFpbMfFw/4Kz5RtIoSPNG6KgmtXcN9bDscX+6GLvlQEpsU
	ZPGDqWAoY/LpSVujqlxDWZImQlsbK0472If+nEHMxN8eYePgxlDVDx+hjumD5EklpK49/abo5ep
	Apaw==
X-Google-Smtp-Source: AGHT+IG3wff7D7xM/5mRWEzYjv8dMgdQPM8uIz6SaqKo3zf8tbMMGoaP9wBn1TY2YikTYlId+/Z0hA==
X-Received: by 2002:a05:6a21:6d9e:b0:263:5c8b:572d with SMTP id adf61e73a8af0-2926f4b4b7dmr13145041637.30.1758491395785;
        Sun, 21 Sep 2025 14:49:55 -0700 (PDT)
Received: from ?IPV6:2804:7f5:b08b:e4a8:7b4f:b63f:f2d1:1393? ([2804:7f5:b08b:e4a8:7b4f:b63f:f2d1:1393])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55186b8498sm7393808a12.12.2025.09.21.14.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 14:49:55 -0700 (PDT)
Message-ID: <18aec78d-7664-4555-a318-fe945dd84780@gmail.com>
Date: Sun, 21 Sep 2025 18:49:46 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/3] dt-bindings: iio: adc: add max14001
To: Conor Dooley <conor@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Kim Seer Paller <kimseer.paller@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>
References: <cover.1757971454.git.marilene.agarcia@gmail.com>
 <30f33a64da0339eccc1474406afb2b1d02a0cd6b.1757971454.git.marilene.agarcia@gmail.com>
 <8e88b601-1329-4cdb-bbd7-feb998c552e8@baylibre.com>
 <20250916-alto-vaseline-f8dafbab03e9@spud>
 <aM8gVOVEujP6Yzxx@debian-BULLSEYE-live-builder-AMD64>
 <20250921-paralegal-styling-17b66d975dcf@spud>
Content-Language: en-US
From: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
In-Reply-To: <20250921-paralegal-styling-17b66d975dcf@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/09/2025 18:22, Conor Dooley wrote:
> On Sat, Sep 20, 2025 at 06:44:52PM -0300, Marcelo Schmitt wrote:
>> ...
>>>
>>>>> +  interrupts:
>>>>> +    minItems: 1
>>>>> +    items:
>>>>> +      - description: |
>>>>> +          Asserts high when ADC readings exceed the upper threshold and low
>>>>> +          when below the lower threshold. Must be connected to the COUT pin.
>>>>> +      - description: |
>>>>> +          Alert output that asserts low during a number of different error
>>>>> +          conditions. The interrupt source must be attached to FAULT pin.
>>>
>>> These descriptions read wrong to me. They __are__ the COUT and FAULT
>>> pins, given what David responded to above, not something that can be
>>> connected to these pins (if they were, they would be represented as
>>> -gpios rather than interrupts most likely). Unless you mean that these
>>> pins can have some other use and are only available on the COUT/FAULT
>>> pins when some register value is set - but even in that case saying
>>> "must be" doesn't fit since the interrupt property could be used to
>>> configure the device accordingly.
>>
>> COUT and FAULT are just two pins on the ADC chip that can be used to generate
>> interrupts. Would a description like the one below sound better?
>>
>>    interrupts:
>>      minItems: 1
>>      items:
>>        - description: |
>>            cout: Comparator output signal that asserts high when ADC readings
>>            exceed the upper threshold and low when readings fall below the lower
>>            threshold.
> 
> I think you should mention the pin name here, like you did below.
> "asserts high on the COUT pin" or w/e.
> 
>>        - description: |
>>            fault: When fault reporting is enabled, the FAULT pin is asserted low
>>            whenever one of the monitored fault conditions occurs.
>>
>> Best regards,
>> Marcelo
Ok, I will change that for v12. Thanks.

Best Regards,
Marilene


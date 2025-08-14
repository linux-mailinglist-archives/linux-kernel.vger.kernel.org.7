Return-Path: <linux-kernel+bounces-769106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C967DB26A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B1FF7A5160
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DF632142C;
	Thu, 14 Aug 2025 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BppAGEUt"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754CF192580
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183079; cv=none; b=YFfG7N9gCgR28dhpfpBogx4ok/BMq4tF0beAab+35pKgqXmffVFfjvum5M5mdvPUeQxTR6K55z+SWuQdv5KUrOlpONasRLtgQJ2hcKmv12gkqh0Qeke+rQhDiDWwJK1v0VfxCFl0afZpFbvsd0mOCTw2dgsGUFYGijH+XJBn7PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183079; c=relaxed/simple;
	bh=fyP/OLr3beYwssW4o3anr5GsJIQEhtOVd8ngVUetdSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jYpLsTsIkuK7wVH3WvgLSz2luHdLeJZjm4grkxlkc4Qt6EwNeuVJhElflEqvmXv2y4GXjGsWc8D/hb6RFfSKm0RU/Aa0ss/6UWdGY4zKxYnia3T5XF1cFLUmsNitx21q9nbo0AwfDav0558BjON/EH5w2qosyvu5xwReC1S+7iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BppAGEUt; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-30ccea6239bso907276fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755183075; x=1755787875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NhLbtz2pbCynkwC1z2ilVubEr1pcqPcdknoxUGu5RA0=;
        b=BppAGEUtHHtmsexkVgMOslgdxIUReQ8vAOm59cKPcjPnjmIxbidYBt0Q+MCtzFIw2g
         OPWMj1DaHSHkHPEMlALAA+QCUKxu+iroLsvOY6hiBJQl0+Oesrvspmcj7lSBRWIAwGeW
         J13NeImus4GIgqybGU+oVoC2AeOKP4T7W/73m8TTsN99Ug9ESQWmWHlVbyVfDQsQ9h68
         pzizqRKMLmdX4SNIWW0guvzFHnsClC2irrsD9L/yDRMM8MY7p+uNj6OJtQn+IInf5h5j
         7H2qw/K8S6NNhqdDXpzqN5TG9JgbyUmWoKSQ7AVBKZtr1c48QotX5nXyK9EWNv0lvHZV
         M+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755183075; x=1755787875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NhLbtz2pbCynkwC1z2ilVubEr1pcqPcdknoxUGu5RA0=;
        b=YRcYI3GydallLdBMhZ6hntX562AxQIGu0IqlETrGwnUBA3eE+hDtbrEOpEhJnaoXJh
         88JUNxxgqVoLfcUhyiZUiC+rHJT9iA8WlzKZrs+t27VzRGe1aYiSCDNoGLu7rpX/azci
         no8s4vyPdJ+zMo34rTYi2qE3sbqfqUKfs2/h7vnebTH6kVVF3fteD2IwHdYb8cp59FOS
         VLg1101gTumQvVENFhN3KwLoFJy2GYmXoRiFDvwMKVsb6eoRyfLdtoAGOS8tT9J7jfJu
         dSmB3b1hEtJ/WIUXf0OcJl8qv9Tsxwptd8IUzb9Xz9ugIMcnogTmiIjgH+01pwXiI0Oe
         OIGw==
X-Forwarded-Encrypted: i=1; AJvYcCVGnDaD8qUnRZOFIcCgtG4kz2S1dZvDIZpdVBD906cP84LN9lHz6CrhEmQh8Bci/E7M6+SBBz3JedL+I6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2bU7abwb8VSTWNvL4pk6A+a2dKdOA6zqsG6/MALJQC/7qHMPm
	mID/tHzQnWUMtaNIy5lnntujcMPxS39OYrdFyHkvPVjfXqJjxKCExGGBSnw5WVHs47E=
X-Gm-Gg: ASbGncu5745QPZEptwC4rnryuubp3AE/+/+ta6tP2hMRc+Fu6FFm+0OwzrRny+WrvrZ
	e0mteY0vYt3qO42RBOWqtGXWGxheCsLfhVScZEqjrxVyKTaTy6c0XdP02vfOHkQTR+G23+Sasdq
	Dfc25pt3w/Ta5AX4tj/jKZseFnkQOLe1vBfA+C4w5eIGD9mq60tRk0AjoBX/LtTQv2+rpWtJ9qy
	P7/Wq3CF61tQ7YpnYQxIgbKwjyFsscwOfO1lsa/HHAmfmsRHqo7S5J1YsvM5LVqxQMT4vbpcs3o
	GfYqwgbh0MpJqXmrA1x8lfc7ZKRBVsVYd+tisrqbLNDefVhxo6WPr9XwOLcK5Y9TtxeryH4IDRK
	BlvZsDCKRyrlROjqjKSVE8WFLVnR0UxhF+MpZwXiud/0OmIEjAoWDF3cmp8EUpKKIyPmzQt3oUe
	s=
X-Google-Smtp-Source: AGHT+IGBSpWFh7v66sa0tHjx26XHgGotdF9DhOCF3YJvgTAZk5dQT2EANWxR0b3KAVLYLKWGk2J75w==
X-Received: by 2002:a05:6871:6a5:b0:30b:582d:8eed with SMTP id 586e51a60fabf-30cd1399dbamr2002074fac.39.1755183075184;
        Thu, 14 Aug 2025 07:51:15 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:2d9b:959c:3c59:5831? ([2600:8803:e7e4:1d00:2d9b:959c:3c59:5831])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7436f879fabsm1436841a34.13.2025.08.14.07.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 07:51:14 -0700 (PDT)
Message-ID: <b1cc499b-403e-4dcf-9e6a-10d4d43a8b30@baylibre.com>
Date: Thu, 14 Aug 2025 09:51:13 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: Add BD7910[0,1,2,3]
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1755159847.git.mazziesaccount@gmail.com>
 <8ef78e3cffcfdf99153a3fcf57860771890f1632.1755159847.git.mazziesaccount@gmail.com>
 <175ce750-7f5d-477c-8d18-dd418ba749be@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <175ce750-7f5d-477c-8d18-dd418ba749be@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/14/25 4:57 AM, Matti Vaittinen wrote:
> On 14/08/2025 11:35, Matti Vaittinen wrote:
>> The ROHM BD79100, BD79101, BD79102, BD79103 are very similar ADCs as the
>> ROHM BD79104. The BD79100 has only 1 channel. BD79101 has 2 channels and
>> the BD79102 has 4 channels. Both BD79103 and BD79104 have 4 channels,

Is it just a difference in max sample rate? or pinout?

>> and, based on the data sheets, they seem identical from the software
>> point-of-view.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>>   .../devicetree/bindings/iio/adc/rohm,bd79104.yaml     | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml b/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
>> index f0a1347ba4db..6a6e6ab4aca3 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
>> @@ -14,7 +14,16 @@ description: |
>>     properties:
>>     compatible:
>> -    const: rohm,bd79104
>> +    oneOf:
>> +      - items:

You can drop the items: here since there is only one item.

>> +          - enum:
>> +              - rohm,bd79100
>> +              - rohm,bd79101
>> +              - rohm,bd79102
>> +              - rohm,bd79104
>> +      - items:
>> +          - const: rohm,bd79104
>> +          - const: rohm,bd79103
> 
> Oops. I believe the order of the compatibles is wrong for the fallback.

Indeed.

> 
>>       reg:
>>       maxItems: 1
> 
> Yours,
>     -- Matti



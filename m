Return-Path: <linux-kernel+bounces-772596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D151B294A9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 20:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3443E4E064F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 18:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC31B3009EF;
	Sun, 17 Aug 2025 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="D+kcBZcF"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0548B2FE068
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755453595; cv=none; b=Bg+OVeNmLQIgkrphEvbIkRwKfZdlTm6NiErIqgkaQosQwHtYYuW1W26Nn62OkSCEliIddQ+FpKeocBMK7/w8gEpTpn0KVGVrqM9eX1BFu4kVleLStTXwIo0BUneuhV5zttb0zIKYJYdQbuMXPPk6YZbb6nG/PxRoNEfL6e55YDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755453595; c=relaxed/simple;
	bh=XKBhrK5uK48jVOSvPBUvlhI9aPEXRfRfj89rA/BcTZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TFmSOH+7//ZAvh3ODU0e3mm9gyPe8E/xNVoXXfYXLxzm5UAvMOnFEZwsz1njiTOXx00k+5jKnF9a/trPXrON/bHsi/6mqFUGA5ITgjIeIPnxuJo1ML+a0i6xxGlVYeuffBVscoDcyvn8BSpLBup07iWfX7max2KishLGSWruVyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=D+kcBZcF; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-61bd4e14054so1633280eaf.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 10:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755453592; x=1756058392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OEazibTv/dumJADggU0/7DTkSNU0F7MYPx46/hjPpqM=;
        b=D+kcBZcFUEzNIge3ROLuHTX6o1X/QDkDpS4TZsXJySBvnRr6Tn0tWQtlaanW8mtTZU
         bW7ftLpZ4RsgAkWYjjsqU1cfiuKZgISOvNrZstdA+qy8RgIMR1Ff0oCAzh3WanAKC9+n
         AjfXHI4XpgOZ7rK2QQh3Pdb9OACIPrlSBh9ELQVcyAPrxkL0OviASGOtizWBGfrbRZxX
         QV9bY3/g+6bGiRCdtHKOtBrjFC6rso3YHvWTKqeF2k9iBl8NsKuhxfGkN7vXYSPJ+6QN
         uKorwlyvwrx7rjO1I3n7gjFTv2d7LDjKC1pZMjMAeLkmGWEyyOhOVLBiiIvSv+TLhK32
         r6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755453592; x=1756058392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OEazibTv/dumJADggU0/7DTkSNU0F7MYPx46/hjPpqM=;
        b=LofFZZe25i0ioRI30+AdzcsDQLoC2RcnfKDd7Hjwat2KgNZHX8qDWdtnhPBsg+cimJ
         GbglrO9B5OtRFKR1RB6tpLHUikWR5Du7xqXio57OS1GzNZ0OCFDtmEwsIjxczqqWlGT0
         mW6w0jBBb8RQuHenEl1NaKRoOz18WsfjLqVi6V/hlAaoPU9qGvPnc9OB4o+DDu0nSCaP
         dsa5DLLfGPWcDTo6r73oJIChD1nY/QmBR22c4EsKnORLPEjouGOoQMVUBUqt8LWrUK9b
         P8qvBQlWey2Bbj3PaJ9dZ55jWFdZ/nhc2/rsosCByDP43QiQcZkQO4ZtXz/oOMExeWJy
         tw6g==
X-Forwarded-Encrypted: i=1; AJvYcCVxYwJuyCBCU81Igc2eJtJYIzi9YdSiSnsDDIBWcio7u2BUwdklm1fhxTKzR/vOiRNkDwtwVIfEcKuh9Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYGG0HtpYhn3gFbfZLPoYkJ6tOQREQqat086bwN90tCeHiZYCW
	KoF+ba4ZezYs2z/LqX6P3DvDP63ba0MfHa9UcAahNOFE638Kjy1ejoJ7iqk3smTTF2M=
X-Gm-Gg: ASbGncvazK3HESZy3BlA28ZRAbjDrmxSOQkvbGZe/9FuBOG9sRclKaPsUTrSLaUEylX
	9u+W8P7zKuQAlpKMrn8A1MXEJGu4SqB4dKBJ6ikYVTvLuyz9BkZYp7ItDULQcL1wECVVb2SQjzr
	X1hz26+KIkjQM1JEG07lm+DOI2AaikOWhqEt7xfb8qT1RYiQoQTf1Lpo0ZyFf+/kMapr3yVfenk
	FFyFHF4sLi7vcjVYCsXarHQWuihTDXv9whKd/qi4OT+6hYytBTCRynSXtyYmBz013zoTpF+gfQ1
	w6svgpblQ303LSIv1ooZpi5FpB8klHYrGxdD6NvdaKq/Qg7CWwnZmsOxbR1lYc+3TdSzk/S/AG5
	SuH+ib50sWhH/fZSVPZGEdK5UjxGLFNXmhIkL8xBwHsfLjM5FaZS2L5BwBAv3WLQP0O9lrdIb2g
	U=
X-Google-Smtp-Source: AGHT+IEiaa6l8aeyyaDiEdkuyBIkbmKAFQO8iY3lL25MRcObEtZ1acfzxgqkOXo/nQtnP2bdKaEaIg==
X-Received: by 2002:a05:6820:220a:b0:61b:fe06:3335 with SMTP id 006d021491bc7-61bfe063825mr3325655eaf.4.1755453591988;
        Sun, 17 Aug 2025 10:59:51 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:7648:43db:38fd:de4a? ([2600:8803:e7e4:1d00:7648:43db:38fd:de4a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61bec1490c5sm662070eaf.26.2025.08.17.10.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 10:59:51 -0700 (PDT)
Message-ID: <65ca6431-56e1-4798-9ecc-6e6adf664f96@baylibre.com>
Date: Sun, 17 Aug 2025 12:59:48 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: iio: mcp9600: Add compatible for
 microchip,mcp9601
To: Jonathan Cameron <jic23@kernel.org>, Ben Collins <bcollins@watter.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Hepp <andrew.hepp@ahepp.dev>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250815164627.22002-1-bcollins@watter.com>
 <20250815164627.22002-2-bcollins@watter.com>
 <20250816105825.35e69652@jic23-huawei>
 <66063382-78c6-4d93-be25-46e972e390f4@baylibre.com>
 <2025081711-coral-aardwark-9f061b@boujee-and-buff>
 <8e228d2d-d22f-4092-8c6d-94ce989b4a84@baylibre.com>
 <2025081713-wooden-clam-aee35a@boujee-and-buff>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2025081713-wooden-clam-aee35a@boujee-and-buff>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/17/25 12:34 PM, Ben Collins wrote:
> On Sun, Aug 17, 2025 at 11:51:22AM -0500, David Lechner wrote:
>> On 8/17/25 11:37 AM, Ben Collins wrote:
>>> On Sat, Aug 16, 2025 at 01:55:31PM -0500, David Lechner wrote:
>>>> On 8/16/25 4:58 AM, Jonathan Cameron wrote:
>>>>> On Fri, 15 Aug 2025 16:46:03 +0000
>>>>> Ben Collins <bcollins@watter.com> wrote:
>>>>>
>>>>>> The mcp9600 driver supports the mcp9601 chip, but complains about not
>>>>>> recognizing the device id on probe. A separate patch...
>>>>>>
>>>>>> 	iio: mcp9600: Recognize chip id for mcp9601
>>>>>>
>>>>>> ...addresses this. This patch updates the dt-bindings for this chip to
>>>>>> reflect the change to allow explicitly setting microchip,mcp9601 as
>>>>>> the expected chip type.
>>>>>>
>>>>>> The mcp9601 also supports features not found on the mcp9600, so this
>>>>>> will also allow the driver to differentiate the support of these
>>>>>> features.
>>>>>
>>>>> If it's additional features only then you can still use a fallback
>>>>> compatible.  Intent being that a new DT vs old kernel still 'works'.
>>>>>
>>>>> Then for the driver on new kernels we match on the new compatible and
>>>>> support those new features.  Old kernel users get to keep the ID
>>>>> mismatch warning - they can upgrade if they want that to go away ;)
>>>>>
>>>>> Krzysztof raised the same point on v2 but I'm not seeing it addressed
>>>>> in that discussion.
>>>>
>>>> One could make the argument that these are not entirely fallback
>>>> compatible since bit 4 of the STATUS register has a different
>>>> meaning depending on if the chip is MCP9601/L01/RL01 or not.
>>>
>>> There are some nuances to this register between the two, but it can be
>>> used generically as "not in range" for both.
>>>
>>> My understanding from the docs is if VSENSE is connected on mcp9601,
>>> then it is explicitly open-circuit detection vs. short-circuit, which
>>> is bit 5.
>>>
>>>> Interestingly, the existing bindings include interrupts for
>>>> open circuit and short circuit alert pins. But these pins
>>>> also only exist on MCP9601/L01/RL01. If we decide these aren't
>>>> fallback compatible, then those properties should have the
>>>> proper constraints added as well.
>>>
>>> In my v4 patch, I'm going to remove the short/open circuit interrupts
>>> since they are not implemented, yet.
>>
>> Don't remove them from the devicetree bindings. Even if the Linux driver
>> doesn't use it, the bindings should be as complete as possible.
>>
>> https://docs.kernel.org/devicetree/bindings/writing-bindings.html
>>
> 
> I couldn't find anything that would easily describe this type of layout:
> 
> properties:
> ...
>   interrupts:
>     minItems: 1
>     maxItems: 4
>   interrupt-names:
>     minItems: 1
>     items:
>       - const: alert1
>       - const: alert2
>       - const: alert3
>       - const: alert4
> 
> allOf:
>   - if:
>       properties:
>         compatible:
>           contains:
>             const: microchip,mcp9601
>     then:
>       # Override maxItems
>       interrupts:
>         maxItems: 6
>       # XXX Add items to existing list???
>       interrupt-names:
>         items:
>           - const: open-circuit
>           - const: short-circuit
> 

We usually do this the other way around. The base binding lists
all of the possibilities then an -if: constraint limits them
if needed.


So don't change what is there already and then add:


allOf:
  - if:
      properties:
        compatible:
          not:
            contains:
              const: microchip,mcp9601
    then:
      properties:
        interrupts:
          maxItems: 4
        interrupt-names:
          maxItems: 4
          enum:
            - alert1
            - alert2
            - alert3
            - alert4



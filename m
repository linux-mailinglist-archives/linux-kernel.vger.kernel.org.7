Return-Path: <linux-kernel+bounces-756737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2476B1B89B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148EC17C5F6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A244B272E42;
	Tue,  5 Aug 2025 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MF+YFD4f"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7131DE3AC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754411733; cv=none; b=CU6ofSZqN5mAzSaN5HxTajElRR/TlFWkmwdiR3I6tMMIpWq0HczfEZu7uIVsfp0t+TkY5PsrjcYvezwPpF6uoGCP7GWPbFDoBcsD0S9h0DKt5R9h07T6yfsmXISDLafIOKXUQHY9c5Qbtj8gBRRuQO/5eG2IkfJCR7syrhGZZGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754411733; c=relaxed/simple;
	bh=PIBhZdO238ZvHLBX3rQTGOO8coLsWI3R3RgIsssqLNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bC6sJwRoIQqRU9Kq1RTTELYcaKHqf5IcJS9uAfhTcKFyNWn5cVS1ZuaFTxEMqyy+bPsSsye6ldjoP38Ex8KgvcixY5Km9BXWM7Ql1neSqFx90g/xXEd5l/hctzPetCnEOPN/6C9SpLfEyObdyX59UKCvWwTlwemFwx5On1ELWm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MF+YFD4f; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-433f1f9718dso2495206b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 09:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754411730; x=1755016530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jtUgL/kOLZJGMiSwsdGyte+QD2BT5vIBoeVeTYduHPY=;
        b=MF+YFD4fpZTEXaurr304BsEf457BRWfUm4sgUvQTvXQ8MXePGChr2AkVN3sRpb4eG2
         4GZE8r3zRZE6GRFUjRRlGqxjeu6pM57niWZilhLJpfP5rRFmdcuPQSD00fsdOVxkJNuG
         InxHwDtVjyZMBy1Bk5S7TZIpAQYkLa8hMJx+CXlbXc1us1fg2tH76UcoSFlFFBOW9F9L
         gVUEv+rjYCmBzcjOTORrUxWMlk3nFX91/bEW7uUUJD0WPVQUApHwqVjcHyWCnISKsEkG
         XxSKX+on9GRUrDNZ8FyCBnAxjMHFfd/VjDUsm/84K4tn7pvgIU5o17W2uG2bf8SbAx39
         xkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754411730; x=1755016530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jtUgL/kOLZJGMiSwsdGyte+QD2BT5vIBoeVeTYduHPY=;
        b=rheyl34ec8LWtc1v4LRfPBkatJBFjOWHifRwRbJbPzMGSaEyo3WEinXp6+PFhWLUTm
         SdZO9xW7qtaIqqPBVj7AGyOWgaOXRLd8JpGM2fK7LQ6AlB+y6IPyniug0zRdNRYHJoXh
         IoKp3GGPSi2wjAeVOSFT9RyVBREerMqSbo1IMMu8v/kJNAUenagg3seUZxSooLsrOMK4
         s5poQgBUse9JlF42RPAwco7Z6moAA2twzC0+Vo9gvkGj4fbLKfMv24C6hfSKXe6h71H+
         vVyY3quGnBu4kKf6Mfffx5srAGZSnHYylWtr6D2aMh2fQLC4B3giNyXwfwx40DLD4kSZ
         bHCw==
X-Forwarded-Encrypted: i=1; AJvYcCV4J2UKdrKbqiClbBpctNKjwYOyHZU+z2BjHiaXe/GDmb0n0+bi2WNAC05g42o3LEN3ugiV+1mv7A+23iU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya6H9hUrM8KDyIdbEh2tf+6wZL5Zx1KVfq+EOHp1IH1DiFT+6k
	5FrBl5JIxoy1Z57KfgPMw65Z/IJmbIkvnEtcx4GGDvXoCbkY+uyq14eq02zn/RvUun8=
X-Gm-Gg: ASbGnctmOQmP15iajixhmKIqkFx4aEZ2wrdtsbhO1AQDnDQ/zlt5t5JxHFiR0sOKQ4d
	yHBycJ6cMKsx+KOHmySo4eqX+IyIWSFNbnijLg3lu1FEyG2frKVUkIQPZ3F8FJNudeQwAreQD7k
	Ma7HRs6QTHcwL6sOe0uQwHKnTjrfKaRZLszPS+2Y+UC7wElo8YCAFpK1YpresV/ZdmcL+QEaDi6
	/Y46clsWCzhsSgQk++O4e6YrMrOxjfm5tMH+509+iJAZwhATYTLxyIH6TXrQAWeQbGWfxX+RhWw
	7NEMkB7x+dxqPxi7gWb+OgMU8fhXRbUbAkaGoQJNgO8hklp8dOe/oe/DEpUopxjukYurNCCn7rM
	39TgTinEVn2Hv29laUDOD6BXve4vzq1I2I+n0bjJ/x8dvvBWfgaG48LPHdsYn5Fc+lchAimq0kl
	/n7GPI+yPkew==
X-Google-Smtp-Source: AGHT+IEPj9WGncyEEwV8zCSGGOL8c8u23+Kwz+ZdJ9c7mTbLm+37ER2spgJtBiQCyb7d39tvDl8XQA==
X-Received: by 2002:a05:6808:1b0e:b0:41c:8cba:1ac9 with SMTP id 5614622812f47-433f03438d8mr8283663b6e.28.1754411730347;
        Tue, 05 Aug 2025 09:35:30 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:cc63:6a65:89f9:fe4a? ([2600:8803:e7e4:1d00:cc63:6a65:89f9:fe4a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61b4e4ac995sm244569eaf.18.2025.08.05.09.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 09:35:29 -0700 (PDT)
Message-ID: <a36d35b8-0f11-4a57-a20c-b00e16f293f9@baylibre.com>
Date: Tue, 5 Aug 2025 11:35:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: magnetometer: document Infineon
 TLV493D 3D Magnetic sensor
To: Dixit Parmar <dixitparmar19@gmail.com>,
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, linux-iio@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250802-tlv493d-sensor-v6_16-rc5-v2-0-e867df86ad93@gmail.com>
 <20250802-tlv493d-sensor-v6_16-rc5-v2-2-e867df86ad93@gmail.com>
 <175423802305.483875.12095436762674457962.robh@kernel.org>
 <aJAd0k-PGbQJqD_R@dixit>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aJAd0k-PGbQJqD_R@dixit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/3/25 9:41 PM, Dixit Parmar wrote:
> On Sun, Aug 03, 2025 at 11:20:40AM -0500, Rob Herring (Arm) wrote:
>>
>> On Sat, 02 Aug 2025 12:14:28 +0530, Dixit Parmar wrote:
>>> Document the bindings for Infineon TLV493D Low-Power 3D Magnetic Sensor
>>> controlled by I2C interface. Main applications includes joysticks, control
>>> elements (white goods, multifunction knops), or electric meters (anti-
>>> tampering).
>>> Drop duplicated entry for infineon,tlv493d from trivial-devices.yaml as
>>> its documented in infineon,tlv493d.yaml now.
>>>
>>> Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
>>> Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
>>> ---
>>>  .../iio/magnetometer/infineon,tlv493d.yaml         | 45 ++++++++++++++++++++++
>>>  .../devicetree/bindings/trivial-devices.yaml       |  2 -
>>>  2 files changed, 45 insertions(+), 2 deletions(-)
>>>
>>
>> My bot found errors running 'make dt_binding_check' on your patch:
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d.yaml: vdd: missing type definition
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d.yaml: 'example' is not one of ['$id', '$schema', 'title', 'description', 'examples', 'required', 'allOf', 'anyOf', 'oneOf', 'definitions', '$defs', 'additionalProperties', 'dependencies', 'dependentRequired', 'dependentSchemas', 'patternProperties', 'properties', 'not', 'if', 'then', 'else', 'unevaluatedProperties', 'deprecated', 'maintainers', 'select', '$ref']
>> 	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
>>
> Ack.
>> doc reference errors (make refcheckdocs):
>>
>> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250802-tlv493d-sensor-v6_16-rc5-v2-2-e867df86ad93@gmail.com
>>
>> The base for the series is generally the latest rc1. A different dependency
>> should be noted in *this* patch.
>>
> I did not get this fully, is this concerning?

Nothing to worry about in this case. This is a new binding with nothing
unusual, so there are no dependencies.

>> If you already ran 'make dt_binding_check' and didn't see the above
>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>> date:
>>
>> pip3 install dtschema --upgrade
>>
>> Please check and re-submit after running the above command yourself. Note
>> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
>> your schema. However, it must be unset to test all examples with your schema.
>>
> Thanks,
> Dixit


